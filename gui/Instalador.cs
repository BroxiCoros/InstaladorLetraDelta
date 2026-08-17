using System.Diagnostics;
using System.Net.Http;

namespace InstaladorLetraDelta;

/// <summary>
/// Estado que el instalador va comunicando a la interfaz.
/// </summary>
/// <param name="Texto">Qué se está haciendo ahora mismo.</param>
/// <param name="Porcentaje">0 a 100, o null si el paso no admite medición.</param>
public sealed record Avance(string Texto, double? Porcentaje);

/// <summary>
/// Lo que hay que hacer para dejar el juego traducido: descargar los packs,
/// descomprimirlos sobre la carpeta del juego y aplicar el parche.
///
/// Es el equivalente de la sección [Code] de setup.iss en el instalador de
/// Windows, y usa exactamente las mismas URL y el mismo orden de pasos.
/// </summary>
public sealed class Instalador
{
    // Pack de español americano (LetraDelta).
    private const string UrlLang = "https://github.com/BroxiCoros/LetraDelta/releases/download/latest/lang.7z";
    // Scripts del mod. Los Borders.csx y los PNG de NXRUNE viajan dentro, así
    // que la opción de bordes no necesita ninguna descarga adicional.
    private const string UrlScripts = "https://github.com/BroxiCoros/DeltranslatePatch/releases/download/latest/scripts.7z";

    // El avance se reparte entre todas las fases para que la barra signifique
    // lo mismo de principio a fin, en vez de reiniciarse en cada descarga. Los
    // tramos son aproximados y están repartidos según lo que tarda cada fase:
    // las descargas ocupan hasta el 45 %, las descompresiones son casi
    // instantáneas, y el parcheo se lleva toda la segunda mitad.
    private const double InicioParcheo = 55;

    // El parcheador procesa el menú y los cinco capítulos: seis hitos, que es
    // lo que permite convertir la fase más larga en un avance real.
    private const int ArchivosAParchear = 6;

    private readonly HttpClient _http = new();
    private readonly IProgress<Avance> _avance;
    private readonly Func<string, Task<bool>> _preguntarPackLocal;

    /// <param name="avance">Por dónde va la instalación.</param>
    /// <param name="preguntarPackLocal">
    /// Recibe el nombre de un pack encontrado junto al instalador y decide si
    /// se usa. La respuesta la da el usuario, así que la interfaz es quien lo
    /// implementa; aquí solo se pregunta.
    /// </param>
    public Instalador(IProgress<Avance> avance, Func<string, Task<bool>> preguntarPackLocal)
    {
        _avance = avance;
        _preguntarPackLocal = preguntarPackLocal;
        _http.Timeout = TimeSpan.FromMinutes(30);
    }

    /// <summary>Salida completa del parcheador, para mostrarla si algo falla.</summary>
    public string SalidaParcheador { get; private set; } = "";

    /// <summary>
    /// Ejecuta la instalación completa. Devuelve null si todo fue bien, o el
    /// mensaje de error si algo falló.
    /// </summary>
    public async Task<string> InstalarAsync(string carpetaJuego, bool conBordes, CancellationToken ct)
    {
        string temporal = Path.Combine(Path.GetTempPath(), "letradelta-" + Path.GetRandomFileName());
        Directory.CreateDirectory(temporal);

        try
        {
            string lang = await ObtenerPackAsync("lang.7z", UrlLang, temporal,
                                                 "Descargando archivos de idioma (español)...",
                                                 0, 32, ct);
            string scripts = await ObtenerPackAsync("scripts.7z", UrlScripts, temporal,
                                                    "Descargando scripts...", 32, 45, ct);

            // El pack trae su propia subcarpeta lang/es. El inglés original no
            // se descarga: el propio mod lo conserva.
            Reportar("Descomprimiendo archivos de idioma (español)...", 45);
            await DescomprimirAsync(lang, carpetaJuego, ct);

            Reportar("Descomprimiendo scripts...", 52);
            string carpetaScripts = Path.Combine(temporal, "scripts");
            await DescomprimirAsync(scripts, carpetaScripts, ct);

            Reportar("Aplicando el parche...", InicioParcheo);
            return await ParchearAsync(carpetaJuego, carpetaScripts, conBordes, temporal, ct);
        }
        catch (OperationCanceledException)
        {
            return "La instalación se canceló.";
        }
        catch (HttpRequestException ex)
        {
            return $"Se produjo un error al descargar los archivos: {ex.Message}";
        }
        catch (Exception ex)
        {
            return $"Se produjo un error durante la instalación: {ex.Message}";
        }
        finally
        {
            try { Directory.Delete(temporal, recursive: true); } catch (IOException) { }
        }
    }

    /// <summary>Comunica un avance global concreto.</summary>
    private void Reportar(string texto, double porcentaje) =>
        _avance.Report(new Avance(texto, porcentaje));

    /// <summary>
    /// Devuelve la ruta del pack: si el usuario dejó una copia junto al
    /// instalador ofrece usarla, y si no lo descarga. Es la instalación sin
    /// conexión que ya existe en la versión de Windows.
    ///
    /// La pregunta no es un trámite: los packs se llaman siempre igual, así que
    /// uno olvidado de hace meses en la carpeta de Descargas instalaría una
    /// traducción vieja sin que nadie se enterara. Windows pregunta desde
    /// siempre (OfflineQuestion1 en setup.iss) y aquí se hacía en silencio.
    /// </summary>
    private async Task<string> ObtenerPackAsync(string nombre, string url, string temporal,
                                                string texto, double desde, double hasta,
                                                CancellationToken ct)
    {
        string local = Path.Combine(CarpetaDelInstalador(), nombre);
        if (File.Exists(local) && await _preguntarPackLocal(nombre))
        {
            Reportar($"Usando el archivo local {nombre}...", hasta);
            return local;
        }

        string destino = Path.Combine(temporal, nombre);
        await DescargarAsync(url, destino, texto, desde, hasta, ct);
        return destino;
    }

    /// <summary>
    /// Descarga un archivo informando del avance. Si el servidor no declara el
    /// tamaño, el avance queda indeterminado en vez de fingir un porcentaje.
    /// </summary>
    private async Task DescargarAsync(string url, string destino, string texto,
                                      double desde, double hasta, CancellationToken ct)
    {
        Reportar(texto, desde);

        using var respuesta = await _http.GetAsync(url, HttpCompletionOption.ResponseHeadersRead, ct);
        respuesta.EnsureSuccessStatusCode();

        long? total = respuesta.Content.Headers.ContentLength;

        await using var origen = await respuesta.Content.ReadAsStreamAsync(ct);
        await using var salida = File.Create(destino);

        var bufer = new byte[81920];
        long copiado = 0;
        int leidos;
        while ((leidos = await origen.ReadAsync(bufer, ct)) > 0)
        {
            await salida.WriteAsync(bufer.AsMemory(0, leidos), ct);
            copiado += leidos;

            // Con el tamaño declarado se puede mostrar cuánto llevamos; si el
            // servidor no lo manda, al menos se ven los megas descargados.
            if (total is > 0)
            {
                double fraccion = (double)copiado / total.Value;
                Reportar($"{texto} {Megas(copiado)} de {Megas(total.Value)}",
                         desde + (hasta - desde) * fraccion);
            }
            else
            {
                _avance.Report(new Avance($"{texto} {Megas(copiado)}", null));
            }
        }
    }

    private static string Megas(long bytes) => $"{bytes / 1024.0 / 1024.0:F1} MB";

    /// <summary>
    /// Descomprime un .7z con el 7-Zip que viaja dentro del instalador: `7zzs`
    /// (el binario estático de Linux, dentro del AppImage) o `7zz` (el binario
    /// universal de macOS, dentro del paquete de la aplicación).
    /// </summary>
    private static async Task DescomprimirAsync(string archivo, string destino, CancellationToken ct)
    {
        Directory.CreateDirectory(destino);

        string sieteZip = Path.Combine(AppContext.BaseDirectory,
                                       OperatingSystem.IsMacOS() ? "7zz" : "7zzs");
        var (codigo, salida) = await EjecutarAsync(sieteZip, ["x", archivo, "-o" + destino, "-y"], ct);

        if (codigo != 0)
            throw new IOException($"No se pudo descomprimir \"{Path.GetFileName(archivo)}\".\n\n{salida}");
    }

    /// <summary>
    /// Lanza DeltaPatcherCLI como proceso aparte, igual que hace el instalador
    /// de Windows. Si falla, intenta sacar la primera línea del
    /// deltapatcher-log.txt, que es la que explica de verdad qué pasó.
    /// </summary>
    private async Task<string> ParchearAsync(string carpetaJuego, string carpetaScripts,
                                             bool conBordes, string carpetaLog, CancellationToken ct)
    {
        string parcheador = Path.Combine(AppContext.BaseDirectory, "DeltaPatcherCLI");

        List<string> argumentos = ["--game", carpetaJuego, "--scripts", carpetaScripts, "--logpath", carpetaLog];
        if (conBordes)
            argumentos.Add("--borders");

        // El parcheador anuncia cada archivo con una línea "===== PARCHEANDO:
        // CHAPTER1 =====". Contarlas convierte la fase más larga de la
        // instalación en un avance real, en vez de una barra indeterminada
        // parada un minuto haciendo creer que se ha colgado.
        int hechos = 0;
        var (codigo, salida) = await EjecutarAsync(parcheador, argumentos, ct, linea =>
        {
            if (!linea.StartsWith("=====", StringComparison.Ordinal))
                return;

            hechos++;
            // La línea anuncia que ese archivo EMPIEZA, así que el avance
            // corresponde a los anteriores. Contarlo como terminado dejaría la
            // barra al 100 % mientras aún queda el último capítulo, que es el
            // más lento de todos.
            double fraccion = Math.Min(1.0, (double)(hechos - 1) / ArchivosAParchear);
            Reportar($"Aplicando el parche ({Math.Min(hechos, ArchivosAParchear)} de {ArchivosAParchear})...",
                     InicioParcheo + (100 - InicioParcheo) * fraccion);
        });
        SalidaParcheador = salida;

        if (codigo == 0)
            return null;

        string log = Path.Combine(carpetaLog, "deltapatcher-log.txt");
        if (File.Exists(log))
        {
            try
            {
                string primera = File.ReadLines(log).FirstOrDefault();
                if (!string.IsNullOrWhiteSpace(primera))
                    return $"Error al aplicar el parche: {primera}";
            }
            catch (IOException) { }
        }

        return $"Error al aplicar el parche, código de error: {codigo}.";
    }

    /// <summary>
    /// Ejecuta un programa y devuelve su código de salida junto con todo lo que
    /// escribió. Las dos salidas se leen mientras el proceso corre: si se
    /// redirigen y no se leen, el hijo se bloquea en cuanto llena la tubería.
    /// </summary>
    private static async Task<(int Codigo, string Salida)> EjecutarAsync(
        string programa, IEnumerable<string> argumentos, CancellationToken ct,
        Action<string> porCadaLinea = null)
    {
        var inicio = new ProcessStartInfo
        {
            FileName = programa,
            RedirectStandardOutput = true,
            RedirectStandardError = true,
            UseShellExecute = false,
            CreateNoWindow = true,
        };
        foreach (string argumento in argumentos)
            inicio.ArgumentList.Add(argumento);

        using var proceso = Process.Start(inicio)
            ?? throw new IOException($"No se pudo iniciar \"{Path.GetFileName(programa)}\".");

        var acumulada = new System.Text.StringBuilder();

        async Task LeerAsync(StreamReader lector)
        {
            string linea;
            while ((linea = await lector.ReadLineAsync(ct)) != null)
            {
                lock (acumulada)
                    acumulada.AppendLine(linea);
                porCadaLinea?.Invoke(linea);
            }
        }

        Task estandar = LeerAsync(proceso.StandardOutput);
        Task errores = LeerAsync(proceso.StandardError);
        await proceso.WaitForExitAsync(ct);
        await Task.WhenAll(estandar, errores);

        return (proceso.ExitCode, acumulada.ToString());
    }

    /// <summary>
    /// Carpeta donde el usuario dejó el instalador, que es donde se buscan los
    /// packs para la instalación sin conexión. No sirve la carpeta del binario:
    /// en las dos plataformas está enterrado dentro del paquete.
    ///
    /// En Linux hay que mirar la variable APPIMAGE, porque el binario vive en
    /// el punto de montaje temporal del AppImage y no donde está el archivo.
    /// En macOS el binario está en `InstaladorLetraDelta.app/Contents/MacOS/`,
    /// así que la carpeta que le interesa al usuario son tres niveles arriba.
    /// </summary>
    public static string CarpetaDelInstalador()
    {
        string appImage = Environment.GetEnvironmentVariable("APPIMAGE");
        if (!string.IsNullOrEmpty(appImage))
            return Path.GetDirectoryName(Path.GetFullPath(appImage)) ?? AppContext.BaseDirectory;

        if (OperatingSystem.IsMacOS())
        {
            // .../InstaladorLetraDelta.app/Contents/MacOS/ -> .../
            var macOS = new DirectoryInfo(AppContext.BaseDirectory);
            DirectoryInfo paquete = macOS.Parent?.Parent;
            if (paquete is not null &&
                paquete.Name.EndsWith(".app", StringComparison.OrdinalIgnoreCase) &&
                paquete.Parent is not null)
            {
                return paquete.Parent.FullName;
            }
        }

        return AppContext.BaseDirectory;
    }
}

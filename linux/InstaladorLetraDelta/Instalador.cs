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
    private const string UrlLangEs = "https://github.com/BroxiCoros/LetraDelta/releases/download/latest/lang.7z";
    // Pack de inglés (LetraDelta-EN). Se instala siempre junto al español para
    // poder alternar de idioma desde el menú del juego.
    private const string UrlLangEn = "https://github.com/BroxiCoros/LetraDelta-EN/releases/download/latest/lang.7z";
    // Scripts del mod. Los Borders.csx y los PNG de NXRUNE viajan dentro, así
    // que la opción de bordes no necesita ninguna descarga adicional.
    private const string UrlScripts = "https://github.com/BroxiCoros/DeltranslatePatch/releases/download/latest/scripts.7z";

    private readonly HttpClient _http = new();
    private readonly IProgress<Avance> _avance;

    public Instalador(IProgress<Avance> avance)
    {
        _avance = avance;
        _http.Timeout = TimeSpan.FromMinutes(30);
    }

    /// <summary>Salida completa del parcheador, para mostrarla si algo falla.</summary>
    public string SalidaParcheador { get; private set; } = "";

    /// <summary>Qué pasó con el idioma por defecto del mod.</summary>
    public ResultadoIdioma Idioma { get; private set; } = ResultadoIdioma.SinPrefijo;

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
            string langEs = await ObtenerPackAsync("lang_es.7z", UrlLangEs, temporal,
                                                   "Descargando archivos de idioma (español)...", ct);
            string langEn = await ObtenerPackAsync("lang_en.7z", UrlLangEn, temporal,
                                                   "Descargando archivos de idioma (inglés)...", ct);
            string scripts = await ObtenerPackAsync("scripts.7z", UrlScripts, temporal,
                                                    "Descargando scripts...", ct);

            // Cada pack de idioma trae su propia subcarpeta lang/<código>, así
            // que ambos se descomprimen sobre la carpeta del juego sin chocar.
            _avance.Report(new Avance("Descomprimiendo archivos de idioma (español)...", null));
            await DescomprimirAsync(langEs, carpetaJuego, ct);

            _avance.Report(new Avance("Descomprimiendo archivos de idioma (inglés)...", null));
            await DescomprimirAsync(langEn, carpetaJuego, ct);

            _avance.Report(new Avance("Descomprimiendo scripts...", null));
            string carpetaScripts = Path.Combine(temporal, "scripts");
            await DescomprimirAsync(scripts, carpetaScripts, ct);

            _avance.Report(new Avance("Aplicando el parche...", null));
            string error = await ParchearAsync(carpetaJuego, carpetaScripts, conBordes, temporal, ct);
            if (error != null)
                return error;

            Idioma = FijarIdiomaPorDefecto(carpetaJuego);
            return null;
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

    /// <summary>
    /// Devuelve la ruta del pack: si el usuario dejó una copia junto al
    /// instalador la usa, y si no lo descarga. Es la instalación sin conexión
    /// que ya existe en la versión de Windows.
    /// </summary>
    private async Task<string> ObtenerPackAsync(string nombre, string url, string temporal,
                                                string texto, CancellationToken ct)
    {
        string local = Path.Combine(CarpetaDelInstalador(), nombre);
        if (File.Exists(local))
        {
            _avance.Report(new Avance($"Usando el archivo local {nombre}...", null));
            return local;
        }

        string destino = Path.Combine(temporal, nombre);
        await DescargarAsync(url, destino, texto, ct);
        return destino;
    }

    /// <summary>
    /// Descarga un archivo informando del avance. Si el servidor no declara el
    /// tamaño, el avance queda indeterminado en vez de fingir un porcentaje.
    /// </summary>
    private async Task DescargarAsync(string url, string destino, string texto, CancellationToken ct)
    {
        _avance.Report(new Avance(texto, null));

        using var respuesta = await _http.GetAsync(url, HttpCompletionOption.ResponseHeadersRead, ct);
        respuesta.EnsureSuccessStatusCode();

        long? total = respuesta.Content.Headers.ContentLength;
        string tamano = total is > 0 ? $" ({total.Value / 1024.0 / 1024.0:F1} MB)" : "";

        await using var origen = await respuesta.Content.ReadAsStreamAsync(ct);
        await using var salida = File.Create(destino);

        var bufer = new byte[81920];
        long copiado = 0;
        int leidos;
        while ((leidos = await origen.ReadAsync(bufer, ct)) > 0)
        {
            await salida.WriteAsync(bufer.AsMemory(0, leidos), ct);
            copiado += leidos;
            _avance.Report(new Avance(texto + tamano,
                                      total is > 0 ? copiado * 100.0 / total.Value : null));
        }
    }

    /// <summary>
    /// Descomprime un .7z con el 7-Zip que viaja dentro del AppImage.
    /// </summary>
    private static async Task DescomprimirAsync(string archivo, string destino, CancellationToken ct)
    {
        Directory.CreateDirectory(destino);

        string sieteZip = Path.Combine(AppContext.BaseDirectory, "7zzs");
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

        var (codigo, salida) = await EjecutarAsync(parcheador, argumentos, ct);
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
        string programa, IEnumerable<string> argumentos, CancellationToken ct)
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

        Task<string> estandar = proceso.StandardOutput.ReadToEndAsync(ct);
        Task<string> errores = proceso.StandardError.ReadToEndAsync(ct);
        await proceso.WaitForExitAsync(ct);

        return (proceso.ExitCode, (await estandar) + (await errores));
    }

    /// <summary>
    /// Deja el español como idioma por defecto del mod, dentro del prefijo de
    /// Proton del juego. Es lo mismo que hace el instalador de Windows sobre
    /// %LOCALAPPDATA%, pero aquí hay que entrar en el prefijo correcto: si se
    /// escribiera en el del propio instalador, el juego no lo vería nunca.
    /// Nunca es motivo de error: si no se puede, el idioma se elige desde el
    /// menú del juego y ya está.
    /// </summary>
    private static ResultadoIdioma FijarIdiomaPorDefecto(string carpetaJuego)
    {
        try
        {
            string biblioteca = Steam.BibliotecaDeJuego(carpetaJuego);
            if (biblioteca is null)
                return ResultadoIdioma.SinPrefijo;

            string prefijo = Steam.BuscarPrefijoProton(biblioteca);
            if (prefijo is null)
                return ResultadoIdioma.SinPrefijo;

            return Configuracion.FijarIdiomaSiNoHay(Steam.RutaConfig(prefijo));
        }
        catch (Exception ex) when (ex is IOException or UnauthorizedAccessException)
        {
            return ResultadoIdioma.SinPrefijo;
        }
    }

    /// <summary>
    /// Carpeta donde está el instalador. Dentro de un AppImage hay que mirar la
    /// variable APPIMAGE: el binario en sí vive en el punto de montaje temporal,
    /// no donde el usuario dejó el archivo.
    /// </summary>
    public static string CarpetaDelInstalador()
    {
        string appImage = Environment.GetEnvironmentVariable("APPIMAGE");
        if (!string.IsNullOrEmpty(appImage))
            return Path.GetDirectoryName(Path.GetFullPath(appImage)) ?? AppContext.BaseDirectory;

        return AppContext.BaseDirectory;
    }
}

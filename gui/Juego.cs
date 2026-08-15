namespace InstaladorLetraDelta;

/// <summary>
/// Cómo están dispuestos los archivos del juego, que depende de la plataforma
/// para la que Steam descargó DELTARUNE:
///
///   Windows/Proton   DELTARUNE/chapter1_windows/data.win
///   macOS            DELTARUNE.app/Contents/Resources/chapter1_mac/game.ios
///
/// En Linux el juego se ejecuta con Proton, así que los archivos son los de
/// Windows y esta clase los trata como tales; la disposición de macOS solo
/// aparece cuando el instalador corre en un Mac.
///
/// La disposición se deduce mirando la carpeta, no el sistema operativo. Es lo
/// mismo que hace el parcheador (ver GameLayout.cs), y por el mismo motivo:
/// permite comprobar los datos de una plataforma desde otra.
/// </summary>
public sealed class Juego
{
    /// <summary>Nombre del archivo de datos: `data.win` o `game.ios`.</summary>
    public string ArchivoDatos { get; }

    /// <summary>Sufijo de las carpetas de capítulo: `_windows` o `_mac`.</summary>
    public string SufijoCapitulo { get; }

    private Juego(string archivoDatos, string sufijoCapitulo)
    {
        ArchivoDatos = archivoDatos;
        SufijoCapitulo = sufijoCapitulo;
    }

    public static readonly Juego Windows = new("data.win", "_windows");
    public static readonly Juego Mac = new("game.ios", "_mac");

    /// <summary>
    /// Deduce la disposición de una carpeta, o devuelve null si ahí no hay un
    /// DELTARUNE completo. Se exige el último capítulo, igual que el instalador
    /// de Windows (ver setup.iss, CheckDeltaruneLoc), para descartar
    /// instalaciones a medio descargar.
    /// </summary>
    public static Juego Detectar(string carpetaJuego)
    {
        if (string.IsNullOrWhiteSpace(carpetaJuego))
            return null;

        foreach (Juego disposicion in new[] { Windows, Mac })
        {
            string ultimo = Path.Combine(carpetaJuego,
                                         "chapter5" + disposicion.SufijoCapitulo,
                                         disposicion.ArchivoDatos);
            if (File.Exists(ultimo))
                return disposicion;
        }

        return null;
    }

    /// <summary>Si en esa carpeta hay un juego que se pueda parchear.</summary>
    public static bool EsInstalacionValida(string carpetaJuego) =>
        Detectar(carpetaJuego) != null;

    /// <summary>
    /// Nombre de una función que solo existe en el juego ya parcheado: la
    /// añade el mod. Comprobado contra los archivos originales de Windows y de
    /// macOS, donde no aparece ninguna vez.
    /// </summary>
    private static readonly byte[] FirmaDelParche = "scr_lang_load"u8.ToArray();

    /// <summary>
    /// Si el archivo de datos del juego ya está modificado por un parche.
    ///
    /// Se busca la firma DENTRO del archivo de datos, y no la carpeta `lang/`
    /// que crea el pack, por un motivo concreto: «Verificar la integridad de
    /// los archivos» de Steam restaura los archivos del juego, pero no borra
    /// los que sobran, así que `lang/` sobrevive a la limpieza. Mirar ahí
    /// delataría para siempre a cualquiera que hubiera instalado la traducción
    /// una vez, incluso después de dejar el juego impecable, y un aviso que
    /// sale siempre no lo lee nadie. El archivo de datos, en cambio, sí lo
    /// restaura Steam: el aviso desaparece justo cuando debe.
    ///
    /// La firma es la del mod, así que un parche que no derive de él no se
    /// detecta y el juego queda igual de sucio. Por eso el aviso general de la
    /// página no sobra: esto lo refuerza cuando se puede, nada más. Y por eso
    /// el texto que se le enseña al usuario habla de que el archivo está
    /// modificado, sin nombrar esta traducción: lo que se sabe seguro es que
    /// la copia no está limpia, no quién la ensució.
    /// </summary>
    public static bool YaParcheado(string carpetaJuego)
    {
        Juego disposicion = Detectar(carpetaJuego);
        if (disposicion is null)
            return false;

        // El del menú es el más pequeño de los seis (unos 3 MB), y el mod lo
        // toca igual que a los capítulos.
        string datos = Path.Combine(carpetaJuego, disposicion.ArchivoDatos);

        try
        {
            using FileStream flujo = File.OpenRead(datos);
            return ContieneFirma(flujo, FirmaDelParche);
        }
        catch (IOException)
        {
            // Si no se puede leer, no se afirma nada: el aviso es una ayuda,
            // no una comprobación de la que dependa la instalación.
            return false;
        }
    }

    /// <summary>
    /// Busca una secuencia de bytes en un flujo, leyendo por bloques y
    /// solapándolos para no perder una coincidencia partida entre dos.
    /// </summary>
    private static bool ContieneFirma(Stream flujo, byte[] firma)
    {
        int solape = firma.Length - 1;
        var bufer = new byte[81920 + solape];
        int guardados = 0;

        while (true)
        {
            int leidos = flujo.Read(bufer, guardados, bufer.Length - guardados);
            if (leidos <= 0)
                return false;

            int disponibles = guardados + leidos;
            if (bufer.AsSpan(0, disponibles).IndexOf(firma) >= 0)
                return true;

            // La cola se conserva al principio del siguiente bloque.
            bufer.AsSpan(disponibles - solape, solape).CopyTo(bufer);
            guardados = solape;
        }
    }

    /// <summary>
    /// Lleva una ruta escrita o elegida por el usuario hasta la carpeta que
    /// contiene de verdad los datos.
    ///
    /// En macOS los archivos viven dentro del paquete de la aplicación, y eso
    /// el usuario no tiene por qué saberlo: el diálogo de macOS ni siquiera
    /// deja entrar en un `.app` (lo presenta como si fuera un archivo), así que
    /// lo máximo que puede elegir es la carpeta `DELTARUNE` que lo contiene.
    /// Se aceptan los tres puntos del camino y se completa el resto.
    /// </summary>
    public static string Normalizar(string ruta)
    {
        if (string.IsNullOrWhiteSpace(ruta))
            return ruta;

        string limpia = ruta.Trim().TrimEnd(Path.DirectorySeparatorChar);

        // Ya apunta a los datos: no hay nada que completar.
        if (EsInstalacionValida(limpia))
            return limpia;

        string[] candidatos =
        [
            Path.Combine(limpia, "DELTARUNE.app", "Contents", "Resources"),
            Path.Combine(limpia, "Contents", "Resources"),
            Path.Combine(limpia, "Resources"),
        ];

        foreach (string candidato in candidatos)
        {
            if (EsInstalacionValida(candidato))
                return candidato;
        }

        return limpia;
    }
}

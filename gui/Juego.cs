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

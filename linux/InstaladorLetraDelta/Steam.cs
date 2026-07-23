using System.Text.RegularExpressions;

namespace InstaladorLetraDelta;

/// <summary>
/// Localiza DELTARUNE recorriendo las bibliotecas de Steam.
/// </summary>
public static class Steam
{
    /// <summary>
    /// Raíces donde puede vivir una instalación de Steam. Se comprueban todas
    /// porque conviven con frecuencia: el paquete nativo usa las tres primeras
    /// (normalmente enlaces entre sí) y Flatpak las dos últimas. La ruta de
    /// Flatpak cambió de `.local/share/Steam` a `data/Steam`, así que se
    /// buscan ambas para no dejar fuera instalaciones antiguas.
    /// </summary>
    private static readonly string[] RaicesCandidatas =
    [
        ".local/share/Steam",
        ".steam/steam",
        ".steam/root",
        ".var/app/com.valvesoftware.Steam/data/Steam",
        ".var/app/com.valvesoftware.Steam/.local/share/Steam",
    ];

    /// <summary>
    /// Devuelve las raíces de Steam existentes, sin repetir. La deduplicación
    /// es imprescindible: en una instalación nativa típica, `.steam/steam` y
    /// `.steam/root` son enlaces simbólicos a `.local/share/Steam`, así que
    /// sin resolverlos se recorrería tres veces la misma biblioteca.
    /// </summary>
    public static IEnumerable<string> Raices()
    {
        string casa = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);
        var vistas = new HashSet<string>(StringComparer.Ordinal);

        foreach (string relativa in RaicesCandidatas)
        {
            string ruta = Path.Combine(casa, relativa);
            if (!Directory.Exists(ruta))
                continue;

            string real = RutaReal(ruta);
            if (vistas.Add(real))
                yield return real;
        }
    }

    /// <summary>
    /// Devuelve todas las bibliotecas de Steam: las propias raíces más las que
    /// declare cada `libraryfolders.vdf`. Así se cubren los discos secundarios
    /// y la microSD de la Steam Deck, que aparecen ahí y en ningún otro sitio.
    /// </summary>
    public static IEnumerable<string> Bibliotecas()
    {
        var vistas = new HashSet<string>(StringComparer.Ordinal);

        foreach (string raiz in Raices())
        {
            if (vistas.Add(raiz))
                yield return raiz;

            string vdf = Path.Combine(raiz, "steamapps", "libraryfolders.vdf");
            if (!File.Exists(vdf))
                continue;

            string contenido;
            try
            {
                contenido = File.ReadAllText(vdf);
            }
            catch (IOException)
            {
                continue;
            }

            foreach (string ruta in RutasEnVdf(contenido))
            {
                if (!Directory.Exists(ruta))
                    continue;

                string real = RutaReal(ruta);
                if (vistas.Add(real))
                    yield return real;
            }
        }
    }

    /// <summary>
    /// Busca DELTARUNE en todas las bibliotecas y devuelve la carpeta de la
    /// primera instalación válida, o null si no hay ninguna.
    /// </summary>
    public static string Detectar()
    {
        foreach (string biblioteca in Bibliotecas())
        {
            string juego = Path.Combine(biblioteca, "steamapps", "common", "DELTARUNE");
            if (EsInstalacionValida(juego))
                return juego;
        }

        return null;
    }

    /// <summary>
    /// Comprueba que la carpeta contenga realmente el juego completo. Se exige
    /// lo mismo que el instalador de Windows (ver setup.iss, CheckDeltaruneLoc):
    /// el ejecutable y el data.win del último capítulo, para descartar
    /// instalaciones a medio descargar.
    /// </summary>
    public static bool EsInstalacionValida(string carpetaJuego)
    {
        if (string.IsNullOrEmpty(carpetaJuego))
            return false;

        return File.Exists(Path.Combine(carpetaJuego, "DELTARUNE.exe"))
            && File.Exists(Path.Combine(carpetaJuego, "chapter5_windows", "data.win"));
    }

    /// <summary>
    /// Extrae las rutas de las bibliotecas de un libraryfolders.vdf.
    /// Se buscan solo las claves "path" en lugar de interpretar el VDF entero:
    /// el formato lleva años estable y no necesitamos nada más del archivo.
    /// </summary>
    private static IEnumerable<string> RutasEnVdf(string contenido)
    {
        foreach (Match coincidencia in Regex.Matches(contenido, "\"path\"\\s+\"([^\"]+)\""))
            yield return coincidencia.Groups[1].Value;
    }

    /// <summary>
    /// Resuelve enlaces simbólicos para poder comparar rutas.
    /// </summary>
    private static string RutaReal(string ruta)
    {
        try
        {
            var info = new DirectoryInfo(ruta);
            return (info.ResolveLinkTarget(returnFinalTarget: true) ?? info).FullName;
        }
        catch (IOException)
        {
            return Path.GetFullPath(ruta);
        }
    }
}

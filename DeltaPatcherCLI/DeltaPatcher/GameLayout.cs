using System.IO;

namespace DeltaPatcherCLI;

/// <summary>
/// Cómo están dispuestos los archivos del juego, que cambia según la plataforma
/// para la que Steam descargó DELTARUNE:
///
///   Windows      DELTARUNE/chapter1_windows/data.win   (y data.win suelto para el menú)
///   macOS        DELTARUNE.app/Contents/Resources/chapter1_mac/game.ios
///
/// El contenido es equivalente: los scripts del mod se aplican igual a ambos y
/// producen los mismos cambios (comprobado archivo a archivo contra los datos
/// reales de la versión de Mac).
///
/// La disposición se deduce MIRANDO LA CARPETA, no el sistema operativo donde
/// corre el parcheador. Así el instalador de cada plataforma no tiene que
/// decir nada, y además se pueden probar los datos de Mac desde Linux, que es
/// la única forma de validar el porte sin tener un Mac delante.
/// </summary>
internal sealed class GameLayout
{
    /// <summary>Nombre del archivo de datos: `data.win` o `game.ios`.</summary>
    public string DataFile { get; }

    /// <summary>Sufijo de las carpetas de capítulo: `_windows` o `_mac`.</summary>
    public string ChapterSuffix { get; }

    /// <summary>Nombre para los mensajes por consola.</summary>
    public string Name { get; }

    private GameLayout(string dataFile, string chapterSuffix, string name)
    {
        DataFile = dataFile;
        ChapterSuffix = chapterSuffix;
        Name = name;
    }

    public static readonly GameLayout Windows = new("data.win", "_windows", "Windows");
    public static readonly GameLayout Mac = new("game.ios", "_mac", "macOS");

    /// <summary>
    /// Ruta relativa (respecto a la carpeta del juego) del archivo de datos de
    /// un capítulo. `numero` va de 1 a 5.
    /// </summary>
    public string ChapterData(int numero) =>
        Path.Combine($"chapter{numero}{ChapterSuffix}", DataFile);

    /// <summary>Ruta relativa del archivo de datos del menú, que va suelto en la raíz.</summary>
    public string MenuData => DataFile;

    /// <summary>
    /// Deduce la disposición de una carpeta del juego, o devuelve null si ahí
    /// no hay un DELTARUNE reconocible. Se mira el capítulo 1 y no el
    /// ejecutable porque es lo que de verdad se va a parchear: una carpeta con
    /// el ejecutable pero sin los datos no sirve para nada.
    /// </summary>
    public static GameLayout Detect(string gamePath)
    {
        if (string.IsNullOrEmpty(gamePath))
            return null;

        foreach (GameLayout layout in new[] { Windows, Mac })
        {
            if (File.Exists(Path.Combine(gamePath, layout.ChapterData(1))))
                return layout;
        }

        return null;
    }
}

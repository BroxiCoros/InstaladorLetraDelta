namespace InstaladorLetraDelta;

/// <summary>Qué se hizo con el idioma por defecto del mod.</summary>
public enum ResultadoIdioma
{
    /// Se escribió es_mx como idioma por defecto.
    Fijado,
    /// El jugador ya tenía un idioma elegido y se respetó.
    YaEstaba,
    /// No se encontró el prefijo de Proton: el juego nunca se ha ejecutado.
    SinPrefijo,
}

/// <summary>
/// Ajusta el true_config.ini del mod, que es donde el juego guarda el idioma
/// elegido. En Windows vive en %LOCALAPPDATA%\DELTARUNE; en Linux el juego
/// corre bajo Proton, así que está dentro del prefijo del propio juego.
/// </summary>
public static class Configuracion
{
    public const string IdiomaPorDefecto = "es_mx";

    // El archivo lo escribe GameMaker desde Windows: finales de línea CRLF y
    // valores entrecomillados (LANG_DT="es_mx"). Se respeta ese formato para
    // que el juego lo lea igual que si lo hubiera escrito él.
    private const string FinDeLinea = "\r\n";
    private const string Seccion = "[LANG]";
    private const string Clave = "LANG_DT";

    /// <summary>
    /// Deja es_mx como idioma por defecto solo si el jugador no había elegido
    /// ninguno. Si ya jugó con el mod y escogió otro, se respeta su elección.
    /// </summary>
    public static ResultadoIdioma FijarIdiomaSiNoHay(string rutaIni)
    {
        if (string.IsNullOrEmpty(rutaIni))
            return ResultadoIdioma.SinPrefijo;

        string carpeta = Path.GetDirectoryName(rutaIni);
        if (!string.IsNullOrEmpty(carpeta))
            Directory.CreateDirectory(carpeta);

        if (!File.Exists(rutaIni))
        {
            File.WriteAllText(rutaIni, $"{Seccion}{FinDeLinea}{Clave}=\"{IdiomaPorDefecto}\"{FinDeLinea}");
            return ResultadoIdioma.Fijado;
        }

        var lineas = new List<string>(File.ReadAllLines(rutaIni));
        int inicioSeccion = -1;

        for (int i = 0; i < lineas.Count; i++)
        {
            string linea = lineas[i].Trim();

            if (linea.StartsWith('[') && linea.EndsWith(']'))
            {
                // Solo interesa lo que haya dentro de [LANG]; al entrar en otra
                // sección se deja de buscar la clave.
                inicioSeccion = linea.Equals(Seccion, StringComparison.OrdinalIgnoreCase) ? i : inicioSeccion;
                continue;
            }

            if (inicioSeccion < 0 || i < inicioSeccion)
                continue;

            if (EsLaClave(linea) && !string.IsNullOrEmpty(ValorDe(linea)))
                return ResultadoIdioma.YaEstaba;
        }

        string nueva = $"{Clave}=\"{IdiomaPorDefecto}\"";
        if (inicioSeccion >= 0)
            lineas.Insert(inicioSeccion + 1, nueva);
        else
            lineas.AddRange([Seccion, nueva]);

        File.WriteAllText(rutaIni, string.Join(FinDeLinea, lineas) + FinDeLinea);
        return ResultadoIdioma.Fijado;
    }

    private static bool EsLaClave(string linea)
    {
        int igual = linea.IndexOf('=');
        return igual > 0 && linea[..igual].Trim().Equals(Clave, StringComparison.OrdinalIgnoreCase);
    }

    private static string ValorDe(string linea)
    {
        int igual = linea.IndexOf('=');
        return igual < 0 ? "" : linea[(igual + 1)..].Trim().Trim('"');
    }
}

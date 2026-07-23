using System.Reflection;
using Avalonia;
using Avalonia.Controls;
using Avalonia.Markup.Xaml;
using Avalonia.Media;

namespace InstaladorLetraDelta;

public partial class MainWindow : Window
{
    // Binarios que viajan dentro del AppImage, junto a este ejecutable.
    private const string PatcherName = "DeltaPatcherCLI";
    private const string SevenZipName = "7zzs";

    public MainWindow()
    {
        AvaloniaXamlLoader.Load(this);
        MostrarDiagnostico();
    }

    private void MostrarDiagnostico()
    {
        string version = Assembly.GetExecutingAssembly().GetName().Version?.ToString(3) ?? "?";
        this.FindControl<TextBlock>("VersionText").Text = $"Versión {version}";

        // APPIMAGE lo exporta el runtime del AppImage al montarse. Si no está,
        // es que se está ejecutando desde una carpeta suelta (útil al desarrollar).
        string appImage = Environment.GetEnvironmentVariable("APPIMAGE");
        bool empaquetado = !string.IsNullOrEmpty(appImage);

        bool hayPatcher = File.Exists(Path.Combine(AppContext.BaseDirectory, PatcherName));
        bool haySevenZip = File.Exists(Path.Combine(AppContext.BaseDirectory, SevenZipName));

        var panel = this.FindControl<StackPanel>("DiagnosticsPanel");
        panel.Children.Add(Linea(
            empaquetado,
            empaquetado ? $"Ejecutándose desde el AppImage: {appImage}"
                        : "Ejecutándose desde una carpeta (sin empaquetar)"));
        panel.Children.Add(Linea(
            hayPatcher,
            hayPatcher ? $"Parcheador encontrado: {PatcherName}"
                       : $"No se encontró {PatcherName} junto al instalador"));
        panel.Children.Add(Linea(
            haySevenZip,
            haySevenZip ? $"Descompresor encontrado: {SevenZipName}"
                        : $"No se encontró {SevenZipName} junto al instalador"));

        // Detección de Steam. Se muestra aquí de momento para poder verificarla;
        // en el asistente pasará a rellenar la página de selección de carpeta.
        var bibliotecas = Steam.Bibliotecas().ToList();
        panel.Children.Add(Linea(
            bibliotecas.Count > 0,
            bibliotecas.Count > 0
                ? $"Bibliotecas de Steam: {bibliotecas.Count} ({string.Join(", ", bibliotecas)})"
                : "No se encontró ninguna biblioteca de Steam"));

        var juego = Steam.Detectar();
        panel.Children.Add(Linea(
            juego != null,
            juego != null ? $"DELTARUNE: {juego.CarpetaJuego}"
                          : "No se encontró DELTARUNE (habrá que indicar la carpeta a mano)"));

        if (juego != null)
        {
            bool hayPrefijo = juego.PrefijoProton != null;
            panel.Children.Add(Linea(
                hayPrefijo,
                hayPrefijo ? $"Prefijo de Proton: {juego.PrefijoProton}"
                           : "Sin prefijo de Proton (el juego nunca se ha ejecutado)"));
        }
    }

    // Una línea de resultado con su marca de correcto/pendiente delante.
    // DockPanel en vez de StackPanel horizontal: así el texto ocupa el ancho
    // restante y se parte en varias líneas en lugar de desbordar el recuadro
    // (las rutas del juego son largas).
    private static Control Linea(bool correcto, string texto)
    {
        var marca = new TextBlock
        {
            Text = correcto ? "✓" : "✗",
            Foreground = correcto ? Brushes.SeaGreen : Brushes.IndianRed,
            FontWeight = FontWeight.Bold,
            Margin = new Thickness(0, 0, 8, 0)
        };
        DockPanel.SetDock(marca, Dock.Left);

        var fila = new DockPanel { LastChildFill = true };
        fila.Children.Add(marca);
        fila.Children.Add(new TextBlock
        {
            Text = texto,
            FontSize = 13,
            TextWrapping = TextWrapping.Wrap
        });
        return fila;
    }

    private void OnExitClick(object sender, Avalonia.Interactivity.RoutedEventArgs e) => Close();
}

using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;

namespace InstaladorLetraDelta;

/// <summary>
/// Pregunta de sí o no sobre la ventana principal. Avalonia no trae ningún
/// cuadro de mensaje, así que el asistente lleva el suyo; es el equivalente del
/// MsgBox con MB_YESNO que usa el instalador de Windows.
/// </summary>
public partial class DialogoPregunta : Window
{
    public DialogoPregunta()
    {
        AvaloniaXamlLoader.Load(this);
    }

    /// <summary>
    /// Muestra la pregunta y espera la respuesta. Cerrar la ventana sin elegir
    /// cuenta como «no», que es siempre la opción conservadora: la respuesta
    /// afirmativa es la que cambia lo que se instala.
    /// </summary>
    public static Task<bool> MostrarAsync(Window padre, string texto,
                                          string textoSi, string textoNo)
    {
        var dialogo = new DialogoPregunta();
        dialogo.FindControl<TextBlock>("TextoPregunta").Text = texto;
        dialogo.FindControl<Button>("BotonSi").Content = textoSi;
        dialogo.FindControl<Button>("BotonNo").Content = textoNo;
        return dialogo.ShowDialog<bool>(padre);
    }

    private void AlSi(object remitente, RoutedEventArgs e) => Close(true);

    private void AlNo(object remitente, RoutedEventArgs e) => Close(false);
}

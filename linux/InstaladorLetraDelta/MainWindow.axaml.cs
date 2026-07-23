using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using Avalonia.Media;
using Avalonia.Platform.Storage;

namespace InstaladorLetraDelta;

public partial class MainWindow : Window
{
    private enum Pagina { Bienvenida, Opciones, Carpeta, Progreso, Resultado }

    private Pagina _pagina = Pagina.Bienvenida;
    private bool _instalacionCorrecta;
    private CancellationTokenSource _cancelacion;

    public MainWindow()
    {
        AvaloniaXamlLoader.Load(this);

        // Si se encuentra el juego, la casilla de la carpeta viene rellena; si
        // no, se deja vacía para que el usuario la indique a mano.
        var instalacion = Steam.Detectar();
        if (instalacion != null)
            this.FindControl<TextBox>("CampoCarpeta").Text = instalacion.CarpetaJuego;

        MostrarPagina(Pagina.Bienvenida);
    }

    // ---------------------------------------------------------------
    // Navegación
    // ---------------------------------------------------------------

    private void MostrarPagina(Pagina pagina)
    {
        _pagina = pagina;

        this.FindControl<StackPanel>("PaginaBienvenida").IsVisible = pagina == Pagina.Bienvenida;
        this.FindControl<StackPanel>("PaginaOpciones").IsVisible = pagina == Pagina.Opciones;
        this.FindControl<StackPanel>("PaginaCarpeta").IsVisible = pagina == Pagina.Carpeta;
        this.FindControl<StackPanel>("PaginaProgreso").IsVisible
            = pagina is Pagina.Progreso or Pagina.Resultado;

        var titulo = this.FindControl<TextBlock>("TituloPagina");
        var subtitulo = this.FindControl<TextBlock>("SubtituloPagina");
        var atras = this.FindControl<Button>("BotonAtras");
        var siguiente = this.FindControl<Button>("BotonSiguiente");
        var cancelar = this.FindControl<Button>("BotonCancelar");

        switch (pagina)
        {
            case Pagina.Bienvenida:
                titulo.Text = "Bienvenido al asistente de instalación de LetraDelta";
                subtitulo.Text = "Traducción al español americano de DELTARUNE";
                break;

            case Pagina.Opciones:
                titulo.Text = "Opciones de instalación";
                subtitulo.Text = "Si no estás seguro, deja todo como está.";
                break;

            case Pagina.Carpeta:
                titulo.Text = "Selecciona la carpeta de DELTARUNE";
                subtitulo.Text = "¿Dónde está instalado el juego?";
                ValidarCarpeta();
                break;

            case Pagina.Progreso:
                titulo.Text = "Realizando la instalación";
                subtitulo.Text = "Por favor, espera...";
                break;

            case Pagina.Resultado:
                titulo.Text = _instalacionCorrecta
                    ? "Instalación completada"
                    : "La instalación no se ha completado";
                subtitulo.Text = "";
                break;
        }

        atras.IsVisible = pagina is Pagina.Opciones or Pagina.Carpeta;
        cancelar.IsVisible = pagina != Pagina.Resultado;
        siguiente.IsVisible = pagina != Pagina.Progreso;
        siguiente.Content = pagina switch
        {
            Pagina.Carpeta => "Instalar",
            Pagina.Resultado => "Finalizar",
            _ => "Siguiente",
        };

        if (pagina == Pagina.Carpeta)
            ValidarCarpeta();
        else
            siguiente.IsEnabled = true;
    }

    private async void AlSiguiente(object remitente, RoutedEventArgs e)
    {
        switch (_pagina)
        {
            case Pagina.Bienvenida:
                MostrarPagina(Pagina.Opciones);
                break;
            case Pagina.Opciones:
                MostrarPagina(Pagina.Carpeta);
                break;
            case Pagina.Carpeta:
                await InstalarAsync();
                break;
            case Pagina.Resultado:
                Close();
                break;
        }
    }

    private void AlAtras(object remitente, RoutedEventArgs e)
    {
        if (_pagina == Pagina.Opciones)
            MostrarPagina(Pagina.Bienvenida);
        else if (_pagina == Pagina.Carpeta)
            MostrarPagina(Pagina.Opciones);
    }

    private void AlCancelar(object remitente, RoutedEventArgs e)
    {
        // Durante la instalación, cancelar corta el proceso en curso; en
        // cualquier otra página simplemente cierra el asistente.
        if (_pagina == Pagina.Progreso)
            _cancelacion?.Cancel();
        else
            Close();
    }

    // ---------------------------------------------------------------
    // Página de la carpeta
    // ---------------------------------------------------------------

    private async void AlExaminar(object remitente, RoutedEventArgs e)
    {
        var carpetas = await StorageProvider.OpenFolderPickerAsync(new FolderPickerOpenOptions
        {
            Title = "Selecciona la carpeta de DELTARUNE",
            AllowMultiple = false,
        });

        if (carpetas.Count > 0)
            this.FindControl<TextBox>("CampoCarpeta").Text = carpetas[0].Path.LocalPath;
    }

    private void AlCambiarCarpeta(object remitente, TextChangedEventArgs e) => ValidarCarpeta();

    /// <summary>
    /// Habilita el botón de instalar solo si la carpeta contiene de verdad el
    /// juego, y explica qué falta cuando no es así.
    /// </summary>
    private void ValidarCarpeta()
    {
        var aviso = this.FindControl<TextBlock>("AvisoCarpeta");
        var siguiente = this.FindControl<Button>("BotonSiguiente");
        string carpeta = this.FindControl<TextBox>("CampoCarpeta").Text ?? "";

        if (string.IsNullOrWhiteSpace(carpeta))
        {
            aviso.Text = "No se encontró DELTARUNE automáticamente. Indica la carpeta del juego.";
            aviso.Foreground = Brushes.Goldenrod;
            siguiente.IsEnabled = false;
            return;
        }

        if (!Steam.EsInstalacionValida(carpeta))
        {
            aviso.Text = "En esa carpeta no está DELTARUNE.exe junto a chapter5_windows/data.win.";
            aviso.Foreground = Brushes.IndianRed;
            siguiente.IsEnabled = false;
            return;
        }

        aviso.Text = "Juego encontrado. Todo listo para instalar.";
        aviso.Foreground = Brushes.SeaGreen;
        siguiente.IsEnabled = true;
    }

    // ---------------------------------------------------------------
    // Instalación
    // ---------------------------------------------------------------

    private async Task InstalarAsync()
    {
        string carpeta = this.FindControl<TextBox>("CampoCarpeta").Text;
        bool conBordes = this.FindControl<CheckBox>("CasillaBordes").IsChecked == true;

        MostrarPagina(Pagina.Progreso);

        var texto = this.FindControl<TextBlock>("TextoProgreso");
        var barra = this.FindControl<ProgressBar>("BarraProgreso");

        var avance = new Progress<Avance>(a =>
        {
            texto.Text = a.Texto;
            barra.IsIndeterminate = a.Porcentaje is null;
            if (a.Porcentaje is double porcentaje)
                barra.Value = porcentaje;
        });

        _cancelacion = new CancellationTokenSource();
        var instalador = new Instalador(avance);
        string error = await instalador.InstalarAsync(carpeta, conBordes, _cancelacion.Token);

        _instalacionCorrecta = error is null;
        barra.IsIndeterminate = false;
        barra.Value = 100;

        if (_instalacionCorrecta)
        {
            texto.Text = "La traducción al español se ha instalado correctamente.\n\n" +
                         "Si nunca habías configurado un idioma dentro del mod, queda fijado el español.\n\n" +
                         "Para revertirla, usa «Verificar integridad de los archivos» en Steam.";
        }
        else
        {
            texto.Text = error;
            MostrarDetalle(instalador.SalidaParcheador);
        }

        MostrarPagina(Pagina.Resultado);
    }

    /// <summary>
    /// Muestra la salida del parcheador cuando algo va mal, para poder
    /// copiarla y pegarla al pedir ayuda.
    /// </summary>
    private void MostrarDetalle(string detalle)
    {
        if (string.IsNullOrWhiteSpace(detalle))
            return;

        this.FindControl<SelectableTextBlock>("TextoDetalle").Text = detalle.TrimEnd();
        this.FindControl<Border>("CajaDetalle").IsVisible = true;
    }
}

using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using Avalonia.Media;
using Avalonia.Platform.Storage;

namespace InstaladorLetraDelta;

public partial class MainWindow : Window
{
    private enum Pagina { Bienvenida, Limpieza, Opciones, Carpeta, Progreso, Resultado }

    private Pagina _pagina = Pagina.Bienvenida;
    private bool _instalacionCorrecta;
    private CancellationTokenSource _cancelacion;

    public MainWindow()
    {
        AvaloniaXamlLoader.Load(this);

        TextosDePlataforma();

        // Si se encuentra el juego, la casilla de la carpeta viene rellena; si
        // no, se deja vacía para que el usuario la indique a mano.
        string carpetaJuego = Steam.Detectar();
        if (carpetaJuego != null)
            this.FindControl<TextBox>("CampoCarpeta").Text = carpetaJuego;

        MostrarPagina(Pagina.Bienvenida);
    }

    /// <summary>
    /// Los textos que hablan de dónde vive el juego cambian según la
    /// plataforma: en Linux se ejecuta con Proton sobre los archivos de
    /// Windows, y en macOS los archivos están dentro del paquete de la
    /// aplicación y ni siquiera se llaman igual.
    /// </summary>
    private void TextosDePlataforma()
    {
        bool mac = OperatingSystem.IsMacOS();

        this.FindControl<TextBlock>("NotaPlataforma").Text = mac
            ? "En macOS los archivos del juego viven dentro de «DELTARUNE.app». El instalador los localiza solo; no hace falta que entres ahí."
            : "En Linux el juego funciona con Proton, pero los archivos del juego son los mismos que en Windows y el parche se aplica igual.";

        this.FindControl<TextBlock>("AyudaCarpeta").Text = mac
            ? "Selecciona la carpeta «DELTARUNE», la que contiene «DELTARUNE.app»."
            : "Selecciona la carpeta que contiene «DELTARUNE.exe» y las carpetas «chapter1_windows» … «chapter5_windows».";
    }

    // ---------------------------------------------------------------
    // Navegación
    // ---------------------------------------------------------------

    private void MostrarPagina(Pagina pagina)
    {
        _pagina = pagina;

        this.FindControl<StackPanel>("PaginaBienvenida").IsVisible = pagina == Pagina.Bienvenida;
        this.FindControl<StackPanel>("PaginaLimpieza").IsVisible = pagina == Pagina.Limpieza;
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

            case Pagina.Limpieza:
                titulo.Text = "Antes de empezar";
                subtitulo.Text = "Requisitos de la instalación";
                ComprobarInstalacionPrevia();
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

        atras.IsVisible = pagina is Pagina.Limpieza or Pagina.Opciones or Pagina.Carpeta;
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
                MostrarPagina(Pagina.Limpieza);
                break;
            case Pagina.Limpieza:
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
        if (_pagina == Pagina.Limpieza)
            MostrarPagina(Pagina.Bienvenida);
        else if (_pagina == Pagina.Opciones)
            MostrarPagina(Pagina.Limpieza);
        else if (_pagina == Pagina.Carpeta)
            MostrarPagina(Pagina.Opciones);
    }

    /// <summary>
    /// Refuerza el aviso cuando se puede detectar que la traducción ya está
    /// puesta. La comprobación mira dentro del archivo de datos, no la carpeta
    /// `lang/`: ver <see cref="Juego.YaTraducido"/> para por qué importa.
    /// </summary>
    private void ComprobarInstalacionPrevia()
    {
        var aviso = this.FindControl<TextBlock>("AvisoInstalacionPrevia");
        string carpeta = this.FindControl<TextBox>("CampoCarpeta").Text ?? "";

        bool yaInstalada = Juego.YaTraducido(carpeta);

        aviso.IsVisible = yaInstalada;
        if (yaInstalada)
        {
            aviso.Text = "Esta copia del juego ya parece tener la traducción instalada. "
                       + "Verifica la integridad de los archivos en Steam antes de continuar, "
                       + "ya que aplicarla de nuevo puede causar problemas.";
            aviso.Foreground = Brushes.Goldenrod;
        }
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

        // En macOS el diálogo no deja entrar en DELTARUNE.app, así que lo que
        // llega aquí suele ser la carpeta que lo contiene: Normalizar completa
        // el resto del camino hasta los datos.
        if (carpetas.Count > 0)
            this.FindControl<TextBox>("CampoCarpeta").Text = Juego.Normalizar(carpetas[0].Path.LocalPath);
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

        // Si lo que hay escrito es la carpeta que contiene DELTARUNE.app (lo
        // único que se puede elegir en el diálogo de macOS), se completa el
        // camino hasta los datos. Al reescribir el campo se vuelve a entrar
        // aquí, ya con la ruta buena, y esa segunda pasada no cambia nada.
        string normalizada = Juego.Normalizar(carpeta);
        if (normalizada != carpeta && Juego.EsInstalacionValida(normalizada))
        {
            this.FindControl<TextBox>("CampoCarpeta").Text = normalizada;
            return;
        }

        if (!Juego.EsInstalacionValida(carpeta))
        {
            // El nombre del archivo cambia según la plataforma del juego, así
            // que se nombra el de esta para que el aviso sea comprobable.
            aviso.Text = OperatingSystem.IsMacOS()
                ? "En esa carpeta no está DELTARUNE. Indica la carpeta que contiene DELTARUNE.app."
                : "En esa carpeta no está DELTARUNE: falta chapter5_windows/data.win.";
            aviso.Foreground = Brushes.IndianRed;
            siguiente.IsEnabled = false;
            return;
        }

        // La comprobación de «ya parcheado» se repite aquí, y no solo en la
        // página de «Antes de empezar», porque allí se mira la carpeta que
        // Steam detectó al arrancar: si el usuario elige otra a mano —que es
        // justo cuando más fácil es apuntar a un juego ya parcheado— aquella
        // comprobación ya pasó y nadie vuelve a mirar. Esta es la última
        // pantalla antes de instalar, así que es la que tiene que acertar.
        //
        // Se lee un archivo de 3 MB, pero solo cuando la ruta ya es válida, o
        // sea un par de veces y no en cada tecla.
        if (Juego.YaTraducido(carpeta))
        {
            aviso.Text = "Juego encontrado. La traducción ya parece estar instalada en esta copia: "
                       + "verifica la integridad de los archivos en Steam antes de continuar, "
                       + "ya que aplicarla de nuevo puede causar problemas.";
            aviso.Foreground = Brushes.Goldenrod;
            siguiente.IsEnabled = true;
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
        var instalador = new Instalador(avance, PreguntarPackLocalAsync);
        string error = await instalador.InstalarAsync(carpeta, conBordes, _cancelacion.Token);

        _instalacionCorrecta = error is null;
        barra.IsIndeterminate = false;
        barra.Value = 100;

        if (_instalacionCorrecta)
        {
            texto.Text = "La traducción al español se ha instalado correctamente.\n\n" +
                         "Puedes cambiar de idioma en cualquier momento desde el menú del juego.\n\n" +
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
    /// Pregunta si usar un pack que había junto al instalador en vez de
    /// descargarlo. Los botones dicen qué va a pasar en lugar de «Sí» y «No»:
    /// la pregunta llega sin avisar, en mitad de la instalación, y quien la lee
    /// puede no recordar haber dejado ese archivo ahí.
    ///
    /// Se llama desde el hilo de la interfaz porque el instalador no usa
    /// ConfigureAwait(false) en ningún await, así que sus continuaciones vuelven
    /// aquí. Si eso cambiara, ShowDialog avisaría con una excepción.
    /// </summary>
    private Task<bool> PreguntarPackLocalAsync(string nombre) =>
        DialogoPregunta.MostrarAsync(
            this,
            $"Se encontró un archivo «{nombre}» junto al instalador.\n\n" +
            "Puedes usarlo en lugar de descargarlo, pero si es una copia antigua " +
            "instalarás una versión desactualizada de la traducción.",
            "Usar ese archivo",
            "Descargarlo");

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

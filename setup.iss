[Setup]
AppName=LetraDelta — Instalador de la traducción de DELTARUNE
AppVersion=1.5.1
AppPublisher=BroxiCoros
AppPublisherURL=https://github.com/BroxiCoros/LetraDelta
AppSupportURL=https://discord.gg/ndkjnhXPPr
DefaultDirName={autopf}\LetraDelta
OutputBaseFilename=InstaladorLetraDelta
Compression=lzma2/ultra64
SolidCompression=yes
SetupIconFile=icon.ico
WizardStyle=modern dynamic
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
DisableDirPage=yes
DisableWelcomePage=no
WizardSmallImageFile=logo.bmp
WizardImageFile=banner.bmp
WizardSmallImageFileDynamicDark=logo.bmp
WizardImageFileDynamicDark=banner.bmp
// SetupLogging=True
// El selector de idioma de Inno se desactiva: ya hay un solo idioma (espanol)
// y no tiene sentido preguntar.
ShowLanguageDialog=no
UsePreviousLanguage=no

[Languages]
Name: "tr"; MessagesFile: "compiler:Languages\Spanish.isl"
// El nombre del language sigue siendo "tr" por compatibilidad con todas
// las claves "tr.X" usadas mas abajo. El MessagesFile apunta a la
// traduccion estandar al espanol que viene con Inno Setup.

[Messages]
tr.ExitSetupMessage=La instalación no se ha completado. Si sales ahora, la traducción no quedará instalada.%n%nPuedes completar la instalación volviendo a ejecutar este programa más tarde.%n%n¿Deseas salir del instalador?

[CustomMessages]

tr.WelcomeLabel1=Bienvenido al asistente de instalación de LetraDelta
tr.WelcomeLabel2=Este asistente instalará la traducción al español americano de DELTARUNE.
tr.wpWelcome1=Descripción de la instalación
tr.wpWelcome2=¿Qué se va a instalar?
tr.wpWelcome3=La instalación de la traducción incluye:
tr.wpWelcome3a= • Mod de "Deltranslate"
tr.wpWelcome4= • Traducción completa de los capítulos 1 a 5
tr.wpWelcome9=La traducción se aplicará sobre la instalación actual del juego.
tr.wpWelcome10=Las partidas guardadas no se verán afectadas.
tr.wpClean1=Antes de empezar
tr.wpClean2=Requisitos de la instalación
tr.wpClean3=La traducción debe aplicarse sobre una copia limpia del juego, sin otros parches ni traducciones instalados antes.
tr.wpClean4=Si ya habías aplicado algún parche, o no lo recuerdas, verifica la integridad de los archivos en Steam antes de continuar:
tr.wpClean5=     Clic derecho sobre DELTARUNE → «Propiedades» → «Archivos instalados» → «Verificar la integridad de los archivos del juego»
tr.wpClean6=Steam restaura los originales y la instalación parte de cero.
tr.AlreadyPatched1=El archivo de datos de esta copia del juego ya está modificado, así que no es una copia limpia.
tr.AlreadyPatched2=Verifica la integridad de los archivos en Steam antes de continuar, para que el parche se aplique sobre los archivos originales.
tr.CreateInputDirPage1=Selecciona la carpeta de DELTARUNE
tr.CreateInputDirPage2=¿Dónde está instalado el juego?
tr.CreateInputDirPage3=Selecciona la carpeta que contiene "DELTARUNE.exe" y las carpetas "chapter1_windows" ... "chapter5_windows".
tr.CreateInputDirPage4=Suele tener este aspecto: 
tr.FinishedText1=La traducción al español se ha instalado correctamente en tu equipo.
tr.FinishedText1a=Para revertirla, usa «Verificar la integridad de los archivos del juego» en Steam.
tr.FinishedText2=Pulsa «Finalizar» para salir del instalador.
tr.ProgressPage1a=Realizando la instalación
tr.ProgressPage1b=Por favor, espera...
tr.FoundGameLoc1=DELTARUNE (Capítulos 1-5) no se encontró en las carpetas predeterminadas. Indica la ruta manualmente.
tr.FoundGameLoc2=No se encontró "DELTARUNE.exe" en la carpeta indicada.
tr.ProgressPage2a= MB
tr.ProgressPage2b=Tamaño del archivo: 
tr.FirstLogLine1=Error al aplicar el parche: 
tr.FirstLogLine2=El registro del instalador se ha guardado en el archivo
tr.ExceptionMsg1a=No se pudo descomprimir el archivo "%s" por un error desconocido.
tr.ExceptionMsg1b=Ruta de descompresión - 
tr.ExceptionMsg2a=No se pudo descomprimir el archivo "%s" - hay archivos en uso, posiblemente por otro proceso.
tr.ExceptionMsg2b=Si la carpeta del juego tiene el atributo "Solo lectura", quítaselo (no olvides "Aplicar") e inténtalo de nuevo.
tr.RaiseException1=Archivo no encontrado, ruta - 
tr.DownloadToTempWithMirror1=Descargando archivos de idioma (español)...
tr.DownloadToTempWithMirror2=Descargando scripts...
tr.DownloadToTempWithMirror3=Se produjo un error al descargar los archivos: 
tr.ProgressPage3a=Descomprimiendo el parcheador...
tr.ProgressPage3b=Descomprimiendo archivos de idioma (español)...
tr.ProgressPage3c=Descomprimiendo scripts...
tr.ProgressPage3d=Aplicando el parche...
tr.HandlePatcherError1=Error al aplicar el parche, código de error: 
tr.HandlePatcherError2=No se pudo iniciar el parcheador.
tr.HandlePatcherError2b=Windows no llegó a ejecutarlo y devolvió el error %d: %s
tr.HandlePatcherError3=El parcheador no aparece donde debería después de descomprimirlo:
tr.HandlePatcherErrorHint=Vuelve a ejecutar el instalador. Si el problema se repite, indica este mensaje al pedir ayuda.
tr.ExceptionMsg3=Se produjo un error durante la instalación: 
tr.FinishedText3a=No se pudo instalar la traducción de DELTARUNE debido a un error.
tr.FinishedText3b=Pulsa «Finalizar» para salir del instalador.
tr.FinishedHeadingLabel1=Completando la instalación de la traducción de DELTARUNE
tr.OfflineQuestion1=Se encontró un archivo lang.7z junto al instalador. ¿Usarlo en lugar de descargarlo?
tr.OfflineQuestion2=Se encontró un archivo scripts.7z junto al instalador. ¿Usarlo en lugar de descargarlo?
tr.wpWelcome11=Si descargas previamente los archivos %s y los colocas junto a este instalador, se te preguntará si quieres usarlos en vez de descargarlos.
tr.DeltaQuick1=Aplicar la traducción a los APK de DeltaQuick (Android)
tr.Borders1=Instalar versión con bordes (NXRUNE)
tr.OptionsPage1=Opciones de instalación
tr.OptionsPage2=Selecciona las opciones que apliquen a tu caso. Si no estás seguro, deja todo como está.
tr.OptionsPageBordersHelp=Añade los bordes decorativos de las versiones de consola. Variante visual basada en NXRUNE.
tr.OptionsPageDeltaQuickHelp=Para usuarios de Android (DeltaQuick). En este modo no se parchea el juego de escritorio.

[Files]
Source: "DeltaPatcherCLI.7z"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Code]
const
  // Pack de idioma español americano (LetraDelta).
  LangURL       = 'https://github.com/BroxiCoros/LetraDelta/releases/download/latest/lang.7z';
  LangURLMirror = 'https://github.com/BroxiCoros/LetraDelta/releases/download/latest/lang.7z';

  // Scripts del mod (DeltranslatePatch fork con etapas 1-6 + bordes integrados).
  // Los Borders.csx y los PNGs de NXRUNE viajan dentro de este mismo .7z;
  // no hay descarga adicional para la opción "con bordes".
  ScriptsURL       = 'https://github.com/BroxiCoros/DeltranslatePatch/releases/download/latest/scripts.7z';
  ScriptsURLMirror = 'https://github.com/BroxiCoros/DeltranslatePatch/releases/download/latest/scripts.7z';

  DeltaruneExe = 'DELTARUNE.exe';

  // Archivo de datos del juego del menu: el mas pequeno de los seis (unos
  // 3 MB) y el primero que toca el parche.
  DeltaruneData = 'data.win';

  // Nombre de una funcion que el mod anade al archivo de datos y que en los
  // archivos originales no aparece ninguna vez. Es la unica forma que hay
  // desde aqui de saber si la copia esta limpia. Es la misma comprobacion que
  // hace el instalador de Linux (ver gui/Juego.cs).
  PatchSignature = 'scr_lang_load';

  // La casilla de DeltaQuick (Android) queda oculta de momento. Todo lo que la
  // implementa sigue en su sitio y sin tocar: el argumento --droid, las rutas
  // de los APK y la exclusion mutua con la opcion de bordes. Para volver a
  // mostrarla basta con poner esto en True; no hay nada mas que deshacer.
  MostrarDeltaQuick = False;

var
  InfoPage: TOutputMsgWizardPage;
  CleanInstallPage: TOutputMsgWizardPage;
  OptionsPage: TWizardPage;
  GamePathPage: TInputDirWizardPage;
  ProgressPage: TOutputProgressWizardPage;

  FinishedText: String;
  ForceClose: Boolean;
  ExistingDrives: TArrayOfString;

  // Carpeta del juego detectada al arrancar el asistente, o vacia si no se
  // encontro. Se calcula una sola vez: rellena el campo de la pagina de
  // carpeta y decide si hay que avisar al usuario de que la indique a mano.
  DetectedGameLoc: String;

  // Casillas de la pagina de opciones (OptionsPage). Se crean en
  // InitializeWizard y se leen al pulsar Siguiente desde esa pagina.
  BordersCheckbox: TNewCheckBox;
  DeltaQuickCheckbox: TNewCheckBox;

  // Avisos de "esta copia ya esta modificada". Se crean siempre y se muestran
  // solo cuando la comprobacion da positivo.
  CleanPatchedLabel: TNewStaticText;
  GamePathPatchedLabel: TNewStaticText;

  // Ultima ruta comprobada y su resultado. La comprobacion lee un archivo de
  // 3 MB y el aviso de la pagina de la carpeta se recalcula en cada tecla, asi
  // que sin esto se releeria el archivo entero mientras el usuario escribe.
  LastPatchCheckPath: String;
  LastPatchCheckResult: Boolean;

  // Variables booleanas que reflejan el estado de las casillas tras
  // confirmar la pagina de opciones. Se consultan luego en
  // DownloadAndExtractFiles.
  InstallBorders: Boolean;
  PatchDeltaQuick: Boolean;

procedure InitExistingDrives;
var
  DriveLetter: Char;
  i, DriveCount: Integer;
begin
  for i := Ord('C') to Ord('Z') do
  begin
    DriveLetter := Chr(i);
    if DirExists(DriveLetter + ':\') then
    begin
      DriveCount := GetArrayLength(ExistingDrives);
      SetArrayLength(ExistingDrives, DriveCount + 1);
      ExistingDrives[DriveCount] := DriveLetter + ':';
    end;
  end;
end;

// Is the full version of DELTARUNE in this folder?
function CheckDeltaruneLoc(DirPath: String): Boolean;
begin
  Result := FileExists(DirPath + DeltaruneExe);
  if Result then
    Result := FileExists(AddBackslash(DirPath) + 'chapter5_windows\data.win');
end;

// Si esta copia del juego ya esta modificada por un parche.
//
// Se busca la firma DENTRO del archivo de datos, y no la carpeta `lang`
// que crea el pack, por un motivo concreto: "Verificar la integridad de los
// archivos" de Steam restaura los archivos del juego, pero no borra los que
// sobran, asi que `lang` sobrevive a la limpieza. Mirar ahi delataria para
// siempre a cualquiera que hubiera instalado la traduccion una vez, incluso
// despues de dejar el juego impecable, y un aviso que sale siempre no lo lee
// nadie. El archivo de datos si lo restaura Steam: el aviso desaparece justo
// cuando debe.
//
// El resultado se guarda en LastPatchCheckPath/LastPatchCheckResult porque
// esto se llama desde el OnChange del campo de la carpeta.
function IsGamePatched(DirPath: String): Boolean;
var
  Data: AnsiString;
begin
  Result := False;

  if DirPath = '' then
    Exit;

  DirPath := AddBackslash(DirPath);

  if DirPath = LastPatchCheckPath then
  begin
    Result := LastPatchCheckResult;
    Exit;
  end;

  // Sin juego no hay nada que afirmar, y no se guarda en la cache: la ruta
  // aun se esta escribiendo y cambiara en la siguiente tecla.
  if not CheckDeltaruneLoc(DirPath) then
    Exit;

  // Si el archivo no se puede leer no se afirma nada: el aviso es una ayuda,
  // no una comprobacion de la que dependa la instalacion.
  //
  // Pos convierte el AnsiString a Unicode con la pagina de codigos del
  // sistema. Con los bytes sueltos de un binario eso no siempre es
  // reversible, pero solo puede hacer que la firma pase desapercibida, nunca
  // que aparezca donde no esta: el peor caso es quedarse sin aviso, que es
  // justo lo que habia antes de esto.
  if LoadStringFromFile(DirPath + DeltaruneData, Data) then
    Result := Pos(PatchSignature, Data) > 0;

  LastPatchCheckPath := DirPath;
  LastPatchCheckResult := Result;
end;

// ---- Deteccion del juego a traves de Steam ----
//
// Steam declara todas sus bibliotecas en `libraryfolders.vdf`, incluidas las
// de discos secundarios. Sin leer ese archivo, una instalacion en
// D:\SteamLibrary no se encuentra nunca, que es el caso mas comun despues
// del predeterminado. La logica es la misma que usa el instalador de Linux
// (ver gui/Steam.cs).

// Devuelve la cadena entrecomillada numero Index (base 0) de una linea del
// VDF, o vacio si no hay tantas. Basta con esto para leer el archivo: no
// hace falta interpretar el formato entero, solo pares clave/valor.
function VdfToken(const Line: String; Index: Integer): String;
var
  i, Start, Found: Integer;
  Abierta: Boolean;
begin
  Result := '';
  Abierta := False;
  Found := 0;
  Start := 1;

  for i := 1 to Length(Line) do
  begin
    if Line[i] <> '"' then
      Continue;

    if not Abierta then
    begin
      Abierta := True;
      Start := i + 1;
    end
    else
    begin
      Abierta := False;
      if Found = Index then
      begin
        Result := Copy(Line, Start, i - Start);
        Exit;
      end;
      Found := Found + 1;
    end;
  end;
end;

// True si la cadena son solo digitos.
function IsDigits(const S: String): Boolean;
var
  i: Integer;
begin
  Result := Length(S) > 0;

  for i := 1 to Length(S) do
    if (S[i] < '0') or (S[i] > '9') then
    begin
      Result := False;
      Exit;
    end;
end;

// Anade una ruta a la lista si existe y no estaba ya. La comprobacion de
// existencia hace de filtro barato: descarta bibliotecas desconectadas y
// tambien los valores numericos que el VDF guarda junto a las rutas.
procedure AddLibrary(var Libraries: TArrayOfString; Path: String);
var
  i, Count: Integer;
begin
  if Path = '' then
    Exit;

  // Bajo Proton, el VDF de Steam declara rutas de Linux (/mnt/..., /run/...).
  // La raiz del sistema se ve como Z:\, y sin ese prefijo quedarian como
  // rutas relativas a la unidad actual: la microSD de una Steam Deck no se
  // encontraria nunca.
  if Path[1] = '/' then
    Path := 'Z:' + Path;

  // El valor `SteamPath` del registro usa barras normales.
  StringChangeEx(Path, '/', '\', True);
  Path := RemoveBackslashUnlessRoot(Path);

  if not DirExists(Path) then
    Exit;

  Count := GetArrayLength(Libraries);
  for i := 0 to Count - 1 do
    if SameText(Libraries[i], Path) then
      Exit;

  SetArrayLength(Libraries, Count + 1);
  Libraries[Count] := Path;
end;

// Saca las rutas de bibliotecas de un libraryfolders.vdf.
procedure CollectLibrariesFromVdf(const VdfPath: String; var Libraries: TArrayOfString);
var
  Raw: AnsiString;
  Lines: TArrayOfString;
  i: Integer;
  Key, Value: String;
begin
  if not FileExists(VdfPath) then
    Exit;
  if not LoadStringFromFile(VdfPath, Raw) then
    Exit;

  // El VDF viene en UTF-8: se decodifica para no estropear las rutas que
  // lleven acentos.
  Lines := StringSplit(UTF8Decode(Raw), [#10], stAll);

  for i := 0 to GetArrayLength(Lines) - 1 do
  begin
    Key := VdfToken(Lines[i], 0);
    Value := VdfToken(Lines[i], 1);

    // Formato actual: "path"  "D:\\SteamLibrary".
    // Formato antiguo: "1"  "D:\\SteamLibrary".
    if SameText(Key, 'path') or IsDigits(Key) then
    begin
      StringChangeEx(Value, '\\', '\', True);
      AddLibrary(Libraries, Value);
    end;
  end;
end;

// Raices donde puede vivir Steam: el registro en Windows, y las rutas
// habituales de Linux vistas desde Proton, donde Z:\ es la raiz del sistema.
// Se cubren el Steam nativo y el de Flatpak, y el usuario "deck" ademas del
// actual.
function SteamRoots(): TArrayOfString;
var
  Roots: TArrayOfString;
  LinuxRoots: array[0..4] of String;
  Users: array[0..1] of String;
  Path: String;
  i, j: Integer;
begin
  SetArrayLength(Roots, 0);

  if RegQueryStringValue(HKCU, 'Software\Valve\Steam', 'SteamPath', Path) then
    AddLibrary(Roots, Path);

  // Steam es una aplicacion de 32 bits, asi que su clave vive en la vista de
  // 32 del registro. Se consultan las dos vistas explicitamente porque el
  // instalador corre en modo 64 y ahi no hay redireccion automatica.
  if RegQueryStringValue(HKLM32, 'SOFTWARE\Valve\Steam', 'InstallPath', Path) then
    AddLibrary(Roots, Path);
  if IsWin64 then
    if RegQueryStringValue(HKLM64, 'SOFTWARE\Valve\Steam', 'InstallPath', Path) then
      AddLibrary(Roots, Path);

  LinuxRoots[0] := 'Z:\home\%s\.local\share\Steam';
  LinuxRoots[1] := 'Z:\home\%s\.steam\steam';
  LinuxRoots[2] := 'Z:\home\%s\.steam\root';
  LinuxRoots[3] := 'Z:\home\%s\.var\app\com.valvesoftware.Steam\data\Steam';
  LinuxRoots[4] := 'Z:\home\%s\.var\app\com.valvesoftware.Steam\.local\share\Steam';

  Users[0] := 'deck'; // usuario predeterminado de Steam Deck
  Users[1] := GetUserNameString();

  for i := 0 to High(LinuxRoots) do
    for j := 0 to High(Users) do
      AddLibrary(Roots, Format(LinuxRoots[i], [Users[j]]));

  Result := Roots;
end;

// Todas las bibliotecas de Steam: las propias raices mas las que declare
// cada libraryfolders.vdf.
function SteamLibraries(): TArrayOfString;
var
  Roots, Libraries: TArrayOfString;
  i: Integer;
begin
  SetArrayLength(Libraries, 0);
  Roots := SteamRoots();

  for i := 0 to GetArrayLength(Roots) - 1 do
  begin
    AddLibrary(Libraries, Roots[i]);

    // Desde 2021 el archivo vive en steamapps\; antes estaba en config\.
    CollectLibrariesFromVdf(AddBackslash(Roots[i]) + 'steamapps\libraryfolders.vdf', Libraries);
    CollectLibrariesFromVdf(AddBackslash(Roots[i]) + 'config\libraryfolders.vdf', Libraries);
  end;

  Result := Libraries;
end;

// Search for the DELTARUNE folder
function FindGameLocation(): String;
var
  GameLocations: array[0..3] of String;
  Libraries: TArrayOfString;
  DrivePrefix, Location: String;
  i, j: Integer;
begin
  // Primero, las bibliotecas que declara el propio Steam.
  Libraries := SteamLibraries();

  for i := 0 to GetArrayLength(Libraries) - 1 do
  begin
    Result := AddBackslash(Libraries[i]) + 'steamapps\common\DELTARUNE\';
    if CheckDeltaruneLoc(Result) then
      Exit;
  end;

  // Respaldo por si el juego no viene de Steam o el registro esta sin
  // escribir: se prueban las rutas fijas de siempre en cada unidad.
  GameLocations[0] := '\Program Files (x86)\Steam\steamapps\common\DELTARUNE\';
  GameLocations[1] := '\Program Files (x86)\DELTARUNE\';
  GameLocations[2] := '\DELTARUNE\';
  GameLocations[3] := '\Program Files\DELTARUNE\';

  Result := '';

  for i := 0 to High(ExistingDrives) do
  begin
    DrivePrefix := ExistingDrives[i];

    for j := 0 to High(GameLocations) do
    begin
      Location := DrivePrefix + GameLocations[j];
      if CheckDeltaruneLoc(Location) then
      begin
        Result := Location;
        Exit;
      end;
    end;
  end;
end;

// ---- Exclusion mutua entre las casillas de la pagina de opciones ----
//
// La opcion de bordes (NXRUNE) y la opcion DeltaQuick son incompatibles
// entre si: los bordes solo aplican al juego de escritorio (modifican
// el data.win), mientras que DeltaQuick parchea APKs de Android sin
// tocar el data.win. Si el usuario marca una de las dos, desmarcamos
// la otra al vuelo.
procedure DeltaQuickCheckboxClick(Sender: TObject);
begin
  if DeltaQuickCheckbox.Checked then
    BordersCheckbox.Checked := False;
end;

procedure BordersCheckboxClick(Sender: TObject);
begin
  if BordersCheckbox.Checked then
    DeltaQuickCheckbox.Checked := False;
end;

// El boton "Examinar" de CreateInputDirPage no abre el selector de carpetas de
// Windows, sino un formulario que Inno Setup dibuja el mismo con su propio
// arbol. Es asi en todas las versiones, asi que actualizar no lo cambia. La
// funcion BrowseForFolder si abre el selector normal (IFileDialog desde Inno
// Setup 6.6.0), de modo que se reemplaza el manejador del boton por este.
//
// Sin boton de carpeta nueva: aqui se busca un juego ya instalado, no hay nada
// que crear. Y se quita la barra final por lo mismo que en InitializeWizard: la
// ruta viaja entrecomillada hasta el parcheador.
procedure GamePathBrowseClick(Sender: TObject);
var
  Dir: String;
begin
  Dir := GamePathPage.Values[0];
  if BrowseForFolder(CustomMessage('CreateInputDirPage1'), Dir, False) then
    GamePathPage.Values[0] := RemoveBackslashUnlessRoot(Dir);
end;

// ---- Aviso de "esta copia ya esta modificada" ----
//
// Se comprueba en las dos paginas donde puede cambiar la respuesta: la de
// requisitos mira la carpeta que se detecto al arrancar, y la de la carpeta
// vuelve a mirar porque es donde el usuario puede elegir otra a mano, que es
// justo cuando mas facil es apuntar a un juego ya parcheado. Aquella
// comprobacion ya paso y nadie volveria a mirar.

// Olvida el resultado guardado. Se llama al entrar en cada una de las dos
// paginas porque el aviso pide precisamente ir a Steam a verificar la
// integridad: quien lo haga y vuelva al asistente tiene que ver el aviso ya
// desaparecido, no la respuesta de antes.
procedure ForgetPatchCheck;
begin
  LastPatchCheckPath := '';
end;

procedure UpdateCleanPageWarning;
begin
  CleanPatchedLabel.Visible := IsGamePatched(GamePathPage.Values[0]);
end;

procedure UpdateGamePathWarning;
begin
  GamePathPatchedLabel.Visible := IsGamePatched(GamePathPage.Values[0]);
end;

procedure GamePathEditChange(Sender: TObject);
begin
  UpdateGamePathWarning;
end;

procedure InitializeWizard;
var
  OffsetY: Integer;
  HelpLabel: TNewStaticText;
begin
  // Antes que nada, porque la deteccion del juego se apoya en la lista de
  // unidades para su busqueda de respaldo.
  InitExistingDrives;

  WizardForm.WelcomeLabel1.Caption := CustomMessage('WelcomeLabel1');
  WizardForm.WelcomeLabel2.Caption := CustomMessage('WelcomeLabel2');

  // ---- Pagina de informacion (compacta) ----
  // Texto resumido para que entre comodo en el cuadro del wizard.
  // Las URLs de descarga manual y los detalles tecnicos viven en el
  // README del repositorio, no en el wizard.
  InfoPage := CreateOutputMsgPage(
    wpWelcome,
    CustomMessage('wpWelcome1'),
    CustomMessage('wpWelcome2'),
    CustomMessage('wpWelcome3') + #13#10 +
    CustomMessage('wpWelcome3a') + #13#10 +
    CustomMessage('wpWelcome4') + #13#10#13#10 +
    CustomMessage('wpWelcome9') + #13#10 +
    CustomMessage('wpWelcome10') + #13#10#13#10 +
    Format(CustomMessage('wpWelcome11'), ['"lang.7z" y "scripts.7z"'])
  );

  // ---- Pagina de requisitos ----
  // Va en pagina propia y no junto al resto de la informacion por dos razones:
  // el cuadro de CreateOutputMsgPage no tiene barra de desplazamiento y lo que
  // no cabe se recorta sin avisar, y esto conviene que se lea entero. Que la
  // copia este limpia no hay forma de comprobarlo desde aqui, asi que lo unico
  // que se puede hacer es decirlo antes de tocar nada.
  CleanInstallPage := CreateOutputMsgPage(
    InfoPage.ID,
    CustomMessage('wpClean1'),
    CustomMessage('wpClean2'),
    CustomMessage('wpClean3') + #13#10#13#10 +
    CustomMessage('wpClean4') + #13#10#13#10 +
    CustomMessage('wpClean5') + #13#10#13#10 +
    CustomMessage('wpClean6')
  );

  // El aviso va debajo del texto fijo y en otro color: lo que dice no es un
  // requisito general, sino algo que se ha comprobado en esta copia concreta.
  // Se cuelga del final de MsgLabel, cuya altura Inno ya ha ajustado al texto
  // (AdjustLabelHeight), para que siga en su sitio si ese texto cambia.
  CleanPatchedLabel := TNewStaticText.Create(CleanInstallPage);
  with CleanPatchedLabel do
  begin
    Parent := CleanInstallPage.Surface;
    AutoSize := False;
    WordWrap := True;
    Left := 0;
    Top := CleanInstallPage.MsgLabel.Top + CleanInstallPage.MsgLabel.Height + ScaleY(12);
    Width := CleanInstallPage.SurfaceWidth;
    Caption := CustomMessage('AlreadyPatched1') + ' ' + CustomMessage('AlreadyPatched2');
    // La altura la decide el texto ya partido en lineas, que depende del ancho
    // y del tamano de fuente del sistema: con un numero fijo, el aviso se
    // recortaria en cuanto alguno de los dos cambiase.
    AdjustHeight;
    Font.Color := $0020A5DA;
    Visible := False;
  end;

  // ---- Pagina de opciones (casillas) ----
  // Cada casilla viene seguida de un texto pequeno explicando que hace.
  // El espaciado vertical es manual para que se vea aireado.
  OptionsPage := CreateCustomPage(
    CleanInstallPage.ID,
    CustomMessage('OptionsPage1'),
    CustomMessage('OptionsPage2')
  );

  OffsetY := 0;

  BordersCheckbox := TNewCheckBox.Create(OptionsPage);
  with BordersCheckbox do
  begin
    Parent := OptionsPage.Surface;
    Top := OffsetY;
    Left := 0;
    Width := OptionsPage.SurfaceWidth;
    Caption := CustomMessage('Borders1');
    Checked := False;
    OnClick := @BordersCheckboxClick;
  end;
  OffsetY := OffsetY + BordersCheckbox.Height + 4;

  HelpLabel := TNewStaticText.Create(OptionsPage);
  with HelpLabel do
  begin
    Parent := OptionsPage.Surface;
    Top := OffsetY;
    Left := 24;
    Width := OptionsPage.SurfaceWidth - 24;
    AutoSize := False;
    WordWrap := True;
    Height := ScaleY(28);
    Caption := CustomMessage('OptionsPageBordersHelp');
    Font.Color := clGrayText;
  end;
  OffsetY := OffsetY + HelpLabel.Height + 12;

  // La casilla se crea aunque este oculta, en vez de no crearla: hay dos sitios
  // que leen su estado (la exclusion mutua de BordersCheckboxClick y el
  // NextButtonClick de la pagina de opciones) y con un control nil reventarian.
  // Oculta y sin marcar, PatchDeltaQuick queda siempre en False y todas las
  // ramas de DeltaQuick se vuelven inalcanzables solas.
  DeltaQuickCheckbox := TNewCheckBox.Create(OptionsPage);
  with DeltaQuickCheckbox do
  begin
    Parent := OptionsPage.Surface;
    Top := OffsetY;
    Left := 0;
    Width := OptionsPage.SurfaceWidth;
    Caption := CustomMessage('DeltaQuick1');
    Checked := False;
    Visible := MostrarDeltaQuick;
    OnClick := @DeltaQuickCheckboxClick;
  end;

  if MostrarDeltaQuick then
  begin
    OffsetY := OffsetY + DeltaQuickCheckbox.Height + 4;

    HelpLabel := TNewStaticText.Create(OptionsPage);
    with HelpLabel do
    begin
      Parent := OptionsPage.Surface;
      Top := OffsetY;
      Left := 24;
      Width := OptionsPage.SurfaceWidth - 24;
      AutoSize := False;
      WordWrap := True;
      Height := ScaleY(28);
      Caption := CustomMessage('OptionsPageDeltaQuickHelp');
      Font.Color := clGrayText;
    end;
  end;

  GamePathPage := CreateInputDirPage(
    OptionsPage.ID,
    CustomMessage('CreateInputDirPage1'),
    CustomMessage('CreateInputDirPage2'),
    CustomMessage('CreateInputDirPage3') + #13#10 +
    CustomMessage('CreateInputDirPage4') + '"C:\Program Files (x86)\Steam\steamapps\common\DELTARUNE"',
    False, ''
  );
  GamePathPage.Add('');
  GamePathPage.Buttons[0].OnClick := @GamePathBrowseClick;

  // El mismo aviso, debajo del campo, y atento a lo que se escriba: aqui la
  // carpeta puede cambiar sin salir de la pagina.
  GamePathPatchedLabel := TNewStaticText.Create(GamePathPage);
  with GamePathPatchedLabel do
  begin
    Parent := GamePathPage.Surface;
    AutoSize := False;
    WordWrap := True;
    Left := 0;
    Top := GamePathPage.Edits[0].Top + GamePathPage.Edits[0].Height + ScaleY(12);
    Width := GamePathPage.SurfaceWidth;
    Caption := CustomMessage('AlreadyPatched1') + ' ' + CustomMessage('AlreadyPatched2');
    AdjustHeight;
    Font.Color := $0020A5DA;
    Visible := False;
  end;

  // Se engancha antes de rellenar el campo a proposito: asi la primera lectura
  // del archivo ocurre aqui, con el asistente aun abriendose, y la pagina de la
  // carpeta se muestra luego sin esperar a nada.
  GamePathPage.Edits[0].OnChange := @GamePathEditChange;

  // Se rellena con la carpeta detectada para que el usuario no tenga que
  // buscarla; si no hay ninguna, se deja la ruta habitual como pista.
  // Sin la barra final: la ruta se pasa entrecomillada al parcheador y una
  // barra antes de la comilla escaparia la comilla.
  DetectedGameLoc := FindGameLocation();
  if DetectedGameLoc <> '' then
    GamePathPage.Values[0] := RemoveBackslashUnlessRoot(DetectedGameLoc)
  else
    GamePathPage.Values[0] := ExpandConstant('{sd}\Program Files (x86)\Steam\steamapps\common\DELTARUNE');

  FinishedText := CustomMessage('FinishedText1') + #13#10#13#10 +
                  CustomMessage('FinishedText1a') + #13#10#13#10 +
                  CustomMessage('FinishedText2');

  ProgressPage := CreateOutputProgressPage(CustomMessage('ProgressPage1a'), CustomMessage('ProgressPage1b'));
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;

  if CurPageID = OptionsPage.ID then
  begin
    InstallBorders     := BordersCheckbox.Checked;
    PatchDeltaQuick    := DeltaQuickCheckbox.Checked;

    if (DetectedGameLoc = '') and (not PatchDeltaQuick) then
    begin
      MsgBox(CustomMessage('FoundGameLoc1'), mbInformation, MB_OK);
      Exit;
    end;
  end
  else if CurPageID = GamePathPage.ID then
  begin
    if (not FileExists(AddBackslash(GamePathPage.Values[0]) + DeltaruneExe)) and (not PatchDeltaQuick) then
    begin
      MsgBox(CustomMessage('FoundGameLoc2'), mbError, MB_OK);
      Result := False;
    end;
  end;
end;

function OnProgress(const ObjectName, FileName: String; const Progress, ProgressMax: Int64): Boolean;
begin
  ProgressPage.SetProgress(Progress, ProgressMax);
  Result := True;
end;

procedure DownloadToTempWithMirror(const TextHeader, MainURL, MirrorURL, FileName: String);
var
  FileSizeBytes: Integer;
  FileSizeStr: String;
  DownloadCallback: TOnDownloadProgress;
begin
  ProgressPage.SetText(TextHeader, '');
  
  try
    FileSizeBytes := DownloadTemporaryFileSize(MainURL);
  except
    FileSizeBytes := DownloadTemporaryFileSize(MirrorURL);
  end;
  
  if FileSizeBytes > 0 then
  begin
    DownloadCallback := @OnProgress;
    FileSizeStr := Format('%.2d', [FileSizeBytes / 1024 / 1024]) + CustomMessage('ProgressPage2a');
    ProgressPage.SetText(TextHeader, CustomMessage('ProgressPage2b') + FileSizeStr);
  end
  else
    DownloadCallback := nil;
  
  try
    DownloadTemporaryFile(MainURL, FileName, '', DownloadCallback);
  except
    DownloadTemporaryFile(MirrorURL, FileName, '', DownloadCallback);
  end;
end;

function HandlePatcherError(GamePath: String): Boolean;
var
  LogPath, LogText, FirstLogLine: String;
  LogTextRaw: AnsiString;
  LineEndPos: Integer;
begin
  LogPath := ExpandConstant('{src}') + '\deltapatcher-log.txt';
  
  if FileExists(LogPath) then
  begin
    if LoadStringFromFile(LogPath, LogTextRaw) then
    begin
      LogText := UTF8Decode(LogTextRaw);
      LineEndPos := Pos(#13#10, LogText);
      if (LineEndPos > 0) and (LineEndPos < 512) then
      begin
        FirstLogLine := Copy(LogText, 1, LineEndPos - 1);
        
        MsgBox(CustomMessage('FirstLogLine1') + FirstLogLine + #13#10
               + #13#10 +
               CustomMessage('FirstLogLine2') + ' "' + LogPath + '".', mbError, MB_OK);
        Result := True;
        Exit;
      end;
    end;
  end;
  
  Result := False;
end;

procedure HandleExtractionError(const ArchiveName, DestDir: String; ExceptionMsg: String);
var
  MsgParts: TArrayOfString;
  Handled: Boolean;
  (*LogPath, ErrorCodeStr: String;
  LogText: AnsiString;
  CodePos, CodeStart, CodeEnd: Integer;*)
begin
  Handled := False;

  MsgParts := StringSplit(ExceptionMsg, [': '], stAll);
  if Length(MsgParts) = 2 then
  begin
    if MsgParts[1] = '1' then
    begin
      ExceptionMsg := Format(CustomMessage('ExceptionMsg1a'), [ArchiveName]) + #1310 +
                      CustomMessage('ExceptionMsg1b') + DestDir;
      Handled := True;
    end
    else
      if MsgParts[1] = '11' then
      begin
        // TODO: extract actual error code from setup log
        (*
        LogPath := ExpandConstant('{log}');
        if LoadStringFromLockedFile(LogPath, LogText) then
        begin
          CodePos := RPos('System error code: ', LogText); // `RPos()` doesn't exist
          if CodePos > 0 then
          begin
            // Move to the start of the code
            CodeStart := CodePos + Length(SearchStr);
            // Find the end of the code (first non-digit)
            CodeEnd := CodeStart;
            while (CodeEnd <= Length(LogContents)) and (LogContents[CodeEnd] in ['0'..'9']) do
              Inc(CodeEnd);
            TempStr := Copy(LogContents, CodeStart, CodeEnd - CodeStart);
            // Convert to integer if possible
            try
              Result := StrToInt(TempStr);
            except
              // Leave as -1 if conversion fails
            end;
          end;
        end;
        *)
        
        ExceptionMsg := Format(CustomMessage('ExceptionMsg2a'), [ArchiveName]) + #13#10 +
                        + #13#10 +
                        CustomMessage('ExceptionMsg2b');
        Handled := True;
      end;
  end;
  
  if not Handled then
    RaiseException(ExceptionMsg);
  
  MsgBox(ExceptionMsg, mbCriticalError, MB_OK);
  RaiseException('empty');
end;

procedure ExtractArchive(const ArchiveFilePath, DestDir: String);
begin
  if not FileExists(ArchiveFilePath) then
    RaiseException(CustomMessage('RaiseException1') + ArchiveFilePath);
  
  try
    Extract7ZipArchive(ArchiveFilePath, DestDir, True, @OnProgress);
  except
    HandleExtractionError(ExtractFileName(ArchiveFilePath), DestDir, GetExceptionMessage());
  end;
end;

function DownloadAndExtractFiles(): Boolean;
var
  LangZipPath, ScriptsZipPath, PatcherZipPath, GamePath, PatcherPath, ExceptionMsg, ArgString, ExecErrorMsg: String;
  ResultCode: Integer;
begin
  LangZipPath    := ExpandConstant('{tmp}\lang.7z');
  ScriptsZipPath := ExpandConstant('{tmp}\scripts.7z');
  PatcherZipPath := ExpandConstant('{tmp}\DeltaPatcherCLI.7z');
  GamePath := GamePathPage.Values[0];

  ProgressPage.Show;
  try
    // ---- Pack de idioma español (LetraDelta) ----
    if FileExists(ExpandConstant('{src}\lang.7z')) then
    begin
      if MsgBox(CustomMessage('OfflineQuestion1'), mbConfirmation, MB_YESNO) = IDYES then
        CopyFile(ExpandConstant('{src}\lang.7z'), LangZipPath, False)
      else
        DownloadToTempWithMirror(CustomMessage('DownloadToTempWithMirror1'), LangURL, LangURLMirror, 'lang.7z');
    end
    else
      DownloadToTempWithMirror(CustomMessage('DownloadToTempWithMirror1'), LangURL, LangURLMirror, 'lang.7z');

    // ---- Scripts del mod (incluye Borders.csx + PNGs si --borders) ----
    if FileExists(ExpandConstant('{src}\scripts.7z')) then
    begin
      if MsgBox(CustomMessage('OfflineQuestion2'), mbConfirmation, MB_YESNO) = IDYES then
        CopyFile(ExpandConstant('{src}\scripts.7z'), ScriptsZipPath, False)
      else
        DownloadToTempWithMirror(CustomMessage('DownloadToTempWithMirror2'), ScriptsURL, ScriptsURLMirror, 'scripts.7z');
    end
    else
      DownloadToTempWithMirror(CustomMessage('DownloadToTempWithMirror2'), ScriptsURL, ScriptsURLMirror, 'scripts.7z');
  except
    MsgBox(CustomMessage('DownloadToTempWithMirror3') + GetExceptionMessage(), mbError, MB_OK);
    Result := False;
    Exit;
  end;

  try
    ProgressPage.SetText(CustomMessage('ProgressPage3a'), '');
    ExtractArchive(PatcherZipPath, ExpandConstant('{tmp}'));

    // El pack trae su subcarpeta `lang/es/`, que el mod detecta escaneando
    // `lang/*/settings.json`. El inglés original no hace falta descargarlo:
    // el propio mod lo conserva.
    ProgressPage.SetText(CustomMessage('ProgressPage3b'), '');
    ExtractArchive(LangZipPath, GamePath);

    ProgressPage.SetText(CustomMessage('ProgressPage3c'), '');
    ExtractArchive(ScriptsZipPath, ExpandConstant('{tmp}\scripts'));

    ProgressPage.SetText(CustomMessage('ProgressPage3d'), '');
    PatcherPath := ExpandConstant('{tmp}\DeltaPatcherCLI.exe');

    // Extract7ZipArchive no ha protestado, pero eso no garantiza que el .exe
    // esté ahí: un programa de seguridad puede haberlo retirado nada más
    // escribirse, y el .7z podría traer una estructura distinta a la que
    // espera esta ruta.
    // Sin esta comprobación el caso «no está» y el caso «está pero Windows no
    // lo deja arrancar» acababan los dos en el mismo mensaje sin datos.
    if not FileExists(PatcherPath) then
    begin
      MsgBox(CustomMessage('HandlePatcherError3') + #13#10 + PatcherPath + #13#10
             + #13#10 +
             CustomMessage('HandlePatcherErrorHint'), mbCriticalError, MB_OK);
      Result := False;
      Exit;
    end;

    ArgString := '';
    if PatchDeltaQuick then
      ArgString := ArgString + ' --droid';
    if InstallBorders then
      ArgString := ArgString + ' --borders';

    if Exec(PatcherPath, Format('--game "%s" --scripts "%s" --logpath "%s"%s', [GamePath, ExpandConstant('{tmp}\scripts'), ExpandConstant('{src}'), ArgString]), '', SW_SHOW, ewWaitUntilTerminated, ResultCode) then
    begin
      if ResultCode <> 0 then
      begin
        if not HandlePatcherError(GamePath) then
          MsgBox(CustomMessage('HandlePatcherError1') + IntToStr(ResultCode) + '.', mbCriticalError, MB_OK);

        Result := False;
        Exit;
      end;
    end
    else
    begin
      // Exec solo devuelve False cuando el proceso ni siquiera llega a
      // arrancar; entonces ResultCode no es el código de salida del
      // parcheador, sino el error de Windows (2 = no se encuentra,
      // 5 = acceso denegado, 225 = un programa de seguridad lo ha bloqueado).
      // SysErrorMessage lo traduce al idioma del sistema.
      ExecErrorMsg := Format(CustomMessage('HandlePatcherError2b'), [ResultCode, SysErrorMessage(ResultCode)]);

      MsgBox(CustomMessage('HandlePatcherError2') + #13#10 + ExecErrorMsg + #13#10
             + #13#10 +
             CustomMessage('HandlePatcherErrorHint'), mbCriticalError, MB_OK);
      Result := False;
      Exit;
    end;

    // El instalador NO toca la configuración ni los datos guardados del juego.
    // El mod ya arranca con el pack de idioma instalado, y escribir en
    // %LOCALAPPDATA%\DELTARUNE tiene un efecto secundario grave: Steam usa la
    // ausencia de esa carpeta como señal para restaurar las partidas desde la
    // nube, así que crearla puede dejar al jugador sin ellas. El idioma se
    // cambia desde el menú del juego.
  except
    ExceptionMsg := GetExceptionMessage();
    if ExceptionMsg <> 'empty' then
      MsgBox(CustomMessage('ExceptionMsg3') + #13#10 + GetExceptionMessage(), mbCriticalError, MB_OK);

    Result := False;
    Exit;
  finally
    ProgressPage.Hide;
  end;

  Result := True;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
    if not DownloadAndExtractFiles() then
    begin
      FinishedText := CustomMessage('FinishedText3a') + #13#10 +
                      + #13#10 +
                      CustomMessage('FinishedText3b');
    end;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = CleanInstallPage.ID then
  begin
    ForgetPatchCheck;
    UpdateCleanPageWarning;
  end
  else if CurPageID = GamePathPage.ID then
  begin
    ForgetPatchCheck;
    UpdateGamePathWarning;
  end
  else if CurPageID = wpFinished then
  begin
    WizardForm.FinishedHeadingLabel.Caption := CustomMessage('FinishedHeadingLabel1');
    WizardForm.FinishedLabel.Caption := FinishedText;
  end;
end;

procedure CloseInstaller;
begin
  ForceClose := True;
  WizardForm.Close;
end;

procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
  Confirm := not ForceClose;
end;

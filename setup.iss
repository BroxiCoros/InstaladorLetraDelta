[Setup]
AppName=LetraDelta — Instalador de la traducción de DELTARUNE
AppVersion=1.0.0
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
tr.wpWelcome4= • Traducción completa del capítulo 1
tr.wpWelcome5= • Traducción del capítulo 2 (en curso)
tr.wpWelcome6= • Traducción del capítulo 3 (en curso)
tr.wpWelcome7= • Traducción del capítulo 4 (en curso)
tr.wpWelcome9=La traducción se aplicará sobre la instalación actual del juego.
tr.wpWelcome10=Las partidas guardadas no se verán afectadas.
tr.CreateInputDirPage1=Selecciona la carpeta de DELTARUNE
tr.CreateInputDirPage2=¿Dónde está instalado el juego?
tr.CreateInputDirPage3=Selecciona la carpeta que contiene "DELTARUNE.exe" y las carpetas "chapter1_windows" ... "chapter4_windows".
tr.CreateInputDirPage4=Suele tener este aspecto: 
tr.FinishedText1=La traducción al español se ha instalado correctamente en tu equipo.
tr.FinishedText2=Pulsa «Finalizar» para salir del instalador.
tr.ProgressPage1a=Realizando la instalación
tr.ProgressPage1b=Por favor, espera...
tr.FoundGameLoc1=DELTARUNE (Capítulos 1-4) no se encontró en las carpetas predeterminadas. Indica la ruta manualmente.
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
tr.DownloadToTempWithMirror1b=Descargando archivos de idioma (inglés)...
tr.DownloadToTempWithMirror2=Descargando scripts...
tr.DownloadToTempWithMirror3=Se produjo un error al descargar los archivos: 
tr.ProgressPage3a=Descomprimiendo el parcheador...
tr.ProgressPage3b=Descomprimiendo archivos de idioma (español)...
tr.ProgressPage3b2=Descomprimiendo archivos de idioma (inglés)...
tr.ProgressPage3c=Descomprimiendo scripts...
tr.ProgressPage3d=Aplicando el parche...
tr.HandlePatcherError1=Error al aplicar el parche, código de error: 
tr.HandlePatcherError2=No se pudo iniciar el parcheador.
tr.ExceptionMsg3=Se produjo un error durante la instalación: 
tr.FinishedText3a=No se pudo instalar la traducción de DELTARUNE debido a un error.
tr.FinishedText3b=Pulsa «Finalizar» para salir del instalador.
tr.FinishedHeadingLabel1=Completando la instalación de la traducción de DELTARUNE
tr.OfflineQuestion1a=Se encontró un archivo lang_es.7z junto al instalador. ¿Usarlo en lugar de descargarlo?
tr.OfflineQuestion1b=Se encontró un archivo lang_en.7z junto al instalador. ¿Usarlo en lugar de descargarlo?
tr.OfflineQuestion2=Se encontró un archivo scripts.7z junto al instalador. ¿Usarlo en lugar de descargarlo?
tr.wpWelcome11=Si descargas previamente los archivos %s y los colocas junto a este instalador, se te preguntará si quieres usarlos en vez de descargarlos.
tr.DeltaQuick1=Aplicar la traducción a los APK de DeltaQuick (Android)
tr.Borders1=Instalar versión con bordes (NXRUNE)
tr.EnglishPack1=Instalar el idioma inglés
tr.OptionsPage1=Opciones de instalación
tr.OptionsPage2=Selecciona las opciones que apliquen a tu caso. Si no estás seguro, deja todo como está.
tr.OptionsPageEnglishHelp=Permite alternar entre español e inglés desde el menú del juego. Si no marcas esta casilla, solo estará disponible el español.
tr.OptionsPageBordersHelp=Añade los bordes decorativos de las versiones de consola. Variante visual basada en NXRUNE.
tr.OptionsPageDeltaQuickHelp=Para usuarios de Android (DeltaQuick). En este modo no se parchea el juego de escritorio.

[Files]
Source: "DeltaPatcherCLI.7z"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Code]
const
  // Pack de idioma español americano (LetraDelta).
  LangESURL       = 'https://github.com/BroxiCoros/LetraDelta/releases/download/latest/lang.7z';
  LangESURLMirror = 'https://github.com/BroxiCoros/LetraDelta/releases/download/latest/lang.7z';

  // Pack de idioma inglés (LetraDelta-EN, fork limpio de EngDeltranslatePack
  // reorganizado a estructura multi-idioma `lang/en/`).
  LangENURL       = 'https://github.com/BroxiCoros/LetraDelta-EN/releases/download/latest/lang.7z';
  LangENURLMirror = 'https://github.com/BroxiCoros/LetraDelta-EN/releases/download/latest/lang.7z';

  // Scripts del mod (DeltranslatePatch fork con etapas 1-6 + bordes integrados).
  // Los Borders.csx y los PNGs de NXRUNE viajan dentro de este mismo .7z;
  // no hay descarga adicional para la opción "con bordes".
  ScriptsURL       = 'https://github.com/BroxiCoros/DeltranslatePatch/releases/download/latest/scripts.7z';
  ScriptsURLMirror = 'https://github.com/BroxiCoros/DeltranslatePatch/releases/download/latest/scripts.7z';

  DeltaruneExe = 'DELTARUNE.exe';
var
  InfoPage: TOutputMsgWizardPage;
  OptionsPage: TWizardPage;
  GamePathPage: TInputDirWizardPage;
  ProgressPage: TOutputProgressWizardPage;

  FinishedText: String;
  ForceClose: Boolean;
  ExistingDrives: TArrayOfString;

  // Casillas de la pagina de opciones (OptionsPage). Se crean en
  // InitializeWizard y se leen al pulsar Siguiente desde esa pagina.
  EnglishPackCheckbox: TNewCheckBox;
  BordersCheckbox: TNewCheckBox;
  DeltaQuickCheckbox: TNewCheckBox;

  // Variables booleanas que reflejan el estado de las casillas tras
  // confirmar la pagina de opciones. Se consultan luego en
  // DownloadAndExtractFiles.
  InstallEnglishPack: Boolean;
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
    Result := FileExists(AddBackslash(DirPath) + 'chapter4_windows\data.win');
end;

// Search for the DELTARUNE folder
function FindGameLocation(): String;
var
  GameLocations: array[0..3] of String;
  GameLocationsLinux: array[0..1] of String;
  DrivePrefix, Location, UserName: String;
  i, j: Integer;
begin
  GameLocations[0] := '\Program Files (x86)\Steam\steamapps\common\DELTARUNE\';
  GameLocations[1] := '\Program Files (x86)\DELTARUNE\';
  GameLocations[2] := '\DELTARUNE\';
  GameLocations[3] := '\Program Files\DELTARUNE\';
  
  // Steam Deck
  GameLocationsLinux[0] := 'Z:\home\%s\.local\share\Steam\steamapps\common\DELTARUNE\';
  GameLocationsLinux[1] := 'Z:\home\%s\.var\app\com.valvesoftware.Steam\.local\share\Steam\steamapps\common\DELTARUNE\';
  UserName := GetUserNameString();

  for i := 0 to High(GameLocationsLinux) do
  begin
    Location := GameLocationsLinux[i];
    
    Result := Format(Location, ['deck']); // Default Steam Deck user name
    if CheckDeltaruneLoc(Result) then
      Exit;
    
    Result := Format(Location, [UserName]);
    if CheckDeltaruneLoc(Result) then
      Exit;
  end;
  
  Result := '';
  
  // Windows PC
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
//
// El pack de ingles SI es compatible con DeltaQuick: los archivos de
// idioma se extraen en la carpeta indicada por el usuario (la del
// juego en escritorio, la que contiene los APK en Android) y el mod
// los detecta sin distincion de plataforma. Por eso esa casilla no
// participa en la exclusion mutua.
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

procedure InitializeWizard;
var
  OffsetY: Integer;
  HelpLabel: TNewStaticText;
begin
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
    CustomMessage('wpWelcome4') + #13#10 +
    CustomMessage('wpWelcome5') + #13#10 +
    CustomMessage('wpWelcome6') + #13#10 +
    CustomMessage('wpWelcome7') + #13#10#13#10 +
    CustomMessage('wpWelcome9') + #13#10 +
    CustomMessage('wpWelcome10') + #13#10#13#10 +
    Format(CustomMessage('wpWelcome11'), ['"lang_es.7z", "lang_en.7z" y "scripts.7z"'])
  );

  // ---- Pagina de opciones (casillas) ----
  // Cada casilla viene seguida de un texto pequeno explicando que hace.
  // El espaciado vertical es manual para que se vea aireado.
  OptionsPage := CreateCustomPage(
    InfoPage.ID,
    CustomMessage('OptionsPage1'),
    CustomMessage('OptionsPage2')
  );

  OffsetY := 0;

  EnglishPackCheckbox := TNewCheckBox.Create(OptionsPage);
  with EnglishPackCheckbox do
  begin
    Parent := OptionsPage.Surface;
    Top := OffsetY;
    Left := 0;
    Width := OptionsPage.SurfaceWidth;
    Caption := CustomMessage('EnglishPack1');
    // Activado por defecto: la mayoria de usuarios prefieren conservar
    // el ingles disponible en el menu para poder alternar. Esta casilla
    // ya no se desactiva al marcar DeltaQuick: el pack de ingles es
    // compatible con el modo Android.
    Checked := True;
  end;
  OffsetY := OffsetY + EnglishPackCheckbox.Height + 4;

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
    Caption := CustomMessage('OptionsPageEnglishHelp');
    Font.Color := clGrayText;
  end;
  OffsetY := OffsetY + HelpLabel.Height + 12;

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

  DeltaQuickCheckbox := TNewCheckBox.Create(OptionsPage);
  with DeltaQuickCheckbox do
  begin
    Parent := OptionsPage.Surface;
    Top := OffsetY;
    Left := 0;
    Width := OptionsPage.SurfaceWidth;
    Caption := CustomMessage('DeltaQuick1');
    Checked := False;
    OnClick := @DeltaQuickCheckboxClick;
  end;
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

  GamePathPage := CreateInputDirPage(
    OptionsPage.ID,
    CustomMessage('CreateInputDirPage1'),
    CustomMessage('CreateInputDirPage2'),
    CustomMessage('CreateInputDirPage3') + #13#10 +
    CustomMessage('CreateInputDirPage4') + '"C:\Program Files (x86)\Steam\steamapps\common\DELTARUNE"',
    False, ''
  );
  GamePathPage.Add('');
  GamePathPage.Values[0] := ExpandConstant('{sd}\Program Files (x86)\Steam\steamapps\common\DELTARUNE');

  FinishedText := CustomMessage('FinishedText1') + #13#10 +
                  + #13#10 +
                  CustomMessage('FinishedText2');

  ProgressPage := CreateOutputProgressPage(CustomMessage('ProgressPage1a'), CustomMessage('ProgressPage1b'));

  InitExistingDrives;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
var
  FoundGameLoc: String;
begin
  Result := True;

  if CurPageID = OptionsPage.ID then
  begin
    InstallEnglishPack := EnglishPackCheckbox.Checked;
    InstallBorders     := BordersCheckbox.Checked;
    PatchDeltaQuick    := DeltaQuickCheckbox.Checked;

    FoundGameLoc := FindGameLocation();
    if (FoundGameLoc = '') and (not PatchDeltaQuick) then
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

// Establece "es_mx" como idioma por defecto en true_config.ini si la
// clave LANG_DT aún no existe. Si el usuario ya jugó con el mod y
// eligió otro idioma, lo respetamos. Esto solo cubre primer install
// (true_config.ini sin sección [LANG]) o instalaciones limpias.
procedure SetSpanishAsDefaultIfUnset;
var
  IniPath, IniDir, Existing: String;
begin
  IniPath := ExpandConstant('{localappdata}\DELTARUNE\true_config.ini');
  IniDir := ExtractFilePath(IniPath);
  if not DirExists(IniDir) then
    ForceDirectories(IniDir);

  Existing := GetIniString('LANG', 'LANG_DT', '', IniPath);
  if Existing = '' then
    SetIniString('LANG', 'LANG_DT', 'es_mx', IniPath);
end;

function DownloadAndExtractFiles(): Boolean;
var
  LangESZipPath, LangENZipPath, ScriptsZipPath, PatcherZipPath, GamePath, PatcherPath, ExceptionMsg, ArgString: String;
  ResultCode: Integer;
begin
  LangESZipPath  := ExpandConstant('{tmp}\lang_es.7z');
  LangENZipPath  := ExpandConstant('{tmp}\lang_en.7z');
  ScriptsZipPath := ExpandConstant('{tmp}\scripts.7z');
  PatcherZipPath := ExpandConstant('{tmp}\DeltaPatcherCLI.7z');
  GamePath := GamePathPage.Values[0];

  ProgressPage.Show;
  try
    // ---- Pack de idioma español (LetraDelta) ----
    if FileExists(ExpandConstant('{src}\lang_es.7z')) then
    begin
      if MsgBox(CustomMessage('OfflineQuestion1a'), mbConfirmation, MB_YESNO) = IDYES then
        CopyFile(ExpandConstant('{src}\lang_es.7z'), LangESZipPath, False)
      else
        DownloadToTempWithMirror(CustomMessage('DownloadToTempWithMirror1'), LangESURL, LangESURLMirror, 'lang_es.7z');
    end
    else
      DownloadToTempWithMirror(CustomMessage('DownloadToTempWithMirror1'), LangESURL, LangESURLMirror, 'lang_es.7z');

    // ---- Pack de idioma inglés (LetraDelta-EN) — opcional ----
    // Solo se descarga (o se busca local) si el usuario marcó la casilla
    // en la página de opciones. Si no la marcó, el juego queda con el
    // español como único idioma disponible en el menú in-game.
    if InstallEnglishPack then
    begin
      if FileExists(ExpandConstant('{src}\lang_en.7z')) then
      begin
        if MsgBox(CustomMessage('OfflineQuestion1b'), mbConfirmation, MB_YESNO) = IDYES then
          CopyFile(ExpandConstant('{src}\lang_en.7z'), LangENZipPath, False)
        else
          DownloadToTempWithMirror(CustomMessage('DownloadToTempWithMirror1b'), LangENURL, LangENURLMirror, 'lang_en.7z');
      end
      else
        DownloadToTempWithMirror(CustomMessage('DownloadToTempWithMirror1b'), LangENURL, LangENURLMirror, 'lang_en.7z');
    end;

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

    // Cada pack de idioma trae una subcarpeta `lang/<code>/` distinta,
    // así que extraer ambos sobre la misma carpeta del juego coexisten
    // sin chocar. El mod escanea `lang/*/settings.json` y los detecta.
    // El pack de inglés solo se extrae si el usuario lo solicitó.
    ProgressPage.SetText(CustomMessage('ProgressPage3b'), '');
    ExtractArchive(LangESZipPath, GamePath);

    if InstallEnglishPack then
    begin
      ProgressPage.SetText(CustomMessage('ProgressPage3b2'), '');
      ExtractArchive(LangENZipPath, GamePath);
    end;

    ProgressPage.SetText(CustomMessage('ProgressPage3c'), '');
    ExtractArchive(ScriptsZipPath, ExpandConstant('{tmp}\scripts'));

    ProgressPage.SetText(CustomMessage('ProgressPage3d'), '');
    PatcherPath := ExpandConstant('{tmp}\DeltaPatcherCLI.exe');

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
      MsgBox(CustomMessage('HandlePatcherError2'), mbCriticalError, MB_OK);
      Result := False;
      Exit;
    end;

    // Tras un parche exitoso, dejar es_mx como idioma por defecto si
    // el usuario aún no había configurado uno.
    if not PatchDeltaQuick then
      SetSpanishAsDefaultIfUnset;
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
  if CurPageID = wpFinished then
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

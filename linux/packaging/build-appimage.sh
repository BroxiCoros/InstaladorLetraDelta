#!/usr/bin/env bash
#
# Construye InstaladorLetraDelta-x86_64.AppImage.
#
# Publica el instalador gráfico (Avalonia) y el parcheador (DeltaPatcherCLI),
# los mete en un AppDir junto al icono y el .desktop, y llama a appimagetool.
#
# Se usa igual en local y en CI. Sin argumentos:
#   ./linux/packaging/build-appimage.sh
#
# El resultado queda en la carpeta Output/ de la raíz del repositorio, igual
# que hace Inno Setup con el instalador de Windows.

set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
PACKAGING_DIR="$REPO_ROOT/linux/packaging"
BUILD_DIR="$REPO_ROOT/linux/build"
APPDIR="$BUILD_DIR/AppDir"
OUTPUT_DIR="$REPO_ROOT/Output"
OUTPUT_NAME="InstaladorLetraDelta-x86_64.AppImage"

GUI_PROJECT="$REPO_ROOT/linux/InstaladorLetraDelta/InstaladorLetraDelta.csproj"
CLI_PROJECT="$REPO_ROOT/DeltaPatcherCLI/DeltaPatcher/DeltaPatcherCLI.csproj"
APKTOOL_JAR="$REPO_ROOT/DeltaPatcherCLI/DeltaPatcher/apktool.jar"

# 7-Zip oficial para Linux. Se empaqueta el binario `7zzs`, que está enlazado
# de forma totalmente estática: funciona en cualquier distribución sin
# dependencias, incluida SteamOS, donde el usuario no puede instalar paquetes.
#
# Por qué se empaqueta en vez de descomprimir desde C# con SharpCompress:
# los packs de LetraDelta son .7z sólidos con LZMA2, y en ellos el decodificador
# gestionado de SharpCompress es unas 275 veces más lento. Medido sobre los
# archivos reales, en un solo hilo: lang.7z tarda 165 s con SharpCompress
# frente a 0,6 s con 7zzs, y scripts.7z 159 s frente a 0,6 s. El resultado de
# ambos es idéntico byte a byte; el problema es solo de velocidad, pero
# convertiría la instalación en cinco minutos de barra de progreso parada.
SEVENZIP_VERSION="7z2501"
SEVENZIP_URL="https://7-zip.org/a/${SEVENZIP_VERSION}-linux-x64.tar.xz"
SEVENZIP_SHA256="4ca3b7c6f2f67866b92622818b58233dc70367be2f36b498eb0bdeaaa44b53f4"

log() { printf '\n\033[1m==> %s\033[0m\n' "$1"; }

# ---------------------------------------------------------------------------
# apktool.jar
# ---------------------------------------------------------------------------
# El .csproj del parcheador lo declara como EmbeddedResource obligatorio, pero
# no se versiona (15 MB). Si no está, se baja la última versión publicada.
if [ ! -f "$APKTOOL_JAR" ]; then
  log "Descargando apktool.jar"
  jar_url="$(curl -fsSL https://api.github.com/repos/iBotPeaches/Apktool/releases/latest \
    | grep -o '"browser_download_url": *"[^"]*apktool_[^"]*\.jar"' \
    | head -1 | cut -d'"' -f4)"
  [ -n "$jar_url" ] || { echo "No se encontró apktool_*.jar en la última release de Apktool" >&2; exit 1; }
  curl -fsSL -o "$APKTOOL_JAR" "$jar_url"
fi

# ---------------------------------------------------------------------------
# Compilación
# ---------------------------------------------------------------------------
rm -rf "$BUILD_DIR"
mkdir -p "$APPDIR/usr/bin" "$APPDIR/usr/share/applications" \
         "$APPDIR/usr/share/icons/hicolor/256x256/apps" "$OUTPUT_DIR"

log "Publicando el instalador gráfico (linux-x64)"
dotnet publish "$GUI_PROJECT" -c Release -r linux-x64 \
  --output "$APPDIR/usr/bin" --nologo -v quiet

log "Publicando DeltaPatcherCLI (linux-x64)"
# Se publica a una carpeta aparte y se copia solo el binario: el parcheador es
# de archivo único, así que no arrastra dependencias sueltas al AppDir.
dotnet publish "$CLI_PROJECT" -c Release -r linux-x64 \
  --output "$BUILD_DIR/cli" --nologo -v quiet -m:1
cp "$BUILD_DIR/cli/DeltaPatcherCLI" "$APPDIR/usr/bin/DeltaPatcherCLI"
chmod +x "$APPDIR/usr/bin/DeltaPatcherCLI"

log "Empaquetando 7-Zip ($SEVENZIP_VERSION)"
mkdir -p "$BUILD_DIR/7zip"
curl -fsSL -o "$BUILD_DIR/7zip.tar.xz" "$SEVENZIP_URL"
echo "$SEVENZIP_SHA256  $BUILD_DIR/7zip.tar.xz" | sha256sum -c - >/dev/null
tar xf "$BUILD_DIR/7zip.tar.xz" -C "$BUILD_DIR/7zip" 7zzs License.txt
cp "$BUILD_DIR/7zip/7zzs" "$APPDIR/usr/bin/7zzs"
chmod +x "$APPDIR/usr/bin/7zzs"
# 7-Zip es LGPL; su licencia viaja junto al binario.
mkdir -p "$APPDIR/usr/share/doc/7-zip"
cp "$BUILD_DIR/7zip/License.txt" "$APPDIR/usr/share/doc/7-zip/License.txt"

# ---------------------------------------------------------------------------
# Metadatos del AppDir
# ---------------------------------------------------------------------------
log "Montando el AppDir"

# El icono del repositorio está en .ico (lo usa Inno Setup). Se convierte al
# PNG de 256x256 que espera la especificación de iconos de freedesktop.
if command -v magick >/dev/null 2>&1; then
  magick "$REPO_ROOT/icon.ico" -resize 256x256 -background none -gravity center \
         -extent 256x256 "$APPDIR/letradelta.png"
elif command -v convert >/dev/null 2>&1; then
  convert "$REPO_ROOT/icon.ico" -resize 256x256 -background none -gravity center \
          -extent 256x256 "$APPDIR/letradelta.png"
else
  echo "Hace falta ImageMagick (magick o convert) para generar el icono" >&2
  exit 1
fi
cp "$APPDIR/letradelta.png" "$APPDIR/usr/share/icons/hicolor/256x256/apps/letradelta.png"

cp "$PACKAGING_DIR/letradelta.desktop" "$APPDIR/letradelta.desktop"
cp "$PACKAGING_DIR/letradelta.desktop" "$APPDIR/usr/share/applications/letradelta.desktop"

cp "$PACKAGING_DIR/AppRun" "$APPDIR/AppRun"
chmod +x "$APPDIR/AppRun"

# ---------------------------------------------------------------------------
# appimagetool
# ---------------------------------------------------------------------------
APPIMAGETOOL="$BUILD_DIR/appimagetool"
if command -v appimagetool >/dev/null 2>&1; then
  APPIMAGETOOL="$(command -v appimagetool)"
else
  log "Descargando appimagetool"
  curl -fsSL -o "$APPIMAGETOOL" \
    "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage"
  chmod +x "$APPIMAGETOOL"
fi

log "Generando el AppImage"
# --appimage-extract-and-run evita depender de FUSE, que no está disponible en
# los contenedores de CI. ARCH es obligatorio para appimagetool.
ARCH=x86_64 "$APPIMAGETOOL" --appimage-extract-and-run \
  "$APPDIR" "$OUTPUT_DIR/$OUTPUT_NAME"

chmod +x "$OUTPUT_DIR/$OUTPUT_NAME"

log "Listo: $OUTPUT_DIR/$OUTPUT_NAME"
ls -lh "$OUTPUT_DIR/$OUTPUT_NAME"

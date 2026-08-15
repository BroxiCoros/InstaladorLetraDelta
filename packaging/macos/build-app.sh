#!/usr/bin/env bash
#
# Construye InstaladorLetraDelta-<arquitectura>.dmg para macOS.
#
# Es el equivalente de packaging/linux/build-appimage.sh: publica el instalador
# gráfico (Avalonia) y el parcheador (DeltaPatcherCLI), los mete en un paquete
# .app junto al icono y el 7-Zip, y genera el .dmg que se distribuye.
#
# Solo se puede ejecutar EN macOS: hacen falta iconutil, sips, codesign y
# hdiutil, que son herramientas del sistema y no existen fuera. En CI lo corre
# el runner de macOS; en local hace falta un Mac.
#
#   ./packaging/macos/build-app.sh            # arquitectura del propio Mac
#   ./packaging/macos/build-app.sh osx-x64    # Intel
#   ./packaging/macos/build-app.sh osx-arm64  # Apple Silicon
#
# El resultado queda en Output/, igual que las otras dos plataformas.
#
# Por qué no se genera un paquete universal (las dos arquitecturas en uno):
# .NET publica un binario por arquitectura y unir a mano cada .dylib del
# runtime con lipo es frágil de mantener. Se publican dos .dmg y cada usuario
# baja el suyo; el juego, en cambio, sí es universal, así que la traducción se
# aplica igual en ambos.

set -euo pipefail

RID="${1:-}"
if [ -z "$RID" ]; then
  case "$(uname -m)" in
    arm64) RID="osx-arm64" ;;
    x86_64) RID="osx-x64" ;;
    *) echo "Arquitectura no reconocida: $(uname -m)" >&2; exit 1 ;;
  esac
fi

case "$RID" in
  osx-arm64) ARCH_NOMBRE="arm64" ;;
  osx-x64)   ARCH_NOMBRE="x64" ;;
  *) echo "RID no soportado: $RID (usa osx-arm64 u osx-x64)" >&2; exit 1 ;;
esac

if [ "$(uname -s)" != "Darwin" ]; then
  echo "Este script solo funciona en macOS: necesita iconutil, sips, codesign y hdiutil." >&2
  exit 1
fi

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
PACKAGING_DIR="$REPO_ROOT/packaging/macos"
BUILD_DIR="$REPO_ROOT/build"
APP="$BUILD_DIR/InstaladorLetraDelta.app"
OUTPUT_DIR="$REPO_ROOT/Output"
OUTPUT_NAME="InstaladorLetraDelta-$ARCH_NOMBRE.dmg"

GUI_PROJECT="$REPO_ROOT/gui/InstaladorLetraDelta.csproj"
CLI_PROJECT="$REPO_ROOT/DeltaPatcherCLI/DeltaPatcher/DeltaPatcherCLI.csproj"
APKTOOL_JAR="$REPO_ROOT/DeltaPatcherCLI/DeltaPatcher/apktool.jar"

# 7-Zip oficial para macOS. El binario `7zz` es universal (x86_64 + arm64), así
# que el mismo archivo vale para los dos paquetes.
#
# Se empaqueta en vez de descomprimir desde C# por lo mismo que en Linux: los
# packs de LetraDelta son .7z sólidos con LZMA2 y el decodificador gestionado
# de SharpCompress es unas 275 veces más lento sobre ellos.
SEVENZIP_VERSION="7z2501"
SEVENZIP_URL="https://7-zip.org/a/${SEVENZIP_VERSION}-mac.tar.xz"
SEVENZIP_SHA256="26aa75bc262bb10bf0805617b95569c3035c2c590a99f7db55c7e9607b2685e0"

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
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources" "$OUTPUT_DIR"

log "Publicando el instalador gráfico ($RID)"
dotnet publish "$GUI_PROJECT" -c Release -r "$RID" \
  --output "$APP/Contents/MacOS" --nologo -v quiet

log "Publicando DeltaPatcherCLI ($RID)"
# Se publica a una carpeta aparte y se copia solo el binario: el parcheador es
# de archivo único, así que no arrastra dependencias sueltas al paquete.
dotnet publish "$CLI_PROJECT" -c Release -r "$RID" \
  --output "$BUILD_DIR/cli" --nologo -v quiet -m:1
cp "$BUILD_DIR/cli/DeltaPatcherCLI" "$APP/Contents/MacOS/DeltaPatcherCLI"
chmod +x "$APP/Contents/MacOS/DeltaPatcherCLI"

log "Empaquetando 7-Zip ($SEVENZIP_VERSION)"
mkdir -p "$BUILD_DIR/7zip"
curl -fsSL -o "$BUILD_DIR/7zip.tar.xz" "$SEVENZIP_URL"
echo "$SEVENZIP_SHA256  $BUILD_DIR/7zip.tar.xz" | shasum -a 256 -c - >/dev/null
tar xf "$BUILD_DIR/7zip.tar.xz" -C "$BUILD_DIR/7zip" 7zz License.txt
cp "$BUILD_DIR/7zip/7zz" "$APP/Contents/MacOS/7zz"
chmod +x "$APP/Contents/MacOS/7zz"
# 7-Zip es LGPL; su licencia viaja junto al binario.
cp "$BUILD_DIR/7zip/License.txt" "$APP/Contents/Resources/Licencia-7-Zip.txt"

# ---------------------------------------------------------------------------
# Metadatos del paquete
# ---------------------------------------------------------------------------
log "Montando el paquete .app"

# La versión sale de setup.iss, que es la única fuente para las tres
# plataformas (el workflow ya comprueba que el .csproj no se desalinee).
VERSION="$(grep -o '^AppVersion=.*' "$REPO_ROOT/setup.iss" | cut -d= -f2 | tr -d '\r')"
[ -n "$VERSION" ] || { echo "No se pudo leer AppVersion de setup.iss" >&2; exit 1; }

cp "$PACKAGING_DIR/Info.plist" "$APP/Contents/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $VERSION" "$APP/Contents/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $VERSION" "$APP/Contents/Info.plist"
printf 'APPL????' > "$APP/Contents/PkgInfo"

# macOS quiere un .icns con varios tamaños dentro, que se arma desde un PNG
# grande con las herramientas del sistema.
#
# El maestro (icono-1024.png) está versionado en vez de generarse aquí desde
# icon.ico, que es lo que usa Inno Setup, por dos motivos: no depender de que
# sips sepa leer .ico, y sobre todo porque el original es pixel art de 255x255
# y ampliarlo pide vecino más próximo. Cualquier otro filtro lo emborrona. Se
# regenera con ImageMagick, desde cualquier plataforma:
#
#   magick icon.ico -filter point -resize 1024x1024 packaging/macos/icono-1024.png
log "Generando el icono"
ICONSET="$BUILD_DIR/letradelta.iconset"
mkdir -p "$ICONSET"
for tam in 16 32 64 128 256 512; do
  sips -z $tam $tam "$PACKAGING_DIR/icono-1024.png" \
       --out "$ICONSET/icon_${tam}x${tam}.png" >/dev/null
  sips -z $((tam * 2)) $((tam * 2)) "$PACKAGING_DIR/icono-1024.png" \
       --out "$ICONSET/icon_${tam}x${tam}@2x.png" >/dev/null
done
iconutil -c icns "$ICONSET" -o "$APP/Contents/Resources/letradelta.icns"

# ---------------------------------------------------------------------------
# Firma
# ---------------------------------------------------------------------------
# Se firma ad hoc (identidad "-"). No es una firma de Apple: el usuario seguirá
# viendo el aviso de Gatekeeper la primera vez y tendrá que abrirlo desde el
# menú contextual (está explicado en el README). Pero es imprescindible: en
# Apple Silicon un binario SIN NINGUNA firma no se ejecuta, lo mata el kernel.
#
# El orden importa: primero lo que va dentro, y el paquete al final. Firmar el
# .app antes que sus binarios anidados invalida el sello en cuanto se toca uno.
log "Firmando (ad hoc)"
codesign --force --sign - --timestamp=none "$APP/Contents/MacOS/7zz"
codesign --force --sign - --timestamp=none "$APP/Contents/MacOS/DeltaPatcherCLI"
find "$APP/Contents/MacOS" -name '*.dylib' -exec \
  codesign --force --sign - --timestamp=none {} \;
# Firmar el paquete firma también su ejecutable principal y sella el resto del
# contenido, así que no hace falta firmar InstaladorLetraDelta por separado.
codesign --force --sign - --timestamp=none "$APP"

# La verificación va SIN --deep a propósito. Con --deep, codesign trata cada
# .dll de .NET como código anidado que debería llevar firma propia y falla con
# "code object is not signed at all". Los .dll son ensamblados gestionados, no
# Mach-O: no se firman, van sellados como recursos del paquete, que es
# justo lo que comprueba la verificación normal.
codesign --verify --strict "$APP"
# Los binarios anidados sí son código de verdad, y esos se comprueban uno a uno.
codesign --verify --strict "$APP/Contents/MacOS/7zz"
codesign --verify --strict "$APP/Contents/MacOS/DeltaPatcherCLI"

# ---------------------------------------------------------------------------
# DMG
# ---------------------------------------------------------------------------
# Se distribuye en .dmg y no en .zip por un motivo concreto: si el usuario
# ejecuta la aplicación desde dentro del .zip descargado, macOS la lanza en una
# copia de solo lectura en /private/var/folders (App Translocation) y entonces
# no encuentra los packs que el usuario haya dejado al lado para la instalación
# sin conexión. El .dmg invita a arrastrarla fuera antes de abrirla.
log "Generando el DMG"
DMG_DIR="$BUILD_DIR/dmg"
mkdir -p "$DMG_DIR"
cp -R "$APP" "$DMG_DIR/"
ln -s /Applications "$DMG_DIR/Aplicaciones"

rm -f "$OUTPUT_DIR/$OUTPUT_NAME"
hdiutil create -volname "Instalador LetraDelta" -srcfolder "$DMG_DIR" \
  -ov -format UDZO "$OUTPUT_DIR/$OUTPUT_NAME" >/dev/null

log "Listo: $OUTPUT_DIR/$OUTPUT_NAME"
ls -lh "$OUTPUT_DIR/$OUTPUT_NAME"

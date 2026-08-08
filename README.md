# LetraDelta — Instalador

Instalador para Windows y Linux de la traducción al español americano de **DELTARUNE** (proyecto [*LetraDelta*](https://github.com/BroxiCoros/LetraDelta)). Aplica el mod [*Deltranslate*](https://github.com/BroxiCoros/DeltranslatePatch) y los archivos de idioma sobre tu copia del juego en uno o dos clics.

---

## Información general

- **Edición compatible:** [Steam](https://store.steampowered.com/app/1671210/DELTARUNE/).
- **Versión del juego compatible:** 1.04 (v17).
- **Idioma:** español americano (es_mx). El mod conserva el inglés original, así que puedes alternar entre ambos desde el menú del juego.
- **Contenido:** traducción completa de los capítulos 1 a 5.
- Las partidas guardadas no se ven afectadas por la instalación.
- La traducción intenta ser fiel a la obra original. Es apta tanto para nuevos jugadores como para quienes ya conocen el juego y quieren disfrutarlo en su idioma.
- Si encuentras cualquier error, por favor toma una captura de pantalla y comunícalo por los canales de [*LetraDelta*](https://github.com/BroxiCoros/LetraDelta).

---

## Instalación (Windows)

1. Descarga `InstaladorLetraDelta-<versión>-Windows.exe` desde la sección de [*releases*](../../releases/latest) y ejecútalo.
2. En la pantalla de bienvenida verás un resumen de lo que se va a instalar. Pulsa «Siguiente».
3. En la página de opciones, marca o desmarca las casillas según prefieras (ver «Opciones de instalación» más abajo).
4. El instalador detecta automáticamente la carpeta de *DELTARUNE* y la deja rellenada: busca en todas las bibliotecas de Steam declaradas en `libraryfolders.vdf`, así que lo encuentra aunque esté en un segundo disco, y también reconoce las rutas de Steam Deck y las ubicaciones habituales de *Program Files*. Si no lo encuentra, te pedirá la carpeta manualmente.
5. Pulsa «Instalar». El asistente descarga los archivos necesarios y aplica el parche.
6. Listo. El juego queda traducido. Puedes alternar entre español e inglés desde el menú del juego cuando quieras.

### Opciones de instalación

En la página de opciones del asistente puedes activar o desactivar una casilla:

- **Instalar versión con bordes (NXRUNE)** — variante visual que añade bordes decorativos en pantalla, basada en NXRUNE. Por defecto está desactivada y se instala la versión estándar.

### Instalación sin conexión

Si descargas previamente los archivos correspondientes y los colocas junto a `InstaladorLetraDelta.exe`, el asistente te preguntará si prefieres usar esos archivos locales en lugar de descargarlos. Los nombres esperados son:

- `lang_es.7z` — pack de español. Indispensable.
- `scripts.7z` — *scripts* del mod. Indispensable.

---

## Instalación (Linux)

En Linux *DELTARUNE* se ejecuta con Proton, pero los archivos del juego son exactamente los mismos que en Windows, así que la traducción se aplica igual y funciona igual.

1. Descarga `InstaladorLetraDelta-<versión>-Linux-x86_64.AppImage` desde la sección de [*releases*](../../releases/latest).
2. Dale permiso de ejecución. Desde el gestor de archivos: clic derecho → «Propiedades» → «Permisos» → marcar «Es ejecutable». Desde la terminal:
   ```sh
   chmod +x InstaladorLetraDelta-*.AppImage
   ```
3. Ábrelo con doble clic y sigue el asistente. Es el mismo recorrido que en Windows: bienvenida, opciones, carpeta del juego e instalación.

**No hace falta instalar nada más.** El AppImage lleva dentro todo lo que necesita, incluidos el parcheador y 7-Zip, así que funciona en cualquier distribución sin tocar el gestor de paquetes.

El instalador **detecta la carpeta del juego automáticamente**: busca en las bibliotecas de Steam declaradas en `libraryfolders.vdf`, así que encuentra el juego aunque esté en un segundo disco o en la microSD de una Steam Deck, y reconoce tanto el Steam nativo como el de Flatpak. Si no lo encuentra, puedes indicar la carpeta a mano.

El instalador **no modifica la configuración ni los datos guardados del juego**: se limita a los archivos de la carpeta de instalación. El idioma se elige desde el menú del juego.

### Steam Deck

Funciona en modo escritorio: descarga el AppImage, dale permiso de ejecución desde Dolphin y ábrelo con doble clic.

### Cómo revertir la traducción

En Steam, clic derecho sobre *DELTARUNE* → «Propiedades» → «Archivos instalados» → «Verificar la integridad de los archivos del juego». Steam restaura los archivos originales.

### Instalación sin conexión

Igual que en Windows: si dejas `lang_es.7z` o `scripts.7z` en la misma carpeta que el AppImage, el asistente te preguntará si prefieres usar esos archivos locales en lugar de descargarlos. Son los mismos nombres que en la [sección de Windows](#instalación-sin-conexión).

---

## Android (DeltaQuick)

> **No disponible por ahora.** La casilla de DeltaQuick está oculta en el instalador, así que los pasos de esta sección no se pueden seguir con la versión actual. Se documentan aquí para cuando vuelva a activarse.

Para jugar la versión traducida en Android, el flujo es algo más largo porque hay que parchear los APK que usa la app DeltaQuick. Necesitas un PC con Windows en algún momento del proceso.

> **Requisito previo:** este modo necesita Java instalado y en el PATH. Descarga el JRE para Windows desde [Adoptium](https://adoptium.net/temurin/releases) (cambia el selector de JDK a JRE, descarga el `.msi` e instálalo).

### Pasos

1. Instala la aplicación [DeltaQuick](https://play.google.com/store/apps/details?id=com.bookerpuzzle.deltaquick) en tu teléfono.
2. Copia al teléfono los archivos del juego **sin modificar** y selecciona la carpeta correspondiente desde la app.
3. Cuando termine el parcheado interno de DeltaQuick, abre el *save manager* de la app y, con el botón «Extract», extrae los archivos `.apk` de la carpeta `packs` a tu teléfono.
4. Copia esos archivos `.apk` a una carpeta de tu PC y ejecuta `InstaladorLetraDelta.exe`.
5. En la página de opciones, marca **«Aplicar la traducción a los APK de DeltaQuick (Android)»**.
6. En la siguiente página, selecciona la carpeta donde colocaste los `.apk` y completa la instalación.
7. Al terminar se habrán creado una carpeta `translated` y una carpeta `lang`. Comprime la carpeta `lang` en un archivo llamado `lang.zip`. Después, vuelve a copiar tanto el `lang.zip` como los `.apk` parcheados al teléfono.
8. En DeltaQuick, con el botón «Load files», coloca el `lang.zip` en la carpeta principal (al lado de `packs`) y los `.apk` de `translated/` de vuelta dentro de la carpeta `packs`.
9. Pulsa «START» en DeltaQuick para iniciar el juego.
10. Listo.

### Notas para Android

- Cuando salga una actualización de DeltaQuick, la app vuelve a parchear el juego automáticamente, así que cuando eso ocurra tendrás que repetir todo el proceso desde el paso 3.
- En esos casos, es buena idea borrar la carpeta `lang` desde el *save manager* de la app antes de volver a cargar la nueva, así te aseguras de que se aplica también cualquier actualización de la traducción.
- Si no quieres lidiar con esto, puedes desactivar la actualización automática de la aplicación en la Play Store.

---

## Repositorios del proyecto

- **[BroxiCoros/LetraDelta](https://github.com/BroxiCoros/LetraDelta)** — pack de español (`lang.7z`).
- **[BroxiCoros/DeltranslatePatch](https://github.com/BroxiCoros/DeltranslatePatch)** — *fork* del mod *Deltranslate* (`scripts.7z`).
- **[BroxiCoros/InstaladorLetraDelta](https://github.com/BroxiCoros/InstaladorLetraDelta)** — este repositorio.

---

## Créditos y reconocimientos

A **LazyDesman**, autor original de [*DeltaSetup*](https://github.com/Lazy-Desman/DeltaSetup) y de `DeltaPatcherCLI`, base de este instalador.

A **Neprim**, autor de [*Deltranslate*](https://github.com/Lazy-Desman/DeltranslatePatch), el mod que hace posible la localización del juego.

A **UnderminersTeam**, por [UndertaleModTool](https://github.com/UnderminersTeam/UndertaleModTool), incluido en el CLI.

A **iBotPeaches**, por [Apktool](https://github.com/iBotPeaches/Apktool), utilizado para parchear los APK de *DeltaQuick*.

A **Igor Pavlov**, por [7-Zip](https://7-zip.org/), cuyo binario para Linux viaja dentro del AppImage para descomprimir los packs.

Al equipo de [**Avalonia**](https://avaloniaui.net/), con la que está hecho el asistente gráfico de Linux.

A **BroxiCoros**, traducción y mantenimiento de *LetraDelta* y este instalador.

Y por supuesto, a **Toby Fox** y a su equipo, por crear *DELTARUNE*.

---

## Aviso legal

Este proyecto es una herramienta no oficial sin vínculo alguno con Toby Fox ni con *DELTARUNE*. No incluye archivos del juego original; para que el instalador funcione es indispensable poseer una copia legítima de *DELTARUNE*.

La traducción y este instalador no pueden venderse ni redistribuirse modificados sin el permiso de sus autores.

Se aplica el principio *as is* (tal cual): los autores no se hacen responsables de posibles errores. La ausencia de virus se ha verificado, pero no se garantiza por contrato.

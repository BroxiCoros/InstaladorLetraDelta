# LetraDelta — Instalador

Instalador para Windows, Linux y macOS de la traducción al español americano de **DELTARUNE** (proyecto [*LetraDelta*](https://github.com/BroxiCoros/LetraDelta)). Aplica el mod [*Deltranslate*](https://github.com/BroxiCoros/DeltranslatePatch) y los archivos de idioma sobre tu copia del juego en uno o dos clics.

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
3. La página «Antes de empezar» recuerda que el parche debe aplicarse sobre una copia limpia del juego. Si el instalador detecta que el archivo de datos ya está modificado, te avisa ahí mismo (ver «Aviso de copia ya modificada» más abajo).
4. En la página de opciones, marca o desmarca las casillas según prefieras (ver «Opciones de instalación» más abajo).
5. El instalador detecta automáticamente la carpeta de *DELTARUNE* y la deja rellenada: busca en todas las bibliotecas de Steam declaradas en `libraryfolders.vdf`, así que lo encuentra aunque esté en un segundo disco, y también reconoce las rutas de Steam Deck y las ubicaciones habituales de *Program Files*. Si no lo encuentra, te pedirá la carpeta manualmente.
6. Pulsa «Instalar». El asistente descarga los archivos necesarios y aplica el parche.
7. Listo. El juego queda traducido. Puedes alternar entre español e inglés desde el menú del juego cuando quieras.

### Aviso de copia ya modificada

El parche está pensado para aplicarse sobre los archivos originales del juego. Si encima ya hay otro parche, el resultado puede no funcionar como debería, y el parcheador no siempre puede avisarlo.

Para ayudar con eso, el instalador mira dentro del archivo de datos del juego y avisa si ve que ya está modificado. El aviso aparece en la página «Antes de empezar» y en la página de la carpeta, y no bloquea la instalación: solo recomienda usar «Verificar la integridad de los archivos del juego» en Steam antes de continuar, que deja el juego como recién descargado.

La comprobación no lo detecta todo, así que la ausencia de aviso no garantiza que la copia esté limpia. Está en las tres plataformas (Windows, Linux y macOS).

### Opciones de instalación

En la página de opciones del asistente puedes activar o desactivar una casilla:

- **Instalar versión con bordes (NXRUNE)** — variante visual que añade bordes decorativos en pantalla, basada en NXRUNE. Por defecto está desactivada y se instala la versión estándar.

### Instalación sin conexión

Si descargas previamente los archivos correspondientes y los colocas junto a `InstaladorLetraDelta.exe`, el asistente te preguntará si prefieres usar esos archivos locales en lugar de descargarlos. Los nombres esperados son:

- `lang.7z` — pack de español. Indispensable.
- `scripts.7z` — *scripts* del mod. Indispensable.

---

## Instalación (Linux)

En Linux *DELTARUNE* se ejecuta con Proton, pero los archivos del juego son exactamente los mismos que en Windows, así que la traducción se aplica igual y funciona igual.

1. Descarga `InstaladorLetraDelta-<versión>-Linux-x86_64.AppImage` desde la sección de [*releases*](../../releases/latest).
2. Dale permiso de ejecución. Desde el gestor de archivos: clic derecho → «Propiedades» → «Permisos» → marcar «Es ejecutable». Desde la terminal:
   ```sh
   chmod +x InstaladorLetraDelta-*.AppImage
   ```
3. Ábrelo con doble clic y sigue el asistente. Es el mismo recorrido que en Windows: bienvenida, «antes de empezar», opciones, carpeta del juego e instalación.

**No hace falta instalar nada más.** El AppImage lleva dentro todo lo que necesita, incluidos el parcheador y 7-Zip, así que funciona en cualquier distribución sin tocar el gestor de paquetes.

El instalador **detecta la carpeta del juego automáticamente**: busca en las bibliotecas de Steam declaradas en `libraryfolders.vdf`, así que encuentra el juego aunque esté en un segundo disco o en la microSD de una Steam Deck, y reconoce tanto el Steam nativo como el de Flatpak. Si no lo encuentra, puedes indicar la carpeta a mano.

El instalador **no modifica la configuración ni los datos guardados del juego**: se limita a los archivos de la carpeta de instalación. El idioma se elige desde el menú del juego.

### Steam Deck

Funciona en modo escritorio: descarga el AppImage, dale permiso de ejecución desde Dolphin y ábrelo con doble clic.

### Cómo revertir la traducción

En Steam, clic derecho sobre *DELTARUNE* → «Propiedades» → «Archivos instalados» → «Verificar la integridad de los archivos del juego». Steam restaura los archivos originales.

### Instalación sin conexión

Igual que en Windows: si dejas `lang.7z` o `scripts.7z` en la misma carpeta que el AppImage, el asistente te preguntará si prefieres usar esos archivos locales en lugar de descargarlos. Son los mismos nombres que en la [sección de Windows](#instalación-sin-conexión).

---

## Instalación (macOS)

*DELTARUNE* tiene versión nativa para Mac, y la traducción se aplica sobre ella igual que en las demás plataformas. Los archivos del juego son distintos a los de Windows (viven dentro del propio `DELTARUNE.app` y se llaman de otra forma), pero el parche que se les aplica es exactamente el mismo.

1. Descarga desde la sección de [*releases*](../../releases/latest) el archivo que corresponda a tu Mac:
   - `InstaladorLetraDelta-<versión>-macOS-arm64.dmg` — Apple Silicon (M1 y posteriores).
   - `InstaladorLetraDelta-<versión>-macOS-Intel.dmg` — Macs con procesador Intel.

   Si no sabes cuál tienes: menú Apple → «Acerca de este Mac». Si donde pone «Chip» ves algo que empieza por «Apple M», es el primero.
2. Abre el `.dmg` y **arrastra el instalador a la carpeta Aplicaciones**, como indica la ventana que aparece. Es importante: si lo abres directamente desde el `.dmg`, macOS lo ejecuta en una copia temporal de solo lectura y no encontrará los archivos que hayas dejado a su lado para la instalación sin conexión.
3. La primera vez, ábrelo con **clic derecho → «Abrir»** y confirma en el aviso. Con doble clic, macOS lo bloquea.
4. Sigue el asistente. Es el mismo recorrido que en Windows y Linux: bienvenida, opciones, carpeta del juego e instalación.

El instalador **detecta la carpeta del juego automáticamente** en la biblioteca de Steam (`~/Library/Application Support/Steam`). Si tuvieras que indicarla a mano, selecciona la carpeta **`DELTARUNE`**: el diálogo de macOS no deja entrar dentro de `DELTARUNE.app`, así que el instalador completa por su cuenta el camino hasta los archivos.

### ¿Por qué avisa de que no se puede comprobar el desarrollador?

Porque el instalador no está firmado con un certificado de Apple, que es de pago y anual. El aviso no indica que haya nada malo en el archivo: macOS lo muestra con cualquier programa que no venga de la App Store o de un desarrollador registrado. Abrirlo con clic derecho → «Abrir» la primera vez es suficiente; a partir de ahí se abre con doble clic como cualquier otra aplicación.

### Cómo revertir la traducción

Igual que en las demás plataformas: en Steam, clic derecho sobre *DELTARUNE* → «Propiedades» → «Archivos instalados» → «Verificar la integridad de los archivos del juego».

### Instalación sin conexión

Igual que en Windows y Linux: si dejas `lang.7z` o `scripts.7z` en la misma carpeta donde está el instalador (fuera del `.dmg`, ver el paso 2), el asistente te preguntará si prefieres usar esos archivos locales en lugar de descargarlos.

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

A **Igor Pavlov**, por [7-Zip](https://7-zip.org/), cuyos binarios para Linux y macOS viajan dentro del instalador para descomprimir los packs.

Al equipo de [**Avalonia**](https://avaloniaui.net/), con la que está hecho el asistente gráfico de Linux y macOS.

A **BroxiCoros**, traducción y mantenimiento de *LetraDelta* y este instalador.

Y por supuesto, a **Toby Fox** y a su equipo, por crear *DELTARUNE*.

---

## Aviso legal

Este proyecto es una herramienta no oficial sin vínculo alguno con Toby Fox ni con *DELTARUNE*. No incluye archivos del juego original; para que el instalador funcione es indispensable poseer una copia legítima de *DELTARUNE*.

La traducción y este instalador no pueden venderse ni redistribuirse modificados sin el permiso de sus autores.

Se aplica el principio *as is* (tal cual): los autores no se hacen responsables de posibles errores. La ausencia de virus se ha verificado, pero no se garantiza por contrato.

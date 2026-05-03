# LetraDelta — Instalador

Instalador para Windows de la traducción al español americano de **DELTARUNE** (proyecto [*LetraDelta*](https://github.com/BroxiCoros/LetraDelta)). Aplica el mod [*Deltranslate*](https://github.com/BroxiCoros/DeltranslatePatch) y los archivos de idioma sobre tu copia del juego en uno o dos clics.

---

## Información general

- **Edición compatible:** [Steam](https://store.steampowered.com/app/1671210/DELTARUNE/).
- **Versión del juego compatible:** 1.04 (v17).
- **Idioma:** español americano (es_mx). Opcionalmente puedes mantener también el inglés disponible.
- Las partidas guardadas no se ven afectadas por la instalación.
- La traducción intenta ser fiel a la obra original. Es apta tanto para nuevos jugadores como para quienes ya conocen el juego y quieren disfrutarlo en su idioma.
- Si encuentras cualquier error, por favor toma una captura de pantalla y comunícalo por los canales de [*LetraDelta*](https://github.com/BroxiCoros/LetraDelta).

---

## Instalación (Windows)

1. Descarga `InstaladorLetraDelta.exe` desde la sección de [*releases*](../../releases/latest) y ejecútalo.
2. En la pantalla de bienvenida verás un resumen de lo que se va a instalar. Pulsa «Siguiente».
3. En la página de opciones, marca o desmarca las casillas según prefieras (ver «Opciones de instalación» más abajo).
4. El instalador detecta automáticamente la carpeta de *DELTARUNE* en las ubicaciones habituales (Steam, Steam Deck, Program Files). Si no la encuentra, te la pedirá manualmente.
5. Pulsa «Instalar». El asistente descarga los archivos necesarios y aplica el parche.
6. Listo. El juego queda traducido. Si nunca habías configurado un idioma dentro del mod, queda fijado el español como predeterminado.

### Opciones de instalación

En la página de opciones del asistente puedes activar o desactivar tres casillas:

- **Instalar el idioma inglés** — añade el inglés como idioma seleccionable desde el menú interno del juego, junto al español. Activada por defecto, ya que conservar el idioma original suele ser lo deseado. Si la desmarcas, el juego queda únicamente en español.
- **Instalar versión con bordes (NXRUNE)** — variante visual que añade bordes decorativos en pantalla, basada en NXRUNE. Por defecto está desactivada y se instala la versión estándar.
- **Aplicar la traducción a los APK de DeltaQuick (Android)** — para usuarios de la aplicación de Android. Ver la sección «Android (DeltaQuick)» más abajo.

> Las dos últimas casillas son **mutuamente excluyentes**: la versión con bordes solo aplica al juego de escritorio (no se puede aplicar a los APK), así que si marcas una de las dos, la otra se desactiva automáticamente.
>
> El pack de inglés, en cambio, **sí es compatible con DeltaQuick**: puedes activarlo aunque vayas a parchear los APK de Android.

### Instalación sin conexión

Si descargas previamente los archivos correspondientes y los colocas junto a `InstaladorLetraDelta.exe`, el asistente te preguntará si prefieres usar esos archivos locales en lugar de descargarlos. Los nombres esperados son:

- `lang_es.7z` — pack de español. Indispensable.
- `scripts.7z` — *scripts* del mod. Indispensable.
- `lang_en.7z` — pack de inglés. Solo necesario si marcas la casilla correspondiente.

---

## Android (DeltaQuick)

Para jugar la versión traducida en Android, el flujo es algo más largo porque hay que parchear los APK que usa la app DeltaQuick. Necesitas un PC con Windows en algún momento del proceso.

> **Requisito previo:** este modo necesita Java instalado y en el PATH. Descarga el JRE para Windows desde [Adoptium](https://adoptium.net/temurin/releases) (cambia el selector de JDK a JRE, descarga el `.msi` e instálalo).

### Pasos

1. Instala la aplicación [DeltaQuick](https://play.google.com/store/apps/details?id=com.bookerpuzzle.deltaquick) en tu teléfono.
2. Copia al teléfono los archivos del juego **sin modificar** y selecciona la carpeta correspondiente desde la app.
3. Cuando termine el parcheado interno de DeltaQuick, abre el *save manager* de la app y, con el botón «Extract», extrae los archivos `.apk` de la carpeta `packs` a tu teléfono.
4. Copia esos archivos `.apk` a una carpeta de tu PC y ejecuta `InstaladorLetraDelta.exe`.
5. En la página de opciones, marca **«Aplicar la traducción a los APK de DeltaQuick (Android)»**. Si quieres conservar también el inglés, deja marcada esa otra casilla.
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
- **[BroxiCoros/LetraDelta-EN](https://github.com/BroxiCoros/LetraDelta-EN)** — pack de inglés (`lang.7z`).
- **[BroxiCoros/DeltranslatePatch](https://github.com/BroxiCoros/DeltranslatePatch)** — *fork* del mod *Deltranslate* (`scripts.7z`).
- **[BroxiCoros/InstaladorLetraDelta](https://github.com/BroxiCoros/InstaladorLetraDelta)** — este repositorio.

---

## Créditos y reconocimientos

A **LazyDesman**, autor original de [*DeltaSetup*](https://github.com/Lazy-Desman/DeltaSetup) y de `DeltaPatcherCLI`, base de este instalador.

A **Neprim**, autor de [*Deltranslate*](https://github.com/Lazy-Desman/DeltranslatePatch), el mod que hace posible la localización del juego.

A **UnderminersTeam**, por [UndertaleModTool](https://github.com/UnderminersTeam/UndertaleModTool), incluido en el CLI.

A **iBotPeaches**, por [Apktool](https://github.com/iBotPeaches/Apktool), utilizado para parchear los APK de *DeltaQuick*.

A **BroxiCoros**, traducción y mantenimiento de *LetraDelta* y este instalador.

Y por supuesto, a **Toby Fox** y a su equipo, por crear *DELTARUNE*.

---

## Aviso legal

Este proyecto es una herramienta no oficial sin vínculo alguno con Toby Fox ni con *DELTARUNE*. No incluye archivos del juego original; para que el instalador funcione es indispensable poseer una copia legítima de *DELTARUNE*.

La traducción y este instalador no pueden venderse ni redistribuirse modificados sin el permiso de sus autores.

Se aplica el principio *as is* (tal cual): los autores no se hacen responsables de posibles errores. La ausencia de virus se ha verificado, pero no se garantiza por contrato.

# Tap de Homebrew de rFirma

Cask de [rFirma](https://rfirma.sgomez.me/) para macOS en Apple Silicon (macOS 15.4 o posterior).

## Instalación

```sh
brew install --cask sgomez/rfirma/rfirma
```

rFirma no está firmada ni notarizada por Apple, y macOS la da por dañada la primera vez.
Tanto si la instalas con Homebrew como si descargas el `.dmg` de las
[Releases](https://github.com/sgomez/rfirma/releases/latest), ábrela así:

```sh
xattr -c /Applications/rfirma.app
```

## Actualizaciones

rFirma se actualiza sola desde la propia aplicación; `brew upgrade` no la toca. Como no
lleva firma de Apple, tras una actualización el llavero puede volver a pedir permiso para
usar la clave de tu certificado.

## Desinstalación

```sh
brew uninstall --cask rfirma        # la aplicación
brew uninstall --zap --cask rfirma  # y además su configuración y sus datos
```

Homebrew no toca dos cosas que rFirma instala fuera de su carpeta:

- **La CA local**, en la confianza de tu usuario: bórrala en Acceso a Llaveros, llavero
  «Inicio de sesión».
- **El manejador de `afirma://`**: si vuelves a AutoFirma, ábrela para que las sedes la usen.

El cask se actualiza solo cada día desde la última Release estable.

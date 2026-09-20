# Laboratorio 2

Proyecto reproducible en **R/RStudio** preparado para subir a GitHub.

## Estructura

- `Laboratorio_2_Completo.R`: script principal.
- `00_VERIFICAR_PROYECTO.R`: verifica archivos, carpetas y paquetes.
- `Laboratorio_2.Rproj`: proyecto de RStudio.
- `data/`: archivos de datos.
- `resultados/`: resultados generados por el script.
- `LISTA_ARCHIVOS.txt`: inventario del proyecto.

## Ejecución

1. Descarga/clona este repositorio.
2. Abre `Laboratorio_2.Rproj` en RStudio.
3. Ejecuta:

```r
source("00_VERIFICAR_PROYECTO.R")
```

4. Si la verificación es correcta, ejecuta:

```r
source("Laboratorio_2_Completo.R")
```

## Dependencias

El laboratorio utiliza funciones base de R y, cuando está disponible, `readr`.

Instalación:

```r
install.packages("readr")
```

## GitHub

Desde la carpeta raíz del proyecto:

```bash
git init
git add .
git commit -m "Laboratorio 2 completo"
git branch -M main
git remote add origin URL_DE_TU_REPOSITORIO
git push -u origin main
```

Sustituye `URL_DE_TU_REPOSITORIO` por la URL de tu repositorio de GitHub.

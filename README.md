# Laboratorio 2 — Importar datos en RStudio

**Curso:** Trabajar con datos en R  
**Profesor:** Dr. Marco A. González Tagle  
**Semestre:** Agosto–Diciembre 2026

Este repositorio reproduce el **Laboratorio 2 oficial** incluido en `Laboratorio_2.pdf`.

## Estructura

- `Laboratorio_2.pdf` — documento fuente oficial.
- `Laboratorio_2_Completo.R` — script reproducible de las Partes 1, 2 y 3.
- `00_VERIFICAR_PROYECTO.R` — comprobación de estructura y datos.
- `Laboratorio_2.Rproj` — proyecto de RStudio.
- `data/` — datos DBH del laboratorio.
- `resultados/` — figuras y resumen generados por el script.

## Ejecución

Abrir `Laboratorio_2.Rproj` en RStudio y ejecutar:

```r
source("00_VERIFICAR_PROYECTO.R")
source("Laboratorio_2_Completo.R")
```

## Paquetes

El laboratorio utiliza principalmente funciones base de R. Para los ejemplos de GitHub y Dropbox se emplean `readr` y `repmis`, respectivamente:

```r
install.packages("readr")
install.packages("repmis")
```

Las descargas externas están protegidas con `tryCatch()` para que una falla de Internet no impida ejecutar las partes locales.

## Nota de reproducibilidad

El script conserva la organización y los ejemplos del PDF. Se hicieron únicamente correcciones de nombres inconsistentes que impedirían la ejecución, por ejemplo `senacisa` → `senasica` y `mamifero` → `mamiferos`. Los cambios están documentados al inicio del script.

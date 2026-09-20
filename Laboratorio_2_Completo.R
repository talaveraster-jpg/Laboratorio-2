# ================================================================
# LABORATORIO 2: IMPORTAR DATOS EN RSTUDIO
# Trabajar con datos en R
# Dr. Marco A. González Tagle | Agosto-Diciembre 2026
# ================================================================
# Fuente: Laboratorio 2 oficial (PDF incluido como Laboratorio_2.pdf).
# El script conserva la organización de las tres partes del documento.
#
# CORRECCIONES MÍNIMAS PARA EJECUCIÓN:
# 1) El PDF usa "mamiferos" al cargar los datos y después "mamifero";
#    se usa "mamiferos" de forma consistente.
# 2) El PDF crea "senasica" y después muestra "head(senacisa)";
#    se corrige a "head(senasica)".
# 3) Las descargas externas se protegen con tryCatch para que una
#    caída de Internet no detenga las actividades locales.
# 4) Se guardan las figuras en resultados/ para reproducibilidad.
# ================================================================

options(stringsAsFactors = FALSE)

# ---------- CONFIGURACIÓN ----------
dir.create("resultados/histogramas", recursive = TRUE, showWarnings = FALSE)
dir.create("resultados/barplots", recursive = TRUE, showWarnings = FALSE)

cat("\n=== LABORATORIO 2 ===\n")
cat("Directorio de trabajo:\n")
print(getwd())

# ================================================================
# PARTE 1: IMPORTAR DATOS
# ================================================================

# 1.1 Importar desde archivo CSV
# En el PDF: trees <- read.csv("DBH_1.csv", header=TRUE)
trees <- read.csv("data/DBH_1.csv", header = TRUE)

cat("\n--- head(trees) ---\n")
print(head(trees))

# 1.2 Directorio de trabajo: ejemplos solicitados en el PDF
getwd()
# setwd("Ubicacion_del_archivo")  # Activar solo si se requiere cambiarlo.

# 1.3 Ingresar manualmente los 30 datos de Pinus pseudostrobus
dbh <- c(
  16.5, 25.3, 22.1, 17.2, 16.1, 8.1, 34.3, 5.4, 5.7, 11.2,
  24.1, 14.5, 7.7, 15.6, 15.9, 10, 17.5, 20.5, 7.8, 27.3,
  9.7, 6.5, 23.4, 8.2, 28.5, 10.4, 11.5, 14.3, 17.2, 16.8
)
print(dbh)

# 1.4 Accesar datos de Internet: Gobierno de México
url <- paste0(
  "https://repodatos.atdt.gob.mx/api_update/senasica/",
  "actividades_inspeccion_movilizacion/",
  "29_actividades-inspeccion-movilizacion.csv"
)

inspeccion <- tryCatch(
  read.csv(url),
  error = function(e) {
    message("No fue posible descargar el archivo del portal de datos: ", conditionMessage(e))
    NULL
  }
)

if (!is.null(inspeccion)) {
  cat("\n--- head(inspeccion) ---\n")
  print(head(inspeccion))
}

# El PDF muestra también la construcción del URL mediante paste0().
prof_url_2 <- paste0(
  "https://repodatos.atdt.gob.mx/api_update/senasica/",
  "actividades_inspeccion_movilizacion/",
  "29_actividades-inspeccion-movilizacion.csv"
)

senasica <- tryCatch(
  read.csv(prof_url_2),
  error = function(e) {
    message("No fue posible descargar senasica: ", conditionMessage(e))
    NULL
  }
)

# Corrección de la errata del PDF: senacisa -> senasica
if (!is.null(senasica)) {
  print(head(senasica))
}

# 1.5 Datos de URL seguras: Dropbox
# El PDF utiliza repmis::source_data().
if (requireNamespace("repmis", quietly = TRUE)) {
  conjunto <- tryCatch(
    repmis::source_data(
      "https://www.dropbox.com/s/hmsf07bbayxv6m3/cuadro1.csv?dl=1"
    ),
    error = function(e) {
      message("No fue posible descargar datos de Dropbox: ", conditionMessage(e))
      NULL
    }
  )
  if (!is.null(conjunto)) print(head(conjunto))
} else {
  message("repmis no está instalado. Para reproducir el ejemplo de Dropbox:")
  message('install.packages("repmis")')
}

# 1.6 Datos de GitHub con readr
if (requireNamespace("readr", quietly = TRUE)) {
  file_github <- paste0(
    "https://raw.githubusercontent.com/mgtagle/",
    "202_Analisis_Estadistico_2020/master/cuadro1.csv"
  )

  inventario <- tryCatch(
    readr::read_csv(file_github, show_col_types = FALSE),
    error = function(e) {
      message("No fue posible descargar el archivo de GitHub: ", conditionMessage(e))
      NULL
    }
  )

  if (!is.null(inventario)) print(head(inventario))
} else {
  message('Para ejecutar el ejemplo de GitHub con readr: install.packages("readr")')
}

# ================================================================
# PARTE 2: OPERACIONES CON LA BASE DE DATOS
# ================================================================

# Media y desviación estándar
media_dbh <- mean(trees$dbh)
sd_dbh <- sd(trees$dbh)

cat("\nMedia de DBH:\n")
print(media_dbh)

cat("\nDesviación estándar de DBH:\n")
print(sd_dbh)

# Restricciones
cat("\nNúmero de individuos con dbh < 10 cm:\n")
print(sum(trees$dbh < 10))

cat("\nIndividuos con dbh < 10 cm:\n")
print(which(trees$dbh < 10))

# Excluir parcela 2
trees.13 <- trees[!(trees$parcela == "2" | trees$parcela == 2), ]
print(trees.13)

# Submuestra dbh <= 10
trees.1 <- subset(trees, dbh <= 10)
print(head(trees.1))

cat("\nMedia muestra original:\n")
print(mean(trees$dbh))

cat("\nMedia submuestra:\n")
print(mean(trees.1$dbh))

# ================================================================
# PARTE 3: REPRESENTACIÓN GRÁFICA
# ================================================================

# 3.1 Histogramas de trees y trees.1
png("resultados/histogramas/Figura_5_histogramas_trees.png",
    width = 1800, height = 900, res = 180)
par(mfrow = c(1,2))
hist(trees$dbh, main = "Muestra original trees",
     xlab = "DBH", ylab = "Frecuencia")
hist(trees.1$dbh, main = "dbh <= 10 cm. trees.1",
     xlab = "DBH", ylab = "Frecuencia")
dev.off()

# 3.2 Datos de mamíferos
mamiferos <- tryCatch(
  read.csv("https://www.openintro.org/data/csv/mammals.csv"),
  error = function(e) {
    message("No fue posible descargar mammals.csv: ", conditionMessage(e))
    NULL
  }
)

if (!is.null(mamiferos)) {
  png("resultados/histogramas/Figura_6_histograma_total_sleep.png",
      width = 1600, height = 1200, res = 180)
  hist(mamiferos$total_sleep)
  dev.off()

  png("resultados/histogramas/Figura_7_histograma_total_sleep_personalizado.png",
      width = 1600, height = 1200, res = 180)
  hist(
    mamiferos$total_sleep,
    xlim = c(0,20), ylim = c(0,14),
    main = "Total de horas sueño de las 39 especies",
    xlab = "Horas sueño",
    ylab = "Frecuencia",
    las = 1,
    col = "navajowhite"
  )
  dev.off()
}

# 3.3 Barplot con chickwts
data("chickwts")
print(head(chickwts[c(1:2,42:43,62:64), ]))

feeds <- table(chickwts$feed)
print(feeds)

png("resultados/barplots/Figura_8_barplot_feeds.png",
    width = 1600, height = 1000, res = 180)
barplot(feeds)
dev.off()

png("resultados/barplots/Figura_9_barplot_feeds_ordenado.png",
    width = 1600, height = 1000, res = 180)
barplot(feeds[order(feeds, decreasing = TRUE)])
dev.off()

# 3.4 Gráfica final personalizada
png("resultados/barplots/Figura_10_barplot_personalizado.png",
    width = 1800, height = 1200, res = 180)
par(mar = c(7,5,4,2) + 0.1)
barplot(
  feeds[order(feeds, decreasing = TRUE)],
  main = "Frecuencias por tipos de alimentación",
  xlab = "Tipo de alimentación",
  ylab = "Número de Pollos",
  las = 2
)
dev.off()

# Guardar resumen reproducible
sink("resultados/resumen_resultados.txt")
cat("LABORATORIO 2 - RESULTADOS PRINCIPALES\n\n")
cat("Media DBH:", media_dbh, "\n")
cat("Desviación estándar DBH:", sd_dbh, "\n")
cat("Número de individuos con DBH < 10:", sum(trees$dbh < 10), "\n")
cat("Índices de individuos con DBH < 10:\n")
print(which(trees$dbh < 10))
cat("\nMedia trees.1 (DBH <= 10):", mean(trees.1$dbh), "\n")
cat("\nFrecuencias chickwts:\n")
print(feeds)
sink()

cat("\n=== LABORATORIO 2 FINALIZADO ===\n")
cat("Las figuras se encuentran en resultados/histogramas y resultados/barplots.\n")

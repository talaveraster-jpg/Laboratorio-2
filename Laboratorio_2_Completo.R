# ============================================================
# LABORATORIO 2 - PROYECTO REPRODUCIBLE EN R
# ============================================================
# Este script conserva la estructura de trabajo del laboratorio
# y agrega verificaciones para facilitar su ejecución desde
# RStudio/GitHub.
# ============================================================

# 0. CONFIGURACIÓN ---------------------------------------------------------
options(stringsAsFactors = FALSE)

# Verificación de paquetes
paquetes <- c("readr")
faltantes <- paquetes[!vapply(paquetes, requireNamespace, logical(1), quietly = TRUE)]

if (length(faltantes) > 0) {
  message("Paquetes faltantes: ", paste(faltantes, collapse = ", "))
  message("Instálalos con: install.packages(c(",
          paste(sprintf('"%s"', faltantes), collapse = ", "), "))")
}

# Directorio del proyecto
proyecto <- getwd()
message("Directorio de trabajo: ", proyecto)

# 1. DIRECTORIO Y ARCHIVOS -----------------------------------------------
getwd()
list.files()

# Si se ejecuta desde la raíz del proyecto, se localizan los datos.
archivo_dbh <- file.path("data", "DBH_1.csv")
archivo_pinus <- file.path("data", "DBH_manual_Pinus_pseudostrobus.csv")

# 2. LECTURA DE DATOS -----------------------------------------------------
if (file.exists(archivo_dbh)) {
  DBH_1 <- read.csv(archivo_dbh, header = TRUE, stringsAsFactors = FALSE)
  message("DBH_1.csv leído correctamente.")
  print(head(DBH_1))
} else {
  warning("No se encontró: ", archivo_dbh)
}

if (file.exists(archivo_pinus)) {
  DBH_manual_Pinus_pseudostrobus <-
    read.csv(archivo_pinus, header = TRUE, stringsAsFactors = FALSE)
  message("DBH_manual_Pinus_pseudostrobus.csv leído correctamente.")
  print(head(DBH_manual_Pinus_pseudostrobus))
} else {
  warning("No se encontró: ", archivo_pinus)
}

# 3. EJEMPLOS BÁSICOS -----------------------------------------------------
# Gobierno/México: construcción de texto con paste0()
texto_mexico <- paste0("México - Laboratorio 2")
print(texto_mexico)

# Ejemplo de combinación de texto
ejemplo_paste0 <- paste0("DBH_", 1:5)
print(ejemplo_paste0)

# 4. LECTURA CON readr ----------------------------------------------------
if (requireNamespace("readr", quietly = TRUE) && file.exists(archivo_dbh)) {
  DBH_readr <- readr::read_csv(archivo_dbh, show_col_types = FALSE)
  print(DBH_readr)
}

# 5. COMPROBACIONES DEL CONJUNTO DBH ------------------------------------
if (exists("DBH_1")) {
  cat("\n--- Estructura DBH_1 ---\n")
  str(DBH_1)

  cat("\n--- Dimensiones ---\n")
  print(dim(DBH_1))

  cat("\n--- Nombres de columnas ---\n")
  print(names(DBH_1))

  cat("\n--- Resumen ---\n")
  print(summary(DBH_1))
}

# 6. DATOS DE Pinus pseudostrobus ----------------------------------------
if (exists("DBH_manual_Pinus_pseudostrobus")) {
  cat("\n--- Pinus pseudostrobus ---\n")
  print(head(DBH_manual_Pinus_pseudostrobus))
  print(summary(DBH_manual_Pinus_pseudostrobus))
}

# 7. EXPORTACIÓN DE RESULTADOS -------------------------------------------
archivo_salida <- file.path("resultados", "verificacion_DBH.txt")

con <- file(archivo_salida, open = "wt")
writeLines("LABORATORIO 2 - VERIFICACIÓN DE DATOS", con)
writeLines(paste0("Directorio: ", getwd()), con)

if (exists("DBH_1")) {
  writeLines("\nDimensiones de DBH_1:", con)
  writeLines(paste(dim(DBH_1), collapse = " x "), con)
  writeLines("\nNombres de columnas:", con)
  writeLines(paste(names(DBH_1), collapse = ", "), con)
  writeLines("\nResumen:", con)
  capture.output(summary(DBH_1), file = con)
}

close(con)

message("\nLaboratorio 2 ejecutado hasta el bloque de verificación.")
message("Resultado generado en: ", archivo_salida)

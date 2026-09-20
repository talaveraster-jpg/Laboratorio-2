# ============================================================
# 00_VERIFICAR_PROYECTO.R
# Verificación previa del Laboratorio 2
# ============================================================

cat("=== VERIFICACIÓN DEL LABORATORIO 2 ===\n\n")

cat("Directorio actual:\n")
print(getwd())

directorios <- c("data", "resultados")
archivos <- c(
  "Laboratorio_2_Completo.R",
  "Laboratorio_2.Rproj",
  "README.md",
  "LISTA_ARCHIVOS.txt",
  "data/DBH_1.csv",
  "data/DBH_manual_Pinus_pseudostrobus.csv"
)

cat("\nDirectorios:\n")
for (d in directorios) {
  cat(sprintf("[%s] %s\n", if (dir.exists(d)) "OK" else "FALTA", d))
}

cat("\nArchivos:\n")
for (f in archivos) {
  cat(sprintf("[%s] %s\n", if (file.exists(f)) "OK" else "FALTA", f))
}

cat("\nPaquetes:\n")
cat(sprintf("[%s] readr\n",
            if (requireNamespace("readr", quietly = TRUE)) "OK" else "FALTA"))

cat("\n=== FIN DE VERIFICACIÓN ===\n")

# VERIFICACIÓN DEL PROYECTO - LABORATORIO 2

cat("=== VERIFICACIÓN DEL LABORATORIO 2 ===\n\n")
archivos <- c(
  "Laboratorio_2.pdf",
  "Laboratorio_2_Completo.R",
  "Laboratorio_2.Rproj",
  "README.md",
  "LISTA_ARCHIVOS.txt",
  "data/DBH_1.csv",
  "data/DBH_manual_Pinus_pseudostrobus.csv"
)

for (f in archivos) {
  cat(sprintf("[%s] %s\n", if (file.exists(f)) "OK" else "FALTA", f))
}

if (file.exists("data/DBH_1.csv")) {
  trees <- read.csv("data/DBH_1.csv")
  cat("\nRegistros DBH_1:", nrow(trees), "\n")
  cat("Columnas:", paste(names(trees), collapse=", "), "\n")
  cat("Media DBH:", mean(trees$dbh), "\n")
  cat("SD DBH:", sd(trees$dbh), "\n")
  cat("DBH < 10:", sum(trees$dbh < 10), "\n")
}

cat("\nPaquetes opcionales:\n")
cat(sprintf("readr: %s\n", requireNamespace("readr", quietly=TRUE)))
cat(sprintf("repmis: %s\n", requireNamespace("repmis", quietly=TRUE)))
cat("\n=== FIN ===\n")

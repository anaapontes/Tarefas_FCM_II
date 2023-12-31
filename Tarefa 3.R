# Lendo pacotes -----------------------------------------------------------

library(tidyverse)
library(pdftools)

# Lendo PDF ---------------------------------------------------------------

pdf <- pdf_text("cadastro.pdf")
pdf <- str_split_1(pdf, "\\n")
pdf

# Tarefa 3 ----------------------------------------------------------------

z <- pdf[grepl("CEP", pdf)] # Extraindo as linhas que possuem "CEP"
z <- gsub("^(.*?)(CEP: )", "", z) # Eliminando os caracteres antes do "CEP:", deixando só os números
z <- gsub("\\.", "", z) # Retirando o ".", para deixar no formato 00000-000
z

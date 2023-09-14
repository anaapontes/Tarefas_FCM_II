# Lendo pacotes -----------------------------------------------------------

library(tidyverse)
library(pdftools)
library(lubridate)

# Lendo PDF ---------------------------------------------------------------

pdf <- pdf_text("cadastro.pdf")
pdf <- str_split_1(pdf, "\\n")
pdf

# Tarefa 4 ----------------------------------------------------------------
endereco <- pdf[grepl("Endereço:", pdf)] # Endereço completo
endereco <- gsub("CEP.*[0-9]$", "", endereco) # Retirando o CEP
endereco <- gsub("Endereço: ", "", endereco) # Retirando o "Endereço:"
endereco <- gsub("\\.$", "", endereco) # Retirando o ponto final que tinha no [1]
endereco <- trimws(endereco, "both") # Recortando os espaços que estão sobrando
endereco

# Obtendo apenas o nome da rua:
rua <- gsub("(Endereço: |,.*)", "", endereco)
rua

# Obtendo apenas o número:
numero <- gsub("[^0-9]", "", endereco)
numero <- gsub("^$", "S/N", numero) # Adicionando sem número (S/N) aos que não tem
numero

# Obtendo apenas a cidade/planeta:
local <- gsub(".*,(.*)", "\\1", endereco)
local <- trimws(local, "both") # Recortando o espaço que está sobrando
local
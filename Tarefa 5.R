# DATASUS -----------------------------------------------------------------

# Não consegui utilizar library(read.dbc) para ler o arquivo .CNV

# Carregar pacotes necessários
library(tidyverse)  
library(lubridate)   

# Ler o conteúdo do arquivo "RACA_COR.cnv" linha por linha
dados <- readLines("RACA_COR.cnv")

# Pré-processamento dos dados

dados <- gsub("10 2 L", "ID  RAÇA/COR  CÓDIGO", dados) # Substituir "10 2 L" por "ID  RAÇA/COR  CÓDIGO" nas linhas dos dados
dados <- gsub("\xc7", "Ç", dados)      # Substituir "Ç"
dados <- gsub("<c3>", "Ã", dados)      # Substituir "Ã"
dados <- gsub("RA<c7>A\\/COR", "", dados) # Remover "RAÇA/COR" em excesso 
dados <- gsub("RAÇA/COR.*)", "INDEVIDOS", dados) # Para agrupar os "INDEVIDOS"
dados <- gsub("RAÇA/COR NÃO EXIGIDO", "NÃO EXIGIDO", dados) # Substituir "RAÇA/COR NÃO EXIGIDO" por "NÃO EXIGIDO"
dados <- gsub("1M,1G,1C,DE, D,87", "06,09,1M,1G,1C,DE,D,87", dados) # Substituir "1M,1G,1C,DE, D,87" por "06,09,1M,1G,1C,DE,D,87"
dados <- dados[-c(9, 10)] # Remover as linhas de índice 9 e 10 que já foram agrupadas nos "INDEVIDOS"

erro <- str_extract_all(dados[8], "(?<=\\d{2}).*$") # Para remover a virgula
dados[8] <- gsub(erro, "", dados[8]) # Removendo a virgula 


dados <- trimws(dados, "both") # Remover espaços em branco no início e no final das linhas

# Dividir os dados em colunas usando dois ou mais espaços como separadores
dados_divididos <- strsplit(dados, "\\s{2,}")

# Extrair as colunas "RAÇA/COR" e "CÓDIGO" (excluindo a coluna "ID")
raca_cor <- sapply(dados_divididos[-1], `[`, 2)
codigo <- sapply(dados_divididos[-1], `[`, 3)

# Criar o dataframe apenas com as colunas "RAÇA/COR" e "CÓDIGO" (sem cabeçalho)
df <- data.frame(`RAÇA/COR` = raca_cor, CÓDIGO = codigo)

# Visualizar o dataframe
print(df)

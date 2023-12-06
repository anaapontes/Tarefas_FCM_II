# Tarefa do dia 21/09
library(RSelenium)
library(wdman)      
library(tidyverse)  
library(rvest)    

# Definindo a página web e outras variáveis
wpage <- "https://emec.mec.gov.br"  # URL da página

# Inicia o servidor do Selenium e abre o Firefox
selenium(retcommand = TRUE, check = TRUE) 

# Configura o driver remoto para utilizar o navegador Firefox
remote_driver <- rsDriver(
  browser = "firefox", # Define o navegador
  port = free_port(),  # Define uma porta livre para o Selenium
  verbose = FALSE,    
  chromever = NULL  
)

# Inicializa o cliente remoto para interagir com o navegador
remDr <- remote_driver$client

# Navegar até a página inicial definida anteriormente
remDr$navigate(wpage)  # Abre a URL especificada
Sys.sleep(15)          # Aguarda 15 segundos para que a página carregue completamente

# Encontra e navega para um elemento específico na página
barra <- remDr$findElement(using = "id", "mainFrame")   # Encontra o elemento com ID "mainFrame"
hh <- barra$getElementAttribute(attrName = "src")[[1]]  # Obtém o atributo 'src' desse elemento
remDr$navigate(hh)                                      # Navega para o link obtido do 'src'
Sys.sleep(15)                                           # Aguarda 15 segundos após a navegação para garantir que a página carregue completamente

# Encontra um elemento usando o XPath e clica no botão
buttom <- remDr$findElement(using = "xpath", value = "/html/body/div[2]/div[2]/div/div[3]/ul/li[1]/a")
buttom$clickElement()  # Clica no elemento encontrado pelo XPath

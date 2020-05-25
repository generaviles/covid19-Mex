# Revisi?n de Datos de Covid 2019 
# Jonathan Keneth Rodriguez Bernal


library(readr)
library(readxl)
library(tidyverse)
library(showtext)



#Abriendo la informaci?n de la base de datos de https://www.gob.mx/salud/documentos/datos-abiertos-152127
#UptdateCOVID19MEXICO <- read_csv("UABC/Proyecto Investigaci?n CoVid-19/Datos Codi Mexico/200415COVID19MEXICO.csv")
UptdateCOVID19MEXICO <- read_csv("data/200416COVID19MEXICO.csv")
View(X200415COVID19MEXICO)

#Abriendo la informaci?nd de la base de datos 
Descriptores <- read_xlsx("UABC/Proyecto Investigaci?n CoVid-19/Datos Covid Mexico/Descriptores_0412.xlsx")
View(Descriptores)

Catalogos_0412 <- read_excel("UABC/Proyecto Investigaci?n CoVid-19/Datos Covid Mexico/Catalogos_0412.xlsx")
View(Catalogos_0412)

Descriptores_0412 <- read_excel("UABC/Proyecto Investigaci?n CoVid-19/Datos Covid Mexico/Descriptores_0412.xlsx")
View(Descriptores_0412)

# Analizando los casos reportados 
gpoEdad <- UptdateCOVID19MEXICO %>%
  mutate(GrupoEdad = cut(EDAD, breaks = c(seq(0, 80, by =10 ), Inf))) %>%
  as.data.frame()


gpoEdadCount <- gpoEdad %>%
   group_by(GrupoEdad) %>%
   summarise(count = n()) %>%
   as.data.frame()



ggplot(gpoEdadCount, aes(x = GrupoEdad, y = count)) +
  geom_bar(stat = 'identity', fill = '#0096ff', alpha = 0.5, color = '#0096ff')+
  geom_text(aes(label = count), vjust = - 0.1) +
  labs(title = "Edad de Casos Positivo, Negativo y Pendiente SARS-CoV-2",
  subtitle = 'Corte al 15 de Abril de 2020',
  caption = 'Calculado con datos oficiales publicados por Secretar?a de Salud',
  x = 'Grupos de Edad', y = 'Conteo') + theme_light() +
  theme(text = element_text(family = "avenirnext"))


#Realizando el filtraje de DATOS y renombre


  
if (UptdateCOVID19MEXICO$SEXO==1){
      rename(UptdateCOVID19MEXICO$SEXO==1, c(SEXO==1="Femenino")}



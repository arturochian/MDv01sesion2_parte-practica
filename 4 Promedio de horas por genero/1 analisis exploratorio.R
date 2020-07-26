library(readxl)
library(dplyr)
library(tidyr)

setwd("D:/ABCN/Github/MDv01sesion2_parte-practica/4 Promedio de horas por genero")
encuesta_limpia <- readxl::read_xlsx("encuesta.xlsx",sheet = "final",skip = 0) #facil
encuesta_completa <- readxl::read_xlsx("encuesta.xlsx",sheet = "Activ-Sexo-Edad-Adulto 2.30",skip = 0) # limpiar según ejemplos # reto


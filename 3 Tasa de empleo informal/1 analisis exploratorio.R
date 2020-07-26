library(readxl)
library(dplyr)
library(tidyr)

setwd("D:/ABCN/Github/MDv01sesion2_parte-practica/3 Tasa de empleo informal")
informal <- readxl::read_xlsx("peao-cuad-7.xlsx",skip = 17)
informal <- informal[complete.cases(informal$...2),]
names(informal)
names(informal)[2:12] <- c(2008:2018)
sapply(informal,class)



informal_segun_departamento<-informal %>%
  pivot_longer(-Departamento, names_to = "Periodo", values_to = "Informalidad")

# pueden hacer lo mismo para area de residencia y region natural y graficar en ggplot2. Fijarse del ejemplo BD2 de sesion 2.

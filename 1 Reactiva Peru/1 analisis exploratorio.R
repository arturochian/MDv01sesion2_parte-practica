library(readxl)
library(dplyr)
library(tidyr)
library(here)

# aquí pon la ruta exacta.
# Recuerda, entra arriba a: 1 "session", 2 "set working directory" y 3 la opción "to source file location"
setwd("D:/ABCN/Github/MDv01sesion2_parte-practica/1 Reactiva Peru")

empresas_reactiva_peru <- readxl::read_xlsx("empresas.xlsx",skip = 1)


View(empresas_reactiva_peru)
# ¿qué ves?

empresas_reactiva_peru <- empresas_reactiva_peru[complete.cases(empresas_reactiva_peru$DEPARTAMENTO),]
# ¿qué cambios has visto?

empresas_reactiva_peru <- empresas_reactiva_peru[,-1]
# ¿qué cambios has visto?

# como hacerlo en una sola linea?
empresas_reactiva_peru <- readxl::read_xlsx("empresas.xlsx",skip = 1) # cargamos de nuevo para tener la data en bruto
empresas_reactiva_peru <- empresas_reactiva_peru[complete.cases(empresas_reactiva_peru$DEPARTAMENTO),-1]
# Otra cosa!

# veamos qué tipo de data es cada uno
sapply(empresas_reactiva_peru,class)

# hay variables en formato character que no deberían ser. Las columnas 5 y 6.

empresas_reactiva_peru[,c(5,6)] <- sapply(empresas_reactiva_peru[,c(5,6)],function(x) round(as.numeric(as.character(x)),2) )

# veamos qué tipo de data es cada uno nuevamente
sapply(empresas_reactiva_peru,class)







library(readxl)
library(dplyr)
library(tidyr)

# aquí pon tu ruta exacta del archivo.
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
View(empresas_reactiva_peru)



# veamos qué tipo de data es cada uno
sapply(empresas_reactiva_peru,class)

# hay variables en formato character que no deberían ser. Las columnas 6 y 7.

empresas_reactiva_peru[,c(6,7)] <- sapply(empresas_reactiva_peru[,c(6,7)],function(x) round(as.numeric(as.character(x)),2) )

# veamos qué tipo de data es cada uno nuevamente
sapply(empresas_reactiva_peru,class)

# veamos qué sectores hay
table(empresas_reactiva_peru$SECTOR)

# veamos qué sectores hay
table(empresas_reactiva_peru$`NOMBRE ENTIDAD OTORGANTE DEL CRÉDITO`)


# hay que crear una nueva variable cobertura! hora de usar dplyr

empresas_reactiva_peru <- empresas_reactiva_peru %>%
                            mutate(nivel_cobertura = round(`MONTO COBERTURA`/`MONTO PRÉSTAMO`*100)) 

####################### usando dplyr

#### 1 ¿Cuál es el monto promedio de los préstamos otorgados por Reactiva Perú por cada banco 
####   y ordenar la data de mayor a menor?

empresas_reactiva_peru %>% # la BD!
  group_by(`NOMBRE ENTIDAD OTORGANTE DEL CRÉDITO`) %>% # agrupala segun...
  summarise(promedio_prestamos=mean(`MONTO PRÉSTAMO`))%>% # crea una nueva variable
  arrange(desc(promedio_prestamos))%>% # reordenala de mayor a menor
  View() # mira la data

#### 2 ¿Cuál es el monto promedio de los préstamos otorgados por Reactiva Perú según sector?

empresas_reactiva_peru %>%# la BD!
  group_by(SECTOR) %>% # agrupala segun...
  summarise(promedio_prestamos=mean(`MONTO PRÉSTAMO`))%>%# crea una nueva variable
  arrange(desc(promedio_prestamos))%>% # reordenala de mayor a menor
  View() # mira la data

#### 3 ¿Cuál es el monto promedio de los préstamos otorgados por Reactiva Perú según sector y banco?

empresas_reactiva_peru %>%# la BD!
  group_by(SECTOR,`NOMBRE ENTIDAD OTORGANTE DEL CRÉDITO`) %>% # agrupala segun...
  summarise(promedio_prestamos=mean(`MONTO PRÉSTAMO`))%>%# crea una nueva variable
  arrange(desc(promedio_prestamos))%>% # reordenala de mayor a menor
  View() # mira la data

#### 4 ¿Cuál es el monto promedio y número de préstamos otorgados por Reactiva Perú según sector y banco. 
####   Ordenar según números de préstamos.

empresas_reactiva_peru %>%# la BD!
  group_by(SECTOR,`NOMBRE ENTIDAD OTORGANTE DEL CRÉDITO`) %>% # agrupala segun...
  summarise(promedio_prestamos=mean(`MONTO PRÉSTAMO`),numero=n())%>%# crea una nueva variable
  arrange(desc(numero))%>% # reordenala de mayor a menor
  View() # mira la data

#### 5 Filtra las CMAC y Financieras y ¿Cuál es el monto promedio y número de préstamos otorgados por Reactiva Perú según sector y banco. 
####   Ordenar según números de préstamos.

empresas_reactiva_peru %>%# la BD!
  filter(`TIPO DE ENTIDAD OTORGANTE DEL CRÉDITO` %in% c("CMAC","FINANCIERAS") ) %>% # c() es una función para crear vectores.  
  group_by(SECTOR,`NOMBRE ENTIDAD OTORGANTE DEL CRÉDITO`) %>% # agrupala segun...
  summarise(promedio_prestamos=mean(`MONTO PRÉSTAMO`),numero=n())%>%# crea una nueva variable
  arrange(desc(numero))%>% # reordenala de mayor a menor
  View() # mira la data

#### 6 Filtra todos excepto las CMAC y Financieras y ¿Cuál es el monto promedio y número de préstamos otorgados por Reactiva Perú según sector y banco. 
####   Ordenar según números de préstamos.

empresas_reactiva_peru %>%# la BD!
  filter(!`TIPO DE ENTIDAD OTORGANTE DEL CRÉDITO` %in% c("CMAC","FINANCIERAS") ) %>% # c() es una función para crear vectores.  
  group_by(SECTOR,`NOMBRE ENTIDAD OTORGANTE DEL CRÉDITO`) %>% # agrupala segun...
  summarise(promedio_prestamos=mean(`MONTO PRÉSTAMO`),numero=n())%>%# crea una nueva variable
  arrange(desc(numero))%>% # reordenala de mayor a menor
  View() # mira la data



####################### tarea dirigida

#### 1 Filtra las CRAC, calculas los montos totales (usa sum()) y ordena según total de préstamos (variable creada) 

#### 2 ¿Cuál es el monto promedio de los préstamos otorgados por Reactiva Perú según departamento? ordenar por monto promedio

#### 3 ¿Cuál es el monto promedio y número de los préstamos otorgados por Reactiva Perú según departamento y sector? ordenar por numero de prestamos

#### 4 Filtra (1) Sector: comercio y (2) entidades financieras: No banca múltiple y calcula el monto promedio según departamento y banco y ordenar por mediana de préstamos.

#### 5 Filtra los préstamos mayores a 1000000 (un millón) con niveles de cobertura específico de 90 y 80, considerando solo 4 principales bancos del país ordenados según número de préstamos y monto total 

####################### Retos

#### 1 ¿Cuál es el sector con más préstamos totales según cada departamento? (RETO)




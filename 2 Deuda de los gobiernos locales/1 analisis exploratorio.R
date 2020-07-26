library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(plotly)

# aquí pon tu ruta exacta del archivo.
# Recuerda, entra arriba a: 1 "session", 2 "set working directory" y 3 la opción "to source file location"

setwd("D:/ABCN/Github/MDv01sesion2_parte-practica/2 Deuda de los gobiernos locales")

# son 9 excels ¿qué hacemos? sin abrir excels para copiar y pegar y acomodar la data

# limpiar un solo excel primero
# comenzamos con la de abril 2020

bd <-  readxl::read_xls("Reporte_Deuda_GRGL_30042020.xls",sheet = "Resumen",skip = 18)

View(bd)
# ¿qué ves?

bd <- bd[1:10,6:9]
names(bd) <- c("acreedor","USD","PEN","porcentaje")
bd[1,1] <- "MEF"
# ¿qué cambios has visto?
View(bd)

# veamos qué tipo de data es cada uno
sapply(bd,class)

# hay variables en formato character que no deberían ser. Todos excepto la columna 1.
bd[,-1]=sapply(bd[,-1],function(x) round(as.numeric(as.character(x)),2))

# necesitamos identificar que la bd es del 2020-04-30. Creamos la variable periodo así:
bd$periodo="2020-04-30"          

#######################################################
#ahora toca unir las datas aplicando todo.

bd2020 <-  readxl::read_xls("Reporte_Deuda_GRGL_30042020.xls",sheet = "Resumen",skip = 18)
bd2020 <- bd2020[1:11,6:9]
names(bd2020) <- c("acreedor","USD","PEN","porcentaje")
bd2020[1,1] <- "MEF"
bd2020[,-1]=sapply(bd2020[,-1],function(x) round(as.numeric(as.character(x)),2))
bd2020$periodo="2020-04-30"          

bd2019 <-  readxl::read_xls("Reporte_Deuda_GRGL_31122019.xls",sheet = "Resumen",skip = 18)
bd2019 <- bd2019[1:11,6:9]
names(bd2019) <- c("acreedor","USD","PEN","porcentaje")
bd2019[1,1] <- "MEF"
bd2019[,-1]<-sapply(bd2019[,-1],function(x) round(as.numeric(as.character(x)),2))
bd2019$periodo<-"2019-12-31"          

bd2018 <-  readxl::read_xls("Reporte_Deuda_GRGL_31122018.xls",sheet = "Resumen",skip = 18)
bd2018 <- bd2018[1:11,6:9]
names(bd2018) <- c("acreedor","USD","PEN","porcentaje")
bd2018[1,1] <- "MEF"
bd2018[,-1] <- sapply(bd2018[,-1],function(x) round(as.numeric(as.character(x)),2))
bd2018$periodo <- "2018-12-31"     
bd2018 <- bd2018[complete.cases(bd2018$USD),]


bd2017 <-  readxl::read_xls("Reporte_Deuda_GRGL_31122017.xls",sheet = "Resumen",skip = 18)
bd2017 <- bd2017[1:14,6:9]
names(bd2017) <- c("acreedor","USD","PEN","porcentaje")
bd2017[1,1] <- "MEF"
bd2017[,-1]<-sapply(bd2017[,-1],function(x) round(as.numeric(as.character(x)),2))
bd2017$periodo<-"2017-12-31"    

bd2016 <-  readxl::read_xls("Reporte_Deuda_GRGL_31122016.xls",sheet = "Resumen Cuadros",skip = 19)
bd2016 <- bd2016[1:15,7:10]
names(bd2016) <- c("acreedor","USD","PEN","porcentaje")
bd2016[1,1] <- "MEF"
bd2016[,-1]<-sapply(bd2016[,-1],function(x) round(as.numeric(as.character(x)),2))
bd2016$periodo<-"2016-12-31"    

bd2015 <-  readxl::read_xls("Reporte_Deuda_GRGL_31122015.xls",sheet = "Resumen Cuadros",skip = 19)
bd2015 <- bd2015[1:15,7:10]
names(bd2015) <- c("acreedor","USD","PEN","porcentaje")
bd2015[1,1] <- "MEF"
bd2015[,-1]<-sapply(bd2015[,-1],function(x) round(as.numeric(as.character(x)),2))
bd2015$periodo<-"2015-12-31"   

bd2014 <-  readxl::read_xls("Reporte_Deuda_GRGL_311214.xls",sheet = "Resumen Cuadros",skip = 19)
bd2014 <- bd2014[1:16,7:10]
names(bd2014) <- c("acreedor","USD","PEN","porcentaje")
bd2014[1,1] <- "MEF"
bd2014[,-1]<-sapply(bd2014[,-1],function(x) round(as.numeric(as.character(x)),2))
bd2014$periodo<-"2014-12-31"   

bd2013 <-  readxl::read_xls("Reporte_Deuda_GRGL_311213.xls",sheet = "Resumen Cuadros",skip = 19)
bd2013 <- bd2013[1:16,7:10]
names(bd2013) <- c("acreedor","USD","PEN","porcentaje")
bd2013[1,1] <- "MEF"
bd2013[,-1]<-sapply(bd2013[,-1],function(x) round(as.numeric(as.character(x)),2))
bd2013$periodo<-"2013-12-31"   

bd2012 <-  readxl::read_xls("reporte_deuda_GRGL_31122012.xls",sheet = "Resumen Cuadros",skip = 19)
bd2012 <- bd2012[1:15,7:10]
names(bd2012) <- c("acreedor","USD","PEN","porcentaje")
bd2012[1,1] <- "MEF"
bd2012[,-1]<-sapply(bd2012[,-1],function(x) round(as.numeric(as.character(x)),2))
bd2012$periodo<-"2012-12-31"   
bd2012 <- bd2012[complete.cases(bd2012$USD),]

# unimos las bd

bd <- rbind(bd2020,bd2019)
bd <- rbind(bd,bd2018)
bd <- rbind(bd,bd2017)
bd <- rbind(bd,bd2016)
bd <- rbind(bd,bd2015)
bd <- rbind(bd,bd2014)
bd <- rbind(bd,bd2013)
bd <- rbind(bd,bd2012)

# ahora una sola
# falta cambiar algunos nombres

table(bd$acreedor)
# Ejm: encontramos a Banco Pichincha como Banco Financiero y Bco. Financiero


bd<-bd %>%
        mutate(acreedor=replace(acreedor, acreedor=="Banco Financiero", "Banco Pichincha")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Bco. Financiero", "Banco Pichincha")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Banco del Crédito del Perú", "BCP")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Banco de Crédito del Perú", "BCP")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Bco. de Crédito", "BCP")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Banco de Crédito", "BCP")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="BBVA B. Continental", "BBVA")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="BBVA Banco Continental", "BBVA")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Banco Internacional del Perú", "Interbank")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Bco. Internacional del Perú", "Interbank")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Banco de la Nación", "BN")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Bco. de la Nación", "BN")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Bco. Scotiabank", "Scotiabank")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Scotiabank Perú", "Scotiabank")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Bco. de Comercio", "Banco de Comercio")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Bco. Comercio", "Banco de Comercio")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="BBVA Banco Continental - Sindicado", "Sindicado")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="BBVA Continental - Bco. Scotiabank - Sindicado", "Sindicado")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="BBVA, Scotia Y BCP Sindicado", "Sindicado")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="BBVA Continental-Scotiabank-Sindic.", "Sindicado")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Caja Metropolitano de Lima", "Caja Metropolitana de Lima")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Bco. Wiese Sudameris", "Banco Wiese Sudameris")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Bco. Agropecuario", "Banco Agropecuario")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Bco. Interamericano de Desarrollo (BID)", "Banco Interamericano de Desarrollo (BID)")) %>%
        mutate(acreedor=replace(acreedor, acreedor=="Bco. Internacional de  Reconstrucción y Fomento (BIRF)", "Banco Internacional de Reconstrucción y Fomento (BIRF)")) %>%  
        as.data.frame()

table(bd$acreedor)
# Ejm: encontramos a BCP como Banco del Crédito del Perú,  Banco de Crédito, Banco de Crédito del Perú

unique(bd$acreedor)

bd <- bd %>% select(periodo,acreedor,PEN)
bd$periodo=as.Date(bd$periodo)



####################### usando ggplot2


ggplot(bd, aes(x = periodo, y = PEN)) + 
  geom_line(aes(color = acreedor), size = 1) +
  theme_minimal()

# ¿qué vemos?
# antes del 2014 estaba en otro formato los numéricos.


bd3<- bd %>% filter(periodo>"2013-01-01",!acreedor=="Total")

ggplot(bd3, aes(x = periodo, y = PEN)) + 
  geom_line(aes(color = acreedor), size = 1) +
  theme_minimal()
ggplotly()


bd<-bd %>% mutate(PEN = case_when(periodo == "2012-12-31"  ~ PEN/1000,
                              TRUE ~ PEN)) # casewhen es una funcion de dplyr lo volvemos millones en el 2012.

ggplot(bd, aes(x = periodo, y = PEN)) + 
  geom_line(aes(color = acreedor), size = 1) +
  theme_minimal()
ggplotly()

library(readxl)
library(dplyr)
library(tidyr)
setwd("D:/ABCN/Github/MDv01sesion2_parte-practica/5 Replicación de paper")
data <-read_feather("pt_replication_modified_exclusions_data.feather")

data2<-data  %>%
  group_by(Country,Sample) %>%
  summarise(n=n()) %>%
  pivot_wider(names_from = Sample,values_from = n,values_fill = list(n = 0)) %>%
  mutate(Total_n=Direct+Paid) %>%
  arrange(desc(Total_n))

View(data2)


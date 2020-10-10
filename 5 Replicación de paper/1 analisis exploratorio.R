library(readxl)
library(dplyr)
library(tidyr)
library(feather)

# paper https://www.nature.com/articles/s41562-020-0886-x
# BD https://osf.io/esxc4/
setwd("D:/ABCN/Github/MDv01sesion2_parte-practica/5 Replicación de paper")
data <-read_feather("pt_replication_modified_exclusions_data.feather")

data2<-data  %>%
  group_by(Country,Sample) %>%
  summarise(n=n()) %>%
  pivot_wider(names_from = Sample,values_from = n,values_fill = list(n = 0)) %>%
  mutate(Total_n=Direct+Paid) %>%
  arrange(desc(Total_n))

View(data2)


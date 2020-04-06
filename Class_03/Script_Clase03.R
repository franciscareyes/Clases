###Class 03 - Data Management & Visualization###
## Author: Esteban Lopez
## Course: Spatial Analytics 
## Program: Master in Business Analytics
## Institution: Universidad Adolfo Ibáñez


#---- Part 1: Data Management  -------------------

# Reading an exporting data

library(readxl)
library(data.table)

read_excel(path = "Class_02/") #Para hacer que aparezcan los archivos hay que apretar tabs

#Variable que margina es la edad, ya que es la variable que no se repite.

casos<-data.table(read_excel("Class_02/2020-03-17-Casos-confirmados.xlsx",na = "—",trim_ws = TRUE,col_names = TRUE),stringsAsFactors = FALSE)
#trim_ws: espacios en blanco que los elimine, col_names: el nombre de las columnas, stringsAsfactores: si hay una variable que sea string que nos las pase, lo ideal es poner false para que no asigne numeros a los valores y uno pueda analizar primero los datos.

casos[,table(Región)] #PAra ver cuantos casos hay por región
casos[,.N,by=.(Región)]#Otra forma de hacerlo

casosRM<-casos[Región=="Metropolitana",]
#Filtro por casos de región metroplitana

###### Exportar datos

saveRDS(casos,"Class_03/casosRM.rds") #para guardar la base de datos en una parte.

write.csv(casos,file = 'Class_03/CasosCovid_RM.csv',fileEncoding = 'UTF-8') #Es más liviano para trasnportar


writexl::write_xlsx #Para escribir una excel, los :: significa que uno puede entrar a ver las variables de la base de datos


casos<-data.table(read_excel("Class_02/2020-03-17-Casos-confirmados.xlsx",na = "—",trim_ws = TRUE,col_names = TRUE),stringsAsFactors = FALSE)

names(casos)
casos<-casos[Región=="Metropolitana",]

saveRDS(casos,"Class_03/casosRM.rds")

write.csv(casos,file = 'Class_03/CasosCovid_RM.csv',fileEncoding = 'UTF-8')

writexl::write_xlsx(casos,path = "Class_03/CasosenExcel.xlsx")


library(foreign)

write.dta


casosRM<-fread("Class_03/CasosCovid_RM.csv",header = T, showProgress = T,data.table = T) #fread sirve para leer datos muy pesados



casosRM<-fread("Class_03/CasosCovid_RM.csv",header = T, showProgress = T,data.table = T)


casosRM[,table(Sexo)]
casosRM[Sexo=="Fememino",Sexo:="Femenino"] #reemplazare el nombre


# Creating (factor) variables, variables de tipo string, tienen leyendas asociadas
#Nos ayuda a convertir y manipular variables dentro de un data frame que tiene etiquetas

class(casosRM$Sexo)

casosRM[,Sexo:=factor(Sexo)]

head(casosRM$Sexo)
head(as.numeric(casosRM$Sexo))

levels(casosRM$Sexo)
labels(casosRM$Sexo)

table(casosRM$Sexo)
casosRM[,.N,by=.(Sexo)]
casosRM[,.N,by=.(Sexo,`Centro de salud`)] #crea una columna N en donde suma a los Masculinos y Femeninos por clinica.

#Collapsing by Centro de Salud , sumar las observaciones que uno tiene y quiere sumar.

objeto1<-casosRM[,sum(`Casos confirmados`,na.rm = T),by=.(`Centro de salud`)]
objeto1
#ERROR por me suma el total de los casos 152

objeto1<-casosRM[,mean(Edad,na.rm = T),by=.(`Centro de salud`)]
objeto1[,V1/sum(V1,na.rm=T)] #Le agrego a objeto 1 esta parte
#collapsing lo que hace es consolidar una base de datos, va a juntar todas las clinicas los andes  y va a arrojar el promedi de edades.


names(casosRM)
obj1<-casosRM[,.N,by=.(`Centro de salud`)] #.N es el orador para que me cuente por centro de salud, cuantos casos hay por centro de salud
names(casosRM)

obj1[,sum(N,na.rm = T)] #Cuenta cuantos casos(N) hay.

obj1[,N/sum(N,na.rm=T)] #me da la proporción de casos

obj1[,porc:=N/sum(N,na.rm = T)] #Crea una variable que se llama porcentajes, esta variable esta dentro del objeto 1, por eso no imprime nada.

###Ocupar .N en vez de la suma pq asi me va a sumar por casos no por la cantidad de casos confirmados, N cuenta cada linea

# collapsing (colapsar) by average age

A<-casosRM[,.(AvAge=mean(Edad,na.rm = T)),by=.(`Centro de salud`)]
#Se lee: la media de edad con una variable AvAge, por centro de salud

B<-casosRM[,.(Total_centro=.N),by=.(`Centro de salud`)]

C<-casosRM[Sexo=="Femenino",.(Total_Centro_Mujeres=.N),by=.(`Centro de salud`)] #Caso de las mujeres por centro

D<-casosRM[Sexo=="Masculino",.(Total_Centro_Hombres=.N),by=.(`Centro de salud`)] #Caso de las hombres por centro

dim(A)
dim(B)
dim(C)
dim(D)

casosRM[,.N,by=.(`Centro de salud`)]


#merging data sets
#MERGE vincular dos bases de datos con una variable clave( como ABCD)

AB_Fake<-cbind(A,B$Total_centro) #Problema de esto esq asume que van a estar en el mismo orden

AB<-merge(A,B,by = "Centro de salud",all = T,sort = F) #Juntar la variable A y B con esta variable clave que es centro de salud. 
                                       #all: se quede con todos los datos, sort: que reorganice la base de datos en este caso no

ABC<-merge(AB,C,by = "Centro de salud",all = T,sort = F)
ABCD<-merge(ABC,D,by = "Centro de salud",all = T,sort = F)
#Merge es bueno pr lo genera en base a cada fila

ABCD[,porc_mujeres:=Total_Centro_Mujeres/Total_centro] #Sacar porcentajes de las variables

####### RESHAPING, para cambiar el formato de la base de datos, puede ser formato ancho para alado, o largo que es el tipico

E<-casosRM[,.(AvAge=mean(Edad,na.rm = T),`Casos confirmados`=.N),by=.(`Centro de salud`,Sexo)]

#Cambiar la posicion de los datos 
#DIRECTION: WIDE --> posicion ancha, la tenemos larga
#IDVAR--> la varaibale que yo quiero que se quede fija
#timevar la que tiene 1 o 0

G<-reshape(E,direction = 'wide',timevar = 'Sexo',v.names = c('AvAge','Casos confirmados'),idvar = 'Centro de salud')

#---- Part 2: Visualization  -------------------

#Scatter plot
  #Base R 
plot(G$`Casos confirmados.Femenino`,G$`Casos confirmados.Masculino`)
text(x =G$`Casos confirmados.Femenino`,y=G$`Casos confirmados.Masculino`, G$`Centro de salud`,cex=0.5)

#ggplot2
p1<-ggplot(G,aes(x=`Casos confirmados.Femenino`,y=`Casos confirmados.Masculino`))+geom_point(aes(size=AvAge.Femenino,colour=AvAge.Masculino))+geom_text(aes(label=`Centro de salud`),size=2,check_overlap = T)
p1

#plotly
library(plotly)
ggplotly(p1)

# other useful ways to show data

#high charter
# http://jkunst.com/highcharter/index.html


#---- Part 3: Intro to Mapping  -------------------
#install.packages("chilemapas")
library(chilemapas)
library(data.table)
library(ggplot2)

zonas_censo<-data.table(censo_2017_zonas,stringsAsFactors = F)

poblacion_adulto_mayor_zonas<-zonas_censo[edad=="65 y mas",.(AdultosMayores=sum(poblacion)),by=.(geocodigo)]

zonas_valparaiso<-mapa_zonas[mapa_zonas$codigo_region=="05",]

zonas_valparaiso<-merge(zonas_valparaiso,codigos_territoriales[,c("codigo_comuna","nombre_comuna")],by="codigo_comuna",all.x=TRUE,sort=F)

zonas_valparaiso<-zonas_valparaiso[zonas_valparaiso$codigo_comuna%in%c("05101","05109"),]

zonas_valparaiso<-merge(zonas_valparaiso,poblacion_adulto_mayor_zonas,by="geocodigo",all.x=TRUE,sort=F)


#plotting
library(RColorBrewer)
paleta <- rev(brewer.pal(n = 9,name = "Reds"))


ggplot(zonas_valparaiso) + 
  geom_sf(aes(fill = AdultosMayores, geometry = geometry)) +
  scale_fill_gradientn(colours = rev(paleta), name = "Poblacion\nadulto mayor") +
  labs(title = "Poblacion de 65 años y más", subtitle = "Valparaíso y Viña del Mar") +
  theme_minimal(base_size = 11)

# creating a fake spatial distribution of adult population in space
zonas_valparaiso2<-cbind(zonas_valparaiso[,c("geocodigo","codigo_comuna","codigo_provincia","codigo_region","geometry")],"AdultosMayores"=sample(zonas_valparaiso$AdultosMayores,size = length(zonas_valparaiso$AdultosMayores)))


ggplot(zonas_valparaiso2) + 
  geom_sf(aes(fill = AdultosMayores, geometry = geometry)) +
  scale_fill_gradientn(colours = rev(paleta), name = "Poblacion\nadulto mayor") +
  labs(title = "Poblacion de 65 años y más", subtitle = "Valparaíso y Viña del Mar") +
  theme_minimal(base_size = 13)

#comparing histograms of the same variable

hist(zonas_valparaiso$AdultosMayores,main = "Histograma Adultos Mayores Viña-Valpo")

hist(zonas_valparaiso2$AdultosMayores,main = "Histograma Adultos Mayores Viña-Valpo")

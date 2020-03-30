##########################################
## Class 02: Review and  Data Management
## Author: Esteban Lopez
## Course: Spatial Analytics 
## Program: Master in Business Analytics
## Institution: Universidad Adolfo Ibáñez
##########################################

#---- Part 1: Review  -------------------

#Estas son las cosas que me gustaría que les queden bien claras

### 1. Sintaxis básica

# Creación de Objetos

x<-NULL
y<-c(TRUE,FALSE)
as.numeric(y)

A<-1
years<-2010:2020
<<<<<<< HEAD
year <- seq(2010,2020, by = 0.5) #Va a aumentar de 0.5 en 0.5
tiktoc<-c("Que", "linda", "te ves", "limpiando", "Esperancita",4) #C transfomra todos los elementos al mismmo tipo
tiktoc

paste("hola","mundo",sep = " ") #separa las palabaras que uno pone en ""
paste(tiktoc, collapse = " ") #genera un string completo de la variable

m1<-matrix(1:4,2,2)
m1
m1%*%t(m1)#La traspuesta ?? creo
=======
year<- seq(2010,2020,by = 0.5)
tiktoc<-c("Que", "linda", "te ves", "limpiando", "Esperancita")

paste("Hola","Mundo",sep=" ")

paste(tiktoc,collapse = " ")

obj2<- as.numeric(c(1,2,3,4,"Esperancita"))
is.na(obj2)


numeros_en_texto<-c("1","2","3")
as.numeric(numeros_en_texto)

m1<-matrix(1:4,2,2)
m1%*%t(m1)
>>>>>>> e7713df0fe2d49a7622ff1365e81212bc9fbc88c
diag(m1)
solve(m1)


<<<<<<< HEAD
a1<-array(1:12,dim = c(2,2,3))# 2*2(filas columnas, profundidad 3)
a1

d1<-data.frame(m1) #convertir matrix en data frame
d1
data("quakes") # promise #data programas en r que vienen recargdados
=======
a1<-array(1:12,dim = c(2,2,3))

d1<-data.frame(m1)
data("quakes") # promise
>>>>>>> e7713df0fe2d49a7622ff1365e81212bc9fbc88c
d1<-data.frame(quakes)
d1

<<<<<<< HEAD
#Manipulacion de objetos
ls() #me pone en lista las variables que definimos arriba
l1<-list(Perrito=1,years,tiktoc,m1) #perrito=A solo le estoy dando el nombre de la variable, el valor de la variable se mantiene.
l1
=======
ls()

l1<-list(Perrito=A,years,tiktoc,m1)
A<-3L
>>>>>>> e7713df0fe2d49a7622ff1365e81212bc9fbc88c

A<-1L #Para que el numero sea entero
class(A) #numerica:decimales, integer:entero
typeof(A) #De que tipo son los elementos dentro del objeto y como estan guardados en general, doble significa que tiene decimales

<<<<<<< HEAD
length(years) #Largo de un objeto, de una dimension
dim(m1) #Cuando tiene dos dimensiones como por ejemplo columnas y filas. Me marca el largo

object.size(d1) #me marca el tamaño de peso, memoria de mi computador que ocupa.
=======
A<-1L

class(A)
typeof(A)

length(years)
dim(m1)

object.size(d1)
>>>>>>> e7713df0fe2d49a7622ff1365e81212bc9fbc88c

names(d1)#nombre de las variables de d1
head(d1)#cabez de la base de daros, da los 6 primeros observaciones
tail(d1)

<<<<<<< HEAD
rm(l1)#Elimina los valores
=======
rm(A)
>>>>>>> e7713df0fe2d49a7622ff1365e81212bc9fbc88c

#Bonus: como se borra todo?
rm(list=ls())

# Indexación uso de los []

length(years)
years[11]

dim(m1)
<<<<<<< HEAD
m1[2,2] #[fila,columna] me impima ese numero, si no pongo columna va a asumir que es la primera

dim(a1)
a1
a1[2,1,3] # [fila,columna, profundidad]
=======
m1[1,2]

dim(a1)
class(a1)
a1[2,1,3]
>>>>>>> e7713df0fe2d49a7622ff1365e81212bc9fbc88c

#listas
l1
l1[2]
l1[2][[1]][1:2]

<<<<<<< HEAD
class (l1[2])
class(l1[2][[1]])

l1
l1$Perrito#Para llamar a la variable y ver su valor
l1[[2]][1:2]


d1[1,] #Trabaje con todas las columnas
d1[,1] #Trabaje con todas las filas, no aparece el nombre pq asume que usted los sabe
d1[,'lat'] #Llamar la variable 
d1$mag[c(1,3,5)]
d1$mag[seq(1,16,2)]
d1$lat[1:4]
d1[1:4,c('lat','long')]#pido del 1 al 4 las variables lat y long

d1$mag>5#filtrar variable que cumpla con una resticcion
table(d1$mag>5) #conteo de cuantos false y true hay
d1[d1$mag>6,] #Utilizar la condicion para busca un indice, la coma vacia es para que nos de todas las columnas

d1$dummy_5up<-as.numeric(d1$mag>5) #crear una variable nueva con lo que recien hicimos
=======
l1[[2]][3:5]

l1$Perrito

d1[1,]
d1[,1]
d1[,'lat']
d1$mag[seq(1,16,2)]
d1$lat[1:4]

d1[,'lat']
d1[1:4,c('lat','long')]

d1$mag>5
table(d1$mag>5)
d1[d1$mag>6,'stations']

d1$dummy_5up<-as.numeric(d1$mag>5)
>>>>>>> e7713df0fe2d49a7622ff1365e81212bc9fbc88c
head(d1)

# Distinguir entre funciones, objetos, números y sintaxis básica
# Funciones: palabra + () con argumentos separados por commas
# Objetos: palabras a la izquierda del signo <- 


#---- Part 2: Loops  -------------------

A<-2

if(A==1){
  print("A es un objeto con un elemento numérico 1")
} else {
  print("A no es igual a 1, pero no se preocupe que lo hacemos")
  A<-1L
}

<<<<<<< HEAD
#For loop
=======
A<-1
class(A)
typeof(A)

dim(A)
length(A)

# For loop
>>>>>>> e7713df0fe2d49a7622ff1365e81212bc9fbc88c

for(i in 1:5){
  print(paste("Me le declaro a la ", i))
  Sys.sleep(2) 
  print("no mejor no... fail!")
  Sys.sleep(1)
}
#dormir el sistema por dos segundos Sys.sleep(2)

i<-1
eps<-50/(i^2)
while(eps>0.001){
  eps<-50/(i^2)
  print(paste("eps value es still..", eps))
  i<-i+1
}

#---- Part 3: Data Management ----
# Tres formas de trabajar con datos

### 1. R-Base 
#http://github.com/rstudio/cheatsheets/raw/master/base-r.pdf

quakes[quakes$mag>6,'mag']

by(data = quakes$mag,INDICES = quakes$stations,FUN = mean) #para que me de el promedio de las magnitudes por estacion.
tapply(X = quakes$mag,INDEX = quakes$stations, FUN = mean) #me lo imprime mas ordenado

### 2. tidyverse 
#https://rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf
library(tidyverse)
#Cómo se instala el paquete si no lo tengo? Tank!!! ayudaaaa!
#install.packages("tydiverse")

install.packages("tidyverse")

quakes %>% 
  filter(mag>6) %>% 
  select(mag) 

quakes %>% 
  group_by(stations) %>%
  summarise(mean(mag))


### 3. data.table (recommended in this course)
library(data.table)
#https://github.com/rstudio/cheatsheets/raw/master/datatable.pdf
#install.packages("data.table")
quakes<-data.table(quakes)
 
quakes[quakes$mag>6,'mag']

quakes[mag>6,]
quakes[mag>6,.(mag,depth)] #.() para hacer listas 


quakes[quakes$mag>6,'mag']

quakes[mag>6,.(mag)]

quakes[,mean(mag),by=.(stations)]

### Reading data from a file

library(readxl)

casos<-data.table(read_excel("Class_02/2020-03-17-Casos-confirmados.xlsx",na = "—",trim_ws = TRUE,col_names = TRUE),stringsAsFactors = FALSE)

casos<-casos[Región=="Metropolitana",]

library(ggplot2)

ggplot(casos[order(Edad,decreasing = T)],)+geom_bar(stat = 'identity' ,aes(x=`Centro de salud`, y=Edad/Edad, group=Sexo, fill=Edad)) + coord_flip()+ facet_wrap(~Sexo) 

casos[Sexo=="Fememino",Sexo:="Femenino"]

ggplot(casos[order(Edad,decreasing = T),])+geom_bar(stat = 'identity',aes(x=`Centro de salud` ,y=Edad/Edad,fill=Edad)) + coord_flip()+ facet_wrap(~Sexo) +labs(title = "Casos Confirmados por Sexo y Establecimiento",subtitle = "Región Metropolitana - 2020-03-17",caption = "Fuente: https://www.minsal.cl/nuevo-coronavirus-2019-ncov/casos-confirmados-en-chile-covid-19/")


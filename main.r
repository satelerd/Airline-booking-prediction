#Grupo numero X, Conformado por: Daniel Sateler, Valentina Kaufmann y Sebastian Diaz
#Carga de la data
setwd("C:/Users/sdiaz/OneDrive/Escritorio/R/Airline-booking-prediction")
data <- read.csv("ALUMNOS-trainData.csv")
data_eval <- read.csv("ALUMNOS-evalData.csv")

library(PerformanceAnalytics)
library(lattice)
library(dplyr)
library(tidyr) 
library(readxl)
library(reshape2)
library(ggplot2)
library(class)
library(kknn)


#Limpieza del data set

head(data)
data <- data[,-2]
data <- data[,-3]
data <- data[,-3]
data <- data[,-16]
#Eliminamos columnas no numericas

corr_mat <- round(cor(data),2)

# reduce the size of correlation matrix
melted_corr_mat <- melt(corr_mat)
ggplot(data = melted_corr_mat, aes(x=Var1, y=Var2,
                                   fill=value)) +
  geom_tile() +
  geom_text(aes(Var2, Var1, label = value),
            color = "black", size = 4)
#Habiendo hecho el heatmap detectamos que para los noshow, la correlacion es repartida por lo que en
#este caso convendria eliminar sol unas cuantas 
#Ahora se creara la variable Key, la cual sera booleana con el fin de designar si es que cumple con tener noshow 
#Mayor a 4 entonces valdra 1, en caso contrario valdra 0 
data <- mutate(data, Key = ifelse(noshow >= 4,1,0))
#Procedemos a crear bases para los modelos
set.seed(3)
n <- nrow(data)
sample <- sample(n,n*0.9)
data_train <- data[sample,]
data_test <- data[-sample,]
#Regresion Logistica 
model <- lm(data_train$Key ~ ., data_train)
#We predict the data_test
predictions <- predict(model, data_test)
#We calculate the matrix of confusion
confusion_matrix <- table(data_test$Key, predictions)
#We show de confusion matrix
show(confusion_matrix)
#We calculate the accuracy
accuracy <- sum(diagonal(confusion_matrix))/sum(confusion_matrix)
#We calculate the precision
precision <- confusion_matrix[1,1]/(confusion_matrix[1,1]+confusion_matrix[1,2])
#We calculate the recall
recall <- confusion_matrix[1,1]/(confusion_matrix[1,1]+confusion_matrix[2,1])
#We calculate the F1 score
f1_score <- 2*(precision*recall)/(precision+recall)

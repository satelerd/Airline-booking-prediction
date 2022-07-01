# Minería de Datos / 2022-01
# Prediciendo sobreventa de asientos en industria Aérea
# Grupo numero 7
# Conformado por: Daniel Sateler, Valentina Kaufmann y Sebastian Diaz


# Carga de la data
setwd("C:/Users/sdiaz/OneDrive/Escritorio/R/Airline-booking-prediction")
data <- read.csv("ALUMNOS-trainData.csv")
data_eval <- read.csv("ALUMNOS-evalData.csv")

# Importamos las librerias necesarias
library(PerformanceAnalytics)
library(lattice)
library(dplyr)
library(tidyr) 
library(readxl)
library(reshape2)
library(ggplot2)
library(class)
library(naivebayes)
library(kknn)


# LIMPIEZA DE LA DATA
head(data)
data <- data[,-2]
data <- data[,-3]
data <- data[,-3]
data <- data[,-16]
data <- data[,-2]

data_eval <- data_eval[,-2]
data_eval <- data_eval[,-3]
data_eval <- data_eval[,-3]
data_eval <- data_eval[,-16]
data_eval <- data_eval[,-2]

# Eliminamos columnas no numericas
corr_mat <- round(cor(data),2)

# Reduce el tamaño de la matriz de correlacion
melted_corr_mat <- melt(corr_mat)
ggplot(data = melted_corr_mat, aes(x=Var1, y=Var2, fill=value)) + geom_tile() + geom_text(aes(Var2, Var1, label = value), color = "black", size = 4)

# Habiendo hecho el heatmap detectamos que para los noshow, la correlacion es repartida por lo que en este caso convendria eliminar solo unas cuantas 
# Ahora se creara la variable Key, la cual sera booleana con el fin de designar si es que cumple con tener noshow 
# Mayor a 4 entonces valdra 1, en caso contrario valdra 0 
data <- mutate(data, Key = ifelse(noshow >= 4,1,0))

# Procedemos a crear bases para los modelos
set.seed(6)
n <- nrow(data)
sample <- sample(n,n*0.9)
data_train <- data[sample,]
data_test <- data[-sample,]
data_train$Key <- factor(data_train$Key)
data_test$Key <- factor(data_test$Key)


# MODELOS

# Primer modelo: Regresion Logistica
# ----------------------------------------
LRmodel <- lm(data_train$Key ~ ., data_train)

# Generamos las predicciones
predictions <- predict(LRmodel, data_test)

# Generamos la matriz de confusion, accuracy, precision, recall y f1
LRconfusion_matrix <- table(data_test$Key, predictions)
LRaccuracy <- sum(diagonal(LRconfusion_matrix))/sum(LRconfusion_matrix)
LRprecision <- LRconfusion_matrix[1,1]/(LRconfusion_matrix[1,1]+LRconfusion_matrix[1,2])
LRrecall <- LRconfusion_matrix[1,1]/(LRconfusion_matrix[1,1]+LRconfusion_matrix[2,1])
LRf1_score <- 2*(LRprecision*LRrecall)/(LRprecision+LRrecall)
# ----------------------------------------


# Segundo modelo: Classificador Bayesiano
# ----------------------------------------
cluster<- kmeans(data_train, centers = 2, nstart = 15)
names(cluster)
sumbt<- kmeans(data_train, centers = 10)$betweenss
sumbt2<- kmeans(data_train, centers = 10)$tot.withinss

Bmodel <- naive_bayes(data_train$Key ~ ., data_train)

# Generamos la prediccion
NBpredictions <- predict(Bmodel, data_test)
NBconfusion_matrix <- table(data_test$Key, NBpredictions)

# Generamos la accuracy, precision, recall y f1
NBaccuracy <- sum(diagonal(NBconfusion_matrix))/sum(NBconfusion_matrix)
NBprecision <- NBconfusion_matrix[1,1]/(NBconfusion_matrix[1,1]+NBconfusion_matrix[1,2])
NBrecall <- NBconfusion_matrix[1,1]/(NBconfusion_matrix[1,1]+NBconfusion_matrix[2,1])
NBf1_score <- 2*(NBprecision*NBrecall)/(NBprecision+NBrecall)
# Se consiguen muy buenos puntajes con NaiveBayes
# ----------------------------------------


# Tercer modelo: KNN
# ----------------------------------------
KNNmodel <- kknn(data_train$Key ~ ., data_train, k = 5)

# Generamos la prediccion
KNNpredictions <- predict(KNNmodel, data_test)

# Generamos la matriz de confusion, accuracy, precision, recall y f1
KNNconfusion_matrix <- table(data_test$Key, KNNpredictions)
KNNaccuracy <- sum(diagonal(KNNconfusion_matrix))/sum(KNNconfusion_matrix)
KNNprecision <- KNNconfusion_matrix[1,1]/(KNNconfusion_matrix[1,1]+KNNconfusion_matrix[1,2])
KNNrecall <- KNNconfusion_matrix[1,1]/(KNNconfusion_matrix[1,1]+KNNconfusion_matrix[2,1])
KNNf1_score <- 2*(KNNprecision*KNNrecall)/(KNNprecision+KNNrecall)
# ----------------------------------------


# CONCLUSIONES

# Con lo anterior se concluye que el mejor modelo de los 3 es el Naive Bayes
# Puesto que los mejores puntajes y resultados son los de Naive Bayes


# Procedimientos finales
# Procedemos a extrapolar el modelo con el data_eval, creando una nueva columna con el resultado presupuestado
data_eval$Key <- predict(Bmodel, data_eval)

# Se guardan los resultados en un archivo csv
write.csv(data_eval$Key, "resultados.csv", row.names = FALSE)

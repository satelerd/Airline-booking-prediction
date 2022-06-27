# Airline-booking-prediction

# Proyecto 2
## Minería de Datos / 2022-01
### Prediciendo sobreventa de asientos en industria Aérea

Las aerolíneas venden un servicio de transporte entre un punto A y un punto B. Una vez que el vuelo
despegó, un asiento vacío ya no se puede vender, por lo que podría decirse que es un producto perecible.

Sumado a esto, existe un número significativo de pasajeros que no se presentan en la puerta del vuelo,
debido a diferentes razones como: atrasos en las conexiones de otros vuelos, cambio de fecha de pasajes,
clima, atrasos en llegar al aeropuerto, cancelación de la reserva, entre otros. Este fenómeno se denomina
no-show, y provoca que algunos asientos de cada vuelo salgan vacíos, lo que les genera a las aerolíneas
un alto costo de oportunidad.

Para mitigar estos costos, las aerolíneas suelen permitir la sobre-reserva de algunos asientos en sus vuelos
(overbooking en inglés). Si la estimación del no-show es correcta, la aerolínea puede salir con todos sus
asientos ocupados; si lo subestiman, pueden salir con asientos vacíos, y si la sobreestiman pueden incluso
tener que dejar a pasajeros fuera del vuelo (se denomina denied boarding).

El objetivo principal de este proyecto es crear un programa computacional que permita a la aerolínea
PANAM estimar si un vuelo tendrá más de 4 no show en su vuelo. Por ejemplo, si un vuelo de Santiago a
Concepción tiene 3 no show entonces el vuelo se cataloga como 0, ya que el número de no show fue bajo.
Caso contrario, si 4 o más personas no se presentaron, entonces el vuelo se cataloga como 1, ya que la
aerolínea pudo haber realizado overbooking.

La base de datos incluye 1,000,000 vuelos de PANAM entre 2009 y 2012 y 21 variables, cuyo diccionario
esta al final de este documento. Además, tiene una segunda base de datos de prueba con 248,880 vuelos
y 20 variables, excluyendo la variable de noshow que es la que debe predecir (recuerde, su modelo tiene
que predecir 0 ó 1).

Como resultado del trabajo, genere un archivo .R o .Rmd mostrando su proceso. El archivo deberá tener
un reporte describiendo las etapas de su proceso (limpieza de datos, selección de variables, y otras), los
modelos supervisados utilizados (1 por cada integrante del grupo), la selección de hiperparámetros
(justificada empíricamente), la comparación de los resultados obtenidos entre los modelos, y el código
empleado.

Los puntajes asignados a cada tarea corresponden a:
- Limpieza de datos (1.0 punto, código y justificación)
- Modelo de clasificación, uno por cada integrante (2.5 punto, código y justificación)
- Selección del modelo final (1.0 puntos, código y justificación)
- Evaluación de la segunda base de datos basado en la variable binaria no-show (1.5 puntos,
código y justificación).

Además, para la evaluación de la segunda base de datos, usted deberá generar un archivo CSV con una
sola columna y 248,880 filas con valores 0 o 1 correspondiente a la evaluación de la segunda base de
datos. Para evaluar, se considerará el F1-score entre todos los grupos, utilizando la clase 0 como TP. Es
decir, el grupo con mejor F1-score obtendrá los 1.5 puntos, a partir de ese valor se realizará una regresión
hacia los puntajes más bajos. En caso de que el archivo tenga menos filas se agregará el valor 1 hasta
cumplir el número de filas requeridas.

Los datos los pueden descargar desde acá:
- [Datos entrenamiento](https://www.dropbox.com/s/xbba54sifp8gpqm/ALUMNOS-trainData.csv?dl=0)
- [Datos evaluación](https://www.dropbox.com/s/kqu49u6eu8vbk2x/ALUMNOS-evalData.csv?dl=0)

• El trabajo es en grupos de 3 alumnos, no se aceptarán grupos de menos o más alumnos.

• El resultado deberá ser subido a webcursos a más tardar el 26 de junio. Usted podrá subir los
archivos requeridos o subir los códigos a su cuenta de GitHub de alguno de los participantes y
enviar el enlace a través de WebCursos.

¡Mucha suerte!


## Diccionario de variables:
- date: Fecha del vuelo
- departure_time: Hora programada para el despegue
- capacity: Capacidad física del avión (# de asientos)
- revenues_usd: Suma de los ingresos totales de un avión (en dólares)
- bookings: Total de reservas en el vuelo al inicio del día de vuelo
- fligth_number: Numero de vuelo (indica la ruta)
- origin: Aeropuerto de origen
- destination: Aeropuerto de destino
- distance: Distancia entre origen y destino
- noshow: Número de pasajeros que no se presentaron al vuelo
- denied_boarding: Número de pasajeros que no pudieron abordar por vuelo sobre reservado
- pax_high: Número de pasajeros que compran la tarifa más alta
- pax_midhigh: Número de pasajeros que compran la segunda tarifa más alta
- pax_midlow: Número de pasajeros que compran la segunda tarifa más baja
- pax_low: Número de pasajeros que compran la tarifa más baja
- pax_freqflyer: Número de pasajeros que canjearon el pasaje con kilómetros PANAM
- group_bookings: Número de pasajeros que van con un grupo de turismo
- out_of_stock: Número de días en la historia del vuelo donde no hubo venta por capacidad
completada (es un indicador de la demanda del vuelo)
- dom_cnx: Número de pasajeros que provienen o continúan a una conexión domestica (dentro del
mismo país de origen)
- int_cnx: Número de pasajeros que provienen o continúan a una conexión internacional
- p2p: Número de pasajeros punto a punto, no conectan ni en origen ni en destino

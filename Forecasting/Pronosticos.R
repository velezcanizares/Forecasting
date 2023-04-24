#1 Instalar paquete
install.packages('quantmod')
install.packages('prophet')

# 2 Abrir Libreria
library(quantmod)
library(prophet)
library(tidyverse)
library(zoo)
library(lubridate)
library(xts)
library(ggplot2)
library(dplyr)

# 3 traer datos
Bitcoin <- getSymbols("BTC-USD", from="2016-01-01", src="yahoo", auto.assign = F)[,6]
class(Bitcoin)
df1 <- fortify.zoo(Bitcoin)
df1 <-df1 %>% rename (ds = colnames(df1)[1], y = colnames(df1)[2])

Ether <- getSymbols("ETH-USD", from="2016-01-01", src="yahoo", auto.assign = F)[,6]
class(Ether)
df2 <- fortify.zoo(Ether)
df2 <-df2 %>% rename (ds = colnames(df2)[1], y = colnames(df2)[2])


# 4 primeras predicciones BTC
modelo1 <- prophet(df1)
horizonte1 <- make_future_dataframe(modelo1, periods = 90)

forecast1 <- predict(modelo1, horizonte1)
tail(forecast1[c('ds','yhat','yhat_lower','yhat_upper')])

# 5 Gráfico Pronosticos BTC
plot1 <- dyplot.prophet(modelo1, forecast1)
plot2 <- prophet_plot_components(modelo1, forecast1)

# 6 Primeras predcciones ETH
modelo2 <- prophet(df2)
horizonte2 <- make_future_dataframe(modelo2, periods = 90)

forecast2 <- predict(modelo2, horizonte2)
tail(forecast2[c('ds','yhat','yhat_lower','yhat_upper')])

# 7 Gráficas
dyplot.prophet(modelo2, forecast2)
prophet_plot_components(modelo2, forecast2)

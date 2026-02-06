library(tidyverse)
library(Metrics)
library(readxl)
library(writexl)


data <- read_xlsx("predictions.xlsx")

row <- data.frame(Sys.Date(), rmse(data$y, data$yhat))

write_csv(row, "results.csv", append = T)

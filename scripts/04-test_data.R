#### Preamble ####
# Purpose: Tests the simulated data
# Author: Linrong Li
# Data: 13 April 2023
# Contact: linrongl.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run the data simulation script


#### Workspace setup ####
library(tidyverse)

#### Test data ####
simulated_data$Party |>
  unique() == c(
    "Republican",
    "Democrat"
  )

simulated_data$Class |>
  unique() |>
  length() == 4

simulated_data$id |> length() == 100

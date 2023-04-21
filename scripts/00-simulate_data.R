#### Preamble ####
# Purpose: Simulates the data set to investigate the attitudes toward homosexual people teaching in higher education [...UPDATE THIS...]
# Author: Linrong Li [...UPDATE THIS...]
# Data: 13 April 2023 [...UPDATE THIS...]
# Contact: linrongl.li@mail.utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(418)
simulated_data <-
  tibble(
    "id" = 1:100,
    "Party" = sample(
      x = c(
        "Democrat",
        "Republican"
      ),
      size = 100,
      replace = TRUE),
    "Class" = sample(
      x = c(
        "Lower class",
        "Working class",
        "Middle class",
        "Upper class"
      ),
      size = 100,
      replace = TRUE
    ),
    "Attitude" = sample(
      x = c(
        "Allowed",
        "Not allowed"
      ),
      size = 100,
      replace = TRUE
    )
  )




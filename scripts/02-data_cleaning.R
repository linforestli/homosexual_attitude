#### Preamble ####
# Purpose: Reads and cleans the data set needed for the analysis
# Author: Linrong Li
# Data: 3 April 2023
# Contact: linrongl.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)
library(readxl)
library(here)

#### Read data ####
raw_data <- read_excel(here::here("inputs/data/GSS.xlsx"))

#### Remove all N/As ####
cleaned_teach <- raw_data %>%
  select(id_, occ10, age, educ, sex, colhomo, class_, prestg10)

for (i in seq_along(cleaned_teach)) {
  # Use grepl to find cells starting with ".s", ".n.", ".i", or ".d"
  bad_cells <- grepl("^\\.s|^\\.n|^\\.i|^\\.d", cleaned_teach[[i]])
  # Replace bad cells with NA
  cleaned_teach[bad_cells, i] <- NA
}

cleaned_teach <- drop_na(cleaned_teach)

#### Save data ####
# [...UPDATE THIS...]
# change cleaned_data to whatever name you end up with at the end of cleaning


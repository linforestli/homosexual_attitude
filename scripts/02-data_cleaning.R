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
library(writexl)

#### Read data ####
raw_data <- read_excel(here::here("inputs/data/GSS.xlsx"))

#### Clean the data to recode the party column and remove NAs ####
cleaned_teach <- raw_data %>%
  filter(ballot != "Ballot b")

for (i in seq_along(cleaned_teach)) {
  # Use grepl to find cells starting with ".s", ".n.", ".i", or ".d"
  bad_cells <- grepl("^\\.s|^\\.n|^\\.i|^\\.d", cleaned_teach[[i]])
  # Replace bad cells with NA
  cleaned_teach[bad_cells, i] <- NA
}

cleaned_teach$age = as.numeric(cleaned_teach$age)
cleaned_teach$educ = as.numeric(cleaned_teach$educ)

cleaned_teach <- cleaned_teach %>% 
  mutate(partyid = case_when(
        partyid == "Strong democrat" ~ "Democrat",
        partyid == "Not very strong democrat" ~ "Democrat",
        partyid == "Independent, close to democrat" ~ "Democrat",
        partyid == "Independent, close to republican" ~ "Republican",
        partyid == "Not very strong republican" ~ "Republican",
        partyid == "Strong republican" ~ "Republican",
        partyid == "Other party" ~ NA,
        partyid == "Independent (neither, no response)" ~ NA,
        TRUE ~ partyid
      ))

cleaned_teach$class_ <- factor(cleaned_teach$class_, 
                               levels = c("Lower class", "Working class", 
                                          "Middle class", "Upper class"))

cleaned_teach <- drop_na(cleaned_teach)

#### Save data ####
write_xlsx(cleaned_teach, 'inputs/data/cleaned.xlsx', col_names=TRUE)


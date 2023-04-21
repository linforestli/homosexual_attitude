#### Preamble ####
# Purpose: Model the relationship between homo teaching and other factors
# Author: Linrong Li
# Data: 03 April 2023
# Contact: linrongl.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: run 02-data_cleaning first

library(tidyverse)
library(tidymodels)
library(ggplot2)

library(tidyverse)
library(tidymodels)
library(ggplot2)
library(MASS)

upper_dem_yes_count <- sum(ifelse(cleaned_teach$colhomo == "ALLOWED" & 
                                       cleaned_teach$partyid == "Democrat" &
                                       cleaned_teach$class_ == "Upper class", 1, 0))
upper_rep_yes_count <- sum(ifelse(cleaned_teach$colhomo == "ALLOWED" & 
                                     cleaned_teach$partyid == "Republican" &
                                     cleaned_teach$class_ == "Upper class", 1, 0))
upper_dem_no_count <- sum(ifelse(cleaned_teach$colhomo == "NOT ALLOWED" & 
                                      cleaned_teach$partyid == "Democrat" &
                                      cleaned_teach$class_ == "Upper class", 1, 0))
upper_rep_no_count <- sum(ifelse(cleaned_teach$colhomo == "NOT ALLOWED" & 
                                    cleaned_teach$partyid == "Republican" &
                                    cleaned_teach$class_ == "Upper class", 1, 0))
middle_dem_yes_count <- sum(ifelse(cleaned_teach$colhomo == "ALLOWED" & 
                                        cleaned_teach$partyid == "Democrat" &
                                        cleaned_teach$class_ == "Middle class", 1, 0))
middle_rep_yes_count <- sum(ifelse(cleaned_teach$colhomo == "ALLOWED" & 
                                      cleaned_teach$partyid == "Republican" &
                                      cleaned_teach$class_ == "Middle class", 1, 0))
middle_dem_no_count <- sum(ifelse(cleaned_teach$colhomo == "NOT ALLOWED" & 
                                       cleaned_teach$partyid == "Democrat" &
                                       cleaned_teach$class_ == "Middle class", 1, 0))
middle_rep_no_count <- sum(ifelse(cleaned_teach$colhomo == "NOT ALLOWED" & 
                                     cleaned_teach$partyid == "Republican" &
                                     cleaned_teach$class_ == "Middle class", 1, 0))
lower_dem_yes_count <- sum(ifelse(cleaned_teach$colhomo == "ALLOWED" & 
                                       cleaned_teach$partyid == "Democrat" &
                                       cleaned_teach$class_ == "Lower class", 1, 0))
lower_rep_yes_count <- sum(ifelse(cleaned_teach$colhomo == "ALLOWED" & 
                                     cleaned_teach$partyid == "Republican" &
                                     cleaned_teach$class_ == "Lower class", 1, 0))
lower_dem_no_count <- sum(ifelse(cleaned_teach$colhomo == "NOT ALLOWED" & 
                                      cleaned_teach$partyid == "Democrat" &
                                      cleaned_teach$class_ == "Lower class", 1, 0))
lower_rep_no_count <- sum(ifelse(cleaned_teach$colhomo == "NOT ALLOWED" & 
                                    cleaned_teach$partyid == "Republican" &
                                    cleaned_teach$class_ == "Lower class", 1, 0))
working_dem_yes_count <- sum(ifelse(cleaned_teach$colhomo == "ALLOWED" & 
                                         cleaned_teach$partyid == "Democrat" &
                                         cleaned_teach$class_ == "Working class", 1, 0))
working_rep_yes_count <- sum(ifelse(cleaned_teach$colhomo == "ALLOWED" & 
                                       cleaned_teach$partyid == "Republican" &
                                       cleaned_teach$class_ == "Working class", 1, 0))
working_dem_no_count <- sum(ifelse(cleaned_teach$colhomo == "NOT ALLOWED" & 
                                        cleaned_teach$partyid == "Democrat" &
                                        cleaned_teach$class_ == "Working class", 1, 0))
working_rep_no_count <- sum(ifelse(cleaned_teach$colhomo == "NOT ALLOWED" & 
                                      cleaned_teach$partyid == "Republican" &
                                      cleaned_teach$class_ == "Working class", 1, 0))

# allow_sex_count <- data.frame(
#   party = c(0, 1),
#   yes = c(female_yes_count, male_yes_count),
#   no = c(female_no_count, male_no_count)
# )
# allow_sex_count$resp <- cbind(allow_sex_count$yes, allow_sex_count$no)

allow_party_class_count <- data.frame(
  class = factor(c("Lower class", "Working class", "Middle class", "Upper class")),
  party = c(0, 0, 0, 0, 1, 1, 1, 1),
  yes = c(lower_dem_yes_count, working_dem_yes_count,
          middle_dem_yes_count, upper_dem_yes_count,
          lower_rep_yes_count, working_rep_yes_count,
          middle_rep_yes_count, upper_rep_yes_count),
  no = c(lower_dem_no_count, working_dem_no_count,
         middle_dem_no_count, upper_dem_no_count,
         lower_rep_no_count, working_rep_no_count,
         middle_rep_no_count, upper_rep_no_count)
)
allow_party_class_count$resp <- cbind(allow_party_class_count$yes, allow_party_class_count$no)

# model1 <- glm(resp ~ female, data = allow_sex_count, family = binomial(link = logit))
# summary(model1)
model2 <- glm(resp ~ class + factor(party), family = binomial(link = logit),
              data = allow_party_class_count)
summary(model2)
exp(confint.default(model2))
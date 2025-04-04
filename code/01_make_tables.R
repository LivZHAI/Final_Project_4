here::i_am("code/01_make_tables.R")

absolute_file_path <- here::here("data/cancer_patient_data_set_copy.csv" )
df_sorted <- read.csv(absolute_file_path, header = TRUE)

##########################################################################################
library(knitr)
library(gt)

table1_variable <- data.frame(
  Variable = c("patient.id", "gender", "age", "air pollution", "alcohol use", "dust allergy", 
               "occupational hazards", "genetic risk", "chronic lung disease", "balanced diet",
               "obesity", "smoking", "passive smoker", "chest pain", "coughing of blood",
               "fatigue", "weight loss", "shortness of breath", "wheezing", "swallowing difficulty",
               "clubbing of finger nails"),
  Type = c("Integer", "Binary (Female, Male)", "Integer", rep("Categorical (1 - 9)", 18)),
  Description = c("ID number of patient", "Sex of patient", "Age of patient (yrs)", 
                  "The level of air pollution exposure of the patient", "The level of alcohol use of the patient",
                  "The level of dust allergy of the patient", "The level of occupational hazards of the patient",
                  "The level of genetic risk of the patient", "The level of chronic lung disease of the patient",
                  "The level of balanced diet of the patient", "The level of obesity of the patient",
                  "The level of smoking of the patient", "The level of passive smoker of the patient",
                  "The level of chest pain of the patient", "The level of coughing of blood of the patient",
                  "The level of fatigue of the patient", "The level of weight loss of the patient",
                  "The level of shortness of breath of the patient", "The level of wheezing of the patient",
                  "The level of swallowing difficulty of the patient", "The level of clubbing of finger nails of the patient")
)

gt_table <- table1_variable %>%
  gt() %>%
  tab_header(
    title = "Table 1. Variable Types and Descriptions"
  ) %>%
  cols_align(
    align = "left",
    columns = everything()
  ) %>%
  tab_options(
    table.font.size = px(12),
    column_labels.font.weight = "bold",
    table.width = pct(100),
    data_row.padding = px(5),
    table.border.top.color = "white",
    heading.align = "left"
  ) 

saveRDS(
  table1_variable,
  file = here::here("output/table1_variable.rds")
)
##########################################################################################
library(dplyr)
#library(knitr)
library(kableExtra)

# kable
table2_descriptive <- as.data.frame(t(apply(df_sorted[, 3:24], 2, quantile, probs = c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE)))
colnames(table2_descriptive) <- c("Min", "First Quantile", "Median", "Third Quantile", "Max")
kable(table2_descriptive, caption = "Table2. Five-Statistics Summary") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  column_spec(1, width = "7%") %>%  
  column_spec(2:6, width = "7%") 

saveRDS(
  table2_descriptive,
  file = here::here("output/table2_descriptive.rds")
)
##########################################################################################
library(labelled)  
library(gtsummary)  

# Table3
var_label(df_sorted)[c(2,3,12)] <- list(
  Gender = 'Gender',
  Age = "Age",
  Smoking = "Smoking"
)

df_sorted$Gender <- as.factor(df_sorted$Gender)
table3_smoking<-
  df_sorted[c(2,3,12)] %>%
  select('Age', 'Gender', 'Smoking')%>%
  tbl_summary(
    by = Gender, 
    missing = "no"
  ) %>%
  modify_spanning_header(c("stat_1", "stat_2") ~ "**Table 3. Proportion of People of Multiple Smoking Levels by Gender**") %>%
  add_overall() 
#add_p()

saveRDS(
  table3_smoking,
  file = here::here("output/table3_smoking.rds")
)

# Table4
var_label(df_sorted)[c(2,3,18)] <- list(
  Gender = 'Gender',
  Age = "Age",
  Shortness.of.Breath= "Shortness of Breath"
)

df_sorted$Gender <- as.factor(df_sorted$Gender)
table4_breath <-
  df_sorted[c(2,3,18)] %>%
  select(all_of(c("Age", "Gender", "Shortness.of.Breath")))%>%
  tbl_summary(
    by = Gender, 
    missing = "no"
  ) %>%
  modify_spanning_header(c("stat_1", "stat_2") ~ "**Table 4. Proportion of People of Multiple Shortness of Breath Levels by Gender**") %>%
  add_overall() 
#add_p()

saveRDS(
  table4_breath,
  file = here::here("output/table4_breath.rds")
)

##########################################################################################


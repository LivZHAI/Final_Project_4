# Final Project Guidance

Welcome to Siyu's repo🏠! This repository will be updated with any changes or new information regarding my final project—Lung Cancer Data Analysis. All relevant materials are included in this repository, including the patient data set and all R code used to generate tables, figures, and reports.

------------------------------------------------------------------------

## 📝Contents of report

This report will follow a formal data analysis workflow involving variable description, exploratory analysis and model establishment to explore the main cause of lung cancer, and finally generate suggestions for preventing lung cancer efficiently.

## 📊Obtaining the data

Data is stored in the folder of `data` and you can directly download it if need.\
This data set contains information on 1000 patients with lung cancer, including their demographics (age, gender), levels of a series of exposure (air pollution exposure, alcohol use, dust allergy, occupational hazards, genetic risk, chronic lung disease, balanced diet, obesity, smoking, passive smoker) and specific body symptoms (chest pain, coughing of blood, fatigue, weight loss ,shortness of breath ,wheezing ,swallowing difficulty ,clubbing of finger nails and snoring), 26 columns in total.

## 💻Initial code description

`code/01_make_tables.R`

-   generates variable description table, saves as `table1_variable.rds`
-   generates descriptive statistics table, saves as `table2_descriptive.rds`
-   generates table of smoking level, saves as `table3_smoking.rds`
-   generates table of shortness of breath level, saves as `table4_breath.rds`
-   all tables are output in `output/` folder

`code/02_make_figures.R`

-   generates a correlation heat map, saves as `figure1_heatmap.png`
-   generates a stacked bar chart for variable of exposure, saves as `figure2_barExposure.png`
-   generates a stacked bar chart for variable of symptom, saves as `figure3_barSymptom.png`
-   all figures are output in `output/` folder

`code/03_make_regressions.R`

-   generates logit regression of outcome on exposure, saves as `regression1_exposure.rds`
-   generates logit regression of outcome on symptom, saves as `regression2_symptom.rds`
-   all regressions are saved in `output/` folder

`code/04_render_report.R`

-   renders `Interim_Report.Rmd`

------------------------------------------------------------------------

## 📄 How to Generate the Final Report

To generate the final report, follow these steps:

1.  **Ensure Required Packages are Installed in Your Rstudio**\
    `knitr`, `kableExtra`, `dplyr`,`labelled`, `gtsummary`, `ggplot2`, `reshape2`, `gt`
2.  **Download Project folder from GitHub**
3.  **Change terminal path to the project and click `make` in your terminal**

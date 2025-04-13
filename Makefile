Interim_Report.html: Interim_Report.Rmd code/04_render_report.R data/cancer_patient_data_set_copy.csv \
                     output/table1_variable.rds output/table2_descriptive.rds output/table3_smoking.rds \
                     output/table4_breath.rds output/figure1_heatmap.png output/figure2_barExposure.png \
                     output/figure3_barSymptom.png
	Rscript code/04_render_report.R
	
output/table1_variable.rds: code/01_make_tables.R data/cancer_patient_data_set_copy.csv
	Rscript code/01_make_tables.R
output/table2_descriptive.rds: code/01_make_tables.R data/cancer_patient_data_set_copy.csv
	Rscript code/01_make_tables.R
output/table3_smoking.rds: code/01_make_tables.R data/cancer_patient_data_set_copy.csv
	Rscript code/01_make_tables.R
output/table4_breath.rds: code/01_make_tables.R data/cancer_patient_data_set_copy.csv
	Rscript code/01_make_tables.R

output/figure1_heatmap.png: code/02_make_figures.R data/cancer_patient_data_set_copy.csv
	Rscript code/02_make_figures.R
output/figure2_barExposure.png: code/02_make_figures.R data/cancer_patient_data_set_copy.csv
	Rscript code/02_make_figures.R
output/figure3_barSymptom.png: code/02_make_figures.R data/cancer_patient_data_set_copy.csv
	Rscript code/02_make_figures.R
 
# add regression later

.PHONY: Analysis
Analysis: output/table1_variable.rds output/table2_descriptive.rds output/table3_smoking.rds output/table4_breath.rds \
          output/figure1_heatmap.png output/figure2_barExposure.png output/figure3_barSymptom.png
          
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f *.html
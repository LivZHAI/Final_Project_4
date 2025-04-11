here::i_am("code/02_make_figures.R")

absolute_file_path <- here::here("data/cancer_patient_data_set_copy.csv" )
df_sorted <- read.csv(absolute_file_path, header = TRUE)

##########################################################################################
library(ggplot2)
library(reshape2)
library(tidyverse)

# Compute the correlation matrix while temporarily excluding Patient.Id
cor_matrix <- cor(df_sorted[, 3:24])
melted_cor_matrix <- melt(cor_matrix)
colnames(melted_cor_matrix) <- c("Var1", "Var2", "Correlation")

breaks_vec <- c(-1.0, -0.4, -0.2, 0, 0.2,0.4, 0.6, 0.8, 1.0)
labels_vec <- c("-1 ~ -0.4","-0.4 ~ -0.2", "-0.2 ~ 0", "0 ~ 0.2", "0.2 ~ 0.4","0.4 ~ 0.6", "0.6 ~ 0.8", "0.8 ~ 1")

melted_cor_matrix$Correlation_Level <- factor(cut(melted_cor_matrix$Correlation, 
                                                  breaks = breaks_vec, 
                                                  labels = labels_vec, 
                                                  include.lowest = TRUE, 
                                                  right = FALSE),
                                              levels = labels_vec)

melted_cor_matrix$Var1 <- factor(melted_cor_matrix$Var1, levels = rownames(cor_matrix))
melted_cor_matrix$Var2 <- factor(melted_cor_matrix$Var2, levels = rownames(cor_matrix))

blue_green_colors <- c("#8d6a9f", "#6f7785", "#469597", "#b7e4c7", "#d8f3dc", "#52b69a", "#2d6a62","#004c6d")  

# Plot Heatmap
heatmap_plot <- 
  ggplot(data = melted_cor_matrix, aes(Var1, Var2, fill = Correlation_Level)) +
  geom_tile(color = "white", linewidth = 0.1) +  
  scale_fill_manual(values = setNames(blue_green_colors,labels_vec),
                    name = "Correlation Level",
                    breaks = labels_vec,
                    labels = labels_vec,
                    drop = FALSE) + 
  geom_text(aes(label = round(Correlation, 2)), size = 2, color = "black") + 
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, size = 8),
        axis.text.y = element_text(size = 8),
        panel.grid = element_blank()) +
  labs(title = "Figure1. Correlation Heatmap",
       x = "", y = "")

ggsave(
  here::here("output/figure1_heatmap.png"),
  plot = heatmap_plot, 
  device = "png"
)
##########################################################################################
# Figure2
# filter exposure variables
df_long <- df_sorted[, 4:13] |>  
  mutate(across(everything(), as.factor)) |>  
  melt(id.vars = NULL)  

# cumulative bar chart
df_counts <- df_long |>  
  group_by(variable, value) |>  
  summarise(count = n(), .groups = 'drop') 

# plot stacked bar chart

morandi_colors <- c("#A8B5A2", "#D6C6B9", "#EDE4DC", "#D4A29C", 
                    "#A89A8E", "#6E6658", "#8DA0A5", "#B5B8A3")
bar_exposure<-
  ggplot(df_counts, aes(x = variable, y = count, fill = value)) +
  geom_bar(stat = "identity", position = "stack") + 
  scale_fill_manual(values = morandi_colors) + 
  geom_text(aes(label = count),  
            position = position_stack(vjust = 0.5),  
            color = "black", size = 2) +  
  labs(
    title = "Figure2. Stacked Bar Chart of Exposure Variables",
    x = "Categorical Variables",
    y = "Count",
    fill = "Intensity"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 12),  
    axis.text.y = element_text(size = 12),
    legend.position = "right"
  )

ggsave(
  here::here("output/figure2_barExposure.png"),
  plot = bar_exposure, 
  device = "png"
)

##########################################################################################
# figure3
# filter symptom variables
df_long <- df_sorted[, 14:24] |>  
  mutate(across(everything(), as.factor)) |>  
  melt(id.vars = NULL)  

# cumulative bar chart
df_counts <- df_long |>  
  group_by(variable, value) |>  
  summarise(count = n(), .groups = 'drop') 

# plot stacked bar chart

morandi_colors <- c("#A8B5A2", "#D6C6B9", "#EDE4DC", "#D4A29C", 
                    "#A89A8E", "#6E6658", "#8DA0A5", "#B5B8A3", "#C3C2B6")
bar_symptom<-
  ggplot(df_counts, aes(x = variable, y = count, fill = value)) +
  geom_bar(stat = "identity", position = "stack") + 
  scale_fill_manual(values = morandi_colors) + 
  geom_text(aes(label = count),  
            position = position_stack(vjust = 0.5),  
            color = "black", size = 2) +  
  labs(
    title = "Figure3. Stacked Bar Chart of Symptom Variables",
    x = "Categorical Variables",
    y = "Count",
    fill = "Intensity"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 12),  
    axis.text.y = element_text(size = 12),
    legend.position = "right"
  )

ggsave(
  here::here("output/figure3_barSymptom.png"),
  plot = bar_symptom, 
  device = "png"
)

##########################################################################################






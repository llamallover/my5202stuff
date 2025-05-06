#worldmap
install.packages("rworldmap")
library(rworldmap)
library(ggplot2)
breast_cancer_data <- data.frame(
  country = c("France", "Cyprus", "Belgium", "Netherlands", "Australia", "China", "United States", "India", "Brazil", "Japan", "Russia", "Germany", "Indonesia", "United Kingdom"),
  ASR = c(105.4, 104.8, 104.4, 101.6, 101.5, 33.0, 95.9, 26.6, 63.1, 74.4, 57.7, 77.0, 41.8, 94.0)
)
pdf("finalbreast_cancer_world_map.pdf", width = 6, height = 8)

world_map <- joinCountryData2Map(breast_cancer_data, 
                                 joinCode = "NAME", nameJoinColumn = "country")

mapParams <- mapCountryData(
  world_map,
  nameColumnToPlot = "ASR",
  mapTitle = "Age-Standardised Rates (ASR) of 
  Breast Cancer per 100,000 Women",
  colourPalette = "heat",
  oceanCol = "lightblue",
  missingCountryCol = "white"
)

#words under legend to label properly
mtext("Low ASR (<40)    |    Moderate ASR (40-80)    |  
      High ASR (80-100)    |    Very High ASR (>100)", 
      side = 1, line = 4, cex = 0.9, col = "black")
dev.off()
#i tried to save it using ggsave but that only works if you make the plot in ggplot
#this had to be saved a different way







#bar graph visualization
install.packages("ggplot2")

library(ggplot2)

# breast cancer data
breast_cancer_data <- data.frame(
  country = c("France", "Cyprus", "Belgium", "Netherlands", "Australia", "China", 
              "United States", "India", "Brazil", "Japan", "Russia", "Germany", 
              "Indonesia", "United Kingdom"),
  ASR = c(105.4, 104.8, 104.4, 101.6, 101.5, 33.0, 95.9, 26.6, 63.1, 74.4, 57.7, 
          77.0, 41.8, 94.0)
)

# Reorder country factor for better visualization
breast_cancer_data$country <- factor(breast_cancer_data$country, levels = breast_cancer_data$country[order(breast_cancer_data$ASR)])

# Create a horizontal bar chart for ease of viewing
ggplot(breast_cancer_data, aes(x = ASR, y = country, fill = ASR)) +
  geom_bar(stat = "identity") +
  scale_fill_gradient(low = "lightblue", high = "pink") +
  labs(title = "Age-Standardised Rates (ASR) of
       of Breast Cancer per 
       100,000 Women",
       x = "ASR per 100,000 Women",
       y = "Country",
       fill = "ASR Level") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggsave("final_bar_graph.pdf", width = 4, height = 6, units = "in")




#4 graphs
# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Step 1: Create the data
data <- data.frame(
  Race_Ethnicity = c("Hispanic (any race)",
                     "Non-Hispanic American Indian / Alaska Native",
                     "Non-Hispanic Asian / Pacific Islander",
                     "Non-Hispanic Black",
                     "Non-Hispanic White"),
  
  All_Ages_Rate = c(104.0, 116.7, 114.3, 131.0, 140.0),
  All_Ages_Lower = c(103.3, 111.3, 113.2, 130.0, 139.5),
  All_Ages_Upper = c(104.7, 122.3, 115.3, 132.0, 140.5),
  
  Under_50_Rate = c(38.6, 40.2, 49.9, 47.8, 50.2),
  Under_50_Lower = c(38.2, 36.1, 49.1, 47.1, 49.8),
  Under_50_Upper = c(39.1, 44.6, 50.8, 48.6, 50.7),
  
  Age_50_64_Rate = c(225.5, 270.3, 260.6, 278.8, 290.0),
  Age_50_64_Lower = c(223.1, 251.2, 256.8, 275.4, 288.3),
  Age_50_64_Upper = c(228.0, 290.6, 264.4, 282.3, 291.6),
  
  Age_65plus_Rate = c(333.7, 372.5, 308.9, 431.7, 476.0),
  Age_65plus_Lower = c(329.9, 346.1, 304.2, 426.6, 473.8),
  Age_65plus_Upper = c(337.6, 400.5, 313.5, 436.9, 478.1)
)

# Step 2: Reshape the data
data_long <- data %>%
  pivot_longer(
    cols = -Race_Ethnicity,
    names_to = c("Age_Group", ".value"),
    names_pattern = "(All_Ages|Under_50|Age_50_64|Age_65plus)_(.*)"
  ) %>%
  mutate(Age_Group = recode(Age_Group,
                            "All_Ages" = "All Ages",
                            "Under_50" = "<50",
                            "Age_50_64" = "50-64",
                            "Age_65plus" = "65+"))

# Step 3: Faceted plot by Age Group
ggplot(data_long, aes(x = Race_Ethnicity, y = Rate, fill = Race_Ethnicity)) +
  geom_col(position = "dodge") +
  geom_errorbar(aes(ymin = Lower, ymax = Upper),
                width = 0.2,
                position = position_dodge(width = 0.9)) +
  facet_wrap(~ Age_Group, ncol = 2) +
  labs(title = "Breast Cancer Incidence by Race/Ethnicity within Age Group",
       x = "Race/Ethnicity", y = "Incidence Rate per 100,000") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")

ggsave("bc_age_vs_demo.pdf", width = 10, height = 6, units = "in")


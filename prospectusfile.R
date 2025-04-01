#working on the code
install.packages("rworldmap")
library(rworldmap)
breast_cancer_data <- data.frame(
  country = c("France", "Cyprus", "Belgium", "Netherlands", "Australia", "China", "United States", "India", "Brazil", "Japan", "Russia", "Germany", "Indonesia", "United Kingdom"),
  ASR = c(105.4, 104.8, 104.4, 101.6, 101.5, 33.0, 95.9, 26.6, 63.1, 74.4, 57.7, 77.0, 41.8, 94.0)
)


world_map <- joinCountryData2Map(breast_cancer_data, 
                                 joinCode = "NAME", nameJoinColumn = "country")

mapParams <- mapCountryData(
  world_map,
  nameColumnToPlot = "ASR",
  mapTitle = "Age-Standardised Rates (ASR) of Breast Cancer per 100,000 Women",
  colourPalette = "heat",
  oceanCol = "lightblue",
  missingCountryCol = "white"
)
addMapLegend(
  legendWidth = 0.6,
  legendLabels = "all",
  legendMar = 4
)


addMapLegend(
  legendWidth = 0.6,
  legendLabels = "all",
  legendMar = 4
)

mtext("Low ASR (<40)    |    Moderate ASR (40-80)    |  
      High ASR (80-100)    |    Very High ASR (>100)", 
      side = 1, line = 4, cex = 0.9, col = "black")


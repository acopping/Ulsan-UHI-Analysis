# =====================================================================
# Spatial Analysis of UHI in Ulsan using Machine Learning and R
# Author: Alexander Copping
# =====================================================================

# Load necessary libraries (Uncomment the lines below to install if needed)
# install.packages("randomForest")
# install.packages("ggplot2")
library(randomForest)
library(ggplot2)

# Load data 
# NOTE: Ensure "ML_data.csv" is in the same working directory as this script.
ulsan_data <- read.csv("ML_data.csv")

# Clean data by removing NA values
ulsan_data <- na.omit(ulsan_data)

# =====================================================================
# 1. Random Forest Machine Learning Model
# =====================================================================

# Initial Random Forest Model
set.seed(123) # Set seed for reproducibility
ulsan_rf <- randomForest(Surface_Temperature___C_ ~ Vegetation, 
                         data = ulsan_data, 
                         ntree = 500)

print("Initial Model Results:")
print(ulsan_rf)

# Tuned Random Forest Model (to address overfitting noise)
set.seed(123)
ulsan_rf_tuned <- randomForest(Surface_Temperature___C_ ~ Vegetation, 
                               data = ulsan_data, 
                               ntree = 500, 
                               nodesize = 100) 

print("Tuned Model Results (Node Size = 100):")
print(ulsan_rf_tuned)

# =====================================================================
# 2. Data Visualisation (Linear Regression Scatterplot)
# =====================================================================

# Generate scatterplot showing inverse relationship
uhi_plot <- ggplot(data = ulsan_data, aes(x = Vegetation, y = Surface_Temperature___C_)) +
  geom_point(alpha = 0.3, colour = "midnightblue") +  
  geom_smooth(method = "lm", colour = "red", linewidth = 1.5) + 
  theme_minimal() + 
  labs(title = "Impact of Vegetation on Land Surface Temperature in Ulsan",
       x = "Vegetation (NDVI)",
       y = "Surface Temperature (°C)") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))

# Display the plot
print(uhi_plot)
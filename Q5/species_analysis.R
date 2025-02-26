library(ggplot2)
library(dplyr)

data <- read.csv("species_data.csv")

species_avg_weight <- data %>%
  group_by(Species) %>%
  summarise(Mean_Weight = mean(Weight, na.rm = TRUE))

write.table(species_avg_weight, file="5_R_outputs.txt", row.names=FALSE, sep="\t")

ggplot(data, aes(x=Sex, y=Weight, fill=Sex)) +
  geom_boxplot() +
  ggtitle("Weight Distribution by Sex") +
  theme_minimal()
ggsave("weight_distribution.png")
library(tidyverse)
library(shiny)
library(ggplot2)
library(plotly)

data2015 <- read_delim("2015StatResults.csv")

data2015 <- gather(data2015, key = "drug", value = "usage", 3:7)

graphdata <- reactive ({
  data2015 %>% 
    filter(Demographic == "Age") %>%
    filter(`State: US` %in% c("12-17 years","18-20 years"))
})
  
bar <- ggplot(data2015, aes(x = drug, y = usage, fill = drug)) + geom_bar(stat = "identity") +
  ggtitle("Drug usage rate by substance per age group in 2015") +
  geom_text((aes(label = scales::percent(usage, accuracy = 1)))) + 
  labs(title = "Substance use by age",
       subtitle = "Percent of usage by drug")

donut <- ggplot(data2015, aes(x = factor(drug), y =  fill = factor(usage))) +
  coord_polar("y", start = 0) + 
  ggtitle("Drug usage rate by substance per age group in 2015")

bar
donut

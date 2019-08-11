library(tidyverse)
library(jmv)
library(ggthemes)

human_resources <- read_csv("C:/Users/ChristianEZW/repositories/statistik_2_online_kurs/data/markdown/hr_cleaned.csv")

# Stell dir vor, du möchtest prüfen, ob Manager näher zum Arbeitsort wohnen
# als der Rest der Mitarbeiter. Du weißt aus der letzten Mittarbeiterbefragung
# dass die Mitarbeiter im Durchschnitt 9.2 Kilometer vom Arbeitsort wohnen. 
# Gleichzeitig nehmen wir an, du kennst du die Standardabweichung
# dieser Distanz: 8.11
# Nun befragst du 25 Manager danach, wie weit sie von ihrem Arbeitsort
# wohnen:

set.seed(25)
(my_sample <- human_resources %>% 
    filter(job_role == "Manager") %>% 
    sample_n(25) %>% 
    select(id, distance_from_home))

z_value <- (mean(my_sample$distance_from_home) - 9.2) / 
              (sd(my_sample$distance_from_home) / sqrt(25))


ggplot(NULL, aes(x = c(-3, 3))) +
  stat_function(
    fun = dnorm,
    geom = "area",
    alpha = .3,
    fill = "steelblue"
  ) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "steelblue",
    xlim = c(qnorm(.95), 4)
  ) +
  geom_vline(xintercept = z_value,
             color = "black",
             size = 1) +
  labs(
    title = "Z-Test Beispiel",
    x = "z-score",
    y = "Dichte"
  ) +
  scale_x_continuous(limits = c(-3, 3))

# p_value <- 1 - pnorm(z_value)
p_value <- 1 - pt(z_value, df = 24)


jmv::ttestOneS(
  data = my_sample,
  vars = distance_from_home,
  testValue = 9.2,
  hypothesis = "gt")

library(tidyverse)
library(jmv)

human_resources <- read_csv("C:/Users/ChristianEZW/repositories/statistik_2_online_kurs/data/markdown/hr_cleaned.csv")

# Ziel: Sind die Mitarbeiter im Schnitt älter als 30 Jahre?
set.seed(543)
my_sample <- human_resources %>% 
    sample_n(35)

# Mittelwert Alter
mean(my_sample$age)
sd(my_sample$age)

# Histogram des Alters der Probanden
ggplot(my_sample, aes(x = age)) + 
  geom_histogram(fill = "royalblue1", 
                 color = "black",
                 binwidth = 5) +
  labs(
    title = "Histogram des Alters der Stichprobe",
    x = "Alter",
    y = "Häufigkeit"
  )

# Boxplot des Alters der Probanen
ggplot(my_sample, aes(x = 1, y = age, group = 1)) + 
  geom_boxplot(fill = "royalblue1", 
                 color = "black", alpha = .2) +
  geom_jitter() +
  labs(
    title = "Boxplot des Alters der Stichprobe",
    x = "",
    y = "Alter"
  ) +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()
  )

# *************** Händische Berechnung ****************************
# t-Test
t_value <- (mean(my_sample$age) - 30) / (sd(my_sample$age) / sqrt(35))
1 - pt(t_value, df = 34)
cohens_d <- (mean(my_sample$age) - 30) /sd(my_sample$age)

# t-Verteilung
ggplot(NULL, aes(x = c(-4, 4))) +
  stat_function(
    fun = dt,
    geom = "area",
    fill = "steelblue",
    alpha = .3,
    args = list(
      df = 34
    )
  ) +
  stat_function(
    fun = dt,
    geom = "area",
    fill = "steelblue",
    xlim = c(qnorm(.95), 4),
    args = list(
      df = 34
    )
  ) +
  geom_vline(xintercept = t_value,
             color = "black",
             size = 1) +
  labs(
    title = "T-Test für eine Stichprobe",
    x = "t-score",
    y = "Dichte"
  ) 

# *************** Berechnung Jamovi ****************************

# Strg + Umschalt + H
write_csv(my_sample, "sample_age.csv")


# One-Sample t-Test
# AV (abhängige Variable):   Alter der Mitarbeiter
# UV (unabhängige Variable): Mittelwert des Alters der Stichprobe
jmv::ttestOneS(
  data = my_sample,
  vars = age,
  testValue = 30,
  hypothesis = "gt",
  effectSize = TRUE,
  desc = TRUE)

# Die Mitarbeiter sind signifikant älter als 30 Jahre, 
# t(34), p < .001, d = 0.88 (großer Effekt).





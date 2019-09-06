library(tidyverse)
library(jmv)
library(hrbrthemes)
library(ggthemes)

student_data <- read_csv("student_data.csv")

# Fragestellung: Hat der Alkoholkonsum und die Pendelstrecke
#                von Schüler*innen einen Einfluss auf deren
#                Lernzeit

# studytime - weekly study time (numeric: 1 - <2 hours, 2 - 2 to 5 hours, 
#                                3 - 5 to 10 hours, or 4 - >10 hours)
# traveltime - home to school travel time (numeric: 1 - <15 min., 
#              2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour)
# Walc - weekend alcohol consumption (numeric: from 1 - very low to 5 - very high)


# Deskriptive Statistik *******************************************************
jmv::descriptives(
  data = student_data,
  vars = vars(traveltime, studytime, Walc),
  sd = TRUE)
#
#  Descriptives                                              
#  ───────────────────────────────────────────────────────── 
#                          traveltime    studytime    Walc   
#  ───────────────────────────────────────────────────────── 
#    N                            395          395     395   
#    Missing                        0            0       0   
#    Mean                        1.45         2.04    2.29   
#    Median                         1            2       2   
#    Standard deviation         0.698        0.839    1.29   
#    Minimum                        1            1       1   
#    Maximum                        4            4       5   
#  ───────────────────────────────────────────────────────── 
# 
#

student_data %>% 
  select(studytime, Walc, traveltime) %>% 
  gather(variable, value) %>% 
  group_by(variable) %>% 
  summarise(
    mean = mean(value),
    sd   = sd(value),
    median = median(value),
    minimun = min(value),
    maximum = max(value),
    n = n()
  )
# A tibble: 3 x 7
# variable      mean    sd median minimun maximum     n
# <chr>         <dbl> <dbl>  <dbl>   <dbl>   <dbl> <int>
# 1 studytime   2.04 0.839      2       1       4   395
# 2 traveltime  1.45 0.698      1       1       4   395
# 3 Walc        2.29 1.29       2       1       5   395


# Barplots ********************************************************************
student_data %>% 
  select(studytime, Walc, traveltime) %>% 
  gather(variable, value) %>% 
  ggplot(aes(x = value)) +
  geom_bar(aes(fill = variable), color = "black") +
  guides(fill = FALSE) +
  facet_wrap(~ variable, scales = "free_x") +
  labs(
    title = "Balkendiagramme der drei Variablen",
    x = "Ausprägung",
    y = "Häufigkeit"
  )

# Boxplots ********************************************************************
student_data %>% 
  select(studytime, Walc, traveltime) %>% 
  gather(variable, value) %>% 
  ggplot(aes(x = variable, y = value)) +
  geom_jitter() +
  geom_boxplot(alpha = .7, aes(fill = variable)) +
  guides(fill = FALSE) +
  facet_wrap(~ variable, scales = "free_x") +
  labs(
    title = "Boxplots der drei Variablen",
    x = "Variable",
    y = "Wert"
  )

# Streudiagram der beiden Variablen Walc + traveltime *************************
# mit der abhängigen Variable studytime
student_data %>% 
  select(studytime, Walc, traveltime) %>% 
  gather(variable, value, -studytime) %>% 
  ggplot(aes(x = value, y = studytime)) +
  geom_jitter() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ variable)  +
  labs(
    title = paste0("Streudiagramme der abhängigen Variablen ",
                   "wöchentlicher Alkoholkonsum bzw. der Pendelstrecke\n",
                   "der SuS und der Lernzeit der SuS"),
    x = "unabhängige Variable",
    y = "Lernzeit"
  )


# Korrelation der unabhängigen und abhängigen *********************************
# Variable
cor(student_data$studytime, student_data$Walc)
cor(student_data$studytime, student_data$traveltime)
cor(student_data$Walc, student_data$traveltime)



# Multiple Regression *********************************************************
# AV: studytime
# UV: Walc + traveltime

jmv::linReg(
  data = student_data,
  dep = studytime,
  covs = vars(traveltime, Walc),
  blocks = list(
    list(
      "traveltime",
      "Walc")),
  refLevels = list(),
  modelTest = TRUE,
  anova = TRUE)

#  Model Fit Measures                                           
#  ──────────────────────────────────────────────────────────── 
#    Model    R        R²        F       df1    df2    p        
#  ──────────────────────────────────────────────────────────── 
#        1    0.263    0.0690    14.5      2    392    < .001   
#  ──────────────────────────────────────────────────────────── 
# 
#
#
#  Omnibus ANOVA Test                                                        
#  ───────────────────────────────────────────────────────────────────────── 
#                  Sum of Squares    df     Mean Square    F        p        
#  ───────────────────────────────────────────────────────────────────────── 
#    traveltime              1.26      1          1.264     1.92     0.167   
#    Walc                   16.31      1         16.311    24.75    < .001   
#    Residuals             258.37    392          0.659                      
#  ───────────────────────────────────────────────────────────────────────── 
#    Note. Type 3 sum of squares
# 
#
#
#  Model Coefficients                                      
#  ─────────────────────────────────────────────────────── 
#    Predictor     Estimate    SE        t        p        
#  ─────────────────────────────────────────────────────── 
#    Intercept       2.5194    0.1128    22.34    < .001   
#    traveltime     -0.0819    0.0592    -1.38     0.167   
#    Walc           -0.1594    0.0320    -4.97    < .001   
#  ─────────────────────────────────────────────────────── 
# 


# In R
lm(studytime ~ Walc + traveltime, data = student_data) %>% 
  summary


# Um den Einfluss des Alkoholkonsums und der Pendelzeit der SuS auf
# die Lernzeit der SuS zu untersuchen, wurde eine multiple Regression
# berechnet. Die multiple Regression ergab einen signifikanten Effekt 
# der beiden Prädiktoren, *F*(2, 392) = 14.5, *p* < .001, R^2 = .06. 
# Die Untersuchung der einzelnen Prädiktoren ergab, dass der Prädiktor 
# Alkoholkonsum einen signifikanten Effekt auf die Lernzeit der 
# SuS hatte, *F*(1, 392) = 24.75, *p* < .001, 
# was darauf hindeutet, dass wochenentlicher Alkoholkonsum zu einer
# Reduzierung der Lernzeit bei SuS führt. Für den Prädiktor 
# Pendelzeit ergab sich kein signifikanter Effekt, 
# *F*(1, 392) = 1.92, *p* = .17, was darauf hindeutet, dass 
# die Pendelzeit keinen Einfluss auf die Lernzeit der SuS hat.












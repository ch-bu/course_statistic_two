library(tidyverse)
library(jmv)
library(ggthemes)

human_resources <- read_csv("C:/Users/ChristianEZW/repositories/statistik_2_online_kurs/data/markdown/hr_cleaned.csv")

# Stell dir vor, der CEO des Unternehmenes möchte, dass die Mitarbeiter 
# schneller eine Beförderung als nach 3.5 Jahren erhalten. Viele
# Mitarbeiter waren unzufrieden und gaben an, dass sie lange auf
# Ihre Beförderung warten mussten. Der CEO hat daher vor ein paar Jahren
# ein KPI (Key Performance Indicator) angegeben, in dem er vorgab,
# dass Mitarbeiter im Schnitt unter 3.5 Jahren eine Beförderung erhalten sollten.
# Nun soll die Erreichung dieses KPI geprüft werden.

# Unsere Hypothese lautet daher (Unterschiedshypothese):
#  - Erhalten Mitarbeiter des Unternehmens früher als nach 3.5 Jahren eine Beförderung? 
#  - AV (abhängige Variable): Jahre seit der letzten Beförderung
#    UV (unabhängige Variable): 
#      - Mittelwert der Stichprobe seit der letzten Beförderung
#      - Angenommener KPI des CEO

# Um die Hypothese zu bearbeiten, befragen wir stellvertretend 50 Mitarbeiter des Unternehmens:

set.seed(22)
(my_sample <- human_resources %>% 
  sample_n(50) %>% 
  select(id, years_since_last_promotion))

# Schauen wir uns ein Balkendiagram an, bei dem wir einsehen können, wie schnell die Mitarbeiter
# befördert wurden:

ggplot(my_sample, aes(x = years_since_last_promotion)) + 
  geom_bar(fill = "chocolate2") +
  labs(
    title = "Wie lange liegt die letzte Beförderung der Mitarbeiter zurück?",
    x = "Jahre seit der letzten Beförderung",
    y = "Häufigkeit"
  ) +
  theme_economist()

# Wie lautet der Mittelwert der Stichprobe hinsichtlich der abhängigen Variable
mean(my_sample$years_since_last_promotion)

# Kompaktes Modell:    Y_i = 3.5
# Erweitertes Modell:  Y_i = 1.88

# SSEs berechnen
(errors <- my_sample %>% 
  mutate(
    compact_model = 3.5,
    augmented_model = 1.88,
    res_compact   = (years_since_last_promotion - compact_model)**2,
    res_augmented = (years_since_last_promotion - augmented_model)**2
  ))


(sse_c <- sum(errors$res_compact))  
(sse_a <- sum(errors$res_augmented))
(ssr <- sse_c - sse_a)

# PRE berechnen
(pre <- ssr / sse_c)

# -> Der Mittelwert der Stichprobe reduziert den Fehler des kompakten Modells um 24.3%. Dies gibt uns
#    Evidenz, dass der KPI errreicht wurde. Wäre PRE bei 0, dann hätten sich die
#    die Jahre bis zur Beförderung nicht reduziert. Wir haben also erste Evidenz, dass 
#    das KPI erreicht wurde. Um diese Frage endgültig zu beantworten, müssen wir allerdings 
#    im nächsten Modull berechnen, ob diese Reduzierung des Fehlers substantiell genug ist,
#    um vorläufig das erweiterte Modell anzunehmen. 





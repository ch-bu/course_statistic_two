
# Dataset for first chapters

```
data <- read_delim("C:/Users/ChristianEZW/repositories/statistik_2_online_kurs/data/markdown/daten_intelligenz.csv", ";", escape_double = FALSE, trim_ws = TRUE)


new_data <- data %>% 
  mutate(
    intelligence_pre = (intelligence_pre / 72.52) * 100,
    intelligence_post = (intelligence_post / 72.52) * 100,
    books_per_year = ((books_per_year / 171) * 10) %>% floor
  ) %>% 
  rename(id = person)


new_data %>% 
  group_by(group) %>% 
  summarise(
    mean_pre = mean(intelligence_pre),
    mean_post = mean(intelligence_post)
  ) %>% 
  gather(variable, value, - group) %>% 
  ggplot(aes(x = variable, y = value, group = group)) +
    geom_line()

```

# Projekte

## 1. Projekt

> Eine Multiple Regression berechnen

* Human Resources: https://www.kaggle.com/rhuebner/human-resources-data-set
* PISA Ergebnisse: 

## 2. Projekt

> ANOVAs und t-Tests berechnen

Spacing Effekt (https://osf.io/kehv9/, https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0182986)
* How Much Mightier is the Pen than the Keyboard for Note-taking? A Replication and Extension of Mueller and Oppenheimer (2014): https://osf.io/dyga5/; https://scholar.google.de/scholar?hl=de&as_sdt=0%2C5&q=How+Much+Mightier+is+the+Pen+than+the+Keyboard+for+Note-taking&btnG=
* https://osf.io/pfeg4/: An Efficacy Study of Interleaved Mathematics Practice

Cronbach's Alpha berechnen


## 3. Projekt

> Spezifische Hypothesen anhand von Kontrasten berechnen

# Technology Stack

* R
* Jamovi

# R und R-Studio

RStudio:
* Editor
* Console
* Output
* Pakete installieren (jmv, tidyverse, janitor)
* Daten importieren (über R-Studio)
* Pakete laden


# R - Grundlagen

* Befehle ausführen
* Pipe-Operator kennen lernen
* Variablen
* Funktionen
* Dataframes
* Chars
* nrow
* Vektoren
* View
* Zeilenlänge 
* Linting Shortcut

tidyverse:
* glimpse
* select
* arrange
* count
* filter
* mutate
* Documentation lesen / Probleme lösen


## R - Vertiefung

Ein Projekt für ein Experiment anlegen
* Rohdaten nicht anfassen
* R-Scripts für jede Hypothese
* Preliminary Results Script
* Ordner: Data (export, raw), analysis, meta,

janitor:
* clean_names


ggplot2:
* geom_histogram, geom_col, geom_boxplot, geom_point
* labs
* guides
* ggplot2-Tutor


jamovi:
* R-Code ausgeben lassen und in R integrieren.
* Erste Analysen mit bestehendem Vorwissen





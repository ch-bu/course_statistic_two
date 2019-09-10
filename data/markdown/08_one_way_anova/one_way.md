# Kategoriale Prädktoren

## Kategorialen Prädiktoren

Bisher hatten wir uns Modelle angeschaut, in denen die Prädiktoren intervallskaliert waren. In der experimentellen Forschung möchten wir allerdings häufig prüfen, ob sich beispielsweise Gruppen voneinander unterscheiden. Beispielsweise könnten wir uns fragen, ob Schüler\*innen, die auf dem Land wohnen mehr Alkohol trinken als Studierende, die in der Stadt wohnen. In diesem Modul werden wir zum ersten Mal Hypothesen testen, deren Prädiktoren kategoriell sind.

Um kategoriale Prädiktoren in unser Modell einzufügen, müssen wir Ihnen numerische Werte zuordnen. Anders ausgedrückt: Wir müssen einen Weg finden, Kategorien auf dem Land wohnen vs. in der Stadt wohnen, in numerische Werte umzuwandeln. Tatsächlich können wir dies tun, in dem wir diesen Kategorien willkürliche Werte zuordnen. Beispielsweise könnten wir den SuS, die auf dem Land wohnen, den Wert 1 zuordnen und den SuS, die in der Stadt wohnen den Wert -1 zuordnen. Genausogut könnten wir SuS, die auf dem Land wohnen, den Wert 289 zuordnen und SuS, die in der Stadt wohnen den Wert 5 zuordnen.

### Kontrastegewichte

Wir werden im folgenden von Kontrastgewichten sprechen, wenn folgendes gilt:

$$
\sum_k \lambda_k = 0
$$

$\lambda_k$ steht für die einzelnen Kontrastgewichte (z.B. -1). In anderen Worten: Die Summe der Kontratsgewichte sollte 0 ergeben. Daraus schließt sich, dass die Kontrastgewichte -1 und 1 gültig sind, die Kontrastgewichte 289 und 5 hingegen nicht, da ihre Summe nicht 0 ergibt. 

Achte darauf, dass wir hier die Kontrastgewichte der Anzahl der Kategorien summieren, nicht der einzelnen Personen. Die macht einen deutlichen Unterschied, sofern die Gruppengröße der einzelnen Kategorien unterschiedlich ist.

Achte auch darauf, dass die Kontrastgewichte bei zwei Kategorien von -5 und 5 ebenso gültig sind, da auch ihre Summe 0 ergibt.

## Modelle mit kategorialen Prädiktoren

Im nächsten Schritt können wir unser Modell aufstellen. Ein erweitertes Modell mit zwei kategorialen Prädiktoren benötigt immer $k - 1$ Prädiktoren. Wenn wir beispielsweise prüfen, ob Schüler\*innen, die auf dem Land wohnen mehr Alkohol trinken als Studierende, die in der Stadt wohnen, benötigen wir *einen* Prädiktor, da wir zwei Gruppen miteinander vergleichen.

$$
Y_i = \beta_0 + \beta_1 * X_1 + \epsilon_i
$$

Für den Prädiktor $X_1$ setzen wir unsere Kontrastgewichte ein. Beispielsweise 1, wenn ein\*e Schüler\*in vom Land kommt.  

Wenn wir die Betakoeffizienten berechnen, erhalten wir folgendes Modell:

$$
\hat{Y} = 2.3778 + 0.1563 * X_1
$$

Die Berechnung dieser Koeffizienten erfolgt genau gleich wie in den vorherigen Modulen. Die Koeffizienten reduizeren die quadrierte Abweichung der tatsächlichen abhängigen Werte und den hervorgesagten Werten.

### R-Exkurs - Faktoren

An dieser Stelle ist es hilfreich, einen kurzen Exkurs in R zu machen, um zu verstehen, wie kategoriale/nominal Variablen und Kontraste in R definiert werden.

Nominale Variablen werden in R als Faktoren definiert. Schauen wir uns hierzu den Datensatz einmal an:

```r
student_data <- read_csv("student_data.csv")
glimpse(student_data %>% select(address, Walc), width = 50)
```

```
Observations: 395
Variables: 2
$ address <chr> "U", "U", "U", "U", "U", "U",...
$ Walc    <dbl> 1, 1, 3, 1, 2, 2, 1, 1, 1, 1,...
```

Die Variable `address` liegt als `chr` vor, dies bedeutet, dass in dieser Variable Texte enthalten sind. In der Variable `Walc` sind `dbl` gespeichert. Es handelt sich dabei um Zahlen mit Nachkommastellen (die hier nicht dargestellt sind, da es keine gibt bei dieser Variable). Um nun unsere Variable `address` in einen Faktor umzuwandeln, können wir die Funktion `as.factor` verwenden:

```r
(student_data <- student_data %>% 
  mutate(
    address = as.factor(address)
  ))
```

```
student_selected <- student_data %>%
  select(address, Walc) %>% 
  mutate(
    address = as.factor(address)
  )

glimpse(student_selected, width = 50)
```

```
Observations: 395
Variables: 2
$ address <fct> U, U, U, U, U, U, U, U, U, U,...
$ Walc    <dbl> 1, 1, 3, 1, 2, 2, 1, 1, 1, 1,...
```

Nun siehst du, dass die Variable `address` als Faktor gespeichert ist: `fct`. Jeder Faktor hat verschiedene Levels. Anhand der Levels bestimmst du die Reihenfolge der nominalskalierten Variable. Die Reihenfolge benötigst du, um später die Kontrastegewichte exakt zu bestimmen. Schauen wir uns die Levels zunächst an:

```r
levels(student_selected$address)
```

```
[1] "R" "U"
```

Erst sind die SuS, die auf dem Land leben angegeben ("R" -> rural), dann die SuS, die in der Stadt leben ("U" -> urban).

Um die Levels händisch zu verändern, können wir die Funktion [`fct_relevel` ](https://forcats.tidyverse.org/reference/fct_relevel.html) verwenden:

```r
student_selected <- student_selected %>% 
  mutate(
    address = fct_relevel(address, "U", "R")
  )
levels(student_selected$address)
```

```
[1] "U" "R"
```

Wie du siehst, sind die Levels nun genau andersherum. Erst kommen die SuS, die in der Stadt wohnen, dann die SuS, die auf dem Land wohnen.

Wenn du später spezifische Kontrasthypothesen rechnen möchtest, ist es äußerst wichtig, dass du weißt, in welcher Reihenfolge die Faktoren auftreten, ansonsten erhältst du verfälschte Ergebnisse.

### R-Exkurs - Kontraste

> Dieser Teil hilft dir, konzeptuell zu verstehen, wie die Modelle in R auf Grundlage der Kontraste einzelner Faktoren berechnet werden. Wir werden später allerdings nicht anhand diese Methode verwenden, um Kontraste zu rechnen, sondern anhand des Pakets emmeans.

Faktoren haben nicht nur Levels, sie umfassen ebenso versteckt einzelne Kontraste. Schauen wir uns hierzu nochmal unseren Faktor an:

```r
student_selected <- student_data %>%
  select(address, Walc) %>% 
  mutate(
    address = as.factor(address)
  )
levels(student_selected$address)
```

```
[1] "R" "U"
```

Das erste Level sind die SuS vom Land, das zweite Level die SuS aus der Stadt. Im Hintergrund verwandelt R diese Buchstaben in Kontrastgewichte:

```r
contrasts(student_selected$address)
```

```
  U
R 0
U 1
```

SuS vom Land erhalten eine 0, SuS von der Stadt eine 1. Du siehst allerdings schon, dass diese Gewichte unsere Regel $\sum_k \lambda_k = 0$ brechen, da ihre Summe nicht 0 ergibt. Es handelt sich hierbei um sogenannte *dummy-kodierte* Kontraste. Wenn wir nun ein Modell aus diesen Kontrastgewichten erstellen, erhalten wir folgendes Modell:

```r
lm(Walc ~ address, data = student_selected)
```

```
Call:
lm(formula = Walc ~ address, data = student_selected)

Coefficients:
(Intercept)     addressU  
     2.5341      -0.3126
```

Dieses Modell ist allerdings nicht das gleiche, welches wir vorhin definiert hatten:

$$
\hat{Y} = 2.3778 + 0.1563 * X_1
$$

Der Grund liegt darin, dass bei diesem Beispiel andere Kontraste verwendet wurden. Wir müssen daher im nächsten Schritt die Kontraste ändern, so dass $\sum_k \lambda_k = 0$  gilt. In R können wir Kontaste ändern, indem wir eine Matrix definieren und den Kontrasten des Faktors zuweisen:

```r

```

## Interpretation der Betagewichte

## Beispiel

# Kontraste

## Konzeptuelle Einführung

## Orthogonale Kontraste

## Nicht-orthogonale Kontraste

## Geplante vs. Post-Hoc Kontraset

F-Wert Anpassung

# Statistische Inferenz

## t-Test für unabhängige Stichproben

## Einfaktorielle Varianzanalyse

# Modeling Example

Mehrere Hypothesen anzeigen
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

Der Grund liegt darin, dass bei diesem Beispiel andere Kontraste verwendet wurden. Wir müssen daher im nächsten Schritt die Kontraste ändern, so dass $\sum_k \lambda_k = 0$  gilt. In R können wir Kontaste ändern, indem wir eine Matrix definieren und den Kontrasten des Faktors zuweisen.

Im ersten Schritt erstellen wir eine Matrix. Eine Matrix kannst du dir wie ein Dataframe vorstellen, nur dass es keine Bezeichnung der Variablen gibt:

```r
(contrast_matrix <- matrix(c(1, -1), ncol = 1))
```

```
     [,1]
[1,]    1
[2,]   -1
```

Diese Matrix weißen wir den Kontrasten des Faktors zu:

```r
contrasts(student_selected$address) <- contrast_matrix
contrasts(student_selected$address)
```

```
  [,1]
R    1
U   -1
```

Wenn wir nun das Modell erneut aufstellen, erhalten wir die gleichen Koeffizienten:

```r
lm(Walc ~ address, data = student_selected)
```

```
Call:
lm(formula = Walc ~ address, data = student_selected)

Coefficients:
(Intercept)     address1  
     2.3778       0.1563
```

Im Vergleich:

$$
\hat{Y} = 2.3778 + 0.1563 * X_1
$$

In der Praxis werden wir Kontraste selten anhand von Matrizen berechnen. Für das Verständnis, wie in R Modelle erstellt werden, ist es allerdings hilfreich zu wissen, wie R Kontraste im Hintergrund speichert. Entscheidend ist, dass du weißt, welche Levels den Faktoren zugeordnet sind, um später Kontraste definieren zu können.

## Interpretation der Betagewichte

Was bedeuten allerdings die Koeffizienten dieses Modells?

$$
\hat{Y} = 2.3778 + 0.1563 * X_1
$$

Bei der einfachen und multiplen Regression konnten wir sagen, dass eine Erhöhung von $X_1$ beispielsweise $\hat{Y}$ um $b_1$ Werte steigern oder senken lässt. Diese Interpretation gelingt allerdings nicht bei kategorialen Prädiktoren.

Nehmen wir ein Beispiel. Berechnen wir zunächst den vorhergesagten Wert $\hat{Y}$ einer Schülerin, die aus dem ländlichen Bereich kommt (das Kontrastgewicht nimmt hierfür den Wert 1 an):

```r
2.3778 + 0.1563 * 1 # 2.5341
```

Weiterhin berechnen wir $\hat{Y}$ für eine Schülerin, die aus der Stadt kommt:

```r
2.3778 + 0.1563 * (-1) # 2.2215
```

Diese Einzelwerte sind nichts anderes als die beiden Mittelwerte der Gruppen:

```r
student_selected %>% 
  group_by(address) %>% 
  summarise(mean = mean(Walc))
```

```
# A tibble: 2 x 2
  address  mean
  <fct>   <dbl>
1 R        2.53
2 U        2.22
```

Der Intercept $b_0$ ($2.3778$) nun ist - bei einem Modell mit einem Prädiktor - definiert als der Wert, wenn $b_1 = 0$ gilt. Wenn daher die Kontrastgewichte zu den Mittelwerten der einzelnen Gruppen führen, ist der Intercept nichts anderes als der Mittelwert der Mittelwerte beider Gruppen.

```r
(2.5341 + 2.2215)  / 2 # 2.3778
```

# Kontraste

## Konzeptuelle Einführung

Wir haben bereits Kontraste bei Modellen kennen gelernt, mit denen wir den Unterschied zwischen zwei Gruppen testen können. Häufig hingegen haben wir allerdings mehr als zwei Gruppen, beispielsweise wenn wir drei verschiedene instruktionale Methoden testen möchten. Während wir bei zwei Gruppen die Kontrastgewichte immer mit -1 und 1 definieren können, sind die Kontrastgewichte bei mehreren Gruppen ein wenig komplexer.

In diesem Teil wirst du zunächst orthogonale Kontraste kennen lernen, die wir häufig verwenden, um Hypothesen bei mehreren Gruppen zu testen. Im nächsten Teil lernst du nicht-orthogonale Kontraste kennen, die eine bestimmte wichtige Eigenschaft der orthogonalen Kontraste nicht besitzen.

## Orthogonale Kontraste

> In diesem Teil erstellen wir ein Modell mit drei Prädiktoren bzw. vier Gruppen. Die Berechnungen dienen dem Aufstellung des Modells. Wichtig für dich ist vor allem, dass du verstehst, was orthogonale Kontraste sind und wie diese berechnet werden. Später werden wir in der Anwendung der Verfahren nicht erneut diese einzelnen Schritte händisch berechnen, sondern sie durch ein Computerprogramm übernehmen lassen.

Unsere erste Bedingung für Kontraste lautete:

$$
\sum_k \lambda_k = 0
$$


## Zwei Prädiktoren

Den Kontrast, der bei zwei Gruppen diese Bedingung erfüllt, können wir uns folgendermaßen darstellen:

|        | Rural | Urban |
|--------|:-----:|------:|
| $\lambda_{1}$ |   1   |    -1 |


Wir bezeichnen den Kontrast mit dem Lambda-Symbol $\lambda_{1}$. Bei zwei Gruppen können wir lediglich einen Kontrast aufstellen. Kontraste sind im Grunde nichts anderes als spezifische Hypothesen, die wir testen, indem wir sie als Prädiktor definieren. Beispielsweise können wir die Tabelle in folgendes Modell übersetzen:

$$
\begin{aligned}
\hat{Y} &= b_0 + b_1 * (1) \\
\hat{Y} &= b_0 + b_1 * (-1)
\end{aligned}
$$

Indem wir den Einfluss des Regressionskoeffizienten $b_1$ testen, prüfen wir quasi, ob es einen Unterschied zwischen beiden Gruppen gibt. Da es zwei Gruppen sind, genügen uns $2-1 = 1$ Prädiktoren.

### Drei Prädiktoren

Haben wir drei Gruppen, benötigen wir eine andere Kontrastkodierung und immer noch $k-1$ Prädiktoren. Beispielsweise benötigen wir zwei Kontraste, wenn wir drei Gruppen in unser Modell aufnehmen möchten. Hier ein Beispiel:

|        | Gruppe1 | Gruppe2 | Gruppe3 |
|--------|:-------:|--------:|---------|
| $\lambda_{1}$ |    -2   |       1 | 1       |
|$\lambda_{2}$| 0       | -1      | 1       |

Oder im Modell ausgedrückt:

$$
\begin{aligned}
\hat{Y} &= b_0 + b_1 * (-2) + b_2 * (0) \\
\hat{Y} &= b_0 + b_1 * (1)  + b_2 * (-1) \\
\hat{Y} &= b_0 + b_1 * (1) + b_2 * (1)
\end{aligned}
$$

Anhand des ersten Regressionskoeffizienten $b_1$ testen wir die Hypothese, ob sich der Mittelwert von Gruppe 2 sowie Gruppe 3 vom Mittelwert der Gruppe 1 unterscheidet. Anhand des zweiten Regressionskoeffizienten $b_2$ testen wir, ob sich der Mittelwert der Gruppe 2 vom Mittelwert der Gruppe 3 unterscheidet.

### Zweite Regel

Orthogonale Kontraste müssen neben folgender Regel $\sum_k \lambda_k = 0$ zusätzlich diese Regel erfüllen:

$$
\sum_k \lambda_{1} * \lambda_{2} = 0
$$

Das Produkt der einzelnen Lambdagewichte sollte 0 ergeben. Unsere beiden Kontraste von oben wären nach dieser Definition orthogonal:

```r
(-2) * 0 + 1 * (-1) + 1 * 1 # 0
```

Folgende Kontraste wären nicht orthogonal:

|        | Gruppe1 | Gruppe2 | Gruppe3 |
|--------|:-------:|--------:|---------|
| $\lambda_{1}$ |    -1   |       0 | 1       |
|$\lambda_{2}$| 0       | -1      | 1       |

Da:

```r
(-1) * 0 + 0 * (-1) + 1 * 1 # 1
```

Die Orthogonalität der Kontraste ist wichtig, da die Regressionskoeffizienten ansonsten nicht die Mittelwertsunterschiede unserer spezifischer Hypothesen testen.

















Wenn wir nun mehrere Gruppen haben, benötigen wir für jede Hypothese 




Wir hatten gerade ein Modell aufgestellt, anhand dessen wir den Unterschied zwischen zwei Gruppen testen konnte. Beispielsweise, ob SuS auf dem Land mehr Alkohol am Wochenende trinken als SuS aus der Stadt. Wir können ebenso Modelle aufbauen, bei denen wir testen, ob es zwischen **mehreren** Gruppen Unterschiede gibt. Dies versuchen wir in diesem Beispiel.

Der Datensatz enthält eine Variable mit dem Namen `reason`. Unter `reason` ist der Grund kodiert, weshalb die Eltern ihre Kinder auf die einzelnen Schulen schicken. Folgende Gründe gibt es:

* close to 'home'
* school 'reputation'
* 'course' preference
* 'other'

> Wir versuchen im nächsten Schritt ein Modell auf Grundlage dieser Gruppen zu erstellen, welches wir später benutzen können, um spezifische Hypothesen zu testen. Als abhängige Variable verwenden wir die Variable `health`. Wir möchten daher später untersuchen, ob der Grund für die Wahl eine Schule zu besuchen einen Effekt auf die Gesundheit der SuS hat (achte allerdings darauf, dass es sich hier um ein quasi-experimentelles Design handelt, da die Gruppen nicht zufällig zugeordnet wurden).

### Schritt 1: Variable in Faktor umwandeln

Schauen wir uns zunächst an, welche Gründe häufig auftreten:

```r
student_data %>% count(reason)
```

```
# A tibble: 4 x 2
  reason         n
  <chr>      <int>
1 course       145
2 home         109
3 other         36
4 reputation   105
```

Die Variable `reason` ist als `char` gespeichert (r`student_data$reason`). Wir müssen sie daher in einen Faktor umwandeln, um die Levels für den Faktor zu bestimmen:

```r
student_data <- student_data %>%
  mutate(
    reason = as.factor(reason) %>% 
      fct_relevel("course", "home", "reputation", "other")
  )
levels(student_data$reason)
```

```
[1] "course"     "home"       "reputation" "other" 
```

### Schritt 2: Kontrastegewichte bestimmen

Um zu unserem Modell zu gelangen, müssen wir im nächsten Schritt die Kontrastgewichte bestimmen. Schauen wir uns hierfür zunächst an, welche Kontraste im Hintergrund bereits aufgestellt hat:

```r
contrasts(student_data$reason)
```

```
           home reputation other
course        0          0     0
home          1          0     0
reputation    0          1     0
other         0          0     1
```

Diese Matrix ist bereits etwas komplizierter. Wir wissen, dass bei vier Gruppen $k-1$, also 3 Prädiktoren in das Modell aufgenommen werden. Diese erkennst du anhand der **Reihen** des Outputs. In dieser *Dummykodierung* berechnet sich der Mittelwert der Gruppe course daher, indem alle Prädiktoren auf 0 gesetzt werden. Wir möchten allerdings keine *Dummykodierung* verwenden, sondern sicherstellen, dass unsere Kontraste unserer Formel $\sum_k \lambda_k = 0$ entsprechen:

```
           home reputation other
course        -1          0     1
home          1          -     0
reputation    0          1     0
other         0          0     1
```

## Nicht-orthogonale Kontraste

## Geplante vs. Post-Hoc Kontraset

F-Wert Anpassung

# Statistische Inferenz

## t-Test für unabhängige Stichproben

## Einfaktorielle Varianzanalyse

# Modeling Example

Mehrere Hypothesen anzeigen
---
moduleTitle: Multiple Regression
unitTitle: Partielle Regressionskoeffizienten
title: Korrelation der Prädiktoren
module: 8
unit: 1
subunit: 0
type: instruction
---

Die multiple Regression führt uns allerdings zu einem Problem, die Redundanz der Prädiktoren. Prädiktoren sind selten gar nicht miteinander korreliert. Stell dir zum Beispiel vor, du fügst in das Modell neben der eigenen Fußgröße und der Größe des Vaters noch die *Schuhgröße des Vaters* mit ein. Die Größe des Vaters und die Schuhgröße des Vaters sind vermutlich hoch korreliert. Wer groß ist, hat auch lange Füße. Wer klein ist, hat in der Regel kurze Füße. 

Sobald Prädiktoren korrelieren, sind sie redundant. Redundanz ist ein Problem, da dadurch die Regressionskoeffizienten (z.B. $\beta_1$) keinen Aufschluss über den alleinigen Einfluss auf $\hat{Y}_i$ geben. Gehen wir ein Beispiel, um diese Idee zu verstehen: 

## Korrelation der Prädiktoren

Wir erstellen zunächst einen Datensatz mit vier Variablen:

* height: Unser Kriterium, den Wert, den wir bestimmen möchten ($\hat{Y}_i$)
* height_father: Die Körpergröße des Vaters
* footsize_father: Die Fußlänge des Vaters

```python
library(tidyverse)

person_data <- tibble(
  height   = c(182, 155, 165, 160, 180),
  height_father = c(181, 167, 180, 170, 183),
  footsize_father = c(33, 19, 31, 20, 24)
)

cor(person_data$height_father, person_data$footsize_father)
```

```
[1] 0.7700653
```

Die beiden Prädiktoren Körpergröße des Vaters und Fußlänge des Vaters sind offensichtlich hoch korreliert.

## Regressionskoeffizienten der Multiplen Regression berechnen

Berechnen wir die Regressionskoeffizienten mit R:

```python
lm(height ~ height_father + footsize_father, data = person_data) %>% 
  {.$coefficients}
```

```
    (Intercept)   height_father footsize_father 
   -106.1448282       1.5784726      -0.1410251 
```

Unser Modell ist also:

$
\hat{Y}_i = -106.144 + 1.58 * X_{i1} + -0.14 * X_{i2}
$

Wir hatten bereits gesagt, wie diese Koeffizienten zu verstehen sind: 

* $1.58$: Erhöht sich die Körpergröße des Vaters um einen Zentimeter, vergrößert sich die Körpergröße der Person um 1.58 cm.
* $-0.14$: Erhöht sich die Fußlänge des Vaters um einen Zentimeter, reduziert sich die Körpergröße der Person um 0.14 Zentimeter.


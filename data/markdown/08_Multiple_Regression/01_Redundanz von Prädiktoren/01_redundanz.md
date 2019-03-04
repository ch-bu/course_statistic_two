---
moduleTitle: Multiple Regression
unitTitle: Redundaz von Prädiktoren
title: Redundanz
module: 8
unit: 1
subunit: 0
type: instruction
---

Die multiple Regression führt uns allerdings zu einem Problem, die Redundanz der Prädiktoren. Prädiktoren sind selten gar nicht miteinander korreliert. Stell dir zum Beispiel vor, du fügst in das Modell neben der eigenen Fußgröße und der Größe des Vaters noch die *Schuhgröße des Vaters* mit ein. Die Größe des Vaters und die Schuhgröße des Vaters sind vermutlich hoch korreliert. Wer groß ist, hat auch lange Füße. Wer klein ist, hat in der Regel kurze Füße. 

Sobald Prädiktoren korrelieren, sind sie redundant. Redundanz ist ein Problem, da uns die Prädiktoren in einer multiplen Regression keinen Aufschluss darüber geben, welchen tatsächlichen Einfluss die Prädiktoren auf $Y_i$ machen. 

Ein Beispiel. Im Folgenden siehst du die gleichen Daten erweitert um die Schuhgröße des Vaters. 

```python
person_data <- tibble(
  height   = c(182, 155, 165, 160, 180),
  footsize = c(23, 20, 21, 25, 30),
  height_father = c(181, 167, 180, 170, 183),
  footsize_father = c(33, 19, 31, 20, 24)
)

cor(person_data$height_father, person_data$footsize_father)
```

```
[1] 0.7700653
```

Die beiden Prädiktoren sind offensichtlich hoch korreliert. Zusätzlich erstellen wir vier Regressionen, zwei einfache Regressionen mit den Prädiktoren des Vaters und eine multiple Regresssion:

```python
# Einfache Regression
lm(height ~ footsize_father, data = person_data) %>% {.$coefficients}
lm(height ~ height_father, data = person_data) %>% {.$coefficients}

# Multiple Regression
lm(height ~ height_father + footsize_father, data = person_data) %>% 
  {.$coefficients}
```
```
> # Einfache Regression
> lm(height ~ footsize_father, data = person_data) %>% {.$coefficients}
    (Intercept) footsize_father 
     137.012407        1.235732 
> lm(height ~ height_father, data = person_data) %>% {.$coefficients}
  (Intercept) height_father 
   -92.832689      1.482592 
> 
> # Multiple Regression
> lm(height ~ height_father + footsize_father, data = person_data) %>% {.$coefficients}
    (Intercept)   height_father footsize_father 
   -106.1448282       1.5784726      -0.1410251 
```

Wären die beiden Prädiktoren gar nicht korreliert, wären die Koeffizienten bei der multiplen Regression gleich wie bei der einfachen Regression:

$
\hat{Y}_i = 137.01 + 1.24 * X_{i1} + 1.482 * X_{i2}
$

Dem ist aber nicht so. Vielmehr erhalten wir folgendes Modell:

$
\hat{Y}_i = -106.144 + 1.58 * X_{i1} + -0.14 * X_{i2}
$


TODO: Kontrolliert für
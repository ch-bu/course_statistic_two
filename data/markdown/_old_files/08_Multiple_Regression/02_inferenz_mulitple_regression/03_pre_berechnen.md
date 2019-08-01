---
moduleTitle: Multiple Regression
unitTitle: Inferenz Multiple Regression
title: PRE berechnen
module: 8
unit: 2
subunit: 3
type: instruction
---

Im nächsten Schritt möchten wir PRE berechnen. Schauen wir uns nochmal den Datensatz an: 

```python
library(tidyverse)

person_data <- tibble(
  height   = c(182, 155, 165, 160, 180),
  footsize = c(23, 20, 21, 25, 30),
  height_father = c(181, 167, 180, 170, 183)
)
```

## Multiple Regression bestimmen

Unser Modell besteht aus zwei Parametern: *die Fußgröße des entsprechenden Person* ($X_{i1}$) und *die Körpergröße des Vaters der Person* ($X_{i2}$). Wir schätzen auf Grundlage dieser Parameter die Körpergröße einer Person ($\hat{Y}_i$):

$
\hat{Y}_i = \beta_0 + \beta_1 * X_{i1} + \beta_2 * X_{i2}
$

## Multiple Regression berechnen

Um die Regressionskoeffizienten zu erhalten, berechnen wir das Modell in R:

```python
lm(height ~ footsize + height_father, data = person_data)
```

```
Call:
lm(formula = height ~ footsize + height_father, data = person_data)

Coefficients:
  (Intercept)       footsize  height_father  
      -78.545          0.615          1.318  
```

Unser Modell ist also: 

$
\hat{Y}_i = -78.545 + 0.615 * X_{i1} + 1.318 * X_{i2}
$

## SSE(C) und SSE(A) berechnen

Im nächsten Schritt berechnen wir die Fehler, welche sich bei dem kompakten Modell als auch beim erweiterten Modell ergeben. Zur Erinnerung:

$
SSE(C) = \sum{(Y_i - \bar{Y})}^2
$

$
SSE(A) = \sum{(Y_i - \hat{Y}_i)}^2
$

$
SSE(C) = SSE(C) - SSE(A) = \sum{(\hat{Y}_i - \bar{Y})}^2
$

Zunächst müssen wir in R die einzelnen Abweichungen des tatsächlichen Wertes ($Y$) von dem vom jeweiligen Modell hervorgesagten Wert abziehen und quadrieren. Am Ende summieren wir diese Abweichungen auf, um SSE(C) und SSE(A) zu erhalten:

```python
sse <- person_data %>%
  mutate(
    sse_c = (height - mean(height))**2,
    sse_a = (height - (-78.545 + 0.615 * footsize + 1.318 * height_father))**2
  )

(sse_c <- sum(sse$sse_c)) # 108.4863
(sse_a <- sum(sse$sse_a)) # 581.2
(ssr <- sse_c - sse_a)    # 472.7137
```

## PRE berechnen

Die proportionale Reduzierung des Fehlers durch unser erweitertes Modell (hier durch eine multiple Regression) berechnet sich durch unsere gewohnte Formel:

$
PRE = \frac{SSR}{SSE(C)}
$

```python
(pre <- ssr / sse_c) # 0.8133409
```

Der Fehler unseres kompakten Modells wird also durch unser erweitertes Modell um ungefäht 81% reduziert. 
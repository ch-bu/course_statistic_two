---
moduleTitle: Multiple Regression
unitTitle: Partielle Regressionskoeffizienten
title: Für einen Prädiktor kontrollieren
module: 8
unit: 1
subunit: 4
type: instruction
---

Wenn sich nun der Regressionskoeffizient ändert, je nachdem welche Prädiktoren im Modell sind, was für eine Aussage macht der Koeffizient dann? Statistisch gesprochen würden wir sagen, der Koeffizient beschreibt den Einfluss des Prädiktors auf das Kriterium, wenn wir für eine andere Variable **kontrollieren**. 

In unserem Modell beschreiben wir also den Einfluss des Prädiktors Fußlänge des Vaters, wenn wir für die Körpergröße des Vaters kontrollieren und andersherum. 

$
\hat{Y}_i = -106.144 + 1.58 * X_{i1} + (-0.14) * X_{i2}
$

Das ist die konzeptuelle Idee, jetzt versuchen wir diese noch mathematisch zu fassen. In den nächsten Schritten erstellen wir diesen Regressionskoeffizienten ($-0.14$) aus mehreren einfachen Regressionen, damit du verstehen kannst, was *kontrolliert* bedeutet. 

Unser Ziel ist den Einfluss des Prädiktors Fußlänge des Vaters auf die Körpergröße der Person zu bestimmen, wenn für die Körpergröße des Vaters kontrolliert wird. 

## Wie viel weichen die Werte vom Durchschnitt ab? 

Wir versuchen als nächstes folgende Frage zu beantworten: 

> Wenn der Vater einer Person um 6 Zentimeter größer ist als der Durchschnitt der Väter aller Personen im Datensatz, wie viel größer als der Durschschnitt ist dann die Person? 

Zunächst müssen wir die Abweichungen vom Durchschnitt berechnen:


```python
mean_deviations <- person_data %>%
  mutate(
    height_centered          = height          - mean(height),
    height_father_centered   = height_father   - mean(height_father),
    footsize_father_centered = footsize_father - mean(footsize_father)
  )
```

```
# A tibble: 5 x 6
  height height_father footsize_father height_centered height_father_centered footsize_father_centered
   <dbl>         <dbl>           <dbl>           <dbl>                  <dbl>                    <dbl>
1    182           181              33            13.6                   4.8                      7.6 
2    155           167              19           -13.4                  -9.20                    -6.40
3    165           180              31            -3.4                   3.8                      5.6 
4    160           170              20            -8.4                  -6.20                    -5.40
5    180           183              24            11.6                   6.8                     -1.40
```

Der Vater der Person 4 beispielsweise ist 6.20 Zentimeter kleiner als der Durschschnitt (siehe Spalte `height_father_centered`). Die Fußgröße des Vaters der Person 1 ist um 7.6 Zentimeter länger als der Durchschnitt (siehe `footsize_father_centered`). 

## Wie viel größer als der Durschnitt ist eine Person, in Abhängigkeit davon wie viel größer der Vater einer Person im Durchschnitt ist? 

Diese Frage können wir durch eine einfache Regression berechnen. Wir haben die Variablen hierfür bereits berechnet: 

* "Wie viel größer als der Durschschnitt ist eine Person": `height_centered`
* "wie viel größer der Vater einer Person im Durchschnitt ist": `height_father_centered`

Aus diesen Variablen erstellen wir eine einfache lineare Regression:

```
lm(height_centered ~ height_father_centered, data = person_data) %>%
  {.$coefficients}
```

```
           (Intercept) height_father_centered 
         -2.204990e-14           1.482592e+00
```

$
\hat{Y}_i = 0 + 1.48 * X_{i1} 
$

Der Y-Achsenabschnitt ist 0, da wir die Werte zentriert haben. Diese Gleichung sagt uns nun folgendes:

> Bei Person 4, deren Vater 6.20 Zentimeter kleiner als der Durchschnitt ist, würden wir erwarten, dass die Person selber $1.48 * (-6.20) = -9.176$ Zentimeter kleiner als der Durchschnitt ist. 

Im nächsten Schritt berechnen wir die Fehler, die wir mit unserer Prognose machen. Ist Person 4 wirklich 9.176 Zentimeter kleiner als der Durchschnitt? Sicher nicht, aber wie groß ist die Differenz? Person 4 ist 8.4 Zentimeter kleiner als der Durchschnitt. Wir haben hervorgesagt, dass die Person 9.176 Zentimeter als der Durschchnitt ist. Unser Fehler ist also:

$
e_4 = -8.4 - (1.48 * (-6.20)) = -8.4 - (-9.176) = 0.776
$

Wir überschätzen also die Abweichung vom Mittelwert um 0.776 Zentimeter. Berechnen wir diese Werte für alle Personen:

```python
(deviations_height_by_height_father <- mean_deviations$height_centered - 
  (1.48 * mean_deviations$height_father_centered))
```

```
[1]  6.496  0.216 -9.024  0.776  1.536
```

Wir sehen erneut, den Wert 0.776 für Person 4. 

## Wie viel größer als die Fußlänge des Vaters einer Person, in Abhängigkeit davon, wie viel größer der Vater einer Person im Durchschnitt ist? 

Diese Frage können wir erneut durch einfache Regression berechnen. Die Variablen sind:

* "Wie viel größer als die Fußlänge des Vaters einer Person": `footsize_father_centered`
* "wie viel größer der Vater einer Person im Durchschnitt ist": `height_father_centered`

Aus diesen Variablen erstellen wir eine einfache lineare Regression:

```
lm(footsize_father_centered ~ height_father_centered, data = person_data) %>%
  {.$coefficients}
```

```
           (Intercept) height_father_centered 
         -6.767090e-15           6.798839e-01
```

$
\hat{Y}_i = 0 + 0.6799 * X_{i1} 
$

> Bei Person 4, dessen Vater 6.20 Zentimeter kleiner als der Durchschnitt ist, würden wir erwarten, dass die Fußlänge des Vaters der Person 4 $0.6799 * (-6.20) = -4.22$ Zentimeter kleiner als der Durchschnitt ist. 

Im nächsten Schritt berechnen wir erneut die Fehler, die wir mit unserer Prognose machen. Ist die Fußlänge des Vaters der Person 4 wirklich 4.22 Zentimeter kleiner als der Durchschnitt? Die Fußlänge des Vaters von Person 4 ist 5.40 Zentimeter kleiner als der Durchschnitt. Unser Fehler ist also:

$
e_4 = -5.40 - (0.6799 * (-6.20)) = -5.40 - (-4.22) = -1.18
$

Wir unterschätzen also die Abweichung vom Mittelwert um 0.776 Zentimeter. Berechnen wir diese Werte für alle Personen:

```python
(deviations_foot_father_by_height_father <- mean_deviations$footsize_father_centered - 
  (0.68 * mean_deviations$height_father_centered))
```

```
1]  4.336 -0.144  3.016 -1.184 -6.024
```

Wir sehen erneut, den Wert -1.18 für Person 4. 

## Inwieweit kann ich die Abweichung der Körpergröße einer Person, die nicht auf die Körpergröße des Vaters zurück geht, durch die Abweichung der Fußgröße des Vaters erklären, die nicht auf die Körpergröße des Vaters zurück geht?

Der Satz ist brutal, er spiegelt aber zurück, was wir als **partiellen Regressionskoeffizienten* bezeichnen. Der partielle Regressionskoeffizient bei einer multiplen Regression gibt den Einfluss eines Prädiktors auf ein Kriterium an, der durch einen anderen Prädiktor kontrolliert ist. 

Wir berechnen daher:

```python
lm(deviations_height_by_height_father ~ deviations_foot_father_by_height_father, 
   data = NULL) %>%
   {.$coefficients}
```

```
   (Intercept) deviations_foot_father_by_height_father 
  -2.313977e-14                           -1.410260e-01 
```

Dies entspricht des linearen Regressionsmodels:

$
\hat{Y}_i = 0 + (-1.41)* X_{i1} 
$

Wenn wir nun das Modell für unsere multiple Regression betrachten, sehen wir, dass der Regressionskoeffizient in diesem Modell gleich dem partiellen Regressionsmodell der multiplen Regression ist. 

$
\hat{Y}_i = -106.144 + 1.58 * X_{i1} + (-0.14) * X_{i2}
$

Wir haben also für die Körpergröße des Vaters kontrolliert und den restlichen Einfluss des Prädiktors Fußlänge des Vaters auf die Körpergröße einer Person berechnet. 
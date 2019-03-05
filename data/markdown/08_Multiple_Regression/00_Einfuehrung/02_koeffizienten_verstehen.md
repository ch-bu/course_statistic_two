---
moduleTitle: Multiple Regression
unitTitle: Multiple Regression
title: Koeffizienten verstehen
module: 8
unit: 0
subunit: 2
type: instruction
---

Schauen wir uns nochmal unsere multiple Regression mit den Prädiktoren Fußgröße und Körpergröße des Vaters an:

$
Y_i = \beta_0 + \beta_1 * X_{i1} + \beta_2 * X_{i2} 
$

$
\hat{Y}_i = -78.545 + 0.615 * X_{i1} + 1.318 * X_{i2}
$

Die Regression hat drei Koeffizienten und zwei Parameter (Fußgröße und Körpergröße des Vaters). Gehen wir sie einzeln durch.

## $\beta_0$ - Y-Achsenabschnitt

<singlechoice question="Welche Größe wird laut dem Modell für eine Person eingeschätzt, deren Fußgröße 0 ist und dessen Vater 0 cm groß ist?"></singlechoice>

Der Koeffizient $\beta_0$ ist der Y-Achsenabschnitt. Wenn alle Parameter auf null gesetzt sind, berechnet sich $\hat{Y}_i$ aus diesem Koeffizienten. Der Koeffizient muss nicht immer Sinn ergeben. Manchmal gibt er Werte zurück, die gar unmöglich sind. Das liegt aber meistens daran, dass die Prädiktoren, welche eingegeben wurden, ebenso nicht realistisch sind. 

## $\beta_1$ - Der Einfluss der Fußgröße

$
\hat{Y}_i = -78.545 + 0.615 * X_{i1} + 1.318 * X_{i2}
$

Der zweite Koeffizient gibt in diesem Modell an, um wie viel sich die Körpergröße ändert, wenn sich die Fußgröße um einen Wert ändert. Unser Model sagt einen $\beta_1$ von 0.615 voraus. Das bedeutet folgendes: 

> Steigt die Fußgröße um den Wert 1, dann steigt die Körpergröße um 0.615 cm. 

Wenn wir dementsprechend den realen Wert von $X_{i1}$ angeben, können wir berechnen, um wie viel Punkte sich die Körpergröße der Person in Abhängigkeit ihrer Fußgröße ändert. Zum Beispiel: $0.615 * 30 = 18.45$. Wenn eine Person eine Fußgröße von 30 hat, dann justieren wir die Körpergröße im Relation zum Y-Achsenabschnitt um 18.45 Zentimeter nach oben. 

## $\beta_2$ - Der Einfluss der Körpergröße des Vaters

$
\hat{Y}_i = -78.545 + 0.615 * X_{i1} + 1.318 * X_{i2}
$

Der dritte Koeffizient gibt in diesem Modell an, um wie viel sich die Körpergröße ändert, wenn sich die Körpergröße des Vaters um einen Wert ändert. Unser Model sagt einen $\beta_2$ von 1.318 voraus. Das bedeutet folgendes: 

> Steigt die Körpergröße des Vaters um den Wert 1, dann steigt die Körpergröße, die wir hervorsagen möchten um 1.318 cm.
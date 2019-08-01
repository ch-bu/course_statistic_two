---
moduleTitle: Statistische Modelle
unitTitle: Notation
title: Notation
module: 2
unit: 2
subunit: 0
type: instruction
---

Wir werden in den nächsten Wochen immer wieder statistische Modelle anschauen und analysieren. Um zu wissen, wovon wir sprechen, ist es wichtig, dass wir die Notation der Begriffe vorab definieren:

* $Y_i$ steht für den Einzelwert von *DATA*, den Werten, welche wir hervorsagen, beziehungsweise den Werte unserer abhängigen Variable. Das kleine $i$ steht für das Untersuchungsobjekt, welches wir gerade betrachten. In der Regel sind das einzelne Menschen. 
* $\hat{Y}_i$ steht für unseren auf Grundlage des Modells hervorgesagten Wertes. Der reale Wert setzt sich aus der Schätzung und dem Fehler zusammen.: $Y_i = \hat{Y}_i + e_i$
* $X_{ij}$ steht für die Variablen, welche wir in unser Modell hinzufügen. $i$ steht für das Untersuchungsobject, $j$ steht für die Nummer der Variable (wir werden später mehrere dieser Variablen haben)
* $\beta_{0}, \beta_{1}, ...$ steht für die Parameter unseres Modells, welche wir finden möchten. Wir werden diese Werte allerdings **nie** exakt bestimmen können, da wir nie Daten von ganzen Populationen haben. Als Faustregel gilt: Sobald ein $\epsilon$ in der Gleichung enthalten ist, spreche ich von Parametern, die in der Population gelten (z.B. $\beta_{0}). 
* $b_0, b_1, ...$ stehen für die Parameter, welche ich auf Grundlage meiner Daten geschätzt habe. Beispielsweise schätze ich den Mittelwert der Population auf Grundlage des Mittelwerts meiner Stichprobe. $b$ wird immer in Kombination mit $\hat{Y}$ verwendet.
* $e_0, e_1, ...$ stehen für die Fehler, die wir aus dem Modell berechnen, welches wir berechnet haben. $e$ wird also immer in Zusammenhang mit $b$ verwendet und nie mit $\beta$. 

## Ein Beispiel

Du untersuchst, ob ein erweitertes Modell, welches die Tatsache einberechnet, ob jemand krank ist, die Temperatur von Personen besser hervorsagen kann als ein Modell, dass lediglich annimmt, dass alle Personen die gleiche Körpertemperatur haben.

### Nullhypothese

Deine Nullyhpothese lautet:

$$
Y_i = \beta_{0} + \epsilon_{i}
$$

Die einzelnen Werte dieser Nullhypothese schätzt du mit folgender Formel:

$$
\hat{Y}_i = b_0
$$

$$
\hat{Y}_i = 37 
$$

### Alternativhypothese

Bei deiner Alternativhypothese gehst du zusätzlich davon aus, dass die Tatsache, ob jemand eine Erklärung hat oder nicht, einen Einfluss auf die Körpertemperatur hat. Du erhältst dadurch einen weiteren Parameter. Deine Alternativhypothese lautet also:

$$
Y_i = \beta_{0} + \beta_{1} * X_{i} + \epsilon_{i}
$$

Die Körpertemperatur deiner Stichprobe ist im Schnitt 37.2°. Wenn jemand eine Erlkältung hat, sagt dein Modell heraus, dass die Körpertemperatur um 0.6° steigt ($X_1 = 1$). Ohne Erkältung schätzt du die Körpertemperatur auf 37.4° ($X_1 = 0$) Die einzelnen Werte dieser Alternativhypothese schtzt du mit folgender Formel:

$$
\hat{Y}_i = b_0 + b_1 * X_1
$$

$$
\hat{Y}_i = 37.2 + 0.6 * X_1
$$

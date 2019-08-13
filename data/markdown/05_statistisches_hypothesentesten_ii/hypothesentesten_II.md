# F-Verteilung und F-Wert

## Konzeptuelles Verständnis

PRE findet man selten in statistischen Büchern. Viel häufiger sind F-Werte, ein Kennwert, der PRE sehr nahe steht. F hat den Vorteil, dass wir durch F die Reduktion des Fehlers für *jeden zusätzlichen Parameter* des erweiterten Modells berechnen können. 

> Ein F-Wert ist das Verhältnis zwischen dem Fehler, welcher durch Parameter des erweiterten Modells reduziert werden und dem Fehler, welcher durch einen willkürlichen weiteren Parameter reduziert werden könnte.

F ist daher ein Kennwert, welcher uns anzeigt wie viel besser bestimmte Parameter im Vergleich zu willkürlichen Parametern in dem erweiterten Modell sind. 

* Ein F-Wert von 1 bedeutet beispielsweise, dass die Parameter im erweiterten Modell genausoviele Fehler des kompakten Modells reduziert wie man es bei einem willkürlich hinzugefügten Parameter erwarten würde. Werte von 1 führen daher nicht zu einer statistischen Signifikanz.
* Werte unter 1 bedeuten, dass die Parameter des erweiterten Modells den Fehler des kompakten Modells *geringer* reduzieren als ein willkürlicher Parameter. Auch in diesem Fall nehmen wir weiterhin die Nullhypothese an. 
* F-Werte über 1 bedeuten, dass die Parameter des erweiterten Modells mehr Fehler reduzieren als ein willkürlicher Parameter. Bei einem hohen F-Wert (z.B. über 5) sprechen wir daher von einem statistisch Signifikanten Ereignis.

### Ein Beispiel

Stell dir beispielsweise vor, dein kompaktes Modell schätzt das Gehalt einer Mitarbeiterin auf 6000 Dollar. Dieses Modell hat keinen Parameter, da es kein $b$ umfasst:

$$
\hat{Y} = 6000 + e = 6000
$$

Dein erweitertes Modell wiederum schätzt das Gehalt einer Person auf Grundlage des Mittelwertes der Stichprobe und hat daher einen Parameter ($b_0$):

$$
\hat{Y} = b_0 + e = \bar{X}
$$

Ein F-Wert würde nun für $b_0$ kennzeichnen, wie viel mehr Fehler durch diesen Parameter reduziert werden als man durch einen willkürlichen Parameter annehmen könnte. Beispielsweise hätten wir genausogut das Gehalt einer Person auf Grundlage der mittleren Schuhgröße der Stichprobe oder dem Abstand der Personen vom Wohnort berechnen können.


## F berechnen

F berechnet sich folgendermaßen:

$$
F = \frac{PRE / (PA - PC)}{(1 - PRE) / (n-PA)}
$$

### Der Zähler

Im Zähler berechnen wir die proportionale Reduktion des Fehlers in Abängigkeit bestimmter Parameter unseres erweiterten Modells: $PRE / (PA - PC)$. Momentan beschäftigen wir uns noch mit Modellen mit nur einem Parameter (z.B. $b_0$). Später werden wir mehrere Parameter in unseren Modellen haben. Zum Beispiel: $\hat{Y} = b_0 + X_1 * b_1 + X_2 * b_2$. Der Zähler gibt daher an, wie viel Fehler durch diesen einzelnen Parameter reduziert werden. 

Stell dir erneut vor, dein kompaktes Modell schätzt das Gehalt einer Mitarbeiterin auf 6000 Dollar. Dieses Modell hat keinen Parameter, da es kein $b$ umfasst. Dein erweitertes Modell wiederum schätzt das Gehalt einer Person auf Grundlage des Mittelwertes der Stichprobe und hat daher einen Parameter ($b_0$): Dein Zähler wäre daher:

$$
PRE / (1 - 0)
$$

Der Zähler gibt daher an, dass durch diesen einen weiteren Parameter der Fehler um einen bestimmten Anteil reduziert wird.

### Der Nenner

Im Nenner kennzeichnen wir wie viel Prozent der Fehler, welche wir durch die weiteren Parameter des erweiterten Modells nicht erklären können ($1 - PRE$), durch einen willkürlichen weiteren Parameter ($n - PA$) erklärt werden könnte. Wir können immer nur so viele Parameter in ein Modell aufnehmen, wie wir Datenpunkte besitzen. Die maximale Anzahl an Parametern ist daher $n$. Da wir allerdings bereits ein paar Parameter für $PA$ verwendet haben, bleiben uns nur noch $n - PA$ Parameter übrig.

### Freiheitsgrade

In der statistischen Literatur spricht bei $PA - PC$ und $n - PA$ von Freiheitsgraden. Diese werden für jedes inferenzstatistische Verfahren verwendet. An dieser Stelle ist es wichtig, dass du weißt, dass diese Berechnungen auch mit diesem Begriff benannt werden.

### Eine weitere Definition




## Ein Beispiel



# Statistische Power

## Was ist Power / Teststärke

## Power und Stichprobenkennwertverteilungen

## Einflüsse auf die statistische Power

# Effektstärken

## Cohen's D

## Eta-Quadrat

# Konfidenzintervalle

## Konzeptuelles Verständnis

## Konfidenzintervalle berechnen

## Konfidenzintervalle in R simulieren

# One Sample T-Test

## T-Verteilung

## Konzeptuelles Verständnis

## Beispiel T-Test

## Unterschied zu z-Test

## Äquivalenz zum F-Test

## Beispiel in R und Jamovi

## Gerichtete und ungerichtete Hypothesen

# Modeling Example



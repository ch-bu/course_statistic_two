---
moduleTitle: Statistische Modelle
unitTitle: Proportional Reduction in Error (PRE)
title: Null- und Alternativhypothese
module: 2
unit: 1
subunit: 5
type: instruction
---

In Statistikbüchern liest man selten von kompakten und erweiterten Modellen. Viel gebräuchlicher sind die Begriffe Null- und Alternativhypothese:

* Nullhypothese = kompaktes Modell
* Alternativhypothese = erweitertes Modell

Genauer müssten wir sagen, dass die Nullhypothese das Modell ist, bei welchem alle Parameter, die zusätzlich in dem erweiterten Modell sind, auf Null gesetzt werden. Deswegen heißt die Nullyhypothese so. 

Hier ein Beispiel: Meine Nullhypothese ist, dass die Intelligenz von Menschen 100 im Schnitt ist:

$
Y_i = \beta_{0} + \epsilon_{i} = 100 + \epsilon_{i}
$

$
Y_i = 100 + \epsilon_{i}
$

Meine Alternativehypothese hat einen weiteren Parameter ($\beta_{1}$), nämlich wie stark die Intelligenz der Mutter von 100 abweicht. Der Wert -10 würde zum Beispiel bedeuten, dass die Mutter 10 Intelligenzpunkte weniger hat als 100, also 90 (die Werte sind frei ausgedacht, wie man zu diesen Werten kommt, lernst du später):

$
Y_i = \beta_{0} + \beta_{1} * X_1 + \epsilon_{i}
$

$
Y_i = 100 + 0.8 * X_1 + \epsilon_{i}
$

Statt 100 wie bei der Nullyhypothese würde ich nun $100 + 0.8 * -10 = 92$ als Intelligenzquotienten für die Person hervor sagen.


## Statistisches Hypothesentesten

Wenn nun mein erweitertes Modell den Fehler des kompakten Modells substantiell minimiert (wir kommen später im Kurs darauf, was das bedeutet), *lehne ich die Nullhypothese zu Gunsten der Alternativhypothese ab*. Ist der Fehler *nicht* substantiell kleiner als in der Nullhypothese, gehe ich weiter von der Nullhypothese aus, sage also, dass die Nullhypothese das beste und sparsamste Modell ist, um meine abhängige Variable hervorzusagen. 
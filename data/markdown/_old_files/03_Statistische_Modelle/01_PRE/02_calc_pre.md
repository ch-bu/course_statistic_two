---
moduleTitle: Statistische Modelle
unitTitle: Proportional Reduction in Error (PRE)
title: Proportional Reduction in Error
module: 2
unit: 1
subunit: 2
type: instruction
---

Um entscheiden zu können, ob die Reduzierung des Fehlers durch das erweiterte Modell groß genug ist, müssen wir einen Weg finden, die Reduzierung des Fehlers zu bestimmen. Wir werden im Verlaufe des Kurses zwei dieser Wege aufzeichnen: *PRE* und *F*. Zunächst beschäftigen wir uns aber mit *PRE*. 

> PRE lässt sich wie folgt definieren: Wie viel Prozent des Fehlers im kompakten Model wird durch das erweiterte Modell reduziert? 

Beispielsweise könnte PRE den Wert .80 annehmen. Das würde bedeutet, dass das erweiterte Modell 80% der Fehler des kompakten Modells reduziert. Berechnet wird PRE folgendermaßen:

$$
PRE = \frac{ERROR(C) - ERROR(A)}{ERROR(C)}
$$

Zwei Dinge sind hierbei wichtig: 

1. Wir müssen ERROR(A) von ERROR(A) abziehen und nicht umgekehrt, da wir wissen, dass der Fehler des erweiterten Modells immer kleiner ist als der Fehler des kompakten Modells. Ansonsten würden wir einen negativen Wert erhalten. 
2. Wir teilen das Resultat aus der Subtraktion von ERROR(C) - ERROR(A), um ein *relatives* Maß zu erhalten. Relativ abhängig vom kompakten Modell. 

Eine alternative Schreibweise für PRE ist: 

$$
PRE = 1 - \frac{ERROR(A)}{ERROR(C)}
$$
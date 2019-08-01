---
moduleTitle: Statistische Modelle
unitTitle: Proportional Reduction in Error (PRE)
title: Kompaktes und erweitertes Modell
module: 2
unit: 1
subunit: 0
type: instruction
---

Wir hatten gerade gesagt, dass wir den Fehler reduzieren möchten und gleichzeitig Parameter in das Modell aufnehmen möchten, die es wert sind, aufgenommen zu werden, sprich, die den Fehler substantiell reduzieren. Wie können wir allerdings bestimmen, ob ein Parameter nun *gut genug ist*, um aufgenommen zu werden? 

> Um die Güte von Parameter einzuschätzen, vergleichen wir zwei Modelle miteinander, das kompakte Modell (C - compact) und das erweiterte Modell (A - augmented). 

## Das kompakte Modell (C)

Das kompakte Modell ist in der Regel das einfachste Modell, welches wir uns vorstellen können. Wir haben bereits kompakte Modelle kennen gelernt: z.B. den Mittelwert einer Verteilung. 

> Das kompakte Model nehmen wir immer als **Referenz**, um heraus zu finden, ob Parameter gut genug sind, um den Fehler substantiell zu reduzieren.

## Das erweiterte Modell (A)

Das erweiterte Modell hat immer mehr Parameter als das kompakte Modell; daher erweitert. Wir wissen, dass der Fehler eines Modells kleiner wird, je mehr Parameter wir in ein Modell hinzu nehmen. Daher gilt:

$$
ERROR(A) \leq ERROR(C)
$$
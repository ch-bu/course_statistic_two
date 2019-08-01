---
moduleTitle: Statistische Modelle
unitTitle: Einführung
title: Fehler reduzieren - Wie? 
module: 2
unit: 0
subunit: 4
type: instruction
---

Es gibt verschiedene Möglichkeiten, den Fehler bei statistischen Modellen zu reduzieren:

## Qualität der Daten verbessern

Zunächst können wir dafür sorgen, dass die Daten ohne Fehler erhoben und eingetragen wurden. Manche Menschen machen Fehler, wenn sie Daten in Excel-Tabellen eintragen, manchmal ist ein Verfahren aber auch unreliabel und zeigt inkonsistente Werte an. Beispielsweise kann eine Waage unreliabel sein, wenn sie beim gleichen Gewicht schwankende Werte angibt. 

## Hinzufügen von mehr Parametern

Je mehr Parameter man in ein statistisches Modell hinzufügt, desto geringer wird der Fehler. Wir könnten bei unserem Modell zur Intelligenz beispielsweise den Parameter Hochschulabschluss hinzunehmen: 

* Bei Menschen, die einen Hochschulabschluss haben, schätzen wir die Intelligenz anhand des Mittelwertes der Intelligenz aller Personen, die einen Hochschullabschluss haben
* Bei Menschen die keinen Hochschullabschluss haben, schätzen wir die Intelligenz anhand des Mittelwerts Intelligenz aller Personen, die keinen Hochschullabschluss haben

$$
Y_i = \beta_{0} + \beta_{1} * X_{1} + ERROR
$$

* $\beta_{0}$ repräsentiert in diesem Fall den Mittelwert von Personen ohne Hochschullabschluss
* $X_{1}$ ist entweder 0 oder 1. 0, wenn eine Person keinen Hochschullabschluss hat, 1, wenn die Person einen Hochschulabschluss hat. 
* $\beta_{1}$ repräsentiert den Unterschied des Intelligenzquotienten zwischen Personen, die einen Hochschullabschluss haben und Personen, die keinen Hochschullabschluss haben.

Hypothetisch könnten wir uns folgendes Modell ausdenken:

$$
Y_i = 100 + 10 * X_{1} + ERROR
$$

Das Modell würde in diesem Fall für Menschen, die keinen Hochschullabschluss haben, einen Intelligenzquotienten von 100 vorschlagen und bei Menschen die einen Hochschullabschluss haben, einen Intelligenzquotienten von 110 vorschlagen. Durch das Hinzufügen dieses Parameters haben wir nun die Hervorsagen von DATA abhängig von einer anderen Variable (hier Hochschullabschluss) gemacht. 

## Die Gefahr beim Hinzufügen von Parametern

Wir könnten noch weitere Parameter hinzufügen (z.B. Anzahl der Bücher im Haus, Intelligenz der Mutter). Schließlich wird der Fehler kleiner, je mehr Parameter im Modell sind. Das wäre allerdings ein Fehler. Im Extremfall würde unser Modell aus so vielen Parametern wie Datenpunkten bestehen. Das Modell würde so aussehen: Jede Person erhält den tatsächlichen Wert, den die Person hat: *Wenn die Person Hans ist, gebe ihr einen IQ von 103.4*. Das wäre widersinnig, da ich dadurch gar keine Werte zusammen gefasst hätte. Zudem wäre so ein Modell langweilig, schließlich werden nur Werte kopiert. 

> Unser Ziel muss es vielmehr sein, so wenige Parameter wie möglich zu verwenden und den Fehler so klein wie möglich zu halten. 

Als Folge haben wir ein Problem: Einerseits sollen die Fehler klein gehalten werden, andererseits sollen so wenig Parameter wie möglich verwendet werden!? Deine Aufgabe als statistisch arbeitenden Menschen ist es, die richtige **Balance** der beiden Ansprüche zu finden. Für jeden Parameter müssen wir uns daher die Frage stellen, ob der Parameter *gut genug ist*, um den Fehler substantiell zu reduzieren. Ein Parameter in unserem Beispiel, der vermutlich den Fehler nicht reduzieren würde, wäre die Lieblingsfarbe einer Person. Wir haben keine theoretischen Begründungen, weshalb jemand der die Farbe *grün* mag, eine höhere Intelligenz haben sollte als jemand, der die Farbe *blau* mag. 
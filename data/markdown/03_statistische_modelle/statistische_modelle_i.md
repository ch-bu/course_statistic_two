# Data = Model + Error

Der ganze Inhalt dieses Kurses lässt sich in einer Gleichung zusammen fassen:

$$
DATA = MODEL + ERROR
$$

## DATA 

*DATA* sind die Werte, welche wir empirisch erheben. Beispielsweise untersuchen wir, wie gut Lernende in einem Test abschneiden oder wir erheben wie Personen einen Kurs bewerten. In der Statistik wird *DATA* häufig auch als *abhängige Variable* bezeichnet.

Als Beispiel können wir die Intelligenz einer Person nehmen. Der Intelligenzquotient einer Person ist *DATA*, also die Punktzahl der Intelligenz, die wir in einem Test von einer Person erhalten. Unser Ziel ist es, ein mathematisches Modell zu bilden, welches diesen Wert wirklichkeitsgetreu hervorsagt. Solche Modelle werden wir in diesem Kurs ausführlich behandeln.

## MODEL

*MODEL* bezeichnet ein mathematisches Modell, welches wir benutzen, um *DATA* hervorzusagen. In der Regel versuchen wir eine Vielzahl an Daten in einer verständlichen Form zusammen zu fassen. In einem Zeitungsbericht findest du selten lange Tabellen mit allen Daten eines Experiments. Vielmehr werden in der Regel einzelne Kennwerte vermittelt: 70% der Personen stimmten für Politiker X; Menschen haben im Schnitt einen Intelligenzquotienten von 100. Diese Werte sind nichts anderes als statistische Modelle, auch wenn diese sehr einfach sind. Das einfachste statistische Modell ist beispielsweise der Mittelwert einer Variable. Modelle werden wir in diesem Kurs anhand von Gleichungen darstellen. Beispielsweise nehmen wir in folgendem Modell an, dass der Intelligenzquotient jeder Person gleich 100 ist:

$$
\hat{Y} = 100
$$

## ERROR

Die Werte, welche unsere Modelle schätzen werden in der Regel nicht DATA entsprechen. Die Abweichungen zwischen dem tatsächlichen Wert (DATA) und dem geschätzem Wert nennen wir ERROR oder auch *Residuum*. Stell dir vor, eine Person hat einen Intelligenzquotienten von 110, wir schätzen allerdings die Intelligenz dieser Person anhand des Mittelwertes auf 100. In diesem Fall hätten wir eine Abweichung von 10 Punkten und dementsprechend einen ERROR von 10 Punkten.

# Ein Beispiel

Stell dir vor, du hast die Intelligenz von 78 Probanden durch einen Intelligenztest erhoben. Jeder Proband hat eine ID erhalten. Hier siehst du die Intelligenzwerte dieser 78 Probanden:

```R
ggplot(new_data, aes(x = intelligence_pre, y = reorder(id, intelligence_pre))) + 
  geom_point() +
  labs(
    x = "Intelligenz",
    y = "Probanden-ID",
    title = "Einzelne Intelligenzwerte der Probanden"
  ) +
  theme_light()
```

![IQ Distribution](./images/intelligence_subjects.png)

Proband 52 beispielsweise (siehe Y-Achse) hat den geringsten Intelligenzquotienten von eta 73, während Proband 26 den höchsten Intelligenzquotienten hat. 

Diese Werte nennen wir **DATA**, da sie die tatsächlichen Werte der Probanden sind.

Wir können **DATA** ebenso in einem Histogram darstellen:

```R
ggplot(new_data, aes(x = intelligence_pre)) + 
  geom_histogram(color = "black", fill = "#cccccc", binwidth = 3) +
  labs(
    x = "Intelligenz",
    y = "Häufigkeit",
    title = "Histogram der Intelligenz der Probanden"
  )
```
![IQ Histogram](./images/intelligence_histogram.png)

Auf der X-Achse siehst du die Intelligenz der Personen, auf der Y-Achse die Häufigkeit dieser Werte.

Wir hatten gerade den Mittelwert als ein einfaches Modell angenommen. Diesen Wert können wir im Histogram abtragen:

```R
ggplot(new_data, aes(x = intelligence_pre)) + 
  geom_histogram(color = "black", fill = "#cccccc", binwidth = 3) +
  geom_vline(
    xintercept = mean(new_data$intelligence_pre),
    color = "steelblue",
    size = 2
  ) +
  labs(
    x = "Intelligenz",
    y = "Häufigkeit",
    title = "Histogram der Intelligenz der Probanden"
  )
```

![IQ Mean](./images/intelligence_mean.png)

Der Mittelwert wäre nun ein Beispiel für ein **Model**. Anhand des Histograms kannst du bereits erkennen, dass der Mittelwert kein gutes Modell ist, um die einzelnen Werte zu bestimmen. Beispielsweise liegt die Person 26 über 40 Intelligenzpunkte über dem Mittelwert. Ebenso ist die Person mit dem geringsten Intelligenzquotienten über 25 Punkte unter dem Mittelwert. Wenngleich das Modell nicht in der Lage ist, die einzelnen Werte gut hervorzusagen, ist es ein Modell, welches DATA hervorsagt und dabei Fehler macht:

$$
DATA = MODEL + ERROR
$$

Der Fehler wäre:

$$
ERROR = DATA - MODEL
$$

Schätzen wir daher den Intelligenzquotienten einer Person auf 100 und liegt der Intelligenzquotient dieser Person bei 110, hätten wir einen Fehler von +10.

Wir werden im nächsten Abschnitt **ERROR** genauer bestimmen. Vorab müssen wir nochmal über die Modelle sprechen.


# Kurzfrage

Stell dir folgendes Szenario vor: Du schätzt, wie alt Menschen in Deutschland werden, die im Jahr 2015 geboren sind. Du schätzt, dass Personen, die im Jahr 2015 geboren sind, im Schnitt 86 Jahre alt werden (dein Modell). Nach 105 Jahren liegen Daten zu deiner Schätzung vor. Mareike, welche im Jahr 2015 geboren ist, wurde 84 Jahre alt.

```
- question: Wie groß ist der Fehler (ERROR) für Mareike? 
  answers:
    - answer: "-2"
      correct: True
      hint: Sehr gut. Der Fehler ist ERROR = DATA - MODEL. Also ERROR = 84 - 86 = -2
    - answer: "2"
      correct: False
      hint: Nicht ganz. Erinnere dich daran das der Fehler ERROR = DATA - MODEL ist
    - answer: "19"
      correct: False
      hint: Nicht ganz. Erinnere dich daran das der Fehler ERROR = DATA - MODEL ist
    - answer: "-19"
      correct: False
      hint: Nicht ganz. Erinnere dich daran das der Fehler ERROR = DATA - MODEL ist
    - answer: "4"
      correct: False
      hint: Nicht ganz. Erinnere dich daran das der Fehler ERROR = DATA - MODEL ist
```

# Frage 2

```
- question: Welches dieser Beispiele ist kein statistisches Modell? Eine Antwort ist richtig.
  hint: Überlege dir, welches dieser Kennwerte mehrere Daten nicht zusammen fasst. 
  answers:
    - answer: Der Mittelwert einer Verteilung
      correct: False
    - answer: Der Modus einer Verteilung
      correct: False
    - answer: Die Einzelwerte einer Verteilung
      correct: True
    - answer: Die Standardabweichung einer Verteilung
      correct: False
```

# Ziele von Modellen

Ein gutes statistisches Modell ist ein Modell, welches die Fehler (ERROR) klein hält und gleichzeitig nicht zu komplex ist. In der Sozialforschung haben wir fast nie Modelle, bei denen wir Fehler von 0 erhalten. Dennoch möchten wir versuchen, diesen Fehler so klein wie möglich zu halten.

Es ist offensichtlich, dass ein einfaches Modell wie der Mittelwert einer Verteilung in der Regel denkbar schlecht ist, um den Fehler klein zu halten. Schauen wir nochmal die Verteilung von gerade eben an:

![IQ Mean](./images/intelligence_mean.png)

Offensichtlich brauchen wir mehr Informationen als den Mittelwert, um zu berechnen, wie hoch der Intelligenzquotient einer Person ist. Man könnte sich zum Beispiel vorstellen, dass die Anzahl der gelesenen Bücher pro Jahr ein guter Parameter sind, um die Intelligenz einer Person genauer hervorzusagen.

# Wie kann der Fehler reduzuiert werden?

Es gibt verschiedene Möglichkeiten, den Fehler bei statistischen Modellen zu reduzieren:

## Qualität der Daten verbessern

Zunächst können wir dafür sorgen, dass die Daten ohne Fehler erhoben und eingetragen wurden. Manche Menschen machen Fehler, wenn sie Daten in Excel-Tabellen eintragen, manchmal ist ein Verfahren aber auch unreliabel und zeigt inkonsistente Werte an. Beispielsweise kann eine Waage unreliabel sein, wenn sie beim gleichen Gewicht schwankende Werte angibt.

## Hinzufügen von mehr Parametern

Je mehr Parameter man in ein statistisches Modell hinzufügt, desto geringer wird der Fehler. Wir könnten bei unserem Modell zur Intelligenz beispielsweise folgende Parameter hinzunehmen:

* die Anzahl der Bücher, die eine Person liest
* die Intelligenz der Eltern
* den höchsten akademischen Abschluss einer Person

Mit jedem Paramater reduziert sich der Fehler. Man könnte daher intuitiv annehmen, dass es sinnvoll wäre, möglichst viele Parameter in ein Modell hinzuzunehmen. Dem ist allerdings nicht so.


## Die Gefahr beim Hinzufügen von Parametern

Ein Modell um unendlich viele Parameter zu erweitern ist nicht sinvoll, da nicht Daten perfekt hervorsagen möchten, sondern wissen möchten, welche Parameter eine Variable substantiell gut erklären. Die Intelligenz der Eltern beispielsweise erklärt die Intelligenz einer Person deutlich besser als die Anzahl der Filme, die eine Person pro Jahr ansieht. 

> Unser Ziel muss es vielmehr sein, so wenige Parameter wie möglich zu verwenden und den Fehler so klein wie möglich zu halten.

Als Folge haben wir ein Problem: Einerseits sollen die Fehler klein gehalten werden, andererseits sollen so wenig Parameter wie möglich verwendet werden!? Deine Aufgabe ist es, die richtige **Balance** der beiden Ansprüche zu finden. Für jeden Parameter müssen wir uns daher die Frage stellen, ob der Parameter *gut genug ist*, um den Fehler substantiell zu reduzieren. Ein Parameter in unserem Beispiel, der vermutlich den Fehler nicht reduzieren würde, wären die Anzahl der Filme, die eine Person pro Jahr ansieht. Wir haben keine theoretischen Begründungen, weshalb diese Variable den Fehler substantiell reduzieren sollte.

# Kurzfrage

Stell dir vor, du möchtest ein statistisches Modell erstellen, um die Größe von Personen hervorzusagen. 

```
- question: Welche der folgenden Parameter würde den Fehler vermutlich substantiell reduzieren und wären es daher Wert, in das Modell aufgenommen zu werden?
  hint: Denke nochmal genauer nach. Überlege dir, was ein schlechter Parameter wäre. Sind die vorliegenden Parameter schlecht? 
  answers:
    - answer: Die Größe des Vaters
      correct: True
    - answer: Die Größe der Partnerin/des Partners
      correct: False
    - answer: Unterernährung während der Kinder- und Jugendzeit
      correct: True
```

# Kompaktes und erweitertes Modell

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


# Null- und Alternativhypothese

In Statistikbüchern liest man selten von kompakten und erweiterten Modellen. Viel gebräuchlicher sind die Begriffe Null- und Alternativhypothese:

* Nullhypothese = kompaktes Modell
* Alternativhypothese = erweitertes Modell

Genauer müssten wir sagen, dass die Nullhypothese das Modell ist, bei welchem alle Parameter, die zusätzlich in dem erweiterten Modell sind, auf Null gesetzt werden. Deswegen heißt das kompakte Modell auch Nullyhypothese. Oder anders gesagt gehen wir bei einer Nullhypothese davon aus, dass es keine Unterschiede zwischen Gruppen gibt. Beispielsweise, indem wir annehmen, dass der Intelligenzquotient von Personen immer gleich ist, egal ob Personen ein bestimmtes Training bekommen oder nicht.


<!-- Hier ein Beispiel: Meine Nullhypothese ist, dass die Intelligenz von Menschen im Schnitt ist 100:

$$
Y_i = \beta_{0} + \epsilon_{i} = 100 + \epsilon_{i}
$$

$$
Y_i = 100 + \epsilon_{i}
$$

Meine Alternativehypothese hat einen weiteren Parameter ($\beta_{1}$), nämlich wie stark die Intelligenz der Mutter von 100 abweicht. Der Wert -10 würde zum Beispiel bedeuten, dass die Mutter 10 Intelligenzpunkte weniger hat als 100, also 90 (die Werte sind frei ausgedacht, wie man zu diesen Werten kommt, lernst du später):

$$
Y_i = \beta_{0} + \beta_{1} * X_1 + \epsilon_{i}
$$

$$
Y_i = 100 + 0.8 * X_1 + \epsilon_{i}
$$

Statt 100 wie bei der Nullyhypothese würde ich nun $100 + 0.8 * -10 = 92$ als Intelligenzquotienten für die Person hervor sagen. -->

## Statistisches Hypothesentesten

Wenn nun mein erweitertes Modell den Fehler des kompakten Modells substantiell minimiert (wir kommen später im Kurs darauf, was das bedeutet), *lehne ich die Nullhypothese zu Gunsten der Alternativhypothese ab*. Ist der Fehler *nicht* substantiell kleiner als in der Nullhypothese, gehe ich weiter von der Nullhypothese aus, sage also, dass die Nullhypothese das beste und sparsamste Modell ist, um meine abhängige Variable hervorzusagen.

# Kurzfrage

```
- question: Warum ist der Fehler beim erweiterten Modell kleiner als beim kompakten Modell? 
  answers:
    - answer: Da jeder weitere Parameter DATA besser erklären kann, unabhängig von der Größe des Einflusses.
      hint: Sehr gut. Das ist richtig.
      correct: True
    - answer: Da das erweiterte Modell Parameter hat, die Fehler stärker reduzieren als beim kompakten Modell.
      hint: Nicht ganz. Es ist möglich, dass der Mittelwert beim kompakten Modell den Fehler bereits sehr klein hält und ein weiterer Parameter den Fehler nur minimal verkleinert.
      correct: False
    - answer: Da die Parameter im erweiterten Modell den Fehler substantiell reduzieren.
      hint: Nein. Die Größe der Fehlerreduzierung ist irrelevant für die Frage. Entscheidend ist, warum der Fehler beim erweiterten Modell immer kleiner ist, da er mehrere Parameter hat.
      correct: False
```

# PRE berechnen

Um entscheiden zu können, ob die Reduzierung des Fehlers durch das erweiterte Modell groß genug ist, müssen wir einen Weg finden, die Reduzierung des Fehlers zu bestimmen. Wir werden im Verlaufe des Kurses mehrere dieser Wege aufzeichnen: Unter anderem *PRE* und *F*. Zunächst beschäftigen wir uns mit *PRE*.

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

# Beispiel PRE in R

Nehmen wir an, du entwickest ein kompaktes Modell mit einem Fehler von 30 und ein erweitertes Modell mit einem Fehler von 10. Wie groß wäre die prozentualle Reduzierung des Fehlers abhängig des kompakten Modells?

$$
PRE = \frac{ERROR(C) - ERROR(A)}{ERROR(C)}
$$


```R
(pre <- (30 - 10) / 30) # 0.6666667
# ODER
(pre <- 1 - (10 / 30)) # 0.6666667
```
Mit `pre` geben wir an, dass wir das Ergebnis der Gleichung `(30 - 10) / 30` in einer Variable speichern. Durch die Klammer um den Befehl wird der Output der Variable direkt in R angezeigt. Alternativ können man schreiben:

```R
pre <- (30 - 10) / 30
pre # 0.6666667
```

Das erweiterte Modell reduziert also den Fehler des kompakten Modells um 67% Prozent.

# Übung PRE

Dein kompaktes Modell hat einen Fehler von 80. Dein erweitertes Modell hat einen Fehler von 60. Wie groß ist PRE in diesem Fall? 

TODO: Hier Aufgabenformat für exakte Fragen einfügen. Auf zwei Nachkommastelle runden! 
-> Antwort: .33.

# Werte von PRE

Nicht jedes PRE ist gleich beeindruckend. Nehmen wir an, du erhältst ein PRE von .02. Das erweiterte Modell hat fünf Parameter mehr als das kompakte Modell. Welches Modell ist nun besser? Wir gehen davon aus, dass das Modell, welches mit den *wenigsten* Parametern ähnliche Ergebnisse erzielt und daher *sparsamer* ist, besser ist. Aus diesem Grund würden wir in diesem Beispiel sagen, dass das kompakte Modell besser ist, schließlich hat es weniger Parameter als das erweitertes Modell und ein geringes PRE.

Die Werte von PRE können zwischen 0 und 1 annehmen. 1 würde bedeuten, dass das erweiterte Modell alle Fehler des kompakten Modells erklärt. Je höher PRE ist, desto eher sollten wir die zusätzlichen Parameter in ein Modell einfügen, um eine abhängige Variable hervorzusagen. Je kleiner PRE ist, desto eher sollten wir das kompakte Modell behalten.

Nur, ab welchem Wert ist PRE groß genug oder klein genug? Dies hängt von mehreren Faktoren ab. Wenn PRE substantiell durch nur einen Parameter reduziert wird, ist dies besser, als wenn PRE durch mehrere Parameter reduziert wird. Schließlich suchen wir sparsame Modelle mit wenigen Parametern.

# Notation

Wir werden in den nächsten Wochen immer wieder statistische Modelle anschauen und analysieren. Um zu wissen, wovon wir sprechen, ist es wichtig, dass wir die Notation der Begriffe vorab definieren:

* $Y_i$ steht für den Einzelwert von *DATA*, den Werten, welche wir hervorsagen, beziehungsweise den Werte unserer abhängigen Variable. Das kleine $i$ steht für das Untersuchungsobjekt, welches wir gerade betrachten. In der Regel sind das einzelne Menschen.
* $\hat{Y}_i$ steht für unseren auf Grundlage des Modells hervorgesagten Werte. Der reale Wert setzt sich aus der Schätzung und dem Fehler zusammen: $Y_i = \hat{Y}_i + e_i$
* $X_{ij}$ steht für die Variablen, welche wir in unser Modell hinzufügen. $i$ steht für das Untersuchungsobject, $j$ steht für die Nummer der Variable (wir werden später mehrere dieser Variablen in unseren Modellen haben)
* $\beta_{0}, \beta_{1}, ...$ steht für die Parameter unseres Modells, welche wir finden möchten. Wir werden diese Werte allerdings **nie** exakt bestimmen können, da wir nie Daten von ganzen Populationen haben. Als Faustregel gilt: Sobald ein $\epsilon$ in der Gleichung enthalten ist, spreche ich von Parametern, die in der Population gelten (z.B. $\beta_{0}$). 
* $b_0, b_1, ...$ stehen für die Parameter, welche ich auf Grundlage der Daten geschätzt habe. Beispielsweise schätze ich den Mittelwert der Population auf Grundlage des Mittelwerts meiner Stichprobe. $b$ wird immer in Kombination mit $\hat{Y}$ verwendet.
* $e_0, e_1, ...$ stehen für die Fehler, die wir aus dem Modell berechnen, welches wir berechnet haben. $e$ wird also immer in Zusammenhang mit $b$ verwendet und nie mit $\beta$.
* $\epsilon_i$ steht für Fehler der sich ergibt, wenn wir $\beta_i$ kennen. Da sich $\beta$ von $b$ unterscheidet, wird sich auch $e$ von $\epsilon$ unterschieden.

# Ein Beispiel einer Null- und Alternativhypothese mit PRE

Nehmen wir an, du möchtest die Intelligenz einer Person auf Grundlage der Anzahl der gelesenen Bücher pro Jahr und dem Alter einer Person hervorsagen.

Da du zwei stetige, das heißt intervallskalierte Werte hast, möchtest du folgendes Modell berechnen:

$$
\hat{Y} = b_0 + b_1 * X_1 + b_2 * X_2
$$

$X_1$ steht für die Anzahl der Bücher pro Jahr, $X_2$ steht für das Alter einer Person. Der Parameter $b_1$ bedeutet, dass Pro Buch, dass eine Person pro Jahr liest, der Intelligenzquotient um $b_1$ Punkte nach oben oder unten geschätzt wird. $b_2$ bedeutet, dass mit jedem Lebensjahr mehr, die Intelligenz der Person um $b_2$ Punkte nach oben oder unten geschätzt wird.

Du erhälst aus diesen beiden Parameter folgendes Modell (wie wir diese Parameter erhalten, wird später erklärt):

$$
\hat{Y} = 68.72 + 2.81 * X_1 - 0.02 * X_2
$$

Mit jedem Buch, dass eine Person liest, steigt daher der Intelligenzquotient laut unserem Modell um 2.81 Punkte. Das Alter scheint die Intelligenz weniger zu beeinflussen, da mit jedem Lebensjahr die Intelligenz um -0.02 Punkte sinkt.

## Nullhypothese

Du möchtest nun heraus finden, ob dieses erweiterte Modell oder deine Alternativhypothese besser ist als ein einfacheres Modell, sprich deine Nullhypothese. Als Nullhypothese nimmst du an, dass jede Person den gleichen Intelligenzquotienten hat:

$$
\hat{Y}_i = b_{0}
$$

Der Mittelwert der Intelligenz der Personen, die du erhebst ist 94.71, also:

$$
\hat{Y}_i = 94.71
$$

## Alternativhypothese

Deine Alternativhypothese besagt, dass die Intelligenz einer Person auf Grundlage der Anzahl der gelesenen Bücher und dem Alter der Person bestimmbar ist:

$$
\hat{Y} = 68.72 + 2.81 * X_1 - 0.02 * X_2
$$

## Berechnung von PRE

Nehmen wir nun an, dass der Fehler des kompakten Modells bei $149.5$ liegt und der Fehler des erweiterten Modells bei $145.40$ liegt. PRE ist daher:

$$
PRE = \frac{149.5 - 145.40}{145.5} = 0.027
$$

Dies entspricht einer Reduzierung des Fehlers um 2.7%. Ist unser erweitertes Modell also substantiell besser den Fehler zu reduzieren als das kompakte Modell? Vermutlich nicht, da der Fehler nur minimal reduziert wird. Im Verlaufe des Kurses werden wir erklären, wie wir eine Entscheidung treffen, ob diese Fehlerreduzierung substantiell genug ist.

# Einfache Modelle mit einem Prädiktor

Beginnen wir mit dem einfachsten Modell, dass wir erstellen können:

$$
Y_i = b_0 + \epsilon_{i}
$$

Stell dir erneut vor, du möchtest die Intelligenz einer Person hervorsagen. Da du nicht alle Personen einer Population testen kannst, holst du dir 78 Personen in das Labor und erhebst durch einen Test ihren Intelligenzquotienten. Anschließend berechnest du den Mittelwert dieser Stichprobe und erhältst den Wert $94.71$.

Da wir die Daten aus einer Stichprobe erheben wird dieser Mittelwert nie dem Mittelwert der Population entsprechen. $b$ kann daher nie $\beta$ sein.

Wir erhalten also:

$$
Y_i = 94.71 + e_i
$$

Auf Grundlage dieser Formel würden wir für jede Person, die gleiche Intelligenz hervorsagen:

$$
\hat{Y}_i = b_0
$$

$$
\hat{Y}_i = 94.71
$$

Grafisch können wir uns dieses Modell als eine Line vorstellen, die für jede Person die gleiche Intelligenz annimmt:

```
ggplot(intelligence, aes(x = reorder(id, intelligence_pre), y = intelligence_pre)) + 
  geom_hline(yintercept = 94.70, color = "steelblue") +
  geom_point() +
  labs(
    x = "ID der Probanden",
    y = "Intelligenz",
    title = "Einzelne Intelligenzwerte der Probanden mit Mittelwert"
  ) 
```

![](./images/intelligence_mean_single_values.png)

Auf der X-Achse siehst du die ID der einzelnen Probanden, auf der Y-Achse deren Intelligenzquotienten.

# Lineare und quadrierte Fehler

Wir wissen, dass ein Mittelwert nie die tatsächlichen Werte einer Person repräsentiert. Kaum eine Person wird einen Intelligenzquotienten von 94.71 haben. Die größe des Fehlers können wir auf Grundlage folgender Formel berechnen:

$$
Y_i = b_0 + e_{i}
$$

Daraus ergibt sich, dass:

$$
e_{i} = Y_i - b_0
$$

Oder:

$$
e_{i} = Y_i - \hat{Y}_i
$$

Stellen wir uns eine Person mit einem Intelligenzquotienten von 102 vor. Der Fehler für diese Person wäre daher:

$$
e_{i} = 102 - 94.71 = 7.29
$$

Grafisch können wir uns diese Fehler folgendermaßen vorstellen:

<!-- ```
intelligence %>% 
  mutate(
    id = id %>% as.double
  ) %>% 
ggplot(aes(x = id, y = intelligence_pre)) + 
  geom_hline(yintercept = 94.70, color = "steelblue") +
  geom_segment(
    aes(x = id,
        xend = id,
        y = intelligence_pre,
        yend = mean(intelligence_pre)
        )
  ) +
  geom_rect(aes(xmin = id,
                xmax = id + (abs(intelligence_pre - mean(intelligence_pre))),
                ymin = intelligence_pre,
                ymax = mean(intelligence_pre),
                alpha = .1),
            fill = "#9999ff") +
  geom_point() +
  coord_fixed() +
  labs(
    x = "ID der Probanden",
    y = "Intelligenz",
    title = "Fehler der geschätzen Werte und der tatsächlichen Werte - quadriert"
  ) 

``` -->

![](./images/intelligence_error_line.png)

Der Fehler ist der Abstand zwischen unserem vorhergesagtem Wert (hier die horizontale Linie) und dem tatsächlichen Wert (hier der Punkt in der Grafik). Wir werden später im Kurs den Fehler allerdings nicht mehr durch eine Linie bestimmen, sondern durch die Quadrierung dieses Fehlers:

![](./images/error_squared.png)

Die Quadrierung der Fehler hat gewissen mathematische Vorteile, die wir in diesem Kurs nicht besprechen werden. Ein Grund liegt darin, dass die Wahl des Fehlers entscheidet, welches einfachste Modell den Fehler am stärksten reduziert. Würden wir beispielsweise den Fehler als die lineare Abweichung zwischen dem tatsächlichen Wert und dem vorhergesagtem Wert berechnen, wäre der Median das Modell, welches die Fehler maximal reduziert. Nehmen wir den Mittelwert als einfachtes Modell, sind die quadrierten Abweichungen das mathematisch korrekteste Modell. 

# Aggregierung der Fehler

Um zu beschreiben, wie hoch die Fehler sowohl in unserem kompakten Modell als auch in unserem erweiterten Modell sind, müssen wir diese Fehler aggregieren. Es gibt hierfür verschiedene Wege, beispielsweise können wir die linearen Fehler summieren. Wir werden in diesem Kurs die Fehler aggregieren, indem die quadrierten Abweichungen der einzelnen Fehler summiert werden.

Im Bilde gesprochen rechnen wir die Summe der Fläche dieser Quadrate zusammen:

![](./images/error_squared.png)

Mathematisch ausgesprochen ist die Summe der quadrierten Abweichungen oder **Sum of Squared Errors** (SSE) also:

$$
SSE = \sum_{i = 1}^n (Y_i - b_0)^2
$$

$Y_i$ entspricht dem tatsächlichen Wert (hier die einzelnen Punkte), $b_0$ entspricht unserem Modell (hier der Mittelwert, blauer Strich). Diese beiden Werte substrahieren wir voneinander und quadrieren diese Differenz (blaue Quadrate). Die Summe dieser Quadrate ergibt SSE oder Sum of Squared Errors.

# Standardisierung des quadrierten Fehlers

Die Aggregierung der Fehler ist abhängig von der Anzahl der Beobachtungspunkte. Beispielsweise ist die Aggregierung des Fehlers von 5 Personen in der Regel deutlich kleiner als die Aggregierung des Fehlers von 20 Personen. Es ist daher sinnvoll, den aggregierten Fehler zu standardisieren, um Fehler miteinander zu vergleichen. Dies schaffen wir, indem wir den aggregierten Fehler durch die Anzahl der Beobachtungspunkte (Probanden) - 1 teilen. Diese Standardisierung des Fehlers nennen wir **Means Squared Error (MSE)**.

$$
MSE = \frac{SSE}{n - 1} = \frac{\sum_{i = 1}^n (Y_i - b_0)^2}{n - 1}
$$

Du wirst feststellen, dass MSE nichts anderes ist als die Varianz einer Verteilung: 

$$
Varianz = s^2 =  \frac{\sum_{i = 1}^n (x_i - \bar{x})^2}{n - 1}
$$

Dementsprechend ist die Wurzel von MSE nichts anderes als die Standardabweichung der standardisierten Fehler:

$$
s = \sqrt{MSE} = \sqrt{\frac{\sum_{i = 1}^n (Y_i - b_0)^2}{n - 1}}
$$


# R-Übung

> Ziel der Übung: PRE auf Grundlage des eben beschriebenen erweiterten Modells und des kompakten Modells hervorzusagen.

Lade dir für diese Übung den Datensatz von folgendem Link (TODO) herunter. Benenne den Datensatz mit der Variable `intelligence`. 


Zunächst laden wir wie immer das Paket tidyverse:

```
library(tidyverse)
```

Zu Beginn ist es immer sinnvoll, sich den Datensatz anzuschauen:

```
glimpse(intelligence)
```

```
Observations: 78
Variables: 7
$ id                <dbl> 25, 26, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36...
$ gender            <chr> "male", "male", "male", "male", "male", "male", "male", "male", "male", "male", "male", "male...
$ age               <dbl> 41, 32, 22, 46, 55, 33, 50, 50, 37, 28, 28, 45, 60, 48, 41, 37, 44, 37, 41, 43, 20, 51, 31, 5...
$ books_per_year    <dbl> 10, 10, 9, 11, 9, 10, 9, 11, 10, 10, 9, 9, 10, 9, 9, 9, 10, 10, 9, 10, 9, 10, 9, 10, 9, 9, 9,...
$ intelligence_post <dbl> 82.73580, 142.02978, 79.97794, 82.73580, 88.25152, 88.25152, 89.63045, 91.00938, 92.38831, 95...
$ group             <dbl> 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, ...
$ intelligence_pre  <dbl> 82.73580, 142.02978, 74.73800, 74.46222, 87.28627, 84.25262, 85.76944, 88.25152, 89.63045, 83...
```

Der Datensatz hat 7 Variablen. Uns interessieren die Variablen `intelligence_pre`, `books_per_year` und `age`. Beachte, dass das Modell, welches wir gleich erstellen erst später in diesem Kurs erklärt wird. Bei diesem Modell handelt es sich um ein Regressionsmodell mit zwei Prädiktoren. Dieses erweiterte Modell hatten wir vorhin folgendermaßen beschrieben:


$$
\hat{Y} = 68.72 + 2.81 * X_1 - 0.02 * X_2
$$

Das kompakte Modell war:


$$
\hat{Y}_i = 94.71
$$


Wie wir das erweiterte Modell berechnen, erfahren wir später im Kurs. Jetzt genügt es zu wissen, dass wir ein erweitertes Modell mit zwei Parametern berechnet haben.

Im nächsten Schritt möchten wir die quadrierten Abweichungen der tatsächlichen Werte und den geschätzen Werten beider Modelle berechnen:

```
(errors <- intelligence %>% 
  mutate(
    compact       = mean(intelligence_pre),
    augmented     = predict(model, newdata = .),
    res_compact   = (compact - intelligence_pre)^2,
    res_augmented = (augmented - intelligence_pre)^2
  ))
``` 

```
# A tibble: 78 x 11
      id gender   age books_per_year intelligence_post group intelligence_pre compact augmented res_compact res_augmented
   <dbl> <chr>  <dbl>          <dbl>             <dbl> <dbl>            <dbl>   <dbl>     <dbl>       <dbl>         <dbl>
 1    25 male      41             10              82.7     2             82.7    94.7      96.0       143.          175. 
 2    26 male      32             10             142.      2            142.     94.7      96.2      2240.         2104. 
 3     1 male      22              9              80.0     1             74.7    94.7      93.6       399.          354. 
 4     2 male      46             11              82.7     1             74.5    94.7      98.7       410.          586. 
 5     3 male      55              9              88.3     1             87.3    94.7      92.9        55.1          31.0
 6     4 male      33             10              88.3     1             84.3    94.7      96.1       109.          141. 
 7     5 male      50              9              89.6     1             85.8    94.7      93.0        79.9          51.7
 8     6 male      50             11              91.0     1             88.3    94.7      98.6        41.7         107. 
 9     7 male      37             10              92.4     1             89.6    94.7      96.0        25.8          41.2
10     8 male      28             10              95.1     1             83.4    94.7      96.2       127.          164. 
# ... with 68 more rows
```

Du siehst, dass wir nun vier weitere Variablen an den Datensatz angefügt haben. Mit `mutate` haben wir diese Variablen berechnet. Die Variable `res_compact` bezeichnet den quadrierten Fehler des kompakten Modells für jeden Probanden, `res_augmented` bezeichnet den quadrierten Fehler des erweiterten Modells für jeden Probanden. 

Um PRE zu berechnen, müssen wir diese Fehler zunächst aggregieren:


$$
SSE = \sum_{i = 1}^n (Y_i - b_0)^2
$$

Wir speichern daher unseren neuen Datensatz in einer Variable und berechnen die Summe dieser beiden Variablen:

```
sum(errors$res_compact)   # 11661.2
sum(errors$res_augmented) # 11341.38
```

Zuletzt können wir aus diesen Fehlern PRE berechnen:

```
(pre <- (11661.2 - 11341.38) / 11661.2) # 0.02742599
```

Erneut erhalten wir einen Fehler von 2.7%. Das erweiterte Modell ist demnach in der Lage die Fehler des kompakten Modells um 2.7% zu reduzieren. Um nun zu bestimmen, ob diese Reduzierung gut genug ist, um das erweiterte Modell bzw. die Alternativhypothese anzunehmen, müssen wir als nächstes verstehen, wie wir bestimmen können, ob ein Fehler substantiell reduziert wird. Mehr dazu im nächsten Teil.


 
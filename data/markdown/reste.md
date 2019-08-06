<!-- # Ein Beispiel einer Null- und Alternativhypothese mit PRE

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

Auf der X-Achse siehst du die ID der einzelnen Probanden, auf der Y-Achse deren Intelligenzquotienten. -->
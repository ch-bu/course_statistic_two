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

In der statistischen Literatur spricht bei $PA - PC$ und $n - PA$ von Freiheitsgraden. Diese werden für jedes inferenzstatistische Verfahren verwendet. Die Freiheitsgrade des Zählers kennzeichnen, wie viel mehr Parameter das erweiterte Modell im Vergleich zum kompakten Modell haben. Die Freiheitsgrade des Nenners kennzeichnen, wie viel Parameter in das erweiterte Modell noch hinzugefügt werden können, wenn man die bestehenden Parameter des erweiterten Modells abzieht.

### Eine weitere Definition

F wird häufig nicht anhand von PRE berechnet, sondern durch die SSR und SSE(A), welche wir bereits kennen gelernt haben:

$$
F = \frac{SSR / (PA - PC)}{SSE(A) / (n-PA)}
$$

SSR kennzeichnet daher den quadrierten Abstand der vorhergesagten Werte des kompakten von den vorhergesagten Werten des erweiterten Modells. SSR ist daher kleiner, wenn beide Modelle ähnliche Vorhersagen treffen. Je größer SSR, desto unterschiedlichere Vorhersagen treffen beide Modelle.

$$
SSR = SSE(C) - SSE(A) = \sum_{i=1}^{n} (\hat{Y_{iC}} - \hat{Y_{iA}})
$$

SSE(A) kennzeichnet die Fehler, welche trotz des erweiterten Modells noch übrig bleiben. Je kleiner SSE(A), desto genauer und daher besser ist unser erweitertes Modell. 

$$
SSE(A) = \sum_{i = 1}^n (Y_i - \hat{Y}_i)^2
$$


#### Der Zähler


$$
SSR / (PA - PC)
$$

Der Zähler ist daher ein relatives Maß der Vohersageunterschiede beider Modelle in Abhängigkeit der jeweiligen Parameter des erweiterten Modells. Je größer der Zähler, desto unterschiedlichere Vorhersagen liefern beide Modelle anhand bestimmter Parameter.

#### Der Nenner

Der Nenner kennzeichnet erneut den Anteil der Fehler, welcher durch einen weiteren willkürlichen Parameter reduziert werden könnte.

## Die F-Verteilung

Da der F-Wert ebenso ein Kennwert wie z oder PRE darstellt, hat F ebenso eine Stichprobenkennwertverteilung. Wir werden an dieser Stelle darauf verzichten, die Stichprobenkennwertverteilung zu simulieren. 

Im Unterschied zur z-Verteilung und zur PRE-Verteilung umfasst die F-Verteilung verschiedene Parameter, welche das Aussehen dieser Verteilung ändern. Genauer muss man beide Freiheitsgrade angeben, um bestimmte F-Verteilungen zu erhalten. Dies bedeutet, dass es sehr viele F-Verteilungen abhängig der Freiheitsgrade gibt. Schauen wir uns eine F-Verteilung an, die wir im nächsten Beispiel verwenden werden, um eine Hypothese zu prüfen:

<!-- ```R
ggplot(NULL, aes(x = c(0, 5))) +
  stat_function(
    fun = df,
    geom = "area",
    alpha = .7,
    fill = "steelblue",
    args = list(
      df1 = 1,
      df2 = 27
    )
  ) +
  stat_function(
    fun = df,
    geom = "area",
    alpha = .7,
    fill = "orange",
    args = list(
      df1 = 4,
      df2 = 47
    )
  ) +
  # geom_vline(xintercept = z_value,
  #            color = "black",
  #            size = 1) +
  labs(
    title = "F-Verteilungen mit unterschiedlichen Freiheitsgraden",
    x = "F",
    y = "Dichte"
  ) +
  scale_x_continuous(limits = c(0, 5))
``` -->

![](f_dists.png)

Hier siehst du zwei F-Verteilungen. Die blaue F-Verteilung hat die Freiheitsgrade df1 = 1, und df2 = 27 und die orangene F-Verteilung hat die Freiheitsgrade df1 = 4 und df2 = 47. 

Wir können ebenso die kritischen Werte der blauen F-Verteilung betrachten:

<!-- ```R
critical_value <- qf(0.95, 1 - 0, 30 - 1)

ggplot(NULL, aes(x = c(0, 5))) +
  stat_function(
    fun = df,
    geom = "area",
    alpha = .3,
    fill = "steelblue",
    args = list(
      df1 = 1,
      df2 = 27
    )
  ) +
  stat_function(
    fun = df,
    geom = "area",
    fill = "steelblue",
    args = list(
      df1 = 1,
      df2 = 27
    ),
    xlim = c(critical_value, 5)
  ) +
  # geom_vline(xintercept = z_value,
  #            color = "black",
  #            size = 1) +
  labs(
    title = "F-Verteilung mit kritischem Wert",
    x = "F",
    y = "Dichte"
  ) +
  scale_x_continuous(limits = c(0, 5))
``` -->

![](critical_value.png)

Alle empirischen F-Werte, welche in den dunkelblauen Bereich fallen führen zu einem signifikanten Ergebnis. Dies bedeutet, dass die Parameter der erweiterten Modelle die Fehler deutlich stärker reduzieren als man annehmen würde, sollte die Nullhypothese gelten.


## Ein Beispiel

> Ziel: Den F-Wert in R berechnen und konzeptuell verstehen

Stell dir folgende Hypothese vor: Deine Nullhypothese lautet, dass die Mitarbeiter 6000 Dollar monatlich verdienen. Deine Alternativhypothese lautet, dass der Mittelwert der Stichprobe, welcher ein proximaler Wert für den Mittelwert der Population ist ein besseres Modell zur Vorhersage des monatlichen Verdienstes der Mitarbeiter ist. Deine Modelle lauten daher:

$$
Y_c = 6000 + e
$$

und 

$$
Y_A = b_0 + e = \bar{X} + e
$$

Dein kompaktes Modell hat keinen Parameter, dein erweitertes Modell hat einen Parameter. 

Zunächst ziehen wir eine Stichprobe aus der Population mit einem N von 30:

```R
set.seed(99)
my_sample <- human_resources %>% 
  sample_n(30)
```

Berechnen wir im nächsten Schritt die Komponenten PRE, SSR und SSE(A), welche wir für beiden Formeln brauchen:

```R
mean_sample <- mean(my_sample$monthly_income) # Mittelwert der Stichprobe
errors <- my_sample %>% 
    mutate(
      compact_model = 6000,
      augmented_model = mean_sample,
      res_compact   = (monthly_income - compact_model)**2,
      res_augmented = (monthly_income - augmented_model)**2
    )


(sse_c <- sum(errors$res_compact))   # 201206027
(sse_a <- sum(errors$res_augmented)) # 173820441
(ssr <- sse_c - sse_a)               # 27385586

# PRE berechnen
(pre <- ssr / sse_c) # 0.1361072
```

Anschließend können wir F berechnen:

```R
# F berechnen (erste Formel)
(F <- (pre / (1 - 0)) / ((1 - pre) / (30 - 1))) # 4.568979

# F berechnen (zweite Formel)
(F <- (ssr / (1 - 0)) / (sse_a / (30 - 1)))     # 4.568979
```

Unsere Berechnungen zeigen, dass beide Formeln zum gleichen Ergebnis kommen. Wir können die Daten folgendermaßen interpretieren:

> Der zusätzliche Parameter $b_0$ reduziert die Fehler des kompakten Modells 4.5 mal stärker als ein willkürlicher Parameter. Wir haben daher Grund zu der Annahme, dass dieser Parameter den Fehler des Modells substantiell reduziert.

Um diese Behauptung zu prüfen, müssen wir als nächstes die Wahrscheinlichkeit eines solchen F-Wertes unter der Nullhypothese berechnen:

```R
1 - pf(F, df1 = 1 - 0, df2 = 30 - 1) # 0.04111498
```

Dieses Ergebnis bedeutet, dass ein solcher F-Wert oder größer gegeben der Nullhypothese nur 4.11% oft vorkommt. Da unser Alphaniveau bei 5% liegt, sprechen wir daher von einem signifikanten Ereignis. Um dies noch einmal zu prüfen, können wir den kritischen F-Wert berechnen:

```R
qf(0.95, df1 = 1 - 0, df2 = 30 - 1) # 4.182964
```

Unser empirischer F-Wert ist größer als der kritische F-Wert, daher haben wir ein signifikantes Ereignis vorliegen.

Zusammenfassend würden wir dieses Ergebnis folgendermaßen in einem Forschungsartikel berichten:

> Das mittlere Einkommen der Mitarbeiter kann signifikant genauer berechnet werden als die willkürliche Annahme eines Einkommens von 6000 Dollar, *F*(1, 27) = 4.57, *p* = .04. 

Jeder F-Test wird gleich aufgebaut:

* *F*(df1, df2): Zunächst werden die Freiheitsgrade benannt.
* $4.57$: Anschließend wird der F-Wert berichtet.
* *p* = .04: Danach wird der p-Wert angegeben.

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



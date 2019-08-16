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

> Das mittlere Einkommen der Mitarbeiter kann durch den Mittelwert der Stichprobe signifikant genauer berechnet werden als die willkürliche Annahme eines Einkommens von 6000 Dollar, *F*(1, 27) = 4.57, *p* = .04. 

Jeder F-Test wird gleich aufgebaut:

* *F*(df1, df2): Zunächst werden die Freiheitsgrade benannt.
* $4.57$: Anschließend wird der F-Wert berichtet.
* *p* = .04: Danach wird der p-Wert angegeben.

# Effektstärke

## Konzeptuelles Verständnis

Statistische Signifikanz und die Effektstärke einer Intervention werden häufig verwechseln. Statistische Signifikanz sagt uns im Prinzip lediglich, welches statistisches Modell akkurater ist, um unsere abhängige Variable zu bestimmen. Beispielsweise können wir auf Grundlage eines Experiments sagen, dass der Mittelwert als erweitertes Modell die Fehler stärker reduziert als ein willkürliche Prognosse des Gehalts der Mitarbeiter von 6000 Dollar monatlich.

Auf Grundlage der Signifikanz können wir allerdings nicht sagen, **wie groß** dieser Unterschied ist. Es ist durchaus möglich signifikante Ereignisse zu erzielen, ohne, dass ein wesentlicher Unterschied zwischen Gruppen besteht. Beispielsweise ist es mathematisch ohne weiteres möglich zu belegen, dass der Meeresspiegel signifikant steigt, wenn ein Tropfen Regen auf das Meer prasselt. Demnach ist statistische Signifikanz nicht mit der praktischen Bedeutsamkeit einer Intervention gleichzusetzen.

*  [Cohen's d](https://www.statisticshowto.datasciencecentral.com/cohens-d/): Wird zur Bestimmunt der Effektstärke bei einer z und t-Verteilung verwendet.
* $r$: Wird zur Bestimmung der Effektstärke einer Korrelation verwenden.
* $\eta^2$: Wird zur Bestimmung der Effektstärke eines F-Testes verwendet


## Cohen's d

Stell dir vor, du untersuchst, ob Manager ein signifikant höheres Einkommen erhalten als alle anderen Mitarbeiter. Du erhebst von 40 Managern ihr Gehalt und von 40 regulären Mitarbeitern. Der Mittelwert der Mitarbeiter beträgt 6500 Dollar, der Mittelwert der Manager beträgt 8000 Dollar. Diesen Unterschied können wir anhand einer nicht-z-standardisierte Stichprobenkennwertverteilung visualisieren:

<!-- ```R
ggplot(NULL, aes(x = c(4000, 8000))) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "steelblue",
    args = list(
      mean = mean(human_resources$monthly_income),
      sd = sd(human_resources$monthly_income) / sqrt(40)
    )
  ) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "orange",
    alpha = .8,
    args = list(
      mean = 8000,
      sd = sd(human_resources$monthly_income) / sqrt(40)
    )
  ) +
  annotate("segment", x = mean(human_resources$monthly_income), 
           xend = 8000, y = 0.00053, yend = 0.00053) +
  labs(
    title = "Visualisierung Cohen's D",
    x = "Monatliches Einkommen",
    y = "Dichte"
  ) +
  scale_x_continuous(limits = c(4000, 10500))


cohens_d <- (8000 - mean(human_resources$monthly_income)) / 
  sd(human_resources$monthly_income)
``` -->


![](cohens_d_1.png)

Die orangene Verteilung kennzeichnet die Stichprobenkennwertverteilung der Alternativhypothese. Die blaue Verteilung kennzeichnet die Stichprobenkennwertverteilung deiner Nullhypothese. 

Um Cohen's D zu bestimmen, berechnen wir zunächst den Mittelwertsunterschied beider Stichproben:

$$
8000 - 6500 = 1500
$$

Manager verdienen also 1500 Dollar mehr als der Rest der Mitarbeiter. Man könnte es dabei belassen, die Effektstärke in Dollar als Mittelwertsunterschied anzugeben. Dies würde allerdings dazu führen, dass diese Mittelwertsunterschiede nicht mehr vergleichbar sind. Stell dir vor, ein ähnliches Experiment wird in einem anderen Land mit einer anderen Währung, z.B. dem Yen, umgesetzt. Ein Vergleich wäre nicht mehr möglich. Cohen's D standardisiert daher diesen Mittelwertsunterschied, indem dieser durch die gepoolte Standardabweichung der Stichproben berechnet wird:

$$
d = \frac{M_A - M_C}{sd_{pooled}}
$$

Die gepoolte Standardabweichung erhalten wir, indem wir beide Standardabweichungen quadrieren, summieren, von 2 abzielen und die Wurzel daraus berechnen:

$$
sd_{pooled} = \sqrt{\frac{sd_1^2 + sd_2^2}{2}}
$$

Die Effektstärke für unser Experiment lautet daher:

$$
d = \frac{8000 - 1500}{4707} = 0.32
$$

### Interpretation von Cohen's d

Allgemein werden Effektstärken als klein, mittel und groß beschrieben. Cohen nimmt folgende Unterscheidung an:

* $0 - 0.2$: kein Effekt
* $0.2 - 0.5$: kleiner Effekt
* $0.5 - 0.8$: mittlerer Effekt
* $> 0.8$: großer Effekt

Je größer Cohen's d ist, desto weiter liegen die Mittelwerte zweier Verteilungen auseinander.

### Weitere Informationen

* [Interpreting Cohen's d effect size](https://rpsychologist.com/d3/cohend/)

## Eta-Quadrat

Zur Berechnung der Effektstärke von F-Verteilungen wird $\eta^2$ (eta-squared) berechnet:

$$
\eta^2 = \frac{SSR}{SS_{total}]}
$$

Ausgesprochen bedeutet $\eta^2$ folgendes: $\eta^2$ beschreibt, wie viel Prozent der Varianz in der abhängigen Variable durch das erweiterte Modell erklärt werden kann. $\eta^2$ kann Werte von 0 bis 1 erhalten. 0 bedeutet, dass das erweiterte Modell (mit einem Parameter) keine Varianz in der abhängigen Variable aufklärt und damit sogut wie nutzlos ist. $\eta^2$ von 1 bedeutet, dass das erweiterte Modell die komplette Varianz der abhängigen Variable aufklärt und wir daher keine Fehlervarianz mehr existiert (SSE(A) wäre in diesem Fall 0).

Stell dir vor, du hast eine Stichprobe von 4 Mitarbeitern. Das Gehalt der Mitarbeiter beträgt 1000, 2000, 3000, und 4000 Dollar. Wir nehmen zusätzlich an, dass das Gehalt des Vaters dieser Personen 1100, 2100, 3100 und 4100 Dollar ist. Wir vergleichen als nächstes zwei Modelle: Das kompakte Modell, welches den Mittelwert zur Berechnung der abhängigen Variable annimmt und ein erweitertes Modell, welches eine lineare Regression (mehr dazu nächste Woche) aus dem Gehalt des Vaters berechnet:

<!-- ```R
my_artificial_sample <- tibble(
  id = c(1000, 2000, 3000, 4000),
  income  = c(5000, 6000, 7000, 8000),
  income_father = c(5100, 5900, 7100, 8100)
)

model <- lm(income ~ income_father, data = my_artificial_sample)

mean_income <-  mean(my_artificial_sample$income)
ggplot(my_artificial_sample, aes(x = income_father, y = income)) + 
  geom_point() +
  geom_hline(yintercept = mean_income, color = "steelblue") +
  geom_segment(
    aes(x = income_father,
        xend = income_father,
        y = income,
        yend = mean_income
    )
  ) +
  geom_rect(aes(xmin = income_father,
                xmax = income_father + (abs(-21.0957 + 0.9987 * income_father - mean_income)),
                ymin = 112.8107 + 0.9751 * income_father,
                ymax = mean_income,
                alpha = .05),
            fill = "orange") + 
  geom_rect(aes(xmin = income_father,
                xmax = income_father + (abs(income - mean_income)),
                ymin = income,
                ymax = mean_income,
                alpha = .05),
            fill = "#9999ff") +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  guides(alpha = FALSE) +
  labs(
    title = "Visualisierung Eta-Quadrat",
    x = "Monatliches Einkommen des Vaters",
    y = "Monatliches Einkommen"
  ) +
  coord_fixed()
``` -->

<!-- ```R
my_artificial_sample <- tibble(
id = c(1000, 2000, 3000, 4000),
income  = c(5000, 6000, 7000, 8000)
)

mean_income <-  mean(my_artificial_sample$income)
ggplot(my_artificial_sample, aes(x = id, y = income)) + 
geom_point() +
geom_text(aes(label = id), nudge_x = .1) +
geom_hline(yintercept = mean_income, color = "steelblue") +
geom_segment(
  aes(x = id,
      xend = id,
      y = income,
      yend = mean_income
  )
) +
geom_rect(aes(xmin = id,
              xmax = id + (abs(income - mean_income)),
              ymin = income,
              ymax = mean_income,
              alpha = .05),
          fill = "#9999ff") +
guides(alpha = FALSE) +
labs(
  title = "Visualisierung der gesamten Fehlervarianz SS_Total",
  x = "ID der Mitarbeiter",
  y = "Monatliches Einkommen"
) +
coord_fixed()
``` -->

![](eta_quadrat_ss.png)

Der horizontale vertikale Strich kennzeichnet das kompakte Modell. Die schwarze Linie kennzeichnet das erweiterte Modell. Die blauen Quadrate kennzeichnen $SS_{total}$, die orangenen Quadrate kennzeichnen $SSR$. Eta-Quadrat ist in diesem Fall das Verhältnis der orangenen Quadrate zu den blauen Quadraten. Da die Fläche der Quadrate der beiden Modelle ähnlich ist, erhalten wir ein Eta-Quadrat von $0.99$. Übersetzt können wir demnach sagen, dass Eta-Quadrat angibt, wie genau unser alternatives Modell die abhängigen Werte prognostiziert. Je höher $\eta^2$, desto genauer ist die Vorhersage.

<!-- ```R
sum_of_squares <- my_artificial_sample %>% 
  mutate(
    ss_total = (income - mean(income))^2,
    ssr      = ((112.8107 + 0.9751 * income_father) - mean(income))^2
  )
  
eta_squared <- sum(sum_of_squares$ssr) / sum(sum_of_squares$ss_total)
``` -->

## Partielles Eta-Quadrat

$\eta^2$ ist nur eine sinnvolle Effektstärke, wenn das erweiterte Modell nur einen Parameter mehr hat als das kompakte Modell. Ähnlich wie bei der Signifikanz, möchten wir die Effektstärke für *jeden weiteren Parameter* des erweiterten Modells berechnen. Im Unterschied zu $\eta^2$ teilen wir nicht durch $SS_{total}$, sondern durch $SSR + SSE(A)$.

$$
\eta_p^2 = \frac{SSR}{SSR + SSE(A)}
$$

# Statistische Power

## Was ist Power / Teststärke

Bei der Bewertung statistischer Signifikanz gehen wir davon aus, dass die Nullhypothese gilt und geben auf Grundlage dieser Annahme an, ob ein Ereignis äußerst unwahrscheinlich ist. 

Bei der Power oder Teststärke eines inferenzstatistischen Tests gehen wir davon aus, dass die Alternativhypothese gilt und bestimmen, wie wahrscheinlich es ist, ein signifikantes Ergebnis zu erzielen.

### Visualisierung signifkanter Ereignisse

<!-- ```R
ggplot(NULL, aes(x = c(-3, 5))) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "steelblue",
    alpha = .3,
  ) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "steelblue",
    xlim = c(qnorm(.95), 4)
  ) +
  stat_function(
    fun = dnorm,
    geom = "line",
    linetype = 2,
    fill = "steelblue",
    alpha = .5,
    args = list(
      mean = 2
    )
  ) +
  labs(
    title = "Visualisierung signifikanter Ereignisse,",
    subtitle = "Kritischer Bereich bei Alpha = 5%",
    x = "z-score",
    y = "Dichte"
  ) +
  scale_x_continuous(limits = c(-3, 5))
``` -->

![](signifikanz.png)

In der Grafik siehst du den Bereich signifikanter Ereignisse bei einer z-Verteilung mit einem Alpha-Niveau von 5%. Jeder empirischer z-Wert, der in den dunkelblauen Bereich fällt, führt zu einem signifikanten Ergebnis. Signifikant, da dieses Ereignis unwahrscheinlich ist, wenn die Nullhypothese angenommen wird. Gestrichelt gekennzeichnet siehst du eine spezifische Alternativhypothese.


### Visualisierung der Power

<!-- ```R
ggplot(NULL, aes(x = c(-3, 5))) +
  stat_function(
    fun = dnorm,
    geom = "line",
    linetype = 2,
  ) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "orange",
    alpha = .8,
    args = list(
      mean = 2
    ),
    xlim = c(qnorm(.95), 5)
  ) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "steelblue",
    xlim = c(qnorm(.95), 4)
  ) +
  stat_function(
    fun = dnorm,
    geom = "area",
    linetype = 2,
    fill = "orange",
    alpha = .2,
    args = list(
      mean = 2
    ),
    xlim = c(-2, qnorm(.95))
  ) +
  labs(
    title = "Visualisierung der Teststärke einer spezifischen Hypothese",
    subtitle = "Kritischer Bereich bei Alpha = 5%",
    x = "z-score",
    y = "Dichte"
  ) +
  scale_x_continuous(limits = c(-3, 5))
``` -->

![](power.png)

Orange gekennzeichnet ist die Alternativhypothese. Blau gekennzeichnet ist der kritische Bereich. Dunkelorange gekennzeichnet ist die Teststärke oder statistische Power.

Zur Bestimmung der Power müssen wir die Grafik folgendermaßen lesen: Unter der Annahme, dass unsere Alternativhypothese stimmt, erhalten wir zu 63.9% ein statistisch signifikantes Ergebnis. Unsere Power oder Teststärke liegt daher bei 63,9%.

```R
1 - pnorm(qnorm(.95), mean = 2) # 0.63876
```

## Power allgemein

Weshalb benötien wir das Konzept der Power? Wenn wir ein Experiment durchführen, gehen wir in der Regel davon aus, dass unsere Alternativhypothese stimmt. Nicht jede Intervention allerdings 

> TODO: Gleiches gilt für andere Verteilungen. z.B. F



## Einflüsse auf die statistische Power

## Beispiel der Berechnung statistischer Power



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



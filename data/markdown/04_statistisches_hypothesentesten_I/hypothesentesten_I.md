# Stichprobenkennwertverteilungen

## Konzeptuelles Verständnis

Wir haben im letzten Kapitel häufiger davon gesprochen, dass wir die Nullhypothese verwerfen, wenn der Fehler des kompakten Modells, durch das erweiterte Modell substantiell verkleinert wird. Nur was bedeutet es, einen Fehler substantiell verkleinert zu verkleinern?  Um diese Frage beantworten zu können, verwenden wir **Stichprobenkennwertverteilungen**. Das Wort Stichprobenkennwertverteilung gibt uns bereits einige Hinweise, um zu verstehen, was dieses Wort bedeutet.

1. Stichprobe
2. Kennwert
3. Verteilung

### Stichprobe

Eine Stichprobe ist eine Teilmenge aus einer Grundgesamtheit. Wahlvorhersagen werden auf Grundlage von Stichproben gezogen, da es mühselig wäre, alle Menschen eines Landes (die Grundgesamtheit) zu befragen. Daher erheben wir immer nur einen kleinen Anteil der Population und versuchen auf Grundlage dieser Stichprobe auf die Population zu schließen.

### Kennwert

Statistische Kennwerte fassen mehrere Datenpunkte zusammen. Du kennst bereits mehrere dieser Kennwerte: Der Mittelwert, der z-Wert, die Standardabweichung oder die Varianz. Jeder dieser Kennwerte fasst Daten zusammen. Der Mittelwert gibt den typischen Wert einer Verteilung an, die Varianz gibt an, wie weit Werte um einen Mittelwert streuen. In den nächsten Wochen werden wir uns vor allem mit dem Mittelwert, PRE, dem t-Wert und dem F-Wert beschäftigen. All diese Werte sind statistische Kennwerte.

### Verteilung

Eine Verteilung ist eine grafische Darstellung des Auftretens einzelner Ausprägung einer Variable. Beispielsweise kennst du unimodale Verteilungen mit nur einem Gipfel:

<!-- ```
ggplot(NULL, aes(x = c(-3, 3))) +
  stat_function(fun = dnorm,
                geom = "area",
                fill = "steelblue")
``` -->

![](unimodal.png)

Oder eine stetige Verteilung

![](unimodal2.png)

Oder eine bimodale Verteilung:

<!-- ```
nn <- 1e4
set.seed(1)
betas<-rbeta(nn,2,2)
sims <- c(betas[1:(nn/2)]*2+1,
          betas[(nn/2+1):nn]*2+3)


hist(sims)
``` -->

![](sims.png)


### Stichprobenkennwertverteilung revisited

Eine Stichprobenkennwertverteilung ist daher eine Verteilung von Kennwerten, die aus einer Stichprobe gewonnen werden. Beispielsweise:

* Die Verteilung von Mittelwerten, die aus mehreren Stichproben berechnet werden.
* Die Verteilung von Mittelwertsdifferenzen, die aus mehreren Stichproben berechnet werden.
* Die Verteilung von PRE, die aus mehreren Stichproben berechnet werden.
* Die Verteilung von Varianzen, die aus mehreren Stichproben berechnet werden.

## Simulation einer Stichprobenkennwertverteilung in R

Um Stichprobenkennwertverteilungen besser zu verstehen, hilft es, diese zu simulieren. Stellen wir uns erneut unsere Population als unsere fiktive Firma mit ihren 1470 Mitarbeitern vor. Versuchen wir im nächsten Schritt den Mittelwert des monatlichen Einkommens einer Stichprobe von 20 Personen zu berechnen:


```R
set.seed(453)
my_sample <- sample_n(human_resources, 20)
my_sample$monthly_income %>% mean # 5483.65
```

Diese Stichprobe verdient im Schnitt 5483.65 Dollar pro Monat. Dieser Mittelwert entspricht allerdings nicht dem Mittelwert der Population, welchen wir in der Regel nicht kennen. Da wir allerdings die Population kennen, können wir den Mittelwert berechnen:

```R
mean(human_resources$monthly_income) # 6502.931
```

Wir unterschätzen den Mittelwert der Stichprobe also erheblich durch unsere Stichprobe.

Um nun zu einer Stichprobenkennwertverteilung zu gelangen, benötigen wir sehr viele dieser Kennwerte aus sehr vielen Stichproben. Versuchen wir daher als nächstes die Mittelwerte von 20 Stichproben zu ziehen (den Code musst du an dieser Stelle nicht verstehen):

```R
(twenty_samples <- c(1:20) %>% 
  map_dbl(~ sample_n(human_resources, 20) %>% 
            {mean(.$monthly_income)}))
```

```
[1]  8147.30  5338.25  5379.75  5312.45  7260.05  6887.40  5726.00  8796.30 11089.40  8490.10
[11]  7251.15  4628.45  7050.95  6419.60  5824.75  5658.65  4635.70  6430.65  7647.00  6765.95
```

Erneut erhalten wir ganz unterschiedliche Mittelwerte. Versuchen wir diese Mittelwerte in einem Histogramm darzustellen:

```R
ggplot(NULL, aes(x = twenty_samples)) +
  geom_histogram(fill = "steelblue", color = "black") +
  labs(
    title = "Stichprobenkennwertverteilung des Mittelwerts",
    x = "Mittelwerte der Stichproben",
    y = "Häufigkeit"
  )
```

![](20_samples.png)

Die Stichprobenkennwertverteilung ist weder unimodal, noch stetig, noch bimodal. Was passiert, wenn wir anstatt 20 10.000 Stichproben ziehen?


```R
ten_thousand_samples <- c(1:10000) %>% 
    map_dbl(~ sample_n(human_resources, 20) %>% 
    {mean(.$monthly_income)})

    
ggplot(NULL, aes(x = ten_thousand_samples)) +
  geom_histogram(fill = "steelblue", color = "black") +
  labs(
    title = "Stichprobenkennwertverteilung des Mittelwerts (10000 Stichproben)",
    x = "Mittelwerte der Stichproben",
    y = "Häufigkeit"
  )
```

![](ten_thousand_samples.png)

Nun erhalten wir eine unimodale Verteilung. Selten erhalten wir in einer Stichprobe einen Mittelwert von über 9000 und selten erhalten wir in einer Stichprobe einen Mittelwert unter 4000 Dollar.

> Stichprobenkennwertverteilungen zeigen an, wie wahrscheinlich bestimmte Kennwerte (z.B. PRE) auftreten, wenn wir von der Nullhypothese ausgehen. Wir können Stichprobenkennwertverteilung daher benutzen, um heraus zu finden, ob Fehler durch das erweiterte Modell substantielle reduziert werden.

## Eigenschaften von Stichprobenkennwertverteilungen

### Je größer die Stichprobe, desto kleiner die Standardabweichung der Normalverteilung

```R
twenty <- c(1:10000) %>% 
    map_dbl(~ sample(human_resources$monthly_income, 20) %>% mean)

fifty <- c(1:10000) %>% 
    map_dbl(~ sample(human_resources$monthly_income, 50) %>% mean)

hundred <- c(1:10000) %>% 
    map_dbl(~ sample(human_resources$monthly_income, 100) %>% mean)

tibble(
  twenty = twenty,
  fifty = fifty,
  hundred = hundred
) %>% 
  gather(sample, value) %>% 
  ggplot(aes(x = value, fill = sample)) +
  geom_density(aes(fill = sample), alpha = .5) +
  labs(
    title = "Stichprobenkennwertverteilungen bei unterschiedlichen Stichprobengrößen",
    fill = "Stichprobe",
    x = "Mittelwert des monatlichen Einkommens der Stichproben",
    y = "Dichte"
  )
```

![](different_n_samples.png)

Die rote Stichprobenkennwertverteilung zeigt eine Stichprobenkennwertverteilung an, die aus Stichproben mit 50 Mitarbeitern generiert wurde. Die blaue Stichprobenkennwertverteilung wurde anhand einer Stichprobengröße von 20 Mitarbeitern generiert. Die grüne Stichprobenkennwertverteilung wurde anhand einer Stichprobe von 100 Mitarbeitern generiert.

Du siehst, dass die Verteilung mit einer steigenden Stichprobengröße eine geringere Varianz aufweißt und *steiler* wird. Ein Grund hierfür ist, dass der Kennwert durch eine größere Stichprobe akkurater geschätzt wird. Stell dir das Extrem vor: Deine Stichproben sind fast so groß wie die ganze Population. Als Folge wirst du fasst immer Werte erhalten, die fast exakt dem Mittelwert entsprechen. Die Stichprobenkennwertverteilung wird daher sehr schmal sein. Bei einer geringen Stichprobegröße erhälst du den gegenteiligen Effekt. Deine Schätzungen des Kennwertes werden sehr variieren, daher ist deine Stichprobenkennwertverteilung breiter.

### Die Standardabweichung der Stichprobenkennwertverteilung des Mittelwertes nennt man Standardfehler

Jede Verteilung hat einen Mittelwert und eine Standardabweichung. Die Stichprobenkennwertverteilung ist keine Ausnahme. Auch sie hat eine Standardabweichung. Diese nennen wir **Standardfehler**. Der Standardfehler der Stichprobenverteilung des Mittelwerts können wir folgendermaßen folgendermaßen schätzen:

$$
SE = \frac{\sigma}{\sqrt{N}}
$$

$\sigma$ kennzeichnet die Standardabweichung der Stichprobe. $N$ kennzeichnet die Größe der Stichprobe.  Wir müssen den Standardfehler schätzen, da wir die Standardabweichung der Population in der Regel nicht kennen. Daher nehmen wir die Standardabweichung der Stichprobe, um den Standardfehler der Stichprobenkennwertverteilung zu schätzen.

Durch diese Formel lässt sich auch erklären, weshalb der Standardfehler bei einer größeren Stichprobe kleiner wird. Stell dir eine Stichprobe von 20 vor. Die Standardabweichung der Verteilung der Stichprobe ist 100:

$$
SE = \frac{100}{\sqrt{20}} = 5
$$

Hätten wir eine Stichprobe von 50 Personen bei einer gleichen Standardabweichung, wäre der Standardfehler:

$$
SE = \frac{100}{\sqrt{50}} = 2
$$


### Die Streuung in der Population ist immer größer als die Streuung in der Stichprobenkennwertverteilung

Der Grund für dieses Phänomen liegt darin, dass eine Stichprobe eines Kennwertes weniger wahrscheinlich extreme Werte einer Verteilung generiert als die tatsächlichen Werte. Stell dir vor, es gibt eine Mitarbeiterin mit einem monatlichen Einkommen von 10000 Dollar. Dies ist ein seltenes Ereignis. Da ein Kennwert immer eine Aggregierung mehrerer Werte ist, wird dieses hohe Einkommen zwar evtl. in den Kennwert einer Stichprobe mit hinein gerechnet, aber immer durch weniger extreme Werte angeglichen, da diese wahrscheinlicher gezogen werden. Hierduch ist die Streuung in der Population größer als in der Stichprobe.

### Der Mittelwert der Stichprobenkennwertverteilung ist der gleiche Mittelwert der Population

Zwar ist die Streuung der Stichprobenkennwertverteilung, deren Mittelwert ist allerdings der gleiche.

# Normalverteilung und Standardnormalverteilung

## Normalverteilung

Normalverteilungen sind besondere Verteilungen, die häufig in der Natur anzutreffen sind. Beispielsweise entspricht die Intelligenz von Personen in der Regel einer Normalverteilung. Ebenso entspricht die Größe von Personen oder der Blutdruck von Personen. 

Eine Normalverteilung sieht immer so aus:

<!-- ```R
ggplot(NULL, aes(x = c(-3, 3))) +
     stat_function(fun = dnorm,
                   geom = "area", fill = "steelblue") + 
      labs(title = "Normalverteilung", x = "Kennwerte", y = "Dichte")
``` -->

![](normal_distribution.png)

Normalverteilungen zeichen sich durch folgende Eigenschaften aus:

1. Sie sind unimodal. Es gibt nur einen Gipfel.
2. Sie sind symmetrisch vom Zentrum der Verteilung.
3. Der Mittelwert, der Modus und der Median sind gleich.
4. Die gesamte Fläche der Verteilung hat den Wert 1.

Zusätzlich hat die Normalverteilung einige wichtige statistische Eigenschaften:

* 68% der Werte fallen eine Standardabweichung vom Mittelwert.
* 95% der Werte fallen zwei Standardabweichungen vom Mittelwert.
* 99.7% der Werte fallen innerhalb von drei Standardabweichungen vom Mittelwert.

<!-- ```R
ggplot(NULL, aes(x = c(-3, 3))) +
  stat_function(fun = dnorm,
                geom = "line",
                xlim = c(-5, 5)) +
  stat_function(fun = dnorm,
                geom = "area",
                fill = "red",
                alpha = .4,
                xlim = c(-3, 3)) +
  stat_function(fun = dnorm,
                geom = "area",
                fill = "steelblue",
                alpha = .4,
                xlim = c(-2, 2)) +
  stat_function(fun = dnorm,
                geom = "area",
                fill = "yellow",
                alpha = .7,
                xlim = c(-1, 1)) +
  annotate("text", x = 0, y = 0.2, label = "68%") +
  annotate("text", x = -1.5, y = 0.08, label = "95%") +
  annotate("text", x = -2.4, y = 0.01, label = "97.5%") +
  xlim(-5, 5) +
  labs(
    title = "68-95-97.7 Regel der Normalverteilung",
    x = "Kennwert",
    y = "Dichte"
  )
``` -->

![](normalverteilung_prozent.png)

### Zusätzliche Informationen

* [Explaining the 68-95-99.7 rule for a normal distribution](https://towardsdatascience.com/understanding-the-68-95-99-7-rule-for-a-normal-distribution-b7b7cbf760c2)
* [Normal distributions - Statistics How To](https://www.statisticshowto.datasciencecentral.com/probability-and-statistics/normal-distributions/)


## Standardnormalverteilung

Die Standardnormalverteilung ist eine besondere Normalverteilung, für die folgendes gilt:

* Der Mittelwert der Standardnormalverteilung ist immer 0.
* Die Standardabweichung der Standardnormalverteilung ist immer 1.

![](standardnormalverteilung.png)

Die Standardnormalverteilung wird auch **z-Verteilung** genannt, Kennwerte in der Standardnormalverteilung z-Werte darstellen. Zur Erinnerung, wir können Mittelwerte z-transformieren, indem wir diese vom Mittelwert abziehen und durch die Standardabweichung der Verteilung teilen. 

Um den Mittelwert der Normalverteilung auf 0 zu ziehen, verschieben wir die Verteilung um den Wert jedes Datenpunktes ($Y$) um den Mittelwert der Verteilung ($\mu$): $Y - \mu$. Im nächsten Schritt teilen wir diesen Wert durch die Standardabweichung ($\sigma$) und erhalten hierdurch eine Standardabweichung von 1:

$$
z = \frac{Y - \mu}{\sigma}
$$


## Zentrales Grenzwerttheorem

Die Stichprobenkennwertverteilung des Mittelwerts (und des Medians) hat eine besondere Eigenschaft. 

> Unabhängig davon, welche Verteilung (z.B. bimodel, unimodal, stetig) eine Population hat, die Stichprobenkennwertverteilung des Mittelwerts entspricht immer einer Normalverteilung.

Mehr Informationen [hier](https://www.statisticshowto.datasciencecentral.com/probability-and-statistics/normal-distributions/central-limit-theorem-definition-examples/).


# Grundlagen der Wahrscheinlichkeitsrechnung

## Axiome der Wahrscheinlichkeit (Kolmogorov)

Wir werden gleich Wahrscheinlichkeiten auf Grundlage von Stichprobenkennwertverteilung berechnen. Zuvor ist es nötig, dass wir zwei grundlegen Axiome der  Wahrscheinlichkeit wiederholen:

1. Die Wahrscheinlichkeit eines Ereignisses bewegt sich zwischen 0 und 1.
2. Die Wahrscheinlichkeit aller möglichen Ereignisse ist 1. Dies entspricht immer der Fläche der Stichprobenkennwertverteilungen.

Später werden wir die Fläche unter Stichprobenkennwertverteilungen berechnen. Unabhängig davon, ob es um eine Stichprobenkennwertverteilung des Mittelwerts (Standardnormalverteilung), der Stichprobenkennwertverteilung von PRE (später auch F), oder der Stichprobenkennwertverteilung von Mittelwertsunterschieden handelt, beträgt die Fläche dieser Verteilung immer 1. Dementsprechend können wir aus Stichprobenkennwertverteilungen berechnen, wie wahrscheinlich ein bestimmter Kennwert auftritt, wenn wir von der Nullhypothese ausgehen.

## Skalenniveaus

Daten liegen in folgenden Skalenniveaus vor:

* Nominalskalierte Daten: Kennzeichnent durch kategoriale Unterschiede. Z.B. Frau/Mann oder die Parteizugehörigkeit SPD/FDP/CDU. Es gibt keine Werte zwischen den einzelnen Werten.
* Ordinalskalierte Daten: Auch Rangskaliserte Daten. Beispielsweise sind die Schulabschlüsse ordinalskaliert: Werksrealschule < Realschule < Gymnasium.
* Intervallskalierte Daten: Kennzeichnent durch unendliche viele mögliche Werte, z.B. die Temperatur.
* Verhältnisskalierte Daten: Kennzeichnent durch einen natürlichen Nullpunkt. Die Länge einer Schnur beispielsweise ist verhältnisskaliert. Ebenso das Gewicht eines Objektes.

Nominalskalierte Daten liegen uns in Experimenten in der Regel durch verschiedene Experimentallgruppen vor. Metrisch skalierte Daten(Intervall- und Verhältnisskalierte Daten) liegen uns in der Regel als abhängige Variable vor, die wir prüfen möchten. Ebenso aber auch als unabhängige Variablen, die wir in unsere Modelle als Parameter einfügen.

## Diskrete und stetige Wahrscheinlichkeiten

Wahrscheinlichkeiten können sowohl diskret als auch stetig vorliegen. Diskrete Wahrscheinlichkeiten zeichen sich dadurch aus, dass sie auf Grundlage von nominalskalierten und ordinalskalierten Daten berechnet werden. Beispielsweise können wir die Wahrscheinlichkeit berechnen, beim Würfeln die Augenzahl 5 zu würfen (1/6). Die Augenzahl ist eine ordinalskalierte Variable. 

Im Unterschied dazu werden stetige Wahrscheinlichkeiten bei Variablen angegeben, die metrisch vorliegen. Beispielsweise können wir die Wahrscheinlichkeit berechnen, größer als 1,80 Meter zu sein. Die Wahrscheinlichkeit einzelner Ereignisse, z.B. die Größe 1,82331243433454 geht gegen Null, da es unendliche viele Ausprägungen zwischen Variablen gibt. Bei der Standardnormalverteilung berechnen wir beispielsweise die Wahrscheinlichkeit eines Ereignisses auf Grundlage des Integrals unter der Verteilung:

<!-- 
```R
ggplot(NULL, aes(x = c(-3, 3))) +
  stat_function(fun = dnorm,
                args = list(
                  mean = 0,
                  sd = 1
                ),
                geom = "area", fill = "steelblue") + 
  stat_function(fun = dnorm,
                geom = "area",
                fill = "yellow",
                alpha = .7,
                xlim = c(0, 2)) +
  annotate("text", x = 1, y = 0.1, label = "47.72%") +
  labs(
    title = "Stetige Wahrscheinlichkeit z > 0 und z < 2", 
    x = "z-Wert", 
    y = "Dichte")

pnorm(2) - pnorm(0)
``` -->

![](stetige_wahrscheinlichkeit.png)

Die gelbe Fläche kennzeichnet die Wahrscheinlichkeit eines z-Wertes größer als 0 und kleiner als 2 zu sein: 47.72%.


# Wahrscheinlichkeiten und Stichprobenkennwertverteilungen

##  Ein Beispiel zur Berechnung der Wahrscheinlichkeit aus einer Stichprobenkennwertverteilung

Stichprobenkennwertverteilungen können uns Auskunft darüber geben, wie wahrscheinlich ein bestimmter Kennwert auftritt. Beispielsweise könnten wir uns fragen, wie wahrscheinlich es ist, eine Stichprobe zu erhalten, die im Schnitt mehr als 9000 Dollar monatlich verdient. Da das monatliche Gehalt eine metrisch skaliserte Variable ist, können wir diese Frage anhand einer stetigen Verteilung prüfen. Als stetige Verteilung eignet sich die Standardnormalverteilung, schließlich wissen wir durch das Zentrale Grenztwerttheorem, dass die Verteilung von Stichprobenmittelwerten einer Normalverteilung entsprechen.

Da die Standardnormalverteilung z-Werte als Kennwerte annimmt, müssen wir zunächst den Z-Wert berechnen, der auftritt, wenn der Mittelwert einer Stichprobe 9000 Dollar beträgt:

$$
z = \frac{\bar{X} - \mu}{\sigma} = \frac{9000 - 6502.931}{4707.957} = 0.5303933
$$

$\bar{X}$ steht für den Mittelwert der Stichprobe, $\mu$ für den tatsächlichen Mittelwert der Population für die abhängige Variable und $\sigma$ für die Standardabweichung der abhängigen Variable. 

Ein mittleres Einkommen von 9000 Dollar hat demnach einen z-Wert von 0.5, dies bedeutet, Menschen die 9000 Euro verdienen, verdienen eine halbe Standardabweichung mehr als der Durchschnitt der Mitarbeiter. 


Diesen z-Wert können wir in der Standardnormalverteilung abbilden: 

```
z_score <- (9000 - mean(human_resources$monthly_income)) / sd(human_resources$monthly_income)

ggplot(NULL, aes(x = c(-3, 3))) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "steelblue",
  ) +
  geom_vline(xintercept = z_score,
             color = "red",
             size = 2) +
  annotate("text", x = z_score + 0.5,
           y = 0.3, label = "z-score der Person mit\neinem IQ von 115")
```

![](z_score.png)


Aus der Visualisierung können wir bereits erkennen, dass die Wahrscheinlichkeit unter 50% liegt, da die die Fläche rechts vom Mittelwert der Verteilung 50% entspricht und der z-Wert weiter rechts des Mittelwertes liegt. Zeigen wir die Wahrscheinlichkeit grafisch an:

```R
ggplot(NULL, aes(x = c(-3, 3))) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "steelblue",
  ) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "#b44682",
    xlim = c(z_score, 3)
  ) +
  labs(
    title = "Wahrscheinlichkeit, eine Stichprobe zu ziehen, die über 9000 Euro pro Monat verdient",
    x = "z-score",
    y = "Dichte"
  )
```

![](probability_z_score.png)

Die Wahrscheinlichkeit entspricht 29,8%:

```R
1 - pnorm(z_score)  # 0.2979196
```

## Wahrscheinlichkeiten und stetige Stichprobenkennwertverteilungen

### Die Wahrscheinlichkeit eines einzelnen Ereignisses ist bei stetigen Variablen immer gleich 0

Wie wahrscheinlich ist es, genau 5678,43234343 Dollar pro Monat zu verdienen? Diese Frage muss bei stetigen Verteilungen, in der es unendlich viele Zwischenwerte gibt immer mit 0 beantwortet werden. Einzelne Ereignisse sind so unwahrscheinlich, da stetige Variablen unendlich genau sein können. 

### Wahrscheinlichkeiten sind bei stetigen Variablen das Integral zwischen zwei Werten

Wir können allerdings berechnen, wie wahrscheinlich es ist, mindestens oder höchstens einen bestimmten Kennwert zu erhalten. Genausogut können wir die Wahrscheinlichkeit zwischen zwei Ereignissen berechnen. Mathematisch nehmen wir das Integral einer Funktion über zwei Werte:


$$
P(x_1 \leq x_2) \int_{x_1}^{x_2} f(x) dx
$$


Das Integral entspricht der Wahrscheinlichkeit, da die Fläche der Stichprobenkennwertverteilungen 1 entspricht und für Omega, sprich den gesamten Ereignisraums entspricht. Beispielsweise können wir berechnen wie wahrscheinlich ist es, zwischen 5000 und 6000 Dollar pro Monat zu verdienen?

```R
z_score_6000 <- (6000 - mean(human_resources$monthly_income)) / sd(human_resources$monthly_income)
z_score_5000 <- (5000 - mean(human_resources$monthly_income)) / sd(human_resources$monthly_income)

ggplot(NULL, aes(x = c(-3, 3))) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "steelblue",
  ) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "#b44682",
    xlim = c(z_score_5000, z_score_6000)
  ) +
  labs(
    title = "Wahrscheinlichkeit zwischen 5000 und 6000 Euro pro Monat zu verdienen",
    x = "Monatlicher Verdienst als z-Wert",
    y = "Dichte"
  ) +
  annotate("text", x = -0.3,
           y = 0.2, label = "8,3%")
```

![](prob_5000_6000.png)


$$
P(5000 \leq 6000) \int_{5000}^{6000} f(x) dx
$$


Ein anderes Beispiel: Wie wahrscheinlich ist es, weniger als 2000 Dollar monatlich zu verdienen?

$$
P(-\infty \geq 2000) \int_{-\infty}^{2000} f(x) dx
$$


```R
z_score_2000 <- (2000 - mean(human_resources$monthly_income)) / sd(human_resources$monthly_income)

ggplot(NULL, aes(x = c(-3, 3))) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "steelblue",
  ) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "#b44682",
    xlim = c(-3, z_score_2000)
  ) +
  labs(
    title = "Wahrscheinlichkeit weniger als 2000 Dollar monatlich zu verdienen",
    x = "Monatlicher Verdienst als z-Wert",
    y = "Dichte"
  ) 
```

![](less_2000.png)


```R
pnorm(z_score_2000) # 0.1694221
```

Die Wahrscheinlichkeit liegt bei 16,9%.

## Generalisierung der Wahrscheinlichkeitsberechnung aus Stichprobenkennwertverteilungen


### Ein Beispiel 

Eine logische Frage, die sich nun ergibt, ist: Warum müssen wir Wahrscheinlichkeiten aus Stichprobenkennewrtverteilungen berechnen? Die Antwort lautet, um Hypothesen zu testen. Stell dir folgendes Szenario vor: Deine Freundin behauptet, dass Mitarbeiter in dem Unternehmen im Schnitt 3000 Dollar verdienen. Du glaubst deiner Freundin nicht und bist dir sicher, dass die Mitarbeiter deutlich mehr als 3000 Dollar pro Monat verdienen. Wie könnt ihr prüfen, wer recht hat? 

Zunächst stellen wir eine Nullhypothese auf. Wir gehen davon aus, dass deine Freundin tatsächlich recht hat. Was würde passieren, wenn deine Freundin falsch läge und das tatsächliche Gehalt deutlich höher liegt? Dann würde der Mittelwert der Stichprobe, die du aus der Population (hier das Unternehmen) erhebst, deutlich höher liegen als 3000 Dollar. Du hättest damit nicht bewiesen, dass deine Freundin recht hat, es wäre allerdings äußerst unwahrscheinlich, dass deine Stichprobe so groß ausfällt, sollte die Nullhypothese stimmen. 

Ihr befragt also 50 Mitarbeiter im Unternehmen nach ihrem monatlichen Gehalt. Folgenden Mittelwert erhaltet ihr:

<!-- ```R
set.seed(899)
my_sample <- sample_n(human_resources, 50)
mean(my_sample$monthly_income) # 6063.02
```

Eure Stichprobe verdient 6063.02 Dollar im Schnitt monatlich. Versuchen wir all diese Informationen grafisch darzustellen:

```R
ggplot(NULL, aes(x = c(0, 10000))) +
  # Nullhypothese
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "steelblue",
    args = list(
      mean = 3000,
      sd = sd(human_resources$monthly_income) / sqrt(50)
    )
  ) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "orange",
    alpha = .6,
    args = list(
      mean = mean(human_resources$monthly_income),
      sd = sd(human_resources$monthly_income) / sqrt(50)
    )
  ) +
  geom_vline(xintercept = 3000,
             color = "blue",
             size = 1) +
  geom_vline(xintercept = 6063.02,
             size = 1) +
  geom_vline(xintercept = mean(human_resources$monthly_income),
             color = "yellow",
             size = 1) +
  annotate("text", x = 3000 - 800,
           color = "blue",
           hjust = 0,
           y = 0.0005, label = "Nullhypothese der Freundin") +
  annotate("text", x = 6063.02 - 800,
           color = "black",
           hjust = 0,
           y = 0.0005, label = "Mittelwert der Stichprobe") +
  annotate("text", x = mean(human_resources$monthly_income) - 800,
           color = "yellow",
           hjust = 0,
           y = 0.0004, label = "Mittelwert der Population") +
  # annotate("segment", x = 3000, xend = mean(human_resources$monthly_income), 
  #              y = 0.0003, yend = 0.0003, color = "black",
  #          linetype = 2) +
  # annotate("segment", x = 6063.02, xend = mean(human_resources$monthly_income), 
  #          y = 0.00001, yend = 0.00001, color = "grey",
  #          linetype = 2) +
  # annotate("rect", xmin = 2000, xmax = 6800, ymin = 0.000005, ymax = 0.000025,
  #          alpha = .2) +
  labs(
    title = "Darstellung der Null- und Alternativhypothese der Freundeswette",
    x = "Monatlicher Verdienst in Dollar",
    y = "Dichte"
  ) 
``` -->

![](friendsbet.png)

Gelb markiert ist die wirkliche Stichprobenkennwertverteilung. Blau markiert ist die Stichprobenkennwertverteilung hätte deine Freundin recht bzw. würde die Nullhypothese gelten. Die farbigen Striche kennzeichnen die Mittelwerte der Stichprobenkennwertverteilungen bzw. den Mittelwert der Stichprobe.

Wir können aus der Grafik mehrere Informationen entnehmen:

* Sollte deine Freundin recht haben, ist es fasst unmöglich einen so hohen Stichprobenmittelwert zu erhalten. Die Wahrscheinlichkeit geht gar gegen 0, da der schwarze Stichprobenmittelwert nicht einmal die Stichprobenkennwertverteilung der Nullhypothese schneidet. Hätte deine Freundin recht, würden wir vielmehr erwarten, dass die Mittelwerte um den Wert 3000 streuen.
* Die Fehler in kompakten Modell (sprich der Nullhypothese) sind deutlich größer als in deiner Alternativhypothese, dass das Gehalt größer ist. In anderen Worten, der Abstand der tatsächlichen Werte zu den Werten deines Modells (hier der Mittelwert deiner Stichprobe) sind deutlich kleiner als bei deiner Freundin: $e = Y - \hat{Y}$. Wir können daher davon ausgehen, dass wir ein relativ hohes PRE durch diese beiden Hypothesen erhalten. Dein erweitertes Modell reduziert die Fehler des kompakten Modells deutlich.
* Der Stichprobenmittelwert entspricht nicht dem Populationsmittelwert. Dies ist allerdings zu erwarten, da wir durch eine Stichprobe immer willkürliche Fluktuationen im Mittelwert erhalten. Genau deswegen haben wir eine Stichprobenkennwertverteilung.


### Generalisierung

* Stichprobenkennwertverteilungen (z.B. z-Werte, PRE) dienen der Überprüfung von Hypothesen.
* Hypothesen umfassen immer eine Null- und eine Alternativhypothese.
* Die Nullhypothese wird verworfen, wenn das Auftreten eines Kennwertes äußerst unwahrscheinlich ist, unter der Annahme, dass die Nullhypothese gilt.
* Hypothesen können nicht bestätigt werden, wir lehnen lediglich die Nullhypothese ab oder behalten diese vorläufig.
* Dass ein Ereignis unwahrscheinlich gegeben einer Nullhypothese ist, bedeutet **nicht**, dass man einen großen Effekt gefunden hat.

> Stichprobenkennwertverteilungen zeigen uns, ob ein Ereignis oder ein Kennwert unwahrscheinlich ist, unter der Annahme, dass die Nullhypothese gilt. Je unwahrscheinlich ein Ereignis unter der Nullhypothese, desto höher ist PRE.

# Stichprobenkennwertverteilung PRE

## Analogie z-Wert und PRE

In diesem Modul haben wir bereits viel über die Standardnormalverteilung geredet. Mittelwerte von Stichproben konnten wir durch eine z-Transformation als Kennwert in einer Standardnormalverteilung abtragen. Im nächsten Schritt haben wir heraus gefunden, wie wir die Wahrscheinlichkeit von Ereignissen auf Grundlage dieser Verteilungen bestimmen könnnen. Wir werden am Ende dieser Einheit einen inferenzstatistischen Test (z-Test) kennen lernen, welcher die Standardnormalverteilung zur Überprüfung von Hypothesen verwendet. Nächste Woche werden wir den t-Test kennen lernen, welcher zur Prüfung von Hypothesen eine T-Verteilung annimmt.

Unklar ist an dieser Stelle vielleicht, inwieweit die der z-Wert mit PRE zusammen hängt? Klären wir nochmal, was diese beiden Kennwerte für eine Bedeutung haben?

* **z-Wert**: Der z-Wert gibt an, wie viele Standardabweichungen ein Wert vom Mittelwert einer Standardnormalverteilung verteilt liegt. Er ist demnach ein Maß, um zu überprüfen, ob sich Mittelwerte voneinander unterscheiden. Die Stichprobenkennwertverteilung des z-Wertes nennen wir Standardnormalverteilung bzw. z-Verteilung.
* **PRE**: PRE ist ein Kennwert, der angibt, um wie viel Prozent ein erweitertes Modell den Fehler eines kompakten Models reduziert. Die Stichprobenkennwertverteilung von PRE nennen wir PRE-Verteilung.

Die Gemeinsamkeiten sind:

* Für beide Kennwerte können wir Stichprobenkennwertverteilungen generieren.
* Die Stichprobenkennwertverteilungen nutzen wir, um zu überprüfen, ob ein Ergebniss (z.B. der empirische z-Wert, oder der empirische PRE) einer Studie ungewöhnlich sind, unter der Bedingung, dass wir die Nullhypothese annehmen.
* Ist ein Ereignis ungewöhnlich unter Annahme der Nullhypothese verwerfen wir die Nullhypothese zu Gunsten der Alternativhypothese (z.B. indem wir nun davon ausgehen, dass das Gehalt der Mitarbeiter größer als 3000 Euro ist).

Unterschiede der beiden Kennwerte sind:

* z-Werte und PRE liefern unterschiedliche Stichprobenkennwertverteilungen. z-Werte liefern eine unimodale Standardnormalverteilung, während PRE-Kennwerte eine rechtsschiefe Verteilung generieren.
* z-Werte können negativ sein, PRE-Werte sind immer positiv (da wir bei SSR quadrieren, können keine negativen Werte entstehen).

## PRE in R simulieren

Gerade haben wir behauptet, dass die Stichprobenkennwertverteilung von PRE rechtsschief ist. In dieser Übung versuchen wir diese Behauptung durch eine Simulation zu belegen. Folgende Schritte müssen wir hierzu umsetzen:

1. Wir müssen sehr viele Stichproben generieren. Stell dir immer vor, wir wiederholen ein Experiment tausende Male. Jede Stichprobe stammt aus der gleichen Popuulation.
2. Wir müssen für jede dieser Stichprobe das PRE berechnen.
3. Wir visualisieren diese PREs in einer Stichprobenkennwertverteilung als Dichtefunktion. 


Laden wir zunächst den Datensatz erneut:

```R
library(tidyverse)

human_resources <- read_csv("C:/Users/ChristianEZW/repositories/statistik_2_online_kurs/data/markdown/hr_cleaned.csv")
```

### Stichproben generieren

Um mehrere Stichproben zu simulieren können wir die Funktion [sample_n](https://dplyr.tidyverse.org/reference/sample.html) verwenden. Wir verwenden die Funktion um 50000 Stichproben aus der Population zu ziehen. Jede Stichprobe umfasst 30 Personen:


```R
samples <- c(1:50000) %>%
  map(~ sample_n(human_resources, 30))
```

### PRE berechnen

Im nächsten Schritt berechnen wir das PRE. Hierfür müssen wir ein kompaktes Modell und ein erweitertes Modell aufstellen. Da wir beim statistischen Hypothesentesten immer prüfen, ob ein Ergebnis unwahrscheinlich ist, wenn man die Nullhypothese annimmt, stellen wir folgendes Hypothesenpaar auf:

$$
\hat{Y}_{compact} = \beta_0 
$$

$$
\hat{Y}_{augmented} = b_0 = \bar{X}
$$

In anderen Worten: Unsere kompaktes Modell besagt, dass wir die $\hat{Y}$ auf Grundlage des Populationsmittelwertes bestimmen. Unser erweitertes Modell besagt, dass $\hat{Y}$ auf Grundlage des Stichprobenmittelwertes hervorgesagt wird.

> Durch die Wahl dieser beiden Modellen entspricht PRE daher den willkürlichen Fluktuationen von PRE, die wir erwarten würden, sollte die Nullhypothese korrekt sein. Hohe PRE-Werte kennzeichnen daher Werte, die wir nicht unwahrscheinlich sind, sollte die Nullhypothese stimmen. Hohe PRE-Werte sind daher ein Indiz dafür, dass das erweiterte Modell vermutlich akkkurater die Wirklichkeit beschreibt als die Nullhypothese, da diese Ereignisse sehr selten vorkommen.


Berechnen wir PRE für jede Stichprobe:

```R
mean_monthly_income <- mean(human_resources$monthly_income)

calc_pre <- function(dataset) {
  errors <- dataset %>%
     mutate(
       compact_model = mean_monthly_income,
       augmented_model = mean(monthly_income),
       res_compact   = (monthly_income - compact_model)**2,
       res_augmented = (monthly_income - augmented_model)**2
     )
  
  sse_c <- sum(errors$res_compact)
  sse_a <- sum(errors$res_augmented)
  ssr <- sse_c - sse_a
  
  ssr / sse_c
}

pres <- samples %>% 
  map_dbl(~ calc_pre(.))
```

### Dichtefunktion von PRE

Zuletzt können wir diese Kennwerte anhand einer Dichtefunktion darstellen:

```R
ggplot(NULL, aes(x = pres)) + 
  geom_density(fill = "steelblue", aes(y=..scaled..)) +
  scale_x_continuous(limits = c(0, 0.4)) +
  labs(
    title = "Stichprobenkennwertverteilung PRE bei N = 50",
    x = "PRE",
    y = "Dichte"
  )
```

![](pre_sampling_dist.png)

Aus dieser Visualisierung können wir bereits mehrere Informationen entnehmen:

* Es ist sehr wahrscheinlich ein PRE von unter 0.1 zu erhalten, unter der Annahme, dass die Nullyhypothese stimmt.
* PREs von über 0.2 sind sehr selten, unter der Annahme, dass die Nullhypothese stimmt.
* Die Fläche der Verteilung entspricht 1.

Analog zur Standardnormalverteilung können wir daher die PRE-Verteilung nutzen, um die Wahrscheinlichkeit bestimmter Kennwerte zu bestimmen. Beispielsweise können wir auf Grundlage der Verteilung berechnen, wie wahrscheinlich es ist, einen PRE von 0.2 oder größer zu erhalten.

# Statistische Entscheidungen

## Kritische Werte

Wir hatten bereits mehrmals erwähnt, dass wir durch PRE erkennen können, ob ein Kennwert unwahrscheinlich ist, unter der Bedingung, dass die Nullhypothese gilt. Wir hatten ebenso gesagt, dass wir die Nullhypothese verwerfen, sobald der Fehler durch das erweiterte Modell **substantiell groß genug** ist. Nun können wir bestimmten, welche Größe wir hiermit meinen. Diese größe nennen wir kritische Werte.

> Als Faustregel: Liegt die Wahrscheinlichkeit für einen Kennwert (z.B. PRE oder z) unter 5%, verwerfen wir die Nullhypothese zu Gunsten der Alternativhypothese. 


Die 5%-Hürde ist willkürlich gewählt und stammt von [Jerzy Neyman und Egon Pearson](https://www.cambridge.org/core/journals/mathematical-proceedings-of-the-cambridge-philosophical-society/article/testing-of-statistical-hypotheses-in-relation-to-probabilities-a-priori/65C6E3D534996282114D4E16FCA3E73C). In der Medizin wird häufig ein Alpha-Niveau von 1% oder geringer angenomme. In der Sozialforschung hat sich ein Alpha-Niveau von 5% etabliert.


### Ein Beispiel

Nehmen wir an, du testest ob ein Sales Executves ein höheres monatliches Gehalt bekommt als der Durchschnitt der Mitarbeiter. Hierfür ziehst du zunächst eine Stichprobe von 30 Personen aus der Population:

```
library(tidyverse)

human_resources <- read_csv("C:/Users/ChristianEZW/repositories/statistik_2_online_kurs/data/markdown/hr_cleaned.csv")

sales <- human_resources %>% 
  filter(job_role == "Sales Executive") %>% 
  sample_n(30)
```

Da du den Mittelwert der Population für deine abhängige Variable kennst, kannst du diesen als verwenden, um den z-Wert deiner Stichprobe zu berechnen:

```R
(z_value <- (mean(sales$monthly_income) - mean(human_resources$monthly_income)) / 
  (sd(human_resources$monthly_income) / sqrt(30))) # 1.398174
```

Der Z-Wert bedeutet, dass Sales Executives ein um 1.39 Standardabweichungen höheres Gehalt bekommen als der Durschschnitt der Bevölkerung. Schauen wir uns diesen Wert in der Stichprobenkennwertverteilung an:

```R
ggplot(NULL, aes(x = c(-3, 3))) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "steelblue",
  ) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "#b44682",
    xlim = c(qnorm(.95), 4)
  ) +
  geom_vline(xintercept = z_value,
             color = "black",
             size = 1) +
  labs(
    title = "z-Wert der Stichprobe Sales Executives mit kritischem Wert",
    x = "z-score",
    y = "Dichte"
  ) +
  scale_x_continuous(limits = c(-3, 3))
```

![](sales.png)


Rot markiert ist der kritische Bereich, bei dem wir die Nullhypothese verwerfen würden. Der Übergang vom blauen in den roten Bereich bezeichnen wir als kritischen Wert. Diesen können wir ganz konkret bestimmen:

```R
qnorm(0.95) # 1.644854
```

Dies bedeutet, dass wir bei allen z-Werten, die über 1.64 sind die Nullhypothese unter der Annahme unserer Alternativhypothese verwerfen würden.

Auf Grundlage unseres Stichprobenergebnisses (unseres z-Wertes) gehen wir nun weiterhin davon aus, dass die Sales Exekutives nicht wesentlich mehr verdienen als der Durchschnitt der Mitarbeiter, da der z-Wert nicht über dem kritischen Bereich liegt.

> Beachte, dass der z-Wert bei jeder Stichprobe anders ausfallen könnte. 

### Gerichtete vs. ungerichtete Hypothese

Achte darauf, dass wir eine gerichtete Hypothese hatten. Wir sind davon ausgegangen, dass die Sales Executives **mehr verdienen** als der Durschschnitt der Bevölkerung. Hätten wir angenommen, dass die Sales Executives ein unterschiedliches Gehalt, unabhängig der Richtung, von der Population haben, hätten wir das Alpha-Niveau links und rechts der Verteilung aufgeteilt:

```R
ggplot(NULL, aes(x = c(-3, 3))) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "steelblue",
  ) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "#b44682",
    xlim = c(qnorm(.975), 4)
  ) +
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "#b44682",
    xlim = c(-4, qnorm(.025))
  ) +
  geom_vline(xintercept = z_value,
             color = "black",
             size = 1) +
  labs(
    title = "z-Wert der Stichprobe Sales Executives mit kritischem Wert",
    subtitle = "Ungerichtete Hypothese",
    x = "z-score",
    y = "Dichte"
  ) +
  scale_x_continuous(limits = c(-3, 3))
```

![](ungerichtet.png)


## Statistische Signifikanz

### Definition

Statistische Signifikanz ist ein häufig missverstandenes Konzept in der Statistik. Per Definition bedeutet Signifikanz folgendes:

> Signifikanz bedeutet, dass ein Kennwert gegeben der Nullhypothese sehr unwahrscheinlich ist und zusätzlich den kritischen Kennwert über- oder untersteigt.

Beispielsweise hatten wir angenommen, dass Sales Executives mehr verdienen als der Durschschnitt der Bevölkerung. Unsere Stichprobe ergab folgenden Kennwert:

![](sales.png)

Da der **empirische Kennwert** kleiner als der **kritische Kennwert** ist, ist dieses Ereignis nicht signifikant. Wir schließen daraus, dass Sales Executives nicht mehr als der Durchschnitt der Mitarbeiter verdient. Wäre der empirische Kennwert im roten Bereich, würden wir von einem signifikanten Ergebnis sprechen.

Später werden wir vermehrt Stichprobenkennwertverteilungen kennen lernen, die PRE entsprechen (z.B. die F-Verteilung). Auch hier gilt, dass ein signifikantes Ereignis vorliegt, sobald der empirische Kennwert größer als der kritische Kennwert ist. Stell dir zum Beispiel vor, wir fragen uns, ob ein erweitertes Modell die Fehler des kompakten Modells substantiell reduziert:

![](f_significant.png)

Da der empirische Kennwert größer als der kritische Kennwert ist, sprechen wir von einem signifikanten Ergebnis und lehnen die Nullhypothese zu Gunsten der Alternativhypothese ab. 

### Generalisierung

#### Statistische Signifikanz != praktische Bedeutsamkeit

Statistische Signifikanz ist nicht gleichzusetzen mit der praktischen Bedeutsamkeit. Stell dir beispielsweise vor, dass dein erweitertes Modell mehrere Versuchsgruppen umfasst. Zum Beispiel untersuchst du, ob genügend Schlaf zu einer besseren Lernleistung führt. Eine Gruppe muss eine Woche lang 8 Stunden schlafen, die andere 5 Stunden. Du erhältst nun ein signifikantes Ereignis. Bedeutet dies, dass es besser ist länger als kürzer zu schlafen? Nicht unbedingt. Es könnte sein, dass du zwar ein signifikantes Ereignis bekommst, allerdings die praktische Bedeutsamkeit bzw. der Effekt der Intervention minimal ist. Signifikanz bedeutet nichts anderes als das ein Ereignis gegeben der Nullhypothese unwahrscheinlich ist. Im nächsten Modul lernen wir das Konzept der Effektstärke kennen, 
welches bessere Aussagen über die praktische Bedeutsamkeit machen kann. 

#### Statistische Signifikanz ist abhängig von der Stichprobengröße

Stell dir vor, eine Freundin behauptet, dass die Mitarbeiter des Unternehmens 5000 Dollar pro Monat verdienen. Du glaubst dem nicht und behauptest, dass die Mitarbeiter mehr verdienen. Ihr befragt willkürlich 50 Mitarbeiter des Unternehmens um deine Alternativhypothese zu testen. Folgende Kennwert erhaltet ihr unter Annahme der Nullhypothese. Rot gekennzeichnet ist der kritische Bereich mit einem Alpha-Niveau von 5%. Blau markiert ist die Nullhypothese. Orange markiert ist deine Alternativhypothese. Der orangene Stich kennzeichnet deinen Stichprobenmittelwert.

![](einkommen_6000.png)

<!-- ```R
ggplot(NULL, aes(x = c(0, 10000))) +
  # Nullhypothese
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "steelblue",
    args = list(
      mean = 5000,
      sd = sd(human_resources$monthly_income) / sqrt(50)
    )
  ) +
  # Kritischer Bereich 0 Hypothese
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "red",
    args = list(
      mean = 5000,
      sd = sd(human_resources$monthly_income) / sqrt(50)
    ),
    xlim = c(qnorm(.95, mean = 5000, 
                   sd = sd(human_resources$monthly_income) / sqrt(50)), 
             8000)
  ) +
  # Alternativhypothese
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "orange",
    alpha = .2,
    args = list(
      mean = 6000,
      sd = sd(human_resources$monthly_income) / sqrt(50)
    )
  ) +
  geom_vline(xintercept = 6000,
             color = "orange",
             size = 1) +
  labs(
    title = paste0("Nullhypothese mittleres Einkommen == 5000,",
                   "Alternativhypothese mittleres Einkommen == 6000"),
    x = "Mittleres Einkommen",
    y = "Dichte"
  ) +
  scale_x_continuous(limits = c(2500, 8000))
``` -->

Aus der Grafik kannst du schließen, dass dein empirischer Kennwert den kritischen Kennwert nicht übersteigt. Das Ereignis ist daher **nicht signifikant**. Auf Grundlage der Signifkanz würde man darauf schließen, dass die Mitarbeiter nicht mehr als 5000 Euro pro Monat verdienen. Bevor wir voreilig zu diesem Schluss kommen, machen wir einen Trick. Anstatt 50 Mitarbeiter befragt ihr einfach 100 Mitarbeiter. Diesmal sehen eure Kennwertverteilungen folgendermaßen aus:

<!-- ```R
ggplot(NULL, aes(x = c(0, 10000))) +
  # Nullhypothese
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "steelblue",
    args = list(
      mean = 5000,
      sd = sd(human_resources$monthly_income) / sqrt(100)
    )
  ) +
  # Kritischer Bereich 0 Hypothese
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "red",
    args = list(
      mean = 5000,
      sd = sd(human_resources$monthly_income) / sqrt(100)
    ),
    xlim = c(qnorm(.95, mean = 5000, 
                   sd = sd(human_resources$monthly_income) / sqrt(100)), 
             8000)
  ) +
  # Alternativhypothese
  stat_function(
    fun = dnorm,
    geom = "area",
    fill = "orange",
    alpha = .2,
    args = list(
      mean = 6000,
      sd = sd(human_resources$monthly_income) / sqrt(100)
    )
  ) +
  geom_vline(xintercept = 6000,
             color = "orange",
             size = 1) +
  labs(
    title = paste0("Nullhypothese mittleres Einkommen == 5000,",
                   "Alternativhypothese mittleres Einkommen == 6000"),
    subtitle = "N = 100",
    x = "Mittleres Einkommen",
    y = "Dichte"
  ) +
  scale_x_continuous(limits = c(2500, 8000))
``` -->


![](n_100.png)

Plötzlich, mit 100 Befragten ist das Ergebnis signifikant. Dies liegt an der Stichprobengröße:

> Die Signifikanz eines Ereignisses ist abhängig von der Stichprobengröße. Je größer die Stichprobe, desto eher wird ein sigifikantes Ergebnis erreicht.

Dieses Phänomen ist relativ einfach anhand des Standardfehlers der Verteilung zu erklären: 

$$
SE = \frac{\sigma}{\sqrt{N}}
$$

Mit einem steigenden N wird die Standardabweichung der Stichprobenkennwertverteilung kleiner. Hierdurch wird die Stichprobenkennwertverteilung steiler. 

> Signifkanz sollte immer in Abhängigkeit der Stichprobengröße, der Power (in den nächsten Kapiteln mehr dazu) und dem zu erwarteten Effekt interpretiert werden. Auf Grundlage eines signifikanten Ereignisses lassen sich keine gülten Schlüsse über die Güte einer Hypothese treffen.

## Die vier Entscheidungsarten von Hypothesen

Beim statistischen Hypothesentesten betreiben wir Wahrscheinlichkeitsrechnung. Beispielsweise wird unserer Stichprobenmittelwert nie dem Populationsmittelwert entsprechen. Hierdurch verändert sich unser Kennwert für jedes Experiment und dadurch teilweise auch die Entscheidung, ob ein Ereignis signifikant ist oder nicht. Wir können dabei zwei Arten von Fehlern machen und zwei korrekte Annahmen treffen:

|                        | Model C korrekt               | Model C nicht korrekt                 |
|------------------------|-------------------------------|---------------------------------|
| Model C ablehnen       |  Type I Fehler / Alpha Fehler | Richtige Entscheidung           |
| Model C nicht ablehnen | Richtige Entscheidung         |  Type II Fehler /   Beta Fehler |

### Type I Fehler / Alpha Fehler

Die Fehler 1. Art (Alpha Fehler) treten auf, wenn die Nullhypothese korrekt ist (z.B. indem wir keinen Unterschied zwischen Experimentalgruppen annehmen), wir uns allerdings auf Grundlage eines signifikanten Ergebnisses für die Alternativhypothese entscheiden. 

In der folgenden Grafik beispielsweise führen alle Kennwerte, die im dunkelblauen Bereich liegen zu einem Fehler der 1. Art.


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
    title = "Visualisierung des Alpha Fehlers",
    subtitle = "Entscheidung für die Alternativhypothese obwohl Nullhypothese stimmt",
    x = "z-score",
    y = "Dichte"
  ) +
  scale_x_continuous(limits = c(-3, 5))
``` -->

![](alpha_fehler.png)


### Type II Fehler / Beta Fehler

Die Fehler 2. Art (Alpha Fehler) treten auf, wenn die Nullhypothese nicht korrekt ist, wir uns allerdings dennoch für die Nullhypothese entscheiden, da wir kein signifikantes Ergebnis erhalten. 

In der folgenden Grafik beispielsweise führen alle Kennwerte, die im dunkelorangenen Bereich liegen zu einem Fehler der 2. Art.

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
    args = list(
      mean = 2
    ),
    xlim = c(-2, qnorm(.95))
  ) +
  stat_function(
    fun = dnorm,
    geom = "area",
    linetype = 2,
    fill = "orange",
    alpha = .3,
    args = list(
      mean = 2
    )
  ) +
  labs(
    title = "Visualisierung des Beta Fehlers",
    subtitle = "Entscheidung für die Nullhypothese obwohl Nullhypothese nicht korrekt ist",
    x = "z-score",
    y = "Dichte"
  ) +
  scale_x_continuous(limits = c(-3, 5))
``` -->

![](beta_fehler.png)

# Modeling Example - z-Test



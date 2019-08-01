# Stichprobenkennwertverteilungen

Wir haben im letzten Kapitel häufiger davon gesprochen, dass wir die Nullhypothese verwerfen, wenn der Fehler des kompakten Modells, durch das erweiterte Modell substantiell verkleinert wird. Aber was bedeutet es, dass ein Fehler substantiell verkleinert wird?  Um diese Frage beantworten zu können, verwenden wir **Stichprobenkennwertverteilungen**. Das Wort Stichprobenkennwertverteilung gibt uns bereits einige Hinweise, um zu verstehen, was dieses Wort bedeutet.

1. Stichprobe
2. Kennwert
3. Verteilung

## Stichprobe

Eine Stichprobe ist eine Teilmenge aus einer Grundgesamtheit. Wahlvorhersagen werden auf Grundlage von Stichproben gezogen, da es mühselig wäre, alle Menschen eines Landes (die Grundgesamtheit) zu befragen. Daher erheben wir immer nur einen kleinen Anteil der Population und versuchen auf Grundlage dieser Stichprobe auf die Population zu schließen.

## Kennwert

Statistische Kennwerte fassen mehrere Datenpunkte zusammen. Du kennst bereits mehrere dieser Kennwerte: Der Mittelwert, der z-Wert, die Standardabweichung oder die Varianz. Jeder dieser Kennwerte fasst Daten zusammen. Der Mittelwert gibt den typischen Wert einer Verteilung an, die Varianz gibt an, wie weit Werte um einen Mittelwert streuen. In den nächsten Wochen werden wir uns vor allem mit dem Mittelwert, PRE, dem t-Wert und dem F-Wert beschäftigen. All diese Werte sind statistische Kennwerte.

## Verteilung

Eine Verteilung ist eine grafische Darstellung des Auftretens einzelner Ausprägung einer Variable. Beispielsweise kennst du unimodale Verteilungen mit nur einem Gipfel:

```
ggplot(NULL, aes(x = c(-3, 3))) +
  stat_function(fun = dnorm,
                geom = "area",
                fill = "steelblue")
```

![](./images/unimodal.png)

Oder eine stetige Verteilung

![](./images/unimodal2.png)

Oder eine bimodale Verteilung:

```
nn <- 1e4
set.seed(1)
betas<-rbeta(nn,2,2)
sims <- c(betas[1:(nn/2)]*2+1,
          betas[(nn/2+1):nn]*2+3)


hist(sims)
```

![](./images/sims.png)


## Stichprobenkennwertverteilung revisited

Eine Stichprobenkennwertverteilung ist daher eine Verteilung von Kennwerten, die aus einer Stichprobe gewonnen werden. Beispielsweise:

* Die Verteilung von Mittelwerten, die aus mehreren Stichproben berechnet werden.
* Die Verteilung von PRE, die aus mehreren Stichproben berechnet werden.
* Die Verteilung von Varianzen, die aus mehreren Stichproben berechnet werden.

# Simulation einer Stichprobenkennwertverteilung in R

Um Stichprobenkennwertverteilungen besser zu verstehen, hilft es, diese zu simulieren. Stell dir vor, es gibt eine Population von 200.000 Menschen. Jede dieser Personen hat einen bestimmten Intelligenzquotienten, den wir allerdings nicht kennen:

Simulieren wir diese Population in R:

```
set.seed(123)
population <- rnorm(200000, mean = 100, sd = 15)
head(population) # 91.59287  96.54734 123.38062 101.05763 101.93932 125.72597
```

* Durch die [set.seed Funktion](https://www.rdocumentation.org/packages/simEd/versions/1.0.3/topics/set.seed) sorgen wir dafür, dass immer die gleichen Werte erzeugt werden, wenn wir willkürliche Daten generieren. In diesem Fall generieren wir eine Populuation von 200.000 Menschen.
* Die Funktion [rnorm](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Normal.html) erzeugt willkürliche Werte aus einer Normalverteilung. Die Funktion hat mehrere Argumente. Das erste Argument ist die Anzahl der Werte (hier 200000), das zweite Argument ist der Mittelwert der Normalverteilung (hier 100), das dritte Argument ist die Standardabweichung dieser Verteilung (hier 15). Bedenke, dass wir als Wissenschaftler diese Werte nie kennen. Würden wir sie kennen, müssten wir keine Inferenzstatistik betreiben, um auf diese Population zu schließen.

Nehmen wir nun an, dass wir 20 Personen aus dieser Stichprobe ziehen:

```
set.seed(456)
(my_sample <- sample(population, 20)) 
# [1]  72.24937  96.89288 116.28088  99.45451 101.94466 100.62200 113.09027 103.94516  68.33457  94.44999  85.76780 106.95938
# [13]  99.19620  91.27975  69.54343  97.14558 122.12985 109.88017 105.40160 103.11018
``` 

* Mit der Funktion [sample](https://stat.ethz.ch/R-manual/R-devel/library/base/html/sample.html) können wir n-beliebige Werte aus unserer Population ziehen.
* Durch die Klammer um die Variable `my_sample` sagen wir R, dass die Werte, welchein `my_sample` gespeichert sind, direkt ausgegeben werden.

Nun können wir den Mittelwert dieser Stichprobe berechnen:

```
mean(my_sample) # 97.88391
```

Unser Mittelwert ist 97.88. Der Mittelwert entspricht nicht ganz dem tatsächlichen Mittelwert von 100, da wir die Daten simuliert haben.

Um nun eine Stichprobenkennwertverteilung zu generieren, benötigen wir *sehr viele* dieser Stichprobenkennwerte. Versuchen wir einmal 10 solcher Mittelwerte aus der Population zu berechnen (den R-Code musst du an dieser Stelle nicht verstehen, er dient eher zur Generierung der Werte):

```
(five_samples <- c(1:5) %>% map_dbl(~ sample(population, 20) %>% mean))
ggplot(NULL, aes(x = five_samples)) +
  geom_histogram(fill = "steelblue", color = "black") +
  labs(
    x = "Intelligenz",
    y = "Häufigkeit",
    title = "Stichprobenkennwertverteilung 5 Personen"
  )
```

![](./images/skv_fuenf.png)

Die Stichprobenkennwerteverteilung bei 5 Stichproben sieht noch ziemlich unimodal aus. Was passiert, wenn wir 100 Stichproben aus der Population ziehen und die Mittelwerte anhand einer Verteilung darstellen:

```
(hundred_samples <- c(1:100) %>% map_dbl(~ sample(population, 20) %>% mean))
ggplot(NULL, aes(x = hundred_samples)) +
  geom_histogram(fill = "steelblue", color = "black") +
  labs(
    x = "Intelligenz",
    y = "Häufigkeit",
    title = "Stichprobenkennwertverteilung 100 Personen"
  )
```

![](./images/hundred_samples.png)

Mittlerweile ist ein grobes Muster zu erkennen. Es scheint selten der Fall zu sein, dass eine Stichprobe einen Mittelwert von über 105 erhält, ebensowenig scheint es häufig der Fall zu sein, dass eine Stichprobe einen Mittelwert unter 94 erhält. 

Was passiert, wenn wir plötzlich 10.000 Stichproben ziehen?

```
(tenthousand_samples <- c(1:10000) %>% map_dbl(~ sample(population, 20) %>% mean))
ggplot(NULL, aes(x = tenthousand_samples)) +
  geom_histogram(fill = "steelblue", color = "black") +
  labs(
    x = "Intelligenz",
    y = "Häufigkeit",
    title = "Stichprobenkennwertverteilung 10.000 Personen"
  )
```

![](./images/tenthousand.png)

Nun erhalten wir eine unimodale Verteilung. Selten haben Stichproben einen Mittelwert von unter 93, selten haben Stichproben einen Mittelwert von über 103. Diese Werte sind ungewöhnliche Ereignisse. Was du siehst ist eine Stichprobenkennwertverteilung des Mittelwerts.

# Eigenschaften von Stichprobenkennwertverteilungen

## Je größer die Stichprobe, desto kleiner die Standardabweichung der Normalverteilung

```R
(twenty <- c(1:10000) %>% 
    map_dbl(~ sample(population, 20) %>% mean))

(fivty <- c(1:10000) %>% 
    map_dbl(~ sample(population, 50) %>% mean))

(hundred <- c(1:10000) %>% 
    map_dbl(~ sample(population, 100) %>% mean))

tibble(
  twenty = twenty,
  fivty = fivty,
  hundred = hundred
) %>% 
  gather(sample, value) %>% 
  ggplot(aes(x = value, fill = sample)) +
  geom_density(aes(fill = sample), alpha = .7) +
  labs(
    title = "Stichprobenkennwertverteilungen bei unterschiedlichen Stichprobengrößen",
    fill = "Stichprobe",
    x = "Mittelwert der Intelligenz",
    y = "Dichte"
  )
```

![](./images/kennwertverteilungen_stichproben.png)

Die rote Stichprobenkennwertverteilung zeigt eine Stichprobenkennwertverteilung an, die aus Stichproben mit 50 Personen generiert wurde. Die blaue Stichprobenkennwertverteilung wurde anhand einer Stichprobengröße von 20 Personen generiert. Die grüne Stichprobenkennwertverteilung wurde anhand einer Stichprobe von 100 Personen generiert. 

Du siehst, dass die Verteilung mit einer steigenden Stichprobengröße eine geringe Varianz aufweißt und *steiler* wird. Ein Grund hierfür ist, dass der Kennwert durch eine größere Stichprobe akkurater geschätzt wird. Stell dir das Extrem vor: Deine Stichproben sind fast so groß wie die ganze Population. Als Folge wirst du fasst immer Werte erhalten, die fast exakt dem Mittelwert entsprechen. Die Stichprobenkennwertverteilung wird daher sehr schmal sein. Bei einer geringen Stichprobe erhälst du den gegenteiligen Effekt. Deine Schätzungen des Kennwertes werden sehr variieren, daher ist deine Stichprobenkennwertverteilung breiter.

## Die Standardabweichung der Stichprobenkennwertverteilung nennt man Standardfehler

Jede Verteilung hat einen Mittelwert und eine Standardabweichung. Die Stichprobenkennwertverteilung ist keine Ausnahme. Auch sie hat eine Standardabweichung. Diese nennen wir **Standardfehler**. Der Standardfehler der Stichprobenverteilung des Mittelwerts können wir folgendermaßen folgendermaßen schätzen:

$$
SE = \frac{\sigma}{sqrt{N}}
$$

Wir müssen den Standardfehler schätzen, da wir die Standardabweichung der Population in der Regel nicht kennen. Daher nehmen wir die Standardabweichung der Stichprobe, um den Standardfehler der Stichprobenkennwertverteilung zu schätzen.

Durch diese Formel lässt sich auch erklären, weshalb der Standardfehler bei einer größeren Stichprobe kleiner wird. Stell dir eine Stichprobe von 20 vor. Die Standardabweichung der Verteilung der Stichprobe ist 100:

$$
SE = \frac{100}{sqrt{20}} = 5
$$

Hätten wir eine Stichprobe von 50 Personen bei einer gleichen Standardabweichung, wäre der Standardfehler:

$$
SE = \frac{100}{sqrt{50}} = 2
$$


## Die Streuung in der Population ist immer größer als die Streuung in der Stichprobenkennwertverteilung

Der Grund für dieses Phänomen liegt darin, dass eine Stichprobe eines Kennwertes weniger wahrscheinlich extreme Werte einer Verteilung generiert als die tatsächlichen Werte. Stell dir vor, es gibt eine Person mit einem Intelligenzquotienten von 140. Dies ist ein seltenes Ereignis. Da ein Kennwert immer eine Aggregierung mehrerer Werte ist, wird dieser hohe Intelligenzquotient zwar mit hinein gerechnet, aber immer durch weniger extreme Werte angeglichen. Hierduch ist die Streuung in der Population größer als in der Stichprobe.

## Der Mittelwert der Stichprobenkennwertverteilung ist der gleiche Mittelwert der Population

Zwar ist die Streuung der Stichprobenkennwertverteilung, deren Mittelwert ist allerdings der gleiche.


# Normalverteilung

Normalverteilungen sind besondere Verteilungen, die häufig in der Natur anzutreffen sind. Beispielsweise entspricht die Intelligenz von Personen in der Regel einer Normalverteilung. Ebenso entspricht die Größe von Personen oder der Blutdruck von Personen. 

Eine Normalverteilung sieht immer so aus:

```R
ggplot(NULL, aes(x = c(-3, 3))) +
     stat_function(fun = dnorm,
                   geom = "area", fill = "steelblue") + 
      labs(title = "Normalverteilung", x = "Kennwerte", y = "Dichte")
```

![](./images/normal_distribution.png)

Normalverteilungen zeichen sich durch folgende Eigenschaften aus:

1. Sie ist unimodal. Es gibt nur einen Gipfel.
2. Sie ist symmetrisch vom Zentrum der Verteilung.
3. Der Mittelwert, der Modus und der Median sind gleich.
4. Die gesamte Fläche der Verteilung hat den Wert 1.

Zusätzlich hat die Normalverteilung einige wichtige statistiche Eigenschaften:

* 68% der Werte fallen eine Standardabweichung vom Mittelwert.
* 95% der Werte fallen zwei Standardabweichungen vom Mittelwert.
* 99.7% der Werte fallen innerhalb von drei Standardabweichungen vom Mittelwert.

```R
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
```

![](./images/normalverteilung_prozent.png)

## Zusätzliche Informationen

* [Explaining the 68-95-99.7 rule for a normal distribution](https://towardsdatascience.com/understanding-the-68-95-99-7-rule-for-a-normal-distribution-b7b7cbf760c2)
* [Normal distributions - Statistics How To](https://www.statisticshowto.datasciencecentral.com/probability-and-statistics/normal-distributions/)


# Standardnormalverteilung

Die Standardnormalverteilung ist eine besondere Normalverteilung, für die folgendes gilt:

* Der Mittelwert der Standardnormalverteilung ist immer 0.
* Die Standardabweichung der Standardnormalverteilung ist immer 1.

![](./images/standardnormalverteilung.png)


# Zentrales Grenzwerttheorem

Die Stichprobenkennwertverteilung des Mittelwerts (und des Medians) hat eine besondere Eigenschaft. 

> Unabhängig davon, welche Verteilung (z.B. bimodel, unimodal, stetig) eine Population hat, die Stichprobenkennwertverteilung des Mittelwerts entspricht immer einer Normalverteilung. 




# z-Transformation

Um aus einer Normalverteilung eine Standardnormalverteilung zu erhalten, kann man die Normalverteilung durch eine z-Transformation in eine Standardnormalverteilung überführen.

Um den Mittelwert der Normalverteilung auf 0 zu siehen, verschieben wir die Verteilung um den Wert jedes Datenpunktes ($Y$) um den Mittelwert der Verteilung ($\mu$): $Y - \mu$. Im nächsten Schritt teilen wir diesen Wert durch die Standardabweichung ($\sigma$) und erhalten hierdurch eine Standardabweichung von 1:

$$
z = \frac{Y - \mu}{\sigma}
$$


#  Wahrscheinlichkeiten aus Stichprobenkennwertverteilungen berechnen

Stichprobenkennwertverteilungen können uns Auskunft darüber geben, wie wahrscheinlich ein Ereignis ist. Stellen wir uns erneut die Verteilung der Intelligenz von Personen vor. Der Intelligenzquotient in der Population hat immer einen Mittelwert von 100 und eine Standardabweichung von 15. Wie wahrscheinlich ist dann beispielsweise, einen Intelligenzquotienten von über 115 zu haben? Gehen wir das Problem Schritt für Schritt durch:

Zunächst berechnen wir den z-Wert dieses Intelligenzquotienten:

$$
z = \frac{115 - 100}{15} = 1
$$

Diesen z-Wert können wir in der Standardnormalverteilung abbilden. 

```
z_score <- (115 - 100) / 15

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

![](./images/z_score_intelligence.png)


Wir hatten bereits erklärt, dass die Fläche von Stichprobenkennwertverteilungen immer 1 ist. Dieser Wert ist gleichzeitig die Wahrscheinlichkeit eines Ereignisses. Der blaue Bereich zeigt an, wie wahrscheinlich es ist, einen willkürlichen Intelligenzquotienten zu besitzen. Die Wahrscheinlichkeit liegt bei 100%.

Wie wahrscheinlich ist es, einen Intelligenzquotienten von über 100 zu besitzen? 50%. Warum? Da wir wissen, das die Standardnormalverteilung symmetrisch ist und der Mittelwert der Standardnormalverteilung dem standardisierten Mittelwert der Verteilung der Intelligenz entspricht. Im folgenden Bild sind diese 50% als Fläche dargestellt:

```
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
    xlim = c(0, 3)
  ) +
  labs(
    title = "Rot dargestellt die Wahrscheinlichkeit einen IQ von über 100 zu haben",
    x = "Intelligenz als z-Wert",
    y = "Dichte"
  )
```

![](./images/iq_50_percent.png)


In R können wir diese Wahrscheinlichkeit mit der Funktion [pnorm](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Normal.html) berechnen:

```R
pnorm(0, mean = 0, sd = 1) # 0.50
```

Der erste Argument der Funktion ist der Wert auf der x-Achse der Normalverteilung (hier der z-Wert). Das zweite Argument ist der Mittelwert der Verteilung (hier 0). Das dritte Argument ist die Standardabweichung der Verteilung (hier 1). Wir wissen also, dass 50% der Menschen einen Intelligenzquotienten über 100 haben. Wie viele Menschen haben nun einen Intelligenzquotienten von über 115? Schauen wir uns die Verteilung dieser Werte zunächst grafisch an:

```
z_score <- (115 - 100) / 15

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
    xlim = c(1, 3)
  ) +
  labs(
    title = "Wahrscheinlichkeit einen IQ über 15 zu haben",
    x = "Intelligenz als z-Wert",
    y = "Dichte"
  ) +
  geom_vline(xintercept = z_score,
             color = "red",
             size = 2) 
```

![](./images/iq_above_115.png)

Die rote Fläche kennzeichnet nun die Wahrscheinlichkeit einen Intelligenzquotienten über 115 zu haben. Berechnen wir diese Wahrscheinlichkeit in R:

```R
1 - pnorm(1, mean = 0, sd = 1) # 0.1586553 -> 15.87%
```

Warum ziehen wir die Wahrscheinlichkeit von 1 ab? Da pnorm uns immer die Fläche links der Verteilung zurück gibt, in diesem Fall also die blaue Fläche. Da wir wissen, dass die Wahrscheinlichkeit einer Stichprobenkennwertverteilung immer 1 ist, können wir diese Wahrscheinlichkeit von 1 abziehen und erhalten dadurch den Komplement. Nur 15.87% der Menschen haben also einen Intelligenzquotienten von über 115. 

# Generalisierung der Wahrscheinlichkeitsberechnung aus Stichprobenkennwertverteilungen

## Die Wahrscheinlichkeit eines einzelnen Ereignisses ist bei stetigen Variablen immer gleich 0

Wie wahrscheinlich ist es, einen Intelligenzquotienten von 98,564 zu haben? Diese Frage muss bei stetigen Verteilungen wie der Intelligenz, in der es unendlich viele Zwischenwerte gibt immer mit 0 beantwortet werden. Einzelne Ereignisse sind so unwahrscheinlich, da stetige Variablen unendliche genau sein können. Es wird keine zwei Personen geben, die einen Intelligenzquotienten von genau 98,564 haben. Was wir aber berechnen können ist die Wahrscheinlichkeit mindestens höchsten ein Ereignis zu haben, zu berechnen. Genausogut können wir die Wahrscheinlichkeit zwischen zwei Ereignissen berechnen. Beispielsweise, wie wahrscheinlich ist es, einen IQ von über 90 und von unter 105 zu haben? 


```
z_score_90 <- (90 - 100) / 15
z_score_105 <- (105 - 100) / 15

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
    xlim = c(z_score_90, z_score_105)
  ) +
  labs(
    title = "Wahrscheinlichkeit einen IQ über über 90 und unter 105 zu haben",
    x = "Intelligenz als z-Wert",
    y = "Dichte"
  ) +
  annotate("text", x = -0.3,
           y = 0.2, label = "37.8%")
```

![](./images/iq_90_105.png)


Die Wahrscheinlichkeit einen IQ über 90 und unter 105 zu haben, ist in der Grafik rot dargestellt. Erneut können wir diese Wahrscheinlichkeit in R berechnen:

```R
pnorm(z_score_105) - pnorm(z_score_90) # 0.3780661
```

# Statistisches Hypothesentesten auf Grundlage von Stichprobenkennwertverteilungen



# Stichprobenkennwertverteilung von PRE


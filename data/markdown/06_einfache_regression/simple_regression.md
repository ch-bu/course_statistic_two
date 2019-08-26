# Modelle

## Fragestellungen der einfachen linearen Regression

Bisher konnten wir Hypothesen testen, die Unterschiede zwischen einem vorgegebenen Mittelwert und dem Mittelwert einer Stichprobe testeten. Unsere Modelle hierfür sahen folgendermaßen aus:

Kompaktes Modell:

$$
Y_i = B_0 + e_{i}
$$

Erweitertes Modell:

$$
Y_i = b_0 + e_{i}
$$

Solche einfachen Modelle werden allerdings in der Sozialforschung selten verwendet, um Hypothesen zu testen. In diesem Modul werden wir das Modelle der einfachen linearen Regression kennen lernen, durch die wir spezifischere Fragestellungen testen können:

* Gibt es einen signifikanten Zusammenhang zwischen der Anzahl der gelesenen Bücher und der Intelligenz?
* Gibt es einen signifikanten Zusammenhang zwischen der Mathematiknote und der Englischnote im Abitur?
* Gibt es einen signifikanten Zusammenhang zwischen der Klassengröße und dem Lernerfolg einer Klasse?

## Das zwei-Parameter Modell

Um gerade genannten Hypothesen zu testen, berechnen wir ein Modell mit zwei Parametern und einer intervallskalierten Variable. Stell dir beispielsweise vor, wir möchten die Hypothese prüfen, ob es einen signifikanten Zusammenhang zwischen dem monatlichen Einkommen der Mitarbeiter und der Anzahl der Arbeitsjahre der Mitarbeiter gibt. Man sollte annehmen, dass Mitarbeiter mehr verdienen, je länger sie arbeiten. Das erweiterte Modell, welches wir finden möchten, sähe folgendermaßen aus:

$$
Y_i = \beta_0 + \beta_1 * X_1 + e_i
$$

<!-- ```R
ggplot(human_resources, aes(x = total_working_years, y = monthly_income)) +
geom_point() +
geom_smooth(method = "lm", se = FALSE) +
labs(
  title = "Einfache lineare Regression",
  x = "Anzahl der Arbeitsjahre",
  y = "Monatliches Einkommen"
)
``` -->

![](simple_regression.png)

* Das Modell ist als blaue Linie dargestellt.
* $Y_i$ steht für das monatliche Gehalt eines einzelnen Mitarbeiters. In der Visualisierung erkennen wir diese Werte anhand der Y-Achsenwerte der einzelnen Punkte.
* $\beta_0$ steht für den Punkt, an dem die Regressionsgerade die Y-Achse schneidet (hier ist dieser Wert 1227,9).
* $\beta_1$ steht für die Steigung der Geraden. Wäre die Steigung 0, würde die Regressionsgerade parallel zur X-Achse verlaufen.
* $X_1$ steht für die Anzahl der Arbeitsjahre der Mitarbeiter.

Auf Grundlage dieser können wir bereits einige Dinge erkennen: Je mehr Arbeitsjahre eine Mitarbeiterin hat, desto mehr verdient diese Mitarbeiterin. Dies können wir daran erkennen, dass die Steigung der Geraden positiv ist. Unser Modell erklärt nicht die ganze Varianz des Gehalts. Viele Punkte sind weit von der Regressionsgeraden entfernt. Dies bedeutet, dass andere Faktoren als die Arbeitsjahre darüber entscheiden wie viel eine Mitarbeiterin verdient. Beispielsweise kann die Rolle des Jobs (z.B. Manager) einen Einfluss auf das Gehalt der Mitarbeiterin haben (dies werden wir in späteren Modellen testen). Manager sollten mehr verdienen als Sekretärinnen.

Diese einzelnen Parameter können wir berechnen (mehr dazu später):

$$
Y_i = 1227.9 + 467.7 * X_1 + e_i
$$

$\beta_0$ gibt uns an, welches Gehalt wir annehmen würden, hätte eine Person noch keine Arbeitserfahrung:

$$
Y_i = 1227.9 + 467.7 * 0 + e_i = 1227.9 + e_i
$$

$\beta_1$ können wir folgendermaßen interpretieren: Mit jeder Arbeitsjahr mehr verdient eine Mitarbeiterin 467,7 Dollar mehr:

$$
Y_i = 1227.9 + 467.7 * 1 + e_i = 1227.9 + 467.7 + e_i = 1695.6
$$

Wenn unsere Mitarbeiterin, daher ein ganzes Jahr arbeitet sollte sie laut unserem Modell anstatt 1227,9 1695,6 Dollar verdienen.

Wir können durch $\beta_1$ auch erkennen, dass es einen positiven Zusammenhang zwischen den Arbeitsjahren und dem monatlichen Gehalt gibt. Wäre $\beta_1$ negativ, hätten wir einen negativen Zusammenhang.

Die Regressionsgerade erlaubt uns daher genauere Vorhersagen als das einfache Modell $Y_i = b_0 + e_i$. Beispielsweise können wir das Gehalt einer Mitarbeiterin schätzen, die bereits 20 Jahre arbeitet:

$$
\hat{Y}_i = 1227.9 + 467.7 * 20 = 10581.9
$$

## Rückschluss DATA = MODEL + ERROR

Zu Beginn unseres Kurses hatten wir statistische Modelle durch die Formel DATA = MODEL + ERROR beschrieben. Unser Modell ist bei der einfachen linearen Regression daher:

$$
\beta_0 + \beta_1 * X_1
$$

Da wir allerdings die Population nicht kennen und daher $\beta_0$ und $\beta_1$ schätzen müssen, berechnen wir $b$-Koeffizienten auf Grundlage unserer Stichprobe:

$$
\hat{Y}_i = b_0 + b_1 * X_1
$$

Der Fehler ergibt sich durch:

$$
e_i = Y_i - \hat{Y}_i = Y_i - (b_0 + b_1*X_1)
$$

Wenn beispielsweise eine Person in Wirklichkeit 3646 Dollar verdient, wir allerdings auf Grundlage unseres Modells 2713 Dollar schätzen, beläuft sich der Fehler auf $3646 - 2713 = 933$.

<!-- ```R
set.seed(154)
s <- human_resources %>% 
  sample_n(5)
m <- lm(monthly_income ~ total_working_years, data = s)
s <- s %>% add_predictions(m)

ggplot(s, aes(x = total_working_years, y = monthly_income)) +
  geom_point() +
  geom_segment(aes(xend = total_working_years,
                   yend = pred),color = "red") +
  # annotate("segment", x = 3, xend = 3, y = 2712.945, yend = 3760,
  #         color = "red") +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Visualisierung Fehler einfache lineare Regression",
    x = "Anzahl der Arbeitsjahre",
    y = "Monatliches Einkommen"
  )
``` -->

Grafisch dargestellt sind diese Fehler der Abstand der tatsächlichen Werte des monatlichen Gehalts $Y_i$ und den regredierten Werte $\hat{Y}_i$:

![](fehler_linear_regression.png)

Statistische Modelle werden fast nie identische Werte für $Y_i$ und $\hat{Y}_i$ liefern, da es sich um einen probabilistischen Zusammenhang und keinen deterministischen Zusammenhang handelt. Am Ende des Moduls werden wir testen, wie gut dieser Zusammenhang ist.

<!-- ## z-standardisierte Regression

Du kennst bereits den Korrelationskoeffizienten zweier Variablen. Der Koeffizent gibt uns an, wie stark zwei Variablen miteinander korrelieren. Eine Korrelation von 1 bedeutet, dass alle Punkte auf der Regressionsgeraden liegen und wir daher $Y_i$ exakt durch unseren Parameter $X_1$ hervor sagen können.

Mit Hilfe der z-Standardisierung können wir unser Modell auf ein Parameter vereinfachen:

$$
\hat{Y}_i = b_1 * X_1
$$

Eine Möglichkeit das Modell zu vereinfachen ist die z-Standardisierung  -->


# Berechnung Regressionsgerade

## Konzeptuelles Verständnis

## Matrixalgebra

## Weitere Formeln


# Statistische Inferenz

## Konzeptuelles Verständnis

## Modellgüte

## Konfidenzintervalle beta

## F-Test

## t-Test

## Beispiel

# Modeling Example

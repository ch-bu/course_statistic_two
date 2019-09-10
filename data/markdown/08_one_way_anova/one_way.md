# Kategoriale Prädktoren

## Kategorialen Prädiktoren

Bisher hatten wir uns Modelle angeschaut, in denen die Prädiktoren intervallskaliert waren. In der experimentellen Forschung möchten wir allerdings häufig prüfen, ob sich beispielsweise Gruppen voneinander unterscheiden. Beispielsweise könnten wir uns fragen, ob Schüler\*innen, die auf dem Land wohnen mehr Alkohol trinken als Studierende, die in der Stadt wohnen. In diesem Modul werden wir zum ersten Mal Hypothesen testen, deren Prädiktoren kategoriell sind.

Um kategoriale Prädiktoren in unser Modell einzufügen, müssen wir Ihnen numerische Werte zuordnen. Anders ausgedrückt: Wir müssen einen Weg finden, Kategorien auf dem Land wohnen vs. in der Stadt wohnen, in numerische Werte umzuwandeln. Tatsächlich können wir dies tun, in dem wir diesen Kategorien willkürliche Werte zuordnen. Beispielsweise könnten wir den SuS, die auf dem Land wohnen, den Wert 1 zuordnen und den SuS, die in der Stadt wohnen den Wert -1 zuordnen. Genausogut könnten wir SuS, die auf dem Land wohnen, den Wert 289 zuordnen und SuS, die in der Stadt wohnen den Wert 5 zuordnen.

### Kontrastegewichte

Wir werden im folgenden von Kontrastgewichten sprechen, wenn folgendes gilt:

$$
\sum_k \lambda_k = 0
$$

$\lambda_k$ steht für die einzelnen Kontrastgewichte (z.B. -1). In anderen Worten: Die Summe der Kontratsgewichte sollte 0 ergeben. Daraus schließt sich, dass die Kontrastgewichte -1 und 1 gültig sind, die Kontrastgewichte 289 und 5 hingegen nicht, da ihre Summe nicht 0 ergibt. 

Achte darauf, dass wir hier die Kontrastgewichte der Anzahl der Kategorien summieren, nicht der einzelnen Personen. Die macht einen deutlichen Unterschied, sofern die Gruppengröße der einzelnen Kategorien unterschiedlich ist.

Achte auch darauf, dass die Kontrastgewichte bei zwei Kategorien von -5 und 5 ebenso gültig sind, da auch ihre Summe 0 ergibt.

## Modelle mit kategorialen Prädiktoren

Im nächsten Schritt können wir unser Modell aufstellen. Ein erweitertes Modell mit zwei kategorialen Prädiktoren benötigt immer $k - 1$ Prädiktoren. Wenn wir beispielsweise prüfen, ob Schüler\*innen, die auf dem Land wohnen mehr Alkohol trinken als Studierende, die in der Stadt wohnen, benötigen wir *einen* Prädiktor.

$$
Y_i = \beta_0 + \beta_1 * X_1 + \epsilon_i
$$

Für den Prädiktor $X_1$ setzen wir unsere Kontrastgewichte ein. Beispielsweise 1, wenn ein\*e Schüler\*in vom Land kommt.  

Wenn wir die Betakoeffizienten berechnen, erhalten wir folgendes Modell:

$$
\hat{Y} = 
$$

## Interpretation der Betagewichte

## Beispiel

# Kontraste

## Konzeptuelle Einführung

## Orthogonale Kontraste

## Nicht-orthogonale Kontraste

## Geplante vs. Post-Hoc Kontraset

F-Wert Anpassung

# Statistische Inferenz

## t-Test für unabhängige Stichproben

## Einfaktorielle Varianzanalyse

# Modeling Example

Mehrere Hypothesen anzeigen
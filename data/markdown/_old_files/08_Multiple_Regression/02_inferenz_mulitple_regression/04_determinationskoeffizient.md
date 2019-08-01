---
moduleTitle: Multiple Regression
unitTitle: Inferenz Multiple Regression
title: R-Squared - Determinationskoeffizient
module: 8
unit: 2
subunit: 4
type: instruction
---

PRE bei der multiplen Regression hat noch einen anderen Namen: 

**Der Determinationskoeffizient** oder $R^2$. 

> Dieser Begriff ist wichtig, ihn solltest du ihn gut einprägen. 

Schauen wir uns nochmal unseren PRE aus der vorherigen Folie an: 

$
PRE = \frac{SSR}{SSE(C)}
$

```python
(pre <- ssr / sse_c) # 0.8133409
```

## Der Determinationskoeffizient

Wenn wir in R herkömmlich eine multiple Regressions berechnen, können wir uns diesen Wert mit Hilfe der Funktion `summary` direkt ausgeben lassen: 

```
lm(height ~ footsize + height_father, data = person_data) %>% summary %>% {.$r.squared}
```

```
[1] 0.8133912
```

Uns tatsächlich, der Wert stimmt fasst exakt mit unserer Berechnung von PRE überein (der Rest sind kleine Rundungsfehler, die nicht in das Gewicht fallen). 
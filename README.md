# da\_stata

Código en Stata para los cursos de **análisis de datos, métodos multivariados y econometría** de Rodrigo Taborda (Escuela de Administración, Universidad de los Andes).

Cada archivo `.do` desarrolla un tema completo: carga los datos, aplica los comandos y deja comentados los pasos para que se puedan seguir en clase o de forma autónoma.

## Contenido

Todo el código está en la carpeta [`dofiles/`](dofiles/). El nombre de cada archivo indica el tema.

### Introducción y regresión lineal

* [`intro`](dofiles/intro.do)
* [`regresion\\\_lineal\\\_intro`](dofiles/regresion_lineal_intro.do)
* [`regresion\\\_lineal\\\_inferencia`](dofiles/regresion_lineal_inferencia.do)
* [`regresion\\\_lineal\\\_inferencia\\\_sim`](dofiles/regresion_lineal_inferencia_sim.do)
* [`regresion\\\_lineal\\\_supuestos`](dofiles/regresion_lineal_supuestos.do)
* [`regresion\\\_lineal\\\_otros1`](dofiles/regresion_lineal_otros1.do)
* [`regresion\\\_xaleatoria\\\_endogeneidad`](dofiles/regresion_xaleatoria_endogeneidad.do)
* [`mv`](dofiles/mv.do)
* [`Sampling Distribution Stata Code`](dofiles/Sampling%20Distribution%20Stata%20Code.do)

### Modelos de respuesta limitada

* [`probit\\\_logit`](dofiles/probit_logit.do)
* [`probit\\\_logit\\\_ordenado`](dofiles/probit_logit_ordenado.do)
* [`conteo`](dofiles/conteo.do)
* [`regresion\\\_survival`](dofiles/regresion_survival.do)
* [`survival\\\_hunger`](dofiles/survival_hunger.do)

### Datos panel y multinivel

* [`datos\\\_panel`](dofiles/datos_panel.do)
* [`datos\\\_panel\\\_poe`](dofiles/datos_panel_poe.do)
* [`multilevel`](dofiles/multilevel.do)

### Métodos multivariados

* [`multivariado\\\_preliminares`](dofiles/multivariado_preliminares.do)
* [`anova\\\_manova`](dofiles/anova_manova.do)
* [`cluster`](dofiles/cluster.do)
* [`pca\\\_fa`](dofiles/pca_fa.do)
* [`sem`](dofiles/sem.do)

### Series de tiempo y finanzas

* [`series\\\_tiempo0`](dofiles/series_tiempo0.do)
* [`series\\\_tiempo1`](dofiles/series_tiempo1.do)
* [`series\\\_tiempo\\\_arma`](dofiles/series_tiempo_arma.do)
* [`series\\\_tiempo\\\_arima`](dofiles/series_tiempo_arima.do)
* [`series\\\_tiempo\\\_filtros`](dofiles/series_tiempo_filtros.do)
* [`series\\\_tiempo\\\_cointegracion`](dofiles/series_tiempo_cointegracion.do)
* [`series\\\_tiempo\\\_cointegracion\\\_oil\\\_maize`](dofiles/series_tiempo_cointegracion_oil_maize.do)
* [`series\\\_tiempo\\\_commodities\\\_ipvn`](dofiles/series_tiempo_commodities_ipvn.do)
* [`series\\\_tiempo\\\_var\\\_vec`](dofiles/series_tiempo_var_vec.do)
* [`series\\\_tiempo\\\_finanzas`](dofiles/series_tiempo_finanzas.do)
* [`series\\\_tiempo\\\_volatilidad0`](dofiles/series_tiempo_volatilidad0.do)
* [`series\\\_tiempo\\\_volatilidad1`](dofiles/series_tiempo_volatilidad1.do)
* [`series\\\_tiempo\\\_volatilidad2`](dofiles/series_tiempo_volatilidad2.do)
* [`VaR`](dofiles/VaR.do)

### Simulación

* [`simulation`](dofiles/simulation.do)
* [`mercadeo\\\_simulacion`](dofiles/mercadeo_simulacion.do)

## Cómo usarlo

1. Descargue o clone el repositorio.
2. Abra el archivo `.do` del tema que le interesa en Stata.
3. Ejecute el código por bloques, leyendo los comentarios.

La mayoría de los archivos cargan los datos directamente desde internet (`rodrigotaborda.com`, *Principles of Econometrics*, Stata Press, UCLA), así que solo se necesita conexión. Algunos archivos usan bases locales que no están incluidas en el repositorio.

Algunos temas usan comandos que no vienen con Stata por defecto (por ejemplo, `freduse`). Si un comando no se reconoce, instálelo con `ssc install nombre\\\_del\\\_comando`.

## Créditos

La mayor parte del código es de Rodrigo Taborda. Algunos archivos se basan en material de otros autores, indicado en el encabezado de cada uno:

* `Sampling Distribution Stata Code.do` — John V. Kane (New York University).
* `survival\\\_hunger.do` — Brett Keller.
* `datos\\\_panel\\\_poe.do` y `series\\\_tiempo1.do` — ejemplos basados en *Principles of Econometrics* (Hill, Griffiths y Lim).
* `mv.do` — en coautoría con Laura Pardo.

## Contacto

Rodrigo Taborda — [rodrigotaborda.com](https://rodrigotaborda.com)


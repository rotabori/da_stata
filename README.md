# da_stata

Código en Stata para los cursos de **análisis de datos, métodos multivariados y econometría** de Rodrigo Taborda (Escuela de Administración, Universidad de los Andes).

Cada archivo `.do` desarrolla un tema completo: carga los datos, aplica los comandos y deja comentados los pasos para que se puedan seguir en clase o de forma autónoma.

## Contenido

Todo el código está en la carpeta [`dofiles/`](dofiles/). El nombre de cada archivo indica el tema.

### Introducción a Stata

- [`intro`](dofiles/intro.do): comandos básicos para leer, examinar, organizar y explorar datos.
- [`multivariado_preliminares`](dofiles/multivariado_preliminares.do): funciones, gráficos, distribuciones de probabilidad y distribución muestral.

### Regresión lineal

- [`regresion_lineal_intro`](dofiles/regresion_lineal_intro.do)
- [`regresion_lineal_inferencia`](dofiles/regresion_lineal_inferencia.do)
- [`regresion_lineal_inferencia_sim`](dofiles/regresion_lineal_inferencia_sim.do)
- [`regresion_lineal_supuestos`](dofiles/regresion_lineal_supuestos.do)
- [`regresion_lineal_otros1`](dofiles/regresion_lineal_otros1.do)
- [`regresion_xaleatoria_endogeneidad`](dofiles/regresion_xaleatoria_endogeneidad.do)
- [`mv`](dofiles/mv.do)
- [`Sampling Distribution Stata Code`](dofiles/Sampling%20Distribution%20Stata%20Code.do)

### Modelos de respuesta limitada

- [`probit_logit`](dofiles/probit_logit.do)
- [`probit_logit_ordenado`](dofiles/probit_logit_ordenado.do)
- [`conteo`](dofiles/conteo.do)
- [`regresion_survival`](dofiles/regresion_survival.do)
- [`survival_hunger`](dofiles/survival_hunger.do)

### Datos panel y multinivel

- [`datos_panel`](dofiles/datos_panel.do)
- [`datos_panel_poe`](dofiles/datos_panel_poe.do)
- [`multilevel`](dofiles/multilevel.do)

### Métodos multivariados

- [`anova_manova`](dofiles/anova_manova.do)
- [`cluster`](dofiles/cluster.do)
- [`pca_fa`](dofiles/pca_fa.do)
- [`sem`](dofiles/sem.do)

### Series de tiempo y finanzas

- [`series_tiempo0`](dofiles/series_tiempo0.do)
- [`series_tiempo1`](dofiles/series_tiempo1.do)
- [`series_tiempo_arma`](dofiles/series_tiempo_arma.do)
- [`series_tiempo_arima`](dofiles/series_tiempo_arima.do)
- [`series_tiempo_filtros`](dofiles/series_tiempo_filtros.do)
- [`series_tiempo_cointegracion`](dofiles/series_tiempo_cointegracion.do)
- [`series_tiempo_cointegracion_oil_maize`](dofiles/series_tiempo_cointegracion_oil_maize.do)
- [`series_tiempo_commodities_ipvn`](dofiles/series_tiempo_commodities_ipvn.do)
- [`series_tiempo_var_vec`](dofiles/series_tiempo_var_vec.do)
- [`series_tiempo_finanzas`](dofiles/series_tiempo_finanzas.do)
- [`series_tiempo_volatilidad0`](dofiles/series_tiempo_volatilidad0.do)
- [`series_tiempo_volatilidad1`](dofiles/series_tiempo_volatilidad1.do)
- [`series_tiempo_volatilidad2`](dofiles/series_tiempo_volatilidad2.do)
- [`VaR`](dofiles/VaR.do)

### Simulación

- [`simulation`](dofiles/simulation.do)
- [`mercadeo_simulacion`](dofiles/mercadeo_simulacion.do)

## Cómo usarlo

1. Descargue o clone el repositorio.
2. Abra el archivo `.do` del tema que le interesa en Stata.
3. Ejecute el código por bloques, leyendo los comentarios.

La mayoría de los archivos cargan los datos directamente desde internet (`rodrigotaborda.com`, *Principles of Econometrics*, Stata Press, UCLA), así que solo se necesita conexión. Algunos archivos usan bases locales que no están incluidas en el repositorio.

Algunos temas usan comandos que no vienen con Stata por defecto (por ejemplo, `freduse`). Si un comando no se reconoce, instálelo con `ssc install nombre_del_comando`.

## Créditos

La mayor parte del código es de Rodrigo Taborda. Algunos archivos se basan en material de otros autores, indicado en el encabezado de cada uno:

- `Sampling Distribution Stata Code.do` — John V. Kane (New York University).
- `survival_hunger.do` — Brett Keller.
- `datos_panel_poe.do` y `series_tiempo1.do` — ejemplos basados en *Principles of Econometrics* (Hill, Griffiths y Lim).
- `mv.do` — en coautoría con Laura Pardo.

## Contacto

Rodrigo Taborda — [rodrigotaborda.com](https://rodrigotaborda.com)

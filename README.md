# da_stata

![Stata](https://img.shields.io/badge/Stata-.do-1a5f91?logo=stata)
![Idioma](https://img.shields.io/badge/idioma-espa%C3%B1ol-2ea44f)
![Última actualización](https://img.shields.io/github/last-commit/rotabori/da_stata?label=%C3%BAltima%20actualizaci%C3%B3n)

Código en Stata para los cursos de **análisis de datos, métodos multivariados y econometría** de Rodrigo Taborda (Escuela de Administración, Universidad de los Andes).

Cada archivo `.do` desarrolla un tema completo: carga los datos, aplica los comandos y deja comentados los pasos para que se puedan seguir en clase o de forma autónoma.

## Contenido

Todo el código está en la carpeta [`dofiles/`](dofiles/). Haga clic en cada tema para ver sus archivos.

<details>
<summary><b>Introducción a Stata</b> (2 archivos)</summary>

- [`intro`](dofiles/intro.do): comandos básicos para leer, examinar, organizar y explorar datos.
- [`multivariado_preliminares`](dofiles/multivariado_preliminares.do): funciones, gráficos, distribuciones de probabilidad y distribución muestral.

</details>

<details>
<summary><b>Regresión lineal</b> (7 archivos)</summary>

- [`regresion_lineal_intro`](dofiles/regresion_lineal_intro.do): comandos de regresión lineal con datos simulados.
- [`regresion_lineal_inferencia`](dofiles/regresion_lineal_inferencia.do): inferencia sobre los coeficientes de la regresión.
- [`regresion_lineal_supuestos`](dofiles/regresion_lineal_supuestos.do): pruebas de los supuestos (heterocedasticidad, autocorrelación, especificación).
- [`regresion_lineal_otros1`](dofiles/regresion_lineal_otros1.do): prueba RESET, colinealidad y variables explicativas dummy.
- [`regresion_xaleatoria_endogeneidad`](dofiles/regresion_xaleatoria_endogeneidad.do): regresores aleatorios y endogeneidad.
- [`mv`](dofiles/mv.do): estimación por máxima verosimilitud.
- [`Sampling Distribution Stata Code`](dofiles/Sampling%20Distribution%20Stata%20Code.do): guía para mostrar distribuciones muestrales.

</details>

<details>
<summary><b>Modelos de respuesta limitada</b> (5 archivos)</summary>

- [`probit_logit`](dofiles/probit_logit.do): modelos probit y logit para variables binarias.
- [`probit_logit_ordenado`](dofiles/probit_logit_ordenado.do): probit y logit ordenados.
- [`conteo`](dofiles/conteo.do): regresión para datos de conteo (Poisson).
- [`regresion_survival`](dofiles/regresion_survival.do): análisis de supervivencia.
- [`survival_hunger`](dofiles/survival_hunger.do): análisis de supervivencia con datos de *Los juegos del hambre*.

</details>

<details>
<summary><b>Datos panel y multinivel</b> (3 archivos)</summary>

- [`datos_panel`](dofiles/datos_panel.do): efectos fijos y aleatorios con datos panel.
- [`datos_panel_poe`](dofiles/datos_panel_poe.do): modelos con variables dummy y panel, ejemplos de *Principles of Econometrics*.
- [`multilevel`](dofiles/multilevel.do): regresión multinivel.

</details>

<details>
<summary><b>Métodos multivariados</b> (4 archivos)</summary>

- [`anova_manova`](dofiles/anova_manova.do): análisis de varianza univariado y multivariado.
- [`cluster`](dofiles/cluster.do): análisis de conglomerados jerárquico.
- [`pca_fa`](dofiles/pca_fa.do): componentes principales y análisis factorial.
- [`sem`](dofiles/sem.do): modelos de ecuaciones estructurales.

</details>

<details>
<summary><b>Series de tiempo y finanzas</b> (14 archivos)</summary>

- [`series_tiempo0`](dofiles/series_tiempo0.do): manejo de fechas y series de tiempo.
- [`series_tiempo1`](dofiles/series_tiempo1.do): regresión autorregresiva con datos estacionarios.
- [`series_tiempo_arma`](dofiles/series_tiempo_arma.do): simulación de procesos ARMA e identificación Box-Jenkins.
- [`series_tiempo_arima`](dofiles/series_tiempo_arima.do): simulación de procesos ARIMA.
- [`series_tiempo_filtros`](dofiles/series_tiempo_filtros.do): suavizamiento con promedios móviles y exponenciales.
- [`series_tiempo_cointegracion`](dofiles/series_tiempo_cointegracion.do): cointegración y regresión espuria.
- [`series_tiempo_cointegracion_oil_maize`](dofiles/series_tiempo_cointegracion_oil_maize.do): cointegración entre precios de petróleo y maíz.
- [`series_tiempo_commodities_ipvn`](dofiles/series_tiempo_commodities_ipvn.do): índice de precios de vivienda nueva.
- [`series_tiempo_var_vec`](dofiles/series_tiempo_var_vec.do): modelos VAR y VEC.
- [`series_tiempo_finanzas`](dofiles/series_tiempo_finanzas.do): descarga de datos financieros (FRED, acciones).
- [`series_tiempo_volatilidad0`](dofiles/series_tiempo_volatilidad0.do): volatilidad, prueba ARCH y modelo GARCH.
- [`series_tiempo_volatilidad1`](dofiles/series_tiempo_volatilidad1.do): modelos ARCH y GARCH con acciones.
- [`series_tiempo_volatilidad2`](dofiles/series_tiempo_volatilidad2.do): simulación de procesos estocásticos de volatilidad.
- [`VaR`](dofiles/VaR.do): valor en riesgo.

</details>

## Cómo usarlo

1. Descargue o clone el repositorio.
2. Abra el archivo `.do` del tema que le interesa en Stata.
3. Ejecute el código por bloques, leyendo los comentarios.

La mayoría de los archivos cargan los datos directamente desde internet ([rodrigotaborda.com](https://rodrigotaborda.com)). Algunos archivos usan bases locales que no están incluidas en el repositorio, el profesor le dará indicaciones.

Algunos temas usan comandos que no vienen con Stata por defecto (por ejemplo, `freduse`). Si un comando no se reconoce, instálelo con `ssc install nombre_del_comando`, el profesor le dará indicaciones.

## Créditos

La mayor parte del código es de Rodrigo Taborda. Algunos archivos se basan en material de otros autores, indicado en el encabezado de cada uno:

- `Sampling Distribution Stata Code.do` — John V. Kane (New York University).
- `datos_panel_poe.do` y `series_tiempo1.do` — ejemplos basados en *Principles of Econometrics* (Hill, Griffiths y Lim).

## Contacto

Rodrigo Taborda — [rodrigotaborda.com](https://rodrigotaborda.com)

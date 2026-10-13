** PROJECT: ANALISIS DE DATOS
** PROGRAM: multivariado_preliminares.do
** PROGRAM TASK: FUNCTIONS, GRAPHS, PROBABILITY DISTRIBUTIONS AND SAMPLING DISTRIBUTIONS
** AUTHOR: RODRIGO TABORDA
** DATE CREATED: 2019/05/26
** DATE REVISION 1: 2020/04/07
** DATE REVISION 2: 2026/10/13
** DATE REVISION #:

********************************************************************;
** #0 ** PROGRAM SETUP;
********************************************************************;

** #0.1 ** CLEAR AND DELIMITER;

    /*CLEAR DATA, GRAPHS AND STORED RESULTS*/
    clear all

    /*COMMANDS END ONLY WHEN A SEMICOLON IS FOUND*/
    #delimit ;

********************************************************************;
** #10 ** FUNCTIONS;
********************************************************************;

** #10.1 ** LINEAR FUNCTIONS;

    /*y = x, SQUARE GRAPH WITH AXES AT 0*/
    twoway function y = x, range(-7 7) yline(0) xline(0) xsize(5) ysize(5);

    /*y = 0.5x, SMALLER SLOPE*/
    twoway function y = .5*x, range(-5 5) yline(0) xline(0) xsize(5) ysize(5);

** #10.2 ** LOGARITHMS;

    /*NATURAL LOG*/
    twoway function y = ln(x), range(-1 7) yline(0) xline(0);

    /*BASE 10 LOG*/
    twoway function y = log10(x), range(-1 7) yline(0) xline(0);

    /*BOTH LOGS IN ONE GRAPH*/
    twoway
        (function y = ln(x), range(-1 7))
        (function y = log10(x), range(-1 7))
        ,
        yline(0) xline(0)
        legend(order(1 "Ln" 2 "Log 10") position(6) rows(1))
        ;

********************************************************************;
** #20 ** GRAPHS;
********************************************************************;

** #20.1 ** BAR GRAPH;

    /*TEMPLATE: MEAN OF var1 BY id, SORTED, WITH VALUES ON BARS*/
    graph bar (mean) var1
        ,
        over(id, sort(1) descending label(angle(25)))
        blabel(bar, position(outside) format(%5.1f))
        ytitle(Título)
        subtitle(Sub-título)
        name(nombre, replace)
        ;

    /*EXAMPLE: MEAN wifi SPEED BY CELLPHONE BRAND*/
    graph bar (mean) wifi
        ,
        over(wifi_celular, sort(1) descending label(angle(25)))
        blabel(bar, position(outside) format(%5.1f))
        subtitle(Celular)
        ytitle(Mbps)
        name(celular_mean, replace)
        ;

** #20.2 ** BOX PLOT;

    /*TEMPLATE: BOX PLOT OF var1 BY id*/
    graph box var1, over(id);

    /*EXAMPLE: CAR PRICE BY FUEL TYPE*/
    graph box ad_price_mill, over(car_fuel_num);

** #20.3 ** HISTOGRAM + BOX PLOT;

    /*DESCRIPTIVE STATISTICS*/
    summarize ad_price_mill;

    /*HISTOGRAM IN PERCENT*/
    histogram ad_price_mill, percent width(5) xsize(5) ytitle("") name(hist, replace);

    /*HORIZONTAL BOX PLOT*/
    graph hbox ad_price_mill, ysize(2) xsize(5) name(hbox, replace);

    /*STACK BOTH GRAPHS*/
    graph combine hist hbox, cols(1);

********************************************************************;
** #30 ** BINOMIAL DISTRIBUTION;
********************************************************************;

** #30.1 ** SETUP;

    /*START FROM EMPTY DATA*/
    clear all;

    /*61 OBSERVATIONS: k = 0, 1, ..., 60*/
    set obs 61;

    /*NUMBER OF SUCCESSES*/
    generate k = _n - 1;

** #30.2 ** PROBABILITY P(X = k);

    /*p = 0.25*/
    generate binomial_prob025 = binomialp(_N-1, _n-1, 0.25);

    /*p = 0.50*/
    generate binomial_prob05 = binomialp(_N-1, _n-1, 0.5);

    /*p = 0.75*/
    generate binomial_prob075 = binomialp(_N-1, _n-1, 0.75);

** #30.3 ** CUMULATIVE PROBABILITY P(X < k);

    /*p = 0.25*/
    generate binomial_cum025 = 1 - binomialtail(_N-1, _n-1, 0.25);

    /*p = 0.50*/
    generate binomial_cum05 = 1 - binomialtail(_N-1, _n-1, 0.5);

    /*p = 0.75*/
    generate binomial_cum075 = 1 - binomialtail(_N-1, _n-1, 0.75);

** #30.4 ** GRAPHS;

    /*PROBABILITY FUNCTIONS*/
    twoway connected binomial_prob* k, xline(25 50 75) name(binomial_prob, replace);

    /*CUMULATIVE FUNCTIONS*/
    twoway connected binomial_cum* k, yline(.25 .5 .75) name(binomial_cum, replace);

********************************************************************;
** #40 ** UNIFORM DISTRIBUTION;
********************************************************************;

** #40.1 ** THEORETICAL UNIFORM;

    /*START FROM EMPTY DATA*/
    clear;

    /*100 OBSERVATIONS*/
    set obs 100;

    /*SAME DENSITY FOR EVERY VALUE*/
    generate x_d = 1;

    /*VALUES 1 TO 100*/
    generate x = _n;

    /*DENSITY GRAPH*/
    twoway connected x_d x, sort msize(tiny) name(a, replace);

    /*CUMULATIVE PROBABILITY*/
    generate p_cum = sum(x_d)/_N;

    /*CUMULATIVE GRAPH*/
    twoway connected p_cum x, sort msize(tiny) name(b, replace);

    /*STACK BOTH GRAPHS*/
    graph combine b a, cols(1) ysize(8);

    /*REMOVE GRAPHS FROM MEMORY*/
    graph drop a b;

** #40.2 ** CONTINUOUS U(0,1);

    /*START FROM EMPTY DATA*/
    clear;

    /*1,000 OBSERVATIONS*/
    set obs 1000;

    /*SEED: SAME RANDOM NUMBERS EVERY RUN*/
    set seed 123456;

    /*U(0,1), DEFAULT LIMITS*/
    generate u1 = runiform();

    /*LABEL*/
    label variable u1 "u1 = U(0,1)";

    /*STATISTICS*/
    summarize u1;

    /*HISTOGRAM*/
    histogram u1;

    /*SAME SEED*/
    set seed 123456;

    /*U(0,1), EXPLICIT LIMITS*/
    generate u2 = runiform(0,1);

    /*LABEL*/
    label variable u2 "u2 = U(0,1)";

    /*STATISTICS*/
    summarize u2;

    /*HISTOGRAM*/
    histogram u2;

    /*SAME SEED, SAME NUMBERS: A STRAIGHT LINE*/
    scatter u1 u2;

** #40.3 ** DISCRETE U(0,1);

    /*ROUND TO 0 OR 1*/
    generate u2a = round(u2);

    /*LABEL*/
    label variable u2a "u2a = U(0,1) discreta";

    /*STATISTICS*/
    summarize u2a;

    /*HISTOGRAM, DEFAULT BINS*/
    histogram u2a;

    /*HISTOGRAM, ONE BAR PER VALUE*/
    histogram u2a, discrete;

    /*CREATE A VALUE LABEL*/
    label define genero 0 "Hombre" 1 "Mujer";

    /*ATTACH IT TO u2a*/
    label values u2a genero;

    /*HISTOGRAM OF u1 BY GROUP*/
    histogram u1, by(u2a);

** #40.4 ** CONTINUOUS U(1,5);

    /*SAME SEED*/
    set seed 123456;

    /*U(1,5) WITH runiform(a,b)*/
    generate u3 = runiform(1,5);

    /*LABEL*/
    label variable u3 "u3 = U(1,5)";

    /*STATISTICS*/
    summarize u3;

    /*HISTOGRAM*/
    histogram u3;

    /*SAME SEED*/
    set seed 123456;

    /*U(a,b) BY HAND: (b-a)*runiform() + a = (5-1)*runiform() + 1*/
    generate double u3a = (4)*runiform() + 1;

    /*LABEL*/
    label variable u3a "u3a = U(1,5)";

    /*STATISTICS*/
    summarize u3a;

    /*HISTOGRAM*/
    histogram u3a;

** #40.5 ** DISCRETE U(1,5);

    /*ROUND u3 (1 AND 5 GET HALF THE WEIGHT)*/
    generate u3b = round(u3);

    /*LABEL*/
    label variable u3b "u3b = U(1,5) discreta";

    /*STATISTICS*/
    summarize u3b;

    /*HISTOGRAM, DEFAULT BINS*/
    histogram u3b;

    /*HISTOGRAM, ONE BAR PER VALUE*/
    histogram u3b, discrete;

    /*SAME SEED*/
    set seed 123456;

    /*DISCRETE U(1,5), EQUAL WEIGHT FOR EVERY VALUE*/
    generate u3c = floor((5-1+1)*runiform() + 1);

    /*LABEL*/
    label variable u3c "u3c = U(1,5) discreta";

    /*STATISTICS*/
    summarize u3c;

    /*HISTOGRAM*/
    histogram u3c, discrete;

********************************************************************;
** #50 ** NORMAL DISTRIBUTION;
********************************************************************;

** #50.1 ** STANDARD NORMAL N(0,1);

    /*SAME SEED*/
    set seed 123456;

    /*N(0,1), DEFAULT PARAMETERS*/
    generate n1 = rnormal();

    /*LABEL*/
    label variable n1 "n1 = N(0,1)";

    /*STATISTICS*/
    summarize n1;

    /*HISTOGRAM*/
    histogram n1;

    /*SAME SEED*/
    set seed 123456;

    /*N(0,1), EXPLICIT PARAMETERS*/
    generate n2 = rnormal(0,1);

    /*LABEL*/
    label variable n2 "n2 = N(0,1), igual a n1";

    /*STATISTICS*/
    summarize n2;

    /*HISTOGRAM*/
    histogram n2;

    /*SAME SEED, SAME NUMBERS: A STRAIGHT LINE*/
    scatter n1 n2;

** #50.2 ** DIFFERENT SEED;

    /*NEW SEED*/
    set seed 654321;

    /*N(0,1), DIFFERENT NUMBERS*/
    generate n3 = rnormal(0,1);

    /*LABEL*/
    label variable n3 "n3 = N(0,1)";

    /*STATISTICS*/
    summarize n3;

    /*HISTOGRAM*/
    histogram n3;

    /*DIFFERENT SEED: NO RELATION*/
    scatter n1 n3;

** #50.3 ** SUM OF NORMALS;

    /*n4 = n2 + n3*/
    generate n4 = n2 + n3;

    /*LABEL*/
    label variable n4 "n4 = n2 + n3";

    /*STATISTICS*/
    summarize n4;

    /*HISTOGRAM*/
    histogram n4;

    /*n4 SHARES n2 = n1: POSITIVE RELATION*/
    scatter n1 n4;

    /*SAME SCATTER BY GROUP*/
    scatter n1 n4, by(u2a);

    /*ALL NORMALS, PAIRWISE*/
    graph matrix n*, half;

** #50.4 ** FINAL DESCRIPTION;

    /*LABEL THE DATASET*/
    label data "Datos simulados distribución uniforme y normal";

    /*STATISTICS FOR ALL VARIABLES*/
    summarize;

    /*VARIABLES, TYPES AND LABELS*/
    describe;

********************************************************************;
** #60 ** T, CHI2 AND F DISTRIBUTIONS;
********************************************************************;

** #60.1 ** T DISTRIBUTION;

    /*t DENSITY WITH 1, 2 AND 3 DEGREES OF FREEDOM*/
    twoway
        (function t_pdf = tden(1,x), range(-4 4))
        (function t_pdf = tden(2,x), range(-4 4))
        (function t_pdf = tden(3,x), range(-4 4))
        ;

** #60.2 ** CHI2 DISTRIBUTION;

    /*CHI2 DENSITY WITH 1, 2 AND 3 DEGREES OF FREEDOM*/
    twoway
        (function chi2_pdf = chi2den(1,x), range(0 50))
        (function chi2_pdf = chi2den(2,x), range(0 50))
        (function chi2_pdf = chi2den(3,x), range(0 50))
        ;

** #60.3 ** F DISTRIBUTION;

    /*F DENSITY WITH (1,1), (2,5), (5,10) AND (10,20) DEGREES OF FREEDOM*/
    twoway
        (function f_pdf = Fden(1,1,x), range(0 15))
        (function f_pdf = Fden(2,5,x), range(0 15))
        (function f_pdf = Fden(5,10,x), range(0 15))
        (function f_pdf = Fden(10,20,x), range(0 15))
        ;

********************************************************************;
** #70 ** SAMPLING DISTRIBUTION;
********************************************************************;

** #70.1 ** NORMAL POPULATION, SAMPLING WITHOUT REPLACEMENT;

    /*START FROM EMPTY DATA*/
    clear;

    /*POPULATION OF 1,000,000*/
    set obs 1000000;

    /*SEED*/
    set seed 71772;

    /*POPULATION: N(500,150)*/
    generate x_1 = rnormal(500,150);

    /*POPULATION MEAN AND SD*/
    tabstat x_1, statistics(mean sd);

    /*POPULATION HISTOGRAM*/
    histogram x_1, title(Población) name(pop_hist, replace);

    /*RANDOM ORDER*/
    tempvar sortorder;
    generate `sortorder' = runiform();
    sort `sortorder';

    /*ASSIGN 5,000 SAMPLES OF 200 OBSERVATIONS EACH*/
    egen sample_id = seq(), from(1) to(5000) block(1);

    /*MEAN OF EACH SAMPLE*/
    egen sample_mean = mean(x_1), by(sample_id);

    /*ONE ROW PER SAMPLE*/
    collapse (mean) sample_mean, by(sample_id);

    /*HISTOGRAM OF SAMPLE MEANS*/
    histogram sample_mean, title(Muestra) name(muestra_hist, replace);

    /*MEAN AND SD OF SAMPLE MEANS*/
    tabstat sample_mean, statistics(mean sd);

** #70.2 ** UNIFORM POPULATION, SAMPLING WITHOUT REPLACEMENT;

    /*START FROM EMPTY DATA*/
    clear;

    /*POPULATION OF 1,000,000*/
    set obs 1000000;

    /*SEED*/
    set seed 71772;

    /*POPULATION: U(0,1)*/
    generate x_1 = runiform();

    /*POPULATION MEAN AND SD*/
    tabstat x_1, statistics(mean sd);

    /*POPULATION HISTOGRAM*/
    histogram x_1, title(Población) name(pop_hist, replace);

    /*RANDOM ORDER*/
    tempvar sortorder;
    generate `sortorder' = runiform();
    sort `sortorder';

    /*ASSIGN 5,000 SAMPLES OF 200 OBSERVATIONS EACH*/
    egen sample_id = seq(), from(1) to(5000) block(1);

    /*MEAN OF EACH SAMPLE*/
    egen sample_mean = mean(x_1), by(sample_id);

    /*ONE ROW PER SAMPLE*/
    collapse (mean) sample_mean, by(sample_id);

    /*HISTOGRAM OF SAMPLE MEANS*/
    histogram sample_mean, title(Muestra) name(muestra_hist, replace);

    /*MEAN AND SD OF SAMPLE MEANS*/
    tabstat sample_mean, statistics(mean sd);

** #70.3 ** REAL DATA, SAMPLING WITHOUT REPLACEMENT;

    /*OPEN STUDENT SURVEY*/
    use http://rodrigotaborda.com/ad/data/ee/encuesta_estudiantes_202yxx_old.dta, clear;

    /*KEEP HEIGHT AND GENDER*/
    keep estatura genero_num;

    /*HEIGHT BY GENDER*/
    tabstat estatura, statistics(mean sd n) by(genero_num);

    /*HEIGHT HISTOGRAM*/
    histogram estatura, title(Estatura) name(pop_hist, replace);

    /*OVERLAPPING HISTOGRAMS BY GENDER*/
    twoway
        (histogram estatura if genero_num == 0, color(blue%50) percent)
        (histogram estatura if genero_num == 1, color(red%50) percent)
        ,
        legend(order(1 "Hombre" 2 "Mujer"))
        ;

    /*DENSITIES BY GENDER*/
    twoway
        (kdensity estatura if genero_num == 0)
        (kdensity estatura if genero_num == 1)
        ,
        name(pop_kd, replace)
        ;

    /*RANDOM ORDER WITHIN GENDER*/
    tempvar sortorder;
    generate `sortorder' = runiform();
    sort genero_num `sortorder';

    /*ASSIGN 125 SAMPLES*/
    egen sample_id = seq(), from(1) to(125) block(1);

    /*MEAN HEIGHT OF EACH SAMPLE, BY GENDER*/
    egen estatura_sample_mu = mean(estatura), by(sample_id genero_num);

    /*ONE ROW PER SAMPLE AND GENDER*/
    collapse (mean) estatura_sample_mu, by(sample_id genero_num);

    /*SAMPLE MEANS BY GENDER*/
    tabstat estatura_sample_mu, statistics(mean sd n) by(genero_num);

    /*HISTOGRAM OF SAMPLE MEANS*/
    histogram estatura_sample_mu, title(Muestra) name(muestra_hist, replace);

    /*DENSITIES OF SAMPLE MEANS BY GENDER*/
    twoway
        (kdensity estatura_sample_mu if genero_num == 0)
        (kdensity estatura_sample_mu if genero_num == 1)
        ,
        name(muestra_kd, replace)
        ;

********************************************************************;
** #99 ** GOOD BYE;
********************************************************************;

    /*CLEAR DATA FROM MEMORY*/
*    clear;

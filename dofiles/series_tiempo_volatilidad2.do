** PROJECT: ANALISIS DE DATOS
** PROGRAM: series_tiempo_volatilidad2.do
** PROGRAM TASK: SERIES DE TIEMPO VOLATILIDAD PROCESO ESTOCASTICO
** AUTHOR: RODRIGO TABORDA
** DATE CREATED: 2022/10/06
** DATE REVISION 1: xxxx/xx/xx

** #0 ** PROGRAM SETUP

    pause on
    #delimit ;

** #0.1 ** SET PATH FOR READING/SAVING DATA;

*    cd ../../;

*********************************************************************;
*** #00 ** PRELIMINAR;
*********************************************************************;

    graph drop _all;
    clear;

    /*DEFINIR NUMERO DE OBSERVACIONES*/;
    set obs 1800;

    /*DEFINIR VARIABLE DE TIEMPO*/;
    generate time=_n;
    tsset time;

    /*DEFINIR VALOR ALEATOREO INICIAL*/;
*    set seed 7890;

    /*GENERAR PROCESO ALEATORIO*/;
    gen e1 = rnormal(0,1);
        label var e1 "e (0,1)";

    sum time;
    local sample = _N;

*********************************************************************;
*** #10 ** WIENER PROCESS;
*********************************************************************;

    gen w = e1 / `sample';
        label var w "Wiener process";

    gen w1 = .;
    replace w1 = e1 in 1;
    replace w1 = l.w1 + e1 in 2/l;
        label var w1 "Wiener process (sum)";
*    gen w11 = sum(e1);

*********************************************************************;
*** #10 ** ITO PROCESS;
*********************************************************************;

    local mu = 0.01;
        display `mu';
    local mu_d = `mu' / `sample';
        display `mu_d';

    local sigma = .9;
        display `sigma';
    local sigma_d = `sigma' / sqrt(`sample');
        display `sigma_d';

*    gen ito_d_ln_p = (`mu_d' - (.5 * (`sigma_d')^2));
    gen ito_d_ln_p = (`mu_d' - (.5 * (`sigma_d')^2)) + (w * `sigma_d');

    gen ito_p = 100 in 1;
    replace ito_p = l.ito_p * exp(ito_d_ln_p) in 2/l;

    tsline w1, name(w1);
    tsline ito_p, name(ito_p);

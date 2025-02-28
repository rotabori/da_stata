** PROJECT: MERCADEO PREDICTIVO
** PROGRAM: mercadeo_simulacion.do
** PROGRAM TASK:
** AUTHOR: RODRIGO TABORDA
** DATE CREATEC: 2023/07/24
** DATE REVISION 1:
** DATE REVISION #:

********************************************************************;
** #0
********************************************************************;

** PROGRAM SETUP

    pause on
    #delimit ;

    set scheme s2color8;

********************************************************************;
** #20 ** SIMULAR DATOS;
********************************************************************;

** #20.1 ** XXX ;

    /*CLEAR*/;
    clear;

    /*SEED*/;
    set seed 123456;

    /*OBS*/;
    set obs 400;

    /*ID*/;
    gen id = _n;
        label variable id "ID";

    /*CIUDAD*/;
    gen urbana = round(rbeta(1,1.5));
        label variable urbana "Urbana";
        label define urbana 0 "Rural" 1 "Urbana";
            label values urbana urbana;

    /*BONO*/;
	gen bono = round(rbeta(1,3)); /*mas 0 si alpha < beta*/
        label variable bono "Bono";
        label define bono 0 "no" 1 "Si";
            label values bono bono;

    /*LOCAL VARIABILIDAD*/;
	local p_m = 11000;
	local p_sd = 1000;

	local q_m = 1100;
	local q_sd = 200;

	local ing_m = 1.8;
	local ing_sd = 0.3;

*************************************************;
*************************************************;
    /*CASO 01*/;
    /*PRECIO Y CANTIDAD LINEAL*/;
    /*PRECIO Y CANTIDAD INVERSA*/;
    /*FUNCION DE DEMANDA*/;
    /*FUNCION DE DEMANDA CONVEXA*/;
    gen p_01 = abs(round(rnormal(`p_m',`p_sd'),0.01));
        label var p_01 "Precio 01";
        egen p_01z = std(p_01), mean(3) sd(.4);

    gen q_01a = abs(round(rnormal(`q_m',`q_sd'),0.01));
        label var q_01a "Cantidad 01a";
        replace q_01a = q_01a * (-.1 * p_01z) + 1100;

    gen q_01b = abs(round(rnormal(`q_m',`q_sd'),0.01));
        label var q_01b "Cantidad 01b";
        replace q_01b = abs(q_01b / (p_01z^3));

	scatter q_01a p_01 ,
        ytitle("Kg / año")
        xtitle(Precio)
        scheme(stcolor)
        name(q01a_dda_0, replace)
        ;
	scatter q_01b p_01,
        ytitle("Kg / año")
        xtitle(Precio)
        scheme(stcolor)
        name(q01b_dda_0, replace)
        ;
    histogram q_01a,
        percent
        width(20)
        title(Cantidad demandada)
        subtitle("Distribución")
        xtitle("Kg / año")
        ytitle(Porcentaje)
        scheme(stcolor)
        name(q01a_hist, replace)
        ;
    twoway
    	(scatter q_01a p_01,
            msize(small)
            ytitle("Kg / año")
            xtitle(Precio))
	   (lfit q_01a p_01, lwidth(thick))
        ,
        scheme(stcolor)
        legend(off)
        name(q01a_dda_1, replace)
        ;
*************************************************;
*************************************************;
aaa
*************************************************;
*************************************************;
    /*CASO 02*/;
    /*PRECIO Y CANTIDAD LINEAL*/;
    /*URBANO VS. RURAL*/;
    /*FUNCION DE DEMANDA*/;
    /*EFECTO CONSTANTE*/;
    gen p_02 = abs(round(rnormal(`p_m',`p_sd'),0.01));
        label var p_02 "Precio 02";
        egen p_02z = std(p_02), mean(3) sd(.4);

    gen q_02a = abs(round(rnormal(`q_m',`q_sd'),0.01));
        label var q_02a "Cantidad 02a";
        replace q_02a = q_02a * (-.1 * p_02z) + 1100 - 50 if urbana == 0;
        replace q_02a = q_02a * (-.1 * p_02z) + 1100 + 50 if urbana == 1;

    twoway (scatter q_02a p_02)
        ,
        scheme(stcolor)
        name(q02a_dda_0, replace)
        ;
    twoway (scatter q_02a p_02 if urbana == 0)(scatter q_02a p_02 if urbana == 1)
        ,
        scheme(stcolor)
        name(q02a_dda_1, replace)
        ;

    graph box q_02a
        ,
        over(urbana)
        title(Cantidad demandada)
        subtitle(Urbano / Rural)
        ytitle("Kg / año")
        scheme(stcolor)
        name(q02a_box, replace)
        ;

    reg q_02a p_02 i.urbana;
    sum q_02a p_02 urbana;
    margins i.urbana, at(p_02=(6000(1000)14000));

    marginsplot, noci addplot((scatter q_02a p_02 if urbana == 0)(scatter q_02a p_02 if urbana == 1))
        legend(off)
        name(q02a_dda_2, replace)
        ;
*************************************************;
*************************************************;

*************************************************;
*************************************************;
    /*CASO 03*/;
    /*FUNCION DE DEMANDA*/;
    /*EFECTO PENDIENTE*/;
    gen p_03 = abs(round(rnormal(`p_m',`p_sd'),0.01));
        label var p_03 "Precio 03";
        egen p_03z = std(p_03), mean(3) sd(.4);

    gen q_03a = abs(round(rnormal(`q_m',`q_sd'),0.01));
        label var q_03a "Cantidad 03a";
        replace q_03a = q_03a * (-.4 * p_03z) + 2100 if urbana == 0;
        replace q_03a = q_03a * (-.2 * p_03z) + 1100 if urbana == 1;

    twoway (scatter p_03 q_03a), name(demand_03z, replace);
    twoway (scatter p_03 q_03a if urbana == 0)(scatter p_03 q_03a if urbana == 1), name(demand_03a, replace);
    twoway (scatter p_03 q_03a if urbana == 0, msize(small))(scatter p_03 q_03a if urbana == 1, msize(small))
        (lfit p_03 q_03a if urbana == 0, lwidth(thick))
        (lfit p_03 q_03a if urbana == 1, lwidth(thick))
        ,
        name(demand_03a_lfit, replace)
        ;

    /*CASO 04*/;
    /*FUNCION DE DEMANDA*/;
    /*EFECTO PENDIENTE & CONSTANTE*/;
    gen p_04 = abs(round(rnormal(`p_m',`p_sd'),0.01));
        label var p_04 "Precio 04";
        egen p_04z = std(p_04), mean(3) sd(.4);

	gen q_04a = abs(round(rnormal(`q_m',`q_sd'),0.01));
        label var q_04a "Cantidad 04a";
        replace q_04a = q_04a * (-.4 * p_04z) + 2100 if urbana == 0;
        replace q_04a = q_04a * (-.1 * p_04z) + 1100 if urbana == 1;

    twoway (scatter p_04 q_04a), name(demand_04z, replace);
    twoway (scatter p_04 q_04a if urbana == 0)(scatter p_04 q_04a if urbana == 1), name(demand_04a, replace);
    twoway (scatter p_04 q_04a if urbana == 0, msize(small))(scatter p_04 q_04a if urbana == 1, msize(small))
        (lfit p_04 q_04a if urbana == 0, lwidth(thick))
        (lfit p_04 q_04a if urbana == 1, lwidth(thick))
        ,
        name(demand_04a_lfit, replace)
        ;

    /*CASO 05*/;
    /*FUNCION DE DEMANDA*/;
    /*EFECTO INGRESO*/;
    gen p_05 = abs(round(rnormal(`p_m',`p_sd'),0.01));
        label var p_05 "Precio 05";
        egen p_05z = std(p_05), mean(3) sd(.4);

    gen ing_05 = round(rnormal(`ing_m',`ing_sd'),0.01);
        label var ing_05 "Ingreso (Millones)";
		
    gen q_05a = abs(round(rnormal(`q_m',`q_sd'),0.01));
        label var q_05a "Cantidad 05a";
        replace q_05a = (q_05a * (-.1 * p_05z) + 1100);
        replace q_05a = (q_05a * (-.1 * p_05z) + 1100) + (q_05a * 0.1 * ing_05);

	graph matrix p_05 q_05a ing_05, half name(demand_05a, replace);

    /*CASO 06*/;
    /*FUNCION DE DEMANDA*/;
    /*EFECTO INGRESO*/;
    /*EFECTO CONSTANTE*/;
    gen p_06 = abs(round(rnormal(`p_m',`p_sd'),0.01));
        label var p_06 "Precio 06";
        egen p_06z = std(p_06), mean(3) sd(.4);
		
    gen ing_06 = round(rnormal(`ing_m',`ing_sd'),0.01);
        label var ing_06 "Ingreso (Millones)";

		gen q_06a = abs(round(rnormal(`q_m',`q_sd'),0.01));
        label var q_06a "Cantidad 06a";
        replace q_06a = (q_06a * (-.1 * p_06z) + 1100);
        replace q_06a = (q_06a * (-.1 * p_06z) + 1100) + (q_06a * 0.1 * ing_06);
        replace q_06a = (q_06a * (-.1 * p_06z) + 1100) + (q_06a * 0.1 * ing_06) - 30 if urbana == 0;
        replace q_06a = (q_06a * (-.1 * p_06z) + 1100) + (q_06a * 0.1 * ing_06) + 30 if urbana == 1;
		
    twoway (scatter p_06 q_06a if urbana == 0)(scatter p_06 q_06a if urbana == 1), name(demand_06a, replace);

    /*CASO 07*/;
    /*VDB/PROBIT/LOGIT*/;
    /*EFECTO INGRESO*/;
    /*EFECTO BONO*/;
    gen compra_07 = round(rbeta(1,1.5));
        label variable compra_07 "Compra";
        label define compra_07 0 "No compra" 1 "Si compra";
            label values compra_07 compra_07;

	gen compra_07_rnd = rnormal(0,0.5);
	gen bono_07 = round(compra_07 + compra_07_rnd);
		replace bono_07 = 0 if bono_07 < 0;
		replace bono_07 = 1 if bono_07 > 1;

        label variable bono_07 "Bono";
        label define bono_07 0 "no" 1 "Si";
            label values bono_07 bono_07;

	gen ing_07 = round(rnormal(`ing_m',`ing_sd'),0.01);
		replace ing_07 = ing_07 * (1 + .2) if compra_07 == 1;
		replace ing_07 = ing_07 * (1 - .2) if compra_07 == 0;
        label var ing_07 "Ingreso (Millones)";

		tab compra_07 bono_07;
		
        reg compra_07 ing_07;
            margins, at(ing_07=(.8(.1)3));
            marginsplot, noci addplot(scatter compra_07 ing_07);

		logit compra_07 ing_07;
			margins, at(ing_07=(.8(.1)3));
			marginsplot, noci addplot(scatter compra_07 ing_07);

		logit compra_07 ing_07 i.bono_07;
			margins bono_07, at(ing_07=(.8(.1)3));
			marginsplot, noci addplot(scatter compra_07 ing_07);

    /*CASO 08*/;
    /*VDORDENADA/PROBIT/LOGIT*/;
    gen likert_08 = round(runiform(1,5));
        label variable likert_08 "Likert";

        label define likert_08
                                1 "Tot. desacuerdo"
                                2 "Desacuerdo"
                                3 "Neutral"
                                4 "Acuerdo"
								5 "Tot. acuerdo"
                                ;
            label values likert_08 likert_08;

	gen ing_08 = round(rnormal(`ing_m',`ing_sd'),0.01);
		label variable ing_08 "Ingreso";
		replace ing_08 = ing_08 * (1 + 0.5) if likert_08 == 5;
		replace ing_08 = ing_08 * (1 + 0.25) if likert_08 == 4;
		replace ing_08 = ing_08 * (1 + 0.0) if likert_08 == 3;
		replace ing_08 = ing_08 * (1 - 0.25) if likert_08 == 2;
		replace ing_08 = ing_08 * (1 - 0.5) if likert_08 == 1;

	gen likert_08_rnd = rnormal(0,0.5);
	gen genero_08 = round(likert_08 + likert_08_rnd);
		label variable genero_08 "Género";
		recode genero_08 (4/6 = 0) (0/3 = 1);

	gen frecuente_08 = round(runiform(0,1));
		label var frecuente_08 "Cliente frecuente";
	
	scatter likert_08 ing_08, name(likert_08, replace);

    reg likert_08 ing_08 genero_08 frecuente_08;
	oprobit likert_08 ing_08 genero_08 frecuente_08;

    /*CASO 09*/;
    /*CONTEO*/;
	gen tta_cred_09 = round(round(rbeta(1,2.5),0.1) * 5);
		label var tta_cred_09 "Tta_cred";
	
	gen ing_09 = round(rnormal(`ing_m',`ing_sd'),0.01);
		label variable ing_09 "Ingreso";
	
*		replace ing_09 = ing_09 * (1 + 1.0) if tta_cred_09 == 8;
*		replace ing_09 = ing_09 * (1 + 0.9) if tta_cred_09 == 7;
*		replace ing_09 = ing_09 * (1 + 0.8) if tta_cred_09 == 6;
		replace ing_09 = ing_09 * (1 + 0.6) if tta_cred_09 == 5;
		replace ing_09 = ing_09 * (1 + 0.4) if tta_cred_09 == 4;
		replace ing_09 = ing_09 * (1 + 0.2) if tta_cred_09 == 3;
		replace ing_09 = ing_09 * (1 - 0.0) if tta_cred_09 == 2;
		replace ing_09 = ing_09 * (1 - 0.2) if tta_cred_09 == 1;
		replace ing_09 = ing_09 * (1 - 0.4) if tta_cred_09 == 0;
		
	gen tta_cred_09_rnd = rnormal(0,0.5);
	gen genero_09 = round(tta_cred_09 + tta_cred_09_rnd);
		label variable genero_09 "Género";
		recode genero_09 (-1/2 = 0) (3/8 = 1);

	scatter tta_cred_09 ing_09, name(tta_cred_09, replace);
    hist tta_cred_09, discrete name(tta_cred_09_hist, replace);
	
	reg tta_cred_09 ing_09 genero_09;
	poisson tta_cred_09 ing_09 genero_09;

********************************************************************;
** #90 ** SAVE;
********************************************************************;

*    local today : display %tdCYND date("$S_DATE", "DMY");
*    local today 20230726;
    local today 20240418;

    drop *_rnd *z;

        /*SAVE*/;
        save                ../../data/mercadeo/mercadeo_`today', replace;
        codebookout         ../../data/mercadeo/mercadeo_`today'.xls, replace;
        export excel using  ../../data/mercadeo/mercadeo_`today'.xlsx, firstrow(variables) nolabel replace;

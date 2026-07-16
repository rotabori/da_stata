** PROJECT: ANALISIS DE DATOS
** PROGRAM: series_tiempo_arma.do
** PROGRAM TASK: MANEJO DE FECHA
** AUTHOR: RODRIGO TABORDA
** DATE CREATED: 2020/04/07
** DATE REVISION 1:
** DATE REVISION #:

** #0.1 ** SET PATH FOR READING/SAVING DATA;

    cd ../../;

*********************************************************************;
*** #10 ** TRATAMIENTO DE FECHA;
*********************************************************************;

    display mdy(1,1,1960); /*Enero 1 de 1960*/;
    display mdy(12,31,1959); /*Enero 1 de 1960*/;
    display hms(0,0,1); /*1 segundo = 1 milisegundo*/;
    display mdyhms(1,1,1960,0,0,1); /*Segundo 1 de Enero 1 de 1960*/;
    display mdyhms(1,1,1960,12,0,0); /*Hora 12 de Enero 1 de 1960*/;
    display dow(mdy(11,1,2000)); /*0 = Sun, 1 = Mon, 2 = Tues, 3 = Wed, 4 = Thurs, 5 = Fri, 6 = Saturday*/;
    display doy(mdy(11,1,2000)); /*dia del año*/;

*********************************************************************;
*** #20 ** DEFINIR VARIABLE DE TIEMPO;
*********************************************************************;

    /*DEFINIR VARIABLE DE TIEMPO*/;
        set obs 366;
        generate time = _n - 1;
        format %td time:
        tsset time;

        generate time_ss = ss(time);
            /*generate time_ss = ss(dofm(time))*/;
        generate time_mm = mm(time);
            /*generate time_mm = mm(dofm(time))*/;
        generate time_hh = hh(time);
            /*generate time_hh = hh(dofm(time))*/;
        generate time_day = day(time);
            /*generate time_day = day(dofm(time))*/;
        generate time_week = week(time);
            /*generate time_week = week(dofm(time))*/;
        generate time_month = month(time);
            /*generate time_month = month(dofm(time))*/;
        generate time_quarter = quarter(time);
            /*generate time_quarter = quarter(dofm(time))*/;
        generate time_semester = halfyear(time);
            /*generate time_semester = halfyear(dofm(time))*/;
        generate time_year = year(time);
            /*generate time_year = year(dofm(time))*/;

    /*DEFINIR VARIABLE DE TIEMPO DE VARIABLES SEPARADAS*/;
    gen date_semester = yh(time_year,time_semester);
        format date_semester %th;

    gen date_quarter = yq(time_year,time_quarter);
        format date_quarter %tq;

    gen date_month = ym(time_year,time_month);
        format date_month %tm;

    gen date_week = yw(time_year,time_week);
        format date_week %tw;

    gen date_mdy = mdy(time_month,time_day,time_year);
        format date_mdy %td;

    gen date_mdyhms = mdyhms(time_month,time_day,time_year,time_hh,time_mm,time_ss);
        format date_mdyhms %tc;

    /*LAG, FORWARD, DIFFERENCE*/;

        gen y = rnormal(0,1)*100;

        generate y_l1 = l.y;
        generate y_l2 = l2.y;
        generate y_f1 = f.y;
        generate y_f2 = f2.y;
        generate y_d1 = d.y;
        generate y_g12 = (y - l7.y) / l7.y;

    /*GRAPH TIME WITHIN*/;
        tsline y;
        tsline y if tin(1jan1960,25jan1960);

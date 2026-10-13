** PROJECT: ANALISIS DE DATOS
** PROGRAM: intro.do
** PROGRAM TASK: PRELIMINARY BASIC STATA COMMANDS
** AUTHOR: RODRIGO TABORDA
** DATE CREATED: 2017/08/17
** DATE REVISION 1: 2020/04/07
** DATE REVISION 2: 2026/10/13
** DATE REVISION #:

********************************************************************;
** #0 ** PROGRAM SETUP;
********************************************************************;

** #0.1 ** DELIMITER;

    pause on
    /*COMMANDS END ONLY WHEN A SEMICOLON IS FOUND*/
    #delimit ;

** #0.2 ** SET PATH FOR READING/SAVING DATA;

    /*SET WORKING FOLDER*/
    cd <SOMEWHERE IN YOUR COMPUTER>;

    /*GO UP TWO FOLDERS*/
    cd ../../;

********************************************************************;
** #10 ** DATA-IN ROUTINE;
********************************************************************;

** #10.1 ** DATA STORED WITHIN STATA;

    /*OPEN EXAMPLE DATA SHIPPED WITH STATA*/
    sysuse auto.dta, clear;

** #10.2 ** STATA FILE (.dta);

    /*OPEN A .dta FILE*/
    use filename.dta, clear;

** #10.3 ** TEXT FILE (.txt / .csv);

    /*OPEN A TEXT FILE*/
    /*delimiter(comma): COLUMNS SEPARATED BY COMMA*/
    /*encoding(utf8): KEEPS SPANISH CHARACTERS*/
    import delimited data/covid19_world_`date'.txt
        ,
        delimiter(comma)
        encoding(utf8)
        clear
        ;

********************************************************************;
** #20 ** EXAMINE YOUR DATA;
********************************************************************;

** #20.1 ** SPREADSHEET VIEW;

    /*VIEW DATA AS A SPREADSHEET*/
    browse;

    /*EDIT DATA AS A SPREADSHEET (AVOID IT)*/
    edit;

** #20.2 ** STRUCTURE AND CONTENT;

    /*VARIABLES, TYPES AND LABELS*/
    describe;

    /*LIST ALL VALUES OF var1*/
    list var1;

    /*LIST OBSERVATIONS 1 TO 10*/
    list var1 in 1/10;

********************************************************************;
** #30 ** TIDY UP YOUR DATA;
********************************************************************;

** #30.1 ** NAMES AND LABELS;

    /*RENAME var1 AS new_var1*/
    rename var1 new_var1;

    /*ATTACH A LABEL*/
    label variable new_var1 "variable label";

** #30.2 ** DROP / KEEP;

    /*DELETE var1, KEEP THE REST*/
    drop var1;

    /*KEEP var1, DELETE THE REST*/
    keep var1;

** #30.3 ** NEW VARIABLES;

    /*TIP: USE PREFIXES / SUFFIXES SO VARIABLES SORT AND GROUP EASILY*/

    /*SUM OF var1 AND var2*/
    generate var10 = var1 + var2;

    /*var1 SQUARED*/
    generate var1_sq = var1^2;

    /*var1 NATURAL LOG*/
    generate var1_ln = ln(var1);

********************************************************************;
** #40 ** EXPLORE YOUR DATA;
********************************************************************;

** #40.1 ** DESCRIPTIVE STATISTICS;

    /*BASIC STATISTICS*/
    summarize var1 var2;

    /*DETAILED STATISTICS*/
    summarize var1 var2, detail;

    /*ONLY IF CONDITION HOLDS*/
    summarize var1 var2 if var_cat == 1, detail;

** #40.2 ** FREQUENCY TABLES;

    /*FREQUENCY TABLE*/
    tabulate var_cat;

** #40.3 ** HISTOGRAM;

    /*HISTOGRAM*/
    histogram var1;

    /*HISTOGRAM + TITLE*/
    histogram var1, title(Add a title);

** #40.4 ** SCATTER PLOT;

    /*Y = var1, X = var2*/
    twoway scatter var1 var2;

    /*Y AXIS 0 TO 100, EVERY 10*/
    twoway scatter var1 var2, ylabel(0(10)100);

    /*BOTH AXES 0 TO 100*/
    twoway scatter var1 var2, ylabel(0(10)100) xlabel(0(10)100);

    /*AXES + TITLE; ONE COMMAND ON SEVERAL LINES*/
    twoway scatter var1 var2,
        ylabel(0(10)100) xlabel(0(10)100)
        title(Add a title)
        ;

    /*ONE SCATTER FOR EACH CATEGORY OF var_cat*/
    twoway scatter var1 var2,
        ylabel(0(10)100) xlabel(0(10)100)
        title(Add a title)
        by(var_cat)
        ;

********************************************************************;
** #50 ** STATA AS A CALCULATOR;
********************************************************************;

** #50.1 ** DISPLAY;

    /*SHOW A RESULT*/
    display 1 + 1;

    /*SHOW TEXT + RESULT*/
    display "La suma de 1 + 1 es: " 1 + 1;

** #50.2 ** SCALARS;

    /*STORE 1 IN a*/
    scalar a = 1;

    /*STORE 1 IN b*/
    scalar b = 1;

    /*USE STORED VALUES*/
    display "La suma de a + b es: " a + b;

********************************************************************;
** #60 ** MISSING VALUES;
********************************************************************;

** #60.1 ** CODING MISSING VALUES;

    /*STATA CODES MISSING VALUES WITH A DOT (.); ALSO .a .b ...*/

    /*MISSING (.) TO 99*/
    mvencode _all, mv(99);

    /*99 BACK TO MISSING (.)*/
    mvdecode _all, mv(99 = .);

********************************************************************;
** #70 ** RECODE AND VALUE LABELS;
********************************************************************;

** #70.1 ** RECODE;

    /*SWAP 0 AND 1*/
    recode var1 (0 = 1) (1 = 0);

** #70.2 ** VALUE LABELS;

    /*CREATE A VALUE LABEL*/
    label define var1_lab 0 "no" 1 "si";

    /*ATTACH IT TO var1*/
    label values var1 var1_lab;

********************************************************************;
** #99 ** GOOD BYE;
********************************************************************;

    /*CLEAR DATA FROM MEMORY*/
*    clear;

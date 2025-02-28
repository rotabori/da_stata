** PROJECT: MONTE CARLO, BOOTSTRAP, JACKNIFE
** PROGRAM: simulation.do
** PROGRAM TASK: SIMULACION
** AUTHOR: RODRIGO TABORDA
** DATE CREATED: 2024/10/06
** DATE REVISION 1:
** DATE REVISION #:

*********************************************************************;
*** #10 ** MONTE CARLO;
*********************************************************************;

    capture program drop simpctile
    program simpctile, rclass
    	version 10.1
    	drop _all
    	set obs 200
    	generate z = rnormal()
    	summarize z, detail
    	return scalar p25 = r(p25)
    	return scalar p50 = r(p50)
    	return scalar p75 = r(p75)
    end
    
    clear
    
    set seed 123
    simulate p25=r(p25) p50=r(p50) p75=r(p75), reps(1000) saving(pctiles,replace): simpctile
    
    use pctiles,clear
    
    summarize
    
    histogram p25, normal name(p25)
    histogram p50, normal name(p50)
    histogram p75, normal name(p75)

    erase pctiles.dta

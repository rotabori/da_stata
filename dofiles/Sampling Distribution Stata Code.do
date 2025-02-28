/* 
A GUIDE FOR DEMONSTRATING SAMPLING DISTRIBUTIONS IN STATA

John V. Kane
New York University
*/

*Necessary Packages:  
ssc install schemepack, replace // great schemes by Asjad Naqvi
ssc install coefplot, replace
net install dm44, from("http://www.stata.com/stb/stb37") replace // sequence package

* See here for more info: www.stata.com/support/faqs/data-management/repeating-sequences-of-numbers/

*For details on installing the "Abel" font featured in the graphs, see:
https://twitter.com/UptonOrwell/status/1605056863858565120

*********************************************************
*EXAMPLE 1: SAMPLING DISTRIBUTION WITH SIMULATED DATA
*********************************************************

*STEP 1:  CLEAR OUT DATA AND DECLARE NUMBER OF OBSERVATIONS

clear // clear existing data

set obs 1000000 // set data set to n=1,000,000


*STEP 2:  GENERATE CLEVERLY-NAMED VARIABLE ("Xvar") 

set seed 1234 // set seed for replication purposes

gen Xvar=rnormal(500, 150)  
*Stata will draw values from a normal distribution with mean=500 and SD=150

hist Xvar, percent scheme(white_tableau) ///
fcolor(midblue%90) ///
title("{bf: Distribution of Xvar}", span) 

tabstat Xvar, st(mean sd) // mean = 499.8365


*STEP 3:  RANDOMLY SHUFFLE THE DATA & GENERATE A SAMPLE ID VARIABLE

*Randomly sort data (to ensure row # won't be correlated with anything)
tempvar sortorder  // declare a temporary "sort order" variable
gen `sortorder' = runiform()  // generate this variable as having values drawn from a normal distribution
sort `sortorder' // sort data on this variable

*Generate sequence to create a sample ID for each observation (requires package from above)
seq sampleID, f(1) t(5000) b(1) // 
/*Notes:
f=starting number of sequence 
t=end number (n / t will equal your number of observations per sample)
b=times each number repeats within one sequence
To create more samples with fewer observations, reduce t; 
To create fewer samples with more observations, increase t
*/

tab sampleID // You now have 5000 groups are equally sized (n=200)


*STEP 4:  CREATE A SAMPLE MEAN FOR EACH SAMPLE ID

egen sampleMean=mean(Xvar), by(sampleID)  // takes mean of Xvar by each sampleID value

sort sampleID // first 200 rows equal sample mean 1; next 200 = sample mean 2, etc.

*Optional: Preserve data as they currently exist
*NOTE: May need to execute directly in command window, not from .do file (bug?)

preserve 


*STEP 5:  COLLAPSE THE DATA TO YIELD 5000 SAMPLE MEANS

*Note:  Apparently need to run this line on its own
collapse sampleMean, by(sampleID) // mean of each sample will now become a single row


*STEP 6:  GRAPH IT AND SHOW DESCRIPTIVES!

hist sampleMean, percent /// histogram command with percent on y-axis
normal normopts(lcolor(magenta)) /// overlay normal distribution line in magenta color
scheme(gg_tableau) /// set scheme
fcolor(midblue%60) fintensity(100) /// adjust coloring of bins
lcolor(cyan) lwidth(thin) /// adjust coloring and look of lines around bins
title("{bf: Sampling Distribution of the Mean of Xvar}") /// title
subtitle("{bf: 5000 samples, N=200 per sample}") /// subtitle
xtitle("Random Sample Means of Xvar") ///
xsize(6.5) ysize(4.5) graphregion(margin(vsmall)) // adjust graph dimensions

*Descriptives:
tabstat sampleMean // 
sum sampleMean, det

di r(mean)+(1.96*(r(sd))) // 520.91276 
di r(mean)-(1.96*(r(sd))) //  478.76021

gen proportion_within_95=0 if sampleMean<478.76021 | sampleMean>520.91276
replace proportion_within_95=1 if proportion_within_95!=0
label define prop 0 "Outside 95%" 1 "Inside 95%"
label values proportion_within_95 prop

proportion proportion_within_95 // almost exactly 95% of sample means fall within +/- 1.96 SDs/SEs


/*KEY TAKEAWAY: 95% of these sample means are between roughly 478 and 521.
Thus, most of the sample means were quite close to the true mean (500), even 
with a relatively small sample size (n=200). */

restore // execute once you are done or wish to go back to pre-collapsed data (note: execute in command window)



********************************************************************
*EXAMPLE 2:  SAMPLING DISTRIBUTION WITH WORLD VALUES SURVEY DATA
********************************************************************

*Download dataset from here:
https://drive.google.com/file/d/1DrDOfEYbFtMp17MpcZKYGXzHCi3Gikr9/view?usp=share_link

clear
use "WVS_Wave_7_DemocracyVariable.dta", clear

set seed 1234  // set seed for replication
gen caseID=_n // optional (if you want to keep track of respondents)

*Variable = Importance of Democracy (1-10 scale) from countries around the world
tab1 B_COUNTRY  DemocracyImportance 
mean DemocracyImportance // mean=8.368993
tabstat caseID, st(n) // total n=76897
set obs 76897


*Let's Graph It!  Notice Its Skewness
hist DemocracyImportance, discrete scheme(gg_tableau) fcolor(%75) lcolor(cyan) ///
xline(8.368993, lcolor(red) lwidth(medium)) ///
title("{bf: How Important is Democracy?}") ///
subtitle("{bf: Answers from Around the World}") ///
note("{it: Note: World Values Survey, Wave 7 (n=75,622)}" "{it: Vertical red line = sample mean}", span size(vsmall))

*Since we already have the data, we can skip to Step 3...


*STEP 3:  RANDOMLY SHUFFLE THE DATA & GENERATE A SAMPLE ID VARIABLE

tempvar sortorder
gen `sortorder' = runiform()
sort `sortorder'

seq DemocracySampleID if DemocracyImportance!=., f(1) t(750) b(1) // restrict to observations w/ DemocracySampleID

tab DemocracySampleID


*STEP 4:  CREATE A SAMPLE MEAN FOR EACH SAMPLE ID

egen DemocracysampleMean=mean(DemocracyImportance), by(DemocracySampleID)


*Optional: Preserve data as they currently exist
*NOTE: May need to execute directly in command window, not from .do file (bug?)
preserve // execute in command window, not from .do file


*STEP 5:  COLLAPSE THE DATA TO YIELD 750 SAMPLE MEANS

*Note:  Apparently need to run this line on its own

collapse DemocracysampleMean, by(DemocracySampleID) // mean of each sample will now become a single row

*STEP 6:  GRAPH IT! 
hist DemocracysampleMean, percent ///
normal normopts(lcolor(magenta)) ///
scheme(gg_tableau) ///
fcolor(midblue%60) fintensity(100) lcolor(cyan) lwidth(thin) ///
xtitle("{bf: Sampling Distribution of the Mean of Democracy Importance}") ///
note("{it: Note: World Values Survey, Wave 7 (n=75,622)}" "{it: Vertical line indicates mean of sampling distribution}", span size(vsmall)) ///
text(9.4 7.77 "Original Sample Mean = 8.368993", color(white) size(small) box ///
fcolor(black) margin(small)) ///
xsize(6.5) ysize(4.5) graphregion(margin(vsmall)) ///
title("{bf: Sampling Distribution of the Mean}") ///
subtitle("{bf: 750 Random Samples; N=102 per Sample}") ///
xline(8.368993, lcolor(magenta) lwidth(medthick)) //


*Descriptives:
tabstat DemocracysampleMean // mean of sampling distribution ("true" mean = 8.368993 )

sum DemocracysampleMean, det  

di r(mean)+(1.96*(r(sd))) // mean + 1.96 SDs
di r(mean)-(1.96*(r(sd))) //  mean - 1.96 SDs

restore // optional if you wish to go back to pre-collapsed data (note: execute in command window)



*********************************************************************************
*EXAMPLE 3:  CREATING & EXAMINING RANDOM SAMPLES OF YOUR DATA (WITH REPLACEMENT)
*********************************************************************************

*STEP 1:  CLEAR OUT DATA AND SET OBSERVATIONS

clear
set seed 54321

set obs 10000 // set number of observations


*STEP 2:  GENERATE A SIMULATED, VERY SKEWED VARIABLE

gen Xvar=rbeta(10, 1)*100  // generates a negatively-skewed variable

*See here for more info:  https://www.stata.com/statalist/archive/2013-03/msg00749.html

tabstat Xvar, st(mean median sd skewness) // mean =90.98944 

hist Xvar, percent scheme(white_tableau) /// definitely skewed!
fcolor(midblue%80) ///
title("{bf: Distribution of Xvar}", span) ///
subtitle("{bf: Yep, I'm totally skewed!}", span) ///
note("{it: Note:  N = 10,000}", span)


*STEP 3: USING LOOPS TO CREATE SAMPLES (WITH REPLACEMENT)

*This will make 5 samples, each containing 200 observations of variable "Xvar"
foreach i of num 1/5 {
	gen sortorder_`i' = runiform()
	sort sortorder_`i'
	gen sample_`i' = Xvar in 1/200
}
/*Notes:  
This will loop through numbers (#) 1 to 5.  For each #, it generates
a variable called "sortorder_#" whose values are randomly drawn from a uniform 
distribution.  It then sorts on this variable, and then generates a variable
called "sample_# " whose values will be equal to the first 200 values of Xvar.
(Because it sorts before generating "sample_#", the first 200 values will be different
each time.) It then repeats the process until it has generated "sample_5".
*/ 

drop sortorder_*

tab1 sample_* // You now have five samples each with 200 observations

sum sample_* //  Descriptive stats for Xvar in each of the 5 samples

*Optional: A loop to make variable labels empty (for graph below)
foreach i of num 1/5 {
	label var sample_`i' " "
}


*STEP 4: TAKE THE MEAN OF Xvar IN EACH OF THE 5 SAMPLES AND STORE IT

foreach i of num 1/5 {
	mean sample_`i'
	estimates store samplemean_`i'
}

/*Notes:  
This will loop through numbers (#) 1 to 5.  For each #, it takes the mean of
"sample_#" and then stores it as "samplemean_#".  
*/


*STEP 5:  GRAPH THE 5 SAMPLE MEANS IN COMPARISON TO THE TRUE SAMPLE MEAN & ITS DISPERSION	
coefplot (samplemean_1, label(Random Sample 1)) (samplemean_2, label(Random Sample 2)) ///
(samplemean_3, label(Random Sample 3)) (samplemean_4, label(Random Sample 4)) (samplemean_5, label(Random Sample 5)), ///
scheme(rainbow) xlab(80(5)100) ///
xlab(82.706704 "-1 SD" 86.848073 "-0.5SD" 90.989442 "True Sample Mean (90.99)" 95.130811 "+0.5 SD" 99.27218 "+1 SD") ///
xline(90.98944, lcolor(magenta) lwidth(medium)) ///
msize(16-pt) mlcolor(cyan) mlwidth(medthin) ///
ciopts(lwidth(medium)) cismooth ///
legend(pos(3) col(1) title("{bf: Sample Means}", box lcolor(white))) ///
title("{bf: Means of 5 Randomly Selected Samples}", span) ///
subtitle("{bf: Negatively Skewed Distribution with Mean=90.99 & SD=8.28}", span) ///
note("{it: Note: N=200 for each sample}", span size(vsmall)) ///
xsize(6.5) ysize(4.5) graphregion(margin(small))

/*KEY TAKEAWAY:  Despite being a modest sample size (n=200), and coming from a very skewed distribution, 
all 5 sample means are very close to the true mean of Xvar. In fact,
each sample mean's confidence interval overlaps with the true Xvar mean. 
*/

*FYI:  How calculations were made for axis values in graph:
summarize Xvar, det
di r(mean) // mean
di r(mean)+r(sd) // +1 SD
di r(mean)-r(sd) // -1 SD
di r(mean)+(.5*r(sd)) // +0.5 SD
di r(mean)-(.5*r(sd)) // -0.5 SD



*********************************************************************************
*EXAMPLE 4:  CREATING A SAMPLING DISTRIBUTION (WITH REPLACEMENT) 
*********************************************************************************

clear

set obs 10000 // set number of observations

gen caseID=_n // Optional: keep track of individual observations


*STEP 2:  GENERATE A SIMULATED, VERY SKEWED VARIABLE

set seed 12345

gen Xvar=rbeta(10, 1)*100  // generates a negatively-skewed variable

*See here for more info:  https://www.stata.com/statalist/archive/2013-03/msg00749.html

tabstat Xvar, st(mean median sd skewness) // mean =90.99234 

hist Xvar, percent scheme(white_tableau) /// definitely skewed!
fcolor(midblue%80) ///
title("{bf: Distribution of Xvar}", span) ///
subtitle("{bf: Yep, I'm totally skewed!}", span) ///
note("{it: Note:  N = 10,000}", span)


*STEP 3: USING LOOPS TO CREATE SAMPLES (WITH REPLACEMENT)

*This will make 75 random samples, each containing 300 observations of variable "Xvar"

quietly foreach i of num 1/75 {
	gen sortorder_`i' = runiform()
	sort sortorder_`i'
	gen sample`i' = Xvar in 1/300
}

*You now have 300 samples, each with 200 observations with randomly drawn values of Xvar


*STEP 4:  RESHAPE THE DATA SO THAT ALL SAMPLES OF "Xvar" BECOME A SINGLE COLUMN

drop sortorder_* // can remove to speed up reshaping

quietly reshape long sample`i', i(caseID) j(samplegroup)

tab sample // 22,500 values of Xvar
tabstat sample if samplegroup<=10, by(samplegroup) st(mean median sd n)

*STEP 5:  CREATE A SAMPLE MEAN FOR EACH SAMPLE ID

egen XvarSampleMean=mean(sample) if sample!=., by(samplegroup)


*Optional: Preserve data as they currently exist
*NOTE: May need to execute directly in command window, not from .do file (bug?)
preserve 


*STEP 6:  COLLAPSE THE DATA TO YIELD 750 SAMPLE MEANS

*Note:  Apparently need to run this line on its own

collapse XvarSampleMean, by(samplegroup) // mean of each sample will now become a single row

tab XvarSampleMean // You now have a dataset of 75 sample means of Xvar

mean XvarSampleMean // mean of sampling distribution  

*STEP 6:  GRAPH IT! 
*(Note: last line saves graph; I'd recommend choose a directory File > Change working directory  > (Choose whatever you want)
hist XvarSampleMean, percent ///
normal normopts(lcolor(magenta)) ///
scheme(gg_tableau) ///
fcolor(midblue%60) fintensity(100) lcolor(cyan) lwidth(medthin) ///
xtitle(" ") ///
note("{bf: Note: 75 Random Samples; N=300 per Sample}" "{it: Vertical line indicates population mean}", span size(vsmall)) ///
text(27.5 89.5 "Population Mean = 90.99234", color(white) size(medsmall) box /// first numbers are (y,x) coordinates
fcolor(black) margin(small)) ///
xlab(89(.5)92) ///
xsize(6.5) ysize(4.5) graphregion(margin(vsmall)) ///
title("{bf: Sampling Distribution of the Mean}") ///
subtitle("{bf: 75 Samples of 300 from a Population of 10,000}") ///
xline(90.99234, lcolor(black) lwidth(medthick)) ///
saving("samplingdist_smallpop.gph", replace) // note:  you may want to 


restore // optional (to return to pre-collapsed data)


/*Step 7:  OPTIONAL: Make a second graph with larger population (repeat steps above)
This helps illustrate that the size of the population is less important for
obtaining an accurate estimate than many people think.
*/

clear
set obs 100000 // setting to 100k instead of 10k

gen caseIDB=_n

set seed 12345

gen XvarB=rbeta(10, 1)*100  // generates a negatively-skewed variable

tabstat XvarB, st(mean median sd skewness n) // mean =90.89477

*This will make 75 samples, each containing 200 observations of variable "XvarB"
quietly foreach i of num 1/75 {
	gen sortorderB_`i' = runiform()
	sort sortorderB_`i'
	gen sampleB`i' = XvarB in 1/300
}

drop sortorderB_* // can remove to speed up reshaping


quietly reshape long sampleB`i', i(caseIDB) j(samplegroupB)


egen XvarSampleMeanB=mean(sampleB) if sampleB!=., by(samplegroupB)


*Optional: Preserve data as they currently exist
*NOTE: May need to execute directly in command window, not from .do file (bug?)
preserve 


*Note:  Apparently need to run this line on its own

collapse XvarSampleMeanB, by(samplegroupB) // mean of each sample will now become a single row

tabstat XvarSampleMeanB, st(mean median sd skewness n) // examine mean of sampling distribution

hist XvarSampleMeanB, percent ///
normal normopts(lcolor(magenta)) ///
scheme(gg_tableau) ///
fcolor(midblue%60) fintensity(100) lcolor(cyan) lwidth(medthin) ///
xtitle(" ") ///
note("{bf: Note: 75 Random Samples; N=300 per Sample}" "{it: Vertical line indicates population mean}", span size(vsmall)) ///
text(22.5 89.5 "Population Mean = 90.89477", color(white) size(medsmall) box /// first numbers are (y,x) coordinates
fcolor(black) margin(small)) ///
xlab(89(.5)92) ///
xsize(6.5) ysize(4.5) graphregion(margin(vsmall)) ///
subtitle("{bf: 75 Samples of 300 from a Population of 100K}") ///
xline(90.92153, lcolor(black) lwidth(medthick)) ///
saving("samplingdist_smallpopB.gph", replace)


graph combine "samplingdist_smallpop.gph" "samplingdist_smallpopB.gph", col(1) ///
ycommon xcommon iscale(.7) ///
xsize(6.5) ysize(5.5) graphregion(margin(vsmall)) ///
scheme(gg_tableau)


**********************************************************************
*BONUS:  TAKING A SINGLE SAMPLE USING THE "SAMPLE" FUNCTION
**********************************************************************
/*This command is very simple and can be helpful.  However, the main downside is that
it immediately drops the observations not sampled, so you can't have multiple random samples 
in your data set at the same time. 
*/

clear // clear existing data

set obs 10000 // set data set to n=1,000,000

set seed 1234 // set seed for replication purposes

gen Xvar=rnormal(500, 150)  

seq catvar, f(1) t(5) b(1) // generate a categorical variable taking on values 1 thru 5

preserve // execute in command window

sample 20 // randomly samples 20% of the dataset 
tab Xvar

restore // execute in command window

preserve // execute in command window

sample 20, count // randomly samples 20 observations (count option)
tab Xvar

restore // execute in command window

preserve // execute in command window

sample 20, by(catvar) // samples 20% of each value of catvar 
mean Xvar, over(catvar)

restore // execute in command window

****************************************************************************


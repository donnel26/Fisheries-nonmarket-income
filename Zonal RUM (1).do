*This file contains code to estimate the first stage of a zonal RUM model.

*The code is implemented using a command line reading "zonalrum [positional arguments]" where the positional arguments is a list of seven variables and a scalar. The seven variables are the ID code for the recreation sites, the ID code for the residential zones, the number of visits to each site, the population in each zone, an indicator variable for any zones that the modeler wants to exclude in estimating the travel cost coefficient (if the modeler does not want to exclude any zones in estimating the travel cost coefficient, this indicator should be set to all zeros), an indicator for the stay-home alternative, travel cost, and travel distance. The final argument is a scalar for the average travel distance, which can be defined prior to running the command, e.g. scalar avgdist=20. For example, a command could look like "zonalrum county_number zip visits pop zonalcatchall stayhome cost distance avg_dist".  

*The output contains the mean site utilities (alternative-specific constants) and travel cost coefficient. 

*The command summarizes part of the output for each run of the outer loop that estimates the travel cost coefficient.


**********************************************
****The zonal RUM command code begins here****
**********************************************
cap prog drop zonalrum
timer on 1
prog def zonalrum, rclass
display _newline as txt "Zonal RUM model" 
display _newline as txt "Inner loop iterations | Predicted avg distance | Travelcost coefficient"

*_dots 0
local rep 1
version 16
args siteid				///
	zoneid				///
	visits				///
	pop					///
	zoneother			///
	stayhome			///
	travelcost			///
	distance			///
	avg_dist 			
	
quietly{
	tempvar share_pop share_vis sums sum_e_jk trip_share trip_share_dist trip_s_pop_s edelta_j e_jk diff avg_dist_hat share_b_hat share_go mu
	global meanutility tcparameter
	sum `siteid'
	scalar min = r(min)
	sum `pop' if `siteid'==min
	scalar totalpop = r(mean)*r(N)	//total population across the residential zones
	scalar totalzones = r(N)		//total number of residential zones
	gen `share_pop' = `pop'/totalpop
	sum `visits', meanonly
	gen `share_vis' = `visits'/(r(mean)*r(N)/totalzones)
	gen `sums' = 0
	gen `sum_e_jk' = 0
	gen `trip_share' = 0
	gen `trip_s_pop_s' = 0
	gen `trip_share_dist' = 0
	gen `edelta_j' = 1
	gen `diff' = 1
	scalar avg_dist_hat = 1
	scalar tolout = 10E-3		//tolerance for outer-loop bisection
	scalar tolin = 10E-7		//tolerance for inner-loop contraction mapping -9
	scalar mu_max = 0.1		//maximum travel cost coefficient in bisection 
	scalar mu_min = 0.0001 //minimum travel cost coefficient in bisection

*Beginning of the outer loop used to calculate the travel cost coefficient
	local o = 1
	scalar tol_out = tolout
	while abs(avg_dist_hat - avg_dist) > tol_out {
		scalar sdiff = 1
		scalar mu_mid = (mu_max + mu_min)/2
		gen double `e_jk' = `edelta_j'*exp(-mu_mid*`travelcost')
		by `zoneid', s: replace `sums' = sum(`e_jk')
		by `zoneid' (`sums'), s: replace `sum_e_jk' = `sums'[_N]
		replace `trip_share' = `e_jk'/`sum_e_jk'
		replace `trip_s_pop_s' = `trip_share'*`share_pop'
		by `siteid', s: replace `sums' = sum(`trip_s_pop_s')
		by `siteid' (`sums'), s: gen `share_b_hat' = `sums'[_N]
		replace `trip_share_dist' = `trip_share'*`pop'*`distance'
		egen `share_go' = total(`pop'*`trip_share') if `stayhome'==0&`zoneother'==0 //This variable name is a misnomer; it calculates the predict number of trips from each zone to each site
		sum `share_go', meanonly
		replace `share_go' = r(mean)
		egen `avg_dist_hat' = total(`trip_share_dist'/`share_go') if `zoneother'==0
		sum `avg_dist_hat', meanonly //Predicted average distance should iterate to actual average distance
		scalar avg_dist_hat = r(mean)
		scalar sign_mid = sign(avg_dist_hat-avg_dist)
		scalar mu_min = cond(sign_mid>0,(mu_mid+mu_min)/2,mu_min)
		scalar mu_max = cond(sign_mid<0,(mu_mid+mu_max)/2,mu_max)

*Beginning of the inner loop used to calculate the mean site utilities
		local i = 1
		scalar tol_in = tolin
		while sdiff > tol_in {
			replace `edelta_j' = `edelta_j'*`share_vis'/`share_b_hat' if `siteid'!=min
			replace `e_jk' = `edelta_j'*exp(-mu_mid*`travelcost')
			drop `sum_e_jk' `share_b_hat'
			by `zoneid', s: replace `sums' = sum(`e_jk')
			by `zoneid' (`sums'), s: gen `sum_e_jk' = `sums'[_N]
			replace `trip_share' = `e_jk'/`sum_e_jk'
			replace `trip_s_pop_s' = `trip_share'*`share_pop'
			by `siteid', s: replace `sums' = sum(`trip_s_pop_s')
			by `siteid' (`sums'), s: gen `share_b_hat' = `sums'[_N]
			replace `diff' = abs(`share_vis' - `share_b_hat')
			sum `diff'
			scalar sdiff = r(max)
			local ++i
			scalar tol_in=tolin*10^floor(`i'/1000)			//reduces the tolerance by 10E-1 every 1000 iterations
		}	
		local ++o
		scalar tol_out=tolout*10^floor(`o'/100)				//reduces the tolerance by 10E-1 every 100 iterations
		nois display `i' %9.0g " | " %9.0g avg_dist_hat %9.0g " | " %9.0g mu_mid 
		*nois _dots `rep++' 0
		drop `e_jk' `share_b_hat' `share_go' `avg_dist_hat'
	}
nois gen tccoefficient= mu_mid  //Estimated travel cost coefficient
gen meanutility = ln(`edelta_j')
*collapse `visits' `stayhome' meanutility tccoefficient, by(`siteid')
}
end

**********************************************
******************2000************************
**********************************************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2000.dta", clear
rename numberzone zoneid
rename Effort2000 visits
rename pop2000 pop
rename distmiles distance
rename excluded zoneother
rename TC2000 travelcost
replace siteid=1 if site=="Calumet"
replace siteid=7 if site=="Burns Harbor"
sort siteid zoneid
//drop if visits==. don't have any to drop now!
//distance per angler hour  5.345195421*4.5== 24.053379
scalar avg_dist=24.053379
replace zoneother=1 if zip==1
replace zoneother=1 if zip==2
*trying stayhome*1.5
replace visits=visits*2.5 if siteid==99
//check this
replace distance=0 if siteid==99
zonalrum siteid zoneid visits pop zoneother stayhome travelcost distance avg_dist


rename visits effort
collapse siteid effort tccoefficient meanutility, by(site)	
gen year=2000
sort siteid

**********************************************
******************2001************************
**********************************************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2001.dta", clear
drop zipstate sitestate
rename numberzone zoneid
rename Effort2001 visits
rename pop2001 pop
rename distmiles distance
rename excluded zoneother
rename TC2001 travelcost
replace siteid=1 if site=="Calumet"
replace siteid=7 if site=="Burns Harbor"
sort siteid zoneid
drop if visits==.
//distance per angler hour 5.832404687*4.5== 26.245821
scalar avg_dist=26.245821
replace zoneother=1 if zip==1
replace zoneother=1 if zip==2
*trying stayhome*1.5
replace visits=visits*2.5 if siteid==99
replace distance=0 if siteid==99
zonalrum siteid zoneid visits pop zoneother stayhome travelcost distance avg_dist


rename visits effort
collapse siteid effort tccoefficient meanutility, by(site)	
gen year=2001
sort siteid

**********************************************
******************2002************************ 
**********************************************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2002.dta",clear
keep siteid site zip numberzone pop2002 Effort2002 TC2002 excluded stayhome distmiles
rename numberzone zoneid
rename Effort2002 visits
rename pop2002 pop
rename distmiles distance
rename excluded zoneother
rename TC2002 travelcost
replace siteid=1 if site=="Calumet"
replace siteid=7 if site=="Burns Harbor"
sort siteid zoneid
drop if visits==.
//distance per angler hour 5.293531049*4.5== 23.82089
scalar avg_dist=23.82089
replace zoneother=1 if zip==1
replace zoneother=1 if zip==2
*trying stayhome*1.5
replace visits=visits*2.5 if siteid==99
replace distance=0 if siteid==99
zonalrum siteid zoneid visits pop zoneother stayhome travelcost distance avg_dist

rename visits effort
collapse siteid effort tccoefficient meanutility, by(site)	
gen year=2002
sort siteid



**********************************************
******************2003************************
**********************************************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2003.dta",clear
keep siteid site zip numberzone pop2003 Effort2003 TC2003 excluded stayhome distmiles
rename numberzone zoneid
rename Effort2003 visits
rename pop2003 pop
rename distmiles distance
rename excluded zoneother
rename TC2003 travelcost
replace siteid=1 if site=="Calumet"
replace siteid=7 if site=="Burns Harbor"
drop if visits==.
sort siteid zoneid
//distance per angler hour 5.553559375*4.5== 24.991017
scalar avg_dist=24.991017
replace zoneother=1 if zip==1
replace zoneother=1 if zip==2
*trying stayhome*1.5
replace visits=visits*2.5 if siteid==99
*replace visits=4541180 if siteid==99
replace distance=0 if siteid==99
zonalrum siteid zoneid visits pop zoneother stayhome travelcost distance avg_dist

rename visits effort
collapse siteid effort tccoefficient meanutility, by(site)	
gen year=2003
sort siteid


**********************************************
******************2004************************
**********************************************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2004.dta",clear
keep siteid site zip numberzone pop2004 Effort2004 TC2004 excluded stayhome distmiles
rename numberzone zoneid
rename Effort2004 visits
rename pop2004 pop
rename distmiles distance
rename excluded zoneother
rename TC2004 travelcost
replace siteid=1 if site=="Calumet"
replace siteid=7 if site=="Burns Harbor"
drop if visits==.
sort siteid zoneid
//distance per angler hour 5.248477101*4.5== 23.618147
scalar avg_dist=23.618147
replace zoneother=1 if zip==1
replace zoneother=1 if zip==2
*trying stayhome*1.5
replace visits=visits*2.5 if siteid==99
*replace visits=4541180 if siteid==99
replace distance=0 if siteid==99
zonalrum siteid zoneid visits pop zoneother stayhome travelcost distance avg_dist

rename visits effort
collapse siteid effort tccoefficient meanutility, by(site)	
gen year=2004
sort siteid

**********************************************
******************2005************************
**********************************************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2005.dta",clear
keep siteid site zip numberzone pop2005 Effort2005 TC2005 excluded stayhome distmiles
rename numberzone zoneid
rename Effort2005 visits
rename pop2005 pop
rename distmiles distance
rename excluded zoneother
rename TC2005 travelcost
replace siteid=1 if site=="Calumet"
replace siteid=7 if site=="Burns Harbor"
drop if visits==.
sort siteid zoneid
//distance per angler hour 5.644878179*4.5== 25.401952
scalar avg_dist=25.401952
replace zoneother=1 if zip==1
replace zoneother=1 if zip==2
*trying stayhome*1.5
replace visits=visits*2.5 if siteid==99
*replace visits=4541180 if siteid==99
replace distance=0 if siteid==99
zonalrum siteid zoneid visits pop zoneother stayhome travelcost distance avg_dist

rename visits effort
collapse siteid effort tccoefficient meanutility, by(site)	
gen year=2005
sort siteid

**********************************************
******************2006************************
**********************************************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2006.dta",clear
keep siteid site zip numberzone pop2006 Effort2006 TC2006 excluded stayhome distmiles
rename numberzone zoneid
rename Effort2006 visits
rename pop2006 pop
rename distmiles distance
rename excluded zoneother
rename TC2006 travelcost
replace siteid=1 if site=="Calumet"
replace siteid=7 if site=="Burns Harbor"
drop if visits==.
sort siteid zoneid
//distance per angler hour 6.0671457*4.5== 27.302156
scalar avg_dist=27.302156
replace zoneother=1 if zip==1
replace zoneother=1 if zip==2
*trying stayhome*1.5
replace visits=visits*2.5 if siteid==99
*replace visits=4541180 if siteid==99
replace distance=0 if siteid==99
zonalrum siteid zoneid visits pop zoneother stayhome travelcost distance avg_dist

rename visits effort
collapse siteid effort tccoefficient meanutility, by(site)	
gen year=2006
sort siteid

**********************************************
******************2007************************
**********************************************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2007.dta",clear
keep siteid site zip numberzone pop2007 Effort2007 TC2007 excluded stayhome distmiles
rename numberzone zoneid
rename Effort2007 visits
rename pop2007 pop
rename distmiles distance
rename excluded zoneother
rename TC2007 travelcost
replace siteid=1 if site=="Calumet"
replace siteid=7 if site=="Burns Harbor"
drop if visits==.
sort siteid zoneid
//distance per angler hour 5.906081553*4.5== 26.577367
scalar avg_dist=26.577367
replace zoneother=1 if zip==1
replace zoneother=1 if zip==2
*trying stayhome*1.5
replace visits=visits*2.5 if siteid==99
*replace visits=4541180 if siteid==99
replace distance=0 if siteid==99
zonalrum siteid zoneid visits pop zoneother stayhome travelcost distance avg_dist

rename visits effort
collapse siteid effort tccoefficient meanutility, by(site)	
gen year=2007
sort siteid

**********************************************
******************2008************************
**********************************************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2008.dta",clear
keep siteid site zip numberzone pop2008 Effort2008 TC2008 excluded stayhome distmiles
rename numberzone zoneid
rename Effort2008 visits
rename pop2008 pop
rename distmiles distance
rename excluded zoneother
rename TC2008 travelcost
replace siteid=1 if site=="Calumet"
replace siteid=7 if site=="Burns Harbor"
drop if visits==.
sort siteid zoneid
//distance per angler hour *4.5== 
scalar avg_dist=26.577367
replace zoneother=1 if zip==1
replace zoneother=1 if zip==2
*trying stayhome*1.5
replace visits=visits*2.5 if siteid==99
*replace visits=4541180 if siteid==99
replace distance=0 if siteid==99
zonalrum siteid zoneid visits pop zoneother stayhome travelcost distance avg_dist

rename visits effort
collapse siteid effort tccoefficient meanutility, by(site)	
gen year=2008
sort siteid

**********************************************
******************2009************************
**********************************************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2009.dta",clear
keep siteid site zip numberzone pop2009 Effort2009 TC2009 excluded stayhome distmiles
rename numberzone zoneid
rename Effort2009 visits
rename pop2009 pop
rename distmiles distance
rename excluded zoneother
rename TC2009 travelcost
replace siteid=1 if site=="Calumet"
replace siteid=7 if site=="Burns Harbor"
drop if visits==.
sort siteid zoneid
//distance per angler hour 5.363795786*4.5== 24.137081
scalar avg_dist=24.137081
replace zoneother=1 if zip==1
replace zoneother=1 if zip==2
*trying stayhome*1.5
replace visits=visits*2.5 if siteid==99
*replace visits=4541180 if siteid==99
replace distance=0 if siteid==99
zonalrum siteid zoneid visits pop zoneother stayhome travelcost distance avg_dist
*
rename visits effort
collapse siteid effort tccoefficient meanutility, by(site)	
gen year=2009
sort siteid

**********************************************
******************2010************************
**********************************************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2010.dta",clear
keep siteid site zip numberzone pop2010 Effort2010 TC2010 excluded stayhome distmiles
rename numberzone zoneid
rename Effort2010 visits
rename pop2010 pop
rename distmiles distance
rename excluded zoneother
rename TC2010 travelcost
replace siteid=1 if site=="Calumet"
replace siteid=7 if site=="Burns Harbor"
drop if visits==.
sort siteid zoneid
//distance per angler hour 5.244272276*4.5== 23.599225
scalar avg_dist=23.599225
replace zoneother=1 if zip==1
replace zoneother=1 if zip==2
*trying stayhome*1.5
replace visits=visits*2.5 if siteid==99
*replace visits=4541180 if siteid==99
replace distance=0 if siteid==99
zonalrum siteid zoneid visits pop zoneother stayhome travelcost distance avg_dist

rename visits effort
collapse siteid effort tccoefficient meanutility, by(site)	
gen year=2010
sort siteid

**********************************************
******************2011************************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2011.dta",clear
keep siteid site zip numberzone pop2011 Effort2011 TC2011 excluded stayhome distmiles
rename numberzone zoneid
rename Effort2011 visits
rename pop2011 pop
rename distmiles distance
rename excluded zoneother
rename TC2011 travelcost
replace siteid=1 if site=="Calumet"
replace siteid=7 if site=="Burns Harbor"
drop if visits==.
sort siteid zoneid
//distance per angler hour 5.274775625*4.5== 23.73649
scalar avg_dist=23.73649
replace zoneother=1 if zip==1
replace zoneother=1 if zip==2
*trying stayhome*1.5
replace visits=visits*2.5 if siteid==99
*replace visits=4541180 if siteid==99
replace distance=0 if siteid==99
zonalrum siteid zoneid visits pop zoneother stayhome travelcost distance avg_dist

rename visits effort
collapse siteid effort tccoefficient meanutility, by(site)	
gen year=2011
sort siteid

**********************************************
******************2012************************
**********************************************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2012.dta",clear
keep siteid site zip numberzone pop2012 Effort2012 TC2012 excluded stayhome distmiles
rename numberzone zoneid
rename Effort2012 visits
rename pop2012 pop
rename distmiles distance
rename excluded zoneother
rename TC2012 travelcost
replace siteid=1 if site=="Calumet"
replace siteid=7 if site=="Burns Harbor"
drop if visits==.
sort siteid zoneid
//distance per angler hour 
scalar avg_dist=23.73649
replace zoneother=1 if zip==1
replace zoneother=1 if zip==2
*trying stayhome*1.5
replace visits=visits*2.5 if siteid==99
*replace visits=4541180 if siteid==99
replace distance=0 if siteid==99
zonalrum siteid zoneid visits pop zoneother stayhome travelcost distance avg_dist

rename visits effort
collapse siteid effort tccoefficient meanutility, by(site)	
gen year=2012
sort siteid

**********************************************
******************2013************************
**********************************************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2013.dta",clear
keep siteid site zip numberzone pop2013 Effort2013 TC2013 excluded stayhome distmiles
rename numberzone zoneid
rename Effort2013 visits
rename pop2013 pop
rename distmiles distance
rename excluded zoneother
rename TC2013 travelcost
replace siteid=1 if site=="Calumet"
replace siteid=7 if site=="Burns Harbor"
drop if visits==.
//distance per angler hour
scalar avg_dist=23.73649
replace zoneother=1 if zip==1
replace zoneother=1 if zip==2
*trying stayhome*1.5
replace visits=visits*2.5 if siteid==99
*replace visits=4541180 if siteid==99
replace distance=0 if siteid==99
zonalrum siteid zoneid visits pop zoneother stayhome travelcost distance avg_dist

rename visits effort
collapse siteid effort tccoefficient meanutility, by(site)	
gen year=2013
sort siteid

STOP
sum siteid
scalar min = r(min)
sum pop if siteid==min, meanonly
scalar totalpop = r(mean)*r(N)
scalar totalzones = r(N)
gen share_pop = pop/totalpop
sum visits, meanonly
gen share_vis = visits/(r(mean)*r(N)/totalzones)
gen sums = 0
gen sum_e_jk = 0
gen trip_share = 0
gen trip_s_pop_s = 0
gen trip_share_dist = 0
gen edelta_j = 1
gen diff = 1
gen double e_jk = edelta_j*exp(-mu_mid*travelcost)
by zoneid, s: replace sums = sum(e_jk)
by zoneid (sums), s: replace sum_e_jk = sums[_N]
replace trip_share = e_jk/sum_e_jk
replace trip_s_pop_s = trip_share*share_pop
by siteid, s: replace sums = sum(trip_s_pop_s)
by siteid (sums), s: gen share_b_hat = sums[_N]

replace edelta_j = edelta_j*share_vis/share_b_hat if siteid!=min
replace e_jk = edelta_j*exp(-mu_mid*travelcost)
drop sum_e_jk share_b_hat
by zoneid, s: replace sums = sum(e_jk)
by zoneid (sums), s: gen sum_e_jk = sums[_N]
replace trip_share = e_jk/sum_e_jk
replace trip_s_pop_s = trip_share*share_pop
by siteid, s: replace sums = sum(trip_s_pop_s)
by siteid (sums), s: gen share_b_hat = sums[_N]
**********************************************
*******Mean utilities from zonal RUM**********
**********************************************
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\stage1results.dta"

tempfile meanutiltities
save `meanutiltities'


**********************************************
*************Harvest rates data***************
**********************************************
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\HarvestRates.dta"
gen HarvestRate2009=. //no sites had harvest data in 2009
reshape long HarvestRate,i(site fish) j(year)

egen fishID= group(fish)


drop if fishID==1
merge 1:1 site year using `meanutiltities'
drop _merge
sort siteid
egen siteID = group(site) //diff than siteid

****indicator for sites being used in second stage***
gen use=1 if site== "Burnham" | site== "Calumet" | site== "Diversey Harbor" | site== "Jackson" | site== "Montrose Harbor" | site== "North Point" | site== "Waukegan Harbor" 
replace use=0 if year== 2009| year== 2010 | year== 2011 | year== 2012 | year== 2013
replace use=0 if use==.
sort use site year
**********************************************
**********Regression to get CR coeff**********
**********************************************
rename tccoefficient rho
rename meanutility delta
gen WTP=delta/rho

gen ILsite=1 if site == "Belmont" | site == "Burnham" |site == "Calumet" |site == "Diversey Harbor" |site == "Jackson" |site == "McCormick" |site == "Montrose Harbor" |site == "North Point" |site == "Waukegan Harbor" |site == "Waukegan Powerplant" 
replace ILsite=0 if ILsite==.
replace ILsite=0 if siteid == 99
egen sitefx=group(siteid)
egen t=group(year)
rename HarvestRate cr
drop if fishID==.
gen t_sqr=t^2
regress cr c.year##c.year i.siteID if fishID==2 //impute missing harvest rates data
predict hrhat
//replace hrhat=abs(hrhat)
replace cr=hrhat if cr==.
gen crt=t*cr
gen crt_sqr=t_sqr*cr

******Regression and save catch rate scalar******
drop if fishID==.
reg WTP cr crt crt_sqr if ILsite == 1, robust  
scalar b1 = _b[cr]
scalar b2 = _b[crt]
scalar b3 = _b[crt_sqr]
 scalar list
 
********Get rid of sites don't need***********
drop if site== "AllIL"| site== "AllIN"| site== "AllINstreams"
//keep if site=="Diversey Harbor"
tempfile Diversey
save `Diversey'

**********************************************
***********bring in zone site data************
**********************************************
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta" 
drop RUCA1 urban rural excluded stayhome
//keep if site=="Diversey Harbor"
reshape long pop Effort TC, i(site zip) j(year)
merge m:1 site year using `Diversey Harbor'
order site zip year fish fish_id rho delta cr crt crt_sqr
sort zip year
drop effort
drop _merge
********************************************************************************************************************************************************************************************************************************************************************************************************************************
sort year
rename Effort visits
replace visits=visits/4.5
egen choice_occasions = total(visits), by(site year)
//egen site_choice_occasions= total(visits), by(site year zip)


gen p_jt=visits*(b1/rho)
gen p=(b1/rho)
mean(p_jt)
gen income=p_jt*cr
mean(income)


collapse (mean) p_jt income, by(site year)
collapse (sum) p_jt income, by(year)










//egen site_choice_occasions = total(visits), by(site year)
//gen share=site_choice_occasions/ choice_occasions 

//choice occasions (# of days of site visits/year)
//gen choice_occasions = 0
//forvalues year = 2000/2013 {
 //   qui sum visits if year == `year', meanonly
 //   replace choice_occasions = r(sum) if year == `year'
//}
//replace choice_occasions = choice_occasions / 4.5
egen choice_id = group(zip)
gen exp_U=exp((rho*TC)+(cr*b1))
**gen exp_U=exp((rho*TC)+(cr*b1)+(crt*b2)+crt_sqr*b3)
by choice_id, sort: egen sum_U= sum(exp_U)
gen lnsum=ln(exp_U)
mean(lnsum)
rename lnsum WTPhat

gen share=site_choice_occasions/choice_occasions
gen WTP_stage2=WTPhat/share
mean(WTP_stage2)




Old code starts here. This is the code for the results for August 2023 version of the paper.
**********************************************
**************WTP Calculation*****************
**********************************************
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\stage1resultscomplete.dta"

drop share_pop sums trip_share trip_s_pop_s trip_share_dist edelta_j diff sum_e_jk e_jk distance stayhome zoneother
collapse (mean) visits share_vis tccoefficient, by(siteid site year)

gen WTP=-(ln(1-share_vis))/tccoefficient
sort site year
by site year: summ WTP

//choice occasions (# of days of site visits/year)
gen choice_occasions = 0
forvalues year = 2002/2013 {
    qui sum visits if year == `year', meanonly
    replace choice_occasions = r(sum) if year == `year'
}

sort siteid year

replace choice_occasions = choice_occasions / 4.5


gen actual_days=visits/4.5 
gen aggvalue=WTP*choice_occasions
gen tripvalue=WTP*(choice_occasions/actual_days)

//travel costs already adjusted to 2023 so probably don't need to do this.
gen CPI=.
replace CPI=174.9 if year==2002
replace CPI=178.3 if year==2003
replace CPI=182.6 if year==2004
replace CPI=188.4 if year==2005
replace CPI=193 if year==2006
replace CPI=198.1 if year==2007
replace CPI=205.4 if year==2008
replace CPI=204.1 if year==2009
replace CPI=208.05 if year==2010
replace CPI=214.7 if year==2011
replace CPI=219.1 if year==2012
replace CPI=222.2 if year==2013
gen CPI2022=272.4013

gen aggvalue_adj=aggvalue*(CPI2022/CPI)
gen tripvalue_adj=tripvalue*(CPI2022/CPI)

**# Site group WTP

drop WTP choice_occasions actual_days aggvalue tripvalue
sort siteid year
order siteid year share_vis tccoefficient
collapse (mean) visits share_vis tccoefficient, by(siteid site year)


//State indicators: 
stop
gen INsite=1 if siteid == 7 | siteid == 2 | siteid == 3 | siteid == 4 
replace INsite=0 if INsite==.
replace INsite=0 if siteid == 99
gen ILsite=1 if siteid == 1 | siteid == 5 | siteid == 6 | siteid == 8 | siteid == 9 | siteid == 10 | siteid == 11 | siteid == 12 | siteid == 13 | siteid == 14  
replace ILsite=0 if siteid == 99
replace ILsite=0 if ILsite ==.
gen INstreams=1 if siteid == siteid == 16 | siteid == 17 | siteid == 18 
replace INstreams=0 if INstreams==.
replace INstreams=1 if siteid==16
replace INstreams=0 if siteid == 99
gen chicagosite=1 if siteid == siteid == 5 | siteid == 6 | siteid == 1 | siteid == 5 | siteid == 8 | siteid == 9 | siteid == 10 | siteid == 11 | siteid == 15
replace chicagosite=0 if chicagosite==.
replace chicagosite=0 if siteid == 99

// IL

local years 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013
foreach year of local years {
    egen total_sharevis_IL_`year' = total(share_vis) if ILsite == 1 & year == `year'
    gen WTPIL`year' = -(ln(1 - total_sharevis_IL_`year')) / tccoefficient if ILsite == 1 & year == `year'
}
list WTPIL2002 WTPIL2003 WTPIL2004 WTPIL2005 WTPIL2006 WTPIL2007 WTPIL2008 WTPIL2009 WTPIL2010 WTPIL2011 WTPIL2012 WTPIL2013

collapse (mean) ILsite  visits share_vis tccoefficient WTPIL2002 WTPIL2003 WTPIL2004 WTPIL2005 WTPIL2006 WTPIL2007 WTPIL2008 WTPIL2009 WTPIL2010 WTPIL2011 WTPIL2012 WTPIL2013, by(siteid site year)

gen WTPIL = 0
local years 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013
foreach year of local years {
    replace WTPIL = WTPIL`year' if year == `year'
}

drop WTPIL2002 WTPIL2003 WTPIL2004 WTPIL2005 WTPIL2006 WTPIL2007 WTPIL2008 WTPIL2009 WTPIL2010 WTPIL2011 WTPIL2012 WTPIL2013

gen choice_occasions = 0
forvalues year = 2002/2013 {
    qui sum visits if year == `year', meanonly
    replace choice_occasions = r(sum) if year == `year'
}

sort siteid year

replace choice_occasions = choice_occasions / 4.5 
//new
local years 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013
foreach year of local years {
    bysort year: egen actual_days_`year'=total(visits) if ILsite == 1 & year == `year'
}

gen actual_days = 0
local years 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013
foreach year of local years {
    replace actual_days = actual_days_`year' if year == `year'
}

drop actual_days_2002 actual_days_2003 actual_days_2004 actual_days_2005 actual_days_2006 actual_days_2007 actual_days_2008 actual_days_2009 actual_days_2010 actual_days_2011 actual_days_2012 actual_days_2013

replace actual_days=actual_days/4.5
//new

collapse (mean)  WTPIL actual_days choice_occasions, by(year ILsite)
keep if ILsite == 1
gen aggvalueIL = WTPIL * choice_occasions
gen tripvalueIL = WTPIL * (choice_occasions / actual_days)

gen CPI=.
replace CPI=174.9 if year==2002
replace CPI=178.3 if year==2003
replace CPI=182.6 if year==2004
replace CPI=188.4 if year==2005
replace CPI=193 if year==2006
replace CPI=198.1 if year==2007
replace CPI=205.4 if year==2008
replace CPI=204.1 if year==2009
replace CPI=208.05 if year==2010
replace CPI=214.7 if year==2011
replace CPI=219.1 if year==2012
replace CPI=222.2 if year==2013
gen CPI2022=272.4013

gen aggvalue_adj=aggvalueIL*(CPI2022/CPI)
gen tripvalue_adj=tripvalueIL*(CPI2022/CPI)
stop

**# IN
local years 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013
foreach year of local years {
    egen total_sharevis_IN_`year' = total(share_vis) if INsite == 1 & year == `year'
    gen WTPIN`year' = -(ln(1 - total_sharevis_IN_`year')) / tccoefficient if INsite == 1 & year == `year'
}
list WTPIN2002 WTPIN2003 WTPIN2004 WTPIN2005 WTPIN2006 WTPIN2007 WTPIN2008 WTPIN2009 WTPIN2010 WTPIN2011 WTPIN2012 WTPIN2013

collapse (mean) INsite  visits share_vis tccoefficient WTPIN2002 WTPIN2003 WTPIN2004 WTPIN2005 WTPIN2006 WTPIN2007 WTPIN2008 WTPIN2009 WTPIN2010 WTPIN2011 WTPIN2012 WTPIN2013, by(siteid site year)

gen WTPIN = 0
local years 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013
foreach year of local years {
    replace WTPIN = WTPIN`year' if year == `year'
}

drop WTPIN2002 WTPIN2003 WTPIN2004 WTPIN2005 WTPIN2006 WTPIN2007 WTPIN2008 WTPIN2009 WTPIN2010 WTPIN2011 WTPIN2012 WTPIN2013

gen choice_occasions = 0
forvalues year = 2002/2013 {
    qui sum visits if year == `year', meanonly
    replace choice_occasions = r(sum) if year == `year'
}

sort siteid year

replace choice_occasions = choice_occasions / 4.5 

//new
local years 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013
foreach year of local years {
    bysort year: egen actual_days_`year'=total(visits) if INsite == 1 & year == `year'
}

gen actual_days = 0
local years 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013
foreach year of local years {
    replace actual_days = actual_days_`year' if year == `year'
}

drop actual_days_2002 actual_days_2003 actual_days_2004 actual_days_2005 actual_days_2006 actual_days_2007 actual_days_2008 actual_days_2009 actual_days_2010 actual_days_2011 actual_days_2012 actual_days_2013

replace actual_days=actual_days/4.5
//new

collapse (mean)  WTPIN actual_days choice_occasions, by(year INsite)
keep if INsite==1
gen aggvalueIN=WTPIN*choice_occasions
gen tripvalueIN=WTPIN*(choice_occasions/actual_days)


gen CPI=.
replace CPI=174.9 if year==2002
replace CPI=178.3 if year==2003
replace CPI=182.6 if year==2004
replace CPI=188.4 if year==2005
replace CPI=193 if year==2006
replace CPI=198.1 if year==2007
replace CPI=205.4 if year==2008
replace CPI=204.1 if year==2009
replace CPI=208.05 if year==2010
replace CPI=214.7 if year==2011
replace CPI=219.1 if year==2012
replace CPI=222.2 if year==2013
gen CPI2022=272.4013

gen aggvalue_adj=aggvalueIN*(CPI2022/CPI)
gen tripvalue_adj=tripvalueIN*(CPI2022/CPI)
stop

**# IN streams
local years 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013
foreach year of local years {
    egen total_sharevis_INstreams_`year' = total(share_vis) if INstreams == 1 & year == `year'
    gen WTPINstreams`year' = -(ln(1 - total_sharevis_INstreams_`year')) / tccoefficient if INstreams == 1 & year == `year'
}
list WTPINstreams2002 WTPINstreams2003 WTPINstreams2004 WTPINstreams2005 WTPINstreams2006 WTPINstreams2007 WTPINstreams2008 WTPINstreams2009 WTPINstreams2010 WTPINstreams2011 WTPINstreams2012 WTPINstreams2013

collapse (mean) INstreams  visits share_vis tccoefficient WTPINstreams2002 WTPINstreams2003 WTPINstreams2004 WTPINstreams2005 WTPINstreams2006 WTPINstreams2007 WTPINstreams2008 WTPINstreams2009 WTPINstreams2010 WTPINstreams2011 WTPINstreams2012 WTPINstreams2013, by(siteid site year)

gen WTPINstreams = 0
local years 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013
foreach year of local years {
    replace WTPINstreams = WTPINstreams`year' if year == `year'
}

drop WTPINstreams2002 WTPINstreams2003 WTPINstreams2004 WTPINstreams2005 WTPINstreams2006 WTPINstreams2007 WTPINstreams2008 WTPINstreams2009 WTPINstreams2010 WTPINstreams2011 WTPINstreams2012 WTPINstreams2013

gen choice_occasions = 0
forvalues year = 2002/2013 {
    qui sum visits if year == `year', meanonly
    replace choice_occasions = r(sum) if year == `year'
}

sort siteid year

replace choice_occasions = choice_occasions / 4.5 

//new
local years 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013
foreach year of local years {
    bysort year: egen actual_days_`year'=total(visits) if INstreams == 1 & year == `year'
}

gen actual_days = 0
local years 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013
foreach year of local years {
    replace actual_days = actual_days_`year' if year == `year'
}

drop actual_days_2002 actual_days_2003 actual_days_2004 actual_days_2005 actual_days_2006 actual_days_2007 actual_days_2008 actual_days_2009 actual_days_2010 actual_days_2011 actual_days_2012 actual_days_2013

replace actual_days=actual_days/4.5
//new

collapse (mean)  WTPINstreams actual_days choice_occasions, by(year INstreams)
keep if INstreams == 1
gen aggvalueINstreams = WTPINstreams * choice_occasions
gen tripvalueINstreams = WTPINstreams * (choice_occasions / actual_days)


gen CPI=.
replace CPI=174.9 if year==2002
replace CPI=178.3 if year==2003
replace CPI=182.6 if year==2004
replace CPI=188.4 if year==2005
replace CPI=193 if year==2006
replace CPI=198.1 if year==2007
replace CPI=205.4 if year==2008
replace CPI=204.1 if year==2009
replace CPI=208.05 if year==2010
replace CPI=214.7 if year==2011
replace CPI=219.1 if year==2012
replace CPI=222.2 if year==2013
gen CPI2022=272.4013

gen aggvalue_adj=aggvalueINstreams*(CPI2022/CPI)
gen tripvalue_adj=tripvalueINstreams*(CPI2022/CPI)




//chi
local years 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013
foreach year of local years {
    egen total_sharevis_chi_`year' = total(share_vis) if chicagosite == 1 & year == `year'
    gen WTPchi`year' = -(ln(1 - total_sharevis_chi_`year')) / tccoefficient if chicagosite == 1 & year == `year'
}
list WTPchi2002 WTPchi2003 WTPchi2004 WTPchi2005 WTPchi2006 WTPchi2007 WTPchi2008 WTPchi2009 WTPchi2010 WTPchi2011 WTPchi2012 WTPchi2013





//esttab using "C:\Users\Emma\Desktop\Fisheries RUM\Stage2Results.csv", cells(b & _star & se)
//eststo clear

//esttab using "C:\Users\Emma\Desktop\Fisheries RUM\Stage2Results.csv", cells(b & _star & se)
//eststo clear

*
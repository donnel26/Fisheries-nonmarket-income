**********************************************
*******Mean utilities from zonal RUM**********
**********************************************

//mean utilities
*********************2000*********************
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\2000.dta"
sort siteid year
tempfile meanutiltities2000
save `meanutiltities2000'

*********************2001*********************
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\2001.dta"
append using `meanutiltities2000'
sort siteid year
tempfile meanutiltities2001
save `meanutiltities2001'

*********************2002*********************
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\2002.dta"
append using `meanutiltities2001'
sort siteid year
tempfile meanutiltities2002
save `meanutiltities2002'

*********************2003*********************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\2003.dta"
append using `meanutiltities2002'
sort siteid year
tempfile meanutiltities2003
save `meanutiltities2003'

*********************2004*********************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\2004.dta"
append using `meanutiltities2003'
sort siteid year
tempfile meanutiltities2004
save `meanutiltities2004'

*********************2005*********************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\2005.dta"
append using `meanutiltities2004'
sort siteid year
tempfile meanutiltities2005
save `meanutiltities2005'

*********************2006*********************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\2006.dta"
append using `meanutiltities2005'
sort siteid year
tempfile meanutiltities2006
save `meanutiltities2006'

*********************2007*********************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\2007.dta"
append using `meanutiltities2006'
sort siteid year
tempfile meanutiltities2007
save `meanutiltities2007'

*********************2008*********************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\2008.dta"
append using `meanutiltities2007'
sort siteid year
tempfile meanutiltities2008
save `meanutiltities2008'

*********************2009*********************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\2009.dta"
append using `meanutiltities2008'
sort siteid year
tempfile meanutiltities2009
save `meanutiltities2009'

*********************2010*********************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\2010.dta"
append using `meanutiltities2009'
sort siteid year
tempfile meanutiltities2010
save `meanutiltities2010'

*********************2011*********************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\2011.dta"
append using `meanutiltities2010'
sort siteid year
tempfile meanutiltities2011
save `meanutiltities2011'

*********************2012*********************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\2012.dta"
append using `meanutiltities2011'
sort siteid year
tempfile meanutiltities2012
save `meanutiltities2012'

*********************2013*********************
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUM results\2013.dta"
append using `meanutiltities2012'
sort siteid year
tempfile meanutiltities2013
save `meanutiltities2013'
stop
**# Bookmark #1


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

egen fishID= group(fish)  // 1= trout and salmon, 2= yellow perch
drop if fishID==2
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
//drop if site== "AllIL"| site== "AllIN"| site== "AllINstreams"
poisson cr t t_sqr i.siteID if fishID==1, vce(robust) 
//regress cr c.year##c.year i.siteID if fishID==1 //impute missing harvest rates data
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
gen CRparam=b1+b2*t+b3*t_sqr

 
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
//collapse (mean) rho, by(site)
//collapse (mean) CRparam, by(site)
stop
********************************
*******Price & Income***********
********************************
sort year
rename Effort visits
replace visits=visits/4.5
egen choice_occasions = total(visits), by(site year)

gen p_jt=visits*(CRparam/rho)
gen income=p_jt*cr

collapse (mean) p_jt income CRparam, by(site year)
collapse (sum) p_jt income, by(year)


collapse (mean) p_jt income CRparam, by(site)
collapse (sum) p_jt income, by(site)
/////
gen p_jt=visits*(289.6375/0.0355797) // crparam/rho
gen income=p_jt*cr
collapse (mean) p_jt income CRparam, by(site year)
collapse (sum) p_jt income, by(year)

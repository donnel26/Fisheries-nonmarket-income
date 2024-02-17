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









##get rid of stuff after this probably##
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

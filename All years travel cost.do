*******************************
************2000***************
*******************************
*** First I import zip to site distances data 
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Fisheries RUM data.xlsx", sheet("distances") firstrow
destring, replace
tempfile distances
save `distances'

** Then I merge it with the 1999 income data. I convert time from minutes to hours. I save this for calculations.
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\angler archive data\Income1999.xlsx", sheet("Income1999") firstrow
destring, replace
merge m:m zip using `distances', keep(match)
drop _merge
gen timehours=timemins/60
** mean(medhhincome)==  43254.15
drop if medhhincome1999==0
rename Idsite siteid
tempfile income1999
save `income1999'

*** Then I do the same with the 2011 data
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Fisheries RUM data.xlsx", sheet("distances") firstrow
destring, replace
tempfile distances
save `distances'

*******************************
************2011***************
*******************************
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\angler archive data\Income2011.xlsx", sheet("Income2011") firstrow
destring, replace
merge m:m zip using `distances', keep(match)
drop _merge
gen timehours=timemins/60
** mean(medhhincome)== 53277.87
drop if medhhincome2011==0
rename Idsite siteid

** Then I merge this data with the 1999 data
merge 1:1 siteid zip using `income1999', keep(match)
drop _merge
replace distmiles=0 if siteid==99
replace timehours=0 if siteid==99

**because of lack of data available, I calculate med income assuming a linear change for years missing data**
gen medhhincome2000 = medhhincome1999 + 1 * (medhhincome2011 - medhhincome1999) / 12
gen medhhincome2001 = medhhincome1999 + 2 * (medhhincome2011 - medhhincome1999) / 12
gen medhhincome2002 = medhhincome1999 + 3 * (medhhincome2011 - medhhincome1999) / 12
gen medhhincome2003 = medhhincome1999 + 4 * (medhhincome2011 - medhhincome1999) / 12
gen medhhincome2004 = medhhincome1999 + 5 * (medhhincome2011 - medhhincome1999) / 12
gen medhhincome2005 = medhhincome1999 + 6 * (medhhincome2011 - medhhincome1999) / 12
gen medhhincome2006 = medhhincome1999 + 7 * (medhhincome2011 - medhhincome1999) / 12
gen medhhincome2007 = medhhincome1999 + 8 * (medhhincome2011 - medhhincome1999) / 12
gen medhhincome2008 = medhhincome1999 + 9 * (medhhincome2011 - medhhincome1999) / 12
gen medhhincome2009 = medhhincome1999 + 10 * (medhhincome2011 - medhhincome1999) / 12
gen medhhincome2010 = medhhincome1999 + 11 * (medhhincome2011 - medhhincome1999) / 12

tempfile medhhincome
save `medhhincome'

** Next I bring in the 2012 and 2013 income data and merge it to all the other data. So now I've got all income data together.
clear
import excel  "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\angler archive data\Income2012.xlsx", sheet("income2012") firstrow clear
merge m:m zip using `medhhincome', keep(match)
drop _merge
drop if zip==.
tempfile medhhincome2012
save `medhhincome2012'
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\angler archive data\Income2013.xlsx", sheet("Income2013") firstrow clear
merge m:m zip using `medhhincome2012', keep(match)
drop _merge
drop if zip==.

** Here I adjust for higher angler incomes.
// Define the starting year and the ending year
local start_year 1999
local end_year 2013
forvalues year = `start_year'/`end_year' {
    replace medhhincome`year' = medhhincome`year' * 1.42
}

* Then I generate time value
// Define the starting year and the ending year
local start_year 2000
local end_year 2013
forvalues year = `start_year'/`end_year' {
    gen timevalue`year' = (medhhincome`year' / 2080) * 0.5
}


// Define AAA driving costs for each year 
gen drivingcosts2000 = 0.2294
gen drivingcosts2001 = 0.2388
gen drivingcosts2002 = 0.259
gen drivingcosts2003 = 0.2776
gen drivingcosts2004 = 0.382
gen drivingcosts2005 = 0.387
gen drivingcosts2006 = 0.398
gen drivingcosts2007 = 0.392
gen drivingcosts2008 = 0.3153
gen drivingcosts2009 = 0.2386
gen drivingcosts2010 = 0.2542
gen drivingcosts2011 = 0.2716
gen drivingcosts2012 = 0.289
gen drivingcosts2013 = 0.3

// Calculate travel costs using the driving costs variable
gen travelcost2000 = 2 * ((drivingcosts2000 * distmiles) + (timevalue2000 * timehours))
gen travelcost2001 = 2 * ((drivingcosts2001 * distmiles) + (timevalue2001 * timehours))
gen travelcost2002 = 2 * ((drivingcosts2002 * distmiles) + (timevalue2002 * timehours))
gen travelcost2003 = 2 * ((drivingcosts2003 * distmiles) + (timevalue2003 * timehours))
gen travelcost2004 = 2 * ((drivingcosts2004 * distmiles) + (timevalue2004 * timehours))
gen travelcost2005 = 2 * ((drivingcosts2005 * distmiles) + (timevalue2005 * timehours))
gen travelcost2006 = 2 * ((drivingcosts2006 * distmiles) + (timevalue2006 * timehours))
gen travelcost2007 = 2 * ((drivingcosts2007 * distmiles) + (timevalue2007 * timehours))
gen travelcost2008 = 2 * ((drivingcosts2008 * distmiles) + (timevalue2008 * timehours))
gen travelcost2009 = 2 * ((drivingcosts2009 * distmiles) + (timevalue2009 * timehours))
gen travelcost2010 = 2 * ((drivingcosts2010 * distmiles) + (timevalue2010 * timehours))
gen travelcost2011 = 2 * ((drivingcosts2011 * distmiles) + (timevalue2011 * timehours))
gen travelcost2012 = 2 * ((drivingcosts2012 * distmiles) + (timevalue2012 * timehours))
gen travelcost2013 = 2 * ((drivingcosts2013 * distmiles) + (timevalue2013 * timehours))

sort siteid numberzone
// Define the starting year and the ending year
local start_year 2000
local end_year 2013

// Loop through the years and set travel costs to 0 for siteid == 99
forvalues year = `start_year'/`end_year' {
    replace travelcost`year' = 0 if siteid == 99
}

replace distmiles=0 if siteid == 99
// Define the starting year and ending year
local start_year 2000
local end_year 2013

// Loop to calculate means and store in a local macro
forvalues year = `start_year'/`end_year' {
    // Calculate mean for the current year excluding siteid 99 and 15
    quietly summarize travelcost`year' if siteid != 99 & siteid != 15
    local mean_value = r(mean)
    
    // Replace travelcost for siteid == 15 with the mean value
    replace travelcost`year' = `mean_value' if siteid == 15
}

**adjust travel costs all to 2023**
// Define CPI for each year
gen cpi2000 = 168.3083333
gen cpi2001 = 174.9
gen cpi2002 = 178.3
gen cpi2003 = 172.8
gen cpi2004 = 182.63
gen cpi2005 = 188.43
gen cpi2006 = 192.97
gen cpi2007 = 198.12
gen cpi2008 = 205.38
gen cpi2009 = 204.06
gen cpi2010 = 208.05
gen cpi2011 = 214.74
gen cpi2012 = 219.10
gen cpi2013 = 222.17
gen cpi2023 = 282.656 

// Adjust travel costs based on CPI
forvalues year = 2000/2013 {
    local cpi_value = cpi`year' // Store CPI value for the year
    replace travelcost`year' = travelcost`year' * (cpi2023 / `cpi_value')
}

// Calculate the mean of distmiles excluding siteid 99 and 15
summarize distmiles if siteid != 99 & siteid != 15
local mean_distmiles = r(mean)
// Replace distmiles for siteid 15 with the calculated mean
replace distmiles = `mean_distmiles' if siteid == 15


drop timemins timehours timevalue2000 timevalue2001 timevalue2002 timevalue2003 timevalue2004 timevalue2005 timevalue2006 timevalue2007 timevalue2008 timevalue2010 timevalue2009 timevalue2010 timevalue2011 timevalue2012 timevalue2013 cpi2000 cpi2001 cpi2002 cpi2003 cpi2004 cpi2005 cpi2006 cpi2007 cpi2008 cpi2009 cpi2010 cpi2011 cpi2012 cpi2013 cpi2023 drivingcosts2000 drivingcosts2001 drivingcosts2002 drivingcosts2003 drivingcosts2004 drivingcosts2005 drivingcosts2006 drivingcosts2007 drivingcosts2008 drivingcosts2009 drivingcosts2010 drivingcosts2011 drivingcosts2012 drivingcosts2013

tempfile TC
save `TC'

clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Fisheries RUM data.xlsx", sheet("fees") firstrow
merge 1:m siteid site using `TC'
drop _merge
sort siteid site

tempfile fees
save `fees'

merge m:1 siteid site using "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Effort and boater share effort.dta"
drop _merge
order siteid site numberzone zip
sort siteid site numberzone zip

//State indicators: (1) IN, (2) IL, (3) MI, (4) WI
gen zipstate=2 if zip>50000
replace zipstate=3 if zip==1
replace zipstate=4 if zip==2
replace zipstate=1 if zipstate==.

//State indicators: (1) IN, (2) IL, (0) Stay home
gen sitestate=1 if siteid == 1 | siteid == 2 | siteid == 3 | siteid == 4 | siteid == 16 | siteid == 17 | siteid == 18 
replace sitestate=2 if sitestate==.
replace sitestate=0 if siteid==99

//replace Other with mean for Belmont, McCormick, and Waukegan
// Calculate means for specified site IDs
egen mean_parking = mean(parking) if siteid == 5 | siteid == 10 | siteid == 14
egen mean_license_nonres = mean(daylicense_nonres) if siteid == 5 | siteid == 10 | siteid == 14
egen mean_launch = mean(launch) if siteid == 5 | siteid == 10 | siteid == 14

// Replace values for siteid == 15 using the calculated means
replace parking = mean_parking if siteid == 15
replace daylicense_nonres = mean_license_nonres if siteid == 15
replace launch = mean_launch if siteid == 15

// Clean up by dropping the mean variables
drop mean_parking mean_license_nonres mean_launch
 
//share boat effort
// Share boat effort for years 2000 to 2013
forvalues year = 2000/2013 {
    // Generate the launch variable for each year
    gen launch_`year' = launch * boateffort_share`year'
    
    // Replace missing values with 0
    replace launch_`year' = 0 if launch_`year' == .
}


foreach year in 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 {
    // Generate TC for the current year
    gen TC`year' = (travelcost`year' + launch_`year' + parking) if zipstate == 2 & sitestate == 2
    
    // From not IL zone to IL site
    replace TC`year' = (travelcost`year' + launch_`year' + parking + daylicense_nonres) if zipstate != 2 & sitestate == 2
    
    // From IN zone to IN site
    replace TC`year' = (travelcost`year' + launch_`year' + parking) if zipstate == 1 & sitestate == 1
    
    // From not IN zone to IN site
    replace TC`year' = (travelcost`year' + launch_`year' + parking + daylicense_nonres) if zipstate != 1 & sitestate == 1
    
    // Set TC to 0 for specific siteid
    replace TC`year' = 0 if siteid == 99
}


drop boateffort_share2000 boateffort_share2001 boateffort_share2002 boateffort_share2003 boateffort_share2004 boateffort_share2005 boateffort_share2006 boateffort_share2007 boateffort_share2008 boateffort_share2009 boateffort_share2010 boateffort_share2011 boateffort_share2012 boateffort_share2013  parking daylicense_nonres launch_2002 launch_2003 launch_2006 launch_2007 launch_2008 launch_2009 launch_2010 launch_2011 launch_2012 launch_2013 parking launch daylicense_res daylicense_nonres travelcost2003 travelcost2004 travelcost2005 travelcost2006 travelcost2007 travelcost2008 travelcost2009 travelcost2010 travelcost2011 travelcost2012 travelcost2013  launch_2004 launch_2005 medhhincome2013 medhhincome2012 medhhincome2011 medhhincome2005 medhhincome2006 medhhincome2007 medhhincome2008 medhhincome2009 medhhincome2010 travelcost2002  medhhincome2002 medhhincome2003 medhhincome2004 medhhincome1999 medhhincome2000 medhhincome2001 travelcost2000 travelcost2001 launch_2000 launch_2001







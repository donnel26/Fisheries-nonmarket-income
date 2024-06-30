clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\ALLilininstreamseffort.xlsx", sheet("Sheet1") firstrow
gen average = (Effort2011 + Effort2013) / 2 if site == "AllIN"
replace Effort2012 = average if site == "AllIN" & missing(Effort2012)
drop average
//reshape long Effort,i(site) j(year)
tempfile Alleffort 
save `Alleffort'

clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Travel costs.dta"
append using `Alleffort'
* Calculate INshare05 and INshare10 for "all sites"
preserve
keep if site=="AllIN" 
scalar INeffort2000 = Effort2000
scalar INeffort2001 = Effort2001
scalar INeffort2002 = Effort2002
scalar INeffort2003 = Effort2003
scalar INeffort2004 = Effort2004
scalar INeffort2005 = Effort2005
scalar INeffort2006 = Effort2006
scalar INeffort2007 = Effort2007
scalar INeffort2008 = Effort2008
scalar INeffort2009 = Effort2009
scalar INeffort2010 = Effort2010
scalar INeffort2011 = Effort2011
scalar INeffort2012 = Effort2012
scalar INeffort2013 = Effort2013
restore
gen INshare05 = Effort2005 / INeffort2005
gen INshare10 = Effort2010 / INeffort2010
preserve
keep if site=="AllIL" 
scalar ILeffort2000 = Effort2000
scalar ILeffort2001 = Effort2001
scalar ILeffort2002 = Effort2002
scalar ILeffort2003 = Effort2003
scalar ILeffort2004 = Effort2004
scalar ILeffort2005 = Effort2005
scalar ILeffort2006 = Effort2006
scalar ILeffort2007 = Effort2007
scalar ILeffort2008 = Effort2008
scalar ILeffort2009 = Effort2009
scalar ILeffort2010 = Effort2010
scalar ILeffort2011 = Effort2011
scalar ILeffort2012 = Effort2012
scalar ILeffort2013 = Effort2013
restore
gen ILshare03 = Effort2003 / ILeffort2003
gen ILshare04 = Effort2004 / ILeffort2004
gen ILshare05 = Effort2005 / ILeffort2005
gen ILshare06 = Effort2006 / ILeffort2006
gen ILshare07 = Effort2007 / ILeffort2007
gen ILshare08 = Effort2008 / ILeffort2008
gen ILshare09 = Effort2009 / ILeffort2009
gen ILshare10 = Effort2010 / ILeffort2010
gen ILshare11 = Effort2011 / ILeffort2011
gen ILshare12 = Effort2012 / ILeffort2012
gen ILshare13 = Effort2013 / ILeffort2013
preserve
keep if site== "AllINstreams"
scalar INstreamseffort2000 = Effort2000
scalar INstreamseffort2001 = Effort2001
scalar INstreamseffort2002 = Effort2002
scalar INstreamseffort2003 = Effort2003
scalar INstreamseffort2004 = Effort2004
scalar INstreamseffort2005 = Effort2005
scalar INstreamseffort2006 = Effort2006
scalar INstreamseffort2007 = Effort2007
scalar INstreamseffort2008 = Effort2008
scalar INstreamseffort2009 = Effort2009
scalar INstreamseffort2010 = Effort2010
scalar INstreamseffort2011 = Effort2011
scalar INstreamseffort2012 = Effort2012
scalar INstreamseffort2013 = Effort2013
restore
gen INstreamsshare05 = Effort2005 / INeffort2005
gen INstreamsshare10 = Effort2010 / INeffort2010
gen INstreamsshare11 = Effort2011 / INeffort2011
gen INstreamsshare12 = Effort2012 / INeffort2012

replace Effort2006=INeffort2006*(INshare05+(INshare10-INshare05)*(1/5)) if Effort2006==. & (site== "Burns Harbor" | site == "East Chicago" | site == "Hammond" | site == "Michigan City")
replace Effort2007=INeffort2007*(INshare05+(INshare10-INshare05)*(2/5)) if Effort2007==. & (site== "Burns Harbor" | site == "East Chicago" | site == "Hammond" | site == "Michigan City")
replace Effort2008=INeffort2008*(INshare05+(INshare10-INshare05)*(3/5)) if Effort2008==. & (site== "Burns Harbor" | site == "East Chicago" | site == "Hammond" | site == "Michigan City")
replace Effort2009=INeffort2009*(INshare05+(INshare10-INshare05)*(4/5)) if Effort2009==. & (site== "Burns Harbor" | site == "East Chicago" | site == "Hammond" | site == "Michigan City")
replace Effort2012=INeffort2012*(INshare05+(INshare10-INshare05)*(7/5)) if Effort2012==. & (site== "Burns Harbor" | site == "East Chicago" | site == "Hammond" | site == "Michigan City")
replace Effort2013=INeffort2013*(INshare05+(INshare10-INshare05)*(8/5)) if Effort2013==. & (site== "Burns Harbor" | site == "East Chicago" | site == "Hammond" | site == "Michigan City")

replace Effort2006=INstreamseffort2006*(INstreamsshare05+(INstreamsshare10-INstreamsshare05)*(1/5)) if Effort2006==. & (site== "Trail Creek" |site == "Little Calumet River"| site == "Salt Creek")
replace Effort2007=INstreamseffort2007*(INstreamsshare05+(INstreamsshare10-INstreamsshare05)*(2/5)) if Effort2007==. & (site == "Trail Creek" |site == "Little Calumet River"| site == "Salt Creek")
replace Effort2008=INstreamseffort2008*(INstreamsshare05+(INstreamsshare10-INstreamsshare05)*(3/5)) if Effort2008==. & (site == "Trail Creek" |site == "Little Calumet River"| site == "Salt Creek")
replace Effort2009=INstreamseffort2009*(INstreamsshare05+(INstreamsshare10-INstreamsshare05)*(4/5)) if Effort2009==. & (site == "Trail Creek" |site == "Little Calumet River"| site == "Salt Creek")
replace Effort2012=INstreamseffort2012*(INstreamsshare05+(INstreamsshare10-INstreamsshare05)*(7/5)) if Effort2012==. & (site == "Trail Creek" |site == "Little Calumet River"| site == "Salt Creek")
replace Effort2013=INstreamseffort2013*(INstreamsshare05+(INstreamsshare10-INstreamsshare05)*(8/5)) if Effort2013==. & ( site == "Trail Creek" |site == "Little Calumet River"| site == "Salt Creek")

replace Effort2000=ILeffort2000*(ILshare06*(1/7)) if Effort2000==. & site== "Belmont" 
replace Effort2001=ILeffort2001*(ILshare06*(2/7)) if Effort2001==. & site== "Belmont"
replace Effort2002=ILeffort2002*(ILshare06*(3/7)) if Effort2002==. & site== "Belmont"
replace Effort2003=ILeffort2003*(ILshare06*(4/7)) if Effort2003==. & site== "Belmont"
replace Effort2004=ILeffort2004*(ILshare06*(5/7)) if Effort2004==. & site== "Belmont"
replace Effort2005=ILeffort2005*(ILshare06*(6/7)) if Effort2005==. & site== "Belmont"

replace Effort2004=ILeffort2004*(ILshare03*(4/3)) if Effort2004==. & site== "Waukegan Powerplant"
replace Effort2005=ILeffort2005*(ILshare03*(5/3)) if Effort2005==. & site== "Waukegan Powerplant"
replace Effort2006=ILeffort2006*(ILshare03*(6/3)) if Effort2006==. & site== "Waukegan Powerplant"
replace Effort2007=ILeffort2007*(ILshare03*(7/3)) if Effort2007==. & site== "Waukegan Powerplant"
replace Effort2008=ILeffort2008*(ILshare03*(8/3)) if Effort2008==. & site== "Waukegan Powerplant"
replace Effort2009=ILeffort2009*(ILshare03*(9/3)) if Effort2009==. & site== "Waukegan Powerplant"
replace Effort2010=ILeffort2010*(ILshare03*(10/3)) if Effort2010==. & site== "Waukegan Powerplant"
replace Effort2011=ILeffort2011*(ILshare03*(11/3)) if Effort2011==. & site== "Waukegan Powerplant"
replace Effort2012=ILeffort2012*(ILshare03*(12/3)) if Effort2012==. & site== "Waukegan Powerplant"
replace Effort2013=ILeffort2013*(ILshare03*(13/3)) if Effort2013==. & site== "Waukegan Powerplant"

replace Effort2010=ILeffort2010*(ILshare09*(10/9)) if Effort2010==. & site== "Burnham"
replace Effort2011=ILeffort2011*(ILshare09*(11/9)) if Effort2011==. & site== "Burnham"
replace Effort2012=ILeffort2012*(ILshare09*(12/9)) if Effort2012==. & site== "Burnham"
replace Effort2013=ILeffort2013*(ILshare09*(13/9)) if Effort2013==. & site== "Burnham"

replace Effort2010=ILeffort2010*(ILshare09*(10/9)) if Effort2010==. & site== "McCormick"
replace Effort2011=ILeffort2011*(ILshare09*(11/9)) if Effort2011==. & site== "McCormick"
replace Effort2012=ILeffort2012*(ILshare09*(12/9)) if Effort2012==. & site== "McCormick"
replace Effort2013=ILeffort2013*(ILshare09*(13/9)) if Effort2013==. & site== "McCormick"

preserve
drop if site == "AllIN" 
drop if site == "AllIL" 
drop if site== "AllINstreams"
keep if zip==45053
replace Effort2000 = . if site == "Stay home"
replace Effort2001 = . if site == "Stay home"
replace Effort2002 = . if site == "Stay home"
replace Effort2003 = . if site == "Stay home"
replace Effort2004 = . if site == "Stay home"
replace Effort2005 = . if site == "Stay home"
replace Effort2006 = . if site == "Stay home"
replace Effort2007 = . if site == "Stay home"
replace Effort2008 = . if site == "Stay home"
replace Effort2009 = . if site == "Stay home"
replace Effort2010 = . if site == "Stay home"
replace Effort2011 = . if site == "Stay home"
replace Effort2012 = . if site == "Stay home"
replace Effort2013 = . if site == "Stay home"
collapse (mean) Effort2000 Effort2001 Effort2002 Effort2003 Effort2004 Effort2005 Effort2006 Effort2007 Effort2008 Effort2009 Effort2010 Effort2011 Effort2012 Effort2013, by(site)
collapse (sum) Effort2000 Effort2001 Effort2002 Effort2003 Effort2004 Effort2005 Effort2006 Effort2007 Effort2008 Effort2009 Effort2010 Effort2011 Effort2012 Effort2013
scalar totalEffort2000=Effort2000
scalar totalEffort2001=Effort2001
scalar totalEffort2002=Effort2002
scalar totalEffort2003=Effort2003
scalar totalEffort2004=Effort2004
scalar totalEffort2005=Effort2005
scalar totalEffort2006=Effort2006
scalar totalEffort2007=Effort2007
scalar totalEffort2008=Effort2008
scalar totalEffort2009=Effort2009
scalar totalEffort2010=Effort2001
scalar totalEffort2011=Effort2011
scalar totalEffort2012=Effort2012
scalar totalEffort2013=Effort2013
restore

//plot trends?
//reshape long Effort,i(site zip) j(year)
//keep if site== "Michigan City"
//scatter Effort year, title("Michigan City Effort Trend for 2000-2013") xtitle("Year") ytitle("Effort") mcolor(blue)

drop INshare05 INshare10 ILshare03 ILshare04 ILshare05 ILshare06 ILshare07 ILshare08 ILshare09 ILshare10 ILshare11 ILshare12 ILshare13 INstreamsshare05 INstreamsshare10 INstreamsshare11 INstreamsshare12
tempfile effort and tc
save `effort and tc'

clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Fisheries RUM data.xlsx", sheet("Pop 2000") firstrow

merge 1:m zip using `effort and tc', keep(match)
rename pop pop2000
drop _merge
sort siteid numberzone
tempfile pop 2000
save `pop 2000'

clear 
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Fisheries RUM data.xlsx", sheet("Pop 2010") firstrow
merge 1:m zip using `pop 2000', keep(match)
rename pop pop2010
drop _merge
sort siteid numberzone

gen pop2001 = pop2000 + 1 * (pop2010 - pop2000) / 10
gen pop2002 = pop2000 + 2 * (pop2010 - pop2000) / 10
gen pop2003 = pop2000 + 3 * (pop2010 - pop2000) / 10
gen pop2004 = pop2000 + 4 * (pop2010 - pop2000) / 10
gen pop2005 = pop2000 + 5 * (pop2010 - pop2000) / 10
gen pop2006 = pop2000 + 6 * (pop2010 - pop2000) / 10
gen pop2007 = pop2000 + 7 * (pop2010 - pop2000) / 10
gen pop2008 = pop2000 + 8 * (pop2010 - pop2000) / 10
gen pop2009 = pop2000 + 9 * (pop2010 - pop2000) / 10
tempfile pops
save `pops'

clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\angler archive data\pop2011.xlsx", sheet("pop2011") firstrow 
drop C D E F
merge m:m zip using `pops',keep(match)
drop _merge

drop if zip==.
tempfile pops2
save `pops2'

clear
import excel  "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\angler archive data\pop2012.xlsx", sheet("pop2012") firstrow 
merge m:m zip using `pops2', keep(match)
drop _merge
drop if zip==.
tempfile pops2
save `pops2'

clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\angler archive data\pop2013.xlsx", sheet("pop2013") firstrow 
merge m:m zip using `pops2', keep(match)
drop _merge
drop if zip==.


***exclude travel distance statistic if site not in IL
gen excluded=0
replace excluded=1 if site== "Burns Harbor" 
replace excluded=1 if site=="East Chicago" 
replace excluded=1 if site=="Hammond" 
replace excluded=1 if site=="Michigan City"
replace excluded=1 if site=="Stay home"
replace excluded=1 if site=="Other"
replace excluded=1 if site== "Little Calumet River" 
replace excluded=1 if site=="Salt Creek" 
replace excluded=1 if site=="Trail Creek" 

***replace WI and MI pops
replace pop2002 = pop2002 / 10 if zip == 1
replace pop2002 = pop2002 / 10 if zip == 2
replace pop2003 = pop2003 / 10 if zip == 1
replace pop2003 = pop2003 / 10 if zip == 2
replace pop2004 = pop2004 / 10 if zip == 1
replace pop2004 = pop2004 / 10 if zip == 2
replace pop2005 = pop2005 / 10 if zip == 1
replace pop2005 = pop2005 / 10 if zip == 2
replace pop2006 = pop2006 / 10 if zip == 1
replace pop2006 = pop2006 / 10 if zip == 2
replace pop2007 = pop2007 / 10 if zip == 1
replace pop2007 = pop2007 / 10 if zip == 2
replace pop2008 = pop2008 / 10 if zip == 1
replace pop2008 = pop2008 / 10 if zip == 2
replace pop2009 = pop2009 / 10 if zip == 1
replace pop2009 = pop2009 / 10 if zip == 2
replace pop2010 = pop2010 / 10 if zip == 1
replace pop2010 = pop2010 / 10 if zip == 2
replace pop2011 = pop2011 / 10 if zip == 1
replace pop2011 = pop2011 / 10 if zip == 2
replace pop2012 = pop2012 / 10 if zip == 1
replace pop2012 = pop2012 / 10 if zip == 2
replace pop2013 = pop2013 / 10 if zip == 1
replace pop2013 = pop2013 / 10 if zip == 2

gen stayhome=0
replace stayhome=1 if site== "Stay home"
replace Effort2000= totalEffort2000*2 if siteid==99
replace Effort2001= totalEffort2001*2 if siteid==99
replace Effort2002= totalEffort2002*2 if siteid==99
replace Effort2003= totalEffort2003*2 if siteid==99
replace Effort2004= totalEffort2004*2 if siteid==99
replace Effort2005= totalEffort2005*2 if siteid==99
replace Effort2006= totalEffort2006*2 if siteid==99
replace Effort2007= totalEffort2007*2 if siteid==99
replace Effort2008= totalEffort2008*2 if siteid==99
replace Effort2009= totalEffort2009*2 if siteid==99
replace Effort2010= totalEffort2010*2 if siteid==99
replace Effort2011= totalEffort2011*2 if siteid==99
replace Effort2012= totalEffort2012*2 if siteid==99
replace Effort2013= totalEffort2013*2 if siteid==99

tempfile data
save `data'
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\RUCA2010zipcode.xlsx", sheet("Data") firstrow
keep if STATE=="IL" | STATE=="IN"
rename ZIP_CODE zip
destring,replace
drop STATE ZIP_TYPE RUCA2
merge 1:m zip using `data'
drop if _merge==1
drop if zip>3 & RUCA1==.
drop _merge

sort siteid numberzone site zip
order siteid numberzone site zip
gen urban=0
gen rural=0
replace urban=1 if RUCA1<7
replace rural=1 if RUCA1>6 
replace urban=0 if zip==1
replace urban=0 if zip==2
replace rural=0 if zip==1
replace rural=0 if zip==2

replace pop2000=pop2000*0.85 if urban==1
replace pop2001=pop2001*0.85 if urban==1
replace pop2002=pop2002*0.85 if urban==1
replace pop2003=pop2003*0.85 if urban==1
replace pop2004=pop2004*0.85 if urban==1
replace pop2005=pop2005*0.85 if urban==1
replace pop2006=pop2006*0.85 if urban==1
replace pop2007=pop2007*0.85 if urban==1
replace pop2008=pop2008*0.85 if urban==1
replace pop2009=pop2009*0.85 if urban==1
replace pop2010=pop2010*0.85 if urban==1
replace pop2011=pop2011*0.85 if urban==1
replace pop2012=pop2012*0.85 if urban==1
replace pop2013=pop2013*0.85 if urban==1

replace pop2000=pop2000*1.6 if rural==1
replace pop2001=pop2001*1.6 if rural==1
replace pop2002=pop2002*1.6 if rural==1
replace pop2003=pop2003*1.6 if rural==1
replace pop2004=pop2004*1.6 if rural==1
replace pop2005=pop2005*1.6 if rural==1
replace pop2006=pop2006*1.6 if rural==1
replace pop2007=pop2007*1.6 if rural==1
replace pop2008=pop2008*1.6 if rural==1
replace pop2009=pop2009*1.6 if rural==1
replace pop2010=pop2010*1.6 if rural==1
replace pop2011=pop2011*1.6 if rural==1
replace pop2012=pop2012*1.6 if rural==1
replace pop2013=pop2013*1.6 if rural==1
stop
//saved as data for models .dta save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta", replace

clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta", clear
keep siteid numberzone site zip pop2000 distmiles Effort2000 zipstate sitestate TC2000 pop2000 excluded stayhome urban rural
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets  Revised\Model2000.dta", replace
***save as Model2000.dta
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta"
keep siteid numberzone site zip pop2001 distmiles Effort2001 zipstate sitestate TC2001 pop2001 excluded stayhome urban rural
***save as Model2001.dta
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2001.dta", replace
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta"
keep siteid numberzone site zip pop2002 distmiles Effort2002 zipstate sitestate TC2002 pop2002 excluded stayhome urban rural
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2002.dta", replace
***save as Model2002.dta
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta"
keep siteid numberzone site zip pop2003 distmiles Effort2003 zipstate sitestate TC2003 pop2003 excluded stayhome urban rural
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2003.dta", replace
***save as Model2003.dta
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta"
keep siteid numberzone site zip pop2004 distmiles Effort2004 zipstate sitestate TC2004 pop2004 excluded stayhome urban rural
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2004.dta", replace
***save as Model2004.dta
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta"
keep siteid numberzone site zip pop2005 distmiles Effort2005 zipstate sitestate TC2005 pop2005 excluded stayhome urban rural
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2005.dta", replace
***save as Model2005.dta
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta"
keep siteid numberzone site zip pop2006 distmiles Effort2006 zipstate sitestate TC2006 pop2006 excluded stayhome urban rural
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2006.dta", replace
***save as Model2006.dta
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta"
keep siteid numberzone site zip pop2007 distmiles Effort2007 zipstate sitestate TC2007 pop2007 excluded stayhome urban rural
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2007.dta", replace
***save as Model2007.dta
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta"
keep siteid numberzone site zip pop2008 distmiles Effort2008 zipstate sitestate TC2008 pop2008 excluded stayhome urban rural
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2008.dta", replace
***save as Model2008.dta
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta"
keep siteid numberzone site zip pop2009 distmiles Effort2009 zipstate sitestate TC2009 pop2009 excluded stayhome urban rural
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2009.dta", replace
***save as Model2009.dta
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta"
keep siteid numberzone site zip pop2010 distmiles Effort2010 zipstate sitestate TC2010 pop2010 excluded stayhome urban rural
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2010.dta", replace
***save as Model2010.dta
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta"
keep siteid numberzone site zip pop2011 distmiles Effort2011 zipstate sitestate TC2011 pop2011 excluded stayhome urban rural
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2011.dta", replace
***save as Model2011.dta
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta"
keep siteid numberzone site zip pop2012 distmiles Effort2012 zipstate sitestate TC2012 pop2012 excluded stayhome urban rural
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2012.dta", replace
***save as Model2012.dta
clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\data for models.dta"
keep siteid numberzone site zip pop2013 distmiles Effort2013 zipstate sitestate TC2013 pop2013 excluded stayhome urban rural
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Stata Data Sets Revised\Model2013.dta", replace
***save as Model2013.dta


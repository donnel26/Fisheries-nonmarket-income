**2000: travel cost=2*((0.2294*distance) + (timevalue*drivingtime))
**2010: travel cost=2*((0.2542*distance) + (timevalue*drivingtime))

*******************************
************2000***************
*******************************
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Fisheries RUM data.xlsx", sheet("distances") firstrow
destring, replace
tempfile distances
save `distances'

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

**adjust to 2023$**

tempfile medhhincome
save `medhhincome'

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

replace medhhincome1999=medhhincome1999*1.42
replace medhhincome2000=medhhincome2000*1.42
replace medhhincome2001=medhhincome2001*1.42
replace medhhincome2002=medhhincome2002*1.42
replace medhhincome2003=medhhincome2003*1.42
replace medhhincome2004=medhhincome2004*1.42
replace medhhincome2005=medhhincome2005*1.42
replace medhhincome2006=medhhincome2006*1.42
replace medhhincome2007=medhhincome2007*1.42
replace medhhincome2008=medhhincome2008*1.42
replace medhhincome2009=medhhincome2009*1.42
replace medhhincome2010=medhhincome2010*1.42
replace medhhincome2011=medhhincome2011*1.42
replace medhhincome2012=medhhincome2012*1.42
replace medhhincome2013=medhhincome2013*1.42


gen timevalue2000 = (medhhincome2000 / 2080) * 0.5
gen timevalue2001 = (medhhincome2001 / 2080) * 0.5
gen timevalue2002 = (medhhincome2002 / 2080) * 0.5
gen timevalue2003 = (medhhincome2003 / 2080) * 0.5
gen timevalue2004 = (medhhincome2004 / 2080) * 0.5
gen timevalue2005 = (medhhincome2005 / 2080) * 0.5
gen timevalue2006 = (medhhincome2006 / 2080) * 0.5
gen timevalue2007 = (medhhincome2007 / 2080) * 0.5
gen timevalue2008 = (medhhincome2008 / 2080) * 0.5
gen timevalue2009 = (medhhincome2009 / 2080) * 0.5
gen timevalue2010 = (medhhincome2010 / 2080) * 0.5
gen timevalue2011 = (medhhincome2011 / 2080) * 0.5
gen timevalue2012 = (medhhincome2012 / 2080) * 0.5
gen timevalue2013 = (medhhincome2013 / 2080) * 0.5

gen travelcost2000 = 2 * ((0.2294 * distmiles) + (timevalue2000 * timehours))
gen travelcost2001 = 2 * ((0.2388 * distmiles) + (timevalue2001 * timehours))
gen travelcost2002 = 2 * ((0.259 * distmiles) + (timevalue2002 * timehours))
gen travelcost2003 = 2 * ((0.2776 * distmiles) + (timevalue2003 * timehours))
gen travelcost2004 = 2 * ((0.382 * distmiles) + (timevalue2004 * timehours))
gen travelcost2005 = 2 * ((0.387 * distmiles) + (timevalue2005 * timehours))
gen travelcost2006 = 2 * ((0.398 * distmiles) + (timevalue2006 * timehours))
gen travelcost2007 = 2 * ((0.392 * distmiles) + (timevalue2007 * timehours))
gen travelcost2008 = 2 * ((0.3153 * distmiles) + (timevalue2008 * timehours))
gen travelcost2009 = 2 * ((0.2386 * distmiles) + (timevalue2009 * timehours))
gen travelcost2010 = 2 * ((0.2542 * distmiles) + (timevalue2010 * timehours))
gen travelcost2011 = 2 * ((0.2716 * distmiles) + (timevalue2011 * timehours))
gen travelcost2012 = 2 * ((0.289 * distmiles) + (timevalue2012 * timehours))
gen travelcost2013 = 2 * ((0.3 * distmiles) + (timevalue2013 * timehours))

sort siteid numberzone

replace travelcost2000 = 0 if siteid == 99
replace travelcost2001 = 0 if siteid == 99
replace travelcost2002 = 0 if siteid == 99
replace travelcost2003 = 0 if siteid == 99
replace travelcost2004 = 0 if siteid == 99
replace travelcost2005 = 0 if siteid == 99
replace travelcost2006 = 0 if siteid == 99
replace travelcost2007 = 0 if siteid == 99
replace travelcost2008 = 0 if siteid == 99
replace travelcost2009 = 0 if siteid == 99
replace travelcost2010 = 0 if siteid == 99
replace travelcost2011 = 0 if siteid == 99
replace travelcost2012 = 0 if siteid == 99
replace travelcost2013 = 0 if siteid == 99

replace distmiles=0 if siteid == 99

mean(travelcost2000) if siteid != 99 & siteid != 15
mean(travelcost2001) if siteid != 99 & siteid != 15
mean(travelcost2002) if siteid != 99 & siteid != 15
mean(travelcost2003) if siteid != 99 & siteid != 15
mean(travelcost2004) if siteid != 99 & siteid != 15
mean(travelcost2005) if siteid != 99 & siteid != 15
mean(travelcost2006) if siteid != 99 & siteid != 15
mean(travelcost2007) if siteid != 99 & siteid != 15
mean(travelcost2008) if siteid != 99 & siteid != 15
mean(travelcost2009) if siteid != 99 & siteid != 15
mean(travelcost2010) if siteid != 99 & siteid != 15
mean(travelcost2011) if siteid != 99 & siteid != 15
mean(travelcost2012) if siteid != 99 & siteid != 15
mean(travelcost2013) if siteid != 99 & siteid != 15

replace travelcost2000=  168.5077 if siteid==15
replace travelcost2001= 173.5946  if siteid==15
replace travelcost2002=  182.6317 if siteid==15
replace travelcost2003= 191.0836 if siteid==15
replace travelcost2004= 230.9173 if siteid==15
replace travelcost2005= 234.3949  if siteid==15
replace travelcost2006= 240.067 if siteid==15
replace travelcost2007= 239.5213  if siteid==15
replace travelcost2008= 213.1165 if siteid==15
replace travelcost2009= 186.7118 if siteid==15
replace travelcost2010= 194.0664 if siteid==15
replace travelcost2011= 202.0793 if siteid==15
replace travelcost2012= 208.8689 if siteid==15
replace travelcost2013= 212.7614 if siteid==15

**adjust travel costs all to 2023**
replace travelcost2000= travelcost2000*(282.656/168.3083333)
replace travelcost2001= travelcost2001*(282.656/174.9)
replace travelcost2002= travelcost2002*(282.656/178.3)
replace travelcost2003= travelcost2003*(282.656/172.8)
replace travelcost2004= travelcost2004*(282.656/182.63)
replace travelcost2005= travelcost2005*(282.656/188.43)
replace travelcost2006= travelcost2006*(282.656/192.97)
replace travelcost2007= travelcost2007*(282.656/198.12)
replace travelcost2008= travelcost2008*(282.656/205.38)
replace travelcost2009= travelcost2009*(282.656/204.06)
replace travelcost2010= travelcost2010*(282.656/208.05)
replace travelcost2011= travelcost2011*(282.656/214.74)
replace travelcost2012= travelcost2012*(282.656/219.10)
replace travelcost2013= travelcost2013*(282.656/222.17)


mean(distmiles) if siteid != 99 & siteid != 15
replace distmiles=  182.8783 if siteid==15

drop timemins timehours timevalue2000 timevalue2001 timevalue2002 timevalue2003 timevalue2004 timevalue2005 timevalue2006 timevalue2007 timevalue2008 timevalue2010 timevalue2009 timevalue2010 timevalue2011 timevalue2012 timevalue2013

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
*egen mean_parking = mean(parking) if siteid == 5 | siteid == 10 | siteid == 14
*egen mean_license_nonres = mean(daylicense_nonres) if siteid == 5 | siteid == 10 | siteid == 14
*egen mean_launch = mean(launch) if siteid == 5 | siteid == 10 | siteid == 14
replace parking=10.83333 if siteid==15
replace daylicense_nonres=10.5 if siteid==15
replace launch=19.33333 if siteid==15
*drop mean_parking mean_license_nonres mean_launch

//share boat effort
gen launch_2000= launch*boateffort_share2000
gen launch_2001= launch*boateffort_share2001
gen launch_2002= launch*boateffort_share2002
gen launch_2003= launch*boateffort_share2003
gen launch_2004= launch*boateffort_share2004
gen launch_2005= launch*boateffort_share2005
gen launch_2006= launch*boateffort_share2006
gen launch_2007= launch*boateffort_share2007
gen launch_2008= launch*boateffort_share2008
gen launch_2009= launch*boateffort_share2009
gen launch_2010= launch*boateffort_share2010
gen launch_2011= launch*boateffort_share2011
gen launch_2012= launch*boateffort_share2012
gen launch_2013= launch*boateffort_share2013
replace launch_2000=0 if launch_2000==.
replace launch_2001=0 if launch_2001==.
replace launch_2002=0 if launch_2002==.
replace launch_2003=0 if launch_2003==.
replace launch_2004=0 if launch_2004==.
replace launch_2005=0 if launch_2005==.
replace launch_2006=0 if launch_2006==.
replace launch_2007=0 if launch_2007==.
replace launch_2008=0 if launch_2008==.
replace launch_2009=0 if launch_2009==.
replace launch_2010=0 if launch_2010==.
replace launch_2011=0 if launch_2011==.
replace launch_2012=0 if launch_2012==.
replace launch_2013=0 if launch_2013==.

******************
******2000********
******************
//From IL zone to IL site
gen TC2000=(travelcost2000+launch_2000+parking) if zipstate==2 & sitestate==2
//From not IL zone to IL site
replace TC2000=(travelcost2000+launch_2000+parking+daylicense_nonres) if zipstate!=2 & sitestate==2

//From IN zone to IN site
replace TC2000=(travelcost2000+launch_2000+parking) if zipstate==1 & sitestate==1
//From not IN zone to IN site
replace TC2000=(travelcost2000+launch_2000+parking+daylicense_nonres) if zipstate!=1 & sitestate==1

replace TC2000=0 if siteid==99

******************
******2001********
******************
//From IL zone to IL site
gen TC2001=(travelcost2001+launch_2001+parking) if zipstate==2 & sitestate==2
//From not IL zone to IL site
replace TC2001=(travelcost2001+launch_2001+parking+daylicense_nonres) if zipstate!=2 & sitestate==2

//From IN zone to IN site
replace TC2001=(travelcost2001+launch_2001+parking) if zipstate==1 & sitestate==1
//From not IN zone to IN site
replace TC2001=(travelcost2001+launch_2001+parking+daylicense_nonres) if zipstate!=1 & sitestate==1

replace TC2001=0 if siteid==99

******************
******2002********
******************
//From IL zone to IL site
gen TC2002=(travelcost2002+launch_2002+parking) if zipstate==2 & sitestate==2
//From not IL zone to IL site
replace TC2002=(travelcost2002+launch_2002+parking+daylicense_nonres) if zipstate!=2 & sitestate==2

//From IN zone to IN site
replace TC2002=(travelcost2002+launch_2002+parking) if zipstate==1 & sitestate==1
//From not IN zone to IN site
replace TC2002=(travelcost2002+launch_2002+parking+daylicense_nonres) if zipstate!=1 & sitestate==1

replace TC2002=0 if siteid==99

******************
******2003********
******************
// From IL zone to IL site
gen TC2003 = (travelcost2003 + launch_2003 + parking) if zipstate == 2 & sitestate == 2
// From not IL zone to IL site
replace TC2003 = (travelcost2003 + launch_2003 + parking + daylicense_nonres) if zipstate != 2 & sitestate == 2

// From IN zone to IN site
replace TC2003 = (travelcost2003 + launch_2003 + parking) if zipstate == 1 & sitestate == 1
// From not IN zone to IN site
replace TC2003 = (travelcost2003 + launch_2003 + parking + daylicense_nonres) if zipstate != 1 & sitestate == 1

replace TC2003 = 0 if siteid == 99

******************
******2004********
******************
// From IL zone to IL site
gen TC2004 = (travelcost2004 + launch_2004 + parking) if zipstate == 2 & sitestate == 2
// From not IL zone to IL site
replace TC2004 = (travelcost2004 + launch_2004 + parking + daylicense_nonres) if zipstate != 2 & sitestate == 2

// From IN zone to IN site
replace TC2004 = (travelcost2004 + launch_2004 + parking) if zipstate == 1 & sitestate == 1
// From not IN zone to IN site
replace TC2004 = (travelcost2004 + launch_2004 + parking + daylicense_nonres) if zipstate != 1 & sitestate == 1

replace TC2004 = 0 if siteid == 99

******************
******2005********
******************
// From IL zone to IL site
gen TC2005 = (travelcost2005 + launch_2005 + parking) if zipstate == 2 & sitestate == 2
// From not IL zone to IL site
replace TC2005 = (travelcost2005 + launch_2005 + parking + daylicense_nonres) if zipstate != 2 & sitestate == 2

// From IN zone to IN site
replace TC2005 = (travelcost2005 + launch_2005 + parking) if zipstate == 1 & sitestate == 1
// From not IN zone to IN site
replace TC2005 = (travelcost2005 + launch_2005 + parking + daylicense_nonres) if zipstate != 1 & sitestate == 1

replace TC2005 = 0 if siteid == 99

******************
******2006********
******************
// From IL zone to IL site
gen TC2006 = (travelcost2006 + launch_2006 + parking) if zipstate == 2 & sitestate == 2
// From not IL zone to IL site
replace TC2006 = (travelcost2006 + launch_2006 + parking + daylicense_nonres) if zipstate != 2 & sitestate == 2

// From IN zone to IN site
replace TC2006 = (travelcost2006 + launch_2006 + parking) if zipstate == 1 & sitestate == 1
// From not IN zone to IN site
replace TC2006 = (travelcost2006 + launch_2006 + parking + daylicense_nonres) if zipstate != 1 & sitestate == 1

replace TC2006 = 0 if siteid == 99

******************
******2007********
******************
// From IL zone to IL site
gen TC2007 = (travelcost2007 + launch_2007 + parking) if zipstate == 2 & sitestate == 2
// From not IL zone to IL site
replace TC2007 = (travelcost2007 + launch_2007 + parking + daylicense_nonres) if zipstate != 2 & sitestate == 2

// From IN zone to IN site
replace TC2007 = (travelcost2007 + launch_2007 + parking) if zipstate == 1 & sitestate == 1
// From not IN zone to IN site
replace TC2007 = (travelcost2007 + launch_2007 + parking + daylicense_nonres) if zipstate != 1 & sitestate == 1

replace TC2007 = 0 if siteid == 99

******************
******2008********
******************
// From IL zone to IL site
gen TC2008 = (travelcost2008 + launch_2008 + parking) if zipstate == 2 & sitestate == 2
// From not IL zone to IL site
replace TC2008 = (travelcost2008 + launch_2008 + parking + daylicense_nonres) if zipstate != 2 & sitestate == 2

// From IN zone to IN site
replace TC2008 = (travelcost2008 + launch_2008 + parking) if zipstate == 1 & sitestate == 1
// From not IN zone to IN site
replace TC2008 = (travelcost2008 + launch_2008 + parking + daylicense_nonres) if zipstate != 1 & sitestate == 1

replace TC2008 = 0 if siteid == 99

******************
******2009********
******************
// From IL zone to IL site
gen TC2009 = (travelcost2009 + launch_2009 + parking) if zipstate == 2 & sitestate == 2
// From not IL zone to IL site
replace TC2009 = (travelcost2009 + launch_2009 + parking + daylicense_nonres) if zipstate != 2 & sitestate == 2

// From IN zone to IN site
replace TC2009 = (travelcost2009 + launch_2009 + parking) if zipstate == 1 & sitestate == 1
// From not IN zone to IN site
replace TC2009 = (travelcost2009 + launch_2009 + parking + daylicense_nonres) if zipstate != 1 & sitestate == 1

replace TC2009 = 0 if siteid == 99

******************
******2010********
******************
// From IL zone to IL site
gen TC2010 = (travelcost2010 + launch_2010 + parking) if zipstate == 2 & sitestate == 2
// From not IL zone to IL site
replace TC2010 = (travelcost2010 + launch_2010 + parking + daylicense_nonres) if zipstate != 2 & sitestate == 2

// From IN zone to IN site
replace TC2010 = (travelcost2010 + launch_2010 + parking) if zipstate == 1 & sitestate == 1
// From not IN zone to IN site
replace TC2010 = (travelcost2010 + launch_2010 + parking + daylicense_nonres) if zipstate != 1 & sitestate == 1

replace TC2010 = 0 if siteid == 99

******************
******2011********
******************
// From IL zone to IL site
gen TC2011 = (travelcost2011 + launch_2011 + parking) if zipstate == 2 & sitestate == 2
// From not IL zone to IL site
replace TC2011 = (travelcost2011 + launch_2011 + parking + daylicense_nonres) if zipstate != 2 & sitestate == 2

// From IN zone to IN site
replace TC2011 = (travelcost2011 + launch_2011 + parking) if zipstate == 1 & sitestate == 1
// From not IN zone to IN site
replace TC2011 = (travelcost2011 + launch_2011 + parking + daylicense_nonres) if zipstate != 1 & sitestate == 1

replace TC2011 = 0 if siteid == 99

******************
******2012********
******************
// From IL zone to IL site
gen TC2012 = (travelcost2012 + launch_2012 + parking) if zipstate == 2 & sitestate == 2
// From not IL zone to IL site
replace TC2012 = (travelcost2012 + launch_2012 + parking + daylicense_nonres) if zipstate != 2 & sitestate == 2

// From IN zone to IN site
replace TC2012 = (travelcost2012 + launch_2012 + parking) if zipstate == 1 & sitestate == 1
// From not IN zone to IN site
replace TC2012 = (travelcost2012 + launch_2012 + parking + daylicense_nonres) if zipstate != 1 & sitestate == 1

replace TC2012 = 0 if siteid == 99

******************
******2013********
******************
// From IL zone to IL site
gen TC2013 = (travelcost2013 + launch_2013 + parking) if zipstate == 2 & sitestate == 2
// From not IL zone to IL site
replace TC2013 = (travelcost2013 + launch_2013 + parking + daylicense_nonres) if zipstate != 2 & sitestate == 2

// From IN zone to IN site
replace TC2013 = (travelcost2013 + launch_2013 + parking) if zipstate == 1 & sitestate == 1
// From not IN zone to IN site
replace TC2013 = (travelcost2013 + launch_2013 + parking + daylicense_nonres) if zipstate != 1 & sitestate == 1

replace TC2013 = 0 if siteid == 99


drop boateffort_share2000 boateffort_share2001 boateffort_share2002 boateffort_share2003 boateffort_share2004 boateffort_share2005 boateffort_share2006 boateffort_share2007 boateffort_share2008 boateffort_share2009 boateffort_share2010 boateffort_share2011 boateffort_share2012 boateffort_share2013  parking daylicense_nonres launch_2002 launch_2003 launch_2006 launch_2007 launch_2008 launch_2009 launch_2010 launch_2011 launch_2012 launch_2013 parking launch daylicense_res daylicense_nonres travelcost2003 travelcost2004 travelcost2005 travelcost2006 travelcost2007 travelcost2008 travelcost2009 travelcost2010 travelcost2011 travelcost2012 travelcost2013  launch_2004 launch_2005 medhhincome2013 medhhincome2012 medhhincome2011 medhhincome2005 medhhincome2006 medhhincome2007 medhhincome2008 medhhincome2009 medhhincome2010 travelcost2002  medhhincome2002 medhhincome2003 medhhincome2004 medhhincome1999 medhhincome2000 medhhincome2001 travelcost2000 travelcost2001 launch_2000 launch_2001







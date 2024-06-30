**********************************************
**************harvest rate data*****************
**********************************************
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Fisheries RUM data.xlsx", sheet("Harvest Rate") firstrow clear 
rename Site site
rename Fish fish
egen fish_id = group(fish)
sort fish_id
tempfile HR
save `HR'

clear 
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Fisheries RUM data.xlsx", sheet("Harvest") firstrow 
tempfile harvest
save `harvest'
clear
import excel "C:\Users\donnel26\OneDrive - purdue.edu\Fisheries RUM\Angler Archive Data\Angler Archive Effort all years.xlsx", sheet("Effort") firstrow
merge 1:m site using `harvest'
sort siteid site fish
drop R S T U V _merge
egen fish_id = group(fish)
sort fish_id
tempfile Effort
save `Effort'
clear 
import excel "C:\Users\donnel26\OneDrive - purdue.edu\Fisheries RUM\ALLilininstreamseffort.xlsx", sheet("Sheet1") firstrow clear 
merge m:m site using `Effort'

/// Gen Effort All IN/IL/IN streams

**gen harvest rate with harvest and effort data**
gen HR0=Harvest2000/Effort2000
gen HR1=Harvest2001/Effort2001
gen HR2=Harvest2002/Effort2002 
gen HR3=Harvest2003/Effort2003 
gen HR4=Harvest2004/Effort2004
gen HR5=Harvest2005/Effort2005
gen HR6=Harvest2006/Effort2006
gen HR7=Harvest2007/Effort2007
gen HR8=Harvest2008/Effort2008
gen HR9=Harvest2009/Effort2009
gen HR10=Harvest2010/Effort2010
gen HR11=Harvest2011/Effort2011
gen HR12=Harvest2012/Effort2012
gen HR13=Harvest2013/Effort2013
drop Effort2000 Effort2001 Effort2003 Effort2002 Effort2004 Effort2005 Effort2006 Effort2007 Effort2008 Effort2009 Effort2010 Effort2011 Effort2012 Effort2013 Harvest2000 Harvest2001 Harvest2002 Harvest2003 Harvest2004 Harvest2005 Harvest2006 Harvest2007 Harvest2008 Harvest2009 Harvest2010 Harvest2011 Harvest2012 Harvest2013 _merge

merge 1:1 site fish using `HR'
tempfile HR and Harvest Rate
tempfile 
save `HR and Harvest Rate'

replace HarvestRate2000=HR0 if HarvestRate2000==.
replace HarvestRate2001=HR1 if HarvestRate2001==.
replace HarvestRate2002=HR2 if HarvestRate2002==.
replace HarvestRate2003=HR3 if HarvestRate2003==.
replace HarvestRate2004=HR4 if HarvestRate2004==.
replace HarvestRate2005=HR5 if HarvestRate2005==.
replace HarvestRate2006=HR6 if HarvestRate2006==.
replace HarvestRate2007=HR7 if HarvestRate2007==.
replace HarvestRate2008=HR8 if HarvestRate2008==.
gen HarvestRate2009=HR9
replace HarvestRate2010=HR10 if HarvestRate2010==.
replace HarvestRate2011=HR11 if HarvestRate2011==.
replace HarvestRate2012=HR12 if HarvestRate2012==.
replace HarvestRate2013=HR13 if HarvestRate2013==.
drop HR0 HR1 HR2 HR3 HR4 HR5 HR6 HR7 HR9 HR8 HR9 HR10 HR11 HR12 HR13
drop _merge

gen perchHarvestRate0=HarvestRate2000 if fish_id== 2
gen troutsalmonHarvestRate0=HarvestRate2000 if fish_id== 1
gen perchHarvestRate1=HarvestRate2001 if fish_id== 2
gen troutsalmonHarvestRate1=HarvestRate2001 if fish_id== 1
gen perchHarvestRate2=HarvestRate2002 if fish_id== 2
gen troutsalmonHarvestRate2=HarvestRate2002 if fish_id== 1
gen perchHarvestRate3=HarvestRate2003 if fish_id== 2
gen troutsalmonHarvestRate3=HarvestRate2003 if fish_id== 1
gen perchHarvestRate4=HarvestRate2004 if fish_id== 2
gen troutsalmonHarvestRate4=HarvestRate2004 if fish_id== 1
gen perchHarvestRate5=HarvestRate2005 if fish_id== 2
gen troutsalmonHarvestRate5=HarvestRate2005 if fish_id== 1
gen perchHarvestRate6=HarvestRate2006 if fish_id== 2
gen troutsalmonHarvestRate6=HarvestRate2006 if fish_id== 1
gen perchHarvestRate7=HarvestRate2007 if fish_id== 2
gen troutsalmonHarvestRate7=HarvestRate2007 if fish_id== 1
gen perchHarvestRate8=HarvestRate2008 if fish_id== 2
gen troutsalmonHarvestRate8=HarvestRate2008 if fish_id== 1
gen perchHarvestRate9=HarvestRate2009 if fish_id== 2
gen troutsalmonHarvestRate9=HarvestRate2009 if fish_id== 1
gen perchHarvestRate10=HarvestRate2010 if fish_id== 2
gen troutsalmonHarvestRate10=HarvestRate2010 if fish_id== 1
gen perchHarvestRate11=HarvestRate2011 if fish_id== 2
gen troutsalmonHarvestRate11=HarvestRate2011 if fish_id== 1
gen perchHarvestRate12=HarvestRate2012 if fish_id== 2
gen troutsalmonHarvestRate12=HarvestRate2012 if fish_id== 1
gen perchHarvestRate13=HarvestRate2013 if fish_id== 2
gen troutsalmonHarvestRate13=HarvestRate2013 if fish_id== 1

drop HarvestRate2000 HarvestRate2001 HarvestRate2002 HarvestRate2003 HarvestRate2004 HarvestRate2005 HarvestRate2006 HarvestRate2007 HarvestRate2008 HarvestRate2010 HarvestRate2011 HarvestRate2012 HarvestRate2013 HarvestRate2009

drop fish_id fish
//Replace with all
//State indicators: 
gen INsite=1 if siteid == 7 | siteid == 2 | siteid == 3 | siteid == 4  
replace INsite=0 if INsite==.
replace INsite=0 if siteid == 99
gen INstreams=1 if siteid == siteid == 16 | siteid == 17 | siteid == 18 
replace INstreams=0 if INstream==.
replace INstreams=1 if siteid==16
replace INstreams=0 if siteid == 99
gen ILsite=1 if siteid == siteid == 5 | siteid == 6 | siteid == 1 | siteid == 5 | siteid == 8 | siteid == 9 | siteid == 10 | siteid == 11 | siteid == 15 | siteid == 14 | siteid == 13 | siteid == 12
replace IL=0 if IL==.
replace IL=0 if siteid == 99

replace perchHarvestRate0=.2444853 if perchHarvestRate0==. & ILsite==1
replace perchHarvestRate0=0.6187657 if perchHarvestRate0==. & INsite==1
replace perchHarvestRate0= 0 if perchHarvestRate0==.

replace troutsalmonHarvestRate0= .1396064 if troutsalmonHarvestRate0==. & ILsite==1
replace troutsalmonHarvestRate0= 0.3164891 if troutsalmonHarvestRate0==. & INsite==1
replace troutsalmonHarvestRate0= 0.110459 if troutsalmonHarvestRate0==. & INstreams==1
replace troutsalmonHarvestRate0= 0 if troutsalmonHarvestRate0==. 

replace perchHarvestRate1= .7302174 if perchHarvestRate1==. & ILsite==1
replace perchHarvestRate1= 0.58824 if perchHarvestRate1==. & INsite==1
replace perchHarvestRate1=0 if perchHarvestRate1==.

replace troutsalmonHarvestRate1= .1789444 if troutsalmonHarvestRate1==. & ILsite==1
replace troutsalmonHarvestRate1= 0.2511555 if troutsalmonHarvestRate1==. & INsite==1
replace troutsalmonHarvestRate1= 0.1072484 if troutsalmonHarvestRate1==. & INstreams==1
replace troutsalmonHarvestRate1= 0 if troutsalmonHarvestRate1==. 

replace perchHarvestRate2= 0.7649524 if perchHarvestRate2==. & ILsite==1
replace perchHarvestRate2= 0.500322 if perchHarvestRate2==. & INsite==1
replace perchHarvestRate2= 0 if perchHarvestRate2==.

replace troutsalmonHarvestRate2= 0.1958462 if troutsalmonHarvestRate2==. & ILsite==1
replace troutsalmonHarvestRate2= 0.3409119 if troutsalmonHarvestRate2==. & INsite==1
replace troutsalmonHarvestRate2= 0.0990381 if troutsalmonHarvestRate2==. & INstreams==1
replace troutsalmonHarvestRate2= 0 if troutsalmonHarvestRate2==.

replace perchHarvestRate3= 0.5215715 if perchHarvestRate3==. & ILsite==1
replace perchHarvestRate3= 0.6082854 if perchHarvestRate3==. & INsite==1
replace perchHarvestRate3= 0 if perchHarvestRate3==.

replace troutsalmonHarvestRate3= 0.1007349 if troutsalmonHarvestRate3==. & ILsite==1
replace troutsalmonHarvestRate3= 0.1998123 if troutsalmonHarvestRate3==. & INsite==1
replace troutsalmonHarvestRate3= 0 if troutsalmonHarvestRate3==. 

replace perchHarvestRate4= 0.5342329 if perchHarvestRate4==. & ILsite==1
replace perchHarvestRate4= 0.600668 if perchHarvestRate4==. & INsite==1
replace perchHarvestRate4= 0 if perchHarvestRate4==. 

replace troutsalmonHarvestRate4=0.0945128 if troutsalmonHarvestRate4==. & ILsite==1
replace troutsalmonHarvestRate4= 0.1465317 if troutsalmonHarvestRate4==. & INsite==1
replace troutsalmonHarvestRate4= 0 if troutsalmonHarvestRate4==.

replace perchHarvestRate5=0.6501945 if perchHarvestRate5==. & ILsite==1
replace perchHarvestRate5= 0.9520922 if perchHarvestRate5==.  & INsite==1
replace perchHarvestRate5= 0 if perchHarvestRate5==. 

replace troutsalmonHarvestRate5=0.1241471 if troutsalmonHarvestRate5==. & ILsite==1
replace troutsalmonHarvestRate5=0.1857873 if troutsalmonHarvestRate5==. & INsite==1
replace troutsalmonHarvestRate5=0.1117356 if troutsalmonHarvestRate5==. & INstreams==1
replace troutsalmonHarvestRate5=0 if troutsalmonHarvestRate5==.

replace perchHarvestRate6=0.4998158 if perchHarvestRate6==. & ILsite==1
replace perchHarvestRate6=1.139993 if perchHarvestRate6==. & INsite==1
replace perchHarvestRate6=0.0036818 if perchHarvestRate6==. & INstreams==1
replace perchHarvestRate6=0 if perchHarvestRate6==. 

replace troutsalmonHarvestRate6= 0.1013371 if troutsalmonHarvestRate6==. & ILsite==1
replace troutsalmonHarvestRate6=0.1524761 if troutsalmonHarvestRate6==. & INsite==1
replace troutsalmonHarvestRate6=0.1303521 if troutsalmonHarvestRate6==. & INstreams==1
replace troutsalmonHarvestRate6=0 if troutsalmonHarvestRate6==.

replace perchHarvestRate7=0.5408148 if perchHarvestRate7==. & ILsite==1
replace perchHarvestRate7=0.6621963 if perchHarvestRate7==. & INsite==1
replace perchHarvestRate7=0.0031564 if perchHarvestRate7==. & INstreams==1
replace perchHarvestRate7=0 if perchHarvestRate7==. 

replace troutsalmonHarvestRate7=0.1152143 if troutsalmonHarvestRate7==. & ILsite==1
replace troutsalmonHarvestRate7=0.1719574 if troutsalmonHarvestRate7==. & INsite==1
replace troutsalmonHarvestRate7=0.0910838 if troutsalmonHarvestRate7==. & INstreams==1
replace troutsalmonHarvestRate7=0 if troutsalmonHarvestRate7==. 

replace perchHarvestRate8=0.4690588 if perchHarvestRate8==. & ILsite==1
replace perchHarvestRate8=0.5054309 if perchHarvestRate8==. & INsite==1
replace perchHarvestRate8=0.0011317 if perchHarvestRate8==. & INstreams==1
replace perchHarvestRate8=0 if perchHarvestRate8==.

replace troutsalmonHarvestRate8=0.1125513 if troutsalmonHarvestRate8==. & ILsite==1
replace troutsalmonHarvestRate8=0.2218675 if troutsalmonHarvestRate8==. & INsite==1
replace troutsalmonHarvestRate8=0.103739 if troutsalmonHarvestRate8==. & INstreams==1
replace troutsalmonHarvestRate8=0 if troutsalmonHarvestRate8==.

replace perchHarvestRate9=0.4961316 if perchHarvestRate9==. & ILsite==1
replace perchHarvestRate9=1.06523 if perchHarvestRate9==. & INsite==1
replace perchHarvestRate9=0.0036167 if perchHarvestRate9==. & INstreams==1
replace perchHarvestRate9=0 if perchHarvestRate9==.

replace troutsalmonHarvestRate9=0.0532506 if troutsalmonHarvestRate9==. & ILsite==1
replace troutsalmonHarvestRate9=0.2230854 if troutsalmonHarvestRate9==.  & INsite==1
replace troutsalmonHarvestRate9=0.1381674 if troutsalmonHarvestRate9==.  & INstreams==1
replace troutsalmonHarvestRate9=0 if troutsalmonHarvestRate9==.

replace perchHarvestRate10=0.3580404 if perchHarvestRate10==. & ILsite==1
replace perchHarvestRate10=1.5 if perchHarvestRate10==. & INsite==1
replace perchHarvestRate10=0 if perchHarvestRate10==.

replace troutsalmonHarvestRate10=0.0866639 if troutsalmonHarvestRate10==. & ILsite==1
replace troutsalmonHarvestRate10=0.1696442 if troutsalmonHarvestRate10==. & INsite==1
replace troutsalmonHarvestRate10=0.1 if troutsalmonHarvestRate10==. & INstreams==1
replace troutsalmonHarvestRate10=0 if troutsalmonHarvestRate10==.

replace perchHarvestRate11=0.1549472 if perchHarvestRate11==.  & ILsite==1
replace perchHarvestRate11=0.7909091  if perchHarvestRate11==. & INsite==1
replace perchHarvestRate11=0.0027722  if perchHarvestRate11==. & INstreams==1
replace perchHarvestRate11=0  if perchHarvestRate11==.

replace troutsalmonHarvestRate11=0.1169463 if troutsalmonHarvestRate11==. & ILsite==1
replace troutsalmonHarvestRate11=0.1669597 if troutsalmonHarvestRate11==. & INsite==1
replace troutsalmonHarvestRate11=0.1843 if troutsalmonHarvestRate11==. & INstreams==1
replace troutsalmonHarvestRate11=0 if troutsalmonHarvestRate11==. 

replace perchHarvestRate12= 0.1982854 if perchHarvestRate12==. & ILsite==1
replace perchHarvestRate12= 0 if perchHarvestRate12==.

replace troutsalmonHarvestRate12=0.1537997 if troutsalmonHarvestRate12==. & ILsite==1
replace troutsalmonHarvestRate12=0.1102504  if troutsalmonHarvestRate12==. & INstreams==1
replace troutsalmonHarvestRate12=0  if troutsalmonHarvestRate12==.

replace perchHarvestRate13=0.1388833 if perchHarvestRate1==. & ILsite==1
replace perchHarvestRate13=0.0019804 if perchHarvestRate1==. & INsite==1
replace perchHarvestRate13=0 if perchHarvestRate1==.

replace troutsalmonHarvestRate13=0.1406773 if troutsalmonHarvestRate13==. & ILsite==1
replace troutsalmonHarvestRate13=0.2569875 if troutsalmonHarvestRate13==. & INsite==1
replace troutsalmonHarvestRate13=0.11485 if troutsalmonHarvestRate13==. & INstreams==1
replace troutsalmonHarvestRate13=0 if troutsalmonHarvestRate13==.

stop
*replace missing with 0*
replace perchHarvestRate0=0 if perchHarvestRate0==.
replace troutsalmonHarvestRate0=0 if troutsalmonHarvestRate0==.
replace perchHarvestRate1 = 0 if perchHarvestRate1 == .
replace troutsalmonHarvestRate1 = 0 if troutsalmonHarvestRate1 == .
replace perchHarvestRate2 = 0 if perchHarvestRate2 == .
replace troutsalmonHarvestRate2 = 0 if troutsalmonHarvestRate2 == .
replace perchHarvestRate3 = 0 if perchHarvestRate3 == .
replace troutsalmonHarvestRate3 = 0 if troutsalmonHarvestRate3 == .
replace perchHarvestRate4 = 0 if perchHarvestRate4 == .
replace troutsalmonHarvestRate4 = 0 if troutsalmonHarvestRate4 == .
replace perchHarvestRate5 = 0 if perchHarvestRate5 == .
replace troutsalmonHarvestRate5 = 0 if troutsalmonHarvestRate5 == .
replace perchHarvestRate6 = 0 if perchHarvestRate6 == .
replace troutsalmonHarvestRate6 = 0 if troutsalmonHarvestRate6 == .
replace perchHarvestRate7 = 0 if perchHarvestRate7 == .
replace troutsalmonHarvestRate7 = 0 if troutsalmonHarvestRate7 == .
replace perchHarvestRate8 = 0 if perchHarvestRate8 == .
replace troutsalmonHarvestRate8 = 0 if troutsalmonHarvestRate8 == .
replace perchHarvestRate9 = 0 if perchHarvestRate9 == .
replace troutsalmonHarvestRate9 = 0 if troutsalmonHarvestRate9 == .
replace perchHarvestRate10 = 0 if perchHarvestRate10 == .
replace troutsalmonHarvestRate10 = 0 if troutsalmonHarvestRate10 == .
replace perchHarvestRate11 = 0 if perchHarvestRate11 == .
replace troutsalmonHarvestRate11 = 0 if troutsalmonHarvestRate11 == .
replace perchHarvestRate12 = 0 if perchHarvestRate12 == .
replace troutsalmonHarvestRate12 = 0 if troutsalmonHarvestRate12 == .
replace perchHarvestRate13 = 0 if perchHarvestRate13 == .
replace troutsalmonHarvestRate13 = 0 if troutsalmonHarvestRate13 == .
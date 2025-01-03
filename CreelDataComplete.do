* Import and clean 2000 data
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2000") firstrow clear
rename site Site
rename Effort2000 Total_Effort
rename BoatEffort2000 Boat_Effort
rename ShoreEffort2000 Shore_Effort
rename YellowPerch_Harvest_2000 YellowPerch_Harvest
rename TroutandSalmonHarvest_2000 Salmon_Harvest
rename YellowPerch_HarvestRate_2000 YellowPerch_Harvest_Rate
rename TroutandSalmonHarvestRate_2000 Salmon_Harvest_Rate
gen BrownTrout_Harvest = .
gen RainbowTrout_Harvest = .
gen LakeTrout_Harvest = .
gen CohoSalmon_Harvest = .
gen ChinookSalmon_Harvest = .
gen Year = 2000
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2000.dta", replace

* Import and clean 2001 data
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2001") firstrow clear
rename site Site
rename Effort2001 Total_Effort
rename BoatEffort2001 Boat_Effort
rename ShoreEffort2001 Shore_Effort
rename YellowPerch_Harvest_2001 YellowPerch_Harvest
rename TroutandSalmonHarvest_2001 Salmon_Harvest
rename YellowPerch_HarvestRate_2001 YellowPerch_Harvest_Rate
rename TroutandSalmonHarvestRate_2001 Salmon_Harvest_Rate
gen Year = 2001
gen BrownTrout_Harvest = .
gen RainbowTrout_Harvest = .
gen LakeTrout_Harvest = .
gen CohoSalmon_Harvest = .
gen ChinookSalmon_Harvest = .
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2001.dta", replace

* Import and clean 2002 data
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2002") firstrow clear
rename site Site
rename Effort2002 Total_Effort
rename BoatEffort2002 Boat_Effort
rename ShoreEffort2002 Shore_Effort
rename YellowPerch_Harvest_2002 YellowPerch_Harvest
rename TroutandSalmonHarvest_2002 Salmon_Harvest
rename YellowPerch_HarvestRate_2002 YellowPerch_Harvest_Rate
rename TroutandSalmonHarvestRate_2002 Salmon_Harvest_Rate
gen Year = 2002
gen BrownTrout_Harvest = .
gen RainbowTrout_Harvest = .
gen LakeTrout_Harvest = .
gen CohoSalmon_Harvest = .
gen ChinookSalmon_Harvest = .
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2002.dta", replace

* Import and clean 2003 data
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2003") firstrow clear
rename site Site
rename Effort2003 Total_Effort
rename BoatEffort2003 Boat_Effort
rename ShoreEffort2003 Shore_Effort
rename YellowPerch_Harvest_2003 YellowPerch_Harvest
rename TroutandSalmonHarvest_2003 Salmon_Harvest
rename YellowPerch_HarvestRate_2003 YellowPerch_Harvest_Rate
rename TroutandSalmonHarvestRate_2003 Salmon_Harvest_Rate
gen Year = 2003
gen BrownTrout_Harvest = .
gen RainbowTrout_Harvest = .
gen LakeTrout_Harvest = .
gen CohoSalmon_Harvest = .
gen ChinookSalmon_Harvest = .

save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2003.dta", replace

* Import and clean 2004 data
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2004") firstrow clear
rename site Site
rename Effort2004 Total_Effort
rename BoatEffort2004 Boat_Effort
rename ShoreEffort2004 Shore_Effort
rename YellowPerch_Harvest_2004 YellowPerch_Harvest
rename TroutandSalmonHarvest_2004 Salmon_Harvest
rename YellowPerch_HarvestRate_2004 YellowPerch_Harvest_Rate
rename TroutandSalmonHarvestRate_2004 Salmon_Harvest_Rate
gen Year = 2004
gen BrownTrout_Harvest = .
gen RainbowTrout_Harvest = .
gen LakeTrout_Harvest = .
gen CohoSalmon_Harvest = .
gen ChinookSalmon_Harvest = .

save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2004.dta", replace

* Import and clean 2005 data
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2005") firstrow clear
rename site Site
rename Effort2005 Total_Effort
rename BoatEffort2005 Boat_Effort
rename ShoreEffort2005 Shore_Effort
rename YellowPerch_Harvest_2005 YellowPerch_Harvest
rename TroutandSalmonHarvest_2005 Salmon_Harvest
rename YellowPerch_HarvestRate_2005 YellowPerch_Harvest_Rate
rename TroutandSalmonHarvestRate_2005 Salmon_Harvest_Rate
gen Year = 2005
gen BrownTrout_Harvest = .
gen RainbowTrout_Harvest = .
gen LakeTrout_Harvest = .
gen CohoSalmon_Harvest = .
gen ChinookSalmon_Harvest = .

save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2005.dta", replace

* Import and clean 2006 data
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2006") firstrow clear
rename site Site
rename Effort2006 Total_Effort
rename BoatEffort2006 Boat_Effort
rename ShoreEffort2006 Shore_Effort
rename YellowPerch_Harvest_2006 YellowPerch_Harvest
rename TroutandSalmonHarvest_2006 Salmon_Harvest
rename YellowPerch_HarvestRate_2006 YellowPerch_Harvest_Rate
rename TroutandSalmonHarvestRate_2006 Salmon_Harvest_Rate
gen Year = 2006
gen BrownTrout_Harvest = .
gen RainbowTrout_Harvest = .
gen LakeTrout_Harvest = .
gen CohoSalmon_Harvest = .
gen ChinookSalmon_Harvest = .

save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2006.dta", replace

* Import and clean 2007 data
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2007") firstrow clear
rename site Site
rename Effort2007 Total_Effort
rename BoatEffort2007 Boat_Effort
rename ShoreEffort2007 Shore_Effort
rename YellowPerch_Harvest_2007 YellowPerch_Harvest
rename TroutandSalmonHarvest_2007 Salmon_Harvest
rename YellowPerch_HarvestRate_2007 YellowPerch_Harvest_Rate
rename TroutandSalmonHarvestRate_2007 Salmon_Harvest_Rate
gen Year = 2007
gen BrownTrout_Harvest = .
gen RainbowTrout_Harvest = .
gen LakeTrout_Harvest = .
gen CohoSalmon_Harvest = .
gen ChinookSalmon_Harvest = .

save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2007.dta", replace

* Import and clean 2008 data
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2008") firstrow clear
rename site Site
rename Effort2008 Total_Effort
rename BoatEffort2008 Boat_Effort
rename ShoreEffort2008 Shore_Effort
rename YellowPerch_Harvest_2008 YellowPerch_Harvest
rename TroutandSalmonHarvest_2008 Salmon_Harvest
rename YellowPerch_HarvestRate_2008 YellowPerch_Harvest_Rate
rename TroutandSalmonHarvestRate_2008 Salmon_Harvest_Rate
gen Year = 2008
gen BrownTrout_Harvest = .
gen RainbowTrout_Harvest = .
gen LakeTrout_Harvest = .
gen CohoSalmon_Harvest = .
gen ChinookSalmon_Harvest = .

save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2008.dta", replace


* Import and clean 2009 data
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2009") firstrow clear
rename site Site
rename Effort2009 Total_Effort
rename BoatEffort2009 Boat_Effort
rename ShoreEffort2009 Shore_Effort
rename YellowPerch_Harvest_2009 YellowPerch_Harvest
rename TroutandSalmonHarvest_2009 Salmon_Harvest
gen BrownTrout_Harvest = .
gen RainbowTrout_Harvest = .
gen LakeTrout_Harvest = .
gen CohoSalmon_Harvest = .
gen ChinookSalmon_Harvest = .

gen Year = 2009
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2009.dta", replace

* Import and clean 2010 data
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2010") firstrow clear
rename site Site
rename Effort2010 Total_Effort
rename BoatEffort2010 Boat_Effort
rename ShoreEffort2010 Shore_Effort
rename YellowPerch_Harvest_2010 YellowPerch_Harvest
rename TroutandSalmonHarvest_2010 Salmon_Harvest
rename YellowPerch_HarvestRate_2010 YellowPerch_Harvest_Rate
rename TroutandSalmonHarvestRate_2010 Salmon_Harvest_Rate
gen Year = 2010
gen BrownTrout_Harvest = .
gen RainbowTrout_Harvest = .
gen LakeTrout_Harvest = .
gen CohoSalmon_Harvest = .
gen ChinookSalmon_Harvest = .

save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2010.dta", replace

* Import and clean 2011 data
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2011") firstrow clear
rename site Site
rename Effort2011 Total_Effort
rename BoatEffort2011 Boat_Effort
rename ShoreEffort2011 Shore_Effort
rename YellowPerch_Harvest_2011 YellowPerch_Harvest
rename TroutandSalmonHarvest_2011 Salmon_Harvest
rename YellowPerch_HarvestRate_2011 YellowPerch_Harvest_Rate
rename TroutandSalmonHarvestRate_2011 Salmon_Harvest_Rate
gen Year = 2011
gen BrownTrout_Harvest = .
gen RainbowTrout_Harvest = .
gen LakeTrout_Harvest = .
gen CohoSalmon_Harvest = .
gen ChinookSalmon_Harvest = .

save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2011.dta", replace

* Import and clean 2012 data
clear
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2012") firstrow clear
rename site Site
rename Effort2012 Total_Effort
rename BoatEffort2012 Boat_Effort
rename ShoreEffort2012 Shore_Effort
rename YellowPerch_Harvest_2012 YellowPerch_Harvest
rename TroutandSalmonHarvest_2012 Salmon_Harvest
gen BrownTrout_Harvest = .
gen RainbowTrout_Harvest = .
gen LakeTrout_Harvest = .
gen CohoSalmon_Harvest = .
gen ChinookSalmon_Harvest = .

gen Year = 2012
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2012.dta", replace

* Import and clean 2013 data
//clear
//import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", //sheet("2013") firstrow clear
//rename site Site
//rename Effort2013 Total_Effort
//rename BoatEffort2013 Boat_Effort
//rename ShoreEffort2013 Shore_Effort
//rename YellowPerch_Harvest_2013 YellowPerch_Harvest
//rename TroutandSalmonHarvest_2013 Salmon_Harvest
//rename YellowPerch_HarvestRate_2013 YellowPerch_Harvest_Rate
//rename TroutandSalmonHarvestRate_2013 Salmon_Harvest_Rate
//gen year = 2013
//save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2013.dta", replace

* Combine all cleaned datasets
clear
append using ///
    "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2000.dta" ///
    "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2001.dta" ///
    "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2002.dta" ///
    "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2003.dta" ///
    "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2004.dta" ///
    "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2005.dta" ///
    "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2006.dta" ///
    "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2007.dta" ///
    "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2008.dta" ///
    "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2009.dta" ///
    "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2010.dta" ///
    "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2011.dta" ///
    "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2012.dta" ///
   // "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Cleaned_2013.dta"
drop J K H I
drop if missing(Site)
* Save combined dataset
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Combined_2000_2012.dta", replace
stop
// Clear any existing data in memory

clear
// Load the data for 2013 and process it
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2013") firstrow clear
gen Year = 2013 // Add a year column
rename (Total_Effort_2013 YellowPerch_Effort_2013 Salmon_Effort_2013 YellowPerch_Harvest_2013 RainbowTrout_Harvest_2013 LakeTrout_Harvest_2013 CohoSalmon_Harvest_2013 ChinookSalmon_Harvest_2013 BrownTrout_Harvest_2013) ///
(Total_Effort YellowPerch_Effort Salmon_Effort YellowPerch_Harvest RainbowTrout_Harvest LakeTrout_Harvest CohoSalmon_Harvest ChinookSalmon_Harvest BrownTrout_Harvest)
drop L
gen Boat_Effort = .
gen Shore_Effort = .
replace Boat_Effort = Total_Effort if Angler_Type == "Boat"
replace Shore_Effort = Total_Effort if Angler_Type == "Peds"
drop Angler_Type

tempfile temp_2013
save `temp_2013', replace

// Clear any existing data in memory
clear
// Load the data for 2014 and process it
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2014") firstrow clear
gen Year = 2014 // Add a year column
rename (Total_Effort_2014 YellowPerch_Effort_2014 Salmon_Effort_2014 YellowPerch_Harvest_2014 RainbowTrout_Harvest_2014 LakeTrout_Harvest_2014 CohoSalmon_Harvest_2014 ChinookSalmon_Harvest_2014 BrownTrout_Harvest_2014) ///
(Total_Effort YellowPerch_Effort Salmon_Effort YellowPerch_Harvest RainbowTrout_Harvest LakeTrout_Harvest CohoSalmon_Harvest ChinookSalmon_Harvest BrownTrout_Harvest)
gen Boat_Effort = .
gen Shore_Effort = .
replace Boat_Effort = Total_Effort if Angler_Type == "Boat"
replace Shore_Effort = Total_Effort if Angler_Type == "Peds"
drop Angler_Type

append using `temp_2013'

// Save the 2014 data as a temporary file
tempfile temp_2014
save `temp_2014', replace

// Append the data for 2015
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2015") firstrow clear
gen Year = 2015 // Add a year column for 2015
rename (Total_Effort_2015 YellowPerch_Effort_2015 Salmon_Effort_2015 YellowPerch_Harvest_2015 RainbowTrout_Harvest_2015 LakeTrout_Harvest_2015 CohoSalmon_Harvest_2015 ChinookSalmon_Harvest_2015 BrownTrout_Harvest_2015 ) ///
(Total_Effort YellowPerch_Effort Salmon_Effort YellowPerch_Harvest RainbowTrout_Harvest LakeTrout_Harvest CohoSalmon_Harvest ChinookSalmon_Harvest BrownTrout_Harvest)
gen Boat_Effort = .
gen Shore_Effort = .
replace Boat_Effort = Total_Effort if Angler_Type == "Boat"
replace Shore_Effort = Total_Effort if Angler_Type == "Peds"
drop Angler_Type


// Append 2015 data to the temporary 2014 dataset
append using `temp_2014'

// Save the combined dataset for 2014 and 2015 as a temporary file
tempfile temp_2014_2015
save `temp_2014_2015', replace

// Append the data for 2016
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2016") firstrow clear
gen Year = 2016 // Add a year column for 2016
rename (Total_Effort_2016 YellowPerch_Effort_2016 Salmon_Effort_2016 YellowPerch_Harvest_2016 RainbowTrout_Harvest_2016 LakeTrout_Harvest_2016 CohoSalmon_Harvest_2016 ChinookSalmon_Harvest_2016 BrownTrout_Harvest_2016  ) ///
(Total_Effort YellowPerch_Effort Salmon_Effort YellowPerch_Harvest RainbowTrout_Harvest LakeTrout_Harvest CohoSalmon_Harvest ChinookSalmon_Harvest BrownTrout_Harvest)
gen Boat_Effort = .
gen Shore_Effort = .
replace Boat_Effort = Total_Effort if Angler_Type == "Boat"
replace Shore_Effort = Total_Effort if Angler_Type == "Peds"
drop Angler_Type

// Append 2016 data to the temporary dataset (2014 and 2015)
append using `temp_2014_2015'

// Save the combined dataset for 2014 to 2016 as a temporary file
tempfile temp_2014_2016
save `temp_2014_2016', replace

// Append the data for 2017
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2017") firstrow clear
gen Year = 2017 // Add a year column for 2017
rename (Total_Effort_2017 YellowPerch_Effort_2017 Salmon_Effort_2017 YellowPerch_Harvest_2017 RainbowTrout_Harvest_2017 LakeTrout_Harvest_2017 CohoSalmon_Harvest_2017 ChinookSalmon_Harvest_2017 BrownTrout_Harvest_2017) ///
(Total_Effort YellowPerch_Effort Salmon_Effort YellowPerch_Harvest RainbowTrout_Harvest LakeTrout_Harvest CohoSalmon_Harvest ChinookSalmon_Harvest BrownTrout_Harvest)
gen Boat_Effort = .
gen Shore_Effort = .
replace Boat_Effort = Total_Effort if Angler_Type == "Boat"
replace Shore_Effort = Total_Effort if Angler_Type == "Peds"
drop Angler_Type


// Append 2017 data to the temporary dataset (2014 to 2016)
append using `temp_2014_2016'

// Save the combined dataset for 2014 to 2017 as a temporary file
tempfile temp_2014_2017
save `temp_2014_2017', replace

// Append the data for 2018
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2018") firstrow clear
gen Year = 2018 // Add a year column for 2018
rename (Total_Effort_2018 YellowPerch_Effort_2018 Salmon_Effort_2018 YellowPerch_Harvest_2018 RainbowTrout_Harvest_2018 LakeTrout_Harvest_2018 CohoSalmon_Harvest_2018 ChinookSalmon_Harvest_2018 BrownTrout_Harvest_2018) ///
(Total_Effort YellowPerch_Effort Salmon_Effort YellowPerch_Harvest RainbowTrout_Harvest LakeTrout_Harvest CohoSalmon_Harvest ChinookSalmon_Harvest BrownTrout_Harvest) 
gen Boat_Effort = .
gen Shore_Effort = .
replace Boat_Effort = Total_Effort if Angler_Type == "Boat"
replace Shore_Effort = Total_Effort if Angler_Type == "Peds"
drop Angler_Type

// Append 2018 data to the temporary dataset (2014 to 2017)
append using `temp_2014_2017'

// Save the combined dataset for 2014 to 2018 as a temporary file
tempfile temp_2014_2018
save `temp_2014_2018', replace

// Append the data for 2019
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2019") firstrow clear
gen Year = 2019 // Add a year column for 2019
rename (Total_Effort_2019 YellowPerch_Effort_2019 Salmon_Effort_2019 YellowPerch_Harvest_2019 RainbowTrout_Harvest_2019 LakeTrout_Harvest_2019 CohoSalmon_Harvest_2019 ChinookSalmon_Harvest_2019 BrownTrout_Harvest_2019) ///
(Total_Effort YellowPerch_Effort Salmon_Effort YellowPerch_Harvest RainbowTrout_Harvest LakeTrout_Harvest CohoSalmon_Harvest ChinookSalmon_Harvest BrownTrout_Harvest)
gen Boat_Effort = .
gen Shore_Effort = .
replace Boat_Effort = Total_Effort if Angler_Type == "Boat"
replace Shore_Effort = Total_Effort if Angler_Type == "Peds"
drop Angler_Type

// Append 2019 data to the temporary dataset (2014 to 2018)
append using `temp_2014_2018'

// Save the combined dataset for 2014 to 2019 as a temporary file
tempfile temp_2014_2019
save `temp_2014_2019', replace

// Append the data for 2020
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2020") firstrow clear
gen Year = 2020 // Add a year column for 2020
rename (Total_Effort_2020 YellowPerch_Effort_2020 Salmon_Effort_2020 YellowPerch_Harvest_2020 RainbowTrout_Harvest_2020 LakeTrout_Harvest_2020 CohoSalmon_Harvest_2020 ChinookSalmon_Harvest_2020 BrownTrout_Harvest_2020) ///
(Total_Effort YellowPerch_Effort Salmon_Effort YellowPerch_Harvest RainbowTrout_Harvest LakeTrout_Harvest CohoSalmon_Harvest ChinookSalmon_Harvest BrownTrout_Harvest)
gen Boat_Effort = .
gen Shore_Effort = .
replace Boat_Effort = Total_Effort if Angler_Type == "Boat"
replace Shore_Effort = Total_Effort if Angler_Type == "Peds"
drop Angler_Type

// Append 2020 data to the temporary dataset (2014 to 2019)
append using `temp_2014_2019'

// Save the combined dataset for 2014 to 2020 as a temporary file
tempfile temp_2014_2020
save `temp_2014_2020', replace

// Append the data for 2021
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2021") firstrow clear
gen Year = 2021 // Add a year column for 2021
rename (Total_Effort_2021 YellowPerch_Effort_2021 Salmon_Effort_2021 YellowPerch_Harvest_2021 RainbowTrout_Harvest_2021 LakeTrout_Harvest_2021 CohoSalmon_Harvest_2021 ChinookSalmon_Harvest_2021 BrownTrout_Harvest_2021) ///
(Total_Effort YellowPerch_Effort Salmon_Effort YellowPerch_Harvest RainbowTrout_Harvest LakeTrout_Harvest CohoSalmon_Harvest ChinookSalmon_Harvest BrownTrout_Harvest)
gen Boat_Effort = .
gen Shore_Effort = .
replace Boat_Effort = Total_Effort if Angler_Type == "Boat"
replace Shore_Effort = Total_Effort if Angler_Type == "Peds"
drop Angler_Type

// Append 2021 data to the temporary dataset (2014 to 2020)
append using `temp_2014_2020'

// Save the combined dataset for 2014 to 2021 as a temporary file
tempfile temp_2014_2021
save `temp_2014_2021', replace

// Append the data for 2022
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2022") firstrow clear
gen Year = 2022 // Add a year column for 2022
rename (Total_Effort_2022 YellowPerch_Effort_2022 Salmon_Effort_2022 YellowPerch_Harvest_2022 RainbowTrout_Harvest_2022 LakeTrout_Harvest_2022 CohoSalmon_Harvest_2022 ChinookSalmon_Harvest_2022 BrownTrout_Harvest_2022) ///
(Total_Effort YellowPerch_Effort Salmon_Effort YellowPerch_Harvest RainbowTrout_Harvest LakeTrout_Harvest CohoSalmon_Harvest ChinookSalmon_Harvest BrownTrout_Harvest)
gen Boat_Effort = .
gen Shore_Effort = .
replace Boat_Effort = Total_Effort if Angler_Type == "Boat"
replace Shore_Effort = Total_Effort if Angler_Type == "Peds"
drop Angler_Type

// Append 2022 data to the temporary dataset (2014 to 2021)
append using `temp_2014_2021'

// Save the combined dataset for 2014 to 2022 as a temporary file
tempfile temp_2014_2022
save `temp_2014_2022', replace

// Append the data for 2023
import excel "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Creel Survey Data.xlsx", sheet("2023") firstrow clear
gen Year = 2023 // Add a year column for 2023
rename (Total_Effort_2023 YellowPerch_Effort_2023 Salmon_Effort_2023 YellowPerch_Harvest_2023 RainbowTrout_Harvest_2023 LakeTrout_Harvest_2023 CohoSalmon_Harvest_2023 ChinookSalmon_Harvest_2023 BrownTrout_Harvest_2023) ///
(Total_Effort YellowPerch_Effort Salmon_Effort YellowPerch_Harvest RainbowTrout_Harvest LakeTrout_Harvest CohoSalmon_Harvest ChinookSalmon_Harvest BrownTrout_Harvest)
gen Boat_Effort = .
gen Shore_Effort = .
replace Boat_Effort = Total_Effort if Angler_Type == "Boat"
replace Shore_Effort = Total_Effort if Angler_Type == "Peds"
drop Angler_Type

// Append 2023 data to the temporary dataset (2014 to 2022)
append using `temp_2014_2022'
drop L

clear
use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Combined_Creel_Data_2014_2023.dta"
drop if Site == "TOTALS"
drop if Site == "Combined TOTALS"
replace Site = "Waukegan Harbor" if Site == "Wau. Harbor"
replace Site = "Other" if Site == "Others"
* Step 1: Sort data by site and year
sort Site Year
replace Boat_Effort=0 if Boat_Effort==.
replace Shore_Effort=0 if Shore_Effort==.
collapse (sum) Total_Effort YellowPerch_Effort Salmon_Effort YellowPerch_Harvest BrownTrout_Harvest RainbowTrout_Harvest CohoSalmon_Harvest ChinookSalmon_Harvest Boat_Effort Shore_Effort, by(Site Year)


// Save the final combined dataset for 2014 to 2023
save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Combined_Creel_Data_2014_2023.dta", replace

clear

use "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\CleanedData\Combined_2000_2012.dta", clear
drop siteid
append using "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Combined_Creel_Data_2014_2023.dta"
drop if Site=="AllIL"
drop if Site=="AllIN"
drop if Site=="AllINstreams"

save "C:\Users\Emma\OneDrive - purdue.edu\Desktop\Fisheries RUM\Combined_Fisheries_Data_2000_2023.dta", replace


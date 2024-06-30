
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

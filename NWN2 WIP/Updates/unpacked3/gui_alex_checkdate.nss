#include "nwnx_clock"

// Go over all PCs on server.
// Return a list of Clerics and their domain status (ok / not ok)
void main()
{
	if (!GetIsPC(OBJECT_SELF))
		return;

	object oPC = OBJECT_SELF;
	//int nCheckResult;
	
	
	
	string sTime = GetSystemDate();
	
	string nMonth = GetStringLeft(sTime, 2);
	string nDay = GetStringRight(GetStringLeft(sTime, 5),2);
	string sYear = IntToString(StringToInt(GetStringRight(sTime, 4))-635);
	
	string frMonth;
	string frYear;
	
	if(nMonth == "01")
	{
		frMonth = "Hammer";
	}
	else if(nMonth == "02")
	{
		frMonth = "Alturiak";
	}	
	else if(nMonth == "03")
	{
		frMonth = "Ches";
	}
	else if(nMonth == "04")
	{
		frMonth = "Tarsakh";
	}
	else if(nMonth == "05")
	{
		frMonth = "Mirtul";
	}
	else if(nMonth == "06")
	{
		frMonth = "Kythorn";
	}
	else if(nMonth == "07")
	{
		frMonth = "Flamerule";
	}
	else if(nMonth == "08")
	{
		frMonth = "Eleasias";
	}
	else if(nMonth == "09")
	{
		frMonth = "Eleint";
	}
	else if(nMonth == "10")
	{
		frMonth = "Marpenoth";
	}
	else if(nMonth == "11")
	{
		frMonth = "Uktar";
	}
	else if(nMonth == "12")
	{
		frMonth = "Nightal";
	}
	
	if(sYear == "1376")
	{
		frYear = "the Year of the Bent Blade";
	}
	else if(sYear == "1377")
	{
		frYear = "the Year of the Haunting";
	}
    else if(sYear == "1378")
	{
		frYear = "the Year of the Cauldron";
	}
	
	SendMessageToPC(oPC, "<C=lightgreen> The server date is " + nDay + " of " + frMonth + ".  The year is " + sYear + " DR, " + frYear + "."); 
		
}
/*
Filename:           hcr2_heartbeat_e
System:             core (module heartbeat event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnHeartbeat Event.
This script should be attachted to the OnHeartbeat event under
the scripts section of Module properties.

-----------------
Revision: v1.01
Made saving the current calendar & time only occur every minute
instead of every heartbeat.

Revision v1.04
Adjusted calendar save to check the value of the passed seconds
over 1 minute intervals instead of stricly relying on GetTimeMinute()
This should fix problems with MinutesPerHour set to 0.
*/
#include "hcr2_core_i"
//#include "mvd_02_modheart"

 

void main() 
{    
	int nSecond = GetTimeSecond();
	if (nSecond >= 0 && nSecond < 6)
	{
		h2_SaveCurrentCalendar();    
	}
    h2_RunModuleEventScripts(H2_EVENT_ON_HEARTBEAT);
	//MvD_02_ModuleHeartBeat();
	ExecuteScript("cmi_mod_hb", OBJECT_SELF); //This is the module
	
}


 
/*

    Script:			This script is called from the leg_all_masterheartbeat script when the Banter system is active.
					It examines to see if there has been a switch from day to night or vice versa and then
					calls a funciton to execute a randomly chosen ID Oneliner from the system that matches their 
					configured variable and to speak it, a random number of seconds after the day/night cycle starts.
	Version:		1.01
	Plugin Version: 1.5
	Last Update:	11/26/2010
	Author:			Marshall Vyper
	Parameters:		None
	
	Change Log:		11/24/2010 - Initial Release
					11/26/2010 - Updated to support Legends Modular Plugins

*/

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_banter_include"




// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// Choose a random number of seconds to delay so we don't have every NPC in the area
	// speaking at the same time when we change from day to night and vice versa
	float fRandomSecs = IntToFloat(Random(LEG_BANTER_DELAY));
	string sLastCheck = GetLocalString(OBJECT_SELF, "LASTTIMECHECK");
	if (GetIsNight() && sLastCheck == "Day")
	{
		// If we were last checked in the day and it is now night, change our local
		// variable to Night and call our speak function.
		SetLocalString(OBJECT_SELF, "LASTTIMECHECK", "Night");
		if (GetLocalString(OBJECT_SELF, "LEG_BANTER_Night") != "")
			DelayCommand(fRandomSecs, LEG_BANTER_DAYNIGHT_ExecuteSpeak("Night"));
	}
	else if (GetIsDay() && sLastCheck == "Night")
	{
		// If we were last checked in the night and it is now day, change our local
		// variable to Night and call our speak function.
		SetLocalString(OBJECT_SELF, "LASTTIMECHECK", "Day");
			if (GetLocalString(OBJECT_SELF, "LEG_BANTER_Day") != "")
		DelayCommand(fRandomSecs, LEG_BANTER_DAYNIGHT_ExecuteSpeak("Day"));
	}
	else if (GetIsDay() && sLastCheck == "")
		SetLocalString(OBJECT_SELF, "LASTTIMECHECK", "Day");
	else if (GetIsNight() && sLastCheck == "")
		SetLocalString(OBJECT_SELF, "LASTTIMECHECK", "Night");
}
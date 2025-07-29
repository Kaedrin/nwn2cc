/*
Filename:           hcr2_fugueexit
System:             fugue death system (area exit event hook-in script  for the hcr2_fugue area)
Author:             Edward Beck (0100010)
Date Created:       Nov. 26th, 2006
Summary:
HCR2 event script.
This script should be attachted to the area exit event for the fugue plane
on its respective scripts tab, or added as an AreaExit
script hook-in if the Fugue plane uses the area hook in events.

-----------------
Revision: v1.01
Changed code to deal with adjustment to save location configuration setting.
Altered code so that the player state is not set to alive if the player exits
fugue by logging off.

Revision v1.02
Change to check against PlayerName instead of CDKey.
*/
#include "hcr2_core_i"

void main()
{
    object oPC = GetExitingObject();
    DeleteLocalInt(oPC, H2_LOGIN_DEATH);
	if (GetPCPlayerName(oPC) != "")
	{   //If the player name is valid it means 
	    //they did not exit by logging out
		h2_SetPlayerState(oPC, H2_PLAYER_STATE_ALIVE);
		if (H2_SAVE_PC_LOCATION_TIMER_INTERVAL > 0.0)
			DelayCommand(0.1, h2_SavePCLocation(oPC));
	}		
}
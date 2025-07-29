/*
Filename:           hcr2_playerrespawn_e
System:             core (player respawn event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnPlayerReSpawn Event.
This script should be attachted to the OnPlayerReSpawn event under
the scripts section of Module properties.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{    
	object oPC = GetLocalObject(OBJECT_SELF, H2_LAST_RESPAWN_BUTTON_PRESSER);
    h2_SetPlayerState(oPC, H2_PLAYER_STATE_ALIVE);
    h2_RunModuleEventScripts(H2_EVENT_ON_PLAYER_RESPAWN);
}
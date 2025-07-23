/*
Filename:           h2_pccorpseopy
System:             pc corpse system (hook-in script for player dying event)
Author:             Edward Beck (0100010)
Date Created:       Dec. 22nd, 2006
Summary:
HCR2 pc corpse system script.

This script should be called via ExecuteScript from the
RunModuleEventScripts(H2_EVENT_ON_PLAYER_DYING, oPC) function that is called from hcr2_playerdying_e.

To make this script execute, a string variable, named OnPlayerDyingX
where X is a number that indicates the order in which you want this player dyingh script to execute,
should be assigned the value "hcr2_pccorpseopy" under the variables section of Module properties.

-----------------
Revision:

*/

#include "hcr2_pccorpse_i"

void main()
{
    object oPC = GetLastPlayerDying();
	//if some other dying subsystem set the player state to something else before this one, no need to continue
    if (h2_GetPlayerState(oPC) != H2_PLAYER_STATE_DYING)
        return;
		
	if (H2_DROP_PLAYER_ITEMS)
	{		
		object oLootBag = h2_CreateLootBag(oPC);
    	h2_MovePossessorInventory(oPC, TRUE, oLootBag);
	}		
}
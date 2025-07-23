/*
Filename:           hcr2_pccorpseopd
System:             pc corpse (player death event hook-in script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 2nd, 2006
Summary:

This script should be called via ExecuteScript from the
RunModuleEventScripts(H2_EVENT_ON_PLAYER_DEATH, oPC) function that is called from hcr2_playerdeath_e.

To make this script execute, a string variable, named OnPlayerDeathX,
where X is a number that indicates the order in which you want this player death script to execute,
should be assigned the value "hcr2_pccorpseopd" under the variables section of Module properties.

-----------------
Revision: v1.01
Items are stripped on a login death only if H2_DROP_PLAYER_ITEMS is true.

*/
#include "hcr2_pccorpse_i"

void main()
{
    object oPC = GetLastPlayerDied();
    //if some other death subsystem set the player state back to alive before this one, no need to continue
    if (h2_GetPlayerState(oPC) != H2_PLAYER_STATE_DEAD)	
		return;
		
	if (GetLocalInt(oPC, H2_LOGIN_DEATH))
	{	
		if (H2_DROP_PLAYER_ITEMS)
		{			
			h2_MovePossessorInventory(oPC, TRUE);
        	h2_MoveEquippedItems(oPC);
		}
		return;		
   	}	
	h2_CreatePlayerCorpse(oPC);	
	if (H2_DROP_PLAYER_ITEMS)
	{
		object oLootBag = h2_CreateLootBag(oPC);
		h2_MovePossessorInventory(oPC, TRUE, oLootBag);
    	h2_MoveEquippedItems(oPC, oLootBag);
	}
}
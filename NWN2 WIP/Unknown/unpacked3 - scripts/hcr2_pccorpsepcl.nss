/*
Filename:           hcr2_pccorpsepcl
System:             pc corpse (pc loaded event hook-in script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 2nd, 2006
Summary:

This script should be called via ExecuteScript from the
RunModuleEventScripts(H2_EVENT_ON_PC_LOADED, oPC) function that is called 
from hcr2_pcloaded_e.

To make this script execute, a string variable, named OnPCLoadedX,
where X is a number that indicates the order in which you want this pc loaded script to execute,
should be assigned the value "hcr2_pccorpsepcl" under the variables section of Module properties.

-----------------
Revision:

*/

#include "hcr2_pccorpse_i"

void main()
{
	object oPC = GetEnteringObject();
	//SpawnScriptDebugger();
	location locRess = h2_GetOfflineRessLocation(oPC);
	int nPlayerstate = h2_GetPlayerState(oPC); 
    if (h2_GetIsLocationValid(locRess) && nPlayerstate == H2_PLAYER_STATE_DEAD)
	{
        h2_PerformOffLineRessurectionLogin(oPC, locRess);
		h2_SetPlayerState(oPC, H2_PLAYER_STATE_ALIVE);
	}

    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == H2_PC_CORPSE_ITEM)
            DestroyObject(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
}
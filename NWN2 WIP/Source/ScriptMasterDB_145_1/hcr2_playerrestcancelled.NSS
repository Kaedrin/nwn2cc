/*
Filename:           hcr2_playerrestcancelled
System:             core (rest cancelled hook-in script)
Author:             Edward Beck (0100010)
Date Created:       Nov. 13th, 2006
Summary:

This script should be called via ExecuteScript from the
RunModuleEventScripts(H2_EVENT_ON_PLAYER_REST_CANCELLED, oPC) function that is called
from hcr2_playerrest_e.

To make this script execute, a string variable, named OnPlayerRestCancelledX,
where X is a number that indicates the order in which you want this player rest cancelled script to execute,
should be assigned the value "hcr2_playerrestcancelled" under the variables section of Module properties.

If the PC has not been flagged to skip the cancel rest code,
then the PC's Hitpoints and spells and feats will be reset to the values they were at prior to resting.

-----------------
Revision: v1.05
Fix for tracking rest time, spells, feats, and health 
for companions on rest

*/
#include "hcr2_playerrest_i"

void main()
{
    object oPC = GetLastPCRested();
	object oPM = GetFirstFactionMember(oPC, FALSE);
	while (GetIsObjectValid(oPM))
	{
		if (!GetIsPC(oPM) || oPM == oPC)
		{
			h2_SetPlayerHitPointsToSavedValue(oPM);
		    h2_SetAvailableSpellsToSavedValues(oPM);
			h2_SetAvailableFeatsToSavedValues(oPM);   
		}
		oPM = GetNextFactionMember(oPM, FALSE);
	}
}
/*
Filename:           hcr2_playerrestfinished
System:             core (rest finished hook-in script)
Author:             Edward Beck (0100010)
Date Created:       Nov. 13th, 2006
Summary:
HCR2 PlayerRest script.

This script should be called via ExecuteScript from the
RunModuleEventScripts(H2_EVENT_ON_PLAYER_REST_FINISHED, oPC) function that is called 
from hcr2_playerrest_e.

To make this script execute, a string variable, named OnPlayerRestFinishedX,
where X is a number that indicates the order in which you want this player rest finished script to execute,
should be assigned the value "hcr2_playerrestfinished" under the variables section of Module properties.

If the PC has not been flagged to not allow spell and feat recovery during rest,
then the PC's spells and feats will be reset to the values they were at prior to resting.
If recovery was allowed, then the time of this rest recovery is saved for that PC.

The PC's hitpoint are also adjusted to only heal the amount that was allowed for from the value
retrieved from the h2_GetPostRestHealAmount.

-----------------
Revision: v1.02
Fixed bug where PC was not healing full HP when
H2_HP_HEALED_PER_REST_PER_LEVEL = -1.

v1.05
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
			int bAllowSpellRecovery = h2_GetAllowSpellRecovery(oPM);
			if (!bAllowSpellRecovery)
		        h2_SetAvailableSpellsToSavedValues(oPM);
		
			int bAllowFeatRecovery = h2_GetAllowFeatRecovery(oPM);
			if (!bAllowFeatRecovery)
		        h2_SetAvailableFeatsToSavedValues(oPM);		    
				
			if (bAllowSpellRecovery && bAllowFeatRecovery)
		        h2_SaveLastRecoveryRestTime(oPM);
		    
		    //if (H2_HP_HEALED_PER_REST_PER_LEVEL > -1)
		    //{        
			    int nPostRestHealAmt = h2_GetPostRestHealAmount(oPM); 	
			    DelayCommand(0.2, h2_LimitPostRestHeal(oPM, nPostRestHealAmt));
		    //}
		}
		oPM = GetNextFactionMember(oPM, FALSE);
	}
}
/*
Filename:           hcr2_bleedsystemopd
System:             bleed system (player death event hook-in script)
Author:             Edward Beck (0100010)
Date Created:       Oct. 3rd, 2007
Summary:

This script should be called via ExecuteScript from the
RunModuleEventScripts(H2_EVENT_ON_PLAYER_DEATH, oPC) function that is called from hcr2_playerdeath_e.

To make this script execute, a string variable, named OnPlayerDeathX where X is a number that indicates
the order in which you want this player dying script to execute.
It should be assigned the value "hcr2_bleedsysopd" under the variables section of Module properties.

Added as of v1.03
-----------------
Revision: 

*/

#include "hcr2_bleedsystem_i"

void main()
{	
	object oPC = GetLastPlayerDied();
	if (!H2_FORCED_BLEED || GetLocalInt(oPC, H2_LOGIN_DEATH))
		return;
	
    if (h2_GetPlayerState(oPC) == H2_PLAYER_STATE_DEAD && !GetLocalInt(oPC, H2_BLEED_OUT))
	{			
		h2_SetPlayerState(oPC, H2_PLAYER_STATE_DYING);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);
		effect eDam = EffectDamage(GetCurrentHitPoints(oPC));
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC);
	}
}
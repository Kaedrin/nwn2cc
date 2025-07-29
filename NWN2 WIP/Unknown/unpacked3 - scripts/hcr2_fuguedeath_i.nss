/*
Filename:           hcr2_fuguedeath_i
System:             fugue death system (include script)
Author:             Edward Beck (0100010)
Date Created:       Nov. 26th, 2006
Summary:
HCR2 hcr2_fuguedeath system function definition file.
This script is consumed by the fugue death system hook-in scripts as an include file.

-----------------
Revision: v1.01
Removed the H2_FUGUE_PLANE tag constant.
(fugue area is now solely determined by placeent of the fugue waypoint)

Revision: v1.05
Altered logging code
Forced control back to original character before
sending dead PC to fugue.
*/

#include "hcr2_core_i"

const string H2_WP_FUGUE = "HCR2_FUGUE";

void h2_SendPlayerToFugue(object oPC)
{
    object oFugueWP = GetObjectByTag(H2_WP_FUGUE);
	if (GetIsObjectValid(oFugueWP))
	{
		object oCurrent = GetControlledCharacter(oPC);
		SetOwnersControlledCompanion(oCurrent, oPC);
	    SendMessageToPC(oPC, H2_TEXT_YOU_HAVE_DIED);
	    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);
	    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)), oPC);
	    h2_RemoveEffects(oPC);
	    ClearAllActions();
	    AssignCommand(oPC, JumpToObject(oFugueWP));
	}
	else
	{
		string sMessage = "Valid fugue waypoint not found. Player was not sent to fugue.";
		h2_LogMessage(H2_LOG_ERROR, sMessage);
	}
}
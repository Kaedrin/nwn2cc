/*
Filename:           hcr2_fuguedeathopd
System:             fugue death system (player death hook-in script)
Author:             Edward Beck (0100010)
Date Created:       Nov. 26th, 2006
Summary:

This script should be called via ExecuteScript from the
RunModuleEventScripts(H2_EVENT_ON_PLAYER_DEATH, oPC) function that is called from hcr2_playerdeath_e.

To make this script execute, a string variable, named OnPlayerDeathX where X is a number that
indicates the order in which you want this player death script to execute.
Ir should be assigned the value "hcr2_fuguedeathopd" under the variables section of Module properties.

-----------------
Revision: v1.01
Changed code so only the area of the fugue waypoint is checked
against the PC's area and not via fugue area's tag constant
which was removed.

Revision: v1.05
Added code to remove player from their currenty paty, and remove all companions
from the player's party upon death of the player's primary character.
*/
#include "hcr2_fuguedeath_i"

void main()
{
    object oPC = GetLastPlayerDied();
	//if some other death subsystem set the player state back to alive before this one, no need to continue
    if (h2_GetPlayerState(oPC) != H2_PLAYER_STATE_DEAD)	
		return;
	
    object oFugueWP = GetObjectByTag(H2_WP_FUGUE);
    if (GetArea(oPC) == GetArea(oFugueWP))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)), oPC);
        return;
    }
    else
    {   //TODO: how should rosters be dealt with?
        h2_DropAllHenchmen(oPC);
		//RemoveFromParty(oPC);
		h2_DropAllCompanions(oPC);
		h2_SendPlayerToFugue(oPC);
    }
}
/*
Filename:           hcr2_fuguedeathopy
System:             fugue death system (player dying hook-in script)
Author:            	Edward Beck (0100010)
Date Created:       Nov. 26th, 2006
Summary:

This script should be called via ExecuteScript from the
RunModuleEventScripts(H2_EVENT_ON_PLAYER_DYING, oPC) function that is called from hcr2_playerdying_e.

To make this script execute, a string variable, named OnPlayerDyingX where X is a number that indicates
the order in which you want this player dying script to execute.
It should be assigned the value "hcr2_fuguedeathopy" under the variables section of Module properties.

-----------------
Revision: v1.01
Changed code so only the area of the fugue waypoint is checked
against the PC's area and not via fugue area's tag constant
which was removed.

*/
#include "hcr2_fuguedeath_i"

void main()
{
    object oPC = GetLastPlayerDying();
	object oFugueWP = GetObjectByTag(H2_WP_FUGUE);
    if (GetArea(oPC) == GetArea(oFugueWP))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)), oPC);
        return;
    }
}
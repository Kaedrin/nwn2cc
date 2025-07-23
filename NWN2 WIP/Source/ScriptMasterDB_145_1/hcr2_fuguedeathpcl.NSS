/*
Filename:           hcr2_fuguedeathpcl
System:             fugue death system  (pc loaded hook-in script)
Author:             Edward Beck (0100010)
Date Created:       Nov. 26th, 2006
Summary:

This script should be called via ExecuteScript from the
RunModuleEventScripts(H2_EVENT_ON_PC_LOADED, oPC) function that is called
from hcr2_pcloaded_e.

To make this script execute, a string variable, named OnPCLoadedX,
where X is a number that indicates the order in which you want this client enter script to execute,
should be assigned the value "hcr2_fuguedeathpcl" under the variables section of Module properties.

-----------------
Revision: v1.01
Changed code so only the area of the fugue waypoint is checked
against the PC's area and not via fugue area's tag constant
which was removed.

*/
#include "hcr2_fuguedeath_i"

void main()
{	
    object oPC = GetEnteringObject();
    int nPlayerstate = h2_GetPlayerState(oPC);
    object oFugueWP = GetObjectByTag(H2_WP_FUGUE);
    if (GetArea(oPC) != GetArea(oFugueWP) && nPlayerstate == H2_PLAYER_STATE_DEAD)
    {
        h2_SendPlayerToFugue(oPC);
    }
}
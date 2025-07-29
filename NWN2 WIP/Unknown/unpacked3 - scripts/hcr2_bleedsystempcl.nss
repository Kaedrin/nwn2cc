/*
Filename:           hcr2_bleedsystempcl
System:             bleed system  (pc loaded hook-in script)
Author:             Edward Beck (0100010)
Date Created:       Sep. 27th, 2009
Summary:

This script should be called via ExecuteScript from the
RunModuleEventScripts(H2_EVENT_ON_PC_LOADED, oPC) function that is called
from hcr2_pcloaded_e.

To make this script execute, a string variable, named OnPCLoadedX,
where X is a number that indicates the order in which you want this client enter script to execute,
should be assigned the value "hcr2_bleedsystempcl" under the variables section of Module properties.

-----------------
Revision:

*/
#include "hcr2_bleedsystem_i"

void main()
{	
    object oPC = GetEnteringObject();
    h2_SetSelfStabilizeChance(oPC, H2_SELF_STABILIZE_CHANCE);
	h2_SetSelfRecoveryChance(oPC, H2_SELF_RECOVERY_CHANCE);
}
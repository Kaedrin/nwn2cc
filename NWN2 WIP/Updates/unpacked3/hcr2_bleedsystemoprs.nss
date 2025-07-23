/*
Filename:           hcr2_bleedsystemoprs
System:             bleed system (player rest started event hook-in script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 10th, 2006
Summary:

This script should be called via ExecuteScript from the
RunModuleEventScripts(H2_EVENT_ON_PLAYER_REST_STARTED, oPC) function that is called from hcr2_playerrest_e.

To make this script execute, a string variable, named OnPlayerRestStartedX where X is a number that indicates
the order in which you want this player dying script to execute.
It should be assigned the value "hcr2_bleedsysoprs" under the variables section of Module properties.

By Default, h2_GetAllowRest, h2_GetAllowSpellRecovery and h2GetAllowFeatRecovery will return true
as hcr2_playerrest_e defaults them to that value before the rest started event scripts are ran.
Likewise, by default, h2_GetPostRestHealAmount is set to the PC's maximum hit points
to allow for full healing after the rest is finished.

These settings however are changed from their default values in the rest started hook-in scripts.

This script alters the post rest heal amount, doubling it if long term case was sucessfully applied
to the pc.

Revision Info should only be included for post-release revisions.
-----------------
Revision:

*/

#include "hcr2_bleedsystem_i"

void main()
{
    object oPC = GetLastPCRested();
    if (GetLocalInt(oPC, H2_LONG_TERM_CARE) && h2_GetPostRestHealAmount(oPC) > 0)
    {
        DeleteLocalInt(oPC, H2_LONG_TERM_CARE);
        int postRestHealAmt = h2_GetPostRestHealAmount(oPC) * 2;
        h2_SetPostRestHealAmount(oPC, postRestHealAmt);
    }
}
/*
Filename:           hcr2_pccorpseocl
System:             pc corpse (client leave event hook-in script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 2nd, 2006
Summary:

This script should be called via ExecuteScript from the
RunModuleEventScripts(H2_EVENT_ON_CLIENT_LEAVE, oPC) function that is called from hcr2_clientleave_e.

To make this script execute, a string variable, named OnClientLeaveX,
where X is a number that indicates the order in which you want this client enter script to execute,
should be assigned the value "hcr2_pccorpseocl" under the variables section of Module properties.

-----------------

*/

#include "hcr2_pccorpse_i"

void main()
{
    object oPC = GetExitingObject();
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == H2_PC_CORPSE_ITEM)
        {
            location locLastDrop = GetLocalLocation(oItem, H2_LAST_DROP_LOCATION);
            object oNewToken = CopyObject(oItem, locLastDrop);			
            h2_DropPlayerCorpse(oNewToken);
        }
        oItem = GetNextItemInInventory(oPC);
    }
}
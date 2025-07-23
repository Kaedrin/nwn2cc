/*
Filename:           hcr2_firewood
System:             player rest
Author:             Edward Beck (0100010)
Date Created:       Nov 13th, 2006
Summary:
HCR2 hcr2_firewood item script.
This script fires via tag based scripting for the OnActivate events for this item.

-----------------
Revision:

*/

#include "hcr2_playerrest_i"
#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
        object oPC   = GetItemActivator();
		object oItem = GetItemActivated();
       	h2_UseFirewood(oPC, oItem);		
    }
}
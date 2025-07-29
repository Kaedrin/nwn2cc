/*
Filename:           hcr2_healerskit
System:             bleed system (item activated script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 22nd, 2006
Summary:
This script fires whenever the hcr2_healerskit items are activated

-----------------
Revision: 

*/

#include "hcr2_bleedsystem_i"
#include "x2_inc_switches"

void main()
{
	int nEvent = GetUserDefinedItemEventNumber();    			
    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
		object oPC = GetItemActivator();;
    	object oTarget = GetItemActivatedTarget();
		object oItem = GetItemActivated();
		if (GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
		{
			SendMessageToPC(oPC, H2_TEXT_CANNOT_USE_ON_TARGET);
	    	return;				
		}
		h2_UseHealSkillOnTarget(oTarget, oPC, oItem);
    }
}
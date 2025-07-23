/*
Filename:           gui_hcr2_healskill
System:             bleed system (heal skill context menu gui callback)
Author:             Edward Beck (0100010)
Date Created:       Dec. 15th, 2006
Summary:
This is called from the context menu as a gui callback when the player right clicks
a creature and chooses the heal menu item.

-----------------
Revision:

*/

#include "hcr2_bleedsystem_i"

void main()
{
	object oTarget = GetPlayerCurrentTarget(OBJECT_SELF);		
	if (GetDistanceBetween(OBJECT_SELF, oTarget) > 1.0)
	{
		AssignCommand(OBJECT_SELF, ActionMoveToObject(oTarget, TRUE));
	}	
	if (GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
	{
		SendMessageToPC(OBJECT_SELF, H2_TEXT_CANNOT_USE_ON_TARGET);
    	return;				
	}	
	object oHealKit = GetItemPossessedBy(OBJECT_SELF, H2_HEALERS_KIT);	
	AssignCommand(OBJECT_SELF, h2_UseHealSkillOnTarget(oTarget, OBJECT_SELF, oHealKit));
	if (GetIsObjectValid(oHealKit))
	{
		SetItemCharges(oHealKit, GetItemCharges(oHealKit) - 1);
	}
}
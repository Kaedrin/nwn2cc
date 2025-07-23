/*
Filename:           hcr2_equipitem_e
System:             core (module player equip item event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnPlayerEquipItem Event.
This script should be attachted to the OnPlayerEquipItem event under
the scripts section of Module properties.

-----------------
Revision: v1.05
Added code to add HCR2-added OnHitProperty

*/

#include "hcr2_core_i"

void main()
{
	object oItem = GetPCItemLastEquipped();	
	h2_AddOnHitProperty(oItem);	
    h2_RunModuleEventScripts(H2_EVENT_ON_PLAYER_EQUIP_ITEM);
}
/*
Filename:           hcr2_unequipitem_e
System:             core (module player unequip item event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnPlayerUnEquipItem Event.
This script should be attachted to the OnPlayerUnEquipItem event under
the scripts section of Module properties.

-----------------
Revision: v1.05
Added code to remove HCR2-added OnHitProperty

*/

#include "hcr2_core_i"

void main()
{
	object oItem = GetPCItemLastUnequipped();
	h2_RemoveAddedOnHitProperty(oItem);
    h2_RunModuleEventScripts(H2_EVENT_ON_PLAYER_UNEQUIP_ITEM);
	object oPC = GetPCItemLastUnequippedBy();
	ExecuteScript("cmi_player_unequip", oPC);
	//ExecuteScript("alex_rws_horse_unequip", oPC);
}
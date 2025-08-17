// k_mod_player_equip
/*
    Module equip item script
    gets the tag of the item and calls:
    "i_<tag>_eq"
*/
// ChazM 3/1/05
// BMA-OEI 9/26/05 moved concat below string trim
// ChazM 10/20/05 - hook back in to the x2_mod_def* script
// ChazM 6/18/07 - Okku can't equip items
// ChazM 6/19/07 - Golem Ally can't equip items
// ChazM 6/21/07 - OneOfMany added to the evergrowing list of those who can't equip items
// ChazM 7/13/07 - Okku allowed to wear rings and amulets	
// ChazM 8/15/07 - send message indicating item can't be equipped.
// ChazM 8/16/07 - Okku Right Ring fix.

//#include "ginc_debug"
#include "ginc_item"

const int STR_REF_NOT_ALLOWED	= 210757;	
void main()
{
    object oPC      = GetPCItemLastEquippedBy();
   	object oItem 	= GetPCItemLastEquipped();
		
	int bEquipForbidden = FALSE;
	// construct can't equip items (except hidden creature items)
	string sTag = GetTag(oPC);
	if ((sTag == "construct")
		||(sTag == "okku")
		||(sTag == "a04_golem_ally")
		||(sTag == "oneofmany")
		)
	{
		int nSlot = GetSlotOfEquippedItem(oItem, oPC);
		// all non-creature items forbidden by default
		if (!GetIsCreatureSlot(nSlot))
		{
			bEquipForbidden = TRUE;
		}		
		
		// okku allowed to wear rings and amulets
		if (sTag == "okku")
		{
			if ((nSlot == INVENTORY_SLOT_NECK) 
				|| (nSlot == INVENTORY_SLOT_LEFTRING)
				|| (nSlot == INVENTORY_SLOT_RIGHTRING))
			{				
				bEquipForbidden = FALSE;
			}
		}	
	}
	
	if ((sTag == "co_zarl"))
	{
		int nSlot = GetSlotOfEquippedItem(oItem, oPC);
		// all non-creature items forbidden by default
		if (GetIsCreatureSlot(nSlot))
		{
			bEquipForbidden = FALSE;
		}
		
		else if ((nSlot == INVENTORY_SLOT_CARMOUR) 
			|| (nSlot == INVENTORY_SLOT_CHEST)
			|| (nSlot == INVENTORY_SLOT_HEAD)
			|| (nSlot == INVENTORY_SLOT_ARMS)
			|| (nSlot == INVENTORY_SLOT_BOOTS))
		{				
			bEquipForbidden = TRUE;
		}	
	}	
	
	if (bEquipForbidden == TRUE)
	{
		AssignCommand(oPC, ActionUnequipItem(oItem));
		SendMessageToPCByStrRef(oPC, STR_REF_NOT_ALLOWED);
		return;
	}
	
	ExecuteScript("x2_mod_def_equ", OBJECT_SELF);
	//SendMessageToPC(oPC,"cmi_player_equip firing.");	
	ExecuteScript("ccs_player_equip", oPC);
	//ExecuteScript("cmi_player_equip", oPC);
}
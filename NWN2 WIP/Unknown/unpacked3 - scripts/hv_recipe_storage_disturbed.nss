#include "nwnx_sql"

// To put on recipe chest on inventory disturbed, to update
// stored recipes of PC
void main()
{
	//object oPC = GetLastDisturbed();
	object oPC = GetLocalObject(OBJECT_SELF, "hv_recipe_storage_user");
	
	// error
	if (!GetIsPC(oPC))
		return;
	
	object oItem = GetInventoryDisturbItem();
	int nAction = GetInventoryDisturbType();
	
	// Added recipe
	if (nAction == INVENTORY_DISTURB_TYPE_ADDED) {
		
		// Make sure it's a recipe or mold
		if ((GetBaseItemType(oItem) != 145) && (GetBaseItemType(oItem) != 146)) {
			 	
			if ((GetBaseItemType(oItem) != 109) || (FindSubString(GetTag(oItem), "mold") == -1)) {
			 	
				SendMessageToPC(oPC, "<C=red>Item is not a recipe, and will be destroyed. Take it out!");
				return;
			}
		}
		
		// if it's a mold, get stack size
		int nStackSize = GetItemStackSize(oItem);
		
		// Set new recipe number
		SetPersistentInt(oPC, GetTag(oItem), GetPersistentInt(oPC, GetTag(oItem), "recipestorage") + nStackSize, 0, "recipestorage");		
	}
	// Took recipe out
	else if (nAction == INVENTORY_DISTURB_TYPE_REMOVED) {
	
		// Make sure it's a recipe or mold
		if ((GetBaseItemType(oItem) != 145) && (GetBaseItemType(oItem) != 146)) {
			 	
			if ((GetBaseItemType(oItem) != 109) || (FindSubString(GetTag(oItem), "mold") == -1)) {
				return;
			}
		}	
		
		// if it's a mold, get stack size
		int nStackSize = GetItemStackSize(oItem);
		
		// Set new recipe number
		SetPersistentInt(oPC, GetTag(oItem), GetPersistentInt(oPC, GetTag(oItem), "recipestorage") - nStackSize, 0, "recipestorage");
	}
}
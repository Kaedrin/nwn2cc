//::///////////////////////////////////////////////
//:: Example XP2 OnItemAcquireScript
//:: x2_mod_def_aqu
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnItemAcquire Event

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////

#include "x2_inc_switches" 
#include "kinc_crafting"
#include "ginc_item"
#include "hv_ore_drop"

void main()
{
     object oItem = GetModuleItemAcquired();
	 string sTag = GetTag(oItem);
	 object oPC = GetModuleItemAcquiredBy();
	 
	 // Mark item as un-pickpocketable.
  if (GetPickpocketableFlag(oItem))
   SetPickpocketableFlag(oItem, FALSE);
	 
	 if(sTag == "nx2_n_arcatten")		//When you acquire the arcane attenuator, if you already have one, we delete the new one.
	 {
	 	object oPC = GetModuleItemAcquiredBy();
	 	int bItemFound = FALSE;
        object oFM =  GetFirstFactionMember(oPC, FALSE);
		while(GetIsObjectValid(oFM))
		{
			object oInvItem = GetFirstItemInInventory(oFM);	//Iterate through the inventory of each faction member till I find the recipe.
			while(GetIsObjectValid(oInvItem))
			{
				if(GetTag(oInvItem) == GetTag(oItem))	//If I find a single copy of the recipe...
				{
					if(!bItemFound)						
					{
						PrettyDebug("Item Found!");
						bItemFound = TRUE;
					}
					
					else
					{
						PrettyDebug("Dupe Item Found! Deleting dupe item.");
						DestroyObject(oInvItem, 0.0f, FALSE);	//remove all copies of the recipe after the first.
					}
				}
				
				oInvItem = GetNextItemInInventory(oFM);
			}
			
			oFM = GetNextFactionMember(oPC, FALSE);
		}				
	 }
	 
	 else if(sTag == "nx2_n_chrgatten")	//If you acquire a charged attenuator and you haven't earned it (i.e. you haven't used an arcane nexus
	 									//since your last turnin), we don't want you getting one.
	 {
	 	object oPC = GetModuleItemAcquiredBy();
	 	if(GetGlobalInt("N_bAttenOut"))
		{
			DestroyObject(oItem, 0.0f, FALSE);
		}
		
		else							//Also, if you already have one, we don't want you getting one.
		{
		 	object oPC = GetModuleItemAcquiredBy();
		 	int bItemFound = FALSE;
	        object oFM =  GetFirstFactionMember(oPC, FALSE);
			
			while(GetIsObjectValid(oFM))
			{
				object oInvItem = GetFirstItemInInventory(oFM);	//Iterate through the inventory of each faction member till I find the recipe.
				while(GetIsObjectValid(oInvItem))
				{
					if(GetTag(oInvItem) == GetTag(oItem))	//If I find a single copy of the recipe...
					{
						if(!bItemFound)						
						{
							PrettyDebug("Item Found!");
							bItemFound = TRUE;
						}
						
						else
						{
							PrettyDebug("Dupe Item Found! Deleting dupe item.");
							DestroyObject(oInvItem, 0.0f, FALSE);	//remove all copies of the recipe after the first.
						}
					}
					
					oInvItem = GetNextItemInInventory(oFM);
				}
				
				oFM = GetNextFactionMember(oPC, FALSE);
			}	
		}
	 }
	// object oItem = GetModuleItemAcquired();
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//recipe test
    int nItemType = GetBaseItemType(oItem);

	// return if it's a recipe or incantation (enchantment)
	if ((nItemType == 145) || (nItemType == 146)) 
	{
		object oPC = GetModuleItemAcquiredBy();
		string sTag = GetTag(oItem);
		SetLocalInt(oPC, sTag, TRUE);
		return;
	} 
	//@@@@@@recipe test
	if(GetBaseItemType(oItem) == 145)	//Recipes are itemtype 145
	 {
	 	object oPC = GetModuleItemAcquiredBy();
		string sTag = GetTag(oItem);
	 	object oFM = GetFirstFactionMember(oPC, TRUE);
		
		while(GetIsObjectValid(oFM))
		{
			int bItemFound = FALSE;
			object oInvItem = GetFirstItemInInventory(oFM);	//Iterate through the inventory of each faction member till I find the recipe.
			while(GetIsObjectValid(oInvItem))
			{
				if(GetTag(oInvItem) == GetTag(oItem))	//If I find a single copy of the recipe...
				{
					if(!bItemFound)						
					{
						PrettyDebug("Item Found!");
						SetLocalInt(oFM, sTag, TRUE);	//Set the int true and flag that I've found the item.
						bItemFound = TRUE;
					}
					
					else
					{
						PrettyDebug("Dupe Item Found! Deleting dupe item.");
						DestroyObject(oInvItem, 0.0f, FALSE);	//remove all copies of the recipe after the first.
					}
				}
				
				oInvItem = GetNextItemInInventory(oFM);
			}
			
			if(!bItemFound && (oFM != oPC))									//If I iterate through the whole inventory of this faction member without finding the recipe
			{
				PrettyDebug("No items found... giving " + sTag + " to " + GetName(oFM));
				CreateItemOnObject(sTag, oFM);				//Give it to him.
			}
			oFM = GetNextFactionMember(oPC, TRUE);
		}
		if(GetIsOwnedByPlayer(oPC) != TRUE)
			DestroyObject(oItem, 0.0f, FALSE);
	 }
	 
	 if(GetBaseItemType(oItem) == 146)	//Recipes are itemtype 145
	 {
	 	object oPC = GetModuleItemAcquiredBy();
		string sTag = GetTag(oItem);
	 	object oFM = GetFirstFactionMember(oPC, TRUE);
		
		while(GetIsObjectValid(oFM))
		{
			int bItemFound = FALSE;
			object oInvItem = GetFirstItemInInventory(oFM);	//Iterate through the inventory of each faction member till I find the recipe.
			while(GetIsObjectValid(oInvItem))
			{
				if(GetTag(oInvItem) == GetTag(oItem))	//If I find a single copy of the recipe...
				{
					if(!bItemFound)						
					{
						SetLocalInt(oFM, sTag, TRUE);	//Set the int true and flag that I've found the item.
						bItemFound = TRUE;
					}
					
					else
					{
						DestroyObject(oInvItem, 0.0f, FALSE);	//remove all copies of the recipe after the first.
					}
				}
				
				oInvItem = GetNextItemInInventory(oFM);
			}
			
			if(!bItemFound && (oFM != oPC))					//If I iterate through the whole inventory of this faction member without finding the recipe
			{
				CreateItemOnObject(sTag, oFM);				//Give it to him.
			}
			oFM = GetNextFactionMember(oPC, TRUE);
		}
		
		if(GetIsOwnedByPlayer(oPC) != TRUE)
			DestroyObject(oItem, 0.0f, FALSE);
	 }
	 
	 // Replace normal gems with crafting ones
	 if (GetBaseItemType(oItem) == BASE_ITEM_GEM) {
	 	string goodGem = "";
	 	if (sTag == "nw_it_gem013") goodGem = ALEXANDRITE;
		else if (sTag == "nw_it_gem003") goodGem = AMETHYST;
		else if (sTag == "nw_it_gem014") goodGem = AVENTURINE;
		else if (sTag == "nw_it_gem005") goodGem = DIAMOND;
		else if (sTag == "nw_it_gem012") goodGem = EMERALD;
		else if (sTag == "nw_it_gem002") goodGem = FIRE_AGATE;
		else if (sTag == "nw_it_gem009") goodGem = FIRE_OPAL;
		else if (sTag == "nw_it_gem015") goodGem = FLUORSPAR;
		else if (sTag == "nw_it_gem011") goodGem = GARNET;
		else if (sTag == "nw_it_gem001") goodGem = GREENSTONE;
		else if (sTag == "nw_it_gem007") goodGem = MALACHITE;
		else if (sTag == "nw_it_gem004") goodGem = PHENALOPE;
		else if (sTag == "nw_it_gem006") goodGem = RUBY;
		else if (sTag == "nw_it_gem008") goodGem = SAPPHIRE;
		else if (sTag == "nw_it_gem010") goodGem = TOPAZ;	
	 
		if (goodGem != "") {
			if (GetIsObjectValid(CreateItemOnObject(goodGem, oPC)))
				DestroyObject(oItem);		
		}
	 }
	 
     // * Generic Item Script Execution Code
     // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // * it will execute a script that has the same name as the item's tag
     // * inside this script you can manage scripts for all events by checking against
     // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
     {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACQUIRE);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }

     }

}
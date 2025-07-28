//::///////////////////////////////////////////////
//:: Example XP2 OnActivate Script Script
//:: x2_mod_def_act
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnItemActivate Event

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////

#include "kinc_trade"
#include "ginc_2da"

#include "x2_inc_switches"

void main()
{
     object oItem = GetItemActivated();
	 		 
	 // This code is used to support NX2's crafting system.
	 if(GetBaseItemType(oItem) == 145)	//Recipes are itemtype 145
	 {
	 	object oPC = GetItemActivator();
		string sTag = GetTag(oItem);
		
		int nRecipeIndex = Search2DA(NX2_CRAFTING_2DA, "RECIPE_TAG", sTag, 1);
		
		if( CheckCanCraft(nRecipeIndex, oPC, NX2_CRAFTING_2DA) )
			CraftItem(nRecipeIndex, oPC, NX2_CRAFTING_2DA);
	 }
     
	 if(GetBaseItemType(oItem) == 146)	//Incantations are itemtype 146
	 {
	 	object oPC = GetItemActivator();
		object oItemToEnchant = GetItemActivatedTarget();
		if(GetObjectType(oItemToEnchant) == OBJECT_TYPE_ITEM)
		{
			string sTag = GetTag(oItem);
		
			int nIncantIndex = Search2DA(NX2_ENCHANTING_2DA, "INCANTATION_TAG", sTag, 1);
		
			if( CheckCanEnchant(nIncantIndex, oItemToEnchant, oPC, NX2_ENCHANTING_2DA) )
				EnchantItem(nIncantIndex, oItemToEnchant, oPC, NX2_ENCHANTING_2DA);
		}
	 }
	 
	  
     // * Generic Item Script Execution Code
     // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // * it will execute a script that has the same name as the item's tag
     // * inside this script you can manage scripts for all events by checking against
     // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
     {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACTIVATE);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }

     }

}
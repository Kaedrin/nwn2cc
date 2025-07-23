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
#include "kinc_crafting"
//#include "kinc_trade"
#include "ginc_2da"
#include "x2_inc_switches"

// Added by Hyper-V
#include "nw_i0_plot"
#include "dmfi_inc_const"
#include "dmfi_inc_tool"

void main()
{
     object oItem = GetItemActivated();
	 object oPC = GetItemActivator();
	 object oUsedOn = GetItemActivatedTarget();
	 
	// VFX Tool
	if (GetTag(oItem) == "hv_vfx_tool") {
		if (GetFirstName(oPC) == "Cherry") {
			DestroyObject(oItem);
		}
		else {
	DisplayGuiScreen(oPC, "hv_vfx_tool", FALSE, "hv_vfx_tool.xml");
		}
	}
	 
	 // Pets!
	 if (GetTag(oItem) == "hv_pet") {
	 
	 	// Store pet type on PC.
		SetLocalString(oPC, "hv_pet_type", GetLocalString(oItem, "hv_pet_type"));
		ExecuteScript("hv_summon_pet", oPC);
	}
	 
	 
	 // DMFI Rename Item.
	 if (GetTag(oItem) == "dmfi_exe_tool") {
	 	if ((GetObjectType(oUsedOn)==OBJECT_TYPE_ITEM) && (!GetPlotFlag(oUsedOn))) {
			object oItemHolder = GetItemPossessor(oUsedOn);
			if ((oItemHolder==oPC) || (GetMaster(oItemHolder)==oPC))
			{
				// Name UI
				string sFirstName = GetName(oUsedOn);
				SetLocalObject(oItem, DMFI_TARGET, oUsedOn);
				DisplayGuiScreen(oPC, SCREEN_DMFI_CHGITEM, FALSE, "dmfichgitem.xml");
				SetGUIObjectText(oPC, SCREEN_DMFI_CHGITEM, "txtFirstName", -1, sFirstName);
				
				// Desc UI
				DisplayGuiScreen(oPC, "hvchange_item_desc", FALSE, "hvchange_item_desc.xml");
				SetGUIObjectText(oPC, "hvchange_item_desc", "DESC_EDIT_ITEM_NAME_TEXT", -1, sFirstName);
			}
			else {
				SendText(oPC, TXT_RENAME_INVALID_TARGET, TRUE, COLOR_RED);
			}
		}
	}
	 
	 // Added by Hyper-V - mortar and pestle essence crafting
	 // Check for Mortar tag
	 if (GetTag(oItem) == "hv_mortar") {
	 	// Check if was used on Alchemist's bench
	 	if (GetTag(oUsedOn) == "ench_alchemist_bench") {
			// Go through each line in the 2DA
			// to check the ingredients
			int i;
			int nIngredientNumber;
			string sIngredient;
			string sEssence;
			int nNumOfRows = GetNum2DARows("hv_essences_crafting");
			for (i=0; i < nNumOfRows; i++) {
				
				// Get ingredient
				sIngredient = Get2DAString("hv_essences_crafting", "Ingredient", i);
				
				// Check if 5 of it are in the bench
				nIngredientNumber = GetNumItems(oUsedOn, sIngredient);
				if (nIngredientNumber > 4) {
					// Make sure the PC has enough craft alchemy
					// skill points
					int nAlchemySkill = GetSkillRank(SKILL_CRAFT_ALCHEMY, oPC);
					if (nAlchemySkill < 10) {
						SendMessageToPC(oPC, "You don't have enough skill points.");
						return;
					}
					
					// Destory 5 of the ingredient from the bench
					DestroyItems(oUsedOn, sIngredient, 5);
					
					// Get the essence to create
					sEssence = Get2DAString("hv_essences_crafting", "Essence", i);
					
					// Create essence on player
					CreateItemOnObject(sEssence, oPC);
				}
			}
		}
	}
	// @@@@@@ End of Hyper-V essence crafting
		 
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
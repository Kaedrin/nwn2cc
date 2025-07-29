///////////////////////////////////////////////////////////////////////////////
//  C Daniel Vale 2007
//  djvale@gmail.com
//
//  C Laurie Vale 2007
//  charlievale@gmail.com
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Script Name:gui_vn_mdp_moditem
// Description: starts the item modifier GUI
//  The PC's original item is copied twice. The MODIFY_ITEM is used to keep
//   track of changes the PC wants to make until they have paid for them
//  The REMOVAL_MODIFY_ITEM keeps track of the value of the item with properties
//      removed. As the cost of the modification is worked by taking the difference
//      between the cost of the original item and the modified item and applying a
//      multiplyer a PC could remove properties, then add some for free.  To stop THIS
//  we remove properties from both the REMOVAL_MODIFY_ITEM and the MODIFY_ITEM
//      and add properties ONLY to the MODIFY_ITEM and then work the cost by
//  taking the difference in value between the REMOVAL_MODIFY_ITEM and the
//  MODIFY_ITEM and applying a multiplyer.  If a PC only removes properties
//  it will be free as the REMOVAL_MODIFY_ITEM will be worth less than the
//  MODIFY_ITEM.
////////////////////////////////////////////////////////////////////////////////

#include "vn_mod_switches"
#include "vn_mdp_gui"
#include "vn_mdp__inc"

void main()
{
	object oPC;
	object oOriginalItem;
	
	// if this is being run as an override, initialise the mdp system
	if (MDP_OVERRIDE_CRAFTING)
	{
		if (MDP_RESTRICT_CRAFTER_IN_OVERRIDE)
			SetModuleSwitch(MODULE_SWITCH_MDP_CRAFTER_RESTRICTIONS, TRUE);
		else
			SetModuleSwitch(MODULE_SWITCH_MDP_CRAFTER_RESTRICTIONS, FALSE);
	}
	
	int nModuleRestriction = GetModuleSwitchValue(MODULE_SWITCH_MDP_CRAFTER_RESTRICTIONS);
	
	oPC = GetPCSpeaker();
	if (oPC==OBJECT_INVALID)// didn't start through conversation
	{
		oPC = GetControlledCharacter(OBJECT_SELF);
		object oArea = GetArea(oPC);
		string sDevAreaTag = GetStringLeft(GetTag(oArea),7);
		
		oOriginalItem = GetPlayerCurrentTarget(oPC);
		CloseGUIScreen(oPC,"SCREEN_PLAYERMENU_POPUP"); // just incase it was started via the player menu
		// can't start from the player menu if the module has module restrictions set true
		// unless player is a DM or DM Possessed
		if(nModuleRestriction)
		{
			if (GetIsDM(oPC) || GetIsDMPossessed(oPC) || MDP_OVERRIDE_CRAFTING || sDevAreaTag == "vn_dev_")
			{
				if (!GetIdentified(oOriginalItem))
				{
					SetIdentified(oOriginalItem,TRUE);
					SendMessageToPC(oPC,"Identified Item");
				}		
				SetLocalObject(oPC,"ORIGINAL_ITEM", oOriginalItem);
			}
			else
			{
				FloatingTextStringOnCreature("You are not allowed to run the item modifier from the player menu. Please find a crafter if you wish to modify an item.",oPC,FALSE,5.0);
				return;
			}
		}
		else
			SetLocalObject(oPC,"ORIGINAL_ITEM", oOriginalItem);	
	}
	else
		oOriginalItem = GetLocalObject(oPC,"ORIGINAL_ITEM");
	
	if (!GetIsObjectValid(oOriginalItem))
	{
		FloatingTextStringOnCreature("Open your inventory and right-click target the item you want to modify before choosing Modify Item ",oPC,FALSE,5.0);
		return;
	}
			

	
	int nFirstValidRemovalPropertyNum;
	
	if (GetPlotFlag(oOriginalItem))
	{
		SendMessageToPC(oPC,"You cannot modify a PLOT item.");
		return;
	}
	
	if (!GetIdentified(oOriginalItem))
		return;
		
	if (!GetIsItemCraftable(GetBaseItemType(oOriginalItem)))
	{
		FloatingTextStringOnCreature("This type of item can NOT be modified.",oPC,FALSE,5.0);
		return;
	}
	object oModifyChest = GetObjectByTag("vn_mdp_safe_chest");
	
	if (!GetIsObjectValid(oModifyChest))
	{
		location lHere = GetLocation(oPC);
		oModifyChest = CreateObject(OBJECT_TYPE_PLACEABLE,"vn_mdp_campaignchest",lHere,FALSE,""); 
		SetLocalInt(oPC,"DestroyChest",1);
	}

	SetLocalObject(oPC,"ModifyChest",oModifyChest);// set the chest the PC is using to modify on them
	
	object oModifyItem = CopyItem(oOriginalItem,oModifyChest,TRUE);
	object oRemovalModifyItem = CopyItem(oOriginalItem,oModifyChest,TRUE);
	string sName = GetName(oOriginalItem);
	
	SetLocalObject(oPC,"REMOVAL_MODIFY_ITEM",oRemovalModifyItem);
	SetLocalObject(oPC,"MODIFY_ITEM",oModifyItem);
	

	DelayCommand(0.1,mdpUpdateGUIStateItemInformation(oPC));
	DelayCommand(0.1,mdpUpdateGUIStateItemModifications(oPC));
	
	DisplayGuiScreen(oPC, "SCREEN_VN_ITEM_PROPERTIES", FALSE, "vn_item_properties.xml");
	DisplayGuiScreen(oPC, "SCREEN_VN_ITEM_MODIFICATIONS", FALSE, "vn_item_modifications.xml");
	SetGUIObjectText(oPC,"SCREEN_VN_ITEM_PROPERTIES","TXT_ITEM_NAME_CHANGE",-1,sName);
	SendMessageToPC(oPC,"Starting Item Modification GUI");

}
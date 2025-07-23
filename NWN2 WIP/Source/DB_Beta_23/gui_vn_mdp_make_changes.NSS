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
// Script Name: gui_vn_mdp_make_changes
// Description: modify item, take gold and update GUI
//   We use a MODIFY_ITEM and REMOVAL_MODIFY_ITEM to cost the modifications
//   The MODIFY_ITEM only needs destroying when the GUI closes, but to
//   keep the costing correct we need to make a new REMOVAL_MODIFY_ITEM
//   everytime a PC pays for a change, as the REMOVAL_MODIFY_ITEM is to
//   stop them removing a property and putting a new property of the same
//   value on and getting the change for free.
////////////////////////////////////////////////////////////////////////////////

#include "vn_mdp_gui"

void main(string sItemName)
{
	object oPC=GetControlledCharacter(OBJECT_SELF);
	object oOriginalItem = GetLocalObject(oPC,"ORIGINAL_ITEM");
	object oModifyItem = GetLocalObject(oPC,"MODIFY_ITEM");
	object oRemovalModifyItem = GetLocalObject(oPC,"REMOVAL_MODIFY_ITEM");
	object oModifyChest = GetLocalObject(oPC,"ModifyChest");
	int nModCost = VerifyModificationCost(oPC);


	if (GetIsDM(oPC) || GetIsDMPossessed(oPC) || (MDP_FOR_FREE))
	{
		 DestroyObject(oOriginalItem);
		 DestroyObject(oRemovalModifyItem);
		 oRemovalModifyItem=CopyItem(oModifyItem,oModifyChest,TRUE);
		 SetLocalObject(oPC,"REMOVAL_MODIFY_ITEM",oRemovalModifyItem);
		 oOriginalItem=CopyItem(oModifyItem,oPC,TRUE);
		 SetFirstName(oOriginalItem,sItemName);
		 SetLocalObject(oPC,"ORIGINAL_ITEM",oOriginalItem);
		 // Resets the item as unchanged so PC can make additional changes
		 SetLocalInt(oPC,"ITEM_CHANGED", FALSE);
	}
	
	else if (SurrenderGold(oPC,nModCost))
	{
		 DelayCommand(1.0,DestroyObject(oOriginalItem));
		 DestroyObject(oRemovalModifyItem);
		 oRemovalModifyItem=CopyItem(oModifyItem,oModifyChest,TRUE);
		 SetLocalObject(oPC,"REMOVAL_MODIFY_ITEM",oRemovalModifyItem);
		 oOriginalItem=CopyItem(oModifyItem,oPC,TRUE);
		 SetFirstName(oOriginalItem,sItemName);
		 SetLocalObject(oPC,"ORIGINAL_ITEM",oOriginalItem);
		 // Resets the item as unchanged so PC can make additional changes
		 SetLocalInt(oPC,"ITEM_CHANGED", FALSE);
	}
	else
		 SendMessageToPC(oPC,"You don't seem to have enough gold");
	
	SetGUIObjectText(oPC,"SCREEN_VN_ITEM_PROPERTIES","TXT_ITEM_NAME_CHANGE",-1,sItemName);
	DelayCommand(0.1,mdpUpdateGUIStateItemInformation(oPC));

}
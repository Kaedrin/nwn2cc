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
// Script Name: gui_vn_mdp_change_name
// Description: change an item's name from a GUI
////////////////////////////////////////////////////////////////////////////////

#include "vn_mdp_gui"

void main(string sItemName)
{
	object oPC=GetControlledCharacter(OBJECT_SELF);
	object oOriginalItem = GetLocalObject(oPC,"ORIGINAL_ITEM");
	object oModifyItem = GetLocalObject(oPC,"MODIFY_ITEM");
	object oRemovalModifyItem = GetLocalObject(oPC,"REMOVAL_MODIFY_ITEM");

	object oModifyChest = GetObjectByTag("vn_mdp_safe_chest");

	// We have to work off a copy as we can't change the name
	// of the item in the PC's inventory
	// To stop them getting IP changes for free we actually make another copy
	// of their "original Item" that way any changes they are working on but
	// haven't paid for won't be lost
	// we have to set the new name to both the NameChangeCopy and the 
	// Modify Item copy so if the PC decides to go ahead with planned changes
	// they will have an item with the new name at the end of the process	


	object oNameChangeCopy = CopyItem(oOriginalItem,oModifyChest,TRUE);
	
	SetFirstName(oModifyItem,sItemName);
	SetFirstName(oNameChangeCopy,sItemName);
	DestroyObject(oOriginalItem);
	oOriginalItem=CopyItem(oNameChangeCopy,oPC,TRUE);
	SetLocalObject(oPC,"ORIGINAL_ITEM",oOriginalItem);
	DestroyObject(oNameChangeCopy);
	
	SetGUIObjectText(oPC,"SCREEN_VN_ITEM_PROPERTIES","TXT_ITEM_NAME_CHANGE",-1,sItemName);
	DelayCommand(0.1,mdpUpdateGUIStateItemInformation(oPC));

}
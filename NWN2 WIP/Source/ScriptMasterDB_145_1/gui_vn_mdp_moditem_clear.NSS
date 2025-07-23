//-----------------------------------------------------------------------------
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
//------------------------------------------------------------------------------
// Script Name:gui_vn_mdp_moditem_clear
// Description: closes the moditem gui's, destroys all copies
//		and clears the local objects
//------------------------------------------------------------------------------
#include "vn_mdp_gui"

void main()
{
	object oPC=GetControlledCharacter(OBJECT_SELF);
	object oArea=GetArea(oPC);
	object oModule=GetModule();
	object oModifyItem = GetLocalObject(oPC,"MODIFY_ITEM");
	object oOriginalItem = GetLocalObject(oPC,"ORIGINAL_ITEM");
	object oRemovalModifyItem = GetLocalObject(oPC,"REMOVAL_MODIFY_ITEM");
	object oModifyChest = GetLocalObject(oPC,"ModifyChest");
	
	DestroyObject(oModifyItem);
	DestroyObject(oRemovalModifyItem);

	if (GetLocalInt(oPC,"DestroyChest"))// only destroy modify chest in campaigns
		DestroyObject(oModifyChest);
	
	DeleteLocalObject(oPC,"ModifyChest");
	DeleteLocalObject(oPC,"REMOVAL_MODIFY_ITEM");
	DeleteLocalObject(oPC,"ORIGINAL_ITEM");
	DeleteLocalObject(oPC,"MODIFY_ITEM");
	DeleteLocalInt(oPC,"ITEM_CHANGED");	
	
	// clean up previous choices

	DeleteLocalInt(oPC, "MDP_SelectionLevel");
	DeleteLocalInt(oPC, "MDP_IMS_TableLevel");
	DeleteLocalInt(oPC, "MDP_PropertySelectionPageOffset");	
		
	DeleteLocalString(oPC, "MDP_PropertySelection2DA0");
	DeleteLocalString(oPC, "MDP_PropertySelection2DA1");
	DeleteLocalString(oPC, "MDP_PropertySelection2DA2");
	DeleteLocalString(oPC, "MDP_PropertySelection2DA3");
	
	DeleteLocalInt(oPC, "MDP_PropertySelectionRow0");
	DeleteLocalInt(oPC, "MDP_PropertySelectionRow1");
	DeleteLocalInt(oPC, "MDP_PropertySelectionRow2");
	DeleteLocalInt(oPC, "MDP_PropertySelectionRow3");
	
	DeleteLocalInt(oPC, "MDP_PropertySelectionIndex0"); 
	DeleteLocalInt(oPC, "MDP_PropertySelectionIndex1"); 
	DeleteLocalInt(oPC, "MDP_PropertySelectionIndex2"); 
	DeleteLocalInt(oPC, "MDP_PropertySelectionIndex3"); 
		
	
	SetGUIObjectHidden(oPC, "SCREEN_VN_ITEM_MODIFICATIONS", "ERROR_NO_PROPERTIES", TRUE);
	SetGUIObjectDisabled(oPC, "SCREEN_VN_ITEM_MODIFICATIONS", "ERROR_NO_PROPERTIES", TRUE);

	CloseGUIScreen(oPC, "SCREEN_VN_ITEM_PROPERTIES");
	SendMessageToPC(oPC,"Closing Item Modifier GUI's");

}
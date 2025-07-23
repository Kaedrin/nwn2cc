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
// Script Name: gui_vn_mdp_remove_property
// Description: remove an item property
//		this removes the property from the MODIFY_ITEM and the 
//		REMOVAL_MODIFY_ITEM only.  We use two modify items for
//		costing purposes see:gui_vn_mdp_moditem
//		when a PC chooses "make changes" and pays then their
//		original item is destroyed and the modified item with any
//		properties removed or added is given to them.
////////////////////////////////////////////////////////////////////////////////
#include "vn_mdp_gui"
void main(int nListBoxRow)
{
	object oPC=GetControlledCharacter(OBJECT_SELF);
	object oOriginalItem = GetLocalObject(oPC,"ORIGINAL_ITEM");
	object oModifyItem = GetLocalObject(oPC,"MODIFY_ITEM");
	object oRemovalModifyItem = GetLocalObject(oPC,"REMOVAL_MODIFY_ITEM");
	int nPropertyNumber = nListBoxRow + 1; // listbox nums start at 0
	
	// we need to remove the properties from both copy's of the original for pricing purposes
	itemproperty ipModifyRemove = GetItemProperty(oModifyItem, nPropertyNumber);
	itemproperty ipRemovalModifyRemove = GetItemProperty(oRemovalModifyItem, nPropertyNumber);
	if ( ! GetIsRemovalDisallowed(ipModifyRemove))
	{
		RemoveItemProperty(oModifyItem, ipModifyRemove);
		RemoveItemProperty(oRemovalModifyItem, ipRemovalModifyRemove);
	}
	
	SetLocalInt(oPC,"ITEM_CHANGED",TRUE);
	// needs a delay or GUI doesn't update correctly
	// pcs won't notice the delay
	DelayCommand(0.1,mdpUpdateGUIStateItemInformation(oPC));
	DelayCommand(0.1,mdpUpdateGUIStateItemModifications(oPC));
	
	

}
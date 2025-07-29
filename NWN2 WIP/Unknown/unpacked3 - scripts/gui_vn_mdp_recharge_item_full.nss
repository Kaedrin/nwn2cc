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
// Script Name: gui_vn_mdp_recharge_item_full
// Description: recharge an item
////////////////////////////////////////////////////////////////////////////////
#include "vn_mdp_gui"
void main()
{
	object oPC=GetControlledCharacter(OBJECT_SELF);
	object oOriginalItem = GetLocalObject(oPC,"ORIGINAL_ITEM");
	object oModifyItem = GetLocalObject(oPC,"MODIFY_ITEM");
	object oRemovalModifyItem = GetLocalObject(oPC,"REMOVAL_MODIFY_ITEM");

	SetLocalInt(oPC,"ITEM_CHANGED", TRUE);
	SetItemCharges(oModifyItem,50);
	SetItemCharges(oRemovalModifyItem, 50);
	
	// need to add and remove a spell to get the correct cost for adding charges
	// doesn't matter if this is the same as spell already on the item
	itemproperty ip = ItemPropertyCastSpell(IP_CONST_CASTSPELL_AID_3, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE); 
	AddItemProperty(DURATION_TYPE_PERMANENT, ip, oModifyItem);
	RemoveItemProperty(oModifyItem, ip);
	
	DelayCommand(0.1,mdpUpdateGUIStateItemInformation(oPC));
	
	
}
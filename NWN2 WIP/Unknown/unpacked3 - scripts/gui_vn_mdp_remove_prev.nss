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
// Script Name:gui_vn_mdp_remove_prev
// Description: go to the previous property on the item
// 		won't dispay properties that PC isn't allowed to remove i.e
// 		useable by sorcer              
////////////////////////////////////////////////////////////////////////////////
#include "vn_mdp_gui"

void main()
{
	object oPC=GetControlledCharacter(OBJECT_SELF);
	object oModifyItem = GetLocalObject(oPC,"MODIFY_ITEM");
	int nPropertyNumber = GetLocalInt(oPC,"PROPERTY_TO_REMOVE_NUM");

	
	nPropertyNumber = GetPreviousValidRemovalProperty(oModifyItem,nPropertyNumber);	
	SetLocalInt(oPC,"PROPERTY_TO_REMOVE_NUM",nPropertyNumber);
	mdpUpdateGUIStateItemModifications(oPC);

}
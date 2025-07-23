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
//  Script Name: gui_vn_mdp_prop_select
//  Description: Construct an item property from button selection in the gui.
//------------------------------------------------------------------------------ 
// itemprops.2da - list what properties an item can have
// itempropdef.2da - starting point: property, sub type, cost table, cost.

#include "vn_mdp_gui"
#include "vn_inc_gui"

void main(int nRowNum)
{
	nRowNum++; // gui rows start at 0
	object oPC=GetControlledCharacter(OBJECT_SELF);
	object oOriginalItem = GetLocalObject(oPC,"ORIGINAL_ITEM");
	object oModifyItem = GetLocalObject(oPC,"MODIFY_ITEM");
	object oRemovalModifyItem = GetLocalObject(oPC,"REMOVAL_MODIFY_ITEM");
	string s2DA = GetLocalString(oPC, "MDP_IMS_2DA");
	// Get the selection information
	// 0 - Type; 1 - SubType1; 2 - SubType2
	int nSelectionLevel = GetLocalInt(oPC, "MDP_SelectionLevel");
	int nIndex = GetArrayInt(oPC, "ROW_PROPERTY_CHOICE_", nRowNum); // what this button points to in the data
	// If the client clicks fast enough it is possible to double select a button and get a dissallowed property. Prevent this:
    if ( ! ModificationTypeAllowed(oModifyItem, oPC, s2DA, nIndex)) return; 	
		
	// Advance to the next property table source
	int nTableLevel = GetLocalInt(oPC, "MDP_IMS_TableLevel");
	nTableLevel++;
	SetLocalInt(oPC, "MDP_IMS_TableLevel", nTableLevel);
	
	// Store selection history on the PC
	SetArrayString(oPC, "MDP_PropertySelection2DA", nSelectionLevel, s2DA);
	SetArrayInt(oPC, "MDP_PropertySelectionRow", nSelectionLevel, nRowNum);
	SetArrayInt(oPC, "MDP_PropertySelectionIndex", nSelectionLevel, nIndex); 

	
	Debug(
		"gui_vn_mdp_prop_select: main() - " +
		"Row = " + IntToString(nRowNum) +
		" Index = " + IntToString(nIndex)+
		" 2DA = " + s2DA
//		" Name = " + sPropertyName +
//		" Num = " + IntToString(nPropertyNum)
		, MDP
		, 3
	);
	
	// Move to the next level
	nSelectionLevel++;
	SetLocalInt(oPC, "MDP_SelectionLevel", nSelectionLevel);
	// when we refresh the page we wan to put the buttons back to the first page not
	// have to look for them
	DeleteLocalInt(oPC, "MDP_PropertySelectionPageOffset");
	// Update the GUI
	mdpUpdateGUIStateItemModifications(oPC);
	DelayCommand(0.1,mdpUpdateGUIStateItemInformation(oPC));
	
}//main
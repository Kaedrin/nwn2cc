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
//  Script Name: gui_vn_mdp_prop_next 
//  Description: 'Next' button for the item property modifier, property 
//               selection scene.
//------------------------------------------------------------------------------

#include "vn_mdp_gui"

void main()
{
	object oPC=GetControlledCharacter(OBJECT_SELF);

	// Get the current page number
	int nPage = GetLocalInt(oPC, "MDP_IMS_PageNumber");
	
	// What index did the first button point to?	
	int nIndexOfButton1 = GetArrayInt(oPC, "BTN_PROPERTY_CHOICE_", 1); 
	
	// Remember where to start this page (for the Prev button)
	SetArrayInt(oPC, "MPD_IMS_FirstButtonIndexOnPage", nPage, nIndexOfButton1);

	// What index did the last button point to?	
	int nIndexOfButton30 = GetArrayInt(oPC, "BTN_PROPERTY_CHOICE_", 30); 

	// Start the next page to start at the index after the last button
	SetLocalInt(oPC, "MDP_PropertySelectionPageOffset", nIndexOfButton30 + 1);

	// Update the page counter
	SetLocalInt(oPC, "MDP_IMS_PageNumber", nPage + 1);
	
	// Update the GUI
	mdpUpdateGUIStateItemModifications(oPC);
	DelayCommand(0.1,mdpUpdateGUIStateItemInformation(oPC));
	
	
} // main
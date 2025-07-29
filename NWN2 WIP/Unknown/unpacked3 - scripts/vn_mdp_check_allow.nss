//------------------------------------------------------------------------------
//  C Daniel Vale 2005
//  djvale@gmail.com
//
//  C Laurie Vale 2005
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
// Script Name: vn_mdp_check_allow
// Description: DO NOT MODIFY
//	 The MDP uses 2DA's to generate the choices a PC can make when modifying an item.
//	 This script handles the removal of invalid 2DA rows and calls any necessary
//	 checks on the valid rows. If you want to change what is available in your module make changes
//	 to "vn_mdp_check_custom_rules"
//
//------------------------------------------------------------------------------
#include "vn_inc_debug"
#include "vn_inc_array"
#include "vn_mdp__inc"
#include "vn_mod_switches"
#include "vn_mdp_check_default_rules"
#include "vn_mdp_check_custom_rules"

int mdpGetIs2DARowValid(string s2DA, int nIndex)
{

	string sColumnHeading = "Label";
	if (s2DA == "iprp_savingthrow" || s2DA == "iprp_saveelement")
		sColumnHeading = "NameString";
	else if (s2DA == "iprp_arcspell")
		sColumnHeading = "Value";
		
	// Only looking at first three characters - the full strings would be
	// "", Padding, DELETED, DEL_, Random, None, CUT, ****, INVALID_RACE
	string sLabel3 = GetStringLeft(Get2DAString(s2DA, sColumnHeading, nIndex), 3);
	string sLabelCheckInvalid = Get2DAString(s2DA, "Name", nIndex);
	
	// return FALSE on non-valid entries first - trying to improve speed
	if (sLabel3 == "") return FALSE;
	if (sLabel3 == "Non") return FALSE;
	if (sLabel3 == "pad") return FALSE;
	if (sLabel3 == "DEL") return FALSE;
	if (sLabel3 == "Ran") return FALSE;
	if (sLabel3 == "CUT") return FALSE;
	if (sLabel3 == "***") return FALSE;
	if (sLabel3 == "INV") return FALSE;
	
	// extra check for the tricky 2DA's with different column names
	// looks for an entry that when found returns BadStrRef - which means it won't go on
	
	string sEntry = Get2DAString(s2DA, "Name", nIndex);
	int nBadString = StringToInt(sEntry);
	if (nBadString == 0) return FALSE;		

	return TRUE;
}


int ModificationTypeAllowed(object oModifyItem, object oPC, string s2DA, int nIndex, int bTreasureItemModification = FALSE)
{
	int nType = GetBaseItemType(oModifyItem);
	int bValid = mdpGetModificationTypeValid(nType, s2DA, nIndex);
	if (!bValid) return FALSE;
	
	object oModule = GetModule();
	int nModuleRestriction = GetLocalInt(oModule,MODULE_SWITCH_MDP_CRAFTER_RESTRICTIONS);
	// no restrictions and we have already checked its valid - so go ahead
	
	if (! nModuleRestriction && ! MDP_RESTRICT_CRAFTER_IN_OVERRIDE)	return TRUE;
	
	int bAllowedInModule = mdpGetModificationAllowedInModule(oPC, oModifyItem, nType, s2DA, nIndex);
	if (!bAllowedInModule) return FALSE;
	// we know it's valid, we know it's allowed in the module so if no area restrictions do it
	if (!MDP_AREA_RESTRICTIONS) return TRUE;
	
	// we know it's valid, we know it's allowed in the module so if being run by the treasure system do it
	if (bTreasureItemModification) return TRUE;
	
	// area's don't matter if this is being run as an override in a local game		
	if (MDP_OVERRIDE_CRAFTING) return TRUE; 

	// DM's can craft anything the module allows in any area
	if (GetIsDM(oPC)|| GetIsDMPossessed(oPC))
		return TRUE; 
				
	object oArea = GetArea(oPC);
	string sTag = GetTag(oArea);
	string sDevArea = GetStringLeft(sTag,7);
	// we know it's valid, we know it's allowed in the module so if being run in the development areas of the module do it
	if (sDevArea == "vn_dev_") return TRUE;
	
	// we now check against the area and will return TRUE if allowe and FALSE if not
	return mdpGetModificationAllowedInArea(oPC, sTag, nType, s2DA, nIndex);
	
}

//void main(){}
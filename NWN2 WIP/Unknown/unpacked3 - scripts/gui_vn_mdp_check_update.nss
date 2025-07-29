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
//  Script Name: gui_vn_mdp_check_update(string sUIName, string sUIVersion)
//  Description: Check if the UI is the most up to date version.
//               This checks to see if there is a version difference between the 
//               client's UI xml code and the server's script.
//               + sUIName and sUIVersion are as listed below.
//------------------------------------------------------------------------------

#include "vn_inc_gui"

// version list


// Charlie's Item Modifier
const string VN_CHARLIE_MDP_SCENE = "vn_item_properties";
const string VN_CHARLIE_MDP_NAME = "Charlie's Item Modifier";
const int VN_CHARLIE_MDP_VERSION = 115;
	

void CheckVersion(object oPC, string sUIName, int nClientUIVersion, int nServerUIVersion)
{
	if (nClientUIVersion < nServerUIVersion)
		FloatingTextStringOnCreature("There is an update available for " + sUIName + ".", oPC);
	else if (nClientUIVersion > nServerUIVersion)
	{
		PrintString("There is an update available for " + sUIName + ".");
		SendMessageToAllDMs("There is an update available for " + sUIName + ".");
	}

}

void main(string sUIName = "", string sUIVersion="")
{
	//SendMessageToPC(GetFirstPC(), "checking UI version");
	object oPC=GetControlledCharacter(OBJECT_SELF);
	
	if (sUIName == "" || sUIVersion == "") 
	{
		// If you get this message then some .xml file is calling this script impropperly. Search for "gui_vn_check_update" in you .xml code and check the parameters.
		SendMessageToPC(oPC, "Bad UI callback to [gui_vn_check_update]");
		return; 
	}
	
	// Do once (per login/server reset).
	if (GetLocalInt(oPC, sUIName + "_Checked_For_Update")) return;
	SetLocalInt(oPC, sUIName + "_Checked_For_Update", 1);

	// Decode the version number
	int nUIVersion = DecodeGUIInt("v", sUIVersion);
	
		
	// Charlie's Item Modifier
	if (sUIName == VN_CHARLIE_MDP_SCENE)
		CheckVersion(oPC, VN_CHARLIE_MDP_NAME, nUIVersion, VN_CHARLIE_MDP_VERSION);

		
}
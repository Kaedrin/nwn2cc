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
//  Script Name: vn_mdp_toggle_restrictions
//  Description: toggles module switch on/off
//------------------------------------------------------------------------------
#include "vn_mod_switches"
void main()
{
	object oPC = GetLastUsedBy();
	string sModuleSwitch = GetLocalString(OBJECT_SELF,"module_crafter_restrictions");
	object oModule = GetModule();
	object oArea = GetArea(oPC);
	string sTag = GetTag(oArea);
	
	if (sModuleSwitch == "on")
	{
		// turn the restrictions off
		PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
		SetLocalInt(oModule,MODULE_SWITCH_MDP_CRAFTER_RESTRICTIONS,FALSE);
		SetLocalString(OBJECT_SELF,"module_crafter_restrictions","off");
		SendMessageToPC(oPC,"Module Restrictions are off");
		SendMessageToPC(oPC,"Crafter is in Area : " + sTag);
	}
	else if (sModuleSwitch == "off")
	{
		PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
		SetLocalInt(oModule,MODULE_SWITCH_MDP_CRAFTER_RESTRICTIONS,TRUE);
		SetLocalString(OBJECT_SELF,"module_crafter_restrictions","on");
		SendMessageToPC(oPC,"Module Restrictions are on");
		SendMessageToPC(oPC,"Crafter is in Area : " + sTag);
	}


}
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
// Script Name: vn_mdp_conv_disallowed 
// Description: conversation conditional
//			Some items aren't available for modification i.e. creature claws etc
//			it is better to rule them out before openning the GUI
////////////////////////////////////////////////////////////////////////////////
#include "nw_i0_plot"
#include "vn_mdp_check_default_rules"

int StartingConditional()
{
	object oPC = GetPCSpeaker();
    object oItem = GetPlayerCurrentTarget(oPC);
	string sItemTag = GetTag(oItem);
	int nType = GetBaseItemType(oItem);
	int nCraftable = GetIsItemCraftable (nType);
	if (nCraftable)
		return FALSE; // not disallowed
	else
		return TRUE;
}
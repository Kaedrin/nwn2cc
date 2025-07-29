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
// Script Name: vn_mdp_conv_getitem
// Description: conversation conditional
//		Gets PCSpeakers currently targeted object and if an item
//		sets it as a Local Object on PC for modifying. Get's name
//		to check that it is the item the PC wants to modify
//		Returns FALSE if no ITEM is targetted so that PC can target the item
//		he wants to modify
////////////////////////////////////////////////////////////////////////////////
#include "nw_i0_plot"

int StartingConditional()
{
	object oPC = GetPCSpeaker();
    object oItem = GetPlayerCurrentTarget(oPC);
	string sItemTag = GetTag(oItem);
	
	if (GetIsObjectValid(oItem)&& 
		GetObjectType(oItem)==OBJECT_TYPE_ITEM &&
		HasItem(oPC,sItemTag)&&
		GetIdentified(oItem) )
	{
		SetLocalObject(oPC,"ORIGINAL_ITEM",oItem);
		SetCustomToken(100,GetName(oItem));
		return TRUE;
	}
   return FALSE;
}
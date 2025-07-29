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
//  Script Name: ga_vn_mda_launch
//  Description: Launch Charlies Item Appearance Changer, from a conversation
//------------------------------------------------------------------------------

#include "vn_mda_gui"

void main()
{
    object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	
	//SendMessageToPC(GetFirstPC(), "ga_vn_mda_launch: main()");
	
	DisplayGuiScreen(oPC, "SCREEN_VN_ITEM_APPEARANCE_CHANGER", FALSE,"vn_item_appearance_changer.xml");
	mda_SetupAppearanceChanger(oPC);
}
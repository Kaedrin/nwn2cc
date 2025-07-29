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
//  Script Name: vn_pc__inc
//  Description: Functions for accessing the player token, and data saved there.
//------------------------------------------------------------------------------
// Orios Token : Identifies players who have accepted the rules.
const string PLAYER_TOKEN = "pc_playertoken";

// PC's can control companions. If PC is controlling companion
// and triggers a script GetIsPC will return TRUE and the script
// will fire on the companion and not the PC themselves
// if you don't want that to happen, after you get the PC
// eg GetPCSpeaker, run GetPCCharacter(oPC) and it will find
// the Player's Character
// When a PC is controlling a companion you can get the 
// PCPlayer name of the PC

object GetPCCharacter(object oPC)
{
	string sLogin = GetPCPlayerName(oPC);
	object oPlayerCharacter = GetLocalObject(GetModule(),sLogin);
	
	return oPlayerCharacter;
}
int GetIsPossessedCompanion(object oPC)
{
	int nPossessedCompanion = FALSE;
	string sLogin = GetPCPlayerName(oPC);
	object oPlayerCharacter = GetLocalObject(GetModule(),sLogin);
	if (oPC != oPlayerCharacter)
		nPossessedCompanion = TRUE;
		
	return nPossessedCompanion;
}
object GetPlayerToken(object oPC)
{
	string sLogin = GetPCPlayerName(oPC);
	string sPlayerToken = sLogin + "Token";	
	
	object oPCToken = GetLocalObject(GetModule(),sPlayerToken);
	return oPCToken;
}

location GetTokenLocation(object oPC, string sVarName)
{
	object oToken = GetPlayerToken(oPC);
	return GetLocalLocation(oToken, sVarName);
}

void SetTokenLocation(object oPC, string sVarName, location lLoc)
{
	object oToken = GetPlayerToken(oPC);
	SetLocalLocation(oToken, sVarName, lLoc);
}

void DeleteTokenLocation(object oPC, string sVarName)
{
	object oToken = GetPlayerToken(oPC);
	DeleteLocalLocation(oToken, sVarName);
}
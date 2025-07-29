/*

    Script:			Causes the calling object to speak a oneline message from the local module based upon a Variable ID Name.
					Local module variables are set during Module Initialization pulled from the database.
	Version:		1.01
	Plugin Version: 1.5
	Last Update:	11/24/2010
	Author:			Marshall Vyper
	Parameters:		string sBanterID, int iBanterChance
	
	Change Log:		1.00 - MV - Initial Version
					1.01 - 06/23/2011 - MV - Added support for AI banter when leaving combat range.

*/

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_banter_include"




// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main(string sBanterID, int iBanterChance, string sEvent)
{
	// If the BANTER Plugin is not active, don't do anything.
	if (!GetLocalInt(GetModule(), "LEG_BANTER_ACTIVE"))
		return;

	// Find out if there is a forced ID and use that instead of the local variable ID.
	if (sBanterID == "")
	{
		// No ID was passed so lets look at the event and grab it from there.
		if (sEvent == "Death")
			sBanterID = GetLocalString(OBJECT_SELF, "LEG_BANTER_OnDeath");
		else if (sEvent == "PercepSeen")
			sBanterID = GetLocalString(OBJECT_SELF, "LEG_BANTER_OnPercep");
		else if (sEvent == "PercepHeard")
			sBanterID = GetLocalString(OBJECT_SELF, "LEG_BANTER_OnPercepHeard");
		else if (sEvent == "PercepVanish")
			sBanterID = GetLocalString(OBJECT_SELF, "LEG_BANTER_OnPercepVanish");
		else if (sEvent == "LegAIRange")
			sBanterID = GetLocalString(OBJECT_SELF, "LEG_BANTER_OnAIRange");
		else if (sEvent == "Convo")
			sBanterID = GetLocalString(OBJECT_SELF, "LEG_BANTER_ID");
	}

	// This NPC or monster may not be configured to use BANTER.  If that's the case, just ignore.
	if (sBanterID == "")
		return;
			
	// Randomly find a Oneliner using either the passed ID or the Local Variable ID.
	int iRandomNum = 0;
	int iMaxOneliners = GetLocalInt(GetModule(), sBanterID + "_Count");
	iRandomNum = Random(iMaxOneliners) + 1;
	string sOneliner = GetLocalString(GetModule(), sBanterID + IntToString(iRandomNum));
	
	// Use a default message if it is using default or someone forgot to put an entry in the database
	// that matches the ID.
	if (sOneliner == "")
		sOneliner = LEG_BANTER_DEFAULTMSG;

	// If the script was called with a specific ID and chance, use that chance instead of the variable one.
	if (iBanterChance == 0)
		iBanterChance = GetLocalInt(OBJECT_SELF, "LEG_BANTER_Chance");
		
	// Do the talking based on the chance to talk variable!  (Default is alway speak it).
	if (d100() <= iBanterChance || iBanterChance == 0)
		ActionSpeakString(sOneliner);
}
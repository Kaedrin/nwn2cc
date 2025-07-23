/*

    Script:			Script that applies Feat effects that we have from our Lore Books.
	Version:		1.01
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		N/A
	
	Change Log:		06/23/2011 - 1.00 MV - Initial Release
	
*/


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_quest_include"


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// Get a listing of feats and apply the ones the PC has.
	SQLExecDirect("SELECT `FeatID` FROM `" + QUESTPREFIX + "_rewarditems` WHERE `FeatID` != ''");
	while (SQLFetch())
	{
		// Grab the feat ID.
		int iFeat = StringToInt(SQLGetData(1));

		// For each feat, we run the Give Feat function which not only applies feat effects, but also
		// checks to see if the PC even HAS the feat.
		LEG_QUEST_GiveFeat(OBJECT_SELF, iFeat);
	}
}
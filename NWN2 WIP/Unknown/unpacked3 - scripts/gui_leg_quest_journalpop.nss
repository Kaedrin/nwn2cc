/*

    Script:			When the Journal is up and the PC presses the Quest button.  This passes
					the proper variables to the journal switching script to load the data for the
					next page.
	Version:		1.01
	Plugin Version: 1.72
	Last Update:	06/23/2011
	Author:			Marshall Vyper
	Parameters:		N/A
	
	Change Log:		06/23/2011 - 1.00 MV - Initial Release
					12/27/2011 - 1.01 MV - Fixed journal item bug not displaying correctly.
	
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
	// Call the Journal Switch script and load its GUI data.
	string sJournalScreen;
	if (JOURNAL_OVERRIDE == 0)
		sJournalScreen = "leg_quest_journal";
	else
		sJournalScreen = "SCREEN_JOURNAL";
	AddScriptParameterString("0");
	AddScriptParameterString("Quests");
	AddScriptParameterString(sJournalScreen);
	ExecuteScriptEnhanced("leg_quest_journalswitch", OBJECT_SELF);
}
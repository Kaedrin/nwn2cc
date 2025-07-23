/*

    Script:			Consolodated script to allow each GUI POP to use the same code.  This lets the PC switch from
					quest list to quest list in their journal.
	Version:		1.02
	Plugin Version: 1.72
	Author:			Marshall Vyper
	Parameters:		N/A
	
	Change Log:		06/23/2011 - 1.00 MV - Initial Release
					12/23/2011 - 1.01 MV - Fixed bug where empty journal entry would appear on finish of repeat quest with no timer.
					12/27/2011 - 1.02 MV - Fixed journal item bug not displaying correctly.
*/


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_quest_include"


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main(string sQuestType, string sQuestTypeName, string sGUI)
{
	// Set up some variables, grab the journal screen and lets start populating it!
	int iCount = 0;
	string sTableID = LEG_COMMON_GetPCTable(OBJECT_SELF, "quests");
	string sQuestCount, sQuest;
	int iSecondCount;
	string sQuestTitle;

	// No those are not TIME seconds, its just another counter.  Clear all the entries in the current 
	// quest list and disable and re-enable the boxes.  Helps to clear them up when swapping between
	// quest types.
	for (iSecondCount = 0; iSecondCount < MAXQUESTS; iSecondCount++)
	{
		SetLocalString(OBJECT_SELF, "Temp1_" + IntToString(iSecondCount), "");
		RemoveListBoxRow(OBJECT_SELF, sGUI, "JOURNAL_LIST", "ROW_" + IntToString(iSecondCount));
	}	
	
	// Grab the PC's current quests.
	SQLExecDirect("SELECT * FROM `" + sTableID + "` WHERE `name` LIKE '%NPC%' AND `val` != '0' AND `val` != '999' AND `val` != '998' AND `questtype`='" + sQuestType + "'");
	while(SQLFetch())
	{
		// Get the Quest ID for each quest and store them in a temporary fake variable array.
		sQuest = SQLGetData(3);
		SetLocalString(OBJECT_SELF, "Temp1_" + IntToString(iCount), GetStringRight(GetStringLeft(sQuest, 12), 4));
		iCount++;	
	}

	// Using our super duper Second counter again, we cycle through the number of active quests we have.
	for (iSecondCount = 0; iSecondCount < iCount; iSecondCount++)
	{
		// Set the Text for each button to be the active quest title.
		SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_mainquests` WHERE `QuestID` = '" + GetLocalString(OBJECT_SELF, "Temp1_" + IntToString(iSecondCount)) + "'");
		SQLFetch();
		sQuestTitle = SQLGetData(27);
		sQuest = SQLGetData(3);
		//SetGUIObjectText(OBJECT_SELF, sGUI, "JOURNAL_TEXT" + IntToString(iSecondCount), -1, sQuestTitle);	
		AddListBoxRow(OBJECT_SELF, sGUI, "JOURNAL_LIST", "ROW_" + IntToString(iSecondCount), "JOURNAL_TEXT0=" + sQuestTitle, "", "15=" + sQuest, "");
	}	

	// Clean up Previous Screen details
	SetGUIObjectText(OBJECT_SELF, sGUI, "title", -1, "");
	SetGUIObjectText(OBJECT_SELF, sGUI, "questdetails", -1, "");
	SetGUIObjectText(OBJECT_SELF, sGUI, "REWARDS", -1, "");
	SetGUIObjectText(OBJECT_SELF, sGUI, "OFFER_REWARDS1", -1, "");
	SetGUIObjectText(OBJECT_SELF, sGUI, "OFFER_REWARDS2", -1, "");
	SetGUIObjectText(OBJECT_SELF, sGUI, "OFFER_REWARDS3", -1, "");
	SetGUITexture(OBJECT_SELF, sGUI, "OFFERED_ICON1", "");
	SetGUITexture(OBJECT_SELF, sGUI, "OFFERED_ICON2", "");			
	SetGUITexture(OBJECT_SELF, sGUI, "OFFERED_ICON3", "");						
	SetGUITexture(OBJECT_SELF, sGUI, "TYPE1", "");						
	SetGUITexture(OBJECT_SELF, sGUI, "TYPE2", "");								
	
	// Add some more info and apply the icon and details to the GUI.
	sQuestCount = IntToString(iCount) + " of " + IntToString(MAXQUESTS) + " " + sQuestTypeName + " Currently Active";
	SetGUIObjectText(OBJECT_SELF, sGUI, "counttitle", -1, sQuestCount);	
	SetGUIObjectText(OBJECT_SELF, sGUI, "MAINTITLE", -1, sQuestTypeName);
	if (sQuestType == "0")
		SetGUITexture(OBJECT_SELF, sGUI, "JOURNAL_ICON", "qj_icon.tga");		
	else if (sQuestType == "1")
		SetGUITexture(OBJECT_SELF, sGUI, "JOURNAL_ICON", "spellbook_icon.tga");			
	else if (sQuestType == "2")
		SetGUITexture(OBJECT_SELF, sGUI, "JOURNAL_ICON", "char_icon.tga");			
	else if (sQuestType == "3")
		SetGUITexture(OBJECT_SELF, sGUI, "JOURNAL_ICON", "store_icon.tga");			
}
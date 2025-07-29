/*

    Script:			This populates the journal GUI detail section when one of the active quests
					are clicked on.
	Version:		1.01
	Plugin Version: 1.72
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
void main(string sQuestName)
{
	// The title of the quest is all we can pass back from the GUI so we have to figure out what
	// the quest ID based on that.  THIS is why we need unique quest titles.
	string sSQLQuestName = SQLEncodeSpecialChars(sQuestName);
	
	// If for some reason, the name of the quest doesn't come back correctly, just exit.
	if (sQuestName == "")
		return;
	
	// Now let's grab the quest ID.
	SQLExecDirect("SELECT `QuestID` FROM `" + QUESTPREFIX + "_mainquests` WHERE `Title` = '" + sSQLQuestName + "'");
	SQLFetch();
	string sQuestID = SQLGetData(1);

	// Grab the PC's current objectives.
	string sTableID = LEG_COMMON_GetPCTable(OBJECT_SELF, "quests");
	int iNPC = GetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_NPC", sTableID);
	int iPCObj1 = GetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ1", sTableID);
	int iPCObj2 = GetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ2", sTableID);
	int iPCObj3 = GetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ3", sTableID);
	int iPCObj4 = GetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ4", sTableID);
	int iPCObj5 = GetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ5", sTableID);
	int iPCObj6 = GetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ6", sTableID);
	int iPCObj7 = GetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ7", sTableID);
	int iPCObj8 = GetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ8", sTableID);
	int iPCObj9 = GetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ9", sTableID);
	int iPCObj10 = GetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ10", sTableID);					

	// Get the details of the quest from its table.	
	SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_mainquests` AS t1, `" + QUESTPREFIX + "_questheader` AS t2, `" + QUESTPREFIX + "_questnpcs` AS t3 WHERE t1.`QuestID`=t2.`QuestID` AND t1.`QuestID` = " + sQuestID + " AND t1.`QuestNPC` = " + IntToString(iNPC) + " AND t1.`NPCTag` = t3.`NPCTag`");
	SQLFetch();	
	
	// Start the Offer Process
	string sObjectiveText1 = SQLGetData(4);
	string sObjectiveText2 = SQLGetData(5);
	string sObjectiveText3 = SQLGetData(6);
	string sObjectiveText4 = SQLGetData(7);
	string sObjectiveText5 = SQLGetData(8);
	string sObjectiveText6 = SQLGetData(9);
	string sObjectiveText7 = SQLGetData(10);
	string sObjectiveText8 = SQLGetData(11);
	string sObjectiveText9 = SQLGetData(12);
	string sObjectiveText10 = SQLGetData(13);				
	int iObjective1 = StringToInt(SQLGetData(14));
	int iObjective2 = StringToInt(SQLGetData(15));
	int iObjective3 = StringToInt(SQLGetData(16));
	int iObjective4 = StringToInt(SQLGetData(17));
	int iObjective5 = StringToInt(SQLGetData(18));
	int iObjective6 = StringToInt(SQLGetData(19));
	int iObjective7 = StringToInt(SQLGetData(20));
	int iObjective8 = StringToInt(SQLGetData(21));
	int iObjective9 = StringToInt(SQLGetData(22));
	int iObjective10 = StringToInt(SQLGetData(23));					
	string sOfferText = SQLGetData(24);
	string sContinueText = SQLGetData(25);
	string sFinishText = SQLGetData(26);
	string sTitle = SQLGetData(27);
	string sRewards = SQLGetData(30);
	int iLevel = StringToInt(SQLGetData(31));
	int iGroupType = StringToInt(SQLGetData(32));
	string sNPCName = SQLGetData(35);
	
	// Initialize some variables that we'll use in a moment.
	string sIcon1;
	string sDescription1;
	string sIcon2;
	string sDescription2;
	string sIcon3;
	string sDescription3;
	string sQty;	
	
	// This is required as a result of the bug found now that the quest tool can select pre-existing items
	// from the items table as rewards.  The order of the items go out of sync.
	int iRewardCounter = 0;
	SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_questrewards` AS t1, `" + QUESTPREFIX + "_rewarditems` AS t2 WHERE t1.`QuestID`='" + sQuestID + "' AND t1.`Action`='GIVEITEM' AND t1.`Parameter1` = t2.`ResRef`");
	while (SQLFetch())
	{
		// Kick off a counter.  We allow up to 3 rewards.
		iRewardCounter++;
		
		// For the each reward, let's grab the first items details such as its icon, description and how many we get.
		if (iRewardCounter == 1)
		{
			sIcon1 = SQLGetData(10);
			sDescription1 = SQLGetData(9);
			sQty = SQLGetData(4);
			if (StringToInt(sQty) > 1)
			{
				sDescription1 = sDescription1 + " x " + sQty;	
			}
		}		
		else if (iRewardCounter == 2)
		{
			sIcon2 = SQLGetData(10);
			sDescription2 = SQLGetData(9);
			sQty = SQLGetData(4);
			if (StringToInt(sQty) > 1)
			{
				sDescription2 = sDescription2 + " x " + sQty;	
			}
		}
		else
		{
			sIcon3 = SQLGetData(10);
			sDescription3 = SQLGetData(9);
			sQty = SQLGetData(4);
			if (StringToInt(sQty) > 1)
			{
				sDescription3 = sDescription3 + " x " + sQty;	
			}
		}
	}

	// Setup what TEXT based rewards we're going to display in the GUI.  These are usually the amount
	// of gold, or just Experience Points etc.  Also grab the color of the difficulty of the quest based
	// on the players level and the recommended quest level.
	sRewards = LEG_QUEST_RewardsText(sRewards);
	string sColor = LEG_QUEST_ChallengeColor(OBJECT_SELF, iLevel);
	string sMainText, sTypeIcon;
	
	// If the Offer Text field is empty for this NPC, then default to his Continue Text
	// This could be the Continue Text, or it could be the Reluctant Fail test.  We'll need to find out if the
	// NPC has reluctance and if the PC has passed it or not.
	int iReluctantPassed = GetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_" + IntToString(iNPC) + "_ReluctantPassed");
	
	if (sOfferText == "")
	{
				
		if (!iReluctantPassed)
		{
			SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_skills` WHERE `QuestID` = '" + sQuestID + "' AND `NPCID` = '" + IntToString(iNPC) + "';");
			while(SQLFetch())
			{
				sMainText = SQLGetData(4);
			}
		}
		else
			sMainText = sContinueText;
	}
	else
		sMainText = sOfferText;

	// Identify the NPC in the journal to help the player along.
	sMainText = sNPCName + " says, '" + sMainText + "'";

	if (iReluctantPassed)
	{
		// Setup some Vars for Objectives	
		string sObj1, sObj2, sObj3, sObj4, sObj5, sObj6, sObj7, sObj8, sObj9, sObj10, sDone1, sDone2, sDone3, sDone4, sDone5, sDone6, sDone7, sDone8, sDone9, sDone10;
	
		// If an objective is complete, we want to add the word Done onto it.
		if (iPCObj1 == iObjective1)
			sDone1 = "<color=LightGreen>(Done)</color>";
		if (iPCObj2 == iObjective2)
			sDone2 = "<color=LightGreen>(Done)</color>";
		if (iPCObj3 == iObjective3)
			sDone3 = "<color=LightGreen>(Done)</color>";
		if (iPCObj4 == iObjective4)
			sDone4 = "<color=LightGreen>(Done)</color>";
		if (iPCObj5 == iObjective5)
			sDone5 = "<color=LightGreen>(Done)</color>";
		if (iPCObj6 == iObjective6)
			sDone6 = "<color=LightGreen>(Done)</color>";
		if (iPCObj7 == iObjective7)
			sDone7 = "<color=LightGreen>(Done)</color>";
		if (iPCObj8 == iObjective8)
			sDone8 = "<color=LightGreen>(Done)</color>";
		if (iPCObj9 == iObjective9)
			sDone9 = "<color=LightGreen>(Done)</color>";
		if (iPCObj10 == iObjective10)
			sDone10 = "<color=LightGreen>(Done)</color>";
			
		// We throw in this code to identify quantities in objectives.  Sometimes, we have to speak to an NPC however
		// we use the Quantity field in the database table to identify which NPC we want hehe.. sneaky.  BUT this
		// causes us a little problem in that the NPC ID looks like a quantity in the GUI so we accomodate for this
		// using the below.		
		if (FindSubString(GetStringLowerCase(sObjectiveText1), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText1), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText1), "protect") < 0 && FindSubString(GetStringLowerCase(sObjectiveText1), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText1), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText1), "escort") < 0 && iObjective1 != 1)
			sObj1 = "(" + IntToString(iPCObj1) + "/" + IntToString(iObjective1) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText2), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText2), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText2), "protect") < 0 && FindSubString(GetStringLowerCase(sObjectiveText2), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText2), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText2), "escort") < 0 && iObjective2 != 1)
			sObj2 = "(" + IntToString(iPCObj2) + "/" + IntToString(iObjective2) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText3), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText3), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText3), "protect") < 0 && FindSubString(GetStringLowerCase(sObjectiveText3), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText3), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText3), "escort") < 0 && iObjective3 != 1)		
			sObj3 = "(" + IntToString(iPCObj3) + "/" + IntToString(iObjective3) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText4), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText4), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText4), "protect") < 0 && FindSubString(GetStringLowerCase(sObjectiveText4), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText4), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText4), "escort") < 0 && iObjective4 != 1)
			sObj4 = "(" + IntToString(iPCObj4) + "/" + IntToString(iObjective4) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText5), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText5), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText5), "protect") < 0 && FindSubString(GetStringLowerCase(sObjectiveText5), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText5), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText5), "escort") < 0 && iObjective5 != 1)
			sObj5 = "(" + IntToString(iPCObj5) + "/" + IntToString(iObjective5) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText6), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText6), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText6), "protect") < 0 && FindSubString(GetStringLowerCase(sObjectiveText6), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText6), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText6), "escort") < 0 && iObjective6 != 1)
			sObj6 = "(" + IntToString(iPCObj6) + "/" + IntToString(iObjective6) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText7), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText7), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText7), "protect") < 0 && FindSubString(GetStringLowerCase(sObjectiveText7), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText7), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText7), "escort") < 0 && iObjective7 != 1)
			sObj7 = "(" + IntToString(iPCObj7) + "/" + IntToString(iObjective7) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText8), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText8), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText8), "protect") < 0 && FindSubString(GetStringLowerCase(sObjectiveText8), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText8), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText8), "escort") < 0 && iObjective8 != 1)
			sObj8 = "(" + IntToString(iPCObj8) + "/" + IntToString(iObjective8) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText9), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText9), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText9), "protect") < 0 && FindSubString(GetStringLowerCase(sObjectiveText9), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText9), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText9), "escort") < 0 && iObjective9 != 1)
			sObj9 = "(" + IntToString(iPCObj9) + "/" + IntToString(iObjective9) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText10), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText10), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText10), "protect") < 0 && FindSubString(GetStringLowerCase(sObjectiveText10), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText10), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText10), "escort") < 0 && iObjective10 != 1)
			sObj10 = "(" + IntToString(iPCObj10) + "/" + IntToString(iObjective10) + ")";
	
	    // Sometimes a player will be instructed to talk to another NPC and finish the quest, thats ok, because
		// just before the player finishes, they're OBJ variable is 0 but the Quest OBJ variable is not 0.  IF
		// however the player selects "LATER" instead of finishing the quest, well its already too late, because
		// we advance the NPC for the player in the questbox script assuming the player will always select finish.
		// Not good enough.  What ends up happening is the "DONE" message and OBJ's are all 0 which is fine but
		// makes the journal look screwy.  Here is the fix:
		if (iObjective1 == 0 && iPCObj1 == 0 && sDone1 != "")
		{
			sObj1 = "";
			sDone1 = "";
		}
	
		// Append the actual objective text for this stage of the quest.		
		sMainText = sMainText + "\n\n\n<color=Yellow>" + sObjectiveText1 + " " + sObj1 + "</color> " + sDone1;				
		if (iObjective2)
			sMainText = sMainText + "\n<color=Yellow>" + sObjectiveText2 + " " + sObj2 + "</color> " + sDone2;
		if (iObjective3)
			sMainText = sMainText + "\n<color=Yellow>" + sObjectiveText3 + " " + sObj3 + "</color> " + sDone3;
		if (iObjective4)
			sMainText = sMainText + "\n<color=Yellow>" + sObjectiveText4 + " " + sObj4 + "</color> " + sDone4;
		if (iObjective5)
			sMainText = sMainText + "\n<color=Yellow>" + sObjectiveText5 + " " + sObj5 + "</color> " + sDone5;
		if (iObjective6)
			sMainText = sMainText + "\n<color=Yellow>" + sObjectiveText6 + " " + sObj6 + "</color> " + sDone6;
		if (iObjective7)
			sMainText = sMainText + "\n<color=Yellow>" + sObjectiveText7 + " " + sObj7 + "</color> " + sDone7;
		if (iObjective8)
			sMainText = sMainText + "\n<color=Yellow>" + sObjectiveText8 + " " + sObj8 + "</color> " + sDone8;
		if (iObjective9)
			sMainText = sMainText + "\n<color=Yellow>" + sObjectiveText9 + " " + sObj9 + "</color> " + sDone9;
		if (iObjective10)
			sMainText = sMainText + "\n<color=Yellow>" + sObjectiveText10 + " " + sObj10 + "</color> " + sDone10;
	
		// If there are no reward items, clean up the icons so we don't get broken pictures.
		if (sIcon1 == ".tga")
			sIcon1 = "";
		if (sIcon2 == ".tga")
			sIcon2 = "";
		if (sIcon3 == ".tga")
			sIcon3 = "";
		
		// Based on the group type specified when the quest is created, use the correct images.  These would
		// be included in the hakpak for this plugin.
		if (iGroupType == 0)
			sTypeIcon = "solo_normal.tga";
		else if (iGroupType == 1)
			sTypeIcon = "solo_hard.tga";
		else if (iGroupType == 2)
			sTypeIcon = "group_normal.tga";
		else if (iGroupType == 3)
			sTypeIcon = "group_hard.tga";
	}
	
	// Now let's display update the GUI that we've already got on our screen with the new data.			
	string sGUI;
	if (JOURNAL_OVERRIDE == 0)
		sGUI = "leg_quest_journal";
	else
		sGUI = "SCREEN_JOURNAL";	
	SetGUIObjectText(OBJECT_SELF, sGUI, "title", -1, sColor + sTitle + "</color>");
	SetGUIObjectText(OBJECT_SELF, sGUI, "questdetails", -1, sMainText);
	SetGUIObjectText(OBJECT_SELF, sGUI, "REWARDS", -1, sRewards);
	SetGUIObjectText(OBJECT_SELF, sGUI, "OFFER_REWARDS1", -1, sDescription1);
	SetGUIObjectText(OBJECT_SELF, sGUI, "OFFER_REWARDS2", -1, sDescription2);
	SetGUIObjectText(OBJECT_SELF, sGUI, "OFFER_REWARDS3", -1, sDescription3);
	SetGUITexture(OBJECT_SELF, sGUI, "OFFERED_ICON1", sIcon1);
	SetGUITexture(OBJECT_SELF, sGUI, "OFFERED_ICON2", sIcon2);			
	SetGUITexture(OBJECT_SELF, sGUI, "OFFERED_ICON3", sIcon3);						
	SetGUITexture(OBJECT_SELF, sGUI, "TYPE1", sTypeIcon);						
	SetGUITexture(OBJECT_SELF, sGUI, "TYPE2", sTypeIcon);								
}
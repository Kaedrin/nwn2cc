/*

    Script:			Main Quest Plugin Include.
	Version:		1.01
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		None

	Change Log:		12/16/2010 - 1.00 MV - Initial Build
					12/23/2011 - 1.01 MV - Bug fix to resolve duplicate retries on mob drops

*/

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// USER CONFIGURABLE CONSTANTS
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_quest_constants"


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// SYSTEM CONSTANTS
// /////////////////////////////////////////////////////////////////////////////////////////////////////
const string COLOUR_WHITE = "<color=#FFFFFF>";        // RGB 255, 255, 255 
const string COLOUR_LIGHT_GREY = "<color=#C0C0C0>";   // RGB 192, 192, 192 
const string COLOUR_GREY = "<color=#808080>";         // RGB 128, 128, 128 
const string COLOUR_DARK_GREY = "<color=#404040>";    // RGB 64, 64, 64 
const string COLOUR_BLACK = "<color=#000000>";        // RGB 0, 0, 0 
const string COLOUR_LIGHT_RED = "<color=#FF8080>";    // RGB 255, 128, 128 
const string COLOUR_LIGHT_GREEN = "<color=#80FF80>";  // RGB 128, 255, 128 
const string COLOUR_LIGHT_BLUE = "<color=#8080FF>";   // RGB 128, 128, 255 
const string COLOUR_LIGHT_YELLOW = "<color=#FFFF80>"; // RGB 255, 255, 128 
const string COLOUR_LIGHT_PURPLE = "<color=#FF80FF>"; // RGB 255, 128, 255 
const string COLOUR_LIGHT_CYAN = "<color=#80FFFF>";   // RGB 128, 255, 255 
const string COLOUR_RED = "<color=#FF0000>";          // RGB 255, 0, 0 
const string COLOUR_GREEN = "<color=#00FF00>";        // RGB 0, 255, 0 
const string COLOUR_BLUE = "<color=#0000FF>";         // RGB 0, 0, 255 
const string COLOUR_YELLOW = "<color=#FFFF00>";       // RGB 255, 255, 0 
const string COLOUR_PURPLE = "<color=#FF00FF>";       // RGB 255, 0, 255 
const string COLOUR_CYAN =  "<color=#00FFFF>";        // RGB 0, 255, 255 
const string COLOUR_ORANGE = "<color=#FF9900>";       // RGB 255, 153, 0 
const string COLOUR_DARK_RED = "<color=#800000>";     // RGB 128, 0, 0 
const string COLOUR_DARK_GREEN = "<color=#008000>";   // RGB 0, 128, 0 
const string COLOUR_DARK_BLUE = "<color=#000080>";    // RGB 0, 0, 128 
const string COLOUR_DARK_YELLOW = "<color=#808000>";  // RGB 128, 128, 0 
const string COLOUR_DARK_PURPLE = "<color=#800080>";  // RGB 128, 0, 128 
const string COLOUR_DARK_CYAN = "<color=#008080>";    // RGB 0, 128, 128 


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_all_masterinclude"



// /////////////////////////////////////////////////////////////////////////////////////////////////////
// FUNCTION DECLARATIONS
// /////////////////////////////////////////////////////////////////////////////////////////////////////




string LEG_QUEST_GetOneLiner(string sNPC);
string LEG_QUEST_GetPostOneLiner(string sNPC);
int LEG_QUEST_CheckOtherObjectives(object oPC, string sQuestID, int iPlayerStep, int iSkipOBJ);
void LEG_QUEST_CompleteObjectives(object oPC, string sQuestID, int iPlayerStep);
void LEG_QUEST_ClearObjectives(object oPC, string sQuestID, string sTableID);
int LEG_QUEST_CheckObjectives(object oPC, string sQuestID, int iPlayerStep);
string LEG_QUEST_RewardsText(string sRewards);
string LEG_QUEST_ChallengeColor(object oPC, int iLevel);
void LEG_QUEST_FireQuestGUI(string sGUI, string sGUIFile, object oPC, int iNPCPosition, string sQuestID, int iAdvanceNPC = 0, int iAdvanceOBJ = 0);
void LEG_QUEST_RefreshQuestIcon(object oNPC, object oMyIcon, object oPC);
void LEG_QUEST_GiveFeat(object oPC, int iFeat);
void LEG_QUEST_QuestCreditItem(string sItem, object oTarget, string sQuest = "", int iObjective = 0, int iOldCondition = 0, int iStackSize = 1, int iNotifyTarget = 1, int iPCHas = 1, int iPCNeeds = 1, string sPlaceID = "", int iAdvanceNPC = 0);

void LEG_QUEST_ObjectiveCredit(string sQuestID, object oTarget, string sObjective, string sObjectiveTarget, int iPCHas, int iPCNeeds, int iObjective, string sPlaceID);

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// FUNCTIONS
// /////////////////////////////////////////////////////////////////////////////////////////////////////




// //////////////////////////////////////////////////
// LEG_QUEST_GetOneLiner
// //////////////////////////////////////////////////
string LEG_QUEST_GetOneLiner(string sNPC)
{
	// Grab the NPC's oneliner out of the NPC table for quests.  Use the NPC Tag to find him which
	// is in the Main Quest table as well.
	string sOneliner;
	SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_questnpcs` WHERE `NPCTag` = '" + sNPC + "'");
	SQLFetch();
	sOneliner = SQLGetData(2);
	return sOneliner;
}



// //////////////////////////////////////////////////
// LEG_QUEST_GetPostOneLiner
// //////////////////////////////////////////////////
string LEG_QUEST_GetPostOneLiner(string sNPC)
{
	// Grab the NPC's oneliner out of the NPC table for quests.  Use the NPC Tag to find him which
	// is in the Main Quest table as well.
	string sOneliner;
	SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_questnpcs` WHERE `NPCTag` = '" + sNPC + "'");
	SQLFetch();
	sOneliner = SQLGetData(4);
	return sOneliner;
}


// //////////////////////////////////////////////////
// LEG_QUEST_CheckOtherObjectives
// //////////////////////////////////////////////////
int LEG_QUEST_CheckOtherObjectives(object oPC, string sQuestID, int iPlayerStep, int iSkipOBJ)
{
	// This will take the Quest passed and find out what its objectives are.  Once it has them, it will
	// compare them to what the PC has accomplished.  If the PC hasn't accomplished them then we return false.
	SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_mainquests` AS t1, `" + QUESTPREFIX + "_questheader` AS t2 WHERE t1.`QuestID`=t2.`QuestID` AND t1.`QuestID` = " + sQuestID + " AND t1.`QuestNPC` = " + IntToString(iPlayerStep));
	SQLFetch();
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
	int iPCObjective1 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ1");
	int iPCObjective2 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ2");
	int iPCObjective3 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ3");
	int iPCObjective4 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ4");								
	int iPCObjective5 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ5");		
	int iPCObjective6 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ6");		
	int iPCObjective7 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ7");		
	int iPCObjective8 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ8");		
	int iPCObjective9 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ9");		
	int iPCObjective10 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ10");			

	// If the PC has accomplished all the objectives EXCEPT for the Special SKIP objective, return true.
	if ((iSkipOBJ != 1 && iPCObjective1 != iObjective1) || (iSkipOBJ != 2 && iPCObjective2 != iObjective2) || (iSkipOBJ != 3 && iPCObjective3 != iObjective3) || (iSkipOBJ != 4 && iPCObjective4 != iObjective4) || (iSkipOBJ != 5 && iPCObjective5 != iObjective5) || (iSkipOBJ != 6 && iPCObjective6 != iObjective6) || (iSkipOBJ != 7 && iPCObjective7 != iObjective7) || (iSkipOBJ != 8 && iPCObjective8 != iObjective8) || (iSkipOBJ != 9 && iPCObjective9 != iObjective9) || (iSkipOBJ != 10 && iPCObjective10 != iObjective10))
		return FALSE;
	else
		return TRUE;
}





// //////////////////////////////////////////////////
// LEG_QUEST_CompleteObjectives
// //////////////////////////////////////////////////
void LEG_QUEST_CompleteObjectives(object oPC, string sQuestID, int iPlayerStep)
{
	// Get the row from the databae.  We'll grab what vars we need depending on
	// where the PC is in the quest.
	SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_mainquests` AS t1, `" + QUESTPREFIX + "_questheader` AS t2 WHERE t1.`QuestID`=t2.`QuestID` AND t1.`QuestID` = " + sQuestID + " AND t1.`QuestNPC` = " + IntToString(iPlayerStep));
	SQLFetch();
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
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ1", iObjective1);
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ2", iObjective2);
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ3", iObjective3);
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ4", iObjective4);								
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ5", iObjective5);		
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ6", iObjective6);		
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ7", iObjective7);		
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ8", iObjective8);		
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ9", iObjective9);		
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ10", iObjective10);							
}



// //////////////////////////////////////////////////
// LEG_QUEST_ClearObjectives
// //////////////////////////////////////////////////
void LEG_QUEST_ClearObjectives(object oPC, string sQuestID, string sTableID)
{
	// Set all the players CURRENT objectives for a particular quest to 0 meaning
	// whatever step the PC is on or will be on for this quest, they will not
	// have any objectives completed for that step/NPC.
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ1", 0);
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ2", 0);
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ3", 0);
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ4", 0);
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ5", 0);
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ6", 0);
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ7", 0);
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ8", 0);
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ9", 0);
	SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ10", 0);
	SetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ1", 0, 0, sTableID);
	SetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ2", 0, 0, sTableID);
	SetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ3", 0, 0, sTableID);
	SetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ4", 0, 0, sTableID);
	SetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ5", 0, 0, sTableID);
	SetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ6", 0, 0, sTableID);
	SetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ7", 0, 0, sTableID);
	SetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ8", 0, 0, sTableID);
	SetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ9", 0, 0, sTableID);
	SetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ10", 0, 0, sTableID);	
}


// //////////////////////////////////////////////////
// LEG_QUEST_CheckObjectives
// //////////////////////////////////////////////////
int LEG_QUEST_CheckObjectives(object oPC, string sQuestID, int iPlayerStep)
{
	// Get the row from the databae.  We'll grab what vars we need depending on
	// where the PC is in the quest.
	SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_mainquests` AS t1, `" + QUESTPREFIX + "_questheader` AS t2 WHERE t1.`QuestID`=t2.`QuestID` AND t1.`QuestID` = " + sQuestID + " AND t1.`QuestNPC` = " + IntToString(iPlayerStep));
	SQLFetch();
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
	int iPCObjective1 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ1");
	int iPCObjective2 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ2");
	int iPCObjective3 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ3");
	int iPCObjective4 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ4");								
	int iPCObjective5 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ5");		
	int iPCObjective6 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ6");		
	int iPCObjective7 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ7");		
	int iPCObjective8 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ8");		
	int iPCObjective9 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ9");		
	int iPCObjective10 = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ10");			

	// If ALL of the objectives are complete then we return TRUE.
	if (iPCObjective1 != iObjective1 || iPCObjective2 != iObjective2 || iPCObjective3 != iObjective3 || iPCObjective4 != iObjective4 || iPCObjective5 != iObjective5 || iPCObjective6 != iObjective6 || iPCObjective7 != iObjective7 || iPCObjective8 != iObjective8 || iPCObjective9 != iObjective9 || iPCObjective10 != iObjective10)
		return FALSE;
	else
		return TRUE;
}




// //////////////////////////////////////////////////
// LEG_QUEST_RewardsText
// //////////////////////////////////////////////////
string LEG_QUEST_RewardsText(string sRewards)
{
	// If we're passing no gold, then the reward is just XP.
	if (sRewards == "0" || sRewards == "")
		sRewards = "Rewards: <color=Yellow>Experience Points</color>";
	else
		sRewards = "Rewards: <color=Yellow>" + sRewards + " Gold</color>"; 
	
	// Return the pretty formated result.
	return sRewards;
}



// //////////////////////////////////////////////////
// LEG_QUEST_ChallengeColor
// //////////////////////////////////////////////////
string LEG_QUEST_ChallengeColor(object oPC, int iLevel)
{
	// Find out the level of the PC and compare.
	string sColor;
	int iChallenge = GetTotalLevels(oPC, FALSE) - iLevel;
	
	// If the result of the Player's Level and the Quest Level is identified as below
	// we want to set the color of what we are displaying to match this difficulty.
	// PURPLE = 	PC Is 5 Levels Lower than Quest
	// RED =	 	PC is 4 Levels Lower than Quest
	// YELLOW = 	PC is 3 or 2 Levels Lower than Quest
	// GREEN = 		PC is 1 level lower than quest, AT the quest or 1 level higher than quest.
	// CYAN = 		PC is 3 or 2 Levels Higher than Quest
	// WHITE =		PC is 4 Levels Higher than Quest
	// GREY = 		PC is 5 Levels Higher than Quest
	switch (iChallenge)
	{
		case -5:
			sColor = COLOUR_LIGHT_PURPLE;
			break;
		case -4:
			sColor = COLOUR_RED;
			break;
		case -3:
		case -2:
			sColor = COLOUR_YELLOW;
			break;
		case -1:
		case 0:
		case 1:
			sColor = COLOUR_LIGHT_GREEN;
			break;
		case 2:
		case 3:
			sColor = COLOUR_LIGHT_CYAN;
			break;
		case 4:
			sColor = COLOUR_WHITE;
			break;
		case 5:
			sColor = COLOUR_LIGHT_GREY;
			break;
	}		
	
	// If of course the PC is more than 5 levels below, automatic Purple
	// And if they are more than 5 levels above the quest, automatic Grey
	if (iChallenge < -5)
		sColor = COLOUR_LIGHT_PURPLE;
	else if (iChallenge	> 5)
		sColor = COLOUR_LIGHT_GREY;

	// Return our Color.
	return sColor;
}




// //////////////////////////////////////////////////
// LEG_QUEST_FireQuestGUI
// //////////////////////////////////////////////////
void LEG_QUEST_FireQuestGUI(string sGUI, string sGUIFile, object oPC, int iNPCPosition, string sQuestID, int iAdvanceNPC = 0, int iAdvanceOBJ = 0)
{
	// Get the quest row from the database for this NPC/Object.  We'll grab what vars we need depending on
	// where the PC is in the quest.
	SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_mainquests` AS t1, `" + QUESTPREFIX + "_questheader` AS t2 WHERE t1.`QuestID`=t2.`QuestID` AND t1.`QuestID` = " + sQuestID + " AND t1.`QuestNPC` = " + IntToString(iNPCPosition));	
	SQLFetch();

	// Start pulling the data for the quest step out of the result.
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
	int iQuestType = StringToInt(SQLGetData(28));	
	string sRewards = SQLGetData(30);
	int iLevel = StringToInt(SQLGetData(31));
	
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
	string sColor = LEG_QUEST_ChallengeColor(oPC, iLevel);
	string sMainText;
	int iBribe, iSkill1, iSkill2;
	string sReluctantText = "", sFailText = "";
	
	// Make the offer text pretty, assuming this is an OFFER or CONTINUE GUI.
	if (sGUI == "leg_quest_offer" || sGUI == "leg_quest_continue" || sGUI == "leg_quest_continue_bribe" || sGUI == "leg_quest_continue_bribe_skill" || sGUI == "leg_quest_continue_all" || sGUI == "leg_quest_continue_skill1" || sGUI == "leg_quest_continue_skills" || sGUI == "leg_quest_continue_fail")
	{
		int iStandardGUI = FALSE;
		if (sGUI == "leg_quest_offer" || sGUI == "leg_quest_continue")
			iStandardGUI = TRUE;
		else
		{
			// We're reluctant, get the reluctant text.
			SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_skills` WHERE `QuestID` = '" + sQuestID + "' AND `NPCID` = '" + IntToString(iNPCPosition) + "';");
			while(SQLFetch())
			{
				sReluctantText = SQLGetData(3);
				sFailText = SQLGetData(4);
				iBribe = StringToInt(SQLGetData(6));
				iSkill1 = StringToInt(SQLGetData(9));
				iSkill2 = StringToInt(SQLGetData(10));
			}
		}
		
		// Setup some Vars
		string sObj1, sObj2, sObj3, sObj4, sObj5, sObj6, sObj7, sObj8, sObj9, sObj10;
		
		// We throw in this code to identify quantities in objectives.  Sometimes, we have to speak to an NPC however
		// we use the Quantity field in the database table to identify which NPC we want hehe.. sneaky.  BUT this
		// causes us a little problem in that the NPC ID looks like a quantity in the GUI so we accomodate for this
		// using the below.
		if (FindSubString(GetStringLowerCase(sObjectiveText1), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText1), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText1), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText1), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText1), "escort") < 0 && iObjective1 != 1)
			sObj1 = "(" + IntToString(iObjective1) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText2), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText2), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText2), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText2), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText2), "escort") < 0 && iObjective2 != 1)
			sObj2 = "(" + IntToString(iObjective2) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText3), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText3), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText3), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText3), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText3), "escort") < 0 && iObjective3 != 1)		
			sObj3 = "(" + IntToString(iObjective3) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText4), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText4), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText4), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText4), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText4), "escort") < 0 && iObjective4 != 1)
			sObj4 = "(" + IntToString(iObjective4) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText5), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText5), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText5), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText5), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText5), "escort") < 0 && iObjective5 != 1)
			sObj5 = "(" + IntToString(iObjective5) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText6), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText6), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText6), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText6), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText6), "escort") < 0 && iObjective6 != 1)
			sObj6 = "(" + IntToString(iObjective6) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText7), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText7), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText7), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText7), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText7), "escort") < 0 && iObjective7 != 1)
			sObj7 = "(" + IntToString(iObjective7) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText8), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText8), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText8), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText8), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText8), "escort") < 0 && iObjective8 != 1)
			sObj8 = "(" + IntToString(iObjective8) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText9), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText9), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText9), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText9), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText9), "escort") < 0 && iObjective9 != 1)
			sObj9 = "(" + IntToString(iObjective9) + ")";
		if (FindSubString(GetStringLowerCase(sObjectiveText10), "speak") < 0 && FindSubString(GetStringLowerCase(sObjectiveText10), "deliver") < 0 && FindSubString(GetStringLowerCase(sObjectiveText10), "visit") < 0 && FindSubString(GetStringLowerCase(sObjectiveText10), "discover") < 0 && FindSubString(GetStringLowerCase(sObjectiveText10), "escort") < 0 && iObjective10 != 1)
			sObj10 = "(" + IntToString(iObjective10) + ")";
		
		// Make the Offer/Continue Text a Pretty Yellow
		if (iStandardGUI)
		{
			sOfferText = sOfferText + "\n\n\n<color=Yellow>" + sObjectiveText1 + " " + sObj1 + "</color>";
			sContinueText = sContinueText + "\n\n\n<color=Yellow>" + sObjectiveText1 + " " + sObj1 + "</color>";
		}
		
		// For each objective that we actually have, make their text pretty and append it to the main text.
		// Note that we don't show any "DONE" here for objectives as that is for the Journal, not the Offer/Cont/Fin 
		// GUI.
		if (iObjective2 && iStandardGUI)
		{
			sOfferText = sOfferText + "\n<color=Yellow>" + sObjectiveText2 + " " + sObj2 + "</color>";
			sContinueText = sContinueText + "\n<color=Yellow>" + sObjectiveText2 + " " + sObj2 + "</color>";
		}
		if (iObjective3 && iStandardGUI)
		{
			sOfferText = sOfferText + "\n<color=Yellow>" + sObjectiveText3 + " " + sObj3 + "</color>";
			sContinueText = sContinueText + "\n<color=Yellow>" + sObjectiveText3 + " " + sObj3 + "</color>";
		}
		if (iObjective4 && iStandardGUI)
		{
			sOfferText = sOfferText + "\n<color=Yellow>" + sObjectiveText4 + " " + sObj4 + "</color>";
			sContinueText = sContinueText + "\n<color=Yellow>" + sObjectiveText4 + " " + sObj4 + "</color>";
		}
		if (iObjective5 && iStandardGUI)
		{
			sOfferText = sOfferText + "\n<color=Yellow>" + sObjectiveText5 + " " + sObj5 + "</color>";
			sContinueText = sContinueText + "\n<color=Yellow>" + sObjectiveText5 + " " + sObj5 + "</color>";
		}
		if (iObjective6 && iStandardGUI)
		{
			sOfferText = sOfferText + "\n<color=Yellow>" + sObjectiveText6 + " " + sObj6 + "</color>";
			sContinueText = sContinueText + "\n<color=Yellow>" + sObjectiveText6 + " " + sObj6 + "</color>";
		}
		if (iObjective7 && iStandardGUI)
		{
			sOfferText = sOfferText + "\n<color=Yellow>" + sObjectiveText7 + " " + sObj7 + "</color>";
			sContinueText = sContinueText + "\n<color=Yellow>" + sObjectiveText7 + " " + sObj7 + "</color>";
		}
		if (iObjective8 && iStandardGUI)
		{
			sOfferText = sOfferText + "\n<color=Yellow>" + sObjectiveText8 + " " + sObj8 + "</color>";
			sContinueText = sContinueText + "\n<color=Yellow>" + sObjectiveText8 + " " + sObj8 + "</color>";
		}
		if (iObjective9 && iStandardGUI)
		{
			sOfferText = sOfferText + "\n<color=Yellow>" + sObjectiveText9 + " " + sObj9 + "</color>";
			sContinueText = sContinueText + "\n<color=Yellow>" + sObjectiveText9 + " " + sObj9 + "</color>";
		}
		if (iObjective10 && iStandardGUI)
		{
			sOfferText = sOfferText + "\n<color=Yellow>" + sObjectiveText10 + " " + sObj10 + "</color>";
			sContinueText = sContinueText + "\n<color=Yellow>" + sObjectiveText10 + " " + sObj10 + "</color>";
		}
		
		if (sGUI == "leg_quest_offer")
			sMainText = sOfferText;	
		else if (sGUI == "leg_quest_continue")
			sMainText = sContinueText;
		else if (sGUI == "leg_quest_continue_fail")
			sMainText = sFailText; 
		else
			sMainText = sReluctantText;
	}				
	else
		sMainText = sFinishText;
	
	// If there are no icons configured then clear any tga entry we may have picked up from the DB table.
	int iRewards = 0;
	if (sIcon1 == ".tga")
		sIcon1 = "";
	if (sIcon2 == ".tga")
		sIcon2 = "";
	if (sIcon3 == ".tga")
		sIcon3 = "";

	if (sIcon1 != "")
		iRewards = 1;		
	if (sIcon2 != "")
		iRewards = 2;		
	if (sIcon3 != "")
		iRewards = 3;		
	
	// Now open the GUI.  The GUI could be an Offer, a Continue or a Finish call based on what we asked this
	// function to do.  Pass all the information we pulled from the database off to the appropriate GUI file
	// that was passed to this function.
	DisplayGuiScreen(oPC, sGUI, FALSE, sGUIFile);			
	SetGUIObjectText(oPC, sGUI, "title", -1, sColor + sTitle + "</color>");
	SetGUIObjectText(oPC, sGUI, "quest", -1, sMainText);
	SetLocalGUIVariable(oPC, sGUI, 1, sQuestID);
	SetLocalGUIVariable(oPC, sGUI, 2, IntToString(iNPCPosition));
	SetLocalGUIVariable(oPC, sGUI, 3, IntToString(iObjective1));
	SetLocalGUIVariable(oPC, sGUI, 4, IntToString(iObjective2));
	SetLocalGUIVariable(oPC, sGUI, 5, IntToString(iObjective3));
	SetLocalGUIVariable(oPC, sGUI, 6, IntToString(iObjective4));
	SetLocalGUIVariable(oPC, sGUI, 7, IntToString(iObjective5));
	SetLocalGUIVariable(oPC, sGUI, 8, IntToString(iAdvanceNPC));
	SetLocalGUIVariable(oPC, sGUI, 10, IntToString(iRewards));
	SetLocalGUIVariable(oPC, sGUI, 11, IntToString(iQuestType));	
	SetLocalGUIVariable(oPC, sGUI, 12, IntToString(iAdvanceOBJ));	
	SetGUIObjectText(oPC, sGUI, "REWARDS", -1, sRewards);

	// If this is an OFFER or CONTINUE then lets set the appropriate 3 rewards text fields
	if (sGUI == "leg_quest_offer" || sGUI == "leg_quest_continue" || sGUI == "leg_quest_continue_bribe" || sGUI == "leg_quest_continue_bribe_skill" || sGUI == "leg_quest_continue_all" || sGUI == "leg_quest_continue_skill1" || sGUI == "leg_quest_continue_skills")
	{
		SetGUIObjectText(oPC, sGUI, "OFFER_REWARDS1", -1, sDescription1);
		SetGUIObjectText(oPC, sGUI, "OFFER_REWARDS2", -1, sDescription2);
		SetGUIObjectText(oPC, sGUI, "OFFER_REWARDS3", -1, sDescription3);
		SetGUITexture(oPC, sGUI, "OFFERED_ICON1", sIcon1);
		SetGUITexture(oPC, sGUI, "OFFERED_ICON2", sIcon2);			
		SetGUITexture(oPC, sGUI, "OFFERED_ICON3", sIcon3);
		

			if (sGUI == "leg_quest_continue_bribe")
			{
				SetGUIObjectText(oPC, sGUI, "BribeButton", -1, IntToString(iBribe) + " GP");	
			}
			else if (sGUI == "leg_quest_continue_bribe_skill")
			{
				SetGUIObjectText(oPC, sGUI, "BribeButton", -1, IntToString(iBribe) + " GP");	
				SetGUIObjectText(oPC, sGUI, "Skill1Button", -1, Get2DAString("skills", "LABEL", iSkill1));
			}
			else if (sGUI == "leg_quest_continue_all")
			{
				SetGUIObjectText(oPC, sGUI, "BribeButton", -1, IntToString(iBribe) + " GP");	
				SetGUIObjectText(oPC, sGUI, "Skill1Button", -1, Get2DAString("skills", "LABEL", iSkill1));				
				SetGUIObjectText(oPC, sGUI, "Skill2Button", -1, Get2DAString("skills", "LABEL", iSkill2));
			}
			else if (sGUI == "leg_quest_continue_skill1")
			{
				SetGUIObjectText(oPC, sGUI, "Skill1Button", -1, Get2DAString("skills", "LABEL", iSkill1));
			}
			else if (sGUI == "leg_quest_continue_skills")
			{
				SetGUIObjectText(oPC, sGUI, "Skill1Button", -1, Get2DAString("skills", "LABEL", iSkill1));
				SetGUIObjectText(oPC, sGUI, "Skill2Button", -1, Get2DAString("skills", "LABEL", iSkill2));				
			}
		
		
	}
	else if(sGUI == "leg_quest_continue_fail")
	{
		// Don't do anything special for fail text.
			
	}
	else
	{		
		// Otherwise, this is a Finish GUI and the 3 rewards are clickable boxes the PC gets to choose from
		// so populating that data is a little different.
		if (sDescription1 != "")
		{
			AddListBoxRow(oPC, sGUI, "REWARDS_LISTBOX", "ROW_1", "LISTBOX_ITEM_TEXT=" + sDescription1, "LISTBOX_ITEM_ICON=" + sIcon1, "15=1", "");
		}
		if (sDescription2 != "")
		{
			SetGUIObjectText(oPC, sGUI, "SELECT_REWARDS", -1, "Select a Reward:");
			AddListBoxRow(oPC, sGUI, "REWARDS_LISTBOX", "ROW_2", "LISTBOX_ITEM_TEXT=" + sDescription2, "LISTBOX_ITEM_ICON=" + sIcon2, "15=2", "");
		}
		if (sDescription3 != "")
		{
			AddListBoxRow(oPC, sGUI, "REWARDS_LISTBOX", "ROW_3", "LISTBOX_ITEM_TEXT=" + sDescription3, "LISTBOX_ITEM_ICON=" + sIcon3, "15=3", "");
		}
	}
}




// //////////////////////////////////////////////////
// LEG_QUEST_RefreshQuestIcon
// //////////////////////////////////////////////////
void LEG_QUEST_RefreshQuestIcon(object oNPC, object oMyIcon, object oPC)
{
	string sQuestID;
	int iNPCID;
	object oTrap;
	
	if (GetIsPC(oNPC))
		return;
	
	if (!GetIsPC(oPC))
		return;
		
	// My Icon doesn't have a trap.  Better create one.
	CreateTrapOnObject(TRAP_BASE_TYPE_EPIC_FIRE, oMyIcon);
	oTrap = GetNearestTrapToObject(oNPC, FALSE);
	SetTrapDetectDC(oTrap, 250);
	SetTrapDisarmable(oTrap, FALSE);
	SetTrapRecoverable(oTrap, FALSE);
	
	if (!GetIsObjectValid(oMyIcon))
		return;
	
	// I have my Trap on my icon.  Should I light it up for this PC?
	int iPCStep;
	int iTotalQuests = GetLocalInt(oNPC, "LEG_QUEST_TotalQuests");
	int iCount;
	for (iCount=1; iCount <= iTotalQuests; iCount++)
	{
		sQuestID = GetLocalString(oNPC, "LEG_QUEST_QuestID_" + IntToString(iCount));
		iNPCID = GetLocalInt(oNPC, "LEG_QUEST_NPCID_" + IntToString(iCount));
		iPCStep = GetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC");
		
		// If I'm not a quest NPC, then get me out.
		if (iNPCID == 0)
			return;
			
		// If I have a quest for the PC then...
		if (iPCStep == iNPCID)
		{
			
			//if (GetTag(oNPC) == "grannyflux")
//			SpeakString(GetName(oNPC) + " I'm in the = Loop", TALKVOLUME_SHOUT);

			// If the PC has all the objectives for this NPC.
			if (LEG_QUEST_CheckObjectives(oPC, sQuestID, iNPCID))
			{
				//SpeakString(GetName(oNPC) + " I'm in the = Loop, Quest ID: " + sQuestID, TALKVOLUME_SHOUT);
				SetTrapDetectedBy(oTrap, oPC);	
			}
			// If the PC doesn't have all the objectives BUT the NPC is reluctant and the PC
			// hasn't resolved it yet.  Though we also only want to do this if the PC is not in 
			// a Failure wait state.
			else if (GetLocalInt(oNPC, "LEG_QUEST_Reluctant_" + IntToString(iCount)))
			{
				int iTimeSystem = GetLocalInt(GetModule(), "LEG_TIME_ACTIVE");
				string sTableID = LEG_COMMON_GetPCTable(oPC, "quests");
				int iReluctantPassed = GetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iNPCID) + "_ReluctantPassed");
				
				// Check for Failure Wait State.
				int iSkillFail = GetLocalInt(oPC, "QuestID_" + sQuestID + "_FailTime");
				if (!iSkillFail && iTimeSystem)
				{
					// Check database just in case.
					iSkillFail = GetPersistentInt(oPC, "QuestID_" + sQuestID + "_FailTime", sTableID);
				}
				
				if (!iReluctantPassed && iSkillFail < LEG_COMMON_TimeStamp())
				{
					//SpeakString(GetName(oNPC) + " I'm in the = Loop, Reluctant section, Quest ID: " + sQuestID, TALKVOLUME_SHOUT);
					SetTrapDetectedBy(oTrap, oPC);	
				}
			}
		}
		else if (iPCStep == 0 || iPCStep == 998)
		{
			//if (GetTag(oNPC) == "grannyflux")
				//SpeakString(GetName(oNPC) + " I'm in the Step = 0 or 998 Loop", TALKVOLUME_SHOUT);

			string sRequirement = GetLocalString(oNPC, "LEG_QUEST_Requirement_" + IntToString(iCount));
			string sQuestStarted = GetLocalString(oNPC, "LEG_QUEST_QuestStarted_" + IntToString(iCount));
			if (GetLocalInt(oPC, "QuestID_" + sRequirement + "_NPC") == 999 || sRequirement == "")
			{
				// If the timer has not passed, then fire the oneliner.
				if (GetLocalInt(oPC, "QuestID_" + sQuestID + "_NextRepeat") > LEG_COMMON_TimeStamp() && iPCStep == 998)
					return;
					
				if (GetLocalInt(oNPC, "LEG_QUEST_Starter_" + IntToString(iCount)))
				{
					//SpeakString(GetName(oNPC) + " I'm a new quest, player needs to talk to me. Setting my Trap Detected");
					// We've already checked if I need a specific quest finished via the sRequirement variable, but
					// what if I simply need a different quest started (not necessarily finished).
					if (GetLocalInt(oPC, "QuestID_" + sQuestStarted + "_NPC") > 0 || sQuestStarted == "")
					{
						//SpeakString(GetName(oNPC) + " I'm in the Step = 0 or 998 Loop, Quest ID: " + sQuestID, TALKVOLUME_SHOUT);
						SetTrapDetectedBy(oTrap, oPC);	
					}
				}
			}
		}
		// Well it looks like the PC has a few objectives that need completing, BUT!  There is one
		// way I could still want to talk to the player and that's if I'm one of those NPC's that have
		// been referred to the PC by another NPC.	
		else if (GetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC") == GetLocalInt(oNPC, "LEG_QUEST_ObjectiveFor_" + IntToString(iCount)) && GetLocalInt(oNPC, "LEG_QUEST_IsObjective_" + IntToString(iCount)))
		{
			//if (GetTag(oNPC) == "grannyflux")
			//	SpeakString(GetName(oNPC) + " I'm in the Talk to Next Loop", TALKVOLUME_SHOUT);
				
			string sRequirement = GetLocalString(oNPC, "LEG_QUEST_Requirement_" + IntToString(iCount));
			string sQuestStarted = GetLocalString(oNPC, "LEG_QUEST_QuestStarted_" + IntToString(iCount));
			if (GetLocalInt(oPC, "QuestID_" + sRequirement + "_NPC") == 999 || sRequirement == "")
			{
				if (GetLocalInt(oPC, "QuestID_" + sQuestStarted + "_NPC") > 0 || sQuestStarted == "")
				{
					// One last thing to check.  If this NPC is only allowed to be talked to, AFTER the player
					// has completed any other objectives FIRST.
					string sCount = IntToString(iCount);
					int iPlayerStep = GetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC");
					int iSkipOBJ = GetLocalInt(oNPC, "LEG_QUEST_IsObjective_" + sCount);

					if ((GetLocalInt(oNPC, "LEG_QUEST_OtherObjectivesDone_" + sCount) && LEG_QUEST_CheckOtherObjectives(oPC, sQuestID, iPlayerStep, iSkipOBJ)) || !GetLocalInt(oNPC, "LEG_QUEST_OtherObjectivesDone_" + IntToString(iCount)))
					{
						// Even though I am the current NPC's objective, I may not be an ACTIVE objective yet until the PC
						// passes any reluctance the current NPC may have.
						int iCurrentNPCStep = GetLocalInt(oNPC, "LEG_QUEST_ObjectiveFor_" + IntToString(iCount));
						string sTableID = LEG_COMMON_GetPCTable(oPC, "quests");
						int iReluctantPassed = GetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iCurrentNPCStep) + "_ReluctantPassed");
						
						if (iReluctantPassed)
						{
							//SpeakString(GetName(oNPC) + " I'm in the Talk to Next Loop, Quest ID: " + sQuestID, TALKVOLUME_SHOUT);
							SetTrapDetectedBy(oTrap, oPC);	
						}
					}
				}
			}
		}
	}
}


// //////////////////////////////////////////////////
// LEG_QUEST_GiveFeat
// //////////////////////////////////////////////////
void LEG_QUEST_GiveFeat(object oPC, int iFeat)
{
	effect eEffect;
	switch (iFeat)
	{
		case 2871:		// Give the Legends Ancient Lore Feat
					    // +2 Lore
						if (GetHasFeat(iFeat, oPC, TRUE))
						{
							eEffect = SupernaturalEffect(ExtraordinaryEffect(EffectSkillIncrease(SKILL_LORE, 2)));
							ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC);
						}
						break;
		
		case 2872:		// Give the Venturing Forth feat for portalling from Eleden.
						if (GetHasFeat(iFeat, oPC, TRUE))
						{
							// Don't do anything for this feat.  It is for portalling only.
						}
						break;	
		
		case 2873:		// Give The Chronicles of Valanthia Feat
						// +2 HP
						if (GetHasFeat(iFeat, oPC, TRUE))
						{
							eEffect = SupernaturalEffect(ExtraordinaryEffect(EffectBonusHitpoints(2)));
							ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC);
						}
						break;
	}					
}


// //////////////////////////////////////////////////
// LEG_QUEST_QuestCreditItem
// //////////////////////////////////////////////////
void LEG_QUEST_QuestCreditItem(string sItem, object oTarget, string sQuestID = "", int iObjective = 0, int iOldCondition = 0, int iStackSize = 1, int iNotifyTarget = 1, int iPCHas = 1, int iPCNeeds = 1, string sPlaceID = "", int iAdvanceNPC = 0)
{
	// Create the item for the PC!
	object oItem;
	object oQuestBag = LEG_COMMON_GetInventoryItemByTag(oTarget, "leg_quest_questbag");
	if (GetIsObjectValid(oQuestBag))
		oItem = LEG_COMMON_CreateItem(oTarget, sItem, iStackSize, oQuestBag);
	else
		oItem = LEG_COMMON_CreateItem(oTarget, sItem, iStackSize);
	
	// We've just obtained an Item.  We should see if we should get credit for it from a quest.
	if (GetIsObjectValid(oItem))
	{
		// Notify the PC and save the credit.
		LEG_QUEST_ObjectiveCredit(sQuestID, oTarget, "Found", GetName(oItem), iPCHas, iPCNeeds, iObjective, sPlaceID);
				
		// Notify the party that this member has looted something
		object oLeader = GetFactionLeader(oTarget);
		object oMember = GetFirstFactionMember(oLeader, TRUE);
	    while(oMember != OBJECT_INVALID)
	    {
			if (oMember != oTarget)		
				SendMessageToPC(oMember, GetName(oTarget) + " has aquired a " + GetName(oItem));
			oMember = GetNextFactionMember(oLeader, TRUE);
		}
	}
	else
	{
		// For some reason, we were not successful in creating the object.  It could be a result of inventory
		// being full or someone forgot to actually create the item in the toolset.  But let's pretend the
		// problem is inventory full because we NEVER forget to actually make the item do we?  DAMMIT!
		// Make it so the PC can re-loot this.
		SetLocalInt(OBJECT_SELF, GetPCPublicCDKey(oTarget), FALSE);
		string sTableID = LEG_COMMON_GetPCTable(oTarget, "placeables");
		
		// Is this a mob drop placeable?  If it is, we never stored this persistently so we don't need
		// to do this if thats the case
		if (!GetLocalInt(OBJECT_SELF, "MOBDeath"))
			SetPersistentInt(oTarget, sPlaceID, 0, 0, sTableID);
		
		// Show some sort of error message to the player
		LEG_COMMON_DisplayInfoBox(oTarget, "Unable to Get Item, Inventory Full or Missing Item!");
	}
}


// //////////////////////////////////////////////////
// LEG_QUEST_QuestCreditPlaceItem
// //////////////////////////////////////////////////
void LEG_QUEST_QuestCreditPlaceItem(string sItem, object oTarget, string sQuestID = "", int iObjective = 0, int iOldCondition = 0, int iStackSize = 1, int iNotifyTarget = 1, int iPCHas = 1, int iPCNeeds = 1, int iEffect = 0, string sPlaceID = "")
{
	// First thing's first.  Destroy the item from the PC's inventory.
	string sItemName = LEG_COMMON_DestroyItems(oTarget, sItem, 1);
	object oIcon;

	// Save the fact that we have performed this objective.	
	LEG_QUEST_ObjectiveCredit(sQuestID, oTarget, "Placed", sItemName, iPCHas, iPCNeeds, iObjective, sPlaceID);

	// If we need to throw out some fireworks or ground shakage or whatever.	
	if (iEffect > 0)
	{
		// Perform some snazzy effect on the placeable
		effect eEffect = EffectVisualEffect(iEffect, FALSE);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, OBJECT_SELF);
	}	
}





// //////////////////////////////////////////////////
// LEG_QUEST_QuestCreditDestroyPlaceable
// //////////////////////////////////////////////////
void LEG_QUEST_QuestCreditDestroyPlaceable(string sItem, object oTarget, string sQuestID = "", int iObjective = 0, int iOldCondition = 0, int iStackSize = 1, int iNotifyTarget = 1, int iPCHas = 1, int iPCNeeds = 1, string sPlaceID = "")
{
	// If we've used an item in this mess, let's destroy it.  This simulates dropping some dynamite down a hole or
	// something similar to that.
	if (sItem != "")
		LEG_COMMON_DestroyItems(oTarget, sItem, 1);

	// Time to announce the destruction of this placeable.
	string sPlaceableName = GetName(OBJECT_SELF);
	object oIcon;
	LEG_QUEST_ObjectiveCredit(sQuestID, oTarget, "Destroyed", sPlaceableName, iPCHas, iPCNeeds, iObjective, sPlaceID);
		
	// Destroy the placeable, and let the Spawn plugin handle bringing it back.
	ExecuteScript("leg_spawn_ondeath", OBJECT_SELF);
	SetPlotFlag(OBJECT_SELF, FALSE);
	AssignCommand(OBJECT_SELF, SetIsDestroyable(TRUE, FALSE, FALSE));	
	DestroyObject(OBJECT_SELF, 2.0, FALSE);
}


// //////////////////////////////////////////////////
// LEG_QUEST_QuestCreditExaminePlaceable
// //////////////////////////////////////////////////
void LEG_QUEST_QuestCreditExaminePlaceable(string sDiscovery, object oTarget, string sQuestID = "", int iObjective = 0, int iPCHas = 1, int iPCNeeds = 1, string sPlaceID = "")
{
	// Not much to this other than just to give credit for looking at something.
	LEG_QUEST_ObjectiveCredit(sQuestID, oTarget, "Discovered", sDiscovery, iPCHas, iPCNeeds, iObjective, sPlaceID);
}


// //////////////////////////////////////////////////
// LEG_QUEST_PlaceableObjectiveCredit
// //////////////////////////////////////////////////
void LEG_QUEST_ObjectiveCredit(string sQuestID, object oTarget, string sObjective, string sObjectiveTarget, int iPCHas, int iPCNeeds, int iObjective, string sPlaceID = "")
{
	// We found our item, now let's get some credit for it.  First we inform the PC that we found this thing.
	// If our sObjectiveTarget text is blank, then send a message to the local chat channel only.
	if (sObjectiveTarget != "")	
		LEG_COMMON_DisplayInfoBox(oTarget, sObjective + " " + sObjectiveTarget + " (" + IntToString(iPCHas) + "/" + IntToString(iPCNeeds) + ")");
	else
		SendMessageToPC(oTarget, sObjective);	
	
	// Next, we update the PC's objective counter with how many they have now.		
	SetLocalInt(oTarget, "QuestID_" + sQuestID + "_OBJ" + IntToString(iObjective), iPCHas);
	
	// Store that same fact persistently.
	string sTableID = LEG_COMMON_GetPCTable(oTarget, "quests");
	SetPersistentInt(oTarget, "QuestID_" + sQuestID + "_OBJ" + IntToString(iObjective), iPCHas, 0, sTableID);
	
	// Play a pretty sound!
	PlaySound("gui_journaladd");

	// If this is a placeable object...
	if (GetObjectType(OBJECT_SELF) == OBJECT_TYPE_PLACEABLE)
	{
		// We also want to ensure the object isn't used again.
		if (!GetLocalInt(OBJECT_SELF, "MOBDeath"))
		{
			sTableID = LEG_COMMON_GetPCTable(oTarget, "placeables");
			SetPersistentInt(oTarget, sQuestID + "_" + sPlaceID, TRUE, 0, sTableID);
		}
		else
		{
			// Lets make sure they can't search anymore during this server reset.
			SetLocalInt(OBJECT_SELF, GetPCPublicCDKey(oTarget), TRUE);
		}
	}	
	
	// If using the Quest Icon configuration, refresh anyone that's nearby that may need to be.
	if (LEG_QUEST_ICONS)
	{
		object oIcon;
		object oNextNPC = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oTarget), FALSE, OBJECT_TYPE_CREATURE);
		while (GetIsObjectValid(oNextNPC))
		{
			oIcon = GetLocalObject(oNextNPC, "MyIcon");
			LEG_QUEST_RefreshQuestIcon(oNextNPC, oIcon, oTarget);				
			oNextNPC = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oTarget), FALSE, OBJECT_TYPE_CREATURE);			
		}	
	}
}
/*

    Script:			Called then the PC clicks Finish on a quest.  This script will
					finish a quest and allow the player to get the spoils (or lose quest items)
	Version:		1.00
	Plugin Version: 1.7
	Last Update:	06/23/2011
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
void main(int iQuestID, int iNPC, int iObj1, int iObj2, int iObj3, int iObj4, int iObj5, int iAdvanceNPC, int iRewardChoice, int iRewards, int iQuestType)
{
	// Get the quest finisher.
	object oNPC = GetLocalObject(OBJECT_SELF, "QNPC");

	// Set up some variables.
	int iLink, iNPCInNextQuest, iRewardCounter;
	string sQuestID = IntToString(iQuestID);
	string sNextQuest;

	// Ensure the PC has selected one of the available rewards if there are any.
	if (iRewards)
	{
		if (iRewardChoice == 0 && iRewards > 1)
		{
			LEG_COMMON_DisplayInfoBox(OBJECT_SELF, "Select a Reward.");
			return;
		}
		else if (iRewardChoice == 0 && iRewards == 1)
			iRewardChoice = 1;
	}

	// If a reward has been chosen then close the gui.
	CloseGUIScreen(OBJECT_SELF, "leg_quest_finish");

	// If we're a repeatable quest then we need to determine that now so we can
	// either finish the quest for good, or allow it to be restarted.
	string sTableID = LEG_COMMON_GetPCTable(OBJECT_SELF, "quests");
	int iFinishState;
	int iRepeats = GetLocalInt(oNPC, "LEG_QUEST_Repeats_" + IntToString(GetLocalInt(OBJECT_SELF, "LEG_QuestPos")));
	int iCompletes = GetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_Completes", sTableID);
	if (iRepeats == 0)
		iFinishState = 999;
	else if (iRepeats == -1)
		iFinishState = 0;
	else if (iCompletes < iRepeats)
		iFinishState = 0;
	else
		iFinishState = 999;
	
	// If the finish state is 0 at this point, we're allowed to repeat however, there is now an elapsed time
	// that is allowed to pass.  If the time is set to 0, then we can keep the finish state at 0, if however
	// the elapsed timer is not 0, then we need to set the quest state to 998.  Then in the openquest script,
	// we check to see if the time has passed for this quest.
	// IMPORTANT: When this timer gets checked, we will only check the LOCAL INT of the PC if the world is not
	// using Legends Persistent Time.  If Legends Persistent Time is active, we will get the stored time.
	int iTimeMins = GetLocalInt(oNPC, "LEG_QUEST_RepeatMins_" + IntToString(GetLocalInt(OBJECT_SELF, "LEG_QuestPos")));
	if (iTimeMins != 0 && iFinishState != 999)
	{
		// Store the state as 998!
		iFinishState = 998;	
		int iTimer = (iTimeMins * REAL_MINUTES) + LEG_COMMON_TimeStamp();
		SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_NextRepeat", iTimer);
		SetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_NextRepeat", iTimer, 0, sTableID);
	}
	
	SetLocalInt(OBJECT_SELF, "LEG_QuestPos", 0);
	
	// Add one complete to whatever we already have.
	iCompletes++;
	SetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_Completes", iCompletes, 0, sTableID);
	
	// Store the data - we've finished.
	SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_NPC", iFinishState);
	SetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_NPC", iFinishState, 0, sTableID);

	// Clean up the objective entries.. we don't need them anymore.  As well, clean up the Locals
	DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ1", sTableID);
	DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ2", sTableID);
	DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ3", sTableID);
	DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ4", sTableID);
	DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ5", sTableID);
	DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ6", sTableID);
	DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ7", sTableID);
	DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ8", sTableID);
	DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ9", sTableID);
	DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ10", sTableID);
	SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ1", 0);
	SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ2", 0);
	SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ3", 0);
	SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ4", 0);
	SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ5", 0);
	SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ6", 0);
	SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ7", 0);
	SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ8", 0);
	SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ9", 0);
	SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ10", 0);
	

	// Perform a Deed annoucement if appropriate
	if (iQuestType == 3)
	{
		// Grab the title of the deed.
		SQLExecDirect("SELECT `Title` FROM `" + QUESTPREFIX + "_mainquests` WHERE `QuestID`='" + sQuestID + "'");
		SQLFetch();
		string sDeedName = SQLGetData(1);
		
		// If the Info plugin is active, then identify the crier and add this announcment
		if (GetLocalInt(GetModule(), "LEG_INFO_ACTIVE"))
		{
			AddScriptParameterString("At " + LEG_COMMON_GetTimeNon24(GetTimeHour(), LEG_COMMON_GetGameTimeMinute()) + " on " + LEG_COMMON_GetMonthName(GetCalendarMonth()) + " " + IntToString(GetCalendarDay()) + ", " + IntToString(GetCalendarYear()));
			AddScriptParameterString(GetName(OBJECT_SELF) + " has completed the " + sDeedName + " deed!");
			ExecuteScriptEnhanced("leg_info_crieradd", OBJECT_SELF);
		}
		
		// If Shout announcements for deeds are active, do that now.  (NOTE Try to get the mod to do this after testing)
		if (LEG_QUEST_DEEDSHOUTS)
			SpeakString(GetName(OBJECT_SELF) + " has completed the " + sDeedName + " deed!", TALKVOLUME_SHOUT);
	}	
	
	// Play a pretty quest done sound and notify the PC
	PlaySound("gui_quest_done");
	LEG_COMMON_DisplayInfoBox(OBJECT_SELF, "Quest Completed");

	// If we're using the Resting plugin, we should store the players locaton if this is not an instance.
	if (GetLocalInt(GetModule(), "LEG_REST_ACTIVE"))
		ExecuteScript("leg_rest_savepc", OBJECT_SELF);
		
	// Get the level of the quest.
	int iQuestLevel;
	SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_questheader` WHERE `QuestID` = " + sQuestID);
	while (SQLFetch())
		iQuestLevel = StringToInt(SQLGetData(9));
	
	// We should remove any props that we shouldn't have.  Props are NEVER to be used as rewards.
	// Unlike the normal GIVEITEMS, we override that and remove any props even if they have a GIVE
	// cuz we don't want PROPS carried over at the end of a quest.  It's our way!
	SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_propitems` WHERE `QuestID` = '" + sQuestID + "';");
	while (SQLFetch())
	{
		string sAction = SQLGetData(2);
		string sParameter1 = SQLGetData(3);
		string sParameter2 = SQLGetData(4);
		string sParameter3 = SQLGetData(5);	
		string sParameter4 = SQLGetData(6);	
		
		// Look for those GIVEITEM actions
		if (sAction == "GIVEITEM")
		{
			// Yes we're supposed to give out props here, but if a builder managed to put
			// any props in this whole quest, we're taking them all back.  That's why they
			// are props.  If the builder wants to give a PC an item to keep, use a reward item,
			// not a prop.  (Notice we did not filter by NPC ID in the SQL above).
			LEG_COMMON_DestroyItems(OBJECT_SELF, sParameter1, StringToInt(sParameter2));
		}
		
		// Look for those GIVEITEM actions
		if (sAction == "TAKEITEM")
		{
			// Put our props in the lootbag, then call our special Loot Bag item create function 
			LEG_COMMON_DestroyItems(OBJECT_SELF, sParameter1, StringToInt(sParameter2));
		}
		
	}
	
	
	// Time to hand out the goods!
	SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_questrewards` WHERE `QuestID` = " + sQuestID);
	while (SQLFetch())
	{
		// Grab all the reward actions for this row.
		string sAction = SQLGetData(2);
		string sParameter1 = SQLGetData(3);
		string sParameter2 = SQLGetData(4);
		string sParameter3 = SQLGetData(5);	
		string sParameter4 = SQLGetData(6);	
		
		// If we're giving XP.. hell yeah!  Then lets give it!
		if (sAction == "GIVEXP")
		{
			// Find out how much XP to give.
			int iXP = StringToInt(sParameter1);
			
			// Adjust XP reward based on level.. we don't want high level players getting too much XP from low
			// level quests so lets chop it up some.
			int iPCLevel = GetTotalLevels(OBJECT_SELF, FALSE);
			if (iPCLevel - iQuestLevel > 1)
				iXP = iXP / (iPCLevel - iQuestLevel);
			
			// Now Hand the XP over and display how much we got!
			sParameter1 = IntToString(iXP);
			GiveXPToCreature(OBJECT_SELF, iXP);
			FloatingTextStringOnCreature("<color=lightblue> " + sParameter1 + " XP Gained </color>", OBJECT_SELF, FALSE);
		}
		else if (sAction == "GIVEGOLD")
		{
			// Oh.. some gold too?  Yes please.
			GiveGoldToCreature(OBJECT_SELF, StringToInt(sParameter1));
		}
		else if (sAction == "TAKEITEM")
		{
			// Some props that we may have had to collect.. time do get rid of those.
			LEG_COMMON_DestroyItems(OBJECT_SELF, sParameter1, StringToInt(sParameter2));			
		}
		else if (sAction == "GIVEITEM")
		{
			// Time to give our selected reward out.
			iRewardCounter++;
			if (iRewardCounter == iRewardChoice)
			{
				// How many do we give?
				int iTotal = StringToInt(sParameter2);
				int iCount;
				
				// Ok, hand them over.
				LEG_COMMON_CreateItem(OBJECT_SELF, sParameter1, iTotal);
			}
		}
		else if (sAction == "GIVEFEAT")
		{
			// Lore books give feats.  Let's do that!
			int iFeat = StringToInt(sParameter1);
			
			// Actual Give Feat Code.
			FeatAdd(OBJECT_SELF, iFeat, FALSE);
			
			// Assign Ability - All our feat rewards need to be listed here.  There's no real easy way around this
			// Too bad too.
			LEG_QUEST_GiveFeat(OBJECT_SELF, iFeat);
			
			// Let them know about our new feat.
			SendMessageToPC(OBJECT_SELF, "New Feat Gained!");
		}		
		else if (sAction == "LINK")
		{
			// Are we linking to another quest?  If so, let's get ready for that.
			iLink = TRUE;
			sNextQuest = sParameter1;
			iNPCInNextQuest = StringToInt(sParameter2);
		}
	}

	// Hand out bonus XP for skill checks
	int iBonusXP = GetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_BonusXP", sTableID);
	if (iBonusXP)
	{
		// Adjust XP reward based on level.. we don't want high level players getting too much XP from low
		// level quests so lets chop it up some.
		int iPCLevel = GetTotalLevels(OBJECT_SELF, FALSE);
		if (iPCLevel - iQuestLevel > 1)
			iBonusXP = iBonusXP / (iPCLevel - iQuestLevel);
		
		// Now Hand the XP over and display how much we got!
		string sParameter1 = IntToString(iBonusXP);
		GiveXPToCreature(OBJECT_SELF, iBonusXP);
		FloatingTextStringOnCreature("<color=lightblue> " + sParameter1 + " Skill Use XP Gained </color>", OBJECT_SELF, FALSE);
	}
	
	
	// Clean up extra variables when the quest is finally completed.
	if (iFinishState == 999)
	{
		DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_NextRepeat", sTableID);
		DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_Completes", sTableID);
		DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_Type", sTableID);
		DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_BonusXP", sTableID);
		DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_FailTime", sTableID);
		SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_1_ReluctantPassed", 0);
		SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_2_ReluctantPassed", 0);
		SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_3_ReluctantPassed", 0);
		SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_4_ReluctantPassed", 0);
		SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_5_ReluctantPassed", 0);
		string sPCTableName = LEG_COMMON_GetPCTable(OBJECT_SELF, "quests");
		SQLExecDirect("DELETE FROM `" + sPCTableName + "` WHERE `Name` LIKE 'QuestID_" + sQuestID + "_%_ReluctantPassed'");
	}
	
	if (iFinishState == 998)
	{
		string sPCTableName = LEG_COMMON_GetPCTable(OBJECT_SELF, "quests");
		SQLExecDirect("DELETE FROM `" + sPCTableName + "` WHERE `Name` LIKE 'QuestID_" + sQuestID + "_%_ReluctantPassed'");
		SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_1_ReluctantPassed", 0);
		SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_2_ReluctantPassed", 0);
		SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_3_ReluctantPassed", 0);
		SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_4_ReluctantPassed", 0);
		SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_5_ReluctantPassed", 0);
		DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_BonusXP", sTableID);
		DeletePersistentVariable(OBJECT_SELF, "QuestID_" + sQuestID + "_FailTime", sTableID);
		
		// Clean up placeable objects that will say "no more clicking for you!" because they have been saved
		// persistently.
		sPCTableName = LEG_COMMON_GetPCTable(OBJECT_SELF, "placeables");
		SQLExecDirect("DELETE FROM `" + sPCTableName + "` WHERE `Name` LIKE '" + sQuestID + "_%'");
	
	}
	
	
	
	// SAVE!
	ExportSingleCharacter(OBJECT_SELF);
			
	// If there was a LINK command in there, let's process it last.
	if (iLink && iFinishState == 999)
	{
		LEG_QUEST_FireQuestGUI("leg_quest_offer", "leg_quest_offer.xml", OBJECT_SELF, iNPCInNextQuest, sNextQuest);
		SetPersistentInt(OBJECT_SELF, "QuestID_" + sNextQuest + "_" + IntToString(iNPCInNextQuest) + "_ReluctantPassed", 1, 0, sTableID);
		SetLocalInt(OBJECT_SELF, "QuestID_" + sNextQuest + "_" + IntToString(iNPCInNextQuest) + "_ReluctantPassed", 1);
	}
		
	// If the PC had any henchmen for this quest, remove them.
	SetLocalInt(oNPC, "Henchman", 0);

	// Refresh any icons if we are using that ability.
	if (GetIsObjectValid(oNPC))
	{
		// Time to refresh OTHER NPC quest Icons that are nearby after accepting this quest.
		if (LEG_QUEST_ICONS)
		{
			object oIcon;
			object oTrap = GetNearestTrapToObject(oNPC, FALSE);
			SetTrapDisabled(oTrap);			
			object oNextNPC = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
			while (GetIsObjectValid(oNextNPC))
			{
				// This section is there's another PC in the vicinity.  If so, I best reset my question
				// icon for them.
				if (GetIsPC(oNextNPC))
				{
					oIcon = GetLocalObject(oNPC, "MyIcon");
					LEG_QUEST_RefreshQuestIcon(oNPC, oIcon, oNextNPC);				
				}
				else
				{
					oIcon = GetLocalObject(oNextNPC, "MyIcon");
					LEG_QUEST_RefreshQuestIcon(oNextNPC, oIcon, OBJECT_SELF);
				}
				
				// Grab the next NPC.
				oNextNPC = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);			
			}	
		}			
	}	
}
/*

    Script:			Initializes players after each server reset.  Sets up their Quest Vars and feats from Lore Books
	Version:		1.00
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
	// The VERY VERY first thing we need to do is find out if this PC has ever been here before.  If they haven't
	// they'll need their quest tables set up.
	// Ever been here before Mr PC?
	object oPC = OBJECT_SELF;
	string sTableID;
	int iFirstTime = GetPersistentInt(oPC, "Initialized", QUESTPREFIX + "_questors");
	if (!iFirstTime)
	{
		// Welcome n00b.
		SetPersistentInt(oPC, "Initialized", 1, 0, QUESTPREFIX + "_questors");
		
		// Create a table for this players quests.  Each player has their own table
		// for performance - 1000 quests leads to 5000 entries.  Times that by each
		// character and you quickly have a table in the hundreds of thousands.  Great for
		// high end, high performance database, but we don't have that and we don't mind
		// having a table for each player - would only be a couple hundred.  Suck it up princess!
		// At least their organized.
		sTableID = LEG_COMMON_GetPCTable(oPC, "quests");
		SQLExecDirect("CREATE TABLE `" + DBNAME + "`.`" + sTableID + "` (`player` varchar( 64 ) NOT NULL default '~',`tag` varchar( 64 ) NOT NULL default '~',`name` varchar( 64 ) NOT NULL default '~',`val` text,`expire` int( 11 ) default NULL ,`last` timestamp NOT NULL default CURRENT_TIMESTAMP ,`questtype` tinyint(4) NOT NULL default '0' ,PRIMARY KEY ( `player` , `tag` , `name` ) ) ENGINE = MYISAM DEFAULT CHARSET = latin1;");
		sTableID = LEG_COMMON_GetPCTable(oPC, "placeables");
		SQLExecDirect("CREATE TABLE `" + DBNAME + "`.`" + sTableID + "` (`player` varchar( 64 ) NOT NULL default '~',`tag` varchar( 64 ) NOT NULL default '~',`name` varchar( 64 ) NOT NULL default '~',`val` text,`expire` int( 11 ) default NULL ,`last` timestamp NOT NULL default CURRENT_TIMESTAMP ,PRIMARY KEY ( `player` , `tag` , `name` ) ) ENGINE = MYISAM DEFAULT CHARSET = latin1;");
	}			

	// If the quest journal system is setup to use the item...
	LEG_COMMON_DestroyItems(oPC, "leg_quest_journal", -1);
	if (!JOURNAL_OVERRIDE)
	{
		// Give the PC the journal tool.
		CreateItemOnObject("leg_quest_journal", oPC, 1);	
	}
		
	// First thing we do is grab all the quests in our table.
	sTableID = LEG_COMMON_GetPCTable(OBJECT_SELF, "quests");
	string sQuestID, sQuestIDFull;
	int iNPCPos, iActiveQuests, iCounter;
	
	// Fire off the SQL for this.
	SQLExecDirect("SELECT * FROM `" + sTableID + "` WHERE `name` LIKE '%NPC%'");
	while(SQLFetch())
	{
		// Grab the QuestID and the NPC step we are on.
		sQuestIDFull = SQLGetData(3);
		iNPCPos = StringToInt(SQLGetData(4));
		
		// Parse out the string from the table to get the 4 digit Quest ID.
		sQuestID = GetStringRight(GetStringLeft(sQuestIDFull, 12), 4);
		
		// Save this position on the PC.
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC", iNPCPos);
		
		// If the quest is not finished then we increment our quest counter.
		if (iNPCPos != 999 && iNPCPos != 998)
		{
			iActiveQuests++;
			SetLocalString(oPC, "QuestCounter_" + IntToString(iActiveQuests), sQuestID);
		}
	}
	
	// Now go through our active quests and setup local variables for each objective we are on.
	while (iCounter <= iActiveQuests)
	{
		iCounter++;
		sQuestID = GetLocalString(oPC, "QuestCounter_" + IntToString(iCounter));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_Type", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_Type", sTableID));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ1", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ1", sTableID));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ2", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ2", sTableID));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ3", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ3", sTableID));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ4", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ4", sTableID));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ5", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ5", sTableID));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ6", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ6", sTableID));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ7", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ7", sTableID));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ8", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ8", sTableID));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ9", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ9", sTableID));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ10", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ10", sTableID));
		
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_1_ReluctantPassed", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_1_ReluctantPassed", sTableID));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_2_ReluctantPassed", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_2_ReluctantPassed", sTableID));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_3_ReluctantPassed", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_3_ReluctantPassed", sTableID));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_4_ReluctantPassed", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_4_ReluctantPassed", sTableID));
		SetLocalInt(oPC, "QuestID_" + sQuestID + "_5_ReluctantPassed", GetPersistentInt(oPC, "QuestID_" + sQuestID + "_5_ReluctantPassed", sTableID));		
	}
	
	// Apply feats that we typically don't have after a server reset.
	ExecuteScript("leg_quest_applyfeats", oPC);
}
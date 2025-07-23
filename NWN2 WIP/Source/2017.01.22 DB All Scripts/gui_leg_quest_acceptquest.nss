/*

    Script:			If the PC accepts the quest offered.  Called by the OFFER GUI when the player hits 
					the Accept Button.
	Version:		1.01
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		N/A
	
	Change Log:		06/23/2011 - 1.00 MV - Initial Release
					12/15/2011 - 1.01 MV - Fixed bug where prop items would not drop if no loot bag.
	
*/


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_quest_include"
#include "leg_all_fixedgincwp"



// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main(int iQuestID, int iNPC, int iObj1, int iObj2, int iObj3, int iObj4, int iObj5, int iAdvanceNPC, int iRewardsChoice, int iRewards, int iQuestType, int iAdvanceOBJ)
{
	// Setup some variables, grabbing the string version of the Quest ID which was passed by the GUI.
	string sQuestID = IntToString(iQuestID);
	int iCount;

	// Create a name for the table structure for this player.  In this case, we're looking at
	// the "quests" table for this PC.
	string sTableID = LEG_COMMON_GetPCTable(OBJECT_SELF, "quests");
	
	// If this NPC is on an escort, just exit the gui.  Seriously?  Just exit the GUI?  Where does it tell the
	// NPC to start walking?  WTF?!  Oh wait.. DUH.  The NPC is NEVER on the Escort quest at this point.  BUT
	// we could somehow end up back in this script if we managed to fire the GUI again somehow so lets catch that.
	object oNPC = GetLocalObject(OBJECT_SELF, "QNPC");
	if (GetLocalInt(oNPC, "OnEscort"))
		return;
		
	// You're only allowed to have 15 quests going at any given time.  So lets make sure that we check
	// for this when the player hits accept.
	SQLExecDirect("SELECT COUNT(*) FROM `" + sTableID + "` WHERE `name` LIKE '%NPC%' AND `val` != '999' AND `questtype` = " + IntToString(iQuestType));
	while(SQLFetch())
		iCount = StringToInt(SQLGetData(1));

	// Oh Oh, looks like we have 15 quests active already.  Let's fire and info box and let the PC know.	
	if (iCount >= MAXQUESTS)
	{
		LEG_COMMON_DisplayInfoBox(OBJECT_SELF, "You already have " + IntToString(MAXQUESTS) + " active quests.");
		return;	
	}
			
	// Store the data - we've accepted.
	SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_NPC", iNPC);
	SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_Type", iQuestType);
	SetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_Type", iQuestType, 0, sTableID);
	SetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_NPC", iNPC, 0, sTableID);
	SQLExecDirect("UPDATE " + sTableID + " SET `questtype`='" + IntToString(iQuestType) + "' WHERE `name` = 'QuestID_" + sQuestID + "_NPC'");	
	
	// Check and see if there are any props that have to be given to the PC
	// Time to hand out the goods!
	SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_propitems` WHERE `QuestID` = '" + sQuestID + "' AND `NPCID` = '" + IntToString(iNPC) + "';");
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
			// Put our props in the lootbag, then call our special Loot Bag item create function 
			object oLootBag = LEG_COMMON_GetInventoryItemByTag(OBJECT_SELF, "leg_quest_questbag");
			LEG_COMMON_CreateItem(OBJECT_SELF, sParameter1, StringToInt(sParameter2), oLootBag);
		}
	}
	
	// Accepted Sound - awww.. pretty.
	PlaySound("gui_journaladd");
	
	// Now we figure out what sort of quest we just accepted.
	string sQuestType;
	switch (iQuestType)
	{
		case 0:	sQuestType = "Quest";
				break;
		case 1: sQuestType = "Lore Book";
				break;
		case 2: sQuestType = "Deed";
				break;
		case 3: sQuestType = "Collection";
				break;
	}
	
	// Tell our hearty adventurer what we've just done.
	LEG_COMMON_DisplayInfoBox(OBJECT_SELF, "Accepted New " + sQuestType);
	
	// If the acceptance of this quest, advances an objective, then lets set it here.
	if (iAdvanceOBJ)
	{
		SetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ" + IntToString(iAdvanceOBJ), 1, 0, sTableID);
		SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_OBJ" + IntToString(iAdvanceOBJ), 1);
		PlaySound("gui_journaladd");
	}
	
	// If we're using the Resting plugin, we should store the players locaton if this is not an instance.
	if (GetLocalInt(GetModule(), "LEG_REST_ACTIVE"))
		ExecuteScript("leg_rest_savepc", OBJECT_SELF);

	// Of course, Me being the NPC you just accepted from which isn't stored anywhere 
	// so we have to figure out who the hell gave it us.  I knew we'd need this somewhere hehe.
	if (GetIsObjectValid(oNPC))
	{
		// Speak a little ta ta.
		PlayVoiceChat(VOICE_CHAT_GOODBYE, oNPC);
		
		// If this NPC spawns an encounter or the like, process it here.
		object oWP;
		int iSpawnMobs;
		
		// If the NPC or Quest Starter can have up to three spawn points active.  This leverages the
		// SPAWN PLUGIN and thus must be configured appropriately.  Use standard spawn plugin procedures
		// along with the SPAWN "LEG_SPAWN_TriggerSpawn" variable.  The Spawn waypoint will remain active
		// even if the server resets via the persistence table.
		string sMobSpawn = GetLocalString(oNPC, "LEG_QUEST_Spawn_1_" + sQuestID);
		if (sMobSpawn != "")
		{
			iSpawnMobs = 1;
			oWP = GetWaypointByTag(sMobSpawn);
			SetLocalInt(oWP, "LEG_SPAWN_TriggerSpawn", 0);
			
			// Persist
			SetPersistentInt(OBJECT_SELF, sMobSpawn, 1, 0, QUESTPREFIX + "_questspawns");
			SetLocalInt(OBJECT_SELF, sMobSpawn, 1);
		}
		sMobSpawn = GetLocalString(oNPC, "LEG_QUEST_Spawn_2_" + sQuestID);
		if (sMobSpawn != "")
		{
			oWP = GetWaypointByTag(sMobSpawn);
			SetLocalInt(oWP, "LEG_SPAWN_TriggerSpawn", 0);

			// Persist
			SetPersistentInt(OBJECT_SELF, sMobSpawn, 1, 0, QUESTPREFIX + "_questspawns");
			SetLocalInt(OBJECT_SELF, sMobSpawn, 1);

		}
		sMobSpawn = GetLocalString(oNPC, "LEG_QUEST_Spawn_3_" + sQuestID);
		if (sMobSpawn != "")
		{
			oWP = GetWaypointByTag(sMobSpawn);
			SetLocalInt(oWP, "LEG_SPAWN_TriggerSpawn", 0);

			// Persist
			SetPersistentInt(OBJECT_SELF, sMobSpawn, 1, 0, QUESTPREFIX + "_questspawns");
			SetLocalInt(OBJECT_SELF, sMobSpawn, 1);
		}
		
		// If we're supposed to Spawn Mobs, then we want to activate them now ensuring the
		// SPAWN Plugin is active.  Also, if the PC is going to get help from the NPC
		// we want to set the special henchman flag so the henchman does not steal the kill.
		if (iSpawnMobs && GetLocalInt(GetModule(), "LEG_SPAWN_ACTIVE"))
		{
			ExecuteScript("leg_spawn_checkspawns", OBJECT_SELF);
			if (GetLocalInt(oNPC, "LEG_QUEST_Henchman"))
				SetLocalInt(oNPC, "Henchman", 1);
		}

		// Some NPC aka Items, need to be destroyed after the PC accepts the quest such as a Lore Book
		if (GetLocalInt(oNPC, "LEG_QUEST_DestroyMe"))
		{
			LEG_COMMON_DestroyItems(OBJECT_SELF, GetTag(oNPC));
		}

		// We have our quest NPC, let's refresh their icon if that option is active.
		object oIcon;
		if (LEG_QUEST_ICONS)
		{
			oIcon = GetLocalObject(oNPC, "MyIcon");
			object oTrap = GetNearestTrapToObject(oNPC, FALSE);
			SetTrapDisabled(oTrap);
			LEG_QUEST_RefreshQuestIcon(oNPC, oIcon, OBJECT_SELF);
		}
		
		// If this is an escort quest, then we have some special things to do.
		// First we find out if the quest we just accepted is an escort.  In order to use ESCORT quests
		// the AI plugin has to be active.
		string sPatrolRoute = GetLocalString(oNPC, "LEG_AI_WalkRoute");
		int iEscort = GetLocalInt(oNPC, "LEG_QUEST_Escort_1_" + sQuestID);

		if (iEscort != 0 && GetLocalInt(GetModule(), "LEG_AI_ACTIVE"))
		{
			// Destroy the quest icon if we are using them.
			if (LEG_QUEST_ICONS)
				DestroyObject(oIcon);
		
			// Advance any players ALSO on this quest and notify them ONLY if they are in the area.
			// This allows parties to all participate in the escort.
			object oPC = OBJECT_SELF;
			object oMember = GetFirstFactionMember(oPC);
	    	while(oMember != OBJECT_INVALID)
	    	{
		        if (GetIsPC(oMember) && GetArea(oMember) == GetArea(oPC))
	        	{
					// Is the player on the quest and are they on this step?
					int iPlayerNPC = GetLocalInt(oMember, "QuestID_" + sQuestID + "_NPC");				
					int iPlayerOBJCount = GetLocalInt(oMember, "QuestID_" + sQuestID + "_OBJ1");
					
					// If the PC is NOT on this quest and hasn't completed it AND has less than 15
					// current quests, automatically add it to their quest journal and close the GUI if
					// they happen to have it up.
					iCount = 0;
					string sMemberTableID = LEG_COMMON_GetPCTable(oMember, "quests");
					SQLExecDirect("SELECT COUNT(*) FROM `" + sMemberTableID + "` WHERE `name` LIKE '%NPC%' AND `val` != '999' AND `questtype` = " + IntToString(iQuestType));
					while(SQLFetch())
						iCount = StringToInt(SQLGetData(1));		
					
					// If our PC is eligible for this quest, give it to them otherwise, just inform them.	
					if (iPlayerNPC == 0 && iCount < 15 )
					{
						// If the party member is indeed on the quest, then save this fact.
						SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_NPC", iNPC);
						SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_Type", iQuestType);
						SetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_Type", iQuestType, 0, sMemberTableID);
						SetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_NPC", iNPC, 0, sMemberTableID);
						SQLExecDirect("UPDATE " + sMemberTableID + " SET `questtype`='" + IntToString(iQuestType) + "' WHERE `name` = 'QuestID_" + sQuestID + "_NPC'");	
					
						// Let the Party Member know someone started this escort quest.
						LEG_COMMON_DisplayInfoBox(oMember, "Escort Quest Started by " + GetName(oPC));
						PlaySound("gui_journaladd");
					}
					else
						LEG_COMMON_DisplayInfoBox(oMember, "Escort Quest Started by " + GetName(oPC));
					
					// Close the OFFER GUI if the PC was just sitting there.
					CloseGUIScreen(oMember, "leg_quest_offer");

				}
				oMember = GetNextFactionMember(oPC);
			}	
			
			// Set some sort of variable flag, so he will NOT speak during his walk.  He can still send out oneliner
			// notes using the waypoint walking script itself.  Like stopping for a rest or buffs etc. if its a long one.
			SetLocalInt(oNPC, "OnEscort", 1);
			
			// Remove any PLOT flag he may have so he can be killed.
			SetPlotFlag(oNPC, FALSE);
			SetMovementRateFactor(oNPC, 1.75);
			AssignCommand(oNPC, SetIsDestroyable(TRUE, FALSE, FALSE));
			
			// Set my escorter
			SetLocalObject(oNPC, "MyEscort", OBJECT_SELF);
			SetLocalString(oNPC, "MyEscort_Quest", sQuestID);
			
			// Get his route.  Then we send him on his way.
			SetLocalInt(oNPC, "X2_L_SPAWN_USE_AMBIENT_IMMOBILE", 0);
			SetCreatureFlag(oNPC, "CREATURE_VAR_USE_SPAWN_AMBIENT_IMMOBILE", FALSE);
			SetLocalInt(oNPC, "X2_L_SPAWN_USE_AMBIENT", 0);
			SetCreatureFlag(oNPC, "CREATURE_VAR_USE_SPAWN_AMBIENT", FALSE);			
			SetLocalString(oNPC, "WP_TAG", sPatrolRoute);
			SetWWPController(sPatrolRoute, oNPC);
			SetBumpState(oNPC, BUMPSTATE_BUMPABLE);
			AssignCommand(oNPC, ClearAllActions());
			AssignCommand(oNPC, WalkWayPoints(TRUE, "heartbeat"));
			
		}		
		
		// Time to refresh OTHER NPC quest Icons that are nearby after accepting this quest.
		if (LEG_QUEST_ICONS)
		{
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
/*

    Script:			If the PC continues the current quest.  Usually not needed for PC's that simply
					re-talk to the same PC however if the player must talk to multiple NPC's for a 
					quest prior to finishing, we can use the Continue GUI and still advance the quest.
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
#include "leg_all_fixedgincwp"



// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main(int iQuestID, int iNPC, int iObj1, int iObj2, int iObj3, int iObj4, int iObj5, int iAdvanceNPC, int iQuestType)
{
	// Setup some variables, grabbing the string version of the Quest ID which was passed by the GUI.
	string sQuestID = IntToString(iQuestID);
	int iCount;
	
	// If this NPC is on an escort, just exit the gui.
	object oNPC = GetLocalObject(OBJECT_SELF, "QNPC");
	if (GetLocalInt(oNPC, "OnEscort"))
		return;

	string sTableID = LEG_COMMON_GetPCTable(OBJECT_SELF, "quests");
	if (iAdvanceNPC != 0)
	{
		// Move the quest along to the next NPC!
		int iNextNPC;
		if (iNPC != iAdvanceNPC)
			iNextNPC = iAdvanceNPC;
		else
			iNextNPC = iNPC;

		// If I am advancing on to the next NPC from this continue, store that information.
		SetLocalInt(OBJECT_SELF, "QuestID_" + sQuestID + "_NPC", iNextNPC);
		SetPersistentInt(OBJECT_SELF, "QuestID_" + sQuestID + "_NPC", iNextNPC, 0, sTableID);
		
		// Now that we have changed NPC's because of the Advance NPC variable, we need to clear out all the
		// other objectives.  I am concerned that by adding this for the Lore Books, I am breaking something else
		// that uses this variable.  Check other quests that use this variable
		LEG_QUEST_ClearObjectives(OBJECT_SELF, sQuestID, sTableID);

		// Check and see if there are any props that have to be given to the PC
		// Time to hand out the goods or take them as the case may be!
		// I only give and remove props if I am advancing along the quest.  Coming back and talking to me
		// while still on my step won't re-run the prop stuff.
		int iRemoveCycle = FALSE;
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
				LEG_COMMON_CreateItem(oLootBag, sParameter1, StringToInt(sParameter2));
			}
			
			// Look for those GIVEITEM actions
			if (sAction == "TAKEITEM")
			{
				if (sParameter1 == "<Remove All>")
				{
					iRemoveCycle = TRUE;
				}
				else
				{
					// Put our props in the lootbag, then call our special Loot Bag item create function 
					LEG_COMMON_DestroyItems(OBJECT_SELF, sParameter1, StringToInt(sParameter2));
				}
			}
			
		}

		if (iRemoveCycle)
		{		
			SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_propitems` WHERE `QuestID` = '" + sQuestID + "' AND `Action` = 'GIVEITEM';");
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
					// Take all the GIVE items.
					LEG_COMMON_DestroyItems(OBJECT_SELF, sParameter1, StringToInt(sParameter2));
				}
			}						
		}
		// Play a pretty sound
		PlaySound("gui_journaladd");

		// If we're using the Resting plugin, we should store the players locaton if this is not an instance.
		if (GetLocalInt(GetModule(), "LEG_REST_ACTIVE"))
			ExecuteScript("leg_rest_savepc", OBJECT_SELF);
		
	}


	// If this NPC spawns an encounter or the like, process it here.
	object oWP;
	int iSpawnMobs;
	
	// If the NPC or Quest Starter is performing a continue can have up to three spawn points active.  This leverages the
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

	
	
	// Refresh my Quest Icon for anyone around me.  Of course, Me being the NPC you just accepted from which
	// isn't stored anywhere so we have to figure out who the hell gave it us.
	oNPC = GetLocalObject(OBJECT_SELF, "QNPC");
	if (GetIsObjectValid(oNPC))
	{
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
			AssignCommand(oNPC, SetIsDestroyable(TRUE, FALSE, FALSE));
			
			//SpeakString("Beginning Escort.  Waypoint Route: " + sPatrolRoute, TALKVOLUME_SHOUT);
			
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
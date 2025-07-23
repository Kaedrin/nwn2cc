/*

    Script:			Called from the On Item Acquired Event of the module for processing quest items that are obtained by the PC
					through non-standard means.  Such as buying an item from a store, looting an item from a standard loot chest etc.
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
#include "leg_quest_itemacquired_def"


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main(object oPC, object oItem)
{
	// Often times items that come from stores etc, will not have any variables saved on them.  This is an engine bug
	// that REALLY REALLY sucks.  As a result, the only workaround is to identify the item the PC got and apply
	// any known variables to them here.  Yes I know, stop yelling at me, it's not my fault.  Included in this plugin are
	// the item definitions from some quests from the Legends Persistent World.  This will give you an idea of what goes in here.
	// Some of these items come from other quests, some come from a store the PC may have had to purchase the item from.
	// All the item variables are kept in a definitions script called "leg_quest_itemacquired_def".
	string sItemRef = GetResRef(oItem);
	LEG_QUEST_ITEMACQUIRED_Defs(sItemRef, oItem);

	// Check for quest items
	// Make sure PC is initialized - apparantly this fires when a player first logs in and we don't want it going off
	// at that point.
	if (GetLocalInt(oPC, "LEG_PLAYER_INIT"))
	{
		// Is our newly acquired item part of a quest?
		if (GetLocalInt(oItem, "LEG_QUEST_TotalQuests"))
		{
			// Yes it is.  Let's see what quest its for.
			string sQuestID = GetLocalString(oItem, "LEG_QUEST_QuestID_1");
			int iObjective = GetLocalInt(oItem, "LEG_QUEST_IsObjective_1");
			int iNPCObjective = GetLocalInt(oItem, "LEG_QUEST_ObjectiveFor_1");

			// Am I the quest starter?
			int iQuestStarter = GetLocalInt(oItem, "LEG_QUEST_Starter_1");
					
			// Is the player on the quest and are they on this step?
			int iPlayerNPC = GetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC");				
			int iPlayerOBJCount = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ" + IntToString(iObjective));
			if (iPlayerNPC == iNPCObjective)
			{
				int iNeeds = GetLocalInt(oItem, "LEG_QUEST_PCNeeds_1");;
				int iPCHas = iPlayerOBJCount;
				if (iNeeds > iPCHas)
				{
					// Looks like the PC needs me.
					iPCHas++;
				
					// Looks like the PC needs me.
					//int iAdvanceNPC = GetLocalInt(oItem, "LEG_QUEST_NPCAdvance_1");
					
					// Display some informtation that the PC obtained this item.
					LEG_COMMON_DisplayInfoBox(oPC, "Found " + GetName(oItem) + " (" + IntToString(iPCHas) + "/" + IntToString(iNeeds) + ")");
					
					// Save the fact that the PC obtained the item
					SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ" + IntToString(iObjective), iPCHas);
					string sTableID = LEG_COMMON_GetPCTable(oPC, "quests");
					SetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ" + IntToString(iObjective), iPCHas, 0, sTableID);
					
					// Play a pretty sound
					PlaySound("gui_journaladd");
					
					// If using the Quest Icon configuration, refresh anyone that's nearby that may need to be.
					if (LEG_QUEST_ICONS)
					{
						object oIcon;
						object oNextNPC = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oPC), FALSE, OBJECT_TYPE_CREATURE);
						while (GetIsObjectValid(oNextNPC))
						{
							oIcon = GetLocalObject(oNextNPC, "MyIcon");
							LEG_QUEST_RefreshQuestIcon(oNextNPC, oIcon, oPC);				
							oNextNPC = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oPC), FALSE, OBJECT_TYPE_CREATURE);			
						}	
					}
					
					// Notify the party that this member has looted something
					object oLeader = GetFactionLeader(oPC);
					object oMember = GetFirstFactionMember(oLeader, TRUE);
				    while(oMember != OBJECT_INVALID)
				    {
						if (oMember != oPC)		
							SendMessageToPC(oMember, GetName(oPC) + " has aquired a " + GetName(oItem));
						oMember = GetNextFactionMember(oLeader, TRUE);
					}
				}			
			}						
			else if (iPlayerNPC == 0 && iQuestStarter)
			{
				// So the PC isn't on this quest for that item.  Let's see if by merely obtaining this item,
				// we are offered a quest.
				// Find out if there is a previous requirement before an offer can take place.
				string sRequirement = GetLocalString(oItem, "LEG_QUEST_Requirement_1");
				string sQuestStarted = GetLocalString(oItem, "LEG_QUEST_QuestStarted_1");
				int iAdvanceOBJ = GetLocalInt(oItem, "LEG_QUEST_ObjectiveAdvance_1");
			
				// If the PC is on step 0 - hasn't started and this item is a quest starter, then
				// start the quest.  (Commonly used for collections)
				if ((GetLocalInt(oPC, "QuestID_" + sRequirement + "_NPC") == 999 || sRequirement == "") && (GetLocalInt(oPC, "QuestID_" + sQuestStarted + "_NPC") != 0 || sQuestStarted == ""))
				{
					LEG_QUEST_FireQuestGUI("leg_quest_offer", "leg_quest_offer.xml", oPC, 1, sQuestID, 0, iAdvanceOBJ);
					string sTableID = LEG_COMMON_GetPCTable(oPC, "quests");
					SetPersistentInt(oPC, "QuestID_" + sQuestID + "_1_ReluctantPassed", 1, 0, sTableID);
					SetLocalInt(oPC, "QuestID_" + sQuestID + "_1_ReluctantPassed", 1);
				}
			}
		}
	}
}
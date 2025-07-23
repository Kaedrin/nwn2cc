/*

    Script:			This script is called on Quest Triggers usually associated with the Explore a Place
					type objective.
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
	// Get the PC that's entering me.. Oh that sounds dirty hehe.
	object oPC = GetEnteringObject();
	string sTriggerName = GetName(OBJECT_SELF);

	// If the Quest plugin isn't active, just exit.
	if (!GetLocalInt(GetModule(), "LEG_QUEST_ACTIVE"))
		return;
				
	if (GetIsPC(oPC))
	{
		// Looks a PC just hit me.  Better check for quests.
		int iTotalQuests = GetLocalInt(OBJECT_SELF, "LEG_QUEST_TotalQuests");
		int iCount, iNeeds, iPCHas;
		string sQuestID, sQuestCounter;
		string sTableID = LEG_COMMON_GetPCTable(oPC, "quests");
	
		// Start cycling through the quests this trigger offers.
		for (iCount = 1; iCount <= iTotalQuests; iCount++)
		{
			SetLocalObject(oPC, "QNPC", OBJECT_SELF);
			sQuestCounter = IntToString(iCount);
			sQuestID = GetLocalString(OBJECT_SELF, "LEG_QUEST_QuestID_" + sQuestCounter);
			int iObjective = GetLocalInt(OBJECT_SELF, "LEG_QUEST_IsObjective_" + sQuestCounter);
			int iNPCObjective = GetLocalInt(OBJECT_SELF, "LEG_QUEST_ObjectiveFor_" + sQuestCounter);
			int iAdvanceNPC = GetLocalInt(OBJECT_SELF, "LEG_QUEST_NPCAdvance_" + sQuestCounter);			
		
			// Is the player on the quest and are they on this step?
			int iPlayerNPC = GetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC");				
			int iPlayerOBJCount = GetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ" + IntToString(iObjective));
			if (iPlayerNPC == iNPCObjective)
			{
				// Is my Objective Owner reluctant and has the PC gotten passed that little issue?
				//int iReluctance = GetLocalInt(OBJECT_SELF, "LEG_QUEST_Reluctant_" + IntToString(iObjective));
				int iReluctantPassed = GetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iNPCObjective) + "_ReluctantPassed");
				
				if (iReluctantPassed == 0)
					return;
			
				// So what are we doing today?  Some exploring?  Ok.  If the PC needs to explore this
				// trigger, lets check and do what we have to do.
				if (GetLocalString(OBJECT_SELF, "LEG_QUEST_Action_" + sQuestCounter) == "Explore")
				{
					// See how many of me the PC needs.  Usually 1.
					iNeeds = GetLocalInt(OBJECT_SELF, "LEG_QUEST_PCNeeds_" + sQuestCounter);
					if (iNeeds == 0)
						iNeeds = 1;
					iPCHas = iPlayerOBJCount;
					if (iNeeds > iPCHas)
					{
						// Now the PC has one more than they had before!
						iPCHas++;
						
						// Looks like the PC needs me.  Let's display some information.  For Quest Type 1 which
						// is Lore Book type quests, we don't put the word "Discovered" in front.  But for other
						// type quests we do.  Meh, design decision, maybe we'll change this some day.  The TEXT
						// we use for the discovery comes from the NAME field of the tigger.
						string sTriggerText;
						int iQuestType = GetLocalInt(oPC, "QuestID_" + sQuestID + "_Type");
						int iForceNameOnly = GetLocalInt(OBJECT_SELF, "LEG_QUEST_ForceName_" + sQuestCounter);
						if (iQuestType == 1 || iForceNameOnly)
							sTriggerText = sTriggerName;
						else
							sTriggerText = "Discovered " + sTriggerName + ".";
							
						// Perform the display.
						LEG_COMMON_DisplayInfoBox(oPC, sTriggerText);
						
						// Save and give credit.
						SetLocalInt(oPC, "QuestID_" + sQuestID + "_OBJ" + IntToString(iObjective), 1);
						SetPersistentInt(oPC, "QuestID_" + sQuestID + "_OBJ" + IntToString(iObjective), 1, 0, sTableID);
						
						// Play a pretty sound.
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

						// We need to check and see if this is a Lorebook Quest and if this Looted Item
						// will advance it and pop-up the GUI
						if (iQuestType == 1 && iPCHas >= iNeeds)
						{
							// This is a lore book and we have completed a Kill objective
							// Pop up the continue GUI if there is another NPC to be had.
							// Otherwise pop up the finish GUI
							int iQuestFinisher = GetLocalInt(OBJECT_SELF, "LEG_QUEST_Finisher_" + sQuestCounter);
							iCount = iTotalQuests;
							if (iQuestFinisher)
							{
								LEG_QUEST_FireQuestGUI("leg_quest_finish", "leg_quest_finish.xml", oPC, iPlayerNPC, sQuestID);
							}
							else
							{
								LEG_QUEST_FireQuestGUI("leg_quest_continue", "leg_quest_continue.xml", oPC, iAdvanceNPC, sQuestID, iAdvanceNPC);
								SetPersistentInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iAdvanceNPC) + "_ReluctantPassed", 1, 0, sTableID);
								SetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iAdvanceNPC) + "_ReluctantPassed", 1);
							}
						}
					}
				}
			}
		}
	}
}
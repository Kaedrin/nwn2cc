/*

    Script:			This script is called when a creature that is assigned a deed needs to be checked 
					against the player quest objectives.  If the PC has the quest or needs it, the 
					deed is advanced or offered or finished.
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
void main(object oPC, object oTarget)
{
	// The oTarget is the target or holder of the deed.  This could be a
	// mob, placeable or pretty much anything.  Importantly, it is the thing
	// that has the deed variables on it.  So lets check for that first.
	int iTotalDeeds = GetLocalInt(oTarget, "LEG_QUEST_TotalQuests");
	if (iTotalDeeds)
	{
		// Looks like this guy is part of one or more deeds.
		int iDeedCount;
		for (iDeedCount = 1; iDeedCount <= iTotalDeeds; iDeedCount++)
		{
			// For each deed this guys has, lets do something.
			string sDeedCount = IntToString(iDeedCount);
			string sDeedID = GetLocalString(oTarget, "LEG_QUEST_QuestID_" + sDeedCount);
			int iDeedQty = GetLocalInt(oTarget, "LEG_QUEST_DeedQty_" + sDeedCount);

			// Don't do anything if this isn't a deed.			
			if (iDeedQty > 0)
			{
				// Now get the player's info
				string sTableID = LEG_COMMON_GetPCTable(oPC, "quests");
				int iPlayerStep = GetLocalInt(oPC, "QuestID_" + sDeedID + "_NPC");
				
				// Deed NPC is always 1.
				int iNPCPosition = 1;
			
				// See if the PC is on or needs to start this quest
				if (iPlayerStep < iNPCPosition)
				{
					// Player needs the offer gui
					LEG_QUEST_FireQuestGUI("leg_quest_offer", "leg_quest_offer.xml", oPC, 1, sDeedID, 0, 1);
					string sTableID = LEG_COMMON_GetPCTable(oPC, "quests");
					SetPersistentInt(oPC, "QuestID_" + sDeedID + "_1_ReluctantPassed", 1, 0, sTableID);
					SetLocalInt(oPC, "QuestID_" + sDeedID + "_1_ReluctantPassed", 1);
				}
				else if (iPlayerStep == iNPCPosition)
				{
					// PC is already on the quest, let's see how many qty they have
					int iPCHas = GetLocalInt(oPC, "QuestID_" + sDeedID + "_OBJ1");
				
					// Add one more and lets see if they are done.
					iPCHas++;
					if (iPCHas >= iDeedQty)
					{
						// All done, fire the Finish GUI
						LEG_QUEST_FireQuestGUI("leg_quest_finish", "leg_quest_finish.xml", oPC, 1, sDeedID);
					}
					else
					{
						// Not done yet, store the fact they just added one though.
						LEG_QUEST_ObjectiveCredit(sDeedID, oPC, "Deed Advanced (" + IntToString(iPCHas) + "/" + IntToString(iDeedQty) + ")", "", iPCHas, iDeedQty, 1, "");
					}
				}
			}
		}
	}
}
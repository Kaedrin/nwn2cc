/*

    Script:			The crappy ass script we had to write because of the bug in the engine that item variables and not stored 
					consistently when purchased from stores or similar means.
	Version:		1.01
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		N/A
	
	Change Log:		06/23/2011 - 1.00 MV - Initial Release
	
*/


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// DEFINITIONS
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void LEG_QUEST_ITEMACQUIRED_Defs(string sItemRef, object oItem)
{
	if (sItemRef != "")
	{
		
		// BEGIN ITEM DEFINITIONS
		if (sItemRef == "frostyale")
		{
			SetLocalInt(oItem, "LEG_QUEST_TotalQuests", 1);
			SetLocalString(oItem, "LEG_QUEST_QuestID_1", "1081");
			SetLocalInt(oItem, "LEG_QUEST_IsObjective_1", 1);
			SetLocalInt(oItem, "LEG_QUEST_ObjectiveFor_1", 1);
			SetLocalInt(oItem, "LEG_QUEST_PCNeeds_1", 1);
		}
/*		else if (sItemRef == "diamondneedle")
		{
			SetLocalInt(oItem, "LEG_QUEST_TotalQuests", 1);
			SetLocalString(oItem, "LEG_QUEST_QuestID_1", "1080");
			SetLocalInt(oItem, "LEG_QUEST_IsObjective_1", 3);
			SetLocalInt(oItem, "LEG_QUEST_ObjectiveFor_1", 1);
			SetLocalInt(oItem, "LEG_QUEST_PCNeeds_1", 1);
		}*/
		else if (sItemRef == "dwarvenlager")
		{
			SetLocalInt(oItem, "LEG_QUEST_TotalQuests", 1);
			SetLocalString(oItem, "LEG_QUEST_QuestID_1", "1092");
			SetLocalInt(oItem, "LEG_QUEST_IsObjective_1", 1);
			SetLocalInt(oItem, "LEG_QUEST_ObjectiveFor_1", 1);
			SetLocalInt(oItem, "LEG_QUEST_PCNeeds_1", 1);
		}
		else if (sItemRef == "caskofmerlot")
		{
			SetLocalInt(oItem, "LEG_QUEST_TotalQuests", 1);
			SetLocalString(oItem, "LEG_QUEST_QuestID_1", "1092");
			SetLocalInt(oItem, "LEG_QUEST_IsObjective_1", 2);
			SetLocalInt(oItem, "LEG_QUEST_ObjectiveFor_1", 1);
			SetLocalInt(oItem, "LEG_QUEST_PCNeeds_1", 1);
		}
		else if (sItemRef == "bottleofmoonshine")
		{
			SetLocalInt(oItem, "LEG_QUEST_TotalQuests", 1);
			SetLocalString(oItem, "LEG_QUEST_QuestID_1", "1092");
			SetLocalInt(oItem, "LEG_QUEST_IsObjective_1", 3);
			SetLocalInt(oItem, "LEG_QUEST_ObjectiveFor_1", 1);
			SetLocalInt(oItem, "LEG_QUEST_PCNeeds_1", 1);
		}				
		else if (sItemRef == "baroftruesilver")
		{
			SetLocalInt(oItem, "LEG_QUEST_TotalQuests", 1);
			SetLocalString(oItem, "LEG_QUEST_QuestID_1", "1117");
			SetLocalInt(oItem, "LEG_QUEST_IsObjective_1", 1);
			SetLocalInt(oItem, "LEG_QUEST_ObjectiveFor_1", 1);
			SetLocalInt(oItem, "LEG_QUEST_PCNeeds_1", 1);
		}		
	}
}
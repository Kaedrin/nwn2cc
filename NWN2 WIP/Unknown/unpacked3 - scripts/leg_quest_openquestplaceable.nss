/*

    Script:			Called by the onused event of quest placeables to start the quest convo.  In this sense 
					a placeable can act just like any NPC.
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
	// Who just touched me.
	object oPC = GetPlaceableLastClickedBy();
	string sName = GetName(OBJECT_SELF);
	
	// If we're a PC...
	if (GetIsPC(oPC))
	{
		// Looks a PC just touched me.  Better check for range and quests.
		if (GetDistanceToObject(oPC) > 3.0)
		{
			LEG_COMMON_DisplayInfoBox(oPC, "You are too far away.", 0);
			AssignCommand(oPC, ClearAllActions());
			return;
		}
		
		// Store the PC that last touched me and fire up my conversation, presumably the quest convo.
		SetLocalObject(OBJECT_SELF, "LASTPC", oPC);
		ActionStartConversation(oPC);
	}
}
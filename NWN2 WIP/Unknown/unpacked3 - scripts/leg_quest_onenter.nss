/*

    Script:			As a player enters an area, we need to double check any Quest Based spawn encounters are labelled 
					active.  Sometimes, a server reset may deactivate a spawn encounter that was previously active 
					due to a Quest Acceptance.  We run this as players enter to re-enable these types of spawn encounters.
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
	// If the PC has entered an area with a special spawn, then check to see if its active.  If it is not,
	// then activate it.  This will persist across reboots etc.  Go through each WP in the area and see if the PC
	// needs it
	object oPC = OBJECT_SELF;
	object oSpawnPoint = GetFirstObjectInArea();
	while (GetIsObjectValid(oSpawnPoint))
	{
		if (GetLocalInt(oSpawnPoint, "LEG_SPAWN_QuestBased") && GetObjectType(oSpawnPoint) == OBJECT_TYPE_WAYPOINT)
		{
			string sWPTag = GetTag(oSpawnPoint);
			if(GetPersistentInt(oPC, sWPTag, QUESTPREFIX + "_questspawns"))
			{
				// Yep, PC needs this active so turn off the Trigger requirement.
				SetLocalInt(oSpawnPoint, "LEG_SPAWN_TriggerSpawn", 0);
				SetLocalInt(oPC, sWPTag, 1);
			}
		}
		
		// Move on to the next waypoint.
		oSpawnPoint = GetNextObjectInArea();
	}
}
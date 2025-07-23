/*
	nar_onenter
	
	Called when a client enters an area.
	
	Resets all containers, encounters, traps, etc. if the area
	has been empty of players for a period of time.
	
	Most specifically:
	 - all doors will be closed
	 - all doors with int bLockable = true will be closed and locked
	 - all objects with tag "nar_container" will have bTriggered = FALSE
	 - all objects with tag "nar_container_locked" will be like above, but
	   locked
	 - all encounters with tag "nar_encounter" will become active
	
	18/01/2011 - Narks 
*/

#include "hcr2_timers_i"

// How many heartbeats (6 seconds) where the area is empty of players
// have to pass until an area is reset.
const int nResetPeriod = 100;

void main()
{
	// Reset the area the first time the area is ever entered.
	if (GetLocalInt(OBJECT_SELF, "nar_bFirstReset") == FALSE)
	{
		SetLocalInt(OBJECT_SELF, "nar_bFirstReset", TRUE);
		// yes, this is hacky, no, I don't care
		SetLocalInt(OBJECT_SELF, "nar_nResetTick", nResetPeriod);
	}

	int nPlayerCount = GetLocalInt(OBJECT_SELF, "nar_nPlayerCount");
	
	// Does the area need to be reset?
	if ((nPlayerCount == 0) && (GetLocalInt(OBJECT_SELF, "nar_nResetTick") >= nResetPeriod))
	{
		SetLocalInt(OBJECT_SELF, "nar_nResetTick", 0);
		
		// Reset the area cleared flag, and remove all stored creatures.
		SetLocalInt(OBJECT_SELF, "nar_bCleared", FALSE);
		int nCount = 0;
		while (TRUE)
		{
			string sKey = "nar_ClearedMonster" + IntToString(nCount) + "ResRef";
			string sResRef = GetLocalString(OBJECT_SELF, sKey);
			if (sResRef == "")
				break;
			
			// Only need to clear the ResRef.
			SetLocalString(OBJECT_SELF, sKey, "");
			nCount++;
		}
		
		object oObject = GetFirstObjectInArea(OBJECT_SELF);
		while (GetIsObjectValid(oObject))
		{
			string sTag = GetTag(oObject);
			
			// Close all doors in the area.
			if (GetObjectType(oObject) == OBJECT_TYPE_DOOR)
			{
				AssignCommand(oObject, ActionCloseDoor(oObject));
				
				// Lock lockable doors.
				if (GetLocalInt(oObject, "bLockable") == TRUE)
					AssignCommand(oObject, ActionDoCommand(SetLocked(oObject, TRUE)));
			}
			
			// Reset all containers in the area.
			if (sTag == "nar_container")
			{
				SetLocalInt(oObject, "bTriggered", FALSE);
			}
			if (sTag == "nar_container_locked")
			{
				SetLocalInt(oObject, "bTriggered", FALSE);
				SetLocked(oObject, TRUE);
			}
			
			// Reset all encounters.
			if (sTag == "nar_encounter")
			{
				SetEncounterActive(TRUE, oObject);
			}
			
			oObject = GetNextObjectInArea(OBJECT_SELF);
		}
	}
	// No reset needed - has the area been cleared?
	else if ((nPlayerCount == 0) && GetLocalInt(OBJECT_SELF, "nar_bCleared") == TRUE)
	{
		// Respawn all monsters.
		SetLocalInt(OBJECT_SELF, "nar_bCleared", FALSE);
		
		// Monsters are stored in this format:
		// ResRef: nar_ClearedMonster#ResRef
		// Location: nar_ClearedMonster#Location
		int nCount = 0;
		while (TRUE)
		{
			string sKey = "nar_ClearedMonster" + IntToString(nCount);
			string sResRef = GetLocalString(OBJECT_SELF, sKey + "ResRef");
			if (sResRef == "")
				break;
			
			// Just in case this handyman crap is on the server
			if (sResRef != "bb_handyman")
			{
				location lLocation = GetLocalLocation(OBJECT_SELF, sKey + "Location");
				CreateObject(OBJECT_TYPE_CREATURE, sResRef, lLocation);
			}
			nCount++;
		}
	}
	
	SetLocalInt(OBJECT_SELF, "nar_nPlayerCount", nPlayerCount + 1);
}
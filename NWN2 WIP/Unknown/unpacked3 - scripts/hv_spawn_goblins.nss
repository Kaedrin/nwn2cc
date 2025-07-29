// Declare functions

// Get PC's party size
int GetPartySize(object oPC);

// Get random type of goblin to spawn
string GetGoblinTag();

// Get nearest distance between waypoint and party
float GetClosestPartyMember(object oPC, object oWP);

// Place on selected kobold's user events to spawn more kobolds
// according to party size
void main()
{	
	// Get PC
	object oPC = GetLastPerceived();
	if (GetIsPC(oPC)) {
	
		// Make sure we didn't already spawn
		GetLocalInt(OBJECT_SELF, "spawned");
		if (GetLocalInt(OBJECT_SELF, "spawned") == 0) {
				
  			// Get spawn WP location
			object oWP = GetNearestObjectByTag("hv_goblin_spawn_wp");	
		
			// If min distance between wp and party is smaller
			// than 12.0, don't spawn.
			if (GetClosestPartyMember(oPC, oWP) < 12.0)
				return;
			
			// Get PC's party size
			int nPartySize = GetPartySize(oPC);
			
			// Limit to 5 spawns
			if (nPartySize > 5)
				nPartySize = 5;
			
			// Spawn goblins according to party size
			int i;
			for (i = 0; i < nPartySize ; i++) {
					
				// Get random goblin
				string sGoblinTag = GetGoblinTag();
					
				if (sGoblinTag != "" ) {
				
					// Spawn it
					CreateObject(OBJECT_TYPE_CREATURE, sGoblinTag, GetLocation(oWP));
				}
			}
				
			// Update localint so it won't spawn any more
			SetLocalInt(OBJECT_SELF, "spawned", 1);
				
			// Say something...
			if (Random(2) == 0)
				SpeakString("Odnut'n!");
			else
				SpeakString("Kunvu'n!");
		}
	}
}


// Get PC's party size
// 3/12/2011 - only count pary members who are 10 meters or less from PC
int GetPartySize(object oPC) {

	int nPartySize = 0;
	
	// Get the first PC party member
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
    // We stop when there are no more valid PC's in the party.
    while(GetIsObjectValid(oPartyMember) == TRUE) {
					
		// Increment size by one.
		if (GetDistanceBetween(oPC, oPartyMember) <= 10.0)
        nPartySize++;
					
        // Get the next PC member of oPC's faction.
        oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
	
	return nPartySize;
}

// Get random goblin tag
string GetGoblinTag() {
	
	string sGoblinTag = "";	

	// Generate random number
	// (Edited to decrease chances for mages, and added blank option.)
	int nRand = Random(3) + 1;
	
	// Return tag based on result
	switch (nRand) {
		case 1 : 
			sGoblinTag = "hv_goblin_archer";
			break;
		
		case 2 :
			sGoblinTag = "hv_goblin_lesser_shaman";
			break;
			
		case 3 :
			sGoblinTag = "hv_goblin_scout_b";
			break;
		
		default:
			sGoblinTag = "hv_goblin_scout_b";
			break;													
	}
	
	return sGoblinTag;
}

// Get nearest distance between waypoint and party
float GetClosestPartyMember(object oPC, object oWP)
{
	float fMinDistance = 20.0;

	// Get the first PC party member
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
	
    // We stop when there are no more valid PC's in the party.
    while(GetIsObjectValid(oPartyMember) == TRUE) {
					
		// Get distance
		if (GetDistanceBetween(oPartyMember, oWP) < fMinDistance)
			fMinDistance = GetDistanceBetween(oPartyMember, oWP);
					
        // Get the next PC member of oPC's faction.
        oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
	
	//SendMessageToPC(oPC, "Min Distance: " + FloatToString(fMinDistance));
	return fMinDistance;
}
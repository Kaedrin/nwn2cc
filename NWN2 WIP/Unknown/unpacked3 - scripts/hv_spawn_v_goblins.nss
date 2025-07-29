// Declare functions

// Get random type of lesser goblin to spawn
string GetLesserGoblinTag();

// Get more powerful goblin tag
string GetGoblinTag();

// Get nearest distance between waypoint and party
float GetClosestPartyMember(object oPC, object oWP);

// Get total party level
int GetPartyLevel(object oPC);

// Get number of spawns to create, based on party level
int GetSpawnNumber(int nPartyLevel, int nMaxSpawns, int nSpawnsDifficulty);

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
			object oWP = GetNearestObjectByTag("hv_goblin_v_spawn_wp");	
		
			// If min distance between wp and party is smaller
			// than 12.0, don't spawn.
			if (GetClosestPartyMember(oPC, oWP) < 12.0)
				return;
			
			// Get PC's party size and level
			int nPartySize = 0;
			int nPartyLevel = 0;
			
    		object oPartyMember = GetFirstFactionMember(oPC, TRUE);

    		while(GetIsObjectValid(oPartyMember) == TRUE) {
					
				// Increment size by one.
				if (GetDistanceBetween(oPC, oPartyMember) <= 10.0)
	        		nPartySize++;
					
				// Add to party level
				nPartyLevel += GetHitDice(oPC);
					
	        	// Get the next PC member of oPC's faction.
        		oPartyMember = GetNextFactionMember(oPC, TRUE);
    		}
			
			// Spawn "strong" goblins based on party level
			int nSpawnNum = GetSpawnNumber(nPartyLevel, 5, 6);
			
			int i = 0;
			for (i = 1; i < nSpawnNum ; i++) {
					
				// Get random goblin
				string sGoblinTag = GetGoblinTag();
					
				if (sGoblinTag != "" ) {
				
					// Spawn it
					CreateObject(OBJECT_TYPE_CREATURE, sGoblinTag, GetLocation(oWP));
				}
			}
			
			// The rest of the gobos will be lesser ones
			if (nSpawnNum > 0) {
				nSpawnNum = nPartySize - nSpawnNum;
				for (i = 0; i < nSpawnNum ; i++) {
					
					// Get random goblin
					string sGoblinTag = GetLesserGoblinTag();
					
					if (sGoblinTag != "" ) {
				
						// Spawn it
						CreateObject(OBJECT_TYPE_CREATURE, sGoblinTag, GetLocation(oWP));
					}
				}
			}
				
			// Update localint so it won't spawn any more
			SetLocalInt(OBJECT_SELF, "spawned", 1);
				
			// Say something...
			SpeakString("Breee!");
		}
	}
}

// Get random goblin tag
string GetLesserGoblinTag() {
	
	string sGoblinTag = "";	

	// Generate random number
	// (Edited to decrease chances for mages, and added blank option.)
	int nRand = Random(4) + 1;
	
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
			
		case 4 : 
			sGoblinTag = "hv_goblin_archer";
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

// Get random goblin tag
string GetGoblinTag() {
	
	string sGoblinTag = "";	

	// Generate random number
	// (Edited to decrease chances for mages, and added blank option.)
	int nRand = Random(3) + 1;
	
	// Return tag based on result
	switch (nRand) {
		case 1 : 
			sGoblinTag = "hv_goblingreen_b";
			break;
		
		case 2 :
			sGoblinTag = "hv_goblingreen_a";
			break;
			
		case 3 :
			sGoblinTag = "hv_goblingreen_s";
			break;
		
		default:
			sGoblinTag = "hv_goblingreen_b";
			break;													
	}
	
	return sGoblinTag;
}

// Get total party level
int GetPartyLevel(object oPC)
{
	int nPartyLevel = 0;
	
	// Get the first PC party member
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
	
    // We stop when there are no more valid PC's in the party.
    while(GetIsObjectValid(oPartyMember) == TRUE) {
					
		// Get level
		nPartyLevel += GetHitDice(oPartyMember);
					
        // Get the next PC member of oPC's faction.
        oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
	
	return nPartyLevel;
}

// Get number of spawns to create, based on party level
int GetSpawnNumber(int nPartyLevel, int nMaxSpawns, int nSpawnsDifficulty)
{
	int nSpawns = 0;
	
	int nCounter = 0;
	while ((nCounter < nMaxSpawns) && (nPartyLevel >= nSpawnsDifficulty)) {
	
		nCounter++;
		nPartyLevel = nPartyLevel - nSpawnsDifficulty;
	}
	
	return nCounter;
}
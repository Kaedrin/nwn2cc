// Declare functions

// Get random type of lesser goblin to spawn
string GetLesserAntTag();

// Get more powerful goblin tag
string GetAntTag();

// Get nearest distance between waypoint and party
float GetClosestPartyMember(object oPC, object oWP);

// Get total party level
int GetPartyLevel(object oPC);

// Get number of spawns to create, based on party level
int GetSpawnNumber(int nPartyLevel, int nMaxSpawns, int nSpawnsDifficulty);

// Will be called via ant on perception
void main()
{	
	// Get PC
	object oPC = GetLastPerceived();
	if (GetIsPC(oPC)) {
	
		// Make sure we didn't already spawn
		GetLocalInt(OBJECT_SELF, "spawned");
		if (GetLocalInt(OBJECT_SELF, "spawned") == 0) {
				
  			// Get spawn WP location
			object oWP = GetNearestObjectByTag("hv_ant_spawn_wp");	
		
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
				if (GetDistanceBetween(oPC, oPartyMember) <= 15.0)
	        		nPartySize++;
					
				// Add to party level
				nPartyLevel += GetHitDice(oPC);
					
	        	// Get the next PC member of oPC's faction.
        		oPartyMember = GetNextFactionMember(oPC, TRUE);
    		}
			
			// Spawn "strong" ants based on party level
			int nSpawnNum = GetSpawnNumber(nPartyLevel, 5, 12);
			
			int i = 0;
			for (i = 1; i < nSpawnNum ; i++) {
					
				// Get random ant
				string sAntTag = GetAntTag();
					
				if (sAntTag != "" ) {
				
					// Spawn it
					CreateObject(OBJECT_TYPE_CREATURE, sAntTag, GetLocation(oWP));
				}
			}
			
			// The rest of the ants will be lesser ones
			if (nSpawnNum > 0) {
				nSpawnNum = nPartySize - nSpawnNum;
				for (i = 0; i < nSpawnNum ; i++) {
					
					// Get random ant
					string sLesserAntTag = GetLesserAntTag();
					
					if (sLesserAntTag != "" ) {
				
						// Spawn it
						CreateObject(OBJECT_TYPE_CREATURE, sLesserAntTag, GetLocation(oWP));
					}
				}
			}
				
			// Update localint so it won't spawn any more
			SetLocalInt(OBJECT_SELF, "spawned", 1);
		}
	}
}

// Get random ant tag
string GetLesserAntTag() {
	
	return "hv_rotten_root";
	string sAntTag = "";	

	// Generate random number
	// (Edited to decrease chances for mages, and added blank option.)
	int nRand = Random(4) + 1;
	
	// Return tag based on result
	switch (nRand) {
		case 1 : 
			sAntTag = "hv_goblin_archer";
			break;
		
		case 2 :
			sAntTag = "hv_goblin_lesser_shaman";
			break;
			
		case 3 :
			sAntTag = "hv_goblin_scout_b";
			break;
			
		case 4 : 
			sAntTag = "hv_goblin_archer";
			break;
		
		default:
			sAntTag = "hv_goblin_scout_b";
			break;													
	}
	
	return sAntTag;
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
string GetAntTag() {
	
	return "dex_antfire";
	string sAntTag = "";	

	// Generate random number
	int nRand = Random(3) + 1;
	
	// Return tag based on result
	switch (nRand) {
		case 1 : 
			sAntTag = "hv_goblingreen_b";
			break;
		
		case 2 :
			sAntTag = "hv_goblingreen_a";
			break;
			
		case 3 :
			sAntTag = "hv_goblingreen_s";
			break;
		
		default:
			sAntTag = "hv_goblingreen_b";
			break;													
	}
	
	return sAntTag;
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
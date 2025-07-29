// Declare functions

// Get PC's party size
int GetPartySize(object oPC);

// Get random type of bandit to spawn
string GetBanditTag();

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
			object oWP = GetNearestObjectByTag("hv_bandits_spawn_wp");	
		
			// If min distance between wp and party is smaller
			// than 12.0, don't spawn.
			if (GetClosestPartyMember(oPC, oWP) < 12.0)
				return;
			
			// Get PC's party size
			int nPartySize = GetPartySize(oPC);
			
			// Limit to 3 spawns
			if (nPartySize > 3)
				nPartySize = 3;
			
			// Spawn bandits according to party size
			int i;
			for (i = 1; i <= nPartySize ; i++) {
				
				// Get random bandit
				string sBanditTag = GetBanditTag();
					
				if (sBanditTag != "" ) {
				
					// Spawn it
					CreateObject(OBJECT_TYPE_CREATURE, sBanditTag, GetLocation(oWP));
				}
			}
				
			// Update localint so it won't spawn any more
			SetLocalInt(OBJECT_SELF, "spawned", 1);
				
			// Say something...
			if (Random(2) == 0)
				SpeakString("Infiltrators! Get them!");
			else
				SpeakString("Intruder!");
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

// Get random bandit tag
string GetBanditTag() {
	
	string sBanditTag = "";	

	// Generate random number
	// (Edited to decrease chances for mages, and added blank option.)
	int nRand = Random(11);
	
	// Return tag based on result
	switch (nRand) {
	
		case 0 : 
			sBanditTag = "hv_bandits_dog";
			break;
			
		case 1 : 
			sBanditTag = "hv_bandits_w_2";
			break;
		
		case 2 :
			sBanditTag = "hv_bandits_r_1";
			break;
			
		case 3 :
			sBanditTag = "hv_bandits_dog";
			break;
			
		case 4 :
			sBanditTag = "hv_bandits_w_2";
			break;
		
		case 5 :
			sBanditTag = "hv_bandits_r_1";
			break;
			
		case 6 :
			sBanditTag = "hv_bandits_dog";
			break;
			
		case 7 :
			sBanditTag = "hv_bandits_s_1";
			break;
			
		case 8 :
			sBanditTag = "hv_bandits_c_1";
			break;
			
		case 9 :
			sBanditTag = "hv_bandits_a_1";
			break;
			
		case 10 :
			sBanditTag = "hv_bandits_a_1";
			break;
		
		default:
			sBanditTag = "hv_bandits_w_2";
			break;													
	}
	
	return sBanditTag;
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
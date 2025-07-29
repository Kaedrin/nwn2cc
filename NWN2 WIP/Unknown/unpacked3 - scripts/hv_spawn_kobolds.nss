// Declare functions

// Get PC's party size
int GetPartySize(object oPC);

// Get random type of kobold to spawn
string GetKoboldTag();

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
				
			// Get PC's party size
			int nPartySize = GetPartySize(oPC);
				
			// Spawn kobolds according to party size
			int i;
			for (i = 0; i < nPartySize ; i++) {
					
				// Get random kobold
				string sKoboldTag = GetKoboldTag();
					
				if (sKoboldTag != "" ) {
					// Get spawn WP location
					object oWP = GetNearestObjectByTag("hv_kobold_spawn_wp");
						
					// Spawn it
					CreateObject(OBJECT_TYPE_CREATURE, sKoboldTag, GetLocation(oWP));
				}
			}
				
			// Update localint so it won't spawn any more
			SetLocalInt(OBJECT_SELF, "spawned", 1);
				
			// Say something...
			SpeakString("Yrip!");
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

// Get random kobold tag
string GetKoboldTag() {
	
	string sKoboldTag = "";	

	// Generate random number
	// (Edited to decrease chances for mages, and added blank option.)
	int nRand = Random(12) + 1;
	
	// Return tag based on result
	switch (nRand) {
		case 1 : 
			sKoboldTag = "hv_kobold_warrior_b";
			break;
		
		case 2 :
			sKoboldTag = "hv_kobold_archer_b";
			break;
			
		case 3 :
			sKoboldTag = "hv_kobold_warrior_b";
			break;
			
		case 4 :
			sKoboldTag = "hv_kobold_archer_b";
			break;
			
		case 5 :
			sKoboldTag = "hv_kobold_warrior_b";
			break;
			
		case 6 :
			sKoboldTag = "hv_kobold_archer_b";
			break;
			
		case 7 :
			sKoboldTag = "hv_kobold_mage_b";
			break;
			
		case 8 :
			sKoboldTag = "hv_kobold_shaman_b";
			break;
			
		case 9 :
			sKoboldTag = "hv_kobold_shaman_b";
			break;
			
		case 10 :
			sKoboldTag = "";
			break;
			
		case 11 :
			sKoboldTag = "";
			break;
			
		case 12 :
			sKoboldTag = "";
			break;													
	}
	
	return sKoboldTag;
}
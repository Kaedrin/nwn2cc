// Every 3 heartbeats (18 seconds) run script that
// will create the glowing orb.
void CreateGlowingOrb()
{
	// Check if boss is hostile yet
	if (GetLocalInt(OBJECT_SELF, "hv_create_orbs") == 1) {
		
		// Progress or reset orb counter
		int nOrbCounter = GetLocalInt(OBJECT_SELF, "hv_orb_counter");
		nOrbCounter++;
		if (nOrbCounter == 3) {
			ExecuteScript("hv_create_temple_orb", OBJECT_SELF);
			nOrbCounter = 0; // reset it
		}
		SetLocalInt(OBJECT_SELF, "hv_orb_counter", nOrbCounter);
	}
}

// Set variable to create ritual 20 minutes after
// last PC left the area.
void ResetRitual()
{
	// if it is already marked for reset, do nothing
	if (GetLocalInt(OBJECT_SELF, "hv_create_all") == 1)
		return;

	// if there are PCs, do nothing
	if (GetLocalInt(OBJECT_SELF, "hv_pc_count") > 0)
		return;
		
	// if we got to 200 (20 minutes), mark for creation
	// and reset counter
	int nResetCounter = GetLocalInt(OBJECT_SELF, "hv_reset_counter");
	if (nResetCounter == 200) {
		SetLocalInt(OBJECT_SELF, "hv_create_all", 1);
		SetLocalInt(OBJECT_SELF, "hv_reset_counter", 0);
	}
	else {
		SetLocalInt(OBJECT_SELF, "hv_reset_counter", nResetCounter + 1);
	}
}

void main()
{
	CreateGlowingOrb();
	// ResetRitual(); // <-- uncomment this to bring back the 
	                  // reset every 20 minutes.
}
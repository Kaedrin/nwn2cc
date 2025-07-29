// Increase PC count by 1.
// Create ritual scene if needed.
void main()
{
	// Reset reset counter
	SetLocalInt(OBJECT_SELF, "hv_reset_counter", 0);

	int nPCCount = GetLocalInt(OBJECT_SELF, "hv_pc_count");
	nPCCount++;
	SetLocalInt(OBJECT_SELF, "hv_pc_count", nPCCount);
	
	// If this is the only PC in the area,
	// check if ritual should be set
	if (nPCCount == 1) {
		//if (GetLocalInt(OBJECT_SELF, "hv_create_all") == 1)
		object oPC = GetEnteringObject();
		if ((GetIsPC(oPC)) && (GetJournalEntry("hv_temple_quest", oPC) == 500))
			ExecuteScript("hv_set_up_temple", OBJECT_SELF);
	}
}
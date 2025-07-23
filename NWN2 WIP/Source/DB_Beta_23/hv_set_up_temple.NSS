// Clear possible left overs
void ClearLeftovers();

// Create boss
void CreateBoss();

// Create green pillars
void CreateGreenPillars();

// Create Summoners
void CreateSummoners();

void main()
{
	// Check if stuff should be created yet.
    // int nCreate = GetLocalInt(OBJECT_SELF, "hv_create_all");
	//if (nCreate == 1) {
	
	//if (GetLocalInt(OBJECT_SELF, "hv_pc_count") == 1) && (
		// Change var so we don't run it again
		// SetLocalInt(OBJECT_SELF, "hv_create_all", 0);	
		
		// Reset reset counter.
		SetLocalInt(OBJECT_SELF, "hv_reset_counter", 0);
	
		// Clean leftovers
		ClearLeftovers();
		
		// Create boss
		CreateBoss();
		
		// Create green pillars
		CreateGreenPillars();
		
		// Create Summoners
		CreateSummoners();
	//}
}

void ClearLeftovers()
{
	// Go through every object in the area,
	// and destroy the Boss, summoners and pillars
	object oObject = GetFirstObjectInArea(OBJECT_SELF);
	while (GetIsObjectValid(oObject)) {
		
		string sTag = GetTag(oObject);
		if ((sTag == "hv_green_pillar") || (sTag == "hv_temple_boss") || (sTag == "hv_temple_summoner") || (sTag == "hv_temple_chest"))
			DestroyObject(oObject);
		
		oObject = GetNextObjectInArea(OBJECT_SELF);
	}
}


void CreateBoss()
{
	// Create the boss!
	object oBossWP = GetObjectByTag("hv_temple_boss_wp");
	location lBossWP = GetLocation(oBossWP);
	object oBoss = CreateObject(OBJECT_TYPE_CREATURE, "hv_temple_boss", lBossWP);
	effect eVisual = EffectVisualEffect(VFX_DUR_GATE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisual, oBoss, 9999.0f);
}

// Go through all the waypoints 
// and create on each one a pillar.
void CreateGreenPillars()
{
	int i = 0;
	string sPillar = "hv_green_pillar";
	string sPillarWP = "hv_green_pillar_wp";
	object oPillarWP;
	location lPillarLocation;
	
	// 8 pillars
	for (i = 0; i < 8; i++) {
	
		// Get location to create pillar
		oPillarWP = GetObjectByTag(sPillarWP, i);
		lPillarLocation = GetLocation(oPillarWP);
		
		// Create pillar
		CreateObject(OBJECT_TYPE_PLACEABLE, sPillar, lPillarLocation);
	}
	
	SetLocalInt(OBJECT_SELF, "hv_pillars_count", 8);
	SetLocalInt(OBJECT_SELF, "hv_create_orbs", 0);	
}	

// Go through all the waypoints
// and create on each one a summoner
void CreateSummoners()
{
	int i = 0;
	string sSummoner = "hv_temple_summoner";
	string sSummonerWP = "hv_temple_summoner_wp";
	object oSummonerWP;
	location lSummonerLocation;
	object oSummoner;
	
	// 4 summoners
	for (i = 0; i < 4; i++) {
		
		// Get location to create summoner
		oSummonerWP = GetObjectByTag(sSummonerWP, i);
		lSummonerLocation = GetLocation(oSummonerWP);
		
		// Create summoner
		oSummoner = CreateObject(OBJECT_TYPE_CREATURE, sSummoner, lSummonerLocation);
		
		// Apply effect on Boss
		ExecuteScript("hv_temple_summoner_effects", oSummoner);
	}	
	SetLocalInt(GetArea(OBJECT_SELF), "hv_hostile_summoners", 1);
	SetLocalInt(GetArea(OBJECT_SELF), "hv_hostile_boss", 0);
}		
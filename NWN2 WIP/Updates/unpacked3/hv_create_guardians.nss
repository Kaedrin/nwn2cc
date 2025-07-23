void main()
{
	// Check if they are already created.
	int nGuardianFlag = 0;
	int nMinion1Flag = 0;
	int nMinion2Flag = 0;
	object oArea = OBJECT_SELF;
    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject))
    {
        if (GetTag(oObject) == "hv_demiplane_guardian")
			nGuardianFlag = 1;
			
		if (GetTag(oObject) == "hv_demiplane_minion1")
			nMinion1Flag = 1;
			
		if (GetTag(oObject) == "hv_demiplane_minion2")
			nMinion2Flag = 1;
			
		oObject = GetNextObjectInArea(oArea);
    }
	
	// Create creatures if they aren't there already
	if (nGuardianFlag == 0) {	
		location lGuardian = GetLocation(GetWaypointByTag("hv_guardian_wp"));
		CreateObject(OBJECT_TYPE_CREATURE, "hv_demiplane_guardian", lGuardian);
	}
	
	if (nMinion1Flag == 0) {
		location lMinion1 = GetLocation(GetWaypointByTag("hv_minion1_wp"));
		CreateObject(OBJECT_TYPE_CREATURE, "hv_demiplane_minion1", lMinion1);
	}
	
	if (nMinion2Flag == 0) {
		location lMinion2 = GetLocation(GetWaypointByTag("hv_minion2_wp"));
		CreateObject(OBJECT_TYPE_CREATURE, "hv_demiplane_minion2", lMinion2);
	}
}
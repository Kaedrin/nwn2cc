#include "hv_p_h_mirrors_inc_v2"
#include "hcr2_core_i"

// Set up the puzzle if the first PC enters the area

const int TOTAL_WP = 23;

// Return TRUE if the WP wasn't used before,
// FALSE otherwise. If it's free, mark it as busy now.
int IsWPFree(object oWP)
{
	object oArea = GetArea(oWP);
	string sWP = ObjectToString(oWP);
	
	if (GetLocalInt(oArea, "hv_wp_s_" + sWP) == 0) {
		SetLocalInt(oArea, "hv_wp_s_" + sWP, 1);
		return TRUE;
	}
		
	return FALSE;
}

// Reset all waypoints to free state
void ResetWayPointsFreeState(object oArea)
{
	int nVarNum = GetVariableCount(oArea);
	int i;
	string sVarName;
	for (i = 0; i < nVarNum; i++) {		
		sVarName = GetVariableName(oArea, i);
		if (FindSubString(sVarName, "hv_wp_s_") != -1)
			SetLocalInt(oArea, sVarName, 0);
	}
}

// Get Random waypoint
location GetRandomMirrorLocation()
{
	// Get random waypoint location
	int nRand = Random(TOTAL_WP);
	object oWP = GetObjectByTag("hv_p_h_mirror_wp", nRand);
	
	// Make sure the WP wasn't already selected
	int nSanityCheck = 0;
	while ((IsWPFree(oWP) == FALSE) && (nSanityCheck < 100)) {
		nRand = Random(TOTAL_WP);
		oWP = GetObjectByTag("hv_p_h_mirror_wp", nRand);
		nSanityCheck++;
	}	
	
	location lLocation = GetLocation(oWP);
	return lLocation;
}

// Set object facing a random direction
void SetFacingRandom(object oObject)
{
	int nRandom = Random(360) + 1;
	AssignCommand(oObject, SetFacing(IntToFloat(nRandom)));
}

// Clear last puzzle setup
void ClearMirrorsPuzzle()
{
	// Destroy mirrors
	int i = 0;
	object oMirror;
	for (i = 0; i < TOTAL_MIRRORS; i++) {
		oMirror = GetObjectByTag(MIRROR_TAG, i);
		if (GetIsObjectValid(oMirror)) { DestroyObject(oMirror, i * 0.1); }
	}
	
	// Destroy machine
	object oMachine = GetObjectByTag("hv_p_h_machine");
	if (GetIsObjectValid(oMachine)) { DestroyObject(oMachine); }
	
	// Destroy Key Crystal
	object oKeyCrystal = GetObjectByTag(KEY_CRYSTAL);
	if (GetIsObjectValid(oKeyCrystal)) { DestroyObject(oKeyCrystal); }
}

// Set it up
void SetMirrorPuzzle()
{			
	// Reset WPs
	object oArea = OBJECT_SELF;
	ResetWayPointsFreeState(oArea);
	
	// Create Machine
	location lLoc = GetRandomMirrorLocation();
	object oMachine = CreateObject(OBJECT_TYPE_PLACEABLE, "hv_p_h_machine", lLoc);
	SetFacingRandom(oMachine);
	
	// Create mirrors
	int i = 0;
	object oMirror;
	for (i = 1; i <= TOTAL_MIRRORS; i++) {
		lLoc = GetRandomMirrorLocation();		
		oMirror = CreateObject(OBJECT_TYPE_PLACEABLE, MIRROR_TAG, lLoc);
		SetFacingRandom(oMirror);
		SetFirstName(oMirror, "Mirror" + IntToString(i));
	}
	
	// Create Crystal
	lLoc = GetRandomMirrorLocation();
	oMirror = CreateObject(OBJECT_TYPE_PLACEABLE, KEY_CRYSTAL, lLoc);
}

void main()
{
	object oPC = GetEnteringObject();
	
	// I want PCs only!
	if (!GetIsPC(oPC))
		return;
		
	// Do the rest only if we're the only PC in the area
	if (GetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA) > 1)
		return;
		
	ClearMirrorsPuzzle();
	SetMirrorPuzzle();
}
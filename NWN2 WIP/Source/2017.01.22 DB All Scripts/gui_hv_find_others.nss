#include "hv_find_players_inc"

// Clear previous searches
void ClearSearchVariables();

// Report search result to activator
void ReportLocation();

void main()
{
	// For testing - allow only DMs to use for now.
	//if (!GetIsDM(OBJECT_SELF)) {
	//	SendMessageToPC(OBJECT_SELF, "Function still in testing.");
	//	return;
	//}
	
	ClearSearchVariables();	

	// Loop through every PC in the module
	object oArea;
	string sAreaName;
	int nPlayersInArea;
	string sAreaVarName;
	object oPC = GetFirstPC();
	while (GetIsObjectValid(oPC)) {
		
		// Get variable from PC:
		// 0 - wasn't set yet
		// 1 - don't find me!
		// 2 - find me.
		int nScryStatus = GetLocalInt(oPC, FIND_PLAYERS_VAR);
		
		// if wasn't set yet (0), and we hide all
		// by default, set the PC to "don't find me".
		// else set to "find me".
		if (nScryStatus == 0) {
		
			if (HIDE_ALL_BY_DEFAULT) {
				nScryStatus = 1;
			}
			else {
				nScryStatus = 2;
			}
			
			SetLocalInt(oPC, FIND_PLAYERS_VAR, nScryStatus);
		}
		
		// Get the area the player is in
		oArea = GetArea(oPC);
		sAreaName = GetName(oArea);
		if(sAreaName == "") sAreaName = "transition";
		sAreaVarName = AREA_VAR_PREFIX + sAreaName;
		
		
		// find player. can't hide from DMs
		if (nScryStatus == 2 || GetIsDM(OBJECT_SELF)) {
			
			// Increase area variable by 1
			int nPlayersInArea = GetLocalInt(OBJECT_SELF, sAreaVarName);
			
			// if it is -1, the whole area should remain hidden,
			// so we do nothing.
			if (nPlayersInArea != -1) {
				SetLocalInt(OBJECT_SELF, sAreaVarName, nPlayersInArea + 1);
			}
		}
		
		// don't find player (1)
		// Can't hide from DMs hehehe
		else if (nScryStatus == 1) {
			
			// Check if we need to hide the entire
			// area for the player
			if (HIDE_ENTIRE_AREA_FOR_PC)
				SetLocalInt(OBJECT_SELF, sAreaVarName, -1);
		}
		
		
		oPC = GetNextPC();	
	}
	
	// report findings
	ReportLocation();
}

// Clear previous searches.
// Go over all variables and delete those with prefix
// of "hv_area_"
void ClearSearchVariables()
{
	int nVarNum = GetVariableCount(OBJECT_SELF);
	int i;
	string sVarName;
	for (i = 0; i < nVarNum; i++) {
		
		sVarName = GetVariableName(OBJECT_SELF, i);
		if (GetSubString(sVarName, 0, GetStringLength(AREA_VAR_PREFIX)) == AREA_VAR_PREFIX)
			SetLocalInt(OBJECT_SELF, sVarName, 0);
	}
}

// Report results to activator
void ReportLocation()
{
	int nVarNum = GetVariableCount(OBJECT_SELF);
	int i;
	int nPCsInArea;
	string sVarName;
	string sAreaName;
	int nPrefixLength = GetStringLength(AREA_VAR_PREFIX);
	int nAreaNameLength;
	for (i = 0; i < nVarNum; i++) {
		
		sVarName = GetVariableName(OBJECT_SELF, i);
		nAreaNameLength = GetStringLength(sVarName) - nPrefixLength;
		if (GetSubString(sVarName, 0, nPrefixLength) == AREA_VAR_PREFIX) {
			sAreaName = GetSubString(sVarName, nPrefixLength, nAreaNameLength);
			nPCsInArea = GetLocalInt(OBJECT_SELF, sVarName);
			if (nPCsInArea > 1)
				SendMessageToPC(OBJECT_SELF, IntToString(nPCsInArea) + " players in " + sAreaName);
			else if (nPCsInArea == 1)
				SendMessageToPC(OBJECT_SELF, IntToString(nPCsInArea) + " player in " + sAreaName);
		}
	}
}
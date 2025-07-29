#include "hv_arena_inc"
// On Enter of the arena trigger - store each PC object
// on the area
void main()
{
	object oPC = GetEnteringObject();
	object oArea = GetArea(OBJECT_SELF);
	if (GetIsPC(oPC)) {
		//string sPCID = PLAYER_OBJECT_VAR + ObjectToString(oPC);
		//SetLocalObject(oArea, sPCID, oPC);
		SetLocalInt(oPC, ARENA_CHALLENGE_VAR, 1);
		int nTotalPCs = GetLocalInt(oArea, CHALLENGERS_COUNT);
		SetLocalInt(oArea, CHALLENGERS_COUNT, nTotalPCs + 1);
		
		// Increase Max HD if needed
		int nMaxHD = GetLocalInt(oArea, MAX_HD);
		int nPlayerHD = GetHitDice(oPC);
		if (nPlayerHD > nMaxHD)
			SetLocalInt(oArea, MAX_HD, nPlayerHD);
			
		// Make Arena faction hostile to challenger
		AdjustReputation(oPC, GetNearestObjectByTag("hv_arena_top_scores"), -100);
	}		
}
#include "hv_arena_inc"

// On Exit of the arena trigger - delete each PC object
// from the area
void main()
{
	object oPC = GetExitingObject();
	object oArea = GetArea(OBJECT_SELF);
	if (GetIsPC(oPC)) {
		//string sPCID = PLAYER_OBJECT_VAR + ObjectToString(oPC);
		//SetLocalObject(oArea, sPCID, OBJECT_INVALID);
		SetLocalInt(oPC, ARENA_CHALLENGE_VAR, 0);
		int nTotalPCs = GetLocalInt(oArea, CHALLENGERS_COUNT);
		if (nTotalPCs < 1)
			nTotalPCs = 1;
		SetLocalInt(oArea, CHALLENGERS_COUNT, nTotalPCs - 1);
		
		// Check if the highest HD player left
		int nMaxHD = GetLocalInt(oArea, MAX_HD);
		int nPlayerHD = GetHitDice(oPC);
		if (nPlayerHD == nMaxHD)
			SetLocalInt(oArea, MAX_HD, 1);
			
		if (nTotalPCs == 1) { // meaning now it's 0!
			CleanArena();
			SetLocalInt(oArea, CHALLENGE_RUNNING, FALSE);
		}
	}		
}
#include "hv_arena_inc"

// Spwan the first monster in the challenge
void main()
{
	object oPC = GetLastUsedBy();
	object oArea = GetArea(OBJECT_SELF);
	
	// Challenge already in progress
	if (GetLocalInt(oArea, CHALLENGE_RUNNING)) {
		SendMessageToPC(oPC, "Challenge is in progress.");
		return;
	}
	
	//SetChallengeVarOnPC(oArea);
	
	// Set starting difficulty based on activator HD
	int nPlayerHD = GetHitDice(oPC);
	int nMaxHD = GetLocalInt(oArea, MAX_HD);
	if (nMaxHD > nPlayerHD)
		nPlayerHD = nMaxHD;
	int nStartDifficulty = GetStartDifficultyV2(nPlayerHD);
		
	SetLocalInt(oArea, CHALLENGERS_START_NUM, GetLocalInt(oArea, CHALLENGERS_COUNT));
	
	// Limit to 6 challengers
	if (GetLocalInt(oArea, CHALLENGERS_START_NUM) > 6) {
		Announce("<C=lightgreen>The challenge is limited to 6 challengers!");
		return;
	}
	
	SetLocalInt(oArea, CHALLENGERS_COUNTER, GetLocalInt(oArea, CHALLENGERS_START_NUM));
	SetLocalObject(oArea, CHALLENGER, oPC);
	SetLocalInt(oArea, ROUND_DIFFICULTY, nStartDifficulty);
	SetLocalInt(oArea, NUM_OF_ROUNDS, 1);
	SetLocalInt(oArea, TOTAL_MONSTERS_KILLED, 0);
	SetLocalInt(oArea, CHALLENGE_RUNNING, TRUE);
	
	// Close and lock doors
	object oDoor = GetObjectByTag("hv_arena_door_1");
	ActionCloseDoor(oDoor);
	ActionDoCommand(SetLocked(oDoor, TRUE));
	
	oDoor = GetObjectByTag("hv_arena_door_2");
	ActionCloseDoor(oDoor);
	ActionDoCommand(SetLocked(oDoor, TRUE));
	
	Announce("<C=teal><b>The challenge will begin in ten seconds!");
	DelayCommand(10.0f, ExecuteScript("hv_arena_next_round", oArea));
}
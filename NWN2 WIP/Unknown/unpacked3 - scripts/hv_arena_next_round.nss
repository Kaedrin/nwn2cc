#include "hv_arena_inc"

// so player beats all monsters in round, time to spanw new round!
// (script is run by the area itself)
void main()
{
	// Do nothing if the challenge is stopped
	if (GetLocalInt(OBJECT_SELF, CHALLENGE_RUNNING) == 0)
		return;
		
	// reset HB Counter
	SetLocalInt(OBJECT_SELF, HB_COUNTER, 0);
			
	// Get PC's party size
	int nPartySize = GetLocalInt(OBJECT_SELF, CHALLENGERS_START_NUM);
	
	// Pick random number of how many monsters to spawn
	// each round difficulty increases, so increase number
	// of monsters
	int nDifficulty = GetLocalInt(OBJECT_SELF, ROUND_DIFFICULTY);
	int nRounds  = GetLocalInt(OBJECT_SELF, NUM_OF_ROUNDS);
	int nRoundMonsters = Random(nPartySize + 1) + 1;
	
	if (nRounds >= 15)
		nRoundMonsters++;
	
	// limit it to 3 monsters
	if (nRoundMonsters > 3)
		nRoundMonsters = 3;
	
	// Store the number on variable
	SetLocalInt(OBJECT_SELF, ROUND_MONSTERS, nRoundMonsters);
	
	// Start creating monsters
	int i;
	for (i = 0; i < nRoundMonsters; i++) {
		CreateArenaMonsterV2(nDifficulty);
	}
	
	
	// Increase difficulty for next round
	//SetLocalInt(OBJECT_SELF, ROUND_DIFFICULTY, nDifficulty + 1);
	
	// increase difficulty every 10 rounds
	if ((nRounds == 10) || (nRounds == 20) || (nRounds >= 30)) {
		if (nDifficulty < 8)
			SetLocalInt(OBJECT_SELF, ROUND_DIFFICULTY, nDifficulty + 1);
	}
}
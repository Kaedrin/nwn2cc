// When a player dies in the arena area, if she has the challenge
// variable, this script will run (by the area).
// 
// Decrement remaining challengers by 1, teleport her outside
// of the arena, and check if challenge is over.
#include "hv_arena_inc"


void main()
{
	// Decrement remaining challengers
	int nChallengersLeft = GetLocalInt(OBJECT_SELF, CHALLENGERS_COUNTER);
	nChallengersLeft--;
	SetLocalInt(OBJECT_SELF, CHALLENGERS_COUNTER, nChallengersLeft);
	
	if (nChallengersLeft == 0) {
		//CleanArena();
		AnnounceResults();
		int nRoundsLasted = GetLocalInt(OBJECT_SELF, NUM_OF_ROUNDS) - 1;
		int nMonstersKilled = GetLocalInt(OBJECT_SELF, TOTAL_MONSTERS_KILLED);
		RegisterRecords(MOST_ROUNDS_VAR, MOST_ROUNDS_PC, nRoundsLasted);
		RegisterRecords(MOST_MONSTERS_KILLED, MOST_MONSTERS_PC, nMonstersKilled);
		object oChallenger = GetLocalObject(OBJECT_SELF, CHALLENGER);
		CheckArenaSurvivalQuest(oChallenger, "hv_arena_survival_5", 600, 601, 5, nRoundsLasted);
		CheckArenaSurvivalQuest(oChallenger, "hv_arena_survival_10", 603, 604, 10, nRoundsLasted);
		CheckArenaSurvivalQuest(oChallenger, "hv_arena_survival_15", 606, 607, 15, nRoundsLasted);
		CheckArenaSurvivalQuest(oChallenger, "hv_arena_survival_20", 609, 610, 20, nRoundsLasted);
		CheckArenaSurvivalQuest(oChallenger, "xenq_arena30", 861220, 861221, 30, nRoundsLasted);
		//SetLocalInt(OBJECT_SELF, CHALLENGE_RUNNING, FALSE);
	}
}
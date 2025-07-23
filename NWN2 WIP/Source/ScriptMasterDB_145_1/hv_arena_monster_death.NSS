#include "hv_arena_inc"

// Check if we need to advance to next round
void main()
{	
	object oArea = GetArea(OBJECT_SELF);
	
	// Check if challengers got outside help (i.e. cheating!)
	object oKiller = GetLastKiller();
	if ((GetLocalInt(oKiller, ARENA_CHALLENGE_VAR) == 0) && (GetIsPC(oKiller))) {
		CleanArena();
		SetLocalInt(oArea, CHALLENGE_RUNNING, FALSE);
		Announce("<C=red>Only challengers are allowed to attack the monsters!");
		return;
	}
	
	// Increment total monsters killed var
	int nTotalMKilled = GetLocalInt(oArea, TOTAL_MONSTERS_KILLED);
	SetLocalInt(oArea, TOTAL_MONSTERS_KILLED, nTotalMKilled + 1);

	// Get the variable that tells us how many
	// monsters were in the round
	int nRoundMonstersCount = GetLocalInt(oArea, ROUND_MONSTERS);
	
	// Now decrement by 1 and set new value
	nRoundMonstersCount--;
	SetLocalInt(oArea, ROUND_MONSTERS, nRoundMonstersCount);
	
	// if it's now 0 - signal next round to begin
	if (nRoundMonstersCount == 0) {
		int nRounds = GetLocalInt(oArea, NUM_OF_ROUNDS);
		nRounds++;
		SetLocalInt(oArea, NUM_OF_ROUNDS, nRounds);
		SetLocalInt(OBJECT_SELF, HB_COUNTER, 0);
		Announce("<C=teal><b>Round number " + IntToString(nRounds) + " will begin in fifteen seconds!");
		AssignCommand(oArea, DelayCommand(15.0f, ExecuteScript("hv_arena_next_round", oArea)));
	}
}
// nar_c_spawnscript

// Script called when a monster spawns.
// Sets up:
// - buffs
// - battle cries
// To be used with c_nar_onuserdefined

// Narks - 24 Dec 2010

#include "NW_I0_GENERIC"

void main()
{
	// Causes creature to buff itself when the PC comes close.
	SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY, TRUE);

	// BATTLE CRY
	// BattleCryCount determines the number of battle cries.
	// Battle cries are stored in BattleCry1, BattleCry2, etc.
	// Eg.	vampire has 3 battle cries, one which is blank
	//		BattleCryCount = 3
	// 		BattleCry1 = "...", BattleCry2 = "..."
	//		
	// 		There is a 2/3 chance of a battle cry and a 1/3 chance
	//		of no battle cry.
	if (GetLocalInt(OBJECT_SELF, "BattleCryCount") > 0)
		SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT, TRUE);
}
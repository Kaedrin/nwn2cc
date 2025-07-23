#include "nwnx_sql"

// On open of treasure chest / gold, reward player, once per reset
void main()
{
	object oPC = GetLastOpenedBy();

	// Check if player looted this reset yet
	if (GetLocalInt(OBJECT_SELF, ObjectToString(oPC)) != 0) {
	
		SpeakString("The treasure has already been looted.");
		return;
	}
	
	// If it's a gold pile, give random gold from 100 to 1000
	if (GetTag(OBJECT_SELF) == "hv_bandits_gold") {
	
		int nRand = Random(901) + 100;
		CreateItemOnObject("nw_it_gold001", OBJECT_SELF, nRand);
	}
	// Chests / Armoir
	else
	 {
	
		ExecuteScript("fw_random_loot", OBJECT_SELF);
		
			// Mark player looted
	SetLocalInt(OBJECT_SELF, ObjectToString(oPC), 1);
}
}


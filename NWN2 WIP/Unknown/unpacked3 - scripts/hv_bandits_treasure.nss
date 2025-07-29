#include "nwnx_sql"
#include "hv_bandits_inc"

// On open of treasure chest / gold, reward player, once per reset
void main()
{
	object oPC = GetLastOpenedBy();

	// Check that PC has password
	if (GetLocalInt(oPC, DIGIT_1) == 0)
		return;
	
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
	else {
	
		ExecuteScript("fw_random_loot", OBJECT_SELF);
		
		// Create quest ring if player has quest =)
		if (GetJournalEntry("hv_bandits_quest", oPC) == 900) {
		
			// Create ring
			CreateItemOnObject("hv_bandits_ring", OBJECT_SELF);
			
			// Advance journal entry =)
			object oPassport = GetItemPossessedBy(oPC,"pc_tracker");	
			int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
			AddJournalQuestEntry("hv_bandits_quest", 905, oPC, FALSE);
			SetPersistentInt(oPC, "hv_bandits_quest", 905);
			SetLocalInt(oPassport,"hv_bandits_quest", 905);
			SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
		}
	}
	
	// Mark player looted
	SetLocalInt(OBJECT_SELF, ObjectToString(oPC), 1);
}
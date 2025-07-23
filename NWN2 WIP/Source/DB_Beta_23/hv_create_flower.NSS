#include "nwnx_sql"

// Create quest item (hv_rare_flower) if opener has quest
void main()
{
	object oPC = GetLastOpenedBy();
	object oPassport = GetItemPossessedBy(oPC,"pc_tracker");	
	int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
	int nEntry = GetJournalEntry("hv_beastmen", oPC);
	if (nEntry == 400) {
		
		// Create item
		CreateItemOnObject("hv_rare_flower");
		
		// Progress quest
		AddJournalQuestEntry("hv_beastmen", 410, oPC, FALSE, FALSE, TRUE);
  		SetPersistentInt(oPC, "hv_beastmen", 410);
  		SetLocalInt(oPassport,"hv_beastmen", 410);
  		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
}
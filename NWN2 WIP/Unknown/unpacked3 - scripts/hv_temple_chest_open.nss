// Give opener a gem to prove she stopped the ritual
#include "nwnx_sql"
void main()
{
	// TODO - change to correct values!!
	int nQuestEntry = 510;
	int nProgressQuestTo = 520;
	string sGemTag = "hv_temple_gem_quest";
	
	object oPC = GetLastOpenedBy();
	if (GetJournalEntry("hv_temple_quest", oPC) == nQuestEntry) {
		CreateItemOnObject(sGemTag, OBJECT_SELF, 1);
		object oPassport = GetItemPossessedBy(oPC,"pc_tracker");	
		int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
		AddJournalQuestEntry("hv_temple_quest", nProgressQuestTo, oPC, FALSE);
		SetPersistentInt(oPC, "hv_temple_quest", nProgressQuestTo);
		SetLocalInt(oPassport,"hv_temple_quest", nProgressQuestTo);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
}
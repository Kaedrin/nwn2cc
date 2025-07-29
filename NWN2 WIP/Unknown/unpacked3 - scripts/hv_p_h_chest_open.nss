// Give opener a book for the gnome puzzle quest
#include "nwnx_sql"
void main()
{
	int nQuestEntry = 460;
	int nProgressQuestTo = 470;
	string sGemTag = "hv_p_h_book";
	
	object oPC = GetLastOpenedBy();
	if (GetJournalEntry("hv_p_h", oPC) == nQuestEntry) {
		CreateItemOnObject(sGemTag, OBJECT_SELF, 1);
		object oPassport = GetItemPossessedBy(oPC,"pc_tracker");	
		int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
		AddJournalQuestEntry("hv_p_h", nProgressQuestTo, oPC, FALSE);
		SetPersistentInt(oPC, "hv_p_h", nProgressQuestTo);
		SetLocalInt(oPassport,"hv_p_h", nProgressQuestTo);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
}
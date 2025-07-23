
#include "nwnx_sql"
void main()
{
	object oPC = GetPCSpeaker();
	object oPassport = GetItemPossessedBy(oPC,"pc_tracker"); 
	int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
 
	int nCurrentEntry = GetJournalEntry("hv_historian", oPC);
   	AddJournalQuestEntry("hv_historian", nCurrentEntry + 1, oPC, FALSE, FALSE, TRUE);
    SetPersistentInt(oPC, "hv_historian", nCurrentEntry + 1 );
    SetLocalInt(oPassport,"hv_historian",  nCurrentEntry + 1);
}
//Author: Xeneize
//Will launch time required for PC to study lore.


 
//Put this script OnExit



#include "nwnx_sql"

void main()
{
	// Setting up the values.
	int nQuestEntry = 861251;
	int nProgressQuestTo = 861252;

object oPC = GetExitingObject();

if (!GetIsPC(oPC)) return;

if (GetJournalEntry("xenq_ud_yathrinquest", oPC) == nQuestEntry) {
		object oPassport = GetItemPossessedBy(oPC,"pc_tracker");	
		int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
		AddJournalQuestEntry("xenq_ud_yathrinquest", nProgressQuestTo, oPC, FALSE);
		SetPersistentInt(oPC, "xenq_ud_yathrinquest", nProgressQuestTo);
		SetLocalInt(oPassport,"xenq_ud_yathrinquest", nProgressQuestTo);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}	
}

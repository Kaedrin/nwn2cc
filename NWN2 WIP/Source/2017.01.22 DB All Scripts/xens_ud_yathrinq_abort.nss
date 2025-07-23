//Author: Xeneize
//Will make PC automatically fail test if aborted.

//Goes on end-event script of conversation file
 

#include "nwnx_sql"

void main()
{
	// Setting up the values.
	int nQuestEntry = 861250;
	int nProgressQuestTo = 861255;

object oPC = GetPCSpeaker();

if (GetJournalEntry("xenq_ud_yathrinquest", oPC) >= nQuestEntry) {
		object oPassport = GetItemPossessedBy(oPC,"pc_tracker");	
		int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
		AddJournalQuestEntry("xenq_ud_yathrinquest", nProgressQuestTo, oPC, FALSE);
		SetPersistentInt(oPC, "xenq_ud_yathrinquest", nProgressQuestTo);
		SetLocalInt(oPassport,"xenq_ud_yathrinquest", nProgressQuestTo);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
}





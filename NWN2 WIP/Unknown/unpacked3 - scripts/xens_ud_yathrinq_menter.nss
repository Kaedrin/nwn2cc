//Author: Xeneize
//Will launch time required for PC to study lore.


 
//Put this script OnEnter



#include "nwnx_sql"

void main()
{
	// Setting up the values.
	int nQuestEntry = 861250;
	int nProgressQuestTo = 861251;

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetJournalEntry("xenq_ud_yathrinquest", oPC) == nQuestEntry) {
		object oPassport = GetItemPossessedBy(oPC,"pc_tracker");	
		int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
		AddJournalQuestEntry("xenq_ud_yathrinquest", nProgressQuestTo, oPC, FALSE);
		SetPersistentInt(oPC, "xenq_ud_yathrinquest", nProgressQuestTo);
		SetLocalInt(oPassport,"xenq_ud_yathrinquest", nProgressQuestTo);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
		DelayCommand(1.0, SendMessageToPC(oPC, "You are in the Melee Magthere; rich with lore about the Drow race, Underdark and the Dark Seldarine. Take your time..."));
    	DelayCommand(1.0, GiveXPToCreature(oPC, 100));
		DelayCommand(60.0, AddJournalQuestEntry("xenq_ud_yathrinquest", 861252, oPC, FALSE));
		DelayCommand(60.0, SetPersistentInt(oPC, "xenq_ud_yathrinquest", 861252));
		DelayCommand(60.0, SetLocalInt(oPassport,"xenq_ud_yathrinquest", 861252));
		DelayCommand(60.0,SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank"));
	}	
}
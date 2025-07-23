//Author: Xeneize
//Will check if PC has quest active, if so it will reward quest items when killing creature.

//Put this script OnDeath
 
#include "nwnx_sql"

void main()
{
	// Setting up the values.
	int nQuestEntry = 86128060;
	int nProgressQuestTo = 86128061;
	string sGemTag = "gac_mino_horn";
ExecuteScript("nw_c2_default7",OBJECT_SELF);
object oPC = GetLastKiller();
while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

if (GetJournalEntry("xenq_ud_magminotaur", oPC) == nQuestEntry) {
		CreateItemOnObject(sGemTag, oPC, 1);
		object oPassport = GetItemPossessedBy(oPC,"pc_tracker");	
		int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
		AddJournalQuestEntry("xenq_ud_magminotaur", nProgressQuestTo, oPC, FALSE);
		SetPersistentInt(oPC, "xenq_ud_magminotaur", nProgressQuestTo);
		SetLocalInt(oPassport,"xenq_ud_magminotaur", nProgressQuestTo);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
}
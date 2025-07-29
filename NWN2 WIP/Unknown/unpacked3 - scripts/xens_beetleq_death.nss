//Author: Xeneize
//Will check if PC has quest active, if so it will reward quest items when killing creature.

//Put this script OnDeath
 
#include "nwnx_sql"

void main()
{
	// Setting up the values.
	int nQuestEntry = 861240;
	int nProgressQuestTo = 861241;
	string sGemTag = "gac_beetle_meat";
ExecuteScript("nw_c2_default7",OBJECT_SELF);
object oPC = GetLastKiller();
while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

if (GetJournalEntry("xenq_ud_beetlemeatbounty", oPC) == nQuestEntry) {
		CreateItemOnObject(sGemTag, oPC, 1);
		object oPassport = GetItemPossessedBy(oPC,"pc_tracker");	
		int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
		AddJournalQuestEntry("xenq_ud_beetlemeatbounty", nProgressQuestTo, oPC, FALSE);
		SetPersistentInt(oPC, "xenq_ud_beetlemeatbounty", nProgressQuestTo);
		SetLocalInt(oPassport,"xenq_ud_beetlemeatbounty", nProgressQuestTo);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
}
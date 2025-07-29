//Author: Xeneize
//Will check if PC has quest active, if so it will progress to next entry.

//Put this script OnDeath
 
#include "nwnx_sql"

void main()
{
	// Setting up the values.
	int nQuestEntry = 861261;
	int nProgressQuestTo = 861262;
ExecuteScript("nw_c2_default7",OBJECT_SELF);
object oPC = GetLastKiller();
while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;
if (GetJournalEntry("xenq_ud_uuthli", oPC) == nQuestEntry) {
		object oPassport = GetItemPossessedBy(oPC,"pc_tracker");	
		int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
		AddJournalQuestEntry("xenq_ud_uuthli", nProgressQuestTo, oPC, FALSE);
		SetPersistentInt(oPC, "xenq_ud_uuthli", nProgressQuestTo);
		SetLocalInt(oPassport,"xenq_ud_uuthli", nProgressQuestTo);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
}
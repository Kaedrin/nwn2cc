//Author: Xeneize
//Will check if PC has quest active, if so it will reward quest items when killing creature.

//Put this script OnDeath
 
#include "nwnx_sql"

void main()
{
	// Setting up the values.
	int nQuestEntry = 861211;
	int nProgressQuestTo = 861215;
	string sGemTag = "gac_troll_blood_bounty";
ExecuteScript("nw_c2_default7",OBJECT_SELF);
object oPC = GetLastKiller();
while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "gac_troll_blood_bounty")!= OBJECT_INVALID)
   {
   return;
   }
else if (GetJournalEntry("xenq_trollblood", oPC) == nQuestEntry) {
		CreateItemOnObject(sGemTag, oPC, 1);
		object oPassport = GetItemPossessedBy(oPC,"pc_tracker");	
		int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
		AddJournalQuestEntry("xenq_trollblood", nProgressQuestTo, oPC, FALSE);
		SetPersistentInt(oPC, "xenq_trollblood", nProgressQuestTo);
		SetLocalInt(oPassport,"xenq_trollblood", nProgressQuestTo);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
}
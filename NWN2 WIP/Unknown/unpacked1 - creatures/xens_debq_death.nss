//Author: Xeneize
//Will check if PC has quest active, if so it will reward quest items when killing creature.

//Put this script OnDeath

#include "nwnx_sql"
void main()
{
	// Setting up the values.
	int nQuestEntry = 861201;
	int nProgressQuestTo = 861202;
	string sGemTag = "gac_drow_ear_bounty";
ExecuteScript("nw_c2_default7",OBJECT_SELF);
object oPC = GetLastKiller();
while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "gac_drow_ear_bounty")!= OBJECT_INVALID)
   {
   return;
   }
else if (GetJournalEntry("xenq_deb", oPC) == nQuestEntry) {
		CreateItemOnObject(sGemTag, oPC, 2);
		object oPassport = GetItemPossessedBy(oPC,"pc_tracker");	
		int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");
		AddJournalQuestEntry("xenq_deb", nProgressQuestTo, oPC, FALSE);
		SetPersistentInt(oPC, "xenq_deb", nProgressQuestTo);
		SetLocalInt(oPassport,"xenq_deb", nProgressQuestTo);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
}
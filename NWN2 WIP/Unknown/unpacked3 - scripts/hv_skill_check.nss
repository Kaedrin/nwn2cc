#include "ginc_var_ops"
#include "ginc_param_const"
#include "nwnx_sql"

void main(int nSkill, int nSkillPoints, string sBookTag)
{
	object oPC = GetPCSpeaker();	
	
	// Exploit fix - if player already been here,
	// return without giving her a thing.
	if (GetLocalInt(oPC, "hv_"+sBookTag+"_roll")) return;
	
	if (GetIsSkillSuccessful(oPC, nSkill, nSkillPoints))
	{
		object oPassport = GetItemPossessedBy(oPC,"pc_tracker"); 
		int nCurrentEntry = GetJournalEntry("hv_historian", oPC);
   		AddJournalQuestEntry("hv_historian", nCurrentEntry + 1, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "hv_historian", nCurrentEntry + 1 );
    	SetLocalInt(oPassport,"hv_historian",  nCurrentEntry + 1);
		CreateItemOnObject(sBookTag, oPC);
		GiveXPToCreature(oPC, 200);
	}
	
	// Mark player so next time they get no chance to roll
	// (exploit fix).
	SetLocalInt(oPC, "hv_"+sBookTag+"_roll", TRUE);
}
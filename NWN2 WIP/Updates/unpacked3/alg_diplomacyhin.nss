//object oItem;
//#include "nw_i0_tool"
#include "ginc_var_ops"
#include "ginc_param_const"
#include "nwnx_sql"

void main()
{
	object oPC = GetPCSpeaker();
	object oTarget;	
	object oPassport = GetItemPossessedBy(oPC,"pc_tracker");	
	int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank");

	if (GetIsSkillSuccessful(oPC, SKILL_DIPLOMACY, 19))
	{
   		//RewardPartyXP(250, oPC, FALSE);
		//SendMessageToPC(oPC, "I suppose if you say someone really needs it.. but don't let me catch you around here.");
   		AddJournalQuestEntry("alex_ghost", 90, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "alex_ghost", 90);
		SetLocalInt(oPassport,"alex_ghost", 90);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
		GiveXPToCreature(oPC, 250);
	}
	else
   	{
		//SendMessageToPC(oPC, "Yeah right.. get lost before I call the Zhent guard over here.");
		AddJournalQuestEntry("alex_ghost", 100, oPC, FALSE, FALSE, TRUE);
		SetPersistentInt(oPC, "alex_ghost", 100);
		SetLocalInt(oPassport,"alex_ghost", 100);
		SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
	}
}
// Visual+Sound for the boss death,
// quest advancement later.

#include "hv_cq_inc"
#include "nwnx_sql"

void main()
{
	effect eVis = EffectNWN2SpecialEffectFile("fx_kos_power_spell");
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(OBJECT_SELF));
	
	SoundObjectPlay(GetObjectByTag(BOSS_DEATH));
	
	// Progress quest for party in area
	SpeakString("<C=lightgreen><i>It can't be over... not like this...");
	
	// Go through killers party to give out XP
	object oPC = GetLastKiller();
	object oPassport;
	int nCurrentRank;
	
	object oMember = GetFirstFactionMember(oPC, TRUE);
	while (GetIsObjectValid(oMember)) {
		if (GetJournalEntry("hv_cq", oMember) == 560) {
			oPassport = GetItemPossessedBy(oMember,"pc_tracker");	
			nCurrentRank = GetPersistentInt(oMember, "RANK", "RP_Rank");
			AddJournalQuestEntry("hv_cq", 570, oMember, FALSE);
			SetPersistentInt(oMember, "hv_cq", 570);
			SetLocalInt(oPassport,"hv_cq", 570);
			SetPersistentInt(oMember, "RANK", (nCurrentRank + 1), 0, "RP_Rank");		
		}
		oMember = GetNextFactionMember(oPC);
	}
}
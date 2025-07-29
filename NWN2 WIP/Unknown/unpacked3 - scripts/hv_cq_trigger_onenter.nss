// Start the battle

#include "hv_cq_inc"

void main()
{
	object oPC = GetEnteringObject();
	if (!GetIsPC(oPC)) return;
	
	// Only run if setup completed
	if (GetLocalInt(GetArea(OBJECT_SELF), SETUP_COMPLETED) == FALSE)
		return;
	
	// Check that the battle isn't started already
	object oArea = GetArea(OBJECT_SELF);
	if (GetLocalInt(oArea, BATTLE_STARTED) == TRUE)
		return;
	
	// Mark battle as started	
	SetLocalInt(oArea, BATTLE_STARTED, TRUE);
		
	// Begin summoning stuff
	SetLocalInt(oArea, SUMMON_STUFF, TRUE);
	
	// Store highest level PC
	object oMember = GetFirstFactionMember(oPC);
	int nMaxHD = 1;
	int nLevel;
	while (GetIsObjectValid(oMember)) {
		nLevel = GetTotalLevels(oMember, FALSE);
		if (nMaxHD < nLevel)
			nMaxHD = nLevel;
		oMember = GetNextFactionMember(oPC);
	}
	SetLocalInt(oArea, TARGET_HD, nMaxHD);
	
	// Boss speaks
	object oBoss = GetObjectByTag(BOSS);
	AssignCommand(oBoss, SpeakString("<C=lightgreen>Ah, fresh subjects for my experiments. Very difficult to come by."));
	SoundObjectPlay(GetObjectByTag(BOSS_SPEAK_0));
	
	// Level boss up
	int nBossLevel = GetLocalInt(GetArea(oBoss), TARGET_HD);
	int nXP = GetXPForLevel(nBossLevel);
	ResetCreatureLevelForXP(oBoss, nXP, FALSE);
	ForceRest(oBoss);
}
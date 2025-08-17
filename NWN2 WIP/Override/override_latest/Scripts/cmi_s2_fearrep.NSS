//::///////////////////////////////////////////////
//:: Fearsome Reputation
//:: cmi_s2_fearrep
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 23, 2009
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_includes"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = SPELLABILITY_DRPIRATE_FEARSOME_REPUTATION;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	int nBonus = 2;
	if (GetLevelByClass(CLASS_DREAD_PIRATE, OBJECT_SELF) > 9)
		nBonus = 6;
	else
	if (GetLevelByClass(CLASS_DREAD_PIRATE, OBJECT_SELF) > 5)
		nBonus = 4;

	effect eIntimidate = EffectSkillIncrease(SKILL_INTIMIDATE, nBonus);
	eIntimidate = SetEffectSpellId(eIntimidate,nSpellId);
	eIntimidate = SupernaturalEffect(eIntimidate);
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eIntimidate, OBJECT_SELF, HoursToSeconds(72)));	
}      
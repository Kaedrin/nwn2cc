//::///////////////////////////////////////////////
//:: Sacred Vow
//:: cmi_s2_sacredvow
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Feb 23, 2008
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
	
	int nSpellId = SPELLABILITY_Sacred_Vow;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	

	effect eDiplomacy = EffectSkillIncrease(SKILL_DIPLOMACY, 2);
	eDiplomacy = SetEffectSpellId(eDiplomacy,nSpellId);
	eDiplomacy = SupernaturalEffect(eDiplomacy);
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDiplomacy, OBJECT_SELF, HoursToSeconds(72)));	
}      
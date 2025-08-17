//::///////////////////////////////////////////////
//:: Melodic Casting
//:: cmi_s2_melodcast
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Nov 17, 2008
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
	
	int nSpellId = FEAT_MELODIC_CASTING;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
		
	int nPerform = GetSkillRank(SKILL_PERFORM, OBJECT_SELF, TRUE);
	int nConc = GetSkillRank(SKILL_CONCENTRATION, OBJECT_SELF, TRUE);
	int nBonus = nPerform - nConc;
	
	if (nBonus > 0)
	{
		effect eSkill = EffectSkillIncrease(SKILL_CONCENTRATION, nBonus);
		eSkill = SetEffectSpellId(eSkill,nSpellId);
		eSkill = SupernaturalEffect(eSkill);
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSkill, OBJECT_SELF));	
	}   
	else
		return;
}   
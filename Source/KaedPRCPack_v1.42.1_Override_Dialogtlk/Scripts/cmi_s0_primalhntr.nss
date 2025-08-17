//::///////////////////////////////////////////////
//:: Primal Hunter
//:: cmi_s0_primalhntr
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 24, 2010
//:://////////////////////////////////////////////

#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
		
	object oTarget = GetSpellTargetObject(); 
	int nSpellId = GetSpellId(); 
			
	float fDuration = HoursToSeconds(24);
	fDuration = ApplyMetamagicDurationMods(fDuration);
		
	effect eSkill = EffectSkillIncrease(SKILL_TUMBLE, 5);
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_PREMONITION );		
	effect eLink = EffectLinkEffects(eSkill, eVis);	
		
	RemoveEffectsFromSpell(oTarget, nSpellId);	
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);		  	
	
	
}      
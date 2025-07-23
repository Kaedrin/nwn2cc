//::///////////////////////////////////////////////
//:: Lips of Rapture
//:: cmi_s2_lipsrapture
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 27, 2008
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
	
	int nSpellId = SPELLABILITY_HEARTWARD_LIPS_RAPTURE;
  	object oTarget = GetSpellTargetObject();	

	effect eAB = EffectAttackIncrease(2);
	effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_2);
	effect eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS,2);
	effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 2);
	
	effect eLink = EffectLinkEffects(eSave, eSkill);
	eLink = EffectLinkEffects(eLink, eDmg);
	eLink = EffectLinkEffects(eLink, eAB);	
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
			
	float fDuration = RoundsToSeconds( 5 );
	effect eKiss = EffectDazed();	
	
    RemoveEffectsFromSpell(oTarget, nSpellId);	
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKiss, oTarget, 6.0f);
	
}      
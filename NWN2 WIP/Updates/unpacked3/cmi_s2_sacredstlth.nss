//::///////////////////////////////////////////////
//:: Sacred Stealth
//:: cmi_s2_sacredstlth
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 8, 2007
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSkillDur = GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF);
	if (nSkillDur <= 0)
		nSkillDur = 1;
		
	effect eHide = EffectSkillIncrease(SKILL_HIDE,10);
	effect eMoveSilent = EffectSkillIncrease(SKILL_MOVE_SILENTLY,10);
	
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);

		
	effect eLink = EffectLinkEffects(eHide, eMoveSilent);
	eLink = EffectLinkEffects(eLink, eVis);	
	
	float fDuration = TurnsToSeconds( nSkillDur );
	fDuration = ApplyMetamagicDurationMods(fDuration);
		
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());	
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
	
}      
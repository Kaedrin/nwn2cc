//::///////////////////////////////////////////////
//:: Sirine's Grace
//:: cmi_s0_sirinegrce
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: October 8, 2007
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "x0_i0_spells"

void ApplyDeflectionAC(object oTarget, float fDuration, int nSpellId)
{
	int nChaMod = GetAbilityModifier(ABILITY_CHARISMA) + 2;
	effect eDeflAC = EffectACIncrease(nChaMod,AC_DEFLECTION_BONUS);
	eDeflAC = SetEffectSpellId(eDeflAC,nSpellId);
    DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeflAC, OBJECT_SELF, fDuration));
}

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	int nSpellId = GetSpellId();
	
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	
	effect eChaBonus = EffectAbilityIncrease(ABILITY_CHARISMA, 4);
	effect eDexaBonus = EffectAbilityIncrease(ABILITY_DEXTERITY, 4);
	effect ePerform = EffectSkillIncrease(SKILL_PERFORM,8);
		
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);	
	effect eLink = EffectLinkEffects(eChaBonus, eDexaBonus);
	eLink = EffectLinkEffects(eLink, ePerform);
	eLink = EffectLinkEffects(eLink, eVis);	
	
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));
	DelayCommand(0.3f, ApplyDeflectionAC(OBJECT_SELF, fDuration, nSpellId));
		
}  
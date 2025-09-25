//::///////////////////////////////////////////////
//:: Chasing Perfection
//:: cmi_s0_chaseperf
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 22, 2007
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "cmi_includes"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
  	object oTarget = GetSpellTargetObject();
	  	
	effect eCha = EffectAbilityIncrease(ABILITY_CHARISMA,4);
	effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH,4);
	effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY,4);	
	effect eWis = EffectAbilityIncrease(ABILITY_WISDOM,4);
	effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION,4);
	effect eInt = EffectAbilityIncrease(ABILITY_INTELLIGENCE,4);
				
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
 		
	effect eLink = EffectLinkEffects(eCha, eStr);
	eLink = EffectLinkEffects(eLink, eDex);
	eLink = EffectLinkEffects(eLink, eWis);	
	eLink = EffectLinkEffects(eLink, eInt);		
	eLink = EffectLinkEffects(eLink, eVis);	
		
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
		
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    RemoveEffectsFromSpell(oTarget, SPELL_BEARS_ENDURANCE);
    RemoveEffectsFromSpell(oTarget, SPELL_MASS_BEAR_ENDURANCE);	
				
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
	
	if ( GetCurrentHitPoints(oTarget) > GetMaxHitPoints(oTarget))
	{	
		effect eHeal = EffectHeal(1);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);	
	}	
	
    if (GetHasSpellEffect(SPELL_GREATER_BEARS_ENDURANCE, oTarget))
    {
		SendMessageToPC(oTarget, "You already have a stronger spell boosting your Constitution active. The Con boost from this spell was not applied.");	
        return;
    }	
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCon, oTarget, fDuration);	
	
}      
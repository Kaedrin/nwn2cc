//::///////////////////////////////////////////////
//:: Living Undeath
//:: cmi_s0_livundeath
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 22, 2007
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
	
  	object oTarget = GetSpellTargetObject();
	  	
	effect eCha = EffectAbilityDecrease(ABILITY_CHARISMA,4);
	effect eCritImmune = EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT);
	effect eSneakImmune = EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK);
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
 		
	effect eLink = EffectLinkEffects(eCha, eCritImmune);
	eLink = EffectLinkEffects(eLink, eSneakImmune);
	eLink = EffectLinkEffects(eLink, eVis);	
		
	
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
		
    RemoveEffectsFromSpell(oTarget, GetSpellId());	
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
	
}      
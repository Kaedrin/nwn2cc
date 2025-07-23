//::///////////////////////////////////////////////
//:: Draconic Might
//:: cmi_s0_dracmight
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: June 27, 2007
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
    	
	effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, 4);	
	effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, 4);
	effect eCha = EffectAbilityIncrease(ABILITY_CHARISMA, 4); 
	effect eNatAC = EffectACIncrease(4, AC_NATURAL_BONUS);
	effect eImmuneSleep = EffectImmunity(IMMUNITY_TYPE_SLEEP);
	effect eImmunePara = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_GREATER_HEROISM);
		
	effect eLink = EffectLinkEffects(eStr, eCon);
	eLink = EffectLinkEffects(eLink, eCha);
	eLink = EffectLinkEffects(eLink, eNatAC);
	eLink = EffectLinkEffects(eLink, eImmuneSleep);	
	eLink = EffectLinkEffects(eLink, eImmunePara);	
	eLink = EffectLinkEffects(eLink, eVis);	
	
	object oTarget = GetSpellTargetObject();	
	
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
		
    RemoveEffectsFromSpell(oTarget, GetSpellId());	
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
	effect eHeal = EffectHeal(1);
	if ( GetCurrentHitPoints(oTarget) > GetMaxHitPoints(oTarget))
	{	
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);	
	}	
}      
//::///////////////////////////////////////////////
//:: Mantle of Faith
//:: cmi_s0_mantlefaith
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
	  	
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = TurnsToSeconds( nCasterLvl ) * 10;
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	
	effect eSR = EffectSpellResistanceIncrease(12 + nCasterLvl); 
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);	
	effect eLink = EffectLinkEffects(eVis, eSR);

    RemoveEffectsFromSpell(oTarget, GetSpellId());	
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
	
}      
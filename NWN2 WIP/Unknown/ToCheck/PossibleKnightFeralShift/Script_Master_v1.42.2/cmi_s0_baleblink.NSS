//::///////////////////////////////////////////////
//:: Baleful Blink
//:: cmi_s0_baleblink
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
	if  (!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_ALL))
	{	
		
		int nSpellId = GetSpellId(); 	
		int nCasterLvl = GetCasterLevel(OBJECT_SELF);
		float fDuration = RoundsToSeconds(nCasterLvl);
		fDuration = ApplyMetamagicDurationMods(fDuration);
			
	    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_DISPLACEMENT);
		effect eMiss = EffectMissChance(50);	
		effect eASF = EffectArcaneSpellFailure(50);	
		effect eLink = EffectLinkEffects(eVis, eMiss);
		eLink = EffectLinkEffects(eLink, eASF);	
			
		RemoveEffectsFromSpell(oTarget, nSpellId);
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, TRUE));			
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);		  	
	}		
}      
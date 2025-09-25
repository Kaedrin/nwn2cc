//::///////////////////////////////////////////////
//:: Hand of Divinity
//:: cmi_s0_handdivinity
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 1, 2007
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
	
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	
	effect eSaveMod = EffectSavingThrowIncrease(SAVING_THROW_ALL, 2); 
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
	
	effect eLink = EffectLinkEffects(eVis, eSaveMod);	
	
    RemoveEffectsFromSpell(oTarget, GetSpellId());
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
		
}      
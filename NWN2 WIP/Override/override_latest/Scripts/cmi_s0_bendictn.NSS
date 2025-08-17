//::///////////////////////////////////////////////
//:: Benediction
//:: cmi_s0_bendictn
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
			
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = TurnsToSeconds(nCasterLvl) * 10;
	fDuration = ApplyMetamagicDurationMods(fDuration);
		
	effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 2);
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_PREMONITION );		
	effect eLink = EffectLinkEffects(eSave, eVis);	
		
	RemoveEffectsFromSpell(oTarget, nSpellId);	
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);		  	
	
	
}      
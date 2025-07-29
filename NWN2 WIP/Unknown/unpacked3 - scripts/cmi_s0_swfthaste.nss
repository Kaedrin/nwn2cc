//::///////////////////////////////////////////////
//:: Swift Haste
//:: cmi_s0_swfthaste
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
	float fDuration = RoundsToSeconds( d4() + 1 );
	fDuration = ApplyMetamagicDurationMods(fDuration);
		
	effect eHaste = EffectHaste();
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_HASTE );		
	effect eLink = EffectLinkEffects(eHaste, eVis);
	effect eAC = EffectACIncrease(4);
		
	RemoveEffectsFromSpell(oTarget, nSpellId);	
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);		  	
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, oTarget, RoundsToSeconds(1));	
	
}      
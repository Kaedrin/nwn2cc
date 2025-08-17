//::///////////////////////////////////////////////
//:: Halo of Sand
//:: cmi_s0_halosand
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 23, 2010
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
	
	int nSpellId = GetSpellId();  
	
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = TurnsToSeconds( nCasterLvl ) * 10;
	fDuration = ApplyMetamagicDurationMods(fDuration);
	
	int nBonus = nCasterLvl / 3;
	if (nBonus > 4)
		nBonus = 4;		
			
	effect eAC = EffectACIncrease(nBonus, AC_DEFLECTION_BONUS);	
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
	effect eLink = EffectLinkEffects(eAC, eVis);	
	
    RemoveEffectsFromSpell(OBJECT_SELF, nSpellId);	
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
	
}      
//::///////////////////////////////////////////////
//:: Blessing of Bahumut
//:: cmi_s0_blessbahumut
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: June 28, 2007
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
	
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);    	
	effect eDR = EffectDamageReduction(10, GMATERIAL_METAL_ADAMANTINE, 0, DR_TYPE_GMATERIAL);

	effect eLink = EffectLinkEffects(eVis, eDR);	
	
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
	
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());	
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
	
	
}      
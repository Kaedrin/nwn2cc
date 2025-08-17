//::///////////////////////////////////////////////
//:: Angelskin
//:: cmi_s0_angelskin
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
	
  	object oTarget = GetSpellTargetObject();
	  	
	effect eDamRes = EffectDamageResistance(DAMAGE_TYPE_NEGATIVE, 5, 0);	
	effect eDR = EffectDamageReduction(5, GMATERIAL_METAL_ADAMANTINE, 0, DR_TYPE_GMATERIAL);
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
		
	effect eLink = EffectLinkEffects(eVis, eDR);
	eLink = EffectLinkEffects(eLink, eDamRes);	
		
	
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
		

    RemoveEffectsFromSpell(oTarget, GetSpellId());	
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
	
}      
//::///////////////////////////////////////////////
//:: Lesser Energized Shield - Cold
//:: cmi_s0_lsrenrgshld_c
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 3, 2007
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
	
	int nSpellId = SPELL_Lesser_Energized_Shield;    	
	effect eDamShld = EffectDamageShield(0, DAMAGE_BONUS_1d4, DAMAGE_TYPE_COLD);
	effect eDamRes = EffectDamageResistance(DAMAGE_TYPE_COLD, 5, 0);	
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
		
	effect eLink = EffectLinkEffects(eDamRes, eDamShld);	
	eLink = EffectLinkEffects(eLink, eVis);	
	eLink = SetEffectSpellId(eLink, nSpellId);
		
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
		
	object oTarget = GetSpellTargetObject();
		
    RemoveEffectsFromSpell(oTarget, nSpellId);		
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
	
}      
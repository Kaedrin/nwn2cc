//::///////////////////////////////////////////////
//:: Sonic Shield
//:: cmi_s0_sonicshld
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 3, 2007
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    	
	effect eDamShld = EffectDamageShield(0, DAMAGE_BONUS_1d8, DAMAGE_TYPE_SONIC);
	effect eAC = EffectACIncrease(4,AC_DEFLECTION_BONUS);
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
		
	effect eLink = EffectLinkEffects(eAC, eDamShld);	
	eLink = EffectLinkEffects(eLink, eVis);	
	
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
		
	object oTarget = GetSpellTargetObject();
	
    RemoveEffectsFromSpell(oTarget, GetSpellId());		
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
	
}      
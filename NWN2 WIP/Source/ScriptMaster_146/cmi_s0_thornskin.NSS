//::///////////////////////////////////////////////
//:: Plant Body
//:: cmi_s0_plantbody
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 8, 2008
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
	
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	
	effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_1d6 , DAMAGE_TYPE_PIERCING);
	effect eDS = EffectDamageShield(5, 0, DAMAGE_TYPE_PIERCING);
		
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
	
	effect eLink = EffectLinkEffects(eVis, eDmg);
	eLink = EffectLinkEffects(eLink, eDS);				
	
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
		
}  
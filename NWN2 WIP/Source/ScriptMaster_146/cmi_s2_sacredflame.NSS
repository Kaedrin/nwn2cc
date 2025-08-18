//::///////////////////////////////////////////////
//:: Sacred Flame
//:: cmi_s2_sacredflame
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 3, 2007
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
	
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BLESS_WEAPON );
	effect eDamBonus = EffectDamageIncrease(DAMAGE_BONUS_1d6,DAMAGE_TYPE_FIRE);
	
	effect eLink = EffectLinkEffects(eVis,eDamBonus);
	eLink = SupernaturalEffect(eLink);
	
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(24));
	
}      
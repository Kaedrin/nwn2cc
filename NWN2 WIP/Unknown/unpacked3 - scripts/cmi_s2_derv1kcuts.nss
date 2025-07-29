//::///////////////////////////////////////////////
//:: Snowflake Wardance
//:: cmi_s2_derv1kcuts
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 29, 2009
//:://////////////////////////////////////////////

#include "x0_i0_spells"
#include "nwn2_inc_spells"

#include "cmi_ginc_chars"

void main()
{
		
	effect eSlash = EffectDamageIncrease(DAMAGE_BONUS_2d6, DAMAGE_TYPE_SLASHING);
	eSlash = SupernaturalEffect(eSlash);
	eSlash = SetEffectSpellId(eSlash, SPELLABILITY_THOUSAND_CUTS );	
	float fDuration = RoundsToSeconds(10);
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlash, OBJECT_SELF, fDuration));		
}
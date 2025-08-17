//::///////////////////////////////////////////////
//:: Blessing of the Righteous
//:: cmi_s0_blessright
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 1, 2007
//:://////////////////////////////////////////////

#include "x2_i0_spells"
#include "nwn2_inc_spells"

#include "cmi_ginc_chars"

void main()
{

	effect eVis = EffectVisualEffect(VFX_IMP_HEALING_S);
	int nHeal = GetHitDice(OBJECT_SELF) + GetAbilityModifier(ABILITY_CONSTITUTION);
	nHeal = nHeal * 2;
	effect eHeal = EffectHeal(nHeal);
		
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
	DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARBARIAN_RAGE);

}
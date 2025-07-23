//::///////////////////////////////////////////////
//:: Elemental Manifestation
//:: cmi_s2_elemmanif
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: May 13, 2008
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{

	int nSpellID = SPELLABILITY_ELEMWAR_MANIFESTATION;
		
    RemoveSpellEffects(nSpellID, OBJECT_SELF, OBJECT_SELF);
	
	effect eLink;
	
	if (GetHasFeat(FEAT_ELEMWAR_AFFINITY_AIR))
	{
		eLink = EffectConcealment(20, MISS_CHANCE_TYPE_VS_RANGED);
	}
	else
	if (GetHasFeat(FEAT_ELEMWAR_AFFINITY_EARTH))
	{	
		eLink =	EffectACIncrease(3, AC_NATURAL_BONUS);
	}
	else
	if (GetHasFeat(FEAT_ELEMWAR_AFFINITY_FIRE))
	{
		eLink = EffectDamageShield(0, DAMAGE_BONUS_1d6, DAMAGE_TYPE_FIRE);
	}
	else
	if (GetHasFeat(FEAT_ELEMWAR_AFFINITY_WATER))
	{
		eLink =	EffectDamageReduction(3, DAMAGE_TYPE_PIERCING, 0, DR_TYPE_DMGTYPE);
	}
		
    effect eDur = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);	
	eLink = EffectLinkEffects(eDur, eLink);	
	eLink = SupernaturalEffect(eLink);
	eLink = SetEffectSpellId(eLink, nSpellID);
		
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(10)));
		
}
//::///////////////////////////////////////////////
//:: Elemental Shield
//:: cmi_s2_elemshield
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: May 13, 2008
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{

	int nSpellID = ELEM_ARCHER_ELEM_SHIELD;
	int nDamageType = 0;	
	int nLevel = GetLevelByClass(CLASS_ELEM_ARCHER, OBJECT_SELF);
		
    RemoveSpellEffects(nSpellID, OBJECT_SELF, OBJECT_SELF);
	
	if (GetHasFeat(FEAT_ELEM_ARCHER_PATH_AIR))
		nDamageType = DAMAGE_TYPE_ELECTRICAL;
	else
	if (GetHasFeat(FEAT_ELEM_ARCHER_PATH_EARTH))
		nDamageType = DAMAGE_TYPE_ACID;
	else
	if (GetHasFeat(FEAT_ELEM_ARCHER_PATH_FIRE))
		nDamageType = DAMAGE_TYPE_FIRE;
	else
	if (GetHasFeat(FEAT_ELEM_ARCHER_PATH_WATER))
		nDamageType = DAMAGE_TYPE_COLD;
		
	int nDuration = GetAbilityModifier(ABILITY_CONSTITUTION);
	if (nDuration < 0)
		nDuration = 0;
	nDuration += nLevel;
	
	int nBonus = nLevel/2;
	if (nLevel == 5)
		nBonus = 3;
		
	if (GetHasFeat(FEAT_ELEM_ARCHER_IMP_ELEM_SHIELD))
	{
		nBonus = nLevel;
		nDuration = nDuration * 2;
	}
		
	effect eDS = EffectDamageShield(nBonus, DAMAGE_BONUS_1d4, nDamageType);
	effect eAC = EffectACIncrease(nBonus);
    effect eDur = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
	effect eLink = EffectLinkEffects(eAC, eDS);	
	eLink = EffectLinkEffects(eDur, eLink);	
	eLink = SupernaturalEffect(eLink);
	eLink = SetEffectSpellId(eLink, nSpellID);
		
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration)));
		
}
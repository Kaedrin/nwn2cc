//::///////////////////////////////////////////////
//:: Elemental Shot
//:: cmi_s2_elemshot
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: May 12, 2008
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{

	int nSpellID = ELEM_ARCHER_ELEM_SHOT;
	int bHasEffects = GetHasSpellEffect(nSpellID, OBJECT_SELF);		
	
    RemoveSpellEffects(nSpellID, OBJECT_SELF, OBJECT_SELF);
	
	if (IsElemArcherStateValid())
	{
		int nRaceBonus = 0;
		int nDamageType = DAMAGE_TYPE_PIERCING;
		int nLevel = GetLevelByClass(CLASS_ELEM_ARCHER, OBJECT_SELF);
			
		if (GetHasFeat(FEAT_ELEM_ARCHER_PATH_AIR))
		{
			if (GetSubRace(OBJECT_SELF) == RACIAL_SUBTYPE_AIR_GENASI)
				nRaceBonus = 2;
			nDamageType = DAMAGE_TYPE_ELECTRICAL;
		}
		else
		if (GetHasFeat(FEAT_ELEM_ARCHER_PATH_EARTH))
		{
			if (GetSubRace(OBJECT_SELF) == RACIAL_SUBTYPE_EARTH_GENASI)
				nRaceBonus = 2;
			nDamageType = DAMAGE_TYPE_ACID;
		}
		else
		if (GetHasFeat(FEAT_ELEM_ARCHER_PATH_FIRE))
		{
			if (GetSubRace(OBJECT_SELF) == RACIAL_SUBTYPE_FIRE_GENASI)
				nRaceBonus = 2;
			nDamageType = DAMAGE_TYPE_FIRE;
		}
		else
		if (GetHasFeat(FEAT_ELEM_ARCHER_PATH_WATER))
		{
			if (GetSubRace(OBJECT_SELF) == RACIAL_SUBTYPE_WATER_GENASI)
				nRaceBonus = 2;
			nDamageType = DAMAGE_TYPE_COLD;
		}
		
		int nDAMAGE_BONUS = GetDamageBonusByValue(nLevel + nRaceBonus);
		effect eLink = EffectDamageIncrease(nDAMAGE_BONUS, nDamageType);
		
		if (nLevel > 3)
		{
			effect eAB = EffectAttackIncrease(2);
			eLink = EffectLinkEffects(eAB, eLink);
		}
		else
		if (nLevel > 1)
		{
			effect eAB = EffectAttackIncrease(1);
			eLink = EffectLinkEffects(eAB, eLink);
		}
		
		eLink = SupernaturalEffect(eLink);
		eLink = SetEffectSpellId(eLink, nSpellID);
		
		DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellID, DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF));
		
		if (!bHasEffects)								
			SendMessageToPC(OBJECT_SELF,"Elemental Shot enabled.");
			
	
	}
	else
	{
		SendMessageToPC(OBJECT_SELF,"Elemental Shot disabled.  You must use a ranged or thrown weapon for this ability to work.");
		return;	
	}	

}
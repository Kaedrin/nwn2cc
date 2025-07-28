//::///////////////////////////////////////////////
//:: Battle Dancer
//:: cmi_s2_battledancer
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 12, 2008
//:://////////////////////////////////////////////

#include "cmi_ginc_chars"

void main()
{

	int nSpellId = SPELLABILITY_BATTLE_DANCER;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	effect eAB = EffectAttackIncrease(2);
	eAB = SetEffectSpellId(eAB, SPELLABILITY_BATTLE_DANCER);
	eAB = SupernaturalEffect(eAB);
	
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, OBJECT_SELF, HoursToSeconds(48));

	
}
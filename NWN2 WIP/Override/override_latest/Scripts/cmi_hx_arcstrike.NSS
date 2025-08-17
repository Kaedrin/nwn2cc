//::///////////////////////////////////////////////
//:: Arcane Strike
//:: cmi_hx_arcstrike
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 17, 2011
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"

void main()
{

	int nSpellId = SPELLABILITY_HEX_ARCANE_STRIKE;
	RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);	
	int nBonus = 2;
	
	int nLevel = GetLevelByClass(CLASS_HEXBLADE, OBJECT_SELF);
	if (GetHitDice(OBJECT_SELF) == nLevel)
	{
		nBonus = 1 + (nLevel / 5);
		if (nBonus < 2)
			nBonus = 2;
	}
	
	effect eLink = EffectDamageIncrease(nBonus);
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);						
	DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(48)));	
	
}
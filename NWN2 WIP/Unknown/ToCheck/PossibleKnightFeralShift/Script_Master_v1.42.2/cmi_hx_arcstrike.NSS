//::///////////////////////////////////////////////
//:: Arcane Strike
//:: cmi_hx_arcstrike
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 27, 2011
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"

void main()
{
/*
	int nSpellId = SPELLABILITY_HEX_ARCANE_STRIKE;

	RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);	

	int nCha = GetAbilityModifier(ABILITY_CHARISMA);
	if (nCha < 1)
		nCha = 1;

    int nLevel = GetLevelByClass(CLASS_HEXBLADE, OBJECT_SELF);
	nLevel = nLevel / 5;		

	effect eLink = EffectDamageIncrease(nLevel);
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
							
	DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nCha)));
*/

	int nSpellId = SPELLABILITY_HEX_ARCANE_STRIKE;

	RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);	
	effect eLink = EffectDamageIncrease(2);
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);						
	DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(48)));	
	
}
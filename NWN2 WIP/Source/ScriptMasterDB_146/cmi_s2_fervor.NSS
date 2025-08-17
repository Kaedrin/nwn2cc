//::///////////////////////////////////////////////
//:: Templar - Fervor
//:: cmi_s2_fervor
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 16, 2009
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{

	int nSpellId = SPELLABILITY_TEMPLAR_FERVOR;

	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);	
	
	int nBonus = GetLevelByClass(CLASS_TEMPLAR) / 2;
	if (nBonus > 5) //Correctly cap the bonus at 10 levels of Templar
		nBonus = 5;
	effect eSave1 = EffectSavingThrowIncrease(SAVING_THROW_FORT, nBonus);
	effect eSave2 = EffectSavingThrowIncrease(SAVING_THROW_WILL, nBonus);
	effect eLink = EffectLinkEffects(eSave1, eSave2);					
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
		
	DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(48)));		
}
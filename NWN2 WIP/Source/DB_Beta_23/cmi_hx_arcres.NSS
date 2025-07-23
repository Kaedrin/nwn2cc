//::///////////////////////////////////////////////
//:: Arcane Resistance
//:: cmi_hx_arcres
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 27, 2011
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"

void main()
{
	int nSpellId = SPELLABILITY_HEX_ARCRES;

	RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);	
	RemoveSpellEffects(SPELL_I_DARK_ONES_OWN_LUCK, OBJECT_SELF, OBJECT_SELF);	

	int nCha = GetAbilityModifier(ABILITY_CHARISMA);
	if (nCha < 1)
		nCha = 1;

    int nLevel = GetLevelByClass(CLASS_HEXBLADE, OBJECT_SELF);
	if (nCha > nLevel)
		nCha = nLevel;			
		
	if (GetHasFeat(FEAT_PRESTIGE_DARK_BLESSING))
	{	
		nCha = 0; // No stacking with Dark Blessing.
	}			
		
	if (nLevel > 3) //Mettle, temporary +4 to all
	{
		int nHD = GetHitDice(OBJECT_SELF);
		if (nLevel >= (nHD/2))
			nCha += 4;		
	}

	effect eLink = EffectSavingThrowIncrease(SAVING_THROW_ALL, nCha);	
	
	if (nLevel > 12)
	{
		if (GetHasFeat(FEAT_HEXBLADE_PRACTICED_CASTER, OBJECT_SELF))
		{
			int nSR = 10 + nLevel;
			if (GetHasFeat(FEAT_SPELLCASTING_PRODIGY, OBJECT_SELF))
				nSR += 4;
			effect eSR = EffectSpellResistanceIncrease(nSR);
			eLink = EffectLinkEffects(eLink, eSR);
		}
		
	
	}
				
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
				
	DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(48)));
}
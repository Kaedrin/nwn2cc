//::///////////////////////////////////////////////
//:: Eldritch Disciple, Damage Reduction
//:: cmi_s2_giftdr
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 2, 2009
//:://////////////////////////////////////////////

#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	  
	object oPC = OBJECT_SELF;
	int nSpellId = SPELLABILITY_ELDDISC_DR;	
	
	if (GetHasSpellEffect(nSpellId,oPC))
		RemoveSpellEffects(nSpellId, oPC, oPC);	

	int nAmount = (GetLevelByClass(CLASS_ELDRITCH_DISCIPLE, oPC) + 1) / 2;	
	int nLevel = GetLevelByClass(CLASS_TYPE_WARLOCK, oPC);
	if (nLevel > 2)
	{
		nAmount += (1 + ((nLevel - 3)/4));
	}
	
		if (GetHasFeat(494))
		{
			nAmount += 9;
		}
		else
		if (GetHasFeat(493))
		{
			nAmount += 6;
		}	
		else
		if (GetHasFeat(492))
		{
			nAmount += 3;
		}
		
		if (GetHasFeat(1253))
			nAmount++;		
			
		//Fey Skin line
		if (GetHasFeat(2184))
		{
			nAmount++;
			if (GetHasFeat(2181))
				nAmount++;	
			if (GetHasFeat(2182))
				nAmount++;	
			if (GetHasFeat(2183))
				nAmount++;										
		}						
			
	effect eDR = EffectDamageReduction(nAmount, GMATERIAL_METAL_COLD_IRON, 0, DR_TYPE_GMATERIAL);
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);	
	effect eLink = EffectLinkEffects(eVis, eDR);
		
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
		
	int nDuration = 3 + GetAbilityModifier(ABILITY_CHARISMA);
	if (nDuration <=0)
		nDuration = 1;
	float fDuration = RoundsToSeconds( nDuration );
			
	SignalEvent(oPC, EventSpellCastAt(oPC, nSpellId, FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, fDuration);
	DecrementRemainingFeatUses(oPC, 294);
}      
//::///////////////////////////////////////////////
//:: Dark Companion Enter
//:: cmi_hx_darkcompa
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 27, 2011
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "cmi_ginc_spells"

void main()
{

	object oTarget = GetEnteringObject();
	object oCaster = GetAreaOfEffectCreator();

	int iHasFeat = GetHasFeat(FEAT_HEXBLADE_EPIC_DARK_COMPANION,oCaster);	
	int nPenalty = 2;
	if (iHasFeat == TRUE)
		nPenalty = 4;
	
	effect eSavePenalty = EffectSavingThrowDecrease(SAVING_THROW_ALL, nPenalty);
	effect eACPenalty = EffectACDecrease(nPenalty);
	effect eLink = EffectLinkEffects(eSavePenalty, eACPenalty);
	eLink = SetEffectSpellId(eLink,SPELLABILITY_DARK_COMPANION);
	eLink = SupernaturalEffect(eLink);
	
	// Doesn't work on self
	if (oTarget != oCaster)
	{
		SignalEvent (oTarget, EventSpellCastAt(oCaster, SPELLABILITY_DARK_COMPANION, FALSE));		

	    //Faction Check
		if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCaster))
		{
			if (!GetHasSpellEffect(SPELLABILITY_DARK_COMPANION,oTarget))		
	        	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(24));			
		}
	}
}
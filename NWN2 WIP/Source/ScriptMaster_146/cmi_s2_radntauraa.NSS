//::///////////////////////////////////////////////
//:: Radiant Aura OnEnter
//:: cmi_s2_radntauraA
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 12, 2007
//:://////////////////////////////////////////////
//:: Based on Aura of Despair

#include "x0_i0_spells"
#include "x2_inc_spellhook"

#include "cmi_ginc_spells"

void main()
{
	object oTarget = GetEnteringObject();
	object oCaster = GetAreaOfEffectCreator();

	effect eABPenalty = EffectAttackDecrease(2);
	effect eACPenalty = EffectACDecrease(2);
	effect eSavePenalty = EffectSavingThrowDecrease(SAVING_THROW_ALL, 2);
	
	effect eLink = EffectLinkEffects(eABPenalty, eACPenalty);
	eLink = EffectLinkEffects(eSavePenalty, eLink);
	eLink = SupernaturalEffect(eLink);
	eLink = SetEffectSpellId(eLink, SPELLABILITY_MASTER_RADIANCE_RADIANT_AURA);
	
	// Doesn't work on self
	if (oTarget != oCaster)
	{
		SignalEvent (oTarget, EventSpellCastAt(oCaster, SPELLABILITY_MASTER_RADIANCE_RADIANT_AURA, FALSE));		

	    //Faction Check
		if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCaster))
		{
	        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(1));			
		}
	}
}
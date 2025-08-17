//::///////////////////////////////////////////////
//:: Trip Vine - OnEnter
//:: cmi_s0_tripvinea
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 23, 2010
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

#include "cmi_ginc_spells"

void main()
{
	int nDC = GetSpellSaveDC();
	if (nDC >= 100)
	{
		nDC = GetLocalInt(GetAreaOfEffectCreator(), "DC2102");
		if (nDC == 0)
			nDC = 15;
	}
	
    //Declare major variables
    effect eKD = EffectKnockdown();
    effect eVis = EffectVisualEffect(VFX_DUR_WEB);
    effect eLink = EffectLinkEffects(eKD, eVis);
    object oTarget = GetEnteringObject();

    if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, GetAreaOfEffectCreator()))
    {
        if( (GetCreatureFlag(oTarget, CREATURE_VAR_IS_INCORPOREAL) != TRUE) )	// AFW-OEI 05/01/2006: Woodland Stride no longer protects from spells.
        {
		
			if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC))
			{
	            //Fire cast spell at event for the target
	            SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_BRIAR_WEB));
	
				//Entangle effect and Web VFX impact
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(1));
			}
		}
    }
}
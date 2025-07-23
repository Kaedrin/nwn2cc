//::///////////////////////////////////////////////
//:: Caustic Web - OnEnter
//:: cmi_s0_causweba
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 10, 2010
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

#include "cmi_ginc_spells"

void main()
{

    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_DUR_WEB);
	effect eAcidDmg = EffectDamage(d6(2), DAMAGE_TYPE_ACID);
    object oTarget = GetEnteringObject();
    effect eSlow = EffectMovementSpeedDecrease(50);
	
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
    {
        if( (GetCreatureFlag(oTarget, CREATURE_VAR_IS_INCORPOREAL) != TRUE) )	// AFW-OEI 05/01/2006: Woodland Stride no longer protects from spells.
        {
            //Fire cast spell at event for the target
            SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_I_CAUSTIC_MIRE));
            DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, RoundsToSeconds(1)));
			DelayCommand(0.02, ApplyEffectToObject(DURATION_TYPE_INSTANT, eAcidDmg, oTarget));	
            DelayCommand(0.03, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oTarget));							
        }
    }
}
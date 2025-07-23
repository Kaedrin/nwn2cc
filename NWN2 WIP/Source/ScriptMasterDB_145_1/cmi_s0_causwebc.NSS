//::///////////////////////////////////////////////
//:: Caustic Web - Heartbeat
//:: cmi_s0_causwebc
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
	effect eDmg;
	
    object oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        if( (GetCreatureFlag(oTarget, CREATURE_VAR_IS_INCORPOREAL) != TRUE) )	// AFW-OEI 05/01/2006: Woodland Stride no longer protects from spells.
        {
            if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
            {
                SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_I_CAUSTIC_MIRE));
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_I_CAUSTIC_MIRE));
				eDmg = EffectDamage(d6(1), DAMAGE_TYPE_ACID);
				
				DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget));
                DelayCommand(0.02, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, RoundsToSeconds(1)));
            }
        }
        oTarget = GetNextInPersistentObject();
    }
}
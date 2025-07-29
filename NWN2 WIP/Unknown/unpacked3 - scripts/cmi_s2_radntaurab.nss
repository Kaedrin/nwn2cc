//::///////////////////////////////////////////////
//:: Radiant Aura OnExit
//:: cmi_s2_radntauraB
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 12, 2007
//:://////////////////////////////////////////////
//:: Based on Aura of Despair

#include "cmi_includes"
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{	
	//SpeakString("nw_s2_auradespairB.nss: On Exit: function entry");

    object oTarget = GetExitingObject();
	object oCaster = GetAreaOfEffectCreator();

    //Search through the valid effects on the target.
    effect eAOE = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eAOE))
    {
        // If the effect was created by the Protective Aura then remove it,
		// but only if it's not the caster himself.
        if ((GetEffectCreator(eAOE) == oCaster) &&
			(GetEffectSpellId(eAOE) == SPELLABILITY_MASTER_RADIANCE_RADIANT_AURA) &&
			(oTarget != oCaster))
        {
			//SpeakString("nw_s2_auradespairB.nss: On Exit: removing effect");
            RemoveEffect(oTarget, eAOE);
        }

        eAOE = GetNextEffect(oTarget);
    }
}
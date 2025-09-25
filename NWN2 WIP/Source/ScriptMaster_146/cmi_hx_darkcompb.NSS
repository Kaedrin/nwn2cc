//::///////////////////////////////////////////////
//:: Dark Companion Exit
//:: cmi_hx_darkcompb
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 27, 2011
//:://////////////////////////////////////////////

#include "cmi_ginc_chars"
#include "x2_inc_spellhook"

void main()
{	

    object oTarget = GetExitingObject();
	object oCaster = GetAreaOfEffectCreator();

    //Search through the valid effects on the target.
    effect eAOE = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eAOE))
    {
        if ((GetEffectCreator(eAOE) == oCaster) &&
			(GetEffectSpellId(eAOE) == SPELLABILITY_DARK_COMPANION) &&
			(oTarget != oCaster))
        {
            RemoveEffect(oTarget, eAOE);
        }

        eAOE = GetNextEffect(oTarget);
    }
	
}
//::///////////////////////////////////////////////
//:: Caustic Web - OnExit
//:: cmi_s0_causwebb
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 10, 2010
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "cmi_includes"

void main()
{

    //Get the object that is exiting the AOE
    object oTarget = GetExitingObject();
    //PrintString("SPELL DEBUG STRING ********** " + "Entering Web On Exit" + GetName(oTarget));
    //int bValid = FALSE;
    //Search through the valid effects on the target.
    effect eAOE = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eAOE))// && bValid == FALSE)
    {
        //If the effect was created by the Web then remove it
        if (GetEffectCreator(eAOE) == GetAreaOfEffectCreator())
        {
            if(GetEffectSpellId(eAOE) == SPELL_I_CAUSTIC_MIRE)
            {
                RemoveEffect(oTarget, eAOE);
            }
        }
        eAOE = GetNextEffect(oTarget);
    }
}
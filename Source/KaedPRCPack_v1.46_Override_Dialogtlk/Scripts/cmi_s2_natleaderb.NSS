//::///////////////////////////////////////////////
//:: Natural Leader Fix - OnEExit
//:: cmi_s2_natleaderc
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 31, 2011
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "cmi_includes"

void main()
{

    //Get the object that is exiting the AOE
    object oTarget = GetExitingObject();
	object oCreator = GetAreaOfEffectCreator();
	
    //Search through the valid effects on the target.
    effect eAOE = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eAOE))// && bValid == FALSE)
    {
        //If the effect was created by the Web then remove it
        if (GetEffectCreator(eAOE) == oCreator)
        {
            if(GetEffectSpellId(eAOE) == NATURAL_LEADER_FIX)
            {
                RemoveEffect(oTarget, eAOE);
            }
        }
        eAOE = GetNextEffect(oTarget);
    }
}
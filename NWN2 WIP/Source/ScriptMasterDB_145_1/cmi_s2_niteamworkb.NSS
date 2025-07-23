//::///////////////////////////////////////////////
//:: Teamwork (Nightsong Infiltrator)
//:: cmi_s2_niteamworkb
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 8, 2007
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "cmi_includes"

void main()
{	

    object oTarget = GetExitingObject();
	object oCaster = GetAreaOfEffectCreator();

    //Search through the valid effects on the target.
	
	
	if 	(oTarget != oCaster)
	{
    	effect eAOE = GetFirstEffect(oTarget);	
	    while (GetIsEffectValid(eAOE))
	    {
	        if ((GetEffectCreator(eAOE) == oCaster) &&
				(GetEffectSpellId(eAOE) == SPELL_SPELLABILITY_AURA_NI_TEAMWORK))
	        {
	            RemoveEffect(oTarget, eAOE);
	        }
	
	        eAOE = GetNextEffect(oTarget);
	    }
	}
}
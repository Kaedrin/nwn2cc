//::///////////////////////////////////////////////
//:: Darkness: On Exit
//:: NW_S0_DarknessB.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a globe of darkness around those in the area
    of effect.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 28, 2002
//:://////////////////////////////////////////////
#include "X0_I0_SPELLS"

#include "x2_inc_spellhook"
#include "cmi_includes"

void main()
{

    object oTarget = GetExitingObject();
    object oCreator = GetAreaOfEffectCreator();
	// 

    int bValid = FALSE;
    effect eAOE;
    //Search through the valid effects on the target.
    eAOE = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eAOE))
    {
        if (GetEffectCreator(eAOE) == oCreator)
        {
            int nID = GetEffectSpellId(eAOE);
            //If the effect was created by the spell then remove it
           if( nID == SPELL_DARKNESS || nID == SPELLABILITY_AS_DARKNESS  || nID == SPELL_SHADOW_CONJURATION_DARKNESS || nID == 688 || nID == 810 || nID == 941 || nID == SPELL_ASN_Darkness || nID == SPELL_ASN_Spellbook_2 || nID == SPELL_BG_Darkness )
           {
                RemoveEffect(oTarget, eAOE);
           }
        }
        //Get next effect on the target
        eAOE = GetNextEffect(oTarget);
    }



}
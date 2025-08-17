//::///////////////////////////////////////////////
//:: Blade Barrier, Self : On Exit
//:: NW_S0_BladeBarSelfB.nss
//:://////////////////////////////////////////////
/*
    This script makes sure that immobilization gets
    removed from the caster if blades are dispelled.
*/
//:://////////////////////////////////////////////
//:: Created By: RPGplayer1
//:: Created On: March 19, 2008
//:://////////////////////////////////////////////

void main()
{


    //Declare major variables
    //Get the object that is exiting the AOE
    object oTarget = GetExitingObject();
    int bValid = FALSE;
    effect eAOE;
    if(GetHasSpellEffect(SPELL_BLADE_BARRIER_SELF, oTarget))
    {
        //Search through the valid effects on the target.
        eAOE = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eAOE) && bValid == FALSE)
        {
            if (GetEffectCreator(eAOE) == GetAreaOfEffectCreator())
            {
                if(GetEffectType(eAOE) == EFFECT_TYPE_CUTSCENEIMMOBILIZE)
                {
                    //If the effect was created by the Blade Barrier then remove it
                    if(GetEffectSpellId(eAOE) == SPELL_BLADE_BARRIER_SELF)
                    {
                        RemoveEffect(oTarget, eAOE);
                        bValid = TRUE;
                    }
                }
            }
            //Get next effect on the target
            eAOE = GetNextEffect(oTarget);
        }
    }
}
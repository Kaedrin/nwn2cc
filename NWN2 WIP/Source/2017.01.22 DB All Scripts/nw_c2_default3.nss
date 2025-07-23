// hcr3.1
// added code so creatures stop attacking dying pcs sometimes.
//    if it was consistent i would toggle it.
//::///////////////////////////////////////////////
//:: Default: End of Combat Round
//:: NW_C2_DEFAULT3
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calls the end of combat script every round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void main()
{
    if  (GetIsDead(GetAttackTarget())) //see below
        {                              //..
        ClearAllActions();             //..
        DetermineCombatRound();        //..
        }                              //..
    else if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
        {
        DetermineSpecialBehavior();
        }
        else if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
        {
        DetermineCombatRound();
        }
        if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
        {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
        }
}
/*Bio screwed up the A.I.-- big time. Attacking creatures--no re-evaluate of target
if it's dying.  There is a check in the DetermineCombatRound() function,
but it only does a "return;" if the target is dead or dying. This means the
creature continues its current action of attacking.  Digging around in Bio A.I.
is like swimming in tar now-- commented out, comment back in, moved this here,
moved this there, etc.  For now, best to make the fix here as it's easy to track
and you can bet they will screw things up again in the A.I. files with patches or
expansions. Break, fix, break fix, break, fix, ad nauseam....
--Heed.*/





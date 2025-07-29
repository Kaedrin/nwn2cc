//::///////////////////////////////////////////////
//:: Default On Damaged
//:: NW_C2_DEFAULT6
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If already fighting then ignore, else determine
    combat round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

#include "hench_i0_ai"
#include "ginc_behavior"
#include "hv_cq_inc"
#include "nwnx_clock"

void main()
{
    int iFocused = GetIsFocused();
	
	// I've been damaged so no longer partially focused
	if (iFocused == FOCUSED_PARTIAL)
	{
		SetLocalInt(OBJECT_SELF, VAR_FOCUSED, FOCUSED_STANDARD); // no longer focused
	}
    if (iFocused == FOCUSED_FULL)
	{
        // remain focused
    }
	else if(GetFleeToExit())
	{
        // We're supposed to run away, do nothing
    }
    else if (GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
        // don't do anything?
    }
    else
    {
        object oDamager = GetLastDamager();
        if (!GetIsObjectValid(oDamager))
        {
        // don't do anything, we don't have a valid damager
        }
        else if (!GetIsFighting(OBJECT_SELF))
        {
            if ((GetLocalInt(OBJECT_SELF, HENCH_HEAL_SELF_STATE) == HENCH_HEAL_SELF_WAIT) &&
                (GetPercentageHPLoss(OBJECT_SELF) < 30))
            {
                // force heal
                HenchDetermineCombatRound(OBJECT_INVALID, TRUE);
            }
            else if (!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
            {
//    Jug_Debug(GetName(OBJECT_SELF) + " responding to damage");
                if (GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
                {
                    HenchDetermineSpecialBehavior(oDamager);
                }
                else
                {
                    HenchDetermineCombatRound(oDamager);
                }
            }
        }
    }
    if(GetSpawnInCondition(NW_FLAG_DAMAGED_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DAMAGED));
    }
	
	
	// Heal damage
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(9000), OBJECT_SELF);
	
	// Check if anyone was seen yet, more than 1 second ago.
	int nPCSeenTime = GetLocalInt(OBJECT_SELF, PC_SEEN_TIME);
	int nTimePassed = 100;
	if (nPCSeenTime > 0)
		nTimePassed = GetUNIXTime() - nPCSeenTime;
		
	if ((GetLocalInt(OBJECT_SELF, PC_SEEN) == TRUE) && (nTimePassed > 1))
		return;
	
	if (GetLocalInt(OBJECT_SELF, ATTACKED) == TRUE)
		return;
	
	object oPC = GetLastDamager();
	
	// Distance check
	if (GetDistanceBetween(OBJECT_SELF, oPC) >= FeetToMeters(30.0f)) {		
		SetLocalInt(OBJECT_SELF, ATTACKED, TRUE);
		return;
	}
	
	// Sneak attack feats check
	if ((GetHasFeat(FEAT_SNEAK_ATTACK, oPC, TRUE))
		||
		(GetHasFeat(FEAT_BLACKGUARD_SNEAK_ATTACK_1D6, oPC, TRUE))
		||
		(GetHasFeat(1497, oPC, TRUE)) // NWN9 sneak attack
		||
		(GetHasFeat(1502, oPC, TRUE)) // Arcane Trickster sneak attack
		||
		(GetHasFeat(1562, oPC, TRUE)) // Shadow thief sneak attack
		||
		(GetHasFeat(455, oPC, TRUE))) // Death attack
	{
		// One hit kill!
		PCKillGuard(oPC, OBJECT_SELF);
	}
	else
		SetLocalInt(OBJECT_SELF, ATTACKED, TRUE);
}
// If the crystals and monsters were slain
// and magic missile is cast on the boss, destroy the barriers (visual effects)
// and make it mortal.

//::///////////////////////////////////////////////
//:: Default: On Spell Cast At
//:: NW_C2_DEFAULTB
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This determines if the spell just cast at the
    target is harmful or not.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 6, 2001
//:://////////////////////////////////////////////

#include "hench_i0_ai"
#include "ginc_behavior"
#include "hv_cq_inc"

void main()
{

	// Check if barrier is vulnerable yet
	if (GetLocalInt(GetArea(OBJECT_SELF), BOSS_VULNERABLE) == FALSE)
		return;
	
	if (GetLocalInt(OBJECT_SELF, SHIELD_REMOVED) == FALSE) {	
		object oPC = GetLastSpellCaster();
		int nSpellID = GetLastSpell();
		
		// Make sure it's an arcane user
		if (!GetHasArcaneClass(oPC))
			return;
			
		// Make sure it's magic missile
		if (nSpellID == SPELL_MAGIC_MISSILE) {
			RemoveBossShield();
			SetLocalInt(OBJECT_SELF, SHIELD_REMOVED, TRUE);
		}
	}
	
    int iFocused = GetIsFocused();

	// spell cast at me so no longer partially focused
	if (iFocused == FOCUSED_PARTIAL)
	{
		SetLocalInt(OBJECT_SELF, VAR_FOCUSED, FOCUSED_STANDARD); // no longer focused
	}

    if (iFocused == FOCUSED_FULL)
	{
        // remain focused
    }
    else if(GetLastSpellHarmful())
    {
		object oCaster = GetLastSpellCaster();
       // ------------------------------------------------------------------
        // If I was hurt by someone in my own faction
        // Then clear any hostile feelings I have against them
        // After all, we're all just trying to do our job here
        // if we singe some eyebrow hair, oh well.
        // ------------------------------------------------------------------
        if (GetFactionEqual(oCaster, OBJECT_SELF))
        {
            ClearPersonalReputation(oCaster, OBJECT_SELF);
            // Send the user-defined event as appropriate
            if(GetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT))
            {
                SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_SPELL_CAST_AT));
            }
            return;
        }
		CheckRemoveStealth();
        if(!GetIsFighting(OBJECT_SELF) && GetIsValidRetaliationTarget(oCaster))
        {
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
            {
                HenchDetermineSpecialBehavior(oCaster);
            }
            else
            {
                HenchDetermineCombatRound(oCaster);
            }
        }
    }
    if(GetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_SPELL_CAST_AT));
    }
}
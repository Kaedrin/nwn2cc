//::///////////////////////////////////////////////
//:: Sacred Stealth
//:: cmi_s2_sacredstlth
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 8, 2007
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
//#include "x0_i0_spells"

void main()
{
    if (!X2PreSpellCastCode())
    {   // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    
    // Does not stack with itself.
    if (!GetHasSpellEffect(GetSpellId(), OBJECT_SELF))
    {
	
		int nChaBonus = GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF);
		if (nChaBonus < 0)
			nChaBonus = 0;
		int nHeal = d6(3) + nChaBonus;
		 
        effect eHP = EffectHealOnZeroHP(OBJECT_SELF, nHeal);
        eHP = ExtraordinaryEffect(eHP); // Make it not dispellable.
    
        //Fire cast spell at event for the specified target
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    
        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHP, OBJECT_SELF);
    }
}   
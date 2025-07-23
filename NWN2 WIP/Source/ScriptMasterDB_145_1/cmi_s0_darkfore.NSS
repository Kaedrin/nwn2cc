//::///////////////////////////////////////////////
//:: Dark Foresight
//:: cmi_s0_darkfore
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 10, 2010
//:://////////////////////////////////////////////

#include "nw_i0_spells"
#include "x2_inc_spellhook" 
#include "cmi_ginc_spells"
#include "noc_warlock_corruption"

void main()
{

    if (!X2PreSpellCastCode())
    {
	    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	AddCorruption(OBJECT_SELF, 9);
	
    object oTarget = GetSpellTargetObject();
	object oLastTarget = GetLocalObject(OBJECT_SELF, "LastDarkForeTgt");
	
	if (GetIsObjectValid(oLastTarget))
	{
		if (GetHasSpellEffect(GetSpellId(), oLastTarget) && (oLastTarget != OBJECT_SELF))
			SendMessageToPC(oLastTarget, "Your Dark Foresight has been given to another.");
		RemoveEffectsFromSpell(oLastTarget, GetSpellId());
	}
	RemoveEffectsFromSpell(oTarget, GetSpellId());
	
    //Declare major variables
    int nDuration = GetWarlockCasterLevel(OBJECT_SELF) * 10;

	effect eAC = EffectACIncrease(2);
	effect eSave = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, 2);
	effect eImm = EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK);
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_PREMONITION );	// NWN2 VFX
    effect eLink = EffectLinkEffects(eAC, eSave);
	eLink = EffectLinkEffects(eLink, eImm);
	eLink = EffectLinkEffects(eLink, eVis);
   
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	
    //Apply the linked effect
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
	SetLocalObject(OBJECT_SELF, "LastDarkForeTgt", oTarget);
}
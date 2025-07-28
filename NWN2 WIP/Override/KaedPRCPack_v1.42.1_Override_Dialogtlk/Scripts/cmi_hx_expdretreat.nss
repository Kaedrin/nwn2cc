//::///////////////////////////////////////////////
//:: Expeditious Retreat
//:: cmi_hx_expdretreat
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "cmi_ginc_chars"

void main()
{
        if (!X2PreSpellCastCode())
        {
        // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
            return;
        }

	//Declare major variables
    object oTarget = GetSpellTargetObject();

    if (GetHasSpellEffect(SPELL_HASTE, oTarget) == TRUE)
    {
        return ; // does nothing if caster already has haste
    }
	
    //effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);	// NWN1 VFX
    effect eDur = EffectVisualEffect( VFX_DUR_SPELL_EXPEDITIOUS_RETREAT );	// NWN2 VFX
    effect eFast = EffectMovementSpeedIncrease(150);
    effect eLink = EffectLinkEffects(eFast, eDur);
    eLink = SetEffectSpellId(eLink, SPELL_EXPEDITIOUS_RETREAT);
	eLink = SupernaturalEffect(eLink);
    float fDuration = RoundsToSeconds(GetHexbladeCasterLevel() * 2);
	
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_EXPEDITIOUS_RETREAT, FALSE));

	//Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
}
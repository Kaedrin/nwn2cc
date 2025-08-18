//::///////////////////////////////////////////////
//:: Inspire Hatred
//:: cmi_s2_insphatred
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Sept 28, 2007
//:://////////////////////////////////////////////


#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{


    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    object oTarget = GetSpellTargetObject();
	
    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_NECROMANCY);	
	
	effect eABLoss = EffectAttackDecrease(2);
	effect eACLoss = EffectACDecrease(2);
	effect eSaveLoss = EffectSavingThrowDecrease(SAVING_THROW_ALL,2);
	
	effect eLink = EffectLinkEffects(eABLoss,eACLoss);
	eLink = EffectLinkEffects (eSaveLoss,eACLoss);
	eLink = SupernaturalEffect(eLink);

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
    {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink , oTarget, TurnsToSeconds(1));
    }
}
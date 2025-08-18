//::///////////////////////////////////////////////
//:: Blur
//:: cmi_s0_blur
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: May 29, 2010
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "cmi_ginc_spells"

void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();

    effect eConc = EffectConcealment(20);
    effect eDur = EffectVisualEffect(VFX_DUR_SPELL_DISPLACEMENT);

    effect eLink = EffectLinkEffects(eConc, eDur);

	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(oTarget, GetSpellId(), FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
}
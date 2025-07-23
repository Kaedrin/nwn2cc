//::///////////////////////////////////////////////
//:: See Invisible
//:: cmi_hx_seeinvis
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	//Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eDur = EffectVisualEffect( VFX_DUR_SPELL_SEE_INVISIBILITY );
    effect eSight = EffectSeeInvisible();
    effect eLink = EffectLinkEffects(eDur, eSight);
    eLink = SetEffectSpellId(eLink, SPELL_SEE_INVISIBILITY);
	eLink = SupernaturalEffect(eLink);
	
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SEE_INVISIBILITY, FALSE));

    float fDuration = TurnsToSeconds(GetHexbladeCasterLevel());

    //Apply the VFX impact and effects
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
}
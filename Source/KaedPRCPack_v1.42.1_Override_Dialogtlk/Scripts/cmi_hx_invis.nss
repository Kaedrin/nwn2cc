//::///////////////////////////////////////////////
//:: Invisibility
//:: cmi_hx_invis
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////


#include "cmi_ginc_chars"
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
    
	effect eVis = EffectVisualEffect( VFX_DUR_INVISIBILITY );
    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
	effect eLink = EffectLinkEffects( eInvis, eVis );
    eLink = SetEffectSpellId(eLink, SPELL_INVISIBILITY);
	eLink = SupernaturalEffect(eLink);
	
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_INVISIBILITY, FALSE));

	int nDuration = GetHexbladeCasterLevel();
    float fDuration = TurnsToSeconds(nDuration);

	//Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
}
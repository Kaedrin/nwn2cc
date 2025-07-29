//::///////////////////////////////////////////////
//:: Greater Invisibility
//:: cmi_hx_grtrinvis
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////


#include "cmi_ginc_spells"
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
    effect eImpact = EffectVisualEffect(VFX_HIT_SPELL_ILLUSION);

    effect eInvis = EffectInvisibility( INVISIBILITY_TYPE_NORMAL );
	effect eVis = EffectVisualEffect( VFX_DUR_INVISIBILITY );
    effect eCover = EffectConcealment(50);
    effect eLink = EffectLinkEffects(eVis, eCover);

    effect eOnDispell = EffectOnDispel(0.0f, RemoveEffectsFromSpell(oTarget, SPELL_GREATER_INVISIBILITY));
    eLink = EffectLinkEffects(eLink, eOnDispell);
    eInvis = EffectLinkEffects(eInvis, eOnDispell);
	
    eLink = SetEffectSpellId(eLink, SPELL_GREATER_INVISIBILITY);
	eLink = SupernaturalEffect(eLink);
    eInvis = SetEffectSpellId(eInvis, SPELL_GREATER_INVISIBILITY);
	eInvis = SupernaturalEffect(eInvis);		

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_INVISIBILITY, FALSE));
    int nDuration = GetHexbladeCasterLevel();
	
    if(GetHasFeat(FEAT_HEXBLADE_ARCANE_MASTERY)) // arcane mastery
    {
        nDuration = nDuration * 2;
    }	
	
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oTarget, RoundsToSeconds(nDuration));
}
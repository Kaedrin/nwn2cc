//::///////////////////////////////////////////////
//:: Etherealness -> Ethereal Jaunt
//:: x2_s1_ether.nss
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Turns a creature ethereal
    Used by one of the undead shape forms for
    shifter/druids. lasts 5 rounds

	Changed to Ethereal Jaunt:
	Last for 1 round/caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003/08/01
//:://////////////////////////////////////////////
//:: AFW-OEI 05/30/2006:
//::	Changed to Ethereal Jaunt

#include "x2_inc_spellhook"

void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    //effect eVis = EffectVisualEffect(VFX_DUR_BLUR);	// NWN1 VFX
    //effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);	// NWN1 VFX
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_ETHEREALNESS );	// NWN2 VFX
    effect eSanc = EffectEthereal();
    effect eLink = EffectLinkEffects(eVis, eSanc);
    //eLink = EffectLinkEffects(eLink, eDur);
    int nDuration = 10;

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Apply the VFX impact and effects
    if(!GetHasSpellEffect(GetSpellId(), OBJECT_SELF))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    }

}
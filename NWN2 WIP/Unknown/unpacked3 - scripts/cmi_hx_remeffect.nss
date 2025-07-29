//::///////////////////////////////////////////////
//:: Remove Effects
//:: NW_SO_RemEffect
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Takes the place of
        Remove Disease
        Neutralize Poison
        Remove Paralysis
        Remove Curse
        Remove Blindness / Deafness
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////
// RPGplayer1 11/22/08 - Keeps effects from Reduce spells

//#include "NW_I0_SPELLS"
#include "X0_I0_SPELLS"

#include "x2_inc_spellhook" 

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  
*/

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    int nSpellID = SPELL_REMOVE_CURSE;
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_ABJURATION);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID, FALSE));
    //Remove effects
	RemoveEffectsFromSpell(oTarget, SPELLABILITY_HEX_CURSE);	
	RemoveEffectsFromSpell(oTarget, SPELLABILITY_HEX_CURSE_LETH);	
	RemoveEffectsFromSpell(oTarget, SPELLABILITY_HEX_CURSE_LETH);	
	RemoveEffectsFromSpell(oTarget, SPELL_BESTOW_CURSE);	
    RemoveSpecificEffect(EFFECT_TYPE_CURSE, oTarget);							
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
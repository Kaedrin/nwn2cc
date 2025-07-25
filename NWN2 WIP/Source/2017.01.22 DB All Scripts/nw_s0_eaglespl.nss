//::///////////////////////////////////////////////
//:: Eagles Splendor
//:: NW_S0_EagleSpl
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Raises targets Chr by 4
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 15, 2001
//:://////////////////////////////////////////////

// (Updated JLR - OEI 07/05/05 NWN2 3.5)

// JLR - OEI 08/24/05 -- Metamagic changes
// ChazM-OEI 7/21/07 Spell constant changed

#include "nwn2_inc_spells"


#include "x2_inc_spellhook" 

#include "cmi_ginc_spells"

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-23 by GeorgZ
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
    object oTarget = GetSpellTargetObject();
    effect eRaise;
    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_EAGLE_SPLENDOR);
    //effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    int nRaise = 4;
    float fDuration = TurnsToSeconds(GetPalRngCasterLevel());

    //Fire cast spell at event for the specified target
        //SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_EAGLES_SPLENDOR));

    //Enter Metamagic conditions
    fDuration = ApplyMetamagicDurationMods(fDuration);
    int nDurType = ApplyMetamagicDurationTypeMods(DURATION_TYPE_TEMPORARY);

    //Set Adjust Ability Score effect
    eRaise = EffectAbilityIncrease(ABILITY_CHARISMA, nRaise);
    effect eLink = EffectLinkEffects(eRaise, eVis);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_EAGLES_SPLENDOR, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(nDurType, eLink, oTarget, fDuration);
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);


}
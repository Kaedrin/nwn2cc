//::///////////////////////////////////////////////
//:: Protection from Good
//:: NW_S0_PrGood.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    When confronted by good the protected character
    gains +2 AC, +2 to Saves and immunity to all
    mind-affecting spells cast by good creatures
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 28, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 22, 2001

// JLR - OEI 08/23/05 -- Permanency & Metamagic changes
#include "nwn2_inc_spells"

#include "cmi_ginc_spells"
#include "x2_inc_spellhook"

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
    int nAlign = ALIGNMENT_GOOD;
    object oTarget = GetSpellTargetObject();
    float fDuration = HoursToSeconds(GetPalRngCasterLevel());

    effect eDur = EffectVisualEffect(VFX_DUR_SPELL_PROT_ALIGN);
    effect eAC = EffectACIncrease(2, AC_DEFLECTION_BONUS);
    //Change the effects so that it only applies when the target is evil
    eAC = VersusAlignmentEffect(eAC, ALIGNMENT_ALL, nAlign);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 2);
    eSave = VersusAlignmentEffect(eSave,ALIGNMENT_ALL, nAlign);
    effect eImmune1 = EffectImmunity(IMMUNITY_TYPE_CHARM);
    effect eImmune2 = EffectImmunity(IMMUNITY_TYPE_DOMINATE);
    effect eImmune3 = EffectImmunity(IMMUNITY_TYPE_FEAR);
    effect eImmune4 = EffectImmunity(IMMUNITY_TYPE_CONFUSED);		
    eImmune1 = VersusAlignmentEffect(eImmune1,ALIGNMENT_ALL, nAlign);
    eImmune2 = VersusAlignmentEffect(eImmune2,ALIGNMENT_ALL, nAlign);
    eImmune3 = VersusAlignmentEffect(eImmune3,ALIGNMENT_ALL, nAlign);
    eImmune4 = VersusAlignmentEffect(eImmune4,ALIGNMENT_ALL, nAlign);			

    effect eLink = EffectLinkEffects(eImmune1, eSave);
    eLink = EffectLinkEffects(eLink, eImmune2);
    eLink = EffectLinkEffects(eLink, eImmune3);
    eLink = EffectLinkEffects(eLink, eImmune4);			
    eLink = EffectLinkEffects(eLink, eAC);
	eLink = EffectLinkEffects(eLink, eDur);

    //Enter Metamagic conditions
    fDuration = ApplyMetamagicDurationMods(fDuration);
    int nDurType = ApplyMetamagicDurationTypeMods(DURATION_TYPE_TEMPORARY);

    RemovePermanencySpells(oTarget);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PROTECTION_FROM_GOOD, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(nDurType, eLink, oTarget, fDuration);
}
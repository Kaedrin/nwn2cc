//::///////////////////////////////////////////////
//:: [Bear's Endurance]
//:: [NW_S0_BearEndur.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Gives the target 4 Constitution.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////

// (Updated JLR - OEI 07/05/05 NWN2 3.5)

// JLR - OEI 08/24/05 -- Metamagic changes
#include "nwn2_inc_spells"


#include "x2_inc_spellhook"

#include "cmi_ginc_spells"

void main()
{
    /*
      Spellcast Hook Code
      Added 2004-03-08 by Jon (should have been added much sooner, but we somehow missed this one...)
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
    effect eCon;
    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_BEAR_ENDURANCE);

    //Does not stack with Mass Bear Endurance	
    if (GetHasSpellEffect(SPELL_GREATER_BEARS_ENDURANCE, oTarget))
    {
		SendMessageToPC(oTarget, "You already have Greater Bear's Endurance active. Spell failed.");
        return;
    }
    if (GetHasSpellEffect(SPELL_Chasing_Perfection, oTarget))
    {
		SendMessageToPC(oTarget, "You already have Chasing Perfection active. Spell failed.");	
        return;
    }	
    RemoveEffectsFromSpell(oTarget, SPELL_BEARS_ENDURANCE);
    RemoveEffectsFromSpell(oTarget, SPELL_MASS_BEAR_ENDURANCE);	
	
    int nCasterLvl = GetPalRngCasterLevel();
    int nModify = 4;
    float fDuration = TurnsToSeconds(nCasterLvl);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BEARS_ENDURANCE, FALSE));

    //Check for metamagic conditions
    fDuration = ApplyMetamagicDurationMods(fDuration);
    int nDurType = ApplyMetamagicDurationTypeMods(DURATION_TYPE_TEMPORARY);

    //Set the ability bonus effect
    eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION,nModify);
    effect eLink = EffectLinkEffects(eCon, eVis);

    //Appyly the VFX impact and ability bonus effect
    ApplyEffectToObject(nDurType, eLink, oTarget, fDuration);
	
	effect eHeal = EffectHeal(1);
	if ( GetCurrentHitPoints(oTarget) > GetMaxHitPoints(oTarget))
	{	
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);	
	}	
}
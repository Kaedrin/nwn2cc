//::///////////////////////////////////////////////
//:: Invocation: Dark One's Own Luck
//:: NW_S0_IDrkOnLck.nss
//:://////////////////////////////////////////////
/*
    Gives a +(Charisma Modifier) bonus to all Saving
    Throws for 24 hours.
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Reynolds (JLR - OEI)
//:: Created On: June 19, 2005
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001


// JLR - OEI 08/24/05 -- Metamagic changes
#include "nwn2_inc_spells"
#include "nw_i0_spells"

#include "x2_inc_spellhook" 

#include "cmi_ginc_spells"

#include "noc_warlock_corruption"

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
	
	AddCorruption(OBJECT_SELF, 2);
	
	if (GetHasSpellEffect(SPELLABILITY_HEX_ARCRES,OBJECT_SELF) || GetHasFeat(FEAT_PRESTIGE_DARK_BLESSING))
	{	
		SendMessageToPC(OBJECT_SELF, "Dark One's Own Luck does not stack with Arcane Resistance or Dark Blessing.");	
		return; //
	}

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    float fDuration = HoursToSeconds(24);
    int nBonus = GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF);
	
	int nCasterLvl  = GetWarlockCasterLevel(OBJECT_SELF);
	if (nBonus > nCasterLvl)
		nBonus = nCasterLvl;

    //Enter Metamagic conditions
    fDuration = ApplyMetamagicDurationMods(fDuration);
    int nDurType = ApplyMetamagicDurationTypeMods(DURATION_TYPE_TEMPORARY);

    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nBonus, SAVING_THROW_TYPE_ALL);
    effect eDur = EffectVisualEffect(VFX_DUR_INVOCATION_DARKONESLUCK);
    effect eLink = EffectLinkEffects(eSave, eDur);

    RemoveEffectsFromSpell(oTarget, GetSpellId());

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(nDurType, eLink, oTarget, fDuration);
}
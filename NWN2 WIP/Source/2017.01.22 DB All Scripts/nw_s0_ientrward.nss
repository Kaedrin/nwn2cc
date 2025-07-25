//::///////////////////////////////////////////////
//:: Invocation: Entropic Warding
//:: NW_S0_IEntrWard.nss
//:://////////////////////////////////////////////
/*
    Gives +4 Move Silently and Hide Skill Bonuses,
    and gives effect of Entropic Shield (Cleric)
    Spell:

    20% concealment to ranged attacks including
    ranged spell attacks
    Duration: 1 turn/level
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Reynolds (JLR - OEI)
//:: Created On: June 19, 2005
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001


// JLR - OEI 08/24/05 -- Metamagic changes
#include "nwn2_inc_spells"

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook" 

#include "cmi_ginc_spells"
#include "noc_warlock_corruption"

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


	AddCorruption(OBJECT_SELF, 2);
	
     //Declare major variables
    object oTarget = OBJECT_SELF;
    float fDuration = TurnsToSeconds(GetWarlockCasterLevel(OBJECT_SELF));
    //effect eVis = EffectVisualEffect(VFX_IMP_AC_BONUS);	// NWN1 VFX
	
	if (GetLevelByClass(CLASS_TYPE_SHADOWDANCER) == 0)
	{
		 fDuration = HoursToSeconds(24);
	}

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Set the four unique armor bonuses
    effect eShield =  EffectConcealment(20, MISS_CHANCE_TYPE_VS_RANGED);
    effect eDur = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);	// Using the same VFX as entropic shield
    //effect eMoveSilently = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 4);
    //effect eHide = EffectSkillIncrease(SKILL_HIDE, 4);
    //effect eLink = EffectLinkEffects(eShield, eMoveSilently);
    //eLink = EffectLinkEffects(eLink, eDur);
    //eLink = EffectLinkEffects(eLink, eHide);
	effect eLink = EffectLinkEffects(eDur, eShield);

    RemoveEffectsFromSpell(oTarget, GetSpellId());

    //Apply the armor bonuses and the VFX impact
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
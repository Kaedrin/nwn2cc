//::///////////////////////////////////////////////
//:: Invocation: Devil's Sight
//:: NW_S0_IDvlSight.nss
//:://////////////////////////////////////////////
/*
    Caster gains Darkvision/Ultravision for 24 hours.
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Reynolds (JLR - OEI)
//:: Created On: June 19, 2005
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001
//:: AFW-OEI 11/20/2006: Change from Darkvision -> Ultravision.  TTP #20413


// JLR - OEI 08/24/05 -- Metamagic changes
#include "nwn2_inc_spells"
#include "nw_i0_spells"

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
    object oTarget = GetSpellTargetObject();
    float fDuration = HoursToSeconds(24);
	
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
	effect eSpot = EffectSkillIncrease(SKILL_SPOT, 6);
	effect eSearch = EffectSkillIncrease(SKILL_SEARCH, 6);
	    
	effect eLink = EffectLinkEffects(eSpot, eSearch);
	eLink = EffectLinkEffects(eLink, eVis);

    RemoveEffectsFromSpell(oTarget, GetSpellId());

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
}
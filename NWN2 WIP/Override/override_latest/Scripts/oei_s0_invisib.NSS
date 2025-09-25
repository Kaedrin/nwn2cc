//::///////////////////////////////////////////////
//:: Invisibility
//:: NW_S0_Invisib.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Target creature becomes invisibility
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

// JLR - OEI 08/24/05 -- Metamagic changes
// PKM-OEI 08.09.06 -- VFX update
//:: AFW-OEI 08/03/2007: Account for Assassins.

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
    object oTarget = GetSpellTargetObject();
    
	effect eVis = EffectVisualEffect( VFX_DUR_INVISIBILITY );
    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);

	effect eSkill = EffectSkillIncrease(SKILL_HIDE,20);
	effect eAB = EffectAttackIncrease(2);
	effect eImm = EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK);
	
	effect eLink = EffectLinkEffects( eInvis, eVis );
	eLink = EffectLinkEffects(eLink, eSkill);
	eLink = EffectLinkEffects(eLink, eAB);
	eLink = EffectLinkEffects(eLink, eImm);		

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_INVISIBILITY, FALSE));

	int nDuration;
	if (GetSpellId() == SPELL_ASN_Invisibility || GetSpellId() == SPELL_ASN_Spellbook_3)
	{	
        nDuration = GetAssassinCasterLevel(OBJECT_SELF);
	}
	else
	{
    	nDuration = GetCasterLevel(OBJECT_SELF);
	}
		
    float fDuration = TurnsToSeconds(nDuration);

    //Enter Metamagic conditions
    fDuration = ApplyMetamagicDurationMods(fDuration);
    int nDurType = ApplyMetamagicDurationTypeMods(DURATION_TYPE_TEMPORARY);

	//Apply the VFX impact and effects
    ApplyEffectToObject(nDurType, eLink, oTarget, fDuration);
}
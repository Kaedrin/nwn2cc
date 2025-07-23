//::///////////////////////////////////////////////
//:: Darkness
//:: NW_S0_Darkness.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a globe of darkness around those in the area
    of effect.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
// ChazM 7/14/06 If cast on an object, signal the object cast on (needed for crafting)
//:: AFW-OEI 08/03/2007: Account for Assassins.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook" 

#include "cmi_ginc_spells"

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


	int nSpellId = GetSpellId();
	
    //Declare major variables including Area of Effect Object
    //effect eAOE = EffectAreaOfEffect(VFX_PER_PRC_DARKNESS);
    effect eAOE = EffectAreaOfEffect(AOE_PER_DARKNESS, "oei_s0_darknessa", "", "oei_s0_darknessb");	
    object oTarget = GetSpellTargetObject();
	if (GetIsObjectValid(oTarget))
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId));
	
    location lTarget = GetSpellTargetLocation();
    int nDuration = GetCasterLevel(OBJECT_SELF);
	
	if (nSpellId == SPELL_BG_Darkness)
	{
		nDuration = GetBlackguardCasterLevel(OBJECT_SELF);
	}
	else if (nSpellId == SPELL_ASN_Spellbook_2 || nSpellId == SPELL_ASN_Darkness)
	{
		nDuration = GetAssassinCasterLevel(OBJECT_SELF);
	}
	else
	{
    	nDuration = GetCasterLevel(OBJECT_SELF);
	}	
	
	int nMetaMagic = GetMetaMagicFeat();
    //Make sure duration does no equal 0
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    //Check Extend metamagic feat.
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
	   nDuration = nDuration *2;	//Duration is +100%
    }
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
}
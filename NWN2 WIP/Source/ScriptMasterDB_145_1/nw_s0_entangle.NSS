//::///////////////////////////////////////////////
//:: Entangle
//:: NW_S0_Enangle
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Area of effect spell that places the entangled
  effect on enemies if they fail a saving throw
  each round.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On:  Dec 12, 2001
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: July 31, 2001
//:: RPGplayer1 12/20/2008:
//::  Use caster level of 4, for racial version
//::  Use charisma based DC, for racial version (per PnP)
//:: RPGplayer1 08/14/2009: Incoporeal cretures are now properly unaffected

#include "x2_inc_spellhook" 
#include "X0_I0_SPELLS"

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


    //Declare major variables including Area of Effect Object
	int nDC = GetSpellSaveDC();
    effect eAOE = EffectAreaOfEffect(AOE_PER_ENTANGLE);
    location lTarget = GetSpellTargetLocation();
    int nDuration = 3 + GetPalRngCasterLevel();
    int nMetaMagic = GetMetaMagicFeat();
	
	//Has same SpellId as Entangle, not an item, but returns no valid class -> it's racial ability
	if (GetSpellId() == SPELL_ENTANGLE && !GetIsObjectValid(GetSpellCastItem()) && GetLastSpellCastClass() == CLASS_TYPE_INVALID)
	{
		eAOE = EffectAreaOfEffect(AOE_PER_ENTANGLE, "", "", "", "AOE_ENTANGLE_RACIAL"); //tag it for heartbeat script
		nDuration = 7;	//CL4 -> 3 + 4 = 7
		nDC = 10 + GetSpellLevel(SPELL_ENTANGLE) + GetAbilityModifier(ABILITY_CHARISMA);
	}	
	
	//Declare major variables
    effect eHold = EffectEntangle();
    effect eEntangle = EffectVisualEffect(VFX_DUR_ENTANGLE);
    //Link Entangle and Hold effects
    effect eLink = EffectLinkEffects(eHold, eEntangle);
	effect eSlow = EffectSlow();
	
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
	
	//The following lines are from nw_s0_entanglec and are included so that a creature can be entangled on the same round that the spell goes off.
	object oTarget = GetFirstObjectInShape( SHAPE_SPHERE, 6.1, lTarget );

    while(GetIsObjectValid(oTarget))
    {
	if( (GetCreatureFlag(oTarget, CREATURE_VAR_IS_INCORPOREAL) != TRUE) )	// AFW-OEI 05/01/2006: Woodland Stride no longer protects from spells.
       {
            if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ENTANGLE));
                //Make SR check
                if(!GetHasSpellEffect(SPELL_ENTANGLE, oTarget))
                {
                    //if(!MyResistSpell(OBJECT_SELF, oTarget))
                    //{
                        //Make reflex save
                        if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC))
                        {
                           //Apply linked effects
                           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(2));
                        }
						else
						{
                        	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, RoundsToSeconds(1));						
						}
                    //}
                }
            }
        }
        //Get next target in the AOE
        oTarget = GetNextObjectInShape( SHAPE_SPHERE, 6.1, lTarget );
    }
	
	SetLocalInt(OBJECT_SELF, "DC53", GetSpellSaveDC());	
}
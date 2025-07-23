//:://///////////////////////////////////////////////
//:: Warlock Lesser Invocation: Flee the Scene
//:: nw_s0_ifleescen.nss
//:: Copyright (c) 2005 Obsidian Entertainment Inc.
//::////////////////////////////////////////////////
//:: Created By: Brock Heinz
//:: Created On: 08/12/05
//::////////////////////////////////////////////////
/*
        5.7.2.7	Flee the Scene
        Complete Arcane, pg. 134
        Spell Level:	4
        Class: 		Misc

        The warlock gets the benefits of the expeditious retreat spell 
        (1st level wizard) for 1 hour. They also get the benefits of the haste 
        spell (3rd level wizard) for 5 rounds.

        [Rules Note] In the rules this equivalent to the dimension door spell, 
        which doesn't exist in NWN2. Instead it is replaced by Expeditious 
        Retreat and a brief bout of the haste spell. The Haste effect would 
        be incredibly powerful in pen-and-paper, but eventually boots of speed 
        and the like will mean the player perpetually has that beneficial 
        effect, so the warlock gets consistent access to it a little bit earlier.

*/


// JLR - OEI 08/24/05 -- Metamagic changes
// RPGplayer1 12/15/08 - Delayed DoHasteEffects(), in order to fix issues with Team Rush feat

#include "nwn2_inc_spells"

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook" 

#include "cmi_ginc_spells"

/*
void DoExpeditiousRetreatEffects( object oCaster, object oTarget, int nMetaMagic )
{
    effect eDur     = EffectVisualEffect( VFX_DUR_SPELL_EXPEDITIOUS_RETREAT );
    effect eFast    = EffectMovementSpeedIncrease(150);
	effect eDodge 	= EffectACIncrease(2);
    effect eLink    = EffectLinkEffects(eFast, eDur);
	eLink 			= EffectLinkEffects(eLink, eDodge);
    
    float fDuration   = HoursToSeconds(1); // 1 hour

    fDuration = ApplyMetamagicDurationMods(fDuration);
    int nDurType = ApplyMetamagicDurationTypeMods(DURATION_TYPE_TEMPORARY);

	//Apply the VFX impact and effects
    ApplyEffectToObject(nDurType, eLink, oTarget, fDuration);
}
*/

void DoHasteEffects( object oCaster, object oTarget, int nMetaMagic, int nHasDarkTransient, float fDuration )
{
    int nCasterLvl  = GetWarlockCasterLevel(oCaster);
    float fDuration   = RoundsToSeconds(nCasterLvl); // Rounds
	
	int nHasDarkTransient = FALSE;
	if (GetHasFeat(FEAT_DARK_TRANSIENT, oCaster))
	{
		nHasDarkTransient = TRUE;
		fDuration = fDuration * 2;
	}

    //Check for metamagic extension
    fDuration = ApplyMetamagicDurationMods(fDuration);

    // Create the Effects
    effect eHaste   = EffectHaste();
    //effect eVis     = EffectVisualEffect(VFX_IMP_HASTE);
    effect eDur     = EffectVisualEffect( VFX_DUR_SPELL_HASTE );
    effect eLink    = EffectLinkEffects(eHaste, eDur);
	
	if (nHasDarkTransient && (oCaster == oTarget))
	{
		effect eAB = EffectAttackIncrease(1);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, oTarget, fDuration);
	}
	
    // Apply effects to the currently selected target.
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}


void main()
{

    if (!X2PreSpellCastCode())
    {
	    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    // Remove any spells that share effects with this spell
    if (GetHasSpellEffect(SPELL_HASTE, OBJECT_SELF) == TRUE)
    {
        RemoveSpellEffects(SPELL_HASTE, OBJECT_SELF, OBJECT_SELF);
    }

    if (GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT, OBJECT_SELF) == TRUE)
    {
        RemoveSpellEffects(SPELL_EXPEDITIOUS_RETREAT, OBJECT_SELF, OBJECT_SELF);
    }
	
    if (GetHasSpellEffect(SPELL_I_FLEE_THE_SCENE, OBJECT_SELF) == TRUE)
    {
        RemoveSpellEffects(SPELL_I_FLEE_THE_SCENE, OBJECT_SELF, OBJECT_SELF);
    }	
	
    int nCasterLvl  = GetWarlockCasterLevel(OBJECT_SELF);
    float fDuration   = RoundsToSeconds(nCasterLvl); // Rounds
	
	int nHasDarkTransient = FALSE;
	if (GetHasFeat(FEAT_DARK_TRANSIENT, OBJECT_SELF))
	{
		nHasDarkTransient = TRUE;
		fDuration = fDuration * 2;
	}

    //Check for metamagic extension
    fDuration = ApplyMetamagicDurationMods(fDuration);

    // Create the Effects
    effect eHaste   = EffectHaste();
    effect eDur     = EffectVisualEffect( VFX_DUR_SPELL_HASTE );
    effect eLink    = EffectLinkEffects(eHaste, eDur);
	
	if (nHasDarkTransient)
	{
		effect eAB = EffectAttackIncrease(2);
		DelayCommand(0.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, OBJECT_SELF, fDuration));
	}
	
	location lTarget = GetSpellTargetLocation();
	object oTarget = GetFirstObjectInShape( SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
	while (GetIsObjectValid(oTarget))
	{
    	if (spellsIsTarget( oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF ))
    		{
        		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_I_FLEE_THE_SCENE, FALSE));	
				DelayCommand(0.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));	
    		}        	
     	//Get the next target in the specified area around the caster
		oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
	}	

}
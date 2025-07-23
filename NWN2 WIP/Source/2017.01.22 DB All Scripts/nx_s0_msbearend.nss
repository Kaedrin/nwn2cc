//::///////////////////////////////////////////////
//:: Bear's Endurance, Mass
//:: NX_s0_msbearend.nss
//:: Copyright (c) 2007 Obsidian Entertainment
//:://////////////////////////////////////////////
/*
 	
Bear's Endurance, Mass
Transmutation
Level: Cleric 6, Druid 6, Sorceror/wizard 6
Range: Close
Targets: One creature/level withint a 30 ft. radius of target
 
The affected creatures gain greater vitality and stamina.  The spell grants the subjects a +4 bonus to Constitution.
*/
//:://////////////////////////////////////////////
//:: Created By: Patrick Mills
//:: Created On: 12.05.06
//:://////////////////////////////////////////////
//:: Updates to scripts go here.

#include "nw_i0_spells" 
#include "nwn2_inc_spells"
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
	location lTarget = GetSpellTargetLocation();
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    effect eBuff;
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BEAR_ENDURANCE ); //replace this with proper vfx later
	
	int nCasterLevel = GetCasterLevel(OBJECT_SELF);


    float fDuration = TurnsToSeconds(nCasterLevel); 
    
    //Set the buff effect
    eBuff = EffectAbilityIncrease(ABILITY_CONSTITUTION, 4);
	eBuff = EffectLinkEffects( eBuff, eVis );

	//Check for metamagic
    fDuration = ApplyMetamagicDurationMods(fDuration);
    int nDurType = ApplyMetamagicDurationTypeMods(DURATION_TYPE_TEMPORARY);
    
	while (GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF))
		{
			//Fire cast spell at event for the specified target
    		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 1024, FALSE));

    		//should not stack with Bear Endurance or itself
		    RemoveEffectsFromSpell(oTarget, SPELL_BEARS_ENDURANCE);
		    RemoveEffectsFromSpell(oTarget, SPELL_MASS_BEAR_ENDURANCE);	
			
			int nError = FALSE;
		    if (GetHasSpellEffect(SPELL_GREATER_BEARS_ENDURANCE, oTarget))
		    {
				nError = TRUE;
				SendMessageToPC(oTarget, "You already have a stronger +Constitution spell active. You did not gain the benefits of Mass Bear's Endurance.");
		    }	
		    if (GetHasSpellEffect(SPELL_Chasing_Perfection, oTarget))
		    {
				nError = TRUE;
				SendMessageToPC(oTarget, "You already have Chasing Perfection active.You did not gain the benefits of Mass Bear's Endurance.");	 
			}						
				
			//Apply the bonus effect and VFX impact
			if (!nError)
			{
	    		ApplyEffectToObject(nDurType, eBuff, oTarget, fDuration);			
				if ( GetCurrentHitPoints(oTarget) > GetMaxHitPoints(oTarget))
				{	
					effect eHeal = EffectHeal(1);
					ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);	
				}
			}
		}
	oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
	}
}
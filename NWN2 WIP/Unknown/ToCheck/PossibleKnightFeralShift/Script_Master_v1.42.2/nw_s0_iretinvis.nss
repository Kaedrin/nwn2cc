//:://///////////////////////////////////////////////
//:: Warlock Dark Invocation: Dark Foresight
//:: nw_s0_iretinvis.nss
//:: Copyright (c) 2005 Obsidian Entertainment Inc.
//::////////////////////////////////////////////////
//:: Created By: Brock Heinz
//:: Created On: 12/08/05
//::////////////////////////////////////////////////
/*

        Retributive Invisibility    Complete Arcane, pg. 135
        Spell Level:	            6
        Class: 		                Misc

        The warlock can use the greater invisibility spell (5th level wizard)
        but only himself at the target. If the invocation is dispelled, a 
        shockwave releases from your body (the visual equivalent of an 
        eldritch doom blast centered on the player) that does 4d6 damage in 
        a 20' radius burst and stuns all enemies for one round. A Fortitude 
        save halves the damage and eliminates the stun effect.
    
        Target creature can attack and cast spells while
        invisible
*/
//:: AFW-OEI 06/07/2006:
//::	Fix bug: should be improved invisibility, not regular
//:: PKM-OEI 07.19.06 : VFX Update

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "cmi_ginc_spells"

void OnDispellCallback( object oCaster, int nSaveDC, float fDuration )
{
	//SpawnScriptDebugger();

	if ( !GetIsObjectValid( oCaster ) )
		return;
 
	location lTarget = GetLocation( oCaster );

	// Do a quick explosion effect
	effect eExplode = EffectVisualEffect( VFX_INVOCATION_ELDRITCH_AOE );
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);


	int nDamageType  	= DAMAGE_TYPE_SONIC;
	int nDamagePower 	= DAMAGE_POWER_NORMAL;
	int nSaveType		= SAVING_THROW_TYPE_NONE;
	float fDistToDelay 	= 0.25f; 

	
	int nDamageAmt;
	float fDelay;
	effect eDmg;
	effect eStun;
	effect eDur;
	effect eDur2;


    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE );
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster) && oTarget != oCaster)
    	{
			nDamageAmt = d6(4);
			nDamageAmt	= ApplyMetamagicVariableMods( nDamageAmt, 4 * 6 );

			int nSaveResult = FortitudeSave( oTarget, nSaveDC, nSaveType, oCaster );
            if ( nSaveResult == SAVING_THROW_CHECK_FAILED ) // saving throw failed
            {
				eDmg = EffectDamage( nDamageAmt, nDamageType, nDamagePower );  // create the effects
				eStun = EffectStunned();
                eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
				eDur2 = EffectVisualEffect( VFX_DUR_STUN );
                effect eLink = EffectLinkEffects(eStun, eDur);
				eLink = EffectLinkEffects(eLink, eDur2);

                // Apply effects to the currently selected target.
				fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget)) * fDistToDelay ;
				DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget));
				DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
            }
			else if ( nSaveResult == SAVING_THROW_CHECK_SUCCEEDED )	// Saving throw successful
			{
				nDamageAmt = nDamageAmt / 2; // halve the damage

				eDmg = EffectDamage( nDamageAmt, nDamageType, nDamagePower ); // create the effect
			
                // Apply effects to the currently selected target.
				fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget)) * fDistToDelay ;
				DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget));
			}
            
		}

		//Select the next target within the spell shape.
		oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE );
	}

}


void main()
{

    if (!X2PreSpellCastCode())
    {
   		// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	//Clear previous casting
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());

	int nSaveDC = GetWarlockDC(OBJECT_SELF, TRUE);
	float fDuration = RoundsToSeconds(GetWarlockCasterLevel(OBJECT_SELF));
	
	//This stays active for the duration of the spell, 1 round per CL
    effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect eDur = EffectVisualEffect( VFX_DUR_INVOCATION_RETRIBUTIVE_INVISIBILITY );
    effect eCover = EffectConcealment(50);
    effect eLink = EffectLinkEffects(eDur, eCover);
    eLink = EffectLinkEffects(eLink, eVis);

	//This will break on combat    
	effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);	
    effect eOnDispell = EffectOnDispel( 0.5f, OnDispellCallback( OBJECT_SELF, nSaveDC, RoundsToSeconds(1) ) );		
	effect eInvisLink = EffectLinkEffects(eOnDispell, eInvis);		

    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_INVISIBILITY, FALSE));
	
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvisLink, OBJECT_SELF,fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF,fDuration);
}
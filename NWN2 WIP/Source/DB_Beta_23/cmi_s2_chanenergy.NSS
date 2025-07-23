//::///////////////////////////////////////////////
//:: Turn Undead
//:: NW_S2_TurnDead
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks domain powers and class to determine
    the proper turning abilities of the casting
    character.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 2, 2001
//:: Updated On: Jul 15, 2003 - Georg Zoeller
//:://////////////////////////////////////////////
//:: MODIFIED MARCH 5 2003 for Blackguards
//:: MODIFIED JULY 24 2003 for Planar Turning to include turn resistance hd

//:: 6/26/06 - BDF-OEI: made a revision with excluding friendlies from being targeted
//:: 08.07.06 - PKM-OEI: Changed panic to rebuke to fix the problem of terrified undead running all over the map.  Details below.
/*  Rebuke Undead:
	The character is frozen in fear and can take no actions.  A cowering character takes -2 AC and loses her Dex bonus (if any.)
	This effect replaces the panic effect.  Lasts 10 rounds.

*/
//:: 9/06/06 - BDF-OEI: removed the outsider SR consideration b/c without Planar Turning feat
//::		it can be practiaclly impossible to turn any mid-level outsider that has 20 SR
//:: 10/18/06 - BDF(OEI): added the GetHasEffect check so that turned undead don't count against the HD (turn damage); per 3.5
//::		added various Print functions to provide better feedback for outcome
//:: AFW-OEI 02/08/2007: Planar Turning is back in.

#include "x0_i0_spells"
#include "cmi_includes"
#include "cmi_ginc_chars"

int GenerateTurnDamage(int nDice, int nEnergyLevel)
{
	int nDamage = 1;
	
	if (nEnergyLevel > 19)
		nDamage = nDice * 6;
	else
		nDamage = d6(nDice);
	
	return nDamage;
}

void main()
{
	int nEnergyLevel = GetLevelByClass(CLASS_TYPE_PALADIN);
	nEnergyLevel += GetLevelByClass(CLASS_TYPE_CLERIC);
	
    nEnergyLevel += GetLevelByClass(CLASS_TYPE_BLACKGUARD);
    nEnergyLevel += GetLevelByClass(CLASS_TYPE_WARPRIEST);
	nEnergyLevel += GetLevelByClass(CLASS_MASTER_RADIANCE);
    nEnergyLevel += GetLevelByClass(CLASS_TYPE_DOOMGUIDE);
	nEnergyLevel += GetLevelByClass(CLASS_SHADOWBANE_STALKER);
	nEnergyLevel += GetLevelByClass(CLASS_CHAMP_SILVER_FLAME);
	nEnergyLevel += GetLevelByClass(CLASS_ELDRITCH_DISCIPLE);
	
	nEnergyLevel += GetHasFeat(FEAT_IMPROVED_TURNING); // Improved Turning
	
	int nDC = 10 + (nEnergyLevel/2) + GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF);
	int nDamageDice = (nEnergyLevel+1)/2;
	
	{
		int nDamage;
		
	    effect eVis = EffectVisualEffect( VFX_HIT_TURN_UNDEAD );
		effect eDamage;
		effect eHeal;	
		
		location lMyLocation = GetLocation( OBJECT_SELF );
	    effect eImpactVis = EffectVisualEffect(VFX_FEAT_TURN_UNDEAD);
	    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpactVis, lMyLocation);
	
		float fSize = 2.0 * RADIUS_SIZE_COLOSSAL;
		object oTarget = GetFirstObjectInShape( SHAPE_SPHERE, fSize, lMyLocation, TRUE );	
	    while( GetIsObjectValid(oTarget))
	    {
	        if( spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF )
	        {
	                if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
	                {
	                        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_TURN_UNDEAD));
	                        DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
							nDamage = GenerateTurnDamage(nDamageDice, nEnergyLevel);
							
							if (WillSave(oTarget, nDC, SAVING_THROW_WILL, OBJECT_SELF) == SAVING_THROW_CHECK_SUCCEEDED)
							{
								nDamage = nDamage/2;
							}
							eDamage = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
	                        DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));						
	                }
	        }
			else
			{
		        if( spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF)  )
		        {
		    		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_TURN_UNDEAD, FALSE));
					
					nDamage = GenerateTurnDamage(nDamageDice, nEnergyLevel);
					eHeal = EffectHeal(nDamage);
		    		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
		        }			
			}
			oTarget = GetNextObjectInShape( SHAPE_SPHERE, fSize, lMyLocation, TRUE );
	    }		
	
	}
	DecrementRemainingFeatUses(OBJECT_SELF, 294);
	DecrementRemainingFeatUses(OBJECT_SELF, 294);
	
}
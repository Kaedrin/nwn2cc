//::///////////////////////////////////////////////
//:: Elemental Storm
//:: cmi_s2_elemstorm
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: May 13, 2008
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"
#include "cmi_ginc_wpns"


// Needs Ranged Touch attack against targets

void main()
{
	int nSpellID = ELEM_ARCHER_ELEM_STORM;
	int nDamageType = 0;	
	int nLevel = GetLevelByClass(CLASS_ELEM_ARCHER, OBJECT_SELF);
	
	if (IsElemArcherStateValid())
	{	
		object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);

		int nTargets = 5;		
		if (GetHasFeat(FEAT_ELEM_ARCHER_IMP_ELEM_STORM))
		{
			nTargets = 10;
		}	
				
		int nElec=0;
		int nFire=0;
		int nCold=0;
		int nAcid=0;
		
		int nDamageBonus = nLevel + d6(2);
		if (GetHasFeat(FEAT_ELEM_ARCHER_IMP_ELEM_STORM))
		{
			nDamageBonus = nLevel + d6(4);
		}
		if (GetHasFeat(FEAT_ELEM_ARCHER_PATH_AIR))
			nElec += nDamageBonus;
		else
		if (GetHasFeat(FEAT_ELEM_ARCHER_PATH_EARTH))
			nAcid += nDamageBonus;
		else
		if (GetHasFeat(FEAT_ELEM_ARCHER_PATH_FIRE))
			nFire += nDamageBonus;
		else
		if (GetHasFeat(FEAT_ELEM_ARCHER_PATH_WATER))
			nCold += nDamageBonus;				
		
		
		effect AttackEffect = GenerateAttackEffect(OBJECT_SELF, oWeapon, 0, 0, 0, nAcid,
		nCold, nElec, nFire, 0, 0, 0, 0, 0);
		//effect eDmg = EffectDamage(nDamageBonus, nDamageType); 
		//effect eLink = EffectLinkEffects(eDmg, AttackEffect);
		
		
		int nLauncherBaseItemType = GetBaseItemType( oWeapon );
		if ( nLauncherBaseItemType != BASE_ITEM_LONGBOW &&
			 nLauncherBaseItemType != BASE_ITEM_SHORTBOW )
		{
			nLauncherBaseItemType = BASE_ITEM_SHORTBOW;
		}		
		
    	//object oTarget;
		location lTarget;	    
		int i = 1;
	    float fDist = 0.0;
	    float fDelay = 0.0;
		float fTravelTime;
		location lCaster = GetLocation( OBJECT_SELF );

		
		location spellTarget = GetSpellTargetLocation();
		object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_TREMENDOUS, spellTarget, TRUE, OBJECT_TYPE_CREATURE);
		while (GetIsObjectValid(oTarget) && (i < nTargets))
		{
			if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF) //Additional target check to make sure that the caster cannot be harmed by this spell
			{
				lTarget = GetLocation( oTarget );
				if ( i == 1 )
				{
					fDelay = 0.0f;
				}
				else
				{
					fDelay += 0.1f;
				}
				
				fTravelTime = GetProjectileTravelTime( lCaster, lTarget, PROJECTILE_PATH_TYPE_HOMING );
				
				// Run Touch Attack routine
				
	            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, ELEM_ARCHER_ELEM_STORM));
				DelayCommand( fDelay, SpawnItemProjectile(OBJECT_SELF, oTarget, lCaster, lTarget, nLauncherBaseItemType, PROJECTILE_PATH_TYPE_HOMING, OVERRIDE_ATTACK_RESULT_HIT_SUCCESSFUL, DAMAGE_TYPE_SONIC) );
	            DelayCommand( fDelay + fTravelTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, AttackEffect, oTarget));
	
				i++;	
			}
			oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_TREMENDOUS, spellTarget, TRUE, OBJECT_TYPE_CREATURE);	
		}
	}
	else
	{		
	
	}	
}
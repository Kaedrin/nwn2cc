//::///////////////////////////////////////////////
//:: Beholder AI and Attack Include
//:: x2_inc_beholder
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

    Include file for several beholder functions

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: August, 2003
//:://////////////////////////////////////////////

#include "x0_i0_spells"

const int BEHOLDER_RAY_DEATH = 1;
const int BEHOLDER_RAY_TK = 2;
const int BEHOLDER_RAY_PETRI= 3;
const int BEHOLDER_RAY_CHARM_MONSTER = 4;
const int BEHOLDER_RAY_SLOW = 5;
const int BEHOLDER_RAY_WOUND = 6;
const int BEHOLDER_RAY_FEAR = 7;
const int BEHOLDER_RAY_CHARM_PERSON = 8;
const int BEHOLDER_RAY_SLEEP = 9;
const int BEHOLDER_RAY_DISINTIGRATE = 10;

struct beholder_target_struct
{
        object oTarget1;
        int nRating1;
        object oTarget2;
        int nRating2;
        object oTarget3;
        int nRating3;
        int nCount;
};



int   GetAntiMagicRayMakesSense ( object oTarget );
void  OpenAntiMagicEye          ( object oTarget );
void  CloseAntiMagicEye         ( object oTarget );
int   BehGetTargetThreatRating  ( object oTarget );
int   BehDetermineHasEffect     ( int nRay, object oCreature );
void  BehDoFireBeam             ( int nRay, object oTarget );

struct beholder_target_struct GetRayTargets ( object oTarget );

int GetAntiMagicRayMakesSense(object oTarget)
{
    int bRet = TRUE;
    int nType;
	
	object oNear = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oTarget);
	float fDistance = GetDistanceBetween(oTarget, oNear);

    effect eTest = GetFirstEffect(oTarget);

    if (!GetIsEffectValid(eTest))
    {
      int nMag = GetLevelByClass(CLASS_TYPE_WIZARD,oTarget) + GetLevelByClass(CLASS_TYPE_SORCERER,oTarget) + GetLevelByClass(CLASS_TYPE_BARD,oTarget) + GetLevelByClass(CLASS_TYPE_RANGER,oTarget) + GetLevelByClass(CLASS_TYPE_PALADIN,oTarget);
      // at least 3 levels of magic user classes... we better use anti magic anyway
      if (nMag < 4)
      {
        bRet = FALSE;
      }
    }
		
    else
    {		
        while (GetIsEffectValid(eTest) && bRet == TRUE )
        {
            nType = GetEffectType(eTest);
            if (nType == EFFECT_TYPE_STUNNED || nType == EFFECT_TYPE_PARALYZE  ||
                nType == EFFECT_TYPE_SLEEP || nType == EFFECT_TYPE_PETRIFY  ||
                nType == EFFECT_TYPE_CHARMED  || nType == EFFECT_TYPE_CONFUSED ||
                nType == EFFECT_TYPE_FRIGHTENED || nType == EFFECT_TYPE_SLOW )
            {
                bRet = FALSE;
            }

            eTest = GetNextEffect(oTarget);
        }
    }
	
	if(fDistance > 30.0 || !GetIsInCombat(oNear))
	{
		bRet = FALSE;
	}
	if(GetHasSpellEffect(SPELL_LEAST_SPELL_MANTLE, oTarget) || GetHasSpellEffect(SPELL_LESSER_SPELL_MANTLE, oTarget) ||
		GetHasSpellEffect(SPELL_SPELL_MANTLE, oTarget) || GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE, oTarget) ||
		GetHasSpellEffect(SPELL_DEATH_WARD, oTarget) || GetHasSpellEffect(SPELL_SPELL_RESISTANCE, oTarget) ||
		GetHasSpellEffect(SPELL_REGENERATE, oTarget) || GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT, oTarget) ||
		GetHasSpellEffect(SPELL_DEATH_WARD, oTarget) || GetHasSpellEffect(SPELL_SPELL_RESISTANCE, oTarget) ||
		GetHasSpellEffect(SPELL_SUPERIOR_RESISTANCE, oTarget) || GetHasSpellEffect(SPELL_PREMONITION, oTarget) ||
		GetHasSpellEffect(SPELL_POLYMORPH_SELF, oTarget) || GetHasSpellEffect(SPELL_ETHEREAL_VISAGE, oTarget) ||
		GetHasSpellEffect(SPELL_HEROISM, oTarget) || GetHasSpellEffect(SPELL_GREATER_HEROISM, oTarget) ||
		GetHasSpellEffect(SPELL_SHADOW_SHIELD, oTarget) || GetHasSpellEffect(SPELL_SHADES_TARGET_CASTER, oTarget))
		{
			bRet = TRUE;
		}
    if (GetHasSpellEffect(727,oTarget)) // already antimagic
    {
        bRet = FALSE;
    }

    return bRet;
}


void OpenAntiMagicEye (object oTarget)
{
   if (GetAntiMagicRayMakesSense(oTarget))
   {
   		ClearAllActions();
        ActionCastSpellAtObject(727 , GetSpellTargetObject(),METAMAGIC_ANY,TRUE,0, PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
   }
}

// being a badass beholder, we close our antimagic eye only to attack with our eye rays
// and then reopen it...
void CloseAntiMagicEye(object oTarget)
{
    RemoveSpellEffects (727,OBJECT_SELF,oTarget);
}


// stacking protection
int BehDetermineHasEffect(int nRay, object oCreature)
{
  switch (nRay)
  {
       case BEHOLDER_RAY_FEAR :     if (GetHasEffect(EFFECT_TYPE_FRIGHTENED,oCreature))
                                        return TRUE;

       case BEHOLDER_RAY_DEATH :    if (GetIsDead(oCreature))
                                        return TRUE;

      case BEHOLDER_RAY_CHARM_MONSTER:      if (GetHasEffect(EFFECT_TYPE_CHARMED,oCreature))
                                        return TRUE;

      case BEHOLDER_RAY_SLOW:      if (GetHasEffect(EFFECT_TYPE_SLOW,oCreature))
                                        return TRUE;

      case BEHOLDER_RAY_PETRI:       if (GetHasEffect(EFFECT_TYPE_PETRIFY,oCreature))
                                        return TRUE;
										
	  case BEHOLDER_RAY_SLEEP:       if (GetHasEffect(EFFECT_TYPE_SLEEP,oCreature))
                                        return TRUE;
  }

    return FALSE;
}


int BehGetTargetThreatRating(object oTarget)
{
    if (oTarget == OBJECT_INVALID)
    {
        return 0;
    }

    int nRet = 20;

    if (GetDistanceBetween(oTarget,OBJECT_SELF) <5.0f)
    {
        nRet += 5;
		
		if(GetHitDice(OBJECT_SELF) <= GetHitDice(oTarget) - 3)
		{
			nRet += 3;
		}
    }
	if (GetDistanceBetween(oTarget,OBJECT_SELF) >15.0f)
    {
        nRet += 3;
    }

    nRet += (GetHitDice(oTarget)-GetHitDice(OBJECT_SELF) /2);
	
	if (GetLevelByClass(CLASS_TYPE_FIGHTER, oTarget) > 3 ||
		GetLevelByClass(CLASS_TYPE_BARBARIAN, oTarget) > 3 ||
		GetLevelByClass(CLASS_TYPE_MONK, oTarget) > 3 ||
		GetLevelByClass(CLASS_TYPE_RANGER, oTarget) > 3)
	{
		nRet += 3;
	}
	if (GetLevelByClass(CLASS_TYPE_ROGUE, oTarget) > 3 ||
		GetLevelByClass(CLASS_TYPE_WARLOCK, oTarget) > 3 ||
		GetLevelByClass(CLASS_TYPE_BARD, oTarget) > 3 ||
		GetLevelByClass(CLASS_TYPE_DRUID, oTarget) > 3 ||
		GetLevelByClass(CLASS_TYPE_PALADIN, oTarget) > 3)
	{
		nRet += 4;
	}
	if (GetLevelByClass(CLASS_TYPE_CLERIC, oTarget) > 3 ||
		GetLevelByClass(CLASS_TYPE_SORCERER, oTarget) > 3 ||
		GetLevelByClass(CLASS_TYPE_WIZARD, oTarget) > 3 ||
		GetLevelByClass(CLASS_TYPE_FAVORED_SOUL, oTarget) > 3 ||
		GetLevelByClass(CLASS_TYPE_SPIRIT_SHAMAN, oTarget) > 3)
	{
		nRet += 5;
	}

    if (GetPlotFlag(oTarget)) //
    {
        nRet -= 6 ;
    }

    if (GetMaster(oTarget)!= OBJECT_INVALID)
    {
        nRet -= 4;
    }

    if (GetHasEffect(EFFECT_TYPE_PETRIFY,oTarget))
    {
        nRet -=10;
    }
	
	if (GetArcaneSpellFailure(oTarget) == 100)
    {
        nRet -=10;
    }
	
	if (GetHasEffect(EFFECT_TYPE_SLEEP,oTarget))
    {
        nRet -=3;
    }
	
	if (GetHasEffect(EFFECT_TYPE_FRIGHTENED,oTarget))
    {
        nRet -=5;
    }
	
	if (GetHasEffect(EFFECT_TYPE_SLOW,oTarget))
    {
        nRet -=5;
    }

    if (GetIsDead(oTarget))
    {
        nRet = 0;
    }

    return nRet;

}


struct beholder_target_struct GetRayTargets(object oTarget)
{

    struct beholder_target_struct stRet;
    object oTarget1;
    object oTarget2;
    object oTarget3;
    int nTarget1;
    int nTarget2;
    int nTarget3;
    int nCount = 0;
	int nNth = 1;
	int nCheck = 0;
    if (oTarget != OBJECT_INVALID)
    {
		oTarget1 = oTarget;
        nCount ++;
        nTarget1 = BehGetTargetThreatRating(oTarget1);

        oTarget2 =  GetNearestCreature(CREATURE_TYPE_IS_ALIVE,CREATURE_ALIVE_TRUE,oTarget1,nNth);
        while(GetIsObjectValid(oTarget2) && nCheck != 1)
        {
			if(GetIsFriend(oTarget1, oTarget2))
			{
            	nTarget2 = BehGetTargetThreatRating(oTarget2);
            	nCount ++;
				nCheck = 1;
			}
			else
			{
				nNth++;
				oTarget2 =  GetNearestCreature(CREATURE_TYPE_IS_ALIVE,CREATURE_ALIVE_TRUE,oTarget1,nNth);
			}
        }
		nCheck=0;	
		nNth=1;
        oTarget3 =  GetNearestCreature(CREATURE_TYPE_IS_ALIVE,CREATURE_ALIVE_TRUE,oTarget2,nNth);
        while(GetIsObjectValid(oTarget3) && nCheck != 1)
        {
			if(GetIsFriend(oTarget1, oTarget3))
			{
            	nTarget3 = BehGetTargetThreatRating(oTarget3);
            	nCount ++;
				nCheck = 1;
			}
			else
			{
				nNth++;
				oTarget3 =  GetNearestCreature(CREATURE_TYPE_IS_ALIVE,CREATURE_ALIVE_TRUE,oTarget2,nNth);
			}
        }
    }


    stRet.oTarget1 = oTarget1;
    stRet.nRating1 = nTarget1;
    if (oTarget2 != OBJECT_INVALID)
    {
        stRet.oTarget2 = oTarget2;
        stRet.nRating2 = nTarget2;
    }
    else
    {
        stRet.oTarget2 = oTarget1;
        stRet.nRating2 = nTarget1;
        nCount =2;
    }

    if (nCount ==3)
    {
        stRet.oTarget3 = oTarget3;
        stRet.nRating3 = nTarget3;
    }
    stRet.nCount =  nCount;


    return stRet;

}


void BehDoFireBeam(int nRay, object oTarget)
{

    // don't use a ray if the target already has that effect
    if (BehDetermineHasEffect(nRay,oTarget))
    {
        return;
    }

    int bHit   = TouchAttackRanged(oTarget,FALSE)>0;
    int nProj;
    switch (nRay)
    {
        case BEHOLDER_RAY_DEATH: nProj = 776;
                            break;
        case BEHOLDER_RAY_TK:    nProj = 777;
                            break;
        case BEHOLDER_RAY_PETRI: nProj = 778;
                            break;
        case BEHOLDER_RAY_CHARM_MONSTER: nProj = 779;
                            break;
        case BEHOLDER_RAY_SLOW:  nProj = 780;
                            break;
        case BEHOLDER_RAY_WOUND: nProj = 783;
                            break;
        case BEHOLDER_RAY_FEAR:  nProj = 784;
                            break;
		case BEHOLDER_RAY_CHARM_PERSON:  nProj = 785;
                            break;
		case BEHOLDER_RAY_SLEEP:  nProj = 786;
                            break;
		case BEHOLDER_RAY_DISINTIGRATE:  nProj = 787;
                            break;

    }

    if (bHit)
    {
         ActionCastSpellAtObject(nProj,oTarget,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    }
        else
    {
        location lFail = GetLocation(oTarget);
        vector vFail = GetPositionFromLocation(lFail);

        if (GetDistanceBetween(OBJECT_SELF,oTarget) > 6.0f)
        {

           vFail.x += IntToFloat(Random(3)) - 1.5;
           vFail.y += IntToFloat(Random(3)) - 1.5;
           vFail.z += IntToFloat(Random(2));
           lFail = Location(GetArea(oTarget),vFail,0.0f);

        }
        //----------------------------------------------------------------------
        // if we are fairly near, calculating a location could cause us to
        // spin, so we use the same location all the time
        //----------------------------------------------------------------------
        else
        {
              vFail.z += 0.8;
              vFail.y += 0.2;
              vFail.x -= 0.2;
        }
		object oIpoint = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_ipoint ", lFail, FALSE, "beh_ip_ray_targ");
        ActionCastSpellAtObject(nProj,oIpoint,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
		DestroyObject(oIpoint, 1.0);
    }


}
//::///////////////////////////////////////////////
//:: Invisible Needle
//:: cmi_s2_invisneedle
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 12, 2007
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_spells"

int GetForceReserveDamageDice()
{

	if (GetHasSpell(463))
		return 9;
	if (GetHasSpell(462))
		return 8;
	if ( GetHasSpell(123) || GetHasSpell(461) )
		return 7;
	if ( GetHasSpell(448) || GetHasSpell(460) )
		return 6;
	if (GetHasSpell(459))
		return 5;
	if ( GetHasSpell(1863) || GetHasSpell(447) )
		return 4;			
																			
	return 0;
}

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	//Declare major variables
	object oTarget = GetSpellTargetObject();
	int nDamageDice = 0;
	
	nDamageDice = GetForceReserveDamageDice();
	int bIgnoreResists = GetHasFeat(FEAT_IMPROVED_RESERVE_FEATS, OBJECT_SELF);
	int bUseOrbEffect = GetHasFeat(FEAT_RESERVE_FEAT_ENHANCEMENT, OBJECT_SELF); 
		
	effect eOrbEffect = EffectACDecrease(2);
	int nSaveThrow = SAVING_THROW_TYPE_ALL;
	int nDC = GetReserveSpellSaveDC(nDamageDice,OBJECT_SELF);
				 
	if (nDamageDice == 0)
	{
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
	}
	else
	if (GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
		{		
			effect eVis = EffectVisualEffect(VFX_HIT_SPELL_CONJURATION);
			//int nDamage = d4(nDamageDice);
			int nDamage = HandleReserveMeta(nDamageDice, 3);
						
			int nRangedTouch = TouchAttackRanged(oTarget);
			if (nRangedTouch != TOUCH_ATTACK_RESULT_MISS)
			{
						
				nDamage += GetRangedTouchSpecDamage(OBJECT_SELF, nDamageDice , FALSE);	
				if (nRangedTouch == TOUCH_ATTACK_RESULT_CRITICAL)
					nDamage = nDamage * 2;
					
				//include sneak attack damage
				nDamage += EvaluateSneakAttack(oTarget, OBJECT_SELF);					
										
				effect eDamage = EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL, bIgnoreResists);
				
				//Fire cast spell at event for the specified target
				SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));				

				//Apply the effects
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
				
				if (bUseOrbEffect)
				{
                	if  (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, nSaveThrow))
						ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOrbEffect, oTarget, 6.0f);				
				}
			}
		}	
	}			



}
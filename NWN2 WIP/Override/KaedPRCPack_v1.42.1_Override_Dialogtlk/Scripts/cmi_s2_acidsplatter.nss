//::///////////////////////////////////////////////
//:: Acidic Splatter
//:: cmi_s2_acidsplatter
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 11, 2007
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_spells"

int GetAcidReserveDamageDice()
{

	if (GetHasSpell(173))
		return 9;
	if (GetHasSpell(71))
		return 7;	
	if (GetHasSpell(0))
		return 6;	
	if (GetHasSpell(873))
		return 5;	
	if (GetHasSpell(1859) || GetHasSpell(1205))
		return 4;		
	if ( GetHasSpell(523) || GetHasSpell(1753) || GetHasSpell(1814) )
		return 3;		
	if ( GetHasSpell(115) || GetHasSpell(1747) )
		return 2;													
		
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
	
	nDamageDice = GetAcidReserveDamageDice();
		 
	if (nDamageDice == 0)
	{
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
	}
	else
	if (GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
		{		
			effect eVis = EffectVisualEffect(VFX_HIT_SPELL_ACID);
			//int nDamage = d6(nDamageDice);
			int nDamage = HandleReserveMeta(nDamageDice, 6);
						
			int nRangedTouch = TouchAttackRanged(oTarget);
			if (nRangedTouch != TOUCH_ATTACK_RESULT_MISS)
			{
						
				nDamage += GetRangedTouchSpecDamage(OBJECT_SELF, nDamageDice , FALSE);
				if (nRangedTouch == TOUCH_ATTACK_RESULT_CRITICAL)
					nDamage = nDamage * 2;
					
				//include sneak attack damage
				nDamage += EvaluateSneakAttack(oTarget, OBJECT_SELF);					
										
				effect eDamage = EffectDamage(nDamage,DAMAGE_TYPE_ACID);
				
				//Fire cast spell at event for the specified target
				SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));				

				//Apply the effects
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
			
			}
		}	
	}			



}
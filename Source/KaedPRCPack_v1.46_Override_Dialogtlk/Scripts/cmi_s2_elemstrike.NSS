//::///////////////////////////////////////////////
//:: Frightful Attack
//:: cmi_s2_frightatk
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 11, 2009
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	int nVFXHit;
	int nDamageType;
	int nSaveType;
	effect eStatusEffect;	
	
	if (GetHasFeat(FEAT_ELEMWAR_AFFINITY_AIR))
	{
		nSaveType = SAVING_THROW_TYPE_ALL;
		nVFXHit = VFX_HIT_SPELL_LIGHTNING;
		nDamageType = DAMAGE_TYPE_BLUDGEONING;	
		eStatusEffect = EffectKnockdown();	
	}	
	else
	if (GetHasFeat(FEAT_ELEMWAR_AFFINITY_EARTH))
	{	
		nSaveType = SAVING_THROW_TYPE_ALL;	
		nDamageType = DAMAGE_TYPE_BLUDGEONING;	
		nVFXHit = VFX_HIT_SPELL_ACID;
		eStatusEffect = EffectKnockdown();			
	}
	else
	if (GetHasFeat(FEAT_ELEMWAR_AFFINITY_FIRE))
	{
		nSaveType = SAVING_THROW_TYPE_FIRE;	
		nDamageType = DAMAGE_TYPE_FIRE;	
		nVFXHit = VFX_HIT_SPELL_FIRE;
		eStatusEffect = EffectDamage(d6(1), nDamageType);
	}
	else
	if (GetHasFeat(FEAT_ELEMWAR_AFFINITY_WATER))
	{
		nSaveType = SAVING_THROW_TYPE_COLD;	
		nDamageType = DAMAGE_TYPE_MAGICAL;	
		nVFXHit = VFX_HIT_SPELL_ICE;
		eStatusEffect = EffectAttackDecrease(4);	
	}
		
	//Declare major variables
	object oTarget = GetSpellTargetObject();
			 
	if (GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
		{		
			effect eVis = EffectVisualEffect(nVFXHit);
			int nDamage = d6(10);
						
			int nMeleeTouch = TouchAttackMelee(oTarget);
			if (nMeleeTouch != TOUCH_ATTACK_RESULT_MISS)
			{
						
				nDamage += GetMeleeTouchSpecDamage(OBJECT_SELF, 10, FALSE);	
				if (nMeleeTouch == TOUCH_ATTACK_RESULT_CRITICAL)
					nDamage = nDamage * 2;
										
				//include sneak attack damage
				nDamage += EvaluateSneakAttack(oTarget, OBJECT_SELF);
									
				effect eDamage = EffectDamage(nDamage,nDamageType);
				
				//Fire cast spell at event for the specified target
				SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));				

				//Apply the effects
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
				
				int nDC = 15 + GetAbilityModifier(ABILITY_CONSTITUTION);	
                if  (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, nSaveType))
				{
					if (nDamageType != DAMAGE_TYPE_FIRE)
						ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStatusEffect, oTarget, 6.0f);				
					else
						DelayCommand(6.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eStatusEffect, oTarget));
				}
			}
		}	
	}			



}
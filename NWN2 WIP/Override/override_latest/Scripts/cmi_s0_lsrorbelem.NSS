//::///////////////////////////////////////////////
//:: Lesser Orb of Elements
//:: cmi_s0_lsrorbelem
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 22, 2007
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_inc_sneakattack"
#include "cmi_ginc_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	int nPiercingCold = FALSE;
	//Declare major variables
	object oTarget = GetSpellTargetObject();
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	nCasterLvl = nCasterLvl / 2;
	if (nCasterLvl > 5)
		nCasterLvl = 5;
	int nDamage = d8(nCasterLvl);	
		
	effect eVis;	
	effect eOrbEffect;
	int nDamageType;
	int nSpellId = GetSpellId();
	int nSaveThrow;
	
	if (nSpellId == SPELL_Lesser_Orb_Electricity)
	{
		nDamageType	= DAMAGE_TYPE_ELECTRICAL;
		eVis = EffectVisualEffect(VFX_HIT_SPELL_LIGHTNING);
		eOrbEffect = EffectSlow();
		nSaveThrow = SAVING_THROW_TYPE_ELECTRICITY;	
	}
	else
	if (nSpellId == SPELL_Lesser_Orb_Cold)
	{	
		nDamageType	= DAMAGE_TYPE_COLD;
		eVis = EffectVisualEffect(VFX_HIT_SPELL_ICE);
		eOrbEffect = EffectBlindness();
		nSaveThrow = SAVING_THROW_TYPE_COLD;
		nPiercingCold = GetHasFeat(FEAT_FROSTMAGE_PIERCING_COLD);
	}	
	else
	if (nSpellId == SPELL_Lesser_Orb_Fire)
	{
		nDamageType	= DAMAGE_TYPE_FIRE;
		eVis = EffectVisualEffect(VFX_HIT_SPELL_FIRE);
		eOrbEffect = EffectDazed();	
		nSaveThrow = SAVING_THROW_TYPE_FIRE;		
	}
	else
	if (nSpellId == SPELL_Lesser_Orb_Acid)
	{
		nDamageType	= DAMAGE_TYPE_ACID;
		eVis = EffectVisualEffect(VFX_HIT_SPELL_ACID);
		eOrbEffect = EffectAttackDecrease(2);	
		nSaveThrow = SAVING_THROW_TYPE_ACID;		
	}
	else
	if (nSpellId == SPELL_Lesser_Orb_Sound)
	{
		nDamageType	= DAMAGE_TYPE_SONIC;
		eVis = EffectVisualEffect(VFX_HIT_SPELL_SONIC);
		eOrbEffect = EffectDeaf();	
		nSaveThrow = SAVING_THROW_TYPE_SONIC;
		nDamage = d6(nCasterLvl);		
	}			
		  
	if (GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
		{		
		
			int nRangedTouch = TouchAttackRanged(oTarget);
			if (nRangedTouch != TOUCH_ATTACK_RESULT_MISS)
			{
				//if(!MyResistSpell(OBJECT_SELF, oTarget))
				//{				
				
				int nMax = (nCasterLvl*8);
				nDamage = ApplyMetamagicVariableMods( nDamage, nMax );
								
				nDamage += GetRangedTouchSpecDamage(OBJECT_SELF, nCasterLvl, FALSE);
					
				if (nRangedTouch == TOUCH_ATTACK_RESULT_CRITICAL && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT, OBJECT_SELF))
					nDamage = nDamage * 2;
					
				if (nSpellId == SPELL_Lesser_Orb_Sound && GetHasSpellEffect(FEAT_LYRIC_THAUM_SONIC_MIGHT,OBJECT_SELF))					
					nDamage += d6(1);					
					
				//include sneak attack damage
				nDamage += EvaluateSneakAttack(oTarget, OBJECT_SELF);			
					
				effect eDamage;					
				if (nPiercingCold)
				{
					nDamage = AdjustPiercingColdDamage(nDamage, oTarget);
				 	eDamage = EffectDamage(nDamage,nDamageType, DAMAGE_POWER_NORMAL, nPiercingCold);
					nSaveThrow = SAVING_THROW_TYPE_ALL;
				}
				else
					eDamage = EffectDamage(nDamage,nDamageType);
				
				//Fire cast spell at event for the specified target
				SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));				

				//Apply the effects
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
				
                if  (!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), nSaveThrow))
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOrbEffect, oTarget, 6.0f);
				
				
				//}
			}
		}	
	}			



}
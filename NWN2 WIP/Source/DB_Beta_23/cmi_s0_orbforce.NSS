//::///////////////////////////////////////////////
//:: Orb of Force
//:: cmi_s0_orbforce
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Jan 1, 2008
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_spells"


void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	//Declare major variables
	object oTarget = GetSpellTargetObject();
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	
	if (nCasterLvl > 10)
		nCasterLvl = 10;
	int nDamage = d6(nCasterLvl);	
	int nSaveThrow;	
		
	effect eVis;	
	int nDamageType;
	int nSpellId = GetSpellId();
	

	nDamageType	= DAMAGE_TYPE_MAGICAL;
	eVis = EffectVisualEffect(VFX_HIT_SPELL_MAGIC);
	
	if (GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
		{		
		
			int nRangedTouch = TouchAttackRanged(oTarget);
			if (nRangedTouch != TOUCH_ATTACK_RESULT_MISS)
			{
				//if(!MyResistSpell(OBJECT_SELF, oTarget))
				//{		
						
				int nMax = (nCasterLvl*6);
				nDamage = ApplyMetamagicVariableMods( nDamage, nMax );	
				
				/*
				if (GetLevelByClass(CLASS_FORCE_MAGE, OBJECT_SELF) > 4)
				{
					int nMeta = GetMetaMagicFeat();
					if (nMeta == METAMAGIC_MAXIMIZE)
						nDamage = (nMax*3)/2;
					else
					if (nMeta != METAMAGIC_EMPOWER)
						nDamage = (nDamage*3)/2;	
				}
				*/				
				
				
				
				nDamage += GetRangedTouchSpecDamage(OBJECT_SELF, nCasterLvl, FALSE);
				if (nRangedTouch == TOUCH_ATTACK_RESULT_CRITICAL && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT, OBJECT_SELF))
					nDamage = nDamage * 2;
				
				//include sneak attack damage
				nDamage += EvaluateSneakAttack(oTarget, OBJECT_SELF);	
														
				effect eDamage = EffectDamage(nDamage,nDamageType);
				
				//Fire cast spell at event for the specified target
				SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));				

				//Apply the effects
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);		
				
				//}
			}
		}	
	}			



}
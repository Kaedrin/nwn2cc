//::///////////////////////////////////////////////
//:: Polar Ray
//:: [nw_s0_polarray.nss]
//:: Copyright (c) 2006 Obsidian Entertainment, Inc.
//:://////////////////////////////////////////////
/*
    If the caster succeeds at a ranged touch attack
    the target takes 1d6 cold damage/caster level
	(max 25d6).
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Woo (AFW-OEI)
//:: Created On: 06/06/2006
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"    
#include "x2_inc_spellhook" 
#include "cmi_inc_sneakattack"
#include "cmi_ginc_spells"

void main()
{
    if (!X2PreSpellCastCode())
    {	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nDmgType = DAMAGE_TYPE_COLD;
	int nHasPierceCold = FALSE;	
	if (GetHasFeat(FEAT_FROSTMAGE_PIERCING_COLD))
	{
		nHasPierceCold = TRUE;
	}	
	

    //Declare major variables
    object oTarget	 	= GetSpellTargetObject();
	int    nCasterLevel = GetCasterLevel(OBJECT_SELF);
	int nTouch      = TouchAttackRanged(oTarget);
	
	if (nCasterLevel > 25)	// Cap caster level
		nCasterLevel = 25;
	else if (nCasterLevel <= 0)
		nCasterLevel = 1;

    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_POLAR_RAY));

		if (nTouch != TOUCH_ATTACK_RESULT_MISS)
		{	//Make SR Check
	        if(!MyResistSpell(OBJECT_SELF, oTarget))
	        {
	            //Enter Metamagic conditions
	 			int nDam = d6(nCasterLevel);
	    		int nMetaMagic = GetMetaMagicFeat();
	            if (nMetaMagic == METAMAGIC_MAXIMIZE)
	            {
	                nDam = 6 * nCasterLevel ;//Damage is at max
	            }
	            else if (nMetaMagic == METAMAGIC_EMPOWER)
	            {
	                nDam = nDam + nDam/2; //Damage/Healing is +50%
	            }
		

				nDam += GetRangedTouchSpecDamage(OBJECT_SELF, nCasterLevel, FALSE);	
									
				if (nTouch == TOUCH_ATTACK_RESULT_CRITICAL && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT))
				{
					nDam = nDam*2;
				}						

				//include sneak attack damage
				if (StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_SneakAttackSpells)))
					nDam += EvaluateSneakAttack(oTarget, OBJECT_SELF);

				if (nHasPierceCold)
				{
					nDam = AdjustPiercingColdDamage(nDam, oTarget);
				}
					
	            //Set damage effect
	            effect eDam = EffectDamage(nDam, nDmgType, DAMAGE_POWER_NORMAL, nHasPierceCold);
	   	 		effect eVis = EffectVisualEffect(VFX_HIT_SPELL_ICE);
	
	            //Apply the VFX impact and damage effect
	            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
	            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
	        }
		}
    }
	
    effect eRay = EffectBeam(VFX_BEAM_ICE, OBJECT_SELF, BODY_NODE_HAND);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
}
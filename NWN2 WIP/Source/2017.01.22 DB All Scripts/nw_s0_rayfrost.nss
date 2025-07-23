//::///////////////////////////////////////////////
//:: Ray of Frost
//:: [NW_S0_RayFrost.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If the caster succeeds at a ranged touch attack
    the target takes 1d4 damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: feb 4, 2001
//:://////////////////////////////////////////////
//:: Bug Fix: Andrew Nobbs, April 17, 2003
//:: Notes: Took out ranged attack roll.
//:://////////////////////////////////////////////
//:: AFW-OEI 06/06/2006:
//::	Pur ranged touch attack back in.
//::PKM-OEI: 05.28.07: Touch attacks now do critical hit damage
//::   - Modernized the metamagic behavior


#include "NW_I0_SPELLS"    
#include "x2_inc_spellhook" 
#include "nwn2_inc_spells"
#include "cmi_inc_sneakattack"
#include "cmi_ginc_spells"

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  
*/

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

	int nDmgType = DAMAGE_TYPE_COLD;	
	int nHasPierceCold = FALSE;
	if (GetHasFeat(FEAT_FROSTMAGE_PIERCING_COLD))
	{
		nHasPierceCold = TRUE;
	}	


    //Declare major variables
    object oTarget = GetSpellTargetObject();
	int nTouch      = TouchAttackRanged(oTarget);

    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAY_OF_FROST));

		if (nTouch != TOUCH_ATTACK_RESULT_MISS)
		{	//Make SR Check
	        if(!MyResistSpell(OBJECT_SELF, oTarget))
	        {
	            //Enter Metamagic conditions
	 			int nDam = d4(1)+1;
				nDam = ApplyMetamagicVariableMods(nDam, 5);
				nDam += GetRangedTouchSpecDamage(OBJECT_SELF, 1, FALSE);
	    		
				if (nTouch == TOUCH_ATTACK_RESULT_CRITICAL && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT))
				{
					nDam = d4(2)+2;
					nDam = ApplyMetamagicVariableMods(nDam, 10);
					nDam += GetRangedTouchSpecDamage(OBJECT_SELF, 2, TRUE);
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
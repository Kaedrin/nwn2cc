//::///////////////////////////////////////////////
//:: Orb of Cold, Lesser.
//:: NX2_S0_OrbColdLess.nss
//:://////////////////////////////////////////////
/*
    An orb of acid about 2 inches across
	shoots from your palm at its target,
	dealing 1d8 points of acid damage. You
	must succeed on a ranged touch attack
	to hit your target.
	For every two caster levels beyond
	1st, your orb deals an additional 1d8
	points of damage: 2d8 at 3rd level,
	3d8 at 5th level, 4d8 at 7th level, and
	the maximum of 5d8 at 9th level or
	higher.
	
	Fort Save failure = blinded for one round
*/
//:://////////////////////////////////////////////
//:: Created By: Justin Reynard (JWR-OEI)
//:: Created On: July 30 2008
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
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

	int nPiercingCold = GetHasFeat(FEAT_FROSTMAGE_PIERCING_COLD);		
	object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
	int nDice = 1;
	int nDamage = 0;
	// Calculate damage.
	if (nCasterLevel >= 9)
		nDice = 5;
	else if (nCasterLevel >= 7)
		nDice = 4;
	else if (nCasterLevel >= 5)
		nDice = 3;
	else if (nCasterLevel >= 3)
		nDice = 2;
		
	// calculate base damage	
	nDamage = d8(nDice);	
	if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
	{
		 SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LESSER_ORB_OF_ELECTRICITY));
		 
		 int nRangedTouch = TouchAttackRanged(oTarget);		 
		 if (nRangedTouch != TOUCH_ATTACK_RESULT_MISS)
		 {
		 // Orb spells are not resisted!!
		 	int nMetaMagic = GetMetaMagicFeat();
			if (nMetaMagic == METAMAGIC_MAXIMIZE)
     	    {
      		   	// do MAXIMIZE 8 * nDice
				nDamage = 8 * nDice;
       	 	}
         	if (nMetaMagic == METAMAGIC_EMPOWER)
         	{
            	// DO EMPOWER damage * 1.5
				nDamage = nDamage + (nDamage/2);
         	}
			
			nDamage += GetRangedTouchSpecDamage(OBJECT_SELF, nDice, FALSE);
					
			if (nRangedTouch == TOUCH_ATTACK_RESULT_CRITICAL && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT, OBJECT_SELF))
				nDamage = nDamage * 2;
					
			//include sneak attack damage
			nDamage += EvaluateSneakAttack(oTarget, OBJECT_SELF);			
			
			// Savint throw for blindness
			if(!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC()))
			{
				// failed saving throw, uh oh! Blinded!
				effect eBlind = EffectBlindness();
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oTarget, RoundsToSeconds(1));
			}
			
			if (nPiercingCold)
				nDamage = AdjustPiercingColdDamage(nDamage, oTarget);
							
			effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_COLD, DAMAGE_POWER_NORMAL, nPiercingCold);
			// visual!!!!
			//effect eVis = EffectVisualEffect(VFX_HIT_SPELL_FIRE);
		    //effect eLink = EffectLinkEffects(eFireDamage, eVis);
			ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
				 	
		 }
		 
	}
	
	}
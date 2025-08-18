//::///////////////////////////////////////////////
//:: Thunderstrike
//:: cmi_s2_thundstruck
//:://////////////////////////////////////////////

// Based on Polar Ray code by OEI

#include "NW_I0_SPELLS"    
#include "x2_inc_spellhook" 
#include "cmi_inc_sneakattack"
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{
    if (!X2PreSpellCastCode())
    {	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	int nSpellID = STORMSINGER_THUNDERSTRIKE;

    //Declare major variables
    object oTarget = GetSpellTargetObject();
	int nTouch = TouchAttackRanged(oTarget);
	
	int nDC = 10 + GetLevelByClass(CLASS_STORMSINGER) + GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF);
	nDC += GetDCBonusByLevel(OBJECT_SELF);
	
	int nDamage = GetSkillRank(SKILL_PERFORM);
	
	if (nDamage < 11) //Short circuit
	{
		SendMessageToPC(OBJECT_SELF, "Insufficient Perform skill, you need 11 or more to use this ability.");
		return;
	}
	if (!GetHasFeat(257))
	{
		SpeakString("No uses of the Bard Song ability are available");
		return;
	}
	else
	{
		DecrementRemainingFeatUses(OBJECT_SELF, 257);		
	}	
	
	nDamage += d20();
	nDamage += GetRangedTouchSpecDamage(OBJECT_SELF, 1, FALSE);
		
	//Stormpower
	nDamage += 2;	
	
	if (nTouch == TOUCH_ATTACK_RESULT_CRITICAL && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT))
	{
		nDamage = nDamage*2;
	}

    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID));

		if (nTouch != TOUCH_ATTACK_RESULT_MISS)
		{			
				//include sneak attack damage
				nDamage += EvaluateSneakAttack(oTarget, OBJECT_SELF);	
								
				if (MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC))
				{
					//Save Made
					nDamage = nDamage/2;
		            effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
		   	 		effect eVis = EffectVisualEffect(VFX_HIT_SPELL_LIGHTNING);
		            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
		            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);					
				}
				else
				{
					//Save Failed
		            effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
		   	 		effect eVis = EffectVisualEffect(VFX_HIT_SPELL_LIGHTNING);
					effect eDeaf = EffectDeaf();
		            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
		            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);	
					if (!GetIsImmune(oTarget, IMMUNITY_TYPE_DEAFNESS) && !MySavingThrow(SAVING_THROW_FORT, oTarget, nDC))
					{
						ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeaf, oTarget, RoundsToSeconds(nDamage));		
					}						
				}
	

		}
    }
	
    effect eBeam = EffectBeam(VFX_BEAM_SONIC, OBJECT_SELF, BODY_NODE_HAND);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, 1.5);
}
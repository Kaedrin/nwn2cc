//::///////////////////////////////////////////////
//:: Elemental Strike
//:: cmi_s2_elemstrike
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 11, 2008
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"
#include "cmi_ginc_wpns"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
		
	//Declare major variables
	object oTarget = GetSpellTargetObject();
			 
	if (GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
		{		
			effect eVis = EffectVisualEffect(VFX_HIT_SPELL_ACID);	
			object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
			effect AttackEffect = GenerateAttackEffect(OBJECT_SELF, oWeapon);
					
			int nMeleeTouch = TouchAttackMelee(oTarget);
			if (nMeleeTouch != TOUCH_ATTACK_RESULT_MISS)
			{
				int nGFK = GetLevelByClass(CLASS_GHOST_FACED_KILLER, OBJECT_SELF);		
				//Fire cast spell at event for the specified target
				SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));				

				//Apply the effects
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, AttackEffect, oTarget);
			
				effect eAB = EffectAttackDecrease(2);
				effect eSave = EffectSavingThrowDecrease(SAVING_THROW_ALL, 2, SAVING_THROW_TYPE_FEAR);
				effect eSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, 2);
				effect eStatusEffect = EffectLinkEffects(eAB, eSkill);
				eStatusEffect = EffectLinkEffects(eStatusEffect, eSave);
										
				int nDC = 10 + GetAbilityModifier(ABILITY_CHARISMA) + nGFK;
								
				if (!GetIsImmune(oTarget, IMMUNITY_TYPE_FEAR) && !GetIsImmune(oTarget, IMMUNITY_TYPE_MIND_SPELLS) )
				{
				 if (GetHitDice(oTarget) <= GetHitDice(OBJECT_SELF))
				 {
					if  (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR))
					{
						effect eDeath = EffectDeath();	
						ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);										
					}
					else
					{
						ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStatusEffect, oTarget, RoundsToSeconds(nGFK));									
					}				 
				 }
				}
				
				location lTarget = GetSpellTargetLocation();
				object oViewingTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE,OBJECT_TYPE_CREATURE);
				while (GetIsObjectValid(oViewingTarget))
				{
					if ((oViewingTarget != oTarget) && (spellsIsTarget(oViewingTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF)))
					{
				    	//Fire cast spell at event for the specified target
				    	SignalEvent(oViewingTarget, EventSpellCastAt(OBJECT_SELF, 2054));
						
						if (!GetIsImmune(oViewingTarget, IMMUNITY_TYPE_FEAR) && !GetIsImmune(oViewingTarget, IMMUNITY_TYPE_MIND_SPELLS) )
						{
						 if (GetHitDice(oViewingTarget) <= GetHitDice(OBJECT_SELF))
						 {
							if  (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR))
							{
								ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStatusEffect, oViewingTarget, RoundsToSeconds(nGFK));									
							}						 
						 }
						}												
					}	
					oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE);		
				}							
			}
		}	
	}			



}
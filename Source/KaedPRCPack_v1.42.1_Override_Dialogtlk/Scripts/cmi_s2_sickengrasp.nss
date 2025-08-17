//::///////////////////////////////////////////////
//:: Sickening Grasp
//:: cmi_s2_sickengrasp
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 11, 2007
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"

int GetNecroReserveLevel()
{

	if ( GetHasSpell(51) || GetHasSpell(190) )
		return 9;		

	if ( GetHasSpell(29) || GetHasSpell(367) || GetHasSpell(898) || GetHasSpell(1018) )
		return 8;						

	if ( GetHasSpell(28) || GetHasSpell(56) || GetHasSpell(366) || GetHasSpell(895) || 
		GetHasSpell(1032) || GetHasSpell(1796) )
		return 7;		
				
	if ( GetHasSpell(18) || GetHasSpell(30) || GetHasSpell(77) || GetHasSpell(528) || GetHasSpell(892) )
		return 6;
		
	if ( GetHasSpell(19) || GetHasSpell(23) || GetHasSpell(164) || GetHasSpell(1017) )
		return 5;					

	if ( GetHasSpell(38) || GetHasSpell(52) || GetHasSpell(435) || GetHasSpell(1773) )
		return 4;
		
	if ( GetHasSpell(2) || GetHasSpell(27) || GetHasSpell(54) || GetHasSpell(129) || GetHasSpell(188) || 
		GetHasSpell(434) || GetHasSpell(513) || GetHasSpell(1036) )
		return 3;
										
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
	int nDuration = 0;
	
	nDuration = GetNecroReserveLevel();
		 
	if (nDuration == 0)
	{
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
	}
	else
	if (GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
		{		
			effect eVis = EffectVisualEffect(VFX_HIT_WEAKEN_SPIRITS);
			effect eDamageDecrease = EffectDamageDecrease(2);
			effect eAB = EffectAttackDecrease(2);
			effect eSave = EffectSavingThrowDecrease(SAVING_THROW_ALL,2,SAVING_THROW_TYPE_ALL);
			effect eSkill = EffectSkillDecrease(SKILL_ALL_SKILLS,2);
			
			effect eLink = EffectLinkEffects(eSkill, eSave);
			eLink = EffectLinkEffects(eLink,eAB);
			eLink = EffectLinkEffects(eLink,eDamageDecrease);
			
			//A sickened creature takes a -2 penalty on attack rolls, weapon damage rolls, 
			//saving throws, skill checks, and ability checks.
			
			//Hmm.  Not going to do the ability check part for now as that would be a 
			//-4 to all stats which is huge for an unlimited use feat.
						
			int nMeleeTouch = TouchAttackMelee(oTarget);
			if (nMeleeTouch != TOUCH_ATTACK_RESULT_MISS)
			{	
				
				//Fire cast spell at event for the specified target
				SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));				
				int nDC = GetReserveSpellSaveDC(nDuration,OBJECT_SELF);
				//Apply the effects
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
					
                if  (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DISEASE))
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));	
				else
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 6.0f);				
			
			}
		}	
	}			



}
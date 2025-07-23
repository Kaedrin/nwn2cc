//::///////////////////////////////////////////////
//:: Hurricane Breath
//:: cmi_s2_hurricbreath
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 11, 2007
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 

int GetAirReserveDamageDice()
{

	if (GetHasSpell(48))
		return 9;
	else
	if (GetHasSpell(2026))
		return 5;
	else
	if (GetHasSpell(75))
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
	
	nDamageDice = GetAirReserveDamageDice();
		 
	if (nDamageDice == 0)
	{
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
	}
	else
	if (GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
		{		
			effect eVis = EffectVisualEffect(VFX_HIT_SPELL_TOUCH_OF_FATIGUE);
					
				effect eEffect = EffectKnockdown();
				
				int nKnockdownStrength = d20(1) + nDamageDice;
				int nMental = GetHighestMentalStatModifier(OBJECT_SELF);
				if (nMental > 2)
					nMental = 2;
				nKnockdownStrength += nMental;
				
				int nEnemyStr = GetAbilityModifier(ABILITY_STRENGTH,oTarget);
				int nEnemyDex = GetAbilityModifier(ABILITY_DEXTERITY,oTarget);
				int nEnemyKDStrength;	
							
				if (nEnemyStr > nEnemyDex)
					nEnemyKDStrength = d20(1) + nEnemyStr;
				else
					nEnemyKDStrength = d20(1) + nEnemyDex;

				
				if (nKnockdownStrength > nEnemyKDStrength)
				{
					//Fire cast spell at event for the specified target
					SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));				
	
					//Apply the effects
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 6.0f);
					ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
				}
		}	
	}			



}
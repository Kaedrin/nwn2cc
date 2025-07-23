//::///////////////////////////////////////////////
//:: Healing Touch
//:: cmi_s2_healingtouch
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 1, 2007
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 

#include "cmi_ginc_chars"

int GetHealingReserveLevel()
{

	if ( GetHasSpell(897) || GetHasSpell(114) )
		return 8;	
					
	if ( GetHasSpell(894) || GetHasSpell(374) || GetHasSpell(70) || GetHasSpell(153) )
		return 7;						
			
	if ( GetHasSpell(891) || GetHasSpell(79) || GetHasSpell(1023) )
		return 6;					
		
	if ( GetHasSpell(80) || GetHasSpell(1030) || GetHasSpell(142) || GetHasSpell(1004) )
		return 5;						

	if ( GetHasSpell(31) || GetHasSpell(152) )
		return 4;																
		
	if ( GetHasSpell(35) || GetHasSpell(126) || GetHasSpell(145) || GetHasSpell(147) || 
		GetHasSpell(1020) || GetHasSpell(1022) || GetHasSpell(2114) )
		return 3;																		
		
	if ( GetHasSpell(34) || GetHasSpell(149) || GetHasSpell(97) || GetHasSpell(1169) )
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
	int nHealingLevel = 0;
	nHealingLevel = GetHealingReserveLevel();
	int nCanHeal = 1;	 
	
	if (nHealingLevel == 0)
	{
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
	}
	else
	if (GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
	{
		
		int nTouchofHealingUse50PercentCap = GetLocalInt(GetModule(), "TouchofHealingUse50PercentCap");
		int nTouchofHealingUseAugmentHealing = GetLocalInt(GetModule(), "TouchofHealingUseAugmentHealing");
		
		if (nTouchofHealingUse50PercentCap)
		{
			if ( GetCurrentHitPoints(oTarget) > (GetMaxHitPoints(oTarget)/2) )
			{	
				SendMessageToPC(OBJECT_SELF,"Target's health is greater than 50%, this ability only affects those at half life or below.");
				nCanHeal = 0;
			}
		}
//		else
//			if (nTouchofHealingUse50PercentCap == 0)
//				SendMessageToPC(OBJECT_SELF, "This module does not support Kaedrin's content correctly.  Please see the 'Adding Module Support.txt' readme about how to add the needed module support.");

		
		effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
		int nHeal = 3 * nHealingLevel;
		
		if (nTouchofHealingUseAugmentHealing)
		{
			if (GetHasFeat(FEAT_AUGMENT_HEALING,OBJECT_SELF))
				nHeal += nHealingLevel * 2;
		}
				
		if (nCanHeal)
		{				
			//Fire cast spell at event for the specified target
			SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));				
	
			//Apply the effects
	        effect eHeal = EffectHeal(nHeal);
	        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);			
			ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
		}

	}			



}
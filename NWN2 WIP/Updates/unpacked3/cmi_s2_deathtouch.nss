//::///////////////////////////////////////////////
//:: Death Touch
//:: cmi_s2_deathtouch
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Sept 28, 2007
//:://////////////////////////////////////////////


#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{


    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    object oTarget = GetSpellTargetObject();
	
	int nTouch = TouchAttackMelee(oTarget);
	
	if (nTouch > 0)
	{
		int nCasterLevel = GetLevelByClass(CLASS_TYPE_CLERIC,OBJECT_SELF);
		
		int nDeathRoll = d6(nCasterLevel);
		if (nTouch == TOUCH_ATTACK_RESULT_CRITICAL)
		{
			nDeathRoll = nDeathRoll * 2;
		}	
		
		int nCurrentHP = GetCurrentHitPoints(oTarget);
		effect eVis = EffectVisualEffect(VFX_HIT_SPELL_NECROMANCY);	
		
		if (nDeathRoll > nCurrentHP)
		{
			
			effect eDeath = EffectDeath(TRUE,TRUE,FALSE,TRUE);
		
		    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
		    {
		            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
		            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath , oTarget);
		    }
		}
		else
		{
			ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
			SendMessageToPC(OBJECT_SELF,"Death Touch failed to slay the target.");
		}
	}
}
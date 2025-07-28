//::///////////////////////////////////////////////
//:: Seed of Life
//:: cmi_s0_seedlife
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 24, 2010
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "x0_i0_spells"

#include "cmi_ginc_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    			
	object oTarget = GetSpellTargetObject();
		
	int nDice = (GetPalRngCasterLevel() / 2) + 10;
	if (nDice > 20)
		nDice = 20;
		
	int nHeal = d4(nDice);	

	effect eHeal = EffectHeal(nHeal);
	effect eVis = EffectVisualEffect(VFX_IMP_HEALING_X);
		
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));	
	RemoveEffectOfType(oTarget, EFFECT_TYPE_WOUNDING);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
	
}      
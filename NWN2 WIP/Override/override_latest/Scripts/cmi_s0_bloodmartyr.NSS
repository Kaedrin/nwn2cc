//::///////////////////////////////////////////////
//:: Blood of the Martyr
//:: cmi_s0_bloodmartyr
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 5, 2007
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    			
	object oTarget = GetSpellTargetObject();
		

	
	int nMaxHealth = GetMaxHitPoints(oTarget);
	int nCurrentHealth = GetCurrentHitPoints(oTarget);
	int nHeal = nMaxHealth - nCurrentHealth;	
	int nDamage=20;
	
	if (nHeal > nDamage)
		nDamage = nHeal;
		
	effect eDamage = EffectDamage(nDamage,DAMAGE_TYPE_DIVINE);
	effect eHeal = EffectHeal(nHeal);
	effect eVis = EffectVisualEffect(VFX_IMP_HEALING_X);
	effect eVisSelf = EffectVisualEffect(VFX_HIT_SPELL_NECROMANCY);
		
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));	
	RemoveEffectOfType(oTarget, EFFECT_TYPE_WOUNDING);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
	
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisSelf, OBJECT_SELF);
	
	
}      
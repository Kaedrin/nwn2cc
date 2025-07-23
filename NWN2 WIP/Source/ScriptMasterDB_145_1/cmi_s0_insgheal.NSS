//::///////////////////////////////////////////////
//:: Insignia of Healing
//:: cmi_s0_insgheal
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 24, 2010
//:://////////////////////////////////////////////

#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
 
	
	int nCasterLvl = GetPalRngCasterLevel();
	int nDuration = nCasterLvl;
	if (nCasterLvl > 10)
		nCasterLvl = 10;
		
	effect eRegen = EffectRegenerate(2, 6.0f);
	float fDuration = HoursToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);		
				
	float fDelay;
	effect eHeal;
	effect eVis = EffectVisualEffect(VFX_IMP_HEALING_S);	
		
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF))
        {
			eHeal = EffectHeal(d8() + nCasterLvl);
			fDelay = GetRandomDelay(0.4, 1.1);
			RemoveEffectsFromSpell(oTarget, GetSpellId());			
			SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
			DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));		
			DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));	
			DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oTarget, fDuration));			
			DelayCommand(fDelay, RemoveEffectOfType(oTarget, EFFECT_TYPE_WOUNDING));									
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    }	
	
}      
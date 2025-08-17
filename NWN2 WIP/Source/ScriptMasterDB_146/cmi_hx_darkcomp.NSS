//::///////////////////////////////////////////////
//:: Dark Companion
//:: cmi_hx_darkcomp
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 27, 2011
//:://////////////////////////////////////////////
#include "nw_i0_spells"
#include "x2_inc_spellhook"
#include "cmi_includes"

void main()
{
    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    object oTarget = GetSpellTargetObject();
	
	// Strip any Auras first
	effect eTest = GetFirstEffect(oTarget);
	while(GetIsEffectValid(eTest))
	{
		if (GetEffectType(eTest) == EFFECT_TYPE_AREA_OF_EFFECT && GetEffectSpellId(eTest) == SPELLABILITY_DARK_COMPANION)
		{
			RemoveEffect(oTarget, eTest);
		}
		eTest = GetNextEffect(oTarget);
	}
	
	
	object o = GetFirstObjectInArea(GetArea(oTarget));
	while(GetIsObjectValid(o))
	{
		if (GetObjectType(o)==OBJECT_TYPE_AREA_OF_EFFECT)
		{
			if (  GetAreaOfEffectSpellId(o)==SPELLABILITY_DARK_COMPANION && GetAreaOfEffectCreator(o) == oTarget )
			{
				DestroyObject(o);
			}
		}	
		o = GetNextObjectInArea(GetArea(oTarget));
	}	
	
		
	if (!GetHasSpellEffect(SPELLABILITY_DARK_COMPANION, OBJECT_SELF))
	{
		effect eAOE = EffectAreaOfEffect(VFX_PER_DARK_COMP);
		effect eVis = EffectVisualEffect(VFXSC_DUR_DARK_COMPANION);
		eAOE = EffectLinkEffects(eVis, eAOE);
		eAOE = SetEffectSpellId(eAOE, SPELLABILITY_DARK_COMPANION);		
		eAOE = ExtraordinaryEffect(eAOE);
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_DARK_COMPANION, FALSE));
	    DelayCommand(0.0f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, oTarget));
	}
		
}
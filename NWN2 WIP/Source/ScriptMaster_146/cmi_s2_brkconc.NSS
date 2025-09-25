//::///////////////////////////////////////////////
//:: Dissonant Chord - Break Concentration
//:: cmi_s2_brkconc
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: October 18, 2009
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
		if (GetEffectType(eTest) == EFFECT_TYPE_AREA_OF_EFFECT && GetEffectSpellId(eTest) == SPELLABILITY_DISCHORD_BREAK_CONC)
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
			//SpeakString("FOUND AOE OBJECT WITH SPELL ID: "+IntToString(GetAreaOfEffectSpellId(o)));
			if (  GetAreaOfEffectSpellId(o)==SPELLABILITY_DISCHORD_BREAK_CONC && GetAreaOfEffectCreator(o) == oTarget )
			{
				//SpeakString("FOUND/DESTROY OLD AOE OBJECT");
				DestroyObject(o);
			}
		}	
		o = GetNextObjectInArea(GetArea(oTarget));
	}	
		
	if (!GetHasSpellEffect(SPELLABILITY_DISCHORD_BREAK_CONC, OBJECT_SELF))
	{
		effect eAOE = EffectAreaOfEffect(VFX_PER_BREAK_CONC);
		eAOE = ExtraordinaryEffect(eAOE);	 //Make effect extraordinary
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_DISCHORD_BREAK_CONC, FALSE));
	    DelayCommand(0.0f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, oTarget));
	}
		
}
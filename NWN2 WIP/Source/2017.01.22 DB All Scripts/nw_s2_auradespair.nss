//::///////////////////////////////////////////////
//:: Aura of Despair
//:: NW_S2_AuraDespair.nss
//:: Copyright (c) 2006 Obsidian Entertainment, Inc.
//:://////////////////////////////////////////////
/*
	Blackguard supernatural ability that causes all
	enemies within 10' to take a -2 penalty on all saves.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Woo (AFW-OEI)
//:: Created On: 05/30/2006
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
		if (GetEffectType(eTest) == EFFECT_TYPE_AREA_OF_EFFECT && GetEffectSpellId(eTest) == SPELLABLILITY_AURA_OF_DESPAIR)
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
			if (  GetAreaOfEffectSpellId(o)==SPELLABLILITY_AURA_OF_DESPAIR && GetAreaOfEffectCreator(o) == oTarget )
			{
				//SpeakString("FOUND/DESTROY OLD AOE OBJECT");
				DestroyObject(o);
			}
		}	
		o = GetNextObjectInArea(GetArea(oTarget));
	}	
		
	if (GetHasFeat(FEAT_EPIC_WIDEN_AURA_DESPAIR,OBJECT_SELF))
	{
		effect eAOE = EffectAreaOfEffect(VFX_PER_WIDEN_AURA_OF_DESPAIR);
		eAOE = ExtraordinaryEffect(eAOE);	 //Make effect extraordinary
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABLILITY_AURA_OF_DESPAIR, FALSE));
		DelayCommand(0.0f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, oTarget));	
	}
	else
	if (!GetHasSpellEffect(SPELLABLILITY_AURA_OF_DESPAIR, OBJECT_SELF))
	{
		effect eAOE = EffectAreaOfEffect(AOE_PER_AURA_OF_DESPAIR);
		eAOE = ExtraordinaryEffect(eAOE);	 //Make effect extraordinary
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABLILITY_AURA_OF_DESPAIR, FALSE));
	    DelayCommand(0.0f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, oTarget));
	}
		
}
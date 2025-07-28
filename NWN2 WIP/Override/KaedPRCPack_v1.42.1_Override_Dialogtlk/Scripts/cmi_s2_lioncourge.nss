//::///////////////////////////////////////////////
//:: Lion's Courage
//:: cmi_s2_lioncourge
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: March 22, 2008
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_includes"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = LION_TALISID_LIONS_COURAGE;
	
	/*
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF); 
	}	
	*/
	
	effect eFear =  EffectImmunity(IMMUNITY_TYPE_FEAR);
	effect eWill = EffectSavingThrowIncrease(SAVING_THROW_WILL, 4, SAVING_THROW_TYPE_MIND_SPELLS);
	effect eLink = EffectLinkEffects(eWill, eFear);
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);
	
}      
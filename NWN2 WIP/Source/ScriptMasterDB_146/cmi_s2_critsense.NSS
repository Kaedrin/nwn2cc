//::///////////////////////////////////////////////
//:: Critical Sense + Expert Tumbling
//:: cmi_s2_critsense
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: March 23, 2008
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
	
	int nSpellId = SPELLABILITY_WHDERV_CRITSENSE;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	int nWhDerv = GetLevelByClass(CLASS_WHIRLING_DERVISH);
	effect eCritSense;
	
	if (nWhDerv > 9) // Crit Sense +2 and Expert Tumbling
	{
		effect eAB = EffectAttackIncrease(2);
		effect eAC = EffectACIncrease(1);
		eCritSense = EffectLinkEffects(eAB,eAC);
	}
	else
	if (nWhDerv > 4) // Expert Tumbling
	{
		effect eAB = EffectAttackIncrease(1);
		effect eAC = EffectACIncrease(1);
		eCritSense = EffectLinkEffects(eAB,eAC);	
	}
	else // Crit Sense +1 
	{
		eCritSense = EffectAttackIncrease(1);	
	}
	
	eCritSense = SetEffectSpellId(eCritSense,nSpellId);
	eCritSense = SupernaturalEffect(eCritSense);
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCritSense, OBJECT_SELF);
	
}      
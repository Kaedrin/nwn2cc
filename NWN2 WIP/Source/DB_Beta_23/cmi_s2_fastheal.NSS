//::///////////////////////////////////////////////
//:: Fast Healing I, II
//:: cmi_s2_fastheal
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 17, 2008
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
	
	int nSpellId = GetSpellId();
	
	if (GetHasSpellEffect(SPELLABILITY_Fast_Healing_I,OBJECT_SELF))
	{
		RemoveSpellEffects(SPELLABILITY_Fast_Healing_I, OBJECT_SELF, OBJECT_SELF);
	}
	if (GetHasSpellEffect(SPELLABILITY_Fast_Healing_II,OBJECT_SELF))
	{
		RemoveSpellEffects(SPELLABILITY_Fast_Healing_II, OBJECT_SELF, OBJECT_SELF);
	}	
	
	int nRegen;
	
	if (GetHasFeat(FEAT_FAST_HEALING_II))
		nRegen = 6;
	else
		nRegen = 3;
	 
	effect eRegen = EffectRegenerate(nRegen, 6.0f);
	eRegen = SetEffectSpellId(eRegen,nSpellId);
	eRegen = SupernaturalEffect(eRegen);
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRegen, OBJECT_SELF);
	
}      
//::///////////////////////////////////////////////
//:: Citadel Training
//:: cmi_s2_cittrain
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 26, 2008
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
	
	int nSpellId = SPELLABILITY_CHAMPWILD_SUPERIOR_DEFENSE;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	int nBoost = GetLevelByClass(CLASS_CHAMPION_WILD);
	nBoost = nBoost / 3;
	
	effect eAC = EffectACIncrease(nBoost);
	eAC = SetEffectSpellId(eAC,nSpellId);
	eAC = SupernaturalEffect(eAC);
	
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAC, OBJECT_SELF));
	
}      
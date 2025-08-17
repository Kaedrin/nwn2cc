//::///////////////////////////////////////////////
//:: Scarred Flesh
//:: cmi_s2_scarflesh
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Jan 17, 2008
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
	
	int nSpellId = WOD_SCARRED_FLESH;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	 
	int nDR = 3;
	
	if (GetHasFeat(494))
	{
		nDR = 12;
	}
	else
	if (GetHasFeat(493))
	{
		nDR = 9;
	}	
	else
	if (GetHasFeat(492))
	{
		nDR = 6;
	}
	
	if (GetHasFeat(1253))
		nDR++;
		
	effect eDR = EffectDamageReduction(nDR, DR_TYPE_NONE, 0, DR_TYPE_NONE);
	eDR = SetEffectSpellId(eDR,nSpellId);
	eDR = SupernaturalEffect(eDR);
	
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDR, OBJECT_SELF));	
}      
//::///////////////////////////////////////////////
//:: Elemental Affinity - Water
//:: cmi_s2_elemafinw
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 4th, 2008
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
	
	int nSpellId = SPELLABILITY_ELEMWAR_AFFINITY;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	 	
	effect eDR = EffectDamageResistance(DAMAGE_TYPE_COLD, 10);
	eDR = SetEffectSpellId(eDR,nSpellId);
	eDR = SupernaturalEffect(eDR);
	
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDR, OBJECT_SELF));	
}      
//::///////////////////////////////////////////////
//:: Forest Might
//:: cmi_s2_forestmight
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 13, 2008
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
	
	int nSpellId = FOREST_MASTER_FOREST_MIGHT;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	

	effect ePierce = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 50);
	effect eRegen = EffectRegenerate(1, 6.0f);
	effect eLink = EffectLinkEffects (ePierce, eRegen);
	
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF));
	
}      
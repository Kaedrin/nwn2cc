//::///////////////////////////////////////////////
//:: Weapon Supremacy
//:: cmi_s2_wpnsuprm
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Aug 15, 2009
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
	
	int nSpellId = SPELLABILITY_WEAPON_SUPREMACY;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	

	effect eAB = EffectAttackIncrease(1);
	effect eAC = EffectACIncrease(1);
	effect eLink = EffectLinkEffects(eAB, eAC);
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(72)));	
}      
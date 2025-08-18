//::///////////////////////////////////////////////
//:: Sanctify Strikes
//:: cmi_s2_sancstrikes
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Aug 17, 2009
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
	
	int nSpellId = SPELLABILITY_SANCTIFY_STRIKES;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	

	effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_2, DAMAGE_TYPE_DIVINE);
	eDmg = SetEffectSpellId(eDmg,nSpellId);
	eDmg = SupernaturalEffect(eDmg);
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDmg, OBJECT_SELF, HoursToSeconds(72)));	
}      
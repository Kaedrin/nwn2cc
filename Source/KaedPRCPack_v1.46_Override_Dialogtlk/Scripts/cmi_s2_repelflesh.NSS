//::///////////////////////////////////////////////
//:: Repellant Flesh
//:: cmi_s2_repelflesh
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
	
	int nSpellId = WOD_REPELLANT_FLESH;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	effect eSR =  EffectSpellResistanceIncrease(10 + GetHitDice(OBJECT_SELF));
	eSR = SetEffectSpellId(eSR,nSpellId);
	eSR = SupernaturalEffect(eSR);
	
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSR, OBJECT_SELF, HoursToSeconds(48));
	
}      
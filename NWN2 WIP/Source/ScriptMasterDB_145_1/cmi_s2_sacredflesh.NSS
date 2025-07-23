//::///////////////////////////////////////////////
//:: Sacred Flesh
//:: cmi_s2_sacredflesh
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
	
	int nSpellId = AKNIGHT_SACRED_FLESH;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	effect eSR =  EffectSpellResistanceIncrease(10 + GetHitDice(OBJECT_SELF));
	eSR = SetEffectSpellId(eSR,nSpellId);
	eSR = SupernaturalEffect(eSR);
	
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSR, OBJECT_SELF, HoursToSeconds(72)));	
	
}      
//::///////////////////////////////////////////////
//:: Sacred Defense
//:: cmi_s2_sacreddef
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Nov 7, 2007
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
	
	int nSpellId = SPELL_DIVSEEK_SACRED_DEFENSE;
	
	int bHasEffects = GetHasSpellEffect(nSpellId,OBJECT_SELF);
	int nBoost = 0;
	
	if (bHasEffects)
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}
	
	int nLevel = GetLevelByClass(CLASS_DIVINE_SEEKER);
		
	if (nLevel > 3)
		nBoost = 2;
	else
		nBoost = 1;
	effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nBoost);
	eSave = SetEffectSpellId(eSave,nSpellId);
	eSave = SupernaturalEffect(eSave);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSave, OBJECT_SELF, HoursToSeconds(48));
	
	
}      
//::///////////////////////////////////////////////
//:: Force of Personality
//:: cmi_s2_forcepers
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 23, 2009
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
	
	int nSpellId = SPELLABILITY_SCOUT_BATTLEFORT;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	int nWis = GetAbilityModifier(ABILITY_WISDOM);
	int nCha= GetAbilityModifier(ABILITY_CHARISMA);
	int nBonus = nCha - nWis;
	if (nBonus <= 0)
		return;
		
	effect eFort = EffectSavingThrowIncrease(SAVING_THROW_WILL, nBonus);
	
	eFort = SetEffectSpellId(eFort,nSpellId);
	eFort = SupernaturalEffect(eFort);
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFort, OBJECT_SELF, HoursToSeconds(72)));	
}      
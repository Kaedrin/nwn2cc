//::///////////////////////////////////////////////
//:: Mystic Protection
//:: cmi_s2_mystprot
//:: Purpose:
//:: Created By: Kaedrin (Matt)
//:: Created On: Sept 25, 2007
//:://////////////////////////////////////////////


#include "x0_i0_spells"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
    int nCasterLvl = GetLevelByClass(CLASS_TYPE_CLERIC,OBJECT_SELF);
	float fDuration = RoundsToSeconds( nCasterLvl );
	
	int nChaMod = GetAbilityModifier(ABILITY_CHARISMA);
	effect eSaveBonus = EffectSavingThrowIncrease(SAVING_THROW_ALL,nChaMod,SAVING_THROW_ALL);
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
	effect eLink = EffectLinkEffects(eVis,eSaveBonus);
	
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink , OBJECT_SELF, fDuration);

}
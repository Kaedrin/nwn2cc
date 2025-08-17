//::///////////////////////////////////////////////
//:: Elemental Sanctuary
//:: cmi_s2_elemsanct
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 13, 2008
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 

void main()
{

    effect eDur = EffectVisualEffect(VFX_DUR_SPELL_SANCTUARY);
	int nDC = 10 + 10 + GetAbilityModifier(ABILITY_STRENGTH);
    effect eSanc = EffectSanctuary(nDC); 
    effect eLink = EffectLinkEffects(eDur, eSanc);

    float fDuration = RoundsToSeconds(10);

    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));
}
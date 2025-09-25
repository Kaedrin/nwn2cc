//::///////////////////////////////////////////////
//:: Aura of Unluck
//:: cmi_hx_auraunluck
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "cmi_ginc_spells"

void main()
{
    //Declare major variables
	RemoveSpellEffects(SPELLABILITY_HEX_AURA_UNLUCK, OBJECT_SELF, OBJECT_SELF);	
	
	int nConceal = 20;
	if (GetHasFeat(FEAT_HEXBLADE_EPIC_IMPROVED_AURA))
		nConceal = 50;
    effect eConc = EffectConcealment(nConceal);
    effect eDur = EffectVisualEffect(VFX_DUR_SPELL_DISPLACEMENT);

    effect eLink = EffectLinkEffects(eConc, eDur);
    eLink = SetEffectSpellId(eLink, SPELLABILITY_HEX_AURA_UNLUCK);
	eLink = SupernaturalEffect(eLink);	
	
	int nCasterLvl = 4 + GetAbilityModifier(ABILITY_CHARISMA);
	if (GetHasFeat(FEAT_HEXBLADE_LINGERING_AURA))
		nCasterLvl += 5;
	
	float fDuration = RoundsToSeconds( nCasterLvl );
	
    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF,SPELLABILITY_HEX_AURA_UNLUCK, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
}
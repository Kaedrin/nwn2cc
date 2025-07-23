//::///////////////////////////////////////////////
//:: Shadow Form
//:: cmi_hx_shadform
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "cmi_ginc_spells"

void main()
{
    //Declare major variables
    object oTarget = OBJECT_SELF;

    effect eConc = EffectConcealment(20);
    effect eDur = EffectVisualEffect(VFX_DUR_SPELL_DISPLACEMENT);
	effect eSkill1 = EffectSkillIncrease(SKILL_MOVE_SILENTLY,4);
	effect eSkill2 = EffectSkillIncrease(SKILL_HIDE,4);

    effect eLink = EffectLinkEffects(eConc, eDur);
	eLink = EffectLinkEffects(eLink, eSkill1);
	eLink = EffectLinkEffects(eLink, eSkill2);	
    eLink = SetEffectSpellId(eLink, Hex_Shadow_Form);
	eLink = SupernaturalEffect(eLink);	
	
	int nCasterLvl = GetHexbladeCasterLevel();
	float fDuration = TurnsToSeconds( nCasterLvl );
    if(GetHasFeat(FEAT_HEXBLADE_ARCANE_MASTERY)) // arcane mastery
    {
        fDuration = fDuration * 2;
    }	
		
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(oTarget, GetSpellId(), FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
}
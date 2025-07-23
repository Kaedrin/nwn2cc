//::///////////////////////////////////////////////
//:: Spiderskin
//:: cmi_hx_spiderskin
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 4, 2013
//:://////////////////////////////////////////////

#include "cmi_ginc_chars"
#include "x2_inc_spellhook" 

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	int nSpellId = Hex_Spiderskin;
		
    //Declare major variables
    int nCasterLvl = GetHexbladeCasterLevel();
	float fDuration = TurnsToSeconds(nCasterLvl);	
    if(GetHasFeat(FEAT_HEXBLADE_ARCANE_MASTERY)) // arcane mastery
    {
        fDuration = fDuration * 2;
    }	
		
    int nLvlBonus;
    if ( nCasterLvl < 12 ) { nLvlBonus = nCasterLvl / 3; }
    else                   { nLvlBonus = 4; }

    int nACBonus = 1 + nLvlBonus;
    int nPoisonSaveBonus = 1 + nLvlBonus;
    int nHideSkillBonus = 1 + nLvlBonus;	
	
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eAC = EffectACIncrease(nACBonus, AC_NATURAL_BONUS);
    effect ePoison = EffectSavingThrowIncrease(SAVING_THROW_ALL, nPoisonSaveBonus , SAVING_THROW_TYPE_POISON);
    effect eHide = EffectSkillIncrease(SKILL_HIDE, nHideSkillBonus);
    effect eDur = EffectVisualEffect( VFX_DUR_SPELL_PREMONITION );
    effect eLink = EffectLinkEffects(eAC, ePoison);
    eLink = EffectLinkEffects(eLink, eHide);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = SetEffectSpellId(eLink, nSpellId);
	eLink = SupernaturalEffect(eLink);		
		
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SPIDERSKIN, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);		
		
}
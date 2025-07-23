//::///////////////////////////////////////////////
//:: Augment Familiar
//:: cmi_hx_augfam
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
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

	int nSpellId = Hex_Shield;
		
    //Declare major variables
    int nCasterLvl = GetHexbladeCasterLevel();
	float fDuration = TurnsToSeconds(nCasterLvl);	
    if(GetHasFeat(FEAT_HEXBLADE_ARCANE_MASTERY)) // arcane mastery
    {
        fDuration = fDuration * 2;
    }	
		
    //Declare major variables
    object oTarget = OBJECT_SELF;
	
    effect eArmor = EffectACIncrease(4, AC_SHIELD_ENCHANTMENT_BONUS);	// AFW-OEI 11/02/2006 change from Deflection to Shield bonus.
    effect eSpell = EffectSpellImmunity(SPELL_MAGIC_MISSILE);
    effect eDur = EffectVisualEffect(VFX_DUR_SPELL_SHIELD);
    effect eLink = EffectLinkEffects(eArmor, eDur);
    eLink = EffectLinkEffects(eLink, eSpell);
    eLink = SetEffectSpellId(eLink, nSpellId);
	eLink = SupernaturalEffect(eLink);		
		
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, Hex_Shield, FALSE));

    RemoveEffectsFromSpell(OBJECT_SELF, Hex_Shield);
		
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);		
		
}
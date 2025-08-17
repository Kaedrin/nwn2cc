//::///////////////////////////////////////////////
//:: Ghostly Visage
//:: cmi_hx_ghostvis
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

	int nSpellId = Hex_Ghostly_Visage;
		
    //Declare major variables
    int nCasterLvl = GetHexbladeCasterLevel();
	float fDuration = TurnsToSeconds(nCasterLvl);	
    if(GetHasFeat(FEAT_HEXBLADE_ARCANE_MASTERY)) // arcane mastery
    {
        fDuration = fDuration * 2;
    }	
		
    //Declare major variables
    object oTarget = GetSpellTargetObject();
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_GHOSTLY_VISAGE );
    effect eDam = EffectDamageReduction(5, GMATERIAL_METAL_ADAMANTINE, 0, DR_TYPE_GMATERIAL);		// 3.5 DR approximation
    effect eSpell = EffectSpellLevelAbsorption(1);
    effect eConceal = EffectConcealment(10);
    effect eLink = EffectLinkEffects(eDam, eVis);
	
    eLink = EffectLinkEffects(eLink, eSpell);
    eLink = EffectLinkEffects(eLink, eConceal);
    eLink = SetEffectSpellId(eLink, nSpellId);
	eLink = SupernaturalEffect(eLink);		
		
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GHOSTLY_VISAGE, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);		
		
}
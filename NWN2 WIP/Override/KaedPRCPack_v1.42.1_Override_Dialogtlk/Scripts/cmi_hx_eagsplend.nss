//::///////////////////////////////////////////////
//:: Eagle's Splendor
//:: cmi_hx_eagsplend
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 20, 2011
//:://////////////////////////////////////////////


#include "x2_inc_spellhook"
#include "nw_i0_spells"
#include "cmi_ginc_chars"

void main()
{
    /*
      Spellcast Hook Code
      Added 2003-06-23 by GeorgZ
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more

    */

        if (!X2PreSpellCastCode())
        {
        // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
            return;
        }

    // End of Spell Cast Hook

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_EAGLE_SPLENDOR);
    int nCasterLvl = GetHexbladeCasterLevel();
	
	RemoveEffectsFromSpell(oTarget, SPELL_EAGLES_SPLENDOR);	
		
    int nModify = 4;
    float fDuration = TurnsToSeconds(nCasterLvl);

    //Signal the spell cast at event
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_EAGLES_SPLENDOR, FALSE));

    effect eCha = EffectAbilityIncrease(ABILITY_CHARISMA,nModify);
    effect eLink = EffectLinkEffects(eCha, eVis);
	
	if (oTarget == OBJECT_SELF)
	{
		effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 2, SAVING_THROW_TYPE_ALL);
		eLink = EffectLinkEffects(eLink, eSave);
	}
	
    eLink = SetEffectSpellId(eLink, SPELL_EAGLES_SPLENDOR);
	eLink = SupernaturalEffect(eLink);		
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
}
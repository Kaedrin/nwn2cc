//::///////////////////////////////////////////////
//:: Paladin - Spirit of Heroism
//:: cmi_s2_spirheroism
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 1, 2009
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "cmi_includes"

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
	int nSpellId = SPELLABILITY_PALADIN_SPIRIT_HEROISM;
	
	int nPaladin = GetLevelByClass(CLASS_TYPE_PALADIN);
    float fDuration = RoundsToSeconds(nPaladin);

    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_BLESS);

	effect eDR = EffectDamageReduction(10, DR_TYPE_NONE, 0, DR_TYPE_NONE);
    effect eHP = EffectBonusHitpoints(GetHitDice(OBJECT_SELF));

    effect eLink = EffectLinkEffects(eDR, eHP);
    eLink = EffectLinkEffects(eLink, eVis);
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
	DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));

}
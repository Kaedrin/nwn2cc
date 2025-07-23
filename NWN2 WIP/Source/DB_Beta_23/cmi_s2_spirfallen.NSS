//::///////////////////////////////////////////////
//:: Paladin - Spirit of the Fallen
//:: cmi_s2_spirfallen
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
	int nSpellId = SPELLABILITY_PALADIN_SPIRIT_FALLEN;
	
	int nPaladin = GetLevelByClass(CLASS_TYPE_PALADIN);
    float fDuration = RoundsToSeconds(nPaladin);

	effect eWard;
    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_BLESS);
    effect eRegen = EffectRegenerate(10, 6.0f);
    effect eLink = EffectLinkEffects(eVis, eRegen);
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	
    float fDelay;
    location lLoc = GetSpellTargetLocation();

    //Get the first target in the radius around the caster
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF))
        {
            fDelay = GetRandomDelay(0.4, 1.1);
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
			eWard = EffectHealOnZeroHP(oTarget, nPaladin*2);
			eWard = SetEffectSpellId(eWard,nSpellId);
			eWard = SupernaturalEffect(eWard);
			DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWard, oTarget, fDuration));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
    }
}
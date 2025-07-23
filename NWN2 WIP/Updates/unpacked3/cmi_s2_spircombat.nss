//::///////////////////////////////////////////////
//:: Paladin - Spirit of Combat
//:: cmi_s2_spircombat
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 1, 2009
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "cmi_ginc_spells"

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
	int nSpellId = SPELLABILITY_PALADIN_SPIRIT_COMBAT;
	
	int nPaladin = GetLevelByClass(CLASS_TYPE_PALADIN);
	int nBonus = nPaladin/4;
	if (nBonus <= 0)
		nBonus = 1;
    float fDuration = RoundsToSeconds(nPaladin);

    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_BLESS);

    effect eAttack = EffectAttackIncrease(nBonus);
	
    effect eDmg = EffectDamageIncrease(GetDamageBonusByValue(nBonus), DAMAGE_TYPE_DIVINE);

    effect eLink = EffectLinkEffects(eAttack, eDmg);
    eLink = EffectLinkEffects(eLink, eVis);
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
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
    }
}
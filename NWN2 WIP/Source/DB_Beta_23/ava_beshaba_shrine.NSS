//::///////////////////////////////////////////////
//:: Shrine of Beshaba
//:: ava_beshaba_shrine.nss
//:://////////////////////////////////////////////
/*
    Used by activating a placable.
	Removes curses on use, followers of Beshaba
	additionally gain a +1 dodge bonus to AC and
	+1 to attack rolls for 10 minutes.
*/
//:://////////////////////////////////////////////
//:: Created By: Hal/Mairn/Avarson
//:: Created On: February 3, 2017
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "cmi_ginc_spells"
#include "nw_i0_spells"


void main()
{
float fDuration = HoursToSeconds(1);
object oTarget = GetPlaceableLastClickedBy();
int nEffect;
effect eVis = EffectVisualEffect(VFX_HIT_SPELL_ABJURATION);
effect eVis2 = EffectVisualEffect(VFX_HIT_SPELL_AVASCULATE);

// Remove curses
        nEffect = EFFECT_TYPE_CURSE;
		RemoveEffectsFromSpell(oTarget, SPELLABILITY_HEX_CURSE);	
		RemoveEffectsFromSpell(oTarget, SPELLABILITY_HEX_CURSE_LETH);	
		RemoveEffectsFromSpell(oTarget, SPELLABILITY_HEX_CURSE_LETH);		
		RemoveEffectsFromSpell(oTarget, SPELL_BESTOW_CURSE);
    	RemoveSpecificEffect(nEffect, oTarget);
		
//If deity is Beshaba, grant +1 hit and +1 dodge for 1 hour / 10 minutes.
	if (GetDeity(oTarget) == "Beshaba") {
		SendMessageToPC(oTarget, "You feel darkness envelope you briefly.");
    	effect eAttack = EffectAttackIncrease(1);
		effect eAC = EffectACIncrease(1, AC_DODGE_BONUS);
		effect eLink = EffectLinkEffects(eAttack, eAC);
		eLink = SetEffectSpellId(eLink, 666001);
		RemoveEffectsFromSpell(oTarget, 666001);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
		
	}
	else
	{
	
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
	}
}


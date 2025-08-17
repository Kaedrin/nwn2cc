//::///////////////////////////////////////////////
//:: Briar Web - OnEnter
//:: cmi_s0_briarweba
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 23, 2010
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

#include "cmi_ginc_spells"

void main()
{

    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_DUR_WEB);
	effect ePierceDmg = EffectDamage(3, DAMAGE_TYPE_PIERCING);
    object oTarget = GetEnteringObject();

    effect eSlow = EffectMovementSpeedDecrease(50);
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
    {
        if( (!GetHasSpellEffect(SPELL_ASN_Freedom_of_Movement, oTarget)) && (!GetHasSpellEffect(SPELL_BG_Freedom_of_Movement, oTarget)) && (!GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT, oTarget)) && (!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget)) && (GetCreatureFlag(oTarget, CREATURE_VAR_IS_INCORPOREAL) != TRUE) )
        {	
            //Fire cast spell at event for the target
            SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_BRIAR_WEB));

			DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, RoundsToSeconds(1)));
			DelayCommand(0.02, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePierceDmg, oTarget));
			DelayCommand(0.03, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oTarget));
        }
    }
}
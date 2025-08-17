//::///////////////////////////////////////////////
//:: Briar Web - Heartbeat
//:: cmi_s0_briarwebc
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
    object oTarget;
	effect eDmg = EffectDamage(3, DAMAGE_TYPE_PIERCING);
    //Spell resistance check
    oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        if( (!GetHasSpellEffect(SPELL_ASN_Freedom_of_Movement, oTarget)) && (!GetHasSpellEffect(SPELL_BG_Freedom_of_Movement, oTarget)) && (!GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT, oTarget)) && (!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget)) && (GetCreatureFlag(oTarget, CREATURE_VAR_IS_INCORPOREAL) != TRUE) )
        {
	            if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
	            {
	                SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_BRIAR_WEB));
	                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BRIAR_WEB));
					DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget));
					DelayCommand(0.02, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, RoundsToSeconds(1)));
	            }
		}
        oTarget = GetNextInPersistentObject();
    }
}
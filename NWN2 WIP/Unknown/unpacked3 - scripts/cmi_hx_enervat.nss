//::///////////////////////////////////////////////
//:: Enervation
//:: cmi_hx_enervat
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////


#include "cmi_ginc_spells"
#include "x2_inc_spellhook" 

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_NECROMANCY);
    effect eBeam = EffectBeam( VFX_BEAM_NECROMANCY, OBJECT_SELF, BODY_NODE_HAND );
    object oTarget = GetSpellTargetObject();
	int nTouch      = TouchAttackRanged(oTarget);
    int nDrain = d4();
    int nDuration = GetHexbladeCasterLevel();
	
    if(GetHasFeat(FEAT_HEXBLADE_ARCANE_MASTERY)) // arcane mastery
    {
        nDuration = nDuration * 2;
    }	
	
	//PKM-OEI: 05.28.07: Do critical hit damage
	if (nTouch == TOUCH_ATTACK_RESULT_CRITICAL && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT))
	{
		nDrain = d4(2);
	}

    effect eDrain = EffectNegativeLevel(nDrain);
    eDrain = SetEffectSpellId(eDrain, SPELL_ENERVATION);	
	eDrain = SupernaturalEffect(eDrain);
	effect eDmg = EffectDamage(nDrain * 6, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_NORMAL, TRUE);

	if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
	{
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ENERVATION));
		if (nTouch != TOUCH_ATTACK_RESULT_MISS)
		{
	                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDrain, oTarget, HoursToSeconds(nDuration));
	                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
					ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget);
		}
		ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eBeam, oTarget, 1.7 );
    }
}
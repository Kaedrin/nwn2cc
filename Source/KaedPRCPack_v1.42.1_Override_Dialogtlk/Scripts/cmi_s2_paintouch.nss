//::///////////////////////////////////////////////
//:: Pain Touch
//:: cmi_s2_paintouch
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Sept 28, 2007
//:://////////////////////////////////////////////


#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{


    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    object oTarget = GetSpellTargetObject();
	int nTouch = TouchAttackMelee(oTarget);
	int nStrLoss = 2;
	int nDexLoss = 2;
	if (nTouch == TOUCH_ATTACK_RESULT_CRITICAL)	
	{
		nStrLoss = nStrLoss * 2;
		nDexLoss = nDexLoss * 2;
	}
	
	
    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_NECROMANCY);	
	
	effect eABLoss = EffectAbilityDecrease(ABILITY_STRENGTH,nStrLoss);
	effect eACLoss = EffectAbilityDecrease(ABILITY_DEXTERITY,nDexLoss);
	
	effect eLink = EffectLinkEffects(eABLoss,eACLoss);
	eLink = SupernaturalEffect(eLink);

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
    {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink , oTarget, TurnsToSeconds(1));
    }
}
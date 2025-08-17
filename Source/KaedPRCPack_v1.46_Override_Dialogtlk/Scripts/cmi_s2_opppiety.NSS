//::///////////////////////////////////////////////
//:: Opportunistic Piety
//:: cmi_s2_opppiety
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 8, 2013
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "cmi_includes"
#include "cmi_inc_sneakattack"

void main()
{

    object oTarget = GetSpellTargetObject();
    int nInt = GetAbilityModifier(ABILITY_INTELLIGENCE);
    if (nInt < 0)
		nInt = 0;
		
    int nLevel = GetLevelByClass(CLASS_FACTOTUM);

    //--------------------------------------------------------------------------
    // Caluclate the amount to heal, min is 1 hp
    //--------------------------------------------------------------------------
    int nHeal = (nLevel * 2)+nInt;
    if(nHeal <= 0)
    {
        nHeal = 1;
    }
    effect eHeal = EffectHeal(nHeal);
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eDam;
    int nTouch;

    //--------------------------------------------------------------------------
    // A paladine can use his lay on hands ability to damage undead creatures
    // having undead class levels qualifies as undead as well
    //--------------------------------------------------------------------------
    if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD || GetLevelByClass(CLASS_TYPE_UNDEAD,oTarget)>0)
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_LAY_ON_HANDS));
        //Make a ranged touch attack
        nTouch = TouchAttackMelee(oTarget,TRUE);
            if(nTouch > 0)
            {
                if(nTouch == 2)
                {
                    nHeal *= 2;
                }
				
				
				if (StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_SneakAttackSpells)))
					nHeal += EvaluateSneakAttack(oTarget, OBJECT_SELF);
				
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_LAY_ON_HANDS));
                eDam = EffectDamage(nHeal, DAMAGE_TYPE_DIVINE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
            }

    }
    else
    {

        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_LAY_ON_HANDS, FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }

		DecrementRemainingFeatUses(OBJECT_SELF, FEAT_TURN_UNDEAD);

}
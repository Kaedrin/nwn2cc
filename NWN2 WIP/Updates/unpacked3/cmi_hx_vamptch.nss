//::///////////////////////////////////////////////
//:: Vampiric Touch
//:: cmi_hx_vamptch
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "cmi_inc_sneakattack"
#include "cmi_ginc_spells"
#include "cmi_ginc_chars"

void main()
{

    if (!X2PreSpellCastCode())
    {
        return;
    }

    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetHexbladeCasterLevel();
    int nDDice = nCasterLevel /2;
	int nTouch      = TouchAttackMelee(oTarget, GetSpellCastItem() == OBJECT_INVALID);
	
    if ((nDDice) == 0)
    {
        nDDice = 1;
    }
    else if (nDDice>10)
    {
        nDDice = 10;
    }



    int nDamage = d6(nDDice); 
	if (nTouch == TOUCH_ATTACK_RESULT_CRITICAL && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT))
	{
		nDamage = nDamage * 2;
	}
		
    int nDuration = nCasterLevel/2;
    if(GetHasFeat(FEAT_HEXBLADE_ARCANE_MASTERY)) // arcane mastery
    {
        nDuration = nDuration * 2;
    }		

	if (nTouch == TOUCH_ATTACK_RESULT_CRITICAL)
	{
		nDamage += GetMeleeTouchSpecDamage(OBJECT_SELF, nDDice , TRUE);
	}
	else
		nDamage += GetMeleeTouchSpecDamage(OBJECT_SELF, nDDice , FALSE);

	
	//include sneak attack damage
	if (StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_SneakAttackSpells)))
		nDamage += EvaluateSneakAttack(oTarget, OBJECT_SELF);	
	

    //--------------------------------------------------------------------------
    //Limit damage to max hp + 10
    //--------------------------------------------------------------------------
    int nMax = GetCurrentHitPoints(oTarget) + 10;
    if(nMax < nDamage)
    {
        nDamage = nMax;
    }

    effect eHeal = EffectTemporaryHitpoints(nDamage);
	eHeal = SupernaturalEffect(eHeal);
	
    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_NECROMANCY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_S);
    if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) &&
            GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD &&
            GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT &&
            !GetHasSpellEffect(SPELL_NEGATIVE_ENERGY_PROTECTION, oTarget))
        {


            SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_VAMPIRIC_TOUCH, FALSE));
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_VAMPIRIC_TOUCH, TRUE));
             if (nTouch>0)
            {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, OBJECT_SELF);
                    RemoveTempHitPoints();
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHeal, OBJECT_SELF, HoursToSeconds(nDuration));
            }
        }
		else
			SendMessageToPC(OBJECT_SELF, "This is an invalid target for vampiric touch.");
    }
}
//::///////////////////////////////////////////////
//:: Harm Touch
//:: cmi_hx_harmtouch
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 24, 2010
//:://////////////////////////////////////////////


#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "cmi_inc_sneakattack"
#include "cmi_ginc_spells"

void main()
{

    //--------------------------------------------------------------------------
    /*  Spellcast Hook Code
       Added 2003-06-20 by Georg
       If you want to make changes to all spells,
       check x2_inc_spellhook.nss to find out more
    */
    //--------------------------------------------------------------------------

    if (!X2PreSpellCastCode())
    {
        return;
    }
    //--------------------------------------------------------------------------
    // End of Spell Cast Hook
    //--------------------------------------------------------------------------

	int nSpellId = GetSpellId();
    object oTarget = GetSpellTargetObject();
	
	if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
	{
	
		int nTouch = TouchAttackMelee(oTarget);	
		if (nTouch > 0)
		{
			{		
			    int nCasterLevel = GetLevelByClass(CLASS_VENGTAKE);
				int nDamage = 5 * nCasterLevel;
			
				if (nTouch == TOUCH_ATTACK_RESULT_CRITICAL && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT))
				{
					nDamage = nDamage * 2;
				}
				
				int nEmpower = GetLocalInt(OBJECT_SELF, "EmpowerHarmTouch");
				if (nEmpower)
				{
					nDamage = nDamage * 2;			
				}
				
				//include sneak attack damage
				if (StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_SneakAttackSpells)))
					nDamage += EvaluateSneakAttack(oTarget, OBJECT_SELF);	
				
			    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
			    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_NECROMANCY);
			
				SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
				SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, TRUE));
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
				
				if (nEmpower)
				{
					eDamage = EffectDamage(nCasterLevel*2, DAMAGE_TYPE_NEGATIVE);
					ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
					ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, OBJECT_SELF);					
				}
				else
				{
					if (nCasterLevel == 10)
					{
						effect eHeal = EffectHeal(nDamage);
						ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
					}
				}
				
				effect eBonus = EffectTemporaryHitpoints(nDamage);
				RemoveEffectsFromSpell(OBJECT_SELF, nSpellId);
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBonus, OBJECT_SELF, TurnsToSeconds(nCasterLevel));				
				
			}	
		}
	
	}	
	
}
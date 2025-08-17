//::///////////////////////////////////////////////
//:: Manifest Death
//:: cmi_s0_mnfstdeath
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
	
	if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) &&
            GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
	{
	
		int nTouch = TouchAttackMelee(oTarget);	
		if (nTouch > 0)
		{
			//if(MyResistSpell(OBJECT_SELF, oTarget) == 0)
			{		
			    int nMetaMagic = GetMetaMagicFeat();
			    int nCasterLevel = GetBlackguardCasterLevel(OBJECT_SELF);
			    int nDice = nCasterLevel /2;
				int nDamage = d6(nDice);
	
			    nDamage = MaximizeOrEmpower(6,nDice,nMetaMagic);  // JLR - OEI 07/19/05
			
				if (nTouch == TOUCH_ATTACK_RESULT_CRITICAL && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT))
				{
					nDamage = nDamage * 2;
				}		
			
				if (nTouch == TOUCH_ATTACK_RESULT_CRITICAL)
				{
					nDamage += GetMeleeTouchSpecDamage(OBJECT_SELF, nDice , TRUE);
				}
				else
					nDamage += GetMeleeTouchSpecDamage(OBJECT_SELF, nDice , FALSE);
			
				//include sneak attack damage
				if (StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_SneakAttackSpells)))
					nDamage += EvaluateSneakAttack(oTarget, OBJECT_SELF);	
				
			    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
			    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_NECROMANCY);
			
				SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
				SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, TRUE));
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
				
				IncrementRemainingFeatUses(OBJECT_SELF, FEAT_TURN_UNDEAD);
				
			}	
		}
	
	}	
	
}
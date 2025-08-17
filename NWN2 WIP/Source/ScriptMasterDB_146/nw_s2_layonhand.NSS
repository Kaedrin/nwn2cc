//::///////////////////////////////////////////////
//:: Lay_On_Hands
//:: NW_S2_LayOnHand.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Paladin is able to heal his Chr Bonus times
    his level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 15, 2001
//:: Updated On: Oct 20, 2003
//:://////////////////////////////////////////////
//:: AFW-OEI 06/13/2006:
//::	If your Cha mod is 0 or less, Lay on Hands does nothing.

#include "NW_I0_SPELLS"
#include "cmi_includes"
#include "cmi_inc_sneakattack"

void main()
{

    object oTarget = GetSpellTargetObject();
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
    if (nChr <= 0)
    {
        //nChr = 0;
		return;		// AFW-OEI 06/13/2006: Lay on Hands does nothing if you don't have a positive Cha mod. 
    }
    int nLevel = GetLevelByClass(CLASS_TYPE_PALADIN);

    //--------------------------------------------------------------------------
    // July 2003: Add Divine Champion levels to lay on hands ability
    //--------------------------------------------------------------------------
    nLevel = nLevel + GetLevelByClass(CLASS_TYPE_DIVINECHAMPION);
	nLevel = nLevel + GetLevelByClass(CLASS_HOSPITALER);	//Hospitaler
	nLevel = nLevel + GetLevelByClass(CLASS_CHAMPION_WILD);		
	nLevel = nLevel + GetLevelByClass(CLASS_TEMPLAR);	
		
    //--------------------------------------------------------------------------
    // Caluclate the amount to heal, min is 1 hp
    //--------------------------------------------------------------------------
    int nHeal = nLevel * nChr;
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

        //----------------------------------------------------------------------
        // GZ: The PhB classifies Lay on Hands as spell like ability, so it is
        //     subject to SR. No more cheesy demi lich kills on touch, sorry.
        //----------------------------------------------------------------------
        int nResist = MyResistSpell(OBJECT_SELF,oTarget);
        if (nResist == 0 )
        {
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
    }
    else
    {

        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_LAY_ON_HANDS, FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
		
		if (oTarget != OBJECT_SELF)
		{
			if (GetHasFeat(FEAT_REWARD_OF_LIFE))
			{
		        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
		        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);			
				int iRand = Random(100);
				if (iRand < 33)
					IncrementRemainingFeatUses(OBJECT_SELF, 299);
			}
		}
    }
	
	if (GetSpellId() == SPELL_Lay_On_Hands_Hostilev1)
	{
		DecrementRemainingFeatUses(OBJECT_SELF, 299);
	}

}
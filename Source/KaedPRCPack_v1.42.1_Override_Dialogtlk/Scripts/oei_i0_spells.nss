//::///////////////////////////////////////////////
//:: oei_i0_spells (content modified from x0_i0_spells and nw_i0_spells
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Expansion 1 and above include file for spells
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 2002
//:: Updated On: August 2003, Georg Zoeller:
//::                          Arcane Archer special ability fix,
//::                          New creatures added to Flying/Petrification check
//::                          Several Fixes toMDispelagic
//::                          Added spellsGetHighestSpellcastingClassLevel
//::                          Added code to spellsIsTarget to make NPCs hurt their allies with AoE spells if ModuleSwitch MODULE_SWITCH_ENABLE_NPC_AOE_HURT_ALLIES is set
//::                          Creatures with Plot or DM Flag set will no longer be affected by petrify. DMs used to get a GUI panel, even if unaffected.
//:: Updated On: September 2003, Georg Zoeller:
//::                          spellsIsTarget was not using oSource in source checks.
//::                          Creatures with Plot or DM Flag set will no longer be affected by petrify. DMs used to get a GUI panel, even if unaffected.
//:: Updated On: October 2003, Georg Zoeller:
//::                          Missile storm's no longer do a SR check for each missile, but only one per target
//::                          ... and there was much rejoicing
//::                          Added code to handleldispeling of AoE spells better
//::                          Henchmen are booted from the party when petrified
//::                          Dispel Magic delay until VFX hit has been set down to 0.3
//:://////////////////////////////////////////////
//:: 8/15/06 - BDF-OEI: modified spellsIsTarget (case SPELL_TARGET_STANDARDHOSTILE) to disregard targets that are associates of
//::    non-hostile PC's that are in the party, based on personal reputation global flag
// ChazM 8/29/06 moved spellsIsTarget() (and includes and constants) to NW_I0_SPELLS
//:: 10/16/06 - BDF-OEI: modified doAura() to substitute EffectDamageIncrease for EffectDamageShield(), which cannot be set for VersusAlignmentEffect()
// ChazM 10/19/06 - modified DoMissileStorm() to more evenly distribute.

//#include "NW_I0_SPELLS"
//#include "x0_i0_henchman"

// JLR - OEI 08/24/05 -- Metamagic changes
//#include "nwn2_inc_metmag"

#include "cmi_ginc_chars"
#include "cmi_ginc_spells"


//void main(){}

// utility spells to get DC
int oei_GetSpellSaveDCWithSpellLevel(int nAbilityModifier, int nSpellLevel);

int oei_GetSpellSaveDCSaveWithSpellID(int nAbilityModifier, int nSpellID);

int oei_GetSpellSaveDC(int nAbilityModifier);

// cure or inflict spell functions

int oei_GetCureDamageTotal(object oTarget, int nDamage, int nMaxExtraDamage, int nMaximized, int nSpellID);

void oei_DoHarming (object oTarget, int nDamageTotal, int nDamageType, int vfx_impactHurt, int bTouchAttack, int nSpellID);

void oei_spellsHealOrHarmTarget(object oTarget, int nDamageTotal, int vfx_impactNormalHurt, int vfx_impactUndeadHurt, int vfx_impactHeal, int nSpellID, int bIsHealingSpell=TRUE, int bHarmTouchAttack=TRUE);

// modified version of spellsCure, additional support for blackguards and for touch specialization
void oei_spellsCure(int nDamage, int nMaxExtraDamage, int nMaximized, int vfx_impactHurt, int vfx_impactHeal, int nSpellID);

// modified version of spellsInflictTouchAttack, additional support for blackguards and for touch specialization
void oei_spellsInflictTouchAttack(int nDamage, int nMaxExtraDamage, int nMaximized, int vfx_impactHurt, int vfx_impactHeal, int nSpellID);




int oei_GetSpellSaveDCWithSpellLevel(int nAbilityModifier, int nSpellLevel)
{
    return 10 + nSpellLevel + GetAbilityModifier(nAbilityModifier) + GetDCBonusByLevel(OBJECT_SELF);
}


int oei_GetSpellSaveDCSaveWithSpellID(int nAbilityModifier, int nSpellID)
{
    return oei_GetSpellSaveDCWithSpellLevel(nAbilityModifier, GetSpellLevel(nSpellID));
}


int oei_GetSpellSaveDC(int nAbilityModifier)
{
    return oei_GetSpellSaveDCSaveWithSpellID(nAbilityModifier, GetSpellId());
}


int oei_GetCureDamageTotal(object oTarget, int nDamage, int nMaxExtraDamage, int nMaximized, int nSpellID)
{
    int nMetaMagic = GetMetaMagicFeat();
    int nExtraDamage; // * figure out the bonus damage
	if (nSpellID == SPELL_BG_Cure_Light_Wounds || nSpellID == SPELL_BG_Cure_Moderate_Wounds ||
		nSpellID == SPELL_BG_Cure_Serious_Wounds || nSpellID == SPELL_BG_Cure_Critical_Wounds)
	{
        nExtraDamage = GetBlackguardCasterLevel(OBJECT_SELF);
	}
	else
	{
		nExtraDamage = GetCasterLevel(OBJECT_SELF);
	}
       
    if (nExtraDamage > nMaxExtraDamage)
    {
        nExtraDamage = nMaxExtraDamage;
    }
    
	// * if low or normal difficulty is treated as MAXIMIZED
    if( GetIsPC(GetFactionLeader(oTarget)) &&
       (GetGameDifficulty() < GAME_DIFFICULTY_CORE_RULES) )
    {
        nDamage = nMaximized + nExtraDamage;
    }
    else
    {
        nDamage = nDamage + nExtraDamage;
    }


    //Make metamagic checks
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        // nDamage = 8 + nExtraDamage;
        nDamage = nMaximized + nExtraDamage;
        // * if low or normal difficulty then MAXMIZED is doubled.
        if(GetIsPC(GetFactionLeader(oTarget)) && GetGameDifficulty() < GAME_DIFFICULTY_CORE_RULES)
        {
            nDamage = nDamage + nMaximized;
        }
    }
	
	// 8/9/06 - BDF-OEI: added the GetSpellCastItem() check to the GetHasFeat() check to make sure that 
	// 	clerics with the healing domain power don't get a bonus when using a healin potion
    if ( nMetaMagic == METAMAGIC_EMPOWER || (GetHasFeat( FEAT_HEALING_DOMAIN_POWER ) && !GetIsObjectValid( GetSpellCastItem() )) )
    {
        nDamage = nDamage + (nDamage/2);
    }


    // JLR - OEI 06/06/05 NWN2 3.5
    if ( GetHasFeat(FEAT_AUGMENT_HEALING) && !GetIsObjectValid(GetSpellCastItem()) )
    {
        int nSpellLvl = GetSpellLevel(nSpellID);
        nDamage = nDamage + (2 * nSpellLvl);
    }
	
	return (nDamage);
}


// this could be a harm spell cast on non-undead or a heal spell cast on undead
void oei_DoHarming (object oTarget, int nDamageTotal, int nDamageType, int vfx_impactHurt, int bTouchAttack, int nSpellID)
{
	if (bTouchAttack)
	{
		// Returns 0 on a miss, 1 on a hit, and 2 on a critical hit.
		int nTouch = TouchAttackMelee(oTarget);
		if (nTouch == 0)
			return;
		if (GetHasFeat(FEAT_MELEE_TOUCH_SPELL_SPECIALIZATION))
		{
			nDamageTotal += 2; // * GetSpellLevel(nSpellID);
		}
	}			

	if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
	{
		if (!MyResistSpell(OBJECT_SELF, oTarget))
		{
			// Returns 0 if the saving throw roll failed, 1 if the saving throw roll succeeded and 2 if the target was immune 
			int nSpellDC;
			// check blackguard spells
			if (nSpellID == SPELL_BG_Cure_Light_Wounds || nSpellID == SPELL_BG_Cure_Moderate_Wounds ||
				nSpellID == SPELL_BG_Cure_Serious_Wounds || nSpellID == SPELL_BG_Cure_Critical_Wounds)
			{
        		nSpellDC = oei_GetSpellSaveDCSaveWithSpellID(ABILITY_WISDOM, nSpellID);
			}
			else
			{
				nSpellDC =  GetSpellSaveDC();
			}
			int nSave = WillSave(oTarget, nSpellDC, SAVING_THROW_TYPE_NONE, OBJECT_SELF);
			if	(nSave != 2)
			{
				// successful save = half damage 
				if  (nSave == 1)
					nDamageTotal = nDamageTotal/2;
				
				effect eDam = EffectDamage(nDamageTotal, nDamageType);
				//Apply the VFX impact and effects
				DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
				effect eVis = EffectVisualEffect(vfx_impactHurt);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
			}						
		}
	}
}


// This spell routes healing and harming out depending on whether we are undead or not.
void oei_spellsHealOrHarmTarget(object oTarget, int nDamageTotal, int vfx_impactNormalHurt, int vfx_impactUndeadHurt, int vfx_impactHeal, int nSpellID, int bIsHealingSpell=TRUE, int bHarmTouchAttack=TRUE)
{
	int bHarmful = FALSE;
	
    // abort for creatures immune to heal.
    if (GetLocalInt(oTarget, VAR_IMMUNE_TO_HEAL))
        return;
		
		
	int bIsUndead = (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD);
    if (!bIsUndead) // target is normal folks.
    {
		if (bIsHealingSpell) // healing spell 
			DoHealing(oTarget, nDamageTotal, vfx_impactHeal);
		else // harming spell
		{
			oei_DoHarming (oTarget, nDamageTotal, DAMAGE_TYPE_NEGATIVE, vfx_impactNormalHurt, bHarmTouchAttack, nSpellID);
			bHarmful = TRUE;
		}			
    }
    else // target is undead
    {
		if (bIsHealingSpell) // heal spell on undead harms
		{
			oei_DoHarming (oTarget, nDamageTotal, DAMAGE_TYPE_POSITIVE, vfx_impactUndeadHurt, bHarmTouchAttack, nSpellID);
			bHarmful = TRUE;
		}			
		else // harming spell on undead heals!
			DoHealing(oTarget, nDamageTotal, vfx_impactHeal);
		
    }

	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID, bHarmful));
}


//	spellsCure
//    Used by the 'cure' series of spells.
//    Will do max heal/damage if at normal or low difficulty.  Random rolls occur at higher difficulties.
// 8/9/06 - BDF-OEI: added the GetSpellCastItem() check to the GetHasFeat() check to make sure that 
// 	clerics with the healing domain power don't get a bonus when using a healin potion
//
//	Heal spells typically do a random amount +1/level up to a max.
//
// Parameters:
//	int nDamage 		- base amount of damage to heal (or cause)
//	int nMaxExtraDamage - an extra amount equal to the Caster's Level is applied, cappen by nMaxExtraDamage
//	int nMaximized 		- This is the max base amount.  (Do not include nMaxExtraDamage)
//  int vfx_impactHurt	- Impact effect to use for when a creature is harmed
// 	int vfx_impactHeal	- Impact effect to use for when a creature is healed
// 	int nSpellID		- The SpellID that is being cast (Spell cast event will be triggered on target).
void oei_spellsCure(int nDamage, int nMaxExtraDamage, int nMaximized, int vfx_impactHurt, int vfx_impactHeal, int nSpellID)
{
    object oTarget = GetSpellTargetObject();
	int nDamageTotal = oei_GetCureDamageTotal(oTarget, nDamage, nMaxExtraDamage, nMaximized, nSpellID);
 	int bIsHealingSpell=TRUE;
	int bHarmTouchAttack=TRUE;
	oei_spellsHealOrHarmTarget(oTarget, nDamageTotal, vfx_impactHurt, vfx_impactHurt, vfx_impactHeal, nSpellID, bIsHealingSpell, bHarmTouchAttack);

}


//::///////////////////////////////////////////////
//:: spellsInflictTouchAttack
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    nDamage: Amount of damage to do
    nMaxExtraDamage: Max amount of +1 per level damage
    nMaximized: Amount of damage to do if maximized
    vfx_impactHurt: Impact to play if hurt by spell
    vfx_impactHeal: Impact to play if healed by spell
    nSpellID: SpellID to broactcast in the signal event
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

void oei_spellsInflictTouchAttack(int nDamage, int nMaxExtraDamage, int nMaximized, int vfx_impactHurt, int vfx_impactHeal, int nSpellID)
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    //int nTouch = TouchAttackMelee(oTarget);

    int nExtraDamage; // * figure out the bonus damage
    int nSpellDC;
    if (nSpellID == SPELLABILITY_BG_INFLICT_SERIOUS_WOUNDS || nSpellID == SPELL_BG_Spellbook_2 || nSpellID == SPELL_BG_InflictSerious ||
        nSpellID == SPELLABILITY_BG_INFLICT_CRITICAL_WOUNDS || nSpellID == SPELL_BG_Spellbook_4 || nSpellID == SPELL_BG_InflictCritical)
    {
        nExtraDamage = GetBlackguardCasterLevel(OBJECT_SELF);
        nSpellDC = oei_GetSpellSaveDCSaveWithSpellID(ABILITY_WISDOM, nSpellID);
    }
    else
    {
        nExtraDamage = GetCasterLevel(OBJECT_SELF);
        nSpellDC = GetSpellSaveDC();
    }

    if (nExtraDamage > nMaxExtraDamage)
    {
        nExtraDamage = nMaxExtraDamage;
    }

        //Check for metamagic
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = nMaximized;
    }
    else
    if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage / 2);
    }


    //Check that the target is undead
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        effect eVis2 = EffectVisualEffect(vfx_impactHeal);
        //Figure out the amount of damage to heal
        //nHeal = nDamage;
        //Set the heal effect
        effect eHeal = EffectHeal(nDamage + nExtraDamage);
        //Apply heal effect and VFX impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID, FALSE));
    }
    else if (TouchAttackMelee(oTarget) > 0)
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID));

            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                int nDamageTotal = nDamage + nExtraDamage;
                nDamageTotal += GetMeleeTouchSpecDamage(OBJECT_SELF, 1 , FALSE);
                // A succesful will save halves the damage
                if(MySavingThrow(SAVING_THROW_WILL, oTarget, nSpellDC, SAVING_THROW_ALL,OBJECT_SELF))
                {
                    nDamageTotal = nDamageTotal / 2;
                }
                effect eVis = EffectVisualEffect(vfx_impactHurt);
                effect eDam = EffectDamage(nDamageTotal,DAMAGE_TYPE_NEGATIVE);
                //Apply the VFX impact and effects
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

            }
        }
    }
}
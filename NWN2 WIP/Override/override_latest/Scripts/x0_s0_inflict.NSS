//::///////////////////////////////////////////////
//:: [Inflict Wounds]
//:: [X0_S0_Inflict.nss]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
//:: This script is used by all the inflict spells
//::
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 2002
//:://////////////////////////////////////////////
//:: VFX Pass By:

#include "X0_I0_SPELLS" // * this is the new spells include for expansion packs

#include "x2_inc_spellhook" 

#include "cmi_ginc_spells"

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

void cmi_spellsInflictTouchAttack(int nDamageDice, int nDamage, int nMaxExtraDamage, int nMaximized, int vfx_impactHurt, int vfx_impactHeal, int nSpellID)
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
//    int nTouch = TouchAttackMelee(oTarget);

    int nExtraDamage = GetCasterLevel(OBJECT_SELF); // * figure out the bonus damage

    if (
	nSpellID == SPELL_BG_InflictSerious || 
	nSpellID == SPELL_BG_Spellbook_2 || 
	nSpellID == SPELL_BG_Spellbook_4 || 			
	nSpellID == SPELL_BG_InflictCritical || 
	nSpellID == SPELLABILITY_BG_INFLICT_SERIOUS_WOUNDS || 
	nSpellID == SPELLABILITY_BG_INFLICT_CRITICAL_WOUNDS)
    {
        nExtraDamage = GetLevelByClass(CLASS_TYPE_BLACKGUARD);
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
    else 
	{
		int nMeleeTouch = TouchAttackMelee(oTarget);
		if (nMeleeTouch >0 )
	    {
	        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
	        {
	            //Fire cast spell at event for the specified target
	            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID));
	            if (!MyResistSpell(OBJECT_SELF, oTarget))
	            {
	                int nDamageTotal = nDamage + nExtraDamage;
	                // A succesful will save halves the damage
	                if(MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_ALL,OBJECT_SELF))
	                {
	                    nDamageTotal = nDamageTotal / 2;
	                }
					
					nDamageTotal += GetMeleeTouchSpecDamage(OBJECT_SELF, nDamageDice, FALSE);
					if (nMeleeTouch == TOUCH_ATTACK_RESULT_CRITICAL)
						nDamageTotal = nDamageTotal * 2;
											
					//include sneak attack damage
					nDamageTotal += EvaluateSneakAttack(oTarget, OBJECT_SELF);
									
	                effect eVis = EffectVisualEffect(vfx_impactHurt);
	                effect eDam = EffectDamage(nDamageTotal,DAMAGE_TYPE_NEGATIVE);
	                //Apply the VFX impact and effects
	                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
	                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
	
	            }
	        }
	    }
	}
}

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  
*/

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

  
    int nSpellID = GetSpellId();
	int nHasTSS = GetHasFeat(FEAT_MELEE_TOUCH_SPELL_SPECIALIZATION);
	
	if (nHasTSS)
	{
	    switch (nSpellID)
	    {
	/*Minor*/     case 431: cmi_spellsInflictTouchAttack(1, 1, 0, 1, 246, VFX_HIT_SPELL_INFLICT_1, nSpellID); break;
	/*Light*/     case 432: case 609: cmi_spellsInflictTouchAttack(1, d8() + 2, 5, 10, 246, VFX_HIT_SPELL_INFLICT_2, nSpellID); break;
	/*Moderate*/  case 433: case 610: cmi_spellsInflictTouchAttack(2, d8(2) + 4, 10, 20, 246, VFX_HIT_SPELL_INFLICT_3, nSpellID); break;
	/*Serious*/   case SPELL_BG_InflictSerious: case SPELL_BG_Spellbook_2: case 434: case 611: cmi_spellsInflictTouchAttack(3, d8(3) + 6, 15, 30, 246, VFX_HIT_SPELL_INFLICT_4, nSpellID); break;
	/*Critical*/  case SPELL_BG_Spellbook_4: case SPELL_BG_InflictCritical: case 435: case 612: cmi_spellsInflictTouchAttack(4, d8(4) + 8, 20, 40, 246, VFX_HIT_SPELL_INFLICT_5, nSpellID); break;
	
	    }	
	}
	else
	{		
	    switch (nSpellID)
	    {
	/*Minor*/     case 431: cmi_spellsInflictTouchAttack(1, 1, 0, 1, 246, VFX_HIT_SPELL_INFLICT_1, nSpellID); break;
	/*Light*/     case 432: case 609: cmi_spellsInflictTouchAttack(1, d8(), 5, 8, 246, VFX_HIT_SPELL_INFLICT_2, nSpellID); break;
	/*Moderate*/  case 433: case 610: cmi_spellsInflictTouchAttack(2, d8(2), 10, 16, 246, VFX_HIT_SPELL_INFLICT_3, nSpellID); break;
	/*Serious*/   case SPELL_BG_InflictSerious: case SPELL_BG_Spellbook_2: case 434: case 611: cmi_spellsInflictTouchAttack(3, d8(3), 15, 24, 246, VFX_HIT_SPELL_INFLICT_4, nSpellID); break;
	/*Critical*/  case SPELL_BG_Spellbook_4: case SPELL_BG_InflictCritical: case 435: case 612: cmi_spellsInflictTouchAttack(4, d8(4), 20, 32, 246, VFX_HIT_SPELL_INFLICT_5, nSpellID); break;
	
	    }
	}
}
//::///////////////////////////////////////////////
//:: General Include for Spells
//:: cmi_ginc_spells
//:: Utility script for spells
//:: Created By: Kaedrin (Matt)
//:: Created On: June 25, 2007
//:://////////////////////////////////////////////

//#include "X0_I0_SPELLS"

// X2_IP_ADDPROP_POLICY_REPLACE_EXISTING is in x2_inc_itemprop
// x2_inc_itemprop for item properties, reference marker.
// X2_IP_ADDPROP_POLICY_REPLACE_EXISTING
// X2_IP_ADDPROP_POLICY_KEEP_EXISTING
// X2_IP_ADDPROP_POLICY_IGNORE_EXISTING
// bIgnoreDurationType, bIgnoreSubType
// X2_IP_ADDPROP_POLICY_REPLACE_EXISTING should ALWAYS be FALSE, FALSE/TRUE
// only weapon visuals should be FALSE, TRUE
// OnHit props should be TRUE, FALSE
// Rest should be FALSE, FALSE


// Dec 30 : Integrated old Energy Substitution code

#include "x2_inc_itemprop"
#include "cmi_includes"
#include "cmi_inc_sneakattack"
#include "x0_i0_spells"
#include "cmi_ginc_palrng"

const int INT_CASTER = 1;
const int CHA_CASTER = 2;
const int WIS_CASTER = 3;

const int ELEMENTAL_TYPE_AIR = 0;
const int ELEMENTAL_TYPE_EARTH = 1;
const int ELEMENTAL_TYPE_FIRE = 2;
const int ELEMENTAL_TYPE_WATER = 3;

// the following switches control how Eldrich blast damage is calculated
// prior implementations included hellfire as base damage and therefore affected empower maximize and criticals.
const int WARLOCK_HELLBLAST_PART_OF_BASE_DAMAGE = FALSE;  // if TRUE hellblast will be included as base damage else its bonus
// prior implementations simply multipled all damage by 1.5, compounding with criticals AND getting maximized
const int WARLOCK_EMPBLAST_ONLY_BASE_NEVER_MAXED = TRUE;  // if TRUE empower will give only 50% of base damage, none of bonus damage and will not be maxed
// prior implementations simply multipled all damage by 2, compounding with empower AND getting maximized
const int WARLOCK_CRITS_ONLY_BASE_NEVER_MAXED = TRUE; // if TRUE crits will give only 100% of base damage, none of bonus damage and will not be maxed
// prior implementations simply multipled all damage by 1.5, compounding with everything else AND getting maximized
const int WARLOCK_EPICELDMASTER_ONLY_BASE_NEVER_MAXED = TRUE; // if TRUE Epic Eldrich Master will give only 50% of base damage, none of bonus damage and will not be maxed

effect CreateProtectionFromAlignmentLink2(int nAlignment, int nPower = 1)
{
    int nFinal = nPower * 2;
    effect eAC = EffectACIncrease(nFinal, AC_DEFLECTION_BONUS);
    eAC = VersusAlignmentEffect(eAC, ALIGNMENT_ALL, nAlignment);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nFinal);
    eSave = VersusAlignmentEffect(eSave,ALIGNMENT_ALL, nAlignment);
	
    effect eImmune1 = EffectImmunity(IMMUNITY_TYPE_CHARM);
    effect eImmune2 = EffectImmunity(IMMUNITY_TYPE_DOMINATE);
    effect eImmune3 = EffectImmunity(IMMUNITY_TYPE_FEAR);
    effect eImmune4 = EffectImmunity(IMMUNITY_TYPE_CONFUSED);		
    eImmune1 = VersusAlignmentEffect(eImmune1,ALIGNMENT_ALL, nAlignment);
    eImmune2 = VersusAlignmentEffect(eImmune2,ALIGNMENT_ALL, nAlignment);
    eImmune3 = VersusAlignmentEffect(eImmune3,ALIGNMENT_ALL, nAlignment);
    eImmune4 = VersusAlignmentEffect(eImmune4,ALIGNMENT_ALL, nAlignment);		
	
	effect eDur;
    if(nAlignment == ALIGNMENT_EVIL)
    {
        eDur = EffectVisualEffect( VFX_DUR_SPELL_GOOD_CIRCLE );	// makes use of NWN2 VFX
    }
    else if(nAlignment == ALIGNMENT_GOOD)
    {
        eDur = EffectVisualEffect( VFX_DUR_SPELL_EVIL_CIRCLE );	// makes use of NWN2 VFX
    }

    effect eLink = EffectLinkEffects(eImmune1, eSave);
    eLink = EffectLinkEffects(eLink, eImmune2);
    eLink = EffectLinkEffects(eLink, eImmune3);
    eLink = EffectLinkEffects(eLink, eImmune4);				
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
    return eLink;
}

object cmi_GetTargetedOrEquippedMeleeWeapon()
{
  object oTarget = GetSpellTargetObject();
  if(GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
  {
    if (IPGetIsMeleeWeapon(oTarget))
    {
        return oTarget;
    }
    else
    {
        return OBJECT_INVALID;
    }

  }

  object oWeapon1 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
  if (GetIsObjectValid(oWeapon1) && IPGetIsMeleeWeapon(oWeapon1))
  {
    return oWeapon1;
  }

  oWeapon1 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
  if (GetIsObjectValid(oWeapon1) && IPGetIsMeleeWeapon(oWeapon1))
  {
    return oWeapon1;
  }

  oWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oTarget);
  if (GetIsObjectValid(oWeapon1))
  {
    return oWeapon1;
  }  
  
  oWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oTarget);
  if (GetIsObjectValid(oWeapon1))
  {
    return oWeapon1;
  }
  
  oWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oTarget);
  if (GetIsObjectValid(oWeapon1))
  {
    return oWeapon1;
  }
  
  oWeapon1 = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget);
  if (GetIsObjectValid(oWeapon1) && GetBaseItemType(oWeapon1) == BASE_ITEM_GLOVES)
  {
    return oWeapon1;
  } 

  return OBJECT_INVALID;

}


int AdjustPiercingColdDamage(int nDam, object oTgt)
{		
	int nDamage = nDam;
	if (GetIsObjectValid(oTgt))
	{

		int PercentVuln = 0;
	    effect eVuln = GetFirstEffect(oTgt);	
	    while (GetIsEffectValid(eVuln))
	    {
			if (GetEffectType(eVuln) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE)
			{
				int nDamageType = GetEffectInteger(eVuln, 0);	//Dmg Type
				if (nDamageType == DAMAGE_TYPE_COLD)
				{
					int iVuln = GetEffectInteger(eVuln, 1);	 //Vuln %
					PercentVuln += iVuln;
				}				
			}
	        eVuln = GetNextEffect(oTgt);
	    }	
			
		object oChest = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oTgt);
		if (GetIsObjectValid(oChest))
		{
			int iHasVuln = GetItemHasItemProperty(oChest, ITEM_PROPERTY_DAMAGE_VULNERABILITY);	
			if (iHasVuln)
			{	
				int iTable;
				int iTableVal;
				int iSubType;
				itemproperty ip = GetFirstItemProperty(oChest);
				while (GetIsItemPropertyValid(ip))
				{	
					iTable = GetItemPropertyCostTable(ip); // 22 = Dmg Vuln Table
					iSubType = GetItemPropertySubType(ip); //Dmg Type
					
					if (iTable == 22 && iSubType == IP_CONST_DAMAGETYPE_COLD)	
					{		
						iTableVal = GetItemPropertyCostTableValue(ip); //Vuln %
						if (iTableVal == 4)
							PercentVuln += 50;
						else
						if (iTableVal == 7)
							PercentVuln += 100;	
						else
						if (iTableVal == 3)
							PercentVuln += 25;
						else
						if (iTableVal == 1)
							PercentVuln += 5; 
						else
						if (iTableVal == 5)
							PercentVuln += 75;
						else
						if (iTableVal == 6)
							PercentVuln += 90;
						else
						if (iTableVal == 2)
							PercentVuln += 10;																										
					}													
					ip = GetNextItemProperty(oChest);
				}
			}
		}
		
		if (PercentVuln > 100)
			PercentVuln = 100;	
			
		if (PercentVuln > 0)
			nDamage = nDamage + (nDamage * PercentVuln / 100);
	}
	return nDamage;
}

int GetWarlockCasterLevel(object oCaster)
{
	int nCasterLevel = GetCasterLevel(oCaster);

	if (GetHasFeat(FEAT_PRACTICED_INVOKER,oCaster))
	{
		int nHD = GetHitDice(oCaster);
		if (nCasterLevel < nHD)
		{
			nCasterLevel += 4;
			if (nCasterLevel > nHD)
				nCasterLevel = nHD;
		}
	}	
	
	if (GetHasFeat(FEAT_FEY_POWER, oCaster))
		nCasterLevel++;
	if (GetHasFeat(FEAT_FIENDISH_POWER, oCaster))
		nCasterLevel++;	
		
	if (nCasterLevel > 31)
		nCasterLevel = 31;
	
	return nCasterLevel;
	
}


int GetRangedTouchSpecDamage(object oCaster, int nDice, int nCrit)
{

	int nBonus;
	
	if (GetHasFeat(FEAT_RANGED_TOUCH_SPELL_SPECIALIZATION, oCaster))	
	{
		if (nCrit)
			nBonus = 4;
		else
			nBonus = 2;
	}
	else
		nBonus = 0;
		
	int iImprovedSpellSpec = GetLocalInt(GetModule(), "SpellSpecAdds1PerDie");	
	if (iImprovedSpellSpec)
	{
		if (nCrit)
			nBonus = nDice * 2;
		else
			nBonus = nDice;
	}
	
	int nDMage = GetLevelByClass(CLASS_DAGGERSPELL_MAGE, oCaster);
	if (nDMage > 0)
	{
		object oWeapon1 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
		if (GetIsObjectValid(oWeapon1) && (GetBaseItemType(oWeapon1) == BASE_ITEM_DAGGER) )
		{
			nBonus += d4(1) + IPGetWeaponEnhancementBonus(oWeapon1);
		}
		/*	
		if (nDMage > 4)
		{
			object oWeapon2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
			if (GetIsObjectValid(oWeapon2) && (GetBaseItemType(oWeapon2) == BASE_ITEM_DAGGER) )
			{
				nBonus += d4(1) + IPGetWeaponEnhancementBonus(oWeapon2);
			}
		}
		*/
		
	}
		
			
	return nBonus;
}

int GetMeleeTouchSpecDamage(object oCaster, int nDice, int nCrit)
{
	//Needs +1/dice cmi_option still
	int nBonus;
	
	if (GetHasFeat(FEAT_MELEE_TOUCH_SPELL_SPECIALIZATION, oCaster))	
	{
		if (nCrit)
			nBonus = 4;
		else
			nBonus = 2;
	}
	else
		nBonus = 0;
		
	int iImprovedSpellSpec = GetLocalInt(GetModule(), "SpellSpecAdds1PerDie");	
	if (iImprovedSpellSpec)
	{
		if (nCrit)
			nBonus = nDice * 2;
		else
			nBonus = nDice;
	}	
	
	int nDMage = GetLevelByClass(CLASS_DAGGERSPELL_MAGE, oCaster);
	if (nDMage > 0)
	{
		object oWeapon1 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
		if (GetIsObjectValid(oWeapon1) && (GetBaseItemType(oWeapon1) == BASE_ITEM_DAGGER) )
		{
			nBonus += d4(1) + IPGetWeaponEnhancementBonus(oWeapon1);
		}	
		if (nDMage > 4)
		{
			object oWeapon2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
			if (GetIsObjectValid(oWeapon2) && (GetBaseItemType(oWeapon2) == BASE_ITEM_DAGGER) )
			{
				nBonus += d4(1) + IPGetWeaponEnhancementBonus(oWeapon2);
			}
		}

	}
	
	int nDShaper = GetLevelByClass(CLASS_DAGGERSPELL_SHAPER, oCaster);
	if (nDShaper > 0)
	{
		object oWeapon1 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
		if (GetIsObjectValid(oWeapon1) && (GetBaseItemType(oWeapon1) == BASE_ITEM_DAGGER) )
		{
			nBonus += d4(1) + IPGetWeaponEnhancementBonus(oWeapon1);
		}	
		if (nDShaper > 9)
		{
			object oWeapon2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
			if (GetIsObjectValid(oWeapon2) && (GetBaseItemType(oWeapon2) == BASE_ITEM_DAGGER) )
			{
				nBonus += d4(1) + IPGetWeaponEnhancementBonus(oWeapon2);
			}
		}

	}					
	
	return nBonus;		
}

int GetBlackguardCasterLevel(object oCaster)
{
	int nCasterLvl = GetLevelByClass(CLASS_TYPE_BLACKGUARD, oCaster);
	int nKoT = GetLevelByClass(CLASS_KNIGHT_TIERDRIAL, oCaster);
	int nDrSlr = GetLevelByClass(CLASS_DRAGONSLAYER, oCaster);
	int nCoN = GetLevelByClass(CLASS_CHILD_NIGHT, oCaster);
	
	if (GetHasFeat(FEAT_PRACTICED_SPELLCASTER_BLACKGUARD, oCaster))
	{
		nCasterLvl += 4;
	}	
	
	if (nKoT > 0 && GetHasFeat(FEAT_KOT_SPELLCASTING_BLACKGUARD, oCaster))
		nCasterLvl += nKoT;	
		
	if (nDrSlr > 0 && GetHasFeat(FEAT_DRSLR_SPELLCASTING_BLACKGUARD, oCaster))
		nCasterLvl += nDrSlr / 2;
		
	if (nCoN > 1 && GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_BLACKGUARD, oCaster))
		nCasterLvl += (nCoN - 1);			
		
	if (nCasterLvl > GetHitDice(oCaster))
		nCasterLvl = GetHitDice(oCaster);				
	
	return nCasterLvl;
}

int GetAssassinCasterLevel(object oCaster)
{
	int nAssasLvl = GetLevelByClass(CLASS_TYPE_ASSASSIN);
	int nAvengLvl = GetLevelByClass(CLASS_AVENGER);
	int nKoT = GetLevelByClass(CLASS_KNIGHT_TIERDRIAL, oCaster);
	int nDrSlr = GetLevelByClass(CLASS_DRAGONSLAYER, oCaster);
	int nCoN = GetLevelByClass(CLASS_CHILD_NIGHT, oCaster);
				
	if (GetHasFeat(FEAT_PRACTICED_SPELLCASTER_ASSASSIN, oCaster))
	{
			nAssasLvl += 4;
	}
	if (GetHasFeat(FEAT_PRACTICED_SPELLCASTER_AVENGER, oCaster))
	{
			nAvengLvl += 4;
	}	
	
	if (nKoT > 0 && GetHasFeat(FEAT_KOT_SPELLCASTING_ASSASSIN, oCaster))
		nAssasLvl += nKoT;	
	if (nKoT > 0 && GetHasFeat(FEAT_KOT_SPELLCASTING_AVENGER, oCaster))
		nAvengLvl += nKoT;							
		
	if (nDrSlr > 0 && GetHasFeat(FEAT_DRSLR_SPELLCASTING_ASSASSIN, oCaster))
		nAssasLvl += nDrSlr / 2;	
	if (nDrSlr > 0 && GetHasFeat(FEAT_DRSLR_SPELLCASTING_AVENGER, oCaster))
		nAvengLvl += nDrSlr / 2;	
		
	if (nCoN > 1 && GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_ASSASSIN, oCaster))
		nAssasLvl += (nCoN - 1);	
	if (nCoN > 1 && GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_AVENGER, oCaster))
		nAvengLvl += (nCoN - 1);						
	
	int nCasterLvl = nAssasLvl + nAvengLvl;	
	
	if (nCasterLvl > GetHitDice(oCaster))
		nCasterLvl = GetHitDice(oCaster);	
	
	return nCasterLvl;
}

int GetWarlockDC(object oWarlock, int nInvocation = 0)
{
	int nDC = GetSpellSaveDC();
	
	if (nInvocation == 0 && GetHasFeat(FEAT_ABILITY_FOCUS_ELDRITCH_BLAST, oWarlock))
	{
		nDC += 2;
	}		
	
	if (nInvocation == 1 && GetHasFeat(FEAT_ABILITY_FOCUS_INVOCATIONS, oWarlock))
	{
		nDC += 2;	
	}
	
	if (GetHasFeat(FEAT_EPIC_LORD_OF_ALL_ESSENCES, oWarlock))
	{
		nDC += 2;
	}		
	
	if (GetHasFeat(FEAT_FEY_POWER, oWarlock))
		nDC++;
		
	if (GetHasFeat(FEAT_FIENDISH_POWER, oWarlock))
		nDC++;		
		
	return nDC;
}

int GetConeEffect(int DAMAGE_TYPE_X)
{
	switch (DAMAGE_TYPE_X)
	{
		case DAMAGE_TYPE_ACID:
			return VFX_DUR_CONE_ACID;
		case DAMAGE_TYPE_ALL:
			return VFX_DUR_CONE_MAGIC;
		case DAMAGE_TYPE_BLUDGEONING:
			return VFX_DUR_CONE_MAGIC;
		case DAMAGE_TYPE_COLD:
			return VFX_DUR_CONE_ICE;
		case DAMAGE_TYPE_DIVINE:
			return VFX_DUR_CONE_HOLY;
		case DAMAGE_TYPE_ELECTRICAL:
			return VFX_DUR_CONE_LIGHTNING;
		case DAMAGE_TYPE_FIRE:
			return VFX_DUR_CONE_FIRE;				
		case DAMAGE_TYPE_MAGICAL:
			return VFX_DUR_CONE_MAGIC;
		case DAMAGE_TYPE_NEGATIVE:
			return VFX_DUR_CONE_EVIL;
		case DAMAGE_TYPE_PIERCING:
			return VFX_DUR_CONE_MAGIC;
		case DAMAGE_TYPE_POSITIVE:
			return VFX_DUR_CONE_HOLY;
		case DAMAGE_TYPE_SLASHING:
			return VFX_DUR_CONE_MAGIC;
		case DAMAGE_TYPE_SONIC:
			return VFX_DUR_CONE_SONIC;																																	
		default: 
			return VFX_DUR_CONE_MAGIC;
	}
	return VFX_DUR_CONE_MAGIC;
}

int GetHitEffect(int DAMAGE_TYPE_X)
{
	switch (DAMAGE_TYPE_X)
	{
		case DAMAGE_TYPE_ACID:
			return VFX_HIT_SPELL_ACID;
		case DAMAGE_TYPE_ALL:
			return VFX_HIT_SPELL_MAGIC;
		case DAMAGE_TYPE_BLUDGEONING:
			return VFX_HIT_SPELL_MAGIC;
		case DAMAGE_TYPE_COLD:
			return VFX_HIT_SPELL_ICE;
		case DAMAGE_TYPE_DIVINE:
			return VFX_HIT_SPELL_HOLY;
		case DAMAGE_TYPE_ELECTRICAL:
			return VFX_HIT_SPELL_LIGHTNING;
		case DAMAGE_TYPE_FIRE:
			return VFX_HIT_SPELL_FIRE;					
		case DAMAGE_TYPE_MAGICAL:
			return VFX_HIT_SPELL_MAGIC;
		case DAMAGE_TYPE_NEGATIVE:
			return VFX_HIT_SPELL_NECROMANCY;
		case DAMAGE_TYPE_PIERCING:
			return VFX_HIT_SPELL_MAGIC;
		case DAMAGE_TYPE_POSITIVE:
			return VFX_HIT_SPELL_HOLY;
		case DAMAGE_TYPE_SLASHING:
			return VFX_HIT_SPELL_MAGIC;
		case DAMAGE_TYPE_SONIC:
			return VFX_HIT_SPELL_SONIC;																																	
		default: 
			return VFX_HIT_SPELL_MAGIC;
	}
	return VFX_HIT_SPELL_MAGIC;
}

int GetSaveType(int DAMAGE_TYPE_X)
{			
	switch (DAMAGE_TYPE_X)
	{
		case DAMAGE_TYPE_ACID:
			return SAVING_THROW_TYPE_ACID;
		case DAMAGE_TYPE_ALL:
			return SAVING_THROW_TYPE_ALL;
		case DAMAGE_TYPE_BLUDGEONING:
			return SAVING_THROW_TYPE_ALL;
		case DAMAGE_TYPE_COLD:
			return SAVING_THROW_TYPE_COLD;
		case DAMAGE_TYPE_DIVINE:
			return SAVING_THROW_TYPE_DIVINE;
		case DAMAGE_TYPE_ELECTRICAL:
			return SAVING_THROW_TYPE_ELECTRICITY;
		case DAMAGE_TYPE_FIRE:
			return SAVING_THROW_TYPE_FIRE;		
		case DAMAGE_TYPE_MAGICAL:
			return SAVING_THROW_TYPE_ALL;
		case DAMAGE_TYPE_NEGATIVE:
			return SAVING_THROW_TYPE_NEGATIVE;
		case DAMAGE_TYPE_PIERCING:
			return SAVING_THROW_TYPE_ALL;
		case DAMAGE_TYPE_POSITIVE:
			return SAVING_THROW_TYPE_POSITIVE;
		case DAMAGE_TYPE_SLASHING:
			return SAVING_THROW_TYPE_ALL;
		case DAMAGE_TYPE_SONIC:
			return SAVING_THROW_TYPE_SONIC;																																	
		default: 
			return SAVING_THROW_TYPE_ALL;
	}
	return SAVING_THROW_TYPE_ALL;
}

int GetDamageType(int DAMAGE_TYPE_X, object oCaster = OBJECT_SELF, int isSpell = 1, int isEnergySubsValid = 0)
{	
	//Handles Piercing Cold
	if (GetHasFeat(FEAT_FROSTMAGE_PIERCING_COLD , oCaster) && isSpell && DAMAGE_TYPE_X == DAMAGE_TYPE_COLD)
	{
		if (DAMAGE_TYPE_X == DAMAGE_TYPE_COLD)
			return DAMAGE_TYPE_MAGICAL;
	}
		
	if (GetHasFeat(FEAT_ENERGY_SUBSTITUTION , oCaster) && isSpell && isEnergySubsValid)
	{
		if (GetHasSpellEffect(SPELLABILITY_ENERGY_SUBSTITUTION_ACID,oCaster) )
			return DAMAGE_TYPE_ACID;
		else
		if (GetHasSpellEffect(SPELLABILITY_ENERGY_SUBSTITUTION_COLD,oCaster) )
			return DAMAGE_TYPE_COLD;
		else
		if (GetHasSpellEffect(SPELLABILITY_ENERGY_SUBSTITUTION_ELEC,oCaster) )
			return DAMAGE_TYPE_ELECTRICAL;
		else
		if (GetHasSpellEffect(SPELLABILITY_ENERGY_SUBSTITUTION_FIRE,oCaster) )
			return DAMAGE_TYPE_FIRE;
		else
		if (GetHasSpellEffect(SPELLABILITY_ENERGY_SUBSTITUTION_SONIC,oCaster) )
			return DAMAGE_TYPE_SONIC;											
	}
		
	switch (DAMAGE_TYPE_X)
	{
		case DAMAGE_TYPE_ACID:
			return DAMAGE_TYPE_ACID;
		case DAMAGE_TYPE_ALL:
			return DAMAGE_TYPE_ALL;
		case DAMAGE_TYPE_BLUDGEONING:
			return DAMAGE_TYPE_BLUDGEONING;
		case DAMAGE_TYPE_COLD:
			return DAMAGE_TYPE_COLD;
		case DAMAGE_TYPE_DIVINE:
			return DAMAGE_TYPE_DIVINE;
		case DAMAGE_TYPE_ELECTRICAL:
			return DAMAGE_TYPE_ELECTRICAL;
		case DAMAGE_TYPE_FIRE:
			return DAMAGE_TYPE_FIRE;			
		case DAMAGE_TYPE_MAGICAL:
			return DAMAGE_TYPE_MAGICAL;
		case DAMAGE_TYPE_NEGATIVE:
			return DAMAGE_TYPE_NEGATIVE;
		case DAMAGE_TYPE_PIERCING:
			return DAMAGE_TYPE_PIERCING;
		case DAMAGE_TYPE_POSITIVE:
			return DAMAGE_TYPE_POSITIVE;
		case DAMAGE_TYPE_SLASHING:
			return DAMAGE_TYPE_SLASHING;
		case DAMAGE_TYPE_SONIC:
			return DAMAGE_TYPE_SONIC;																																	
		default: 
			return DAMAGE_TYPE_ALL;
	}
	return DAMAGE_TYPE_ALL;
}

void WildShape_Unarmed(object oPC, float fDuration)
{
	object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);	
	
	itemproperty iBonusFeat;
	
	if (GetHasFeat(1355, oPC))
	{
		iBonusFeat = ItemPropertyBonusFeat(293); //	Power Crit Cr. 
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oHide,fDuration);	
	}
	
	if (GetHasFeat(1129, oPC))
	{
		iBonusFeat = ItemPropertyBonusFeat(345); //	G Wpn Foc Cr. 
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oHide,fDuration);	
	}	
	
	if (GetHasFeat(1169, oPC))
	{
		iBonusFeat = ItemPropertyBonusFeat(385); //	G Wpn Spec Cr.
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oHide,fDuration);	
	}
	
	if (GetHasFeat(100, oPC))
	{
		iBonusFeat = ItemPropertyBonusFeat(402); //	Wpn Foc Cr.
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oHide,fDuration);	
	}
	
	if (GetHasFeat(62, oPC))
	{
		iBonusFeat = ItemPropertyBonusFeat(IPRP_FEAT_IMPCRITCREATURE); //	Imp Crit Cr.
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oHide,fDuration);	
	}	
	
	if (GetHasFeat(138, oPC))
	{
		iBonusFeat = ItemPropertyBonusFeat(IPRP_FEAT_WPNSPEC_CREATURE); //	Wpn Spec Cr.
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oHide,fDuration);	
	}
	
	if (GetHasFeat(630, oPC))
	{
		iBonusFeat = ItemPropertyBonusFeat(IPRP_FEAT_EPICWPNFOC_CREATURE); //	 Epic Wpn Foc Cr.
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oHide,fDuration);	
	}	
	
	if (GetHasFeat(668, oPC))
	{
		iBonusFeat = ItemPropertyBonusFeat(IPRP_FEAT_EPICWPNSPEC_CREATURE); //	 Epic Wpn Spec Cr.
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oHide,fDuration);	
	}	
	
	if (GetHasFeat(720, oPC))
	{
		iBonusFeat = ItemPropertyBonusFeat(IPRP_FEAT_EPICOVERWHELMCRIT_CREATURE); //	 Epic Over Crit Cr.
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oHide,fDuration);	
	}
												
	//IPRP   xxx       Unarmed_FeatId
	//293 Power Crit Cr. 1355
	//345 G Wpn Foc Cr. 1129
	//385 G Wpn Spec Cr. 1169
	//402 Wpn Foc Cr.  100
	//804 Imp Crit Cr.   62
	//805 Wpn Spec Cr. 138
	//806 Epic Wpn Foc Cr. 	630
	//807 Epic Wpn Spec Cr. 668
	//808 Epic Over Crit Cr. 720
	
}

void BuffSummons(object oPC, int nElemental = 0, int nAshbound = 0)
{
	object oTarget = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
	if (GetHasFeat(FEAT_BECKON_THE_FROZEN, oPC))
	{
		effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_COLD);
		effect eDmgImm = EffectDamageResistance(DAMAGE_TYPE_COLD, 9999, 0);		
		effect eDmgVul = EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE, 50);
		effect eLink = EffectLinkEffects(eDmgVul, eDmgImm);
		eLink = EffectLinkEffects(eLink, eDmg);
		eLink = SetEffectSpellId(eLink,FEAT_BECKON_THE_FROZEN);
		eLink = SupernaturalEffect(eLink);	
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget));
	}
	if (nElemental == 1 && GetHasFeat(FEAT_AUGMENT_ELEMENTAL, oPC))
	{	
		effect eLink = EffectTemporaryHitpoints(GetHitDice(oTarget)*2);
		eLink = SetEffectSpellId(eLink,FEAT_AUGMENT_ELEMENTAL);
		eLink = SupernaturalEffect(eLink);	
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget));
	
		itemproperty iEnhance = ItemPropertyEnhancementBonus(2);	
	   object oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oTarget);
	  if (GetIsObjectValid(oWeapon))
	  {
		AddItemProperty(DURATION_TYPE_PERMANENT, iEnhance, oWeapon);
	  } 
	
	  oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oTarget);
	  if (GetIsObjectValid(oWeapon))
	  {
		AddItemProperty(DURATION_TYPE_PERMANENT, iEnhance, oWeapon);
	  }
	
	  oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oTarget);
	  if (GetIsObjectValid(oWeapon))
	  {
		AddItemProperty(DURATION_TYPE_PERMANENT, iEnhance, oWeapon);
	  }	
		
	}
	
	if (nAshbound == 1 && GetHasFeat(FEAT_ASHBOUND, oPC))
	{	
		effect eLink = EffectAttackIncrease(3);
		eLink = SetEffectSpellId(eLink,FEAT_ASHBOUND);
		eLink = SupernaturalEffect(eLink);	
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget));
	}		
	
	//return TRUE;

}

effect IncorporealEffect(object oTarget)
{

	int nChaAC = GetAbilityModifier(ABILITY_CHARISMA, oTarget);
	effect eAC = EffectACIncrease(nChaAC, AC_DEFLECTION_BONUS);
	effect eConceal = EffectConcealment(50);
	effect eSR = EffectSpellResistanceIncrease(25);
	
	effect eLink = EffectLinkEffects(eAC,eConceal);
	eLink = EffectLinkEffects(eSR, eLink);
	eLink = SupernaturalEffect(eLink);

	return eLink;
	
}

void ApplyPhantomStats(object oOwner)
{
	object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oOwner);
	effect eLink = IncorporealEffect(oSummon);
	effect eDamage = EffectDamageIncrease(DAMAGE_BONUS_2d10, DAMAGE_TYPE_COLD);
	eLink = EffectLinkEffects(eDamage, eLink);

	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oSummon));
}

void WildshapeCheck(object oTarget, object oCursedPolyItem)
{

    if (!GetHasEffect( EFFECT_TYPE_POLYMORPH, oTarget))
    {
    	DelayCommand(0.3f, DestroyObject(oCursedPolyItem, 0.1f, FALSE));
		RemoveEffectsFromSpell(oTarget, SPELLABILITY_EXALTED_WILD_SHAPE);
		RemoveEffectsFromSpell(oTarget, -FEAT_NATWARR_NATARM_CROC);
		RemoveEffectsFromSpell(oTarget, -FEAT_NATWARR_NATARM_GRIZZLY);
		RemoveEffectsFromSpell(oTarget, -FEAT_NATWARR_NATARM_GROWTH);
		RemoveEffectsFromSpell(oTarget, -FEAT_NATWARR_NATARM_BLAZE);
		RemoveEffectsFromSpell(oTarget, -FEAT_NATWARR_NATARM_CLOUD);
		RemoveEffectsFromSpell(oTarget, -FEAT_NATWARR_NATARM_EARTH);
		if (GetLevelByClass(CLASS_FIST_FOREST, oTarget) > 0)
			ExecuteScript("cmi_s2_fotfacbonus",oTarget);									
        return;
    }
	else
	    DelayCommand(6.0f, WildshapeCheck(oTarget, oCursedPolyItem) );

}

void AddSpellSlotsToObject(object oSource, object oTarget, float nDuration)
{

		if (GetIsObjectValid(oSource))
		{
			itemproperty ipLoop=GetFirstItemProperty(oSource);
			while (GetIsItemPropertyValid(ipLoop))
			{
			
				//SendMessageToPC(OBJECT_SELF, "InLoop");
			  	if (GetItemPropertyType(ipLoop)==ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
				{
				  //SendMessageToPC(OBJECT_SELF, "Bonus Slot Found on Item");
				  AddItemProperty(DURATION_TYPE_TEMPORARY, ipLoop, oTarget,nDuration);
				}
			
			   	ipLoop=GetNextItemProperty(oSource);
			}
		}

}


int GetDamageBonusByValue(int nValue)
{

	switch (nValue)
	{
		case 1: 
			return DAMAGE_BONUS_1;
		break;
		
		case 2: 
			return DAMAGE_BONUS_2;
		break;	
		
		case 3: 
			return DAMAGE_BONUS_3;
		break;	
	
		case 4: 
			return DAMAGE_BONUS_4;
		break;	

		case 5: 
			return DAMAGE_BONUS_5;
		break;	
		
		case 6: 
			return DAMAGE_BONUS_6;
		break;	

		case 7: 
			return DAMAGE_BONUS_7;
		break;	
		
		case 8: 
			return DAMAGE_BONUS_8;
		break;	
		
		case 9: 
			return DAMAGE_BONUS_9;
		break;	
		
		case 10: 
			return DAMAGE_BONUS_10;
		break;	
		
		case 11: 
			return DAMAGE_BONUS_11;
		break;																								
	
		case 12: 
			return DAMAGE_BONUS_12;
		break;	
		
		case 13: 
			return DAMAGE_BONUS_13;
		break;	
		
		case 14: 
			return DAMAGE_BONUS_14;
		break;	
		
		case 15: 
			return DAMAGE_BONUS_15;
		break;
					
		case 16: 
			return DAMAGE_BONUS_16;
		break;
					
		case 17: 
			return DAMAGE_BONUS_17;
		break;
					
		case 18: 
			return DAMAGE_BONUS_18;
		break;
					
		case 19: 
			return DAMAGE_BONUS_19;
		break;
					
		case 20: 
			return DAMAGE_BONUS_20;
		break;
				
		default: 
			return DAMAGE_BONUS_21;																			
		break;											
	}
	return 0;

}

object IPGetTargetedOrEquippedShield()
{
  object oTarget = GetSpellTargetObject();
  if(GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
  {
    if (GetBaseItemType(oTarget) == BASE_ITEM_LARGESHIELD ||
                               GetBaseItemType(oTarget) == BASE_ITEM_SMALLSHIELD ||
                                GetBaseItemType(oTarget) == BASE_ITEM_TOWERSHIELD)
    {
        return oTarget;
    }
    else
    {
		return OBJECT_INVALID;
    }


  }
  else
  {
      object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
      if (GetIsObjectValid(oShield) && (GetBaseItemType(oShield) == BASE_ITEM_LARGESHIELD ||
                               GetBaseItemType(oShield) == BASE_ITEM_SMALLSHIELD ||
                                GetBaseItemType(oShield) == BASE_ITEM_TOWERSHIELD))
      {
        return oShield;
      }
    }



  return OBJECT_INVALID;

}


object IPGetTargetedOrEquippedWeapon()
{
  object oTarget = GetSpellTargetObject();
  if(GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
  {
  
   if (IPGetIsMeleeWeapon(oTarget) || IPGetIsRangedWeapon(oTarget))
    {
        return oTarget;
    }
    else
    {
        return OBJECT_INVALID;
    }

  }

  object oWeapon1 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
  if (GetIsObjectValid(oWeapon1) && (IPGetIsRangedWeapon(oWeapon1) || IPGetIsMeleeWeapon(oWeapon1)))
  {
    return oWeapon1;
  }

  oWeapon1 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
  if (GetIsObjectValid(oWeapon1) && (IPGetIsRangedWeapon(oWeapon1) || IPGetIsMeleeWeapon(oWeapon1)))
  {
    return oWeapon1;
  }
  
   oWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oTarget);
  if (GetIsObjectValid(oWeapon1))
  {
    return oWeapon1;
  } 

  oWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oTarget);
  if (GetIsObjectValid(oWeapon1))
  {
    return oWeapon1;
  }

  oWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oTarget);
  if (GetIsObjectValid(oWeapon1))
  {
    return oWeapon1;
  }
  
   oWeapon1 = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget);
  if (GetIsObjectValid(oWeapon1))
  {
    return oWeapon1;
  } 

  return OBJECT_INVALID;

}

void DoCamoflage2(object oTarget)
{
    //Declare major variables
    //effect eVis = EffectVisualEffect(VFX_HIT_SPELL_TRANSMUTATION);	// NWN1 VFX
    effect eVis = EffectVisualEffect( 631 );	// NWN2 VFX: VFX_DUR_SPELL_CAMOFLAGE
    effect eHide = EffectSkillIncrease(SKILL_HIDE, 10);
    //effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);	// NWN1 VFX
    effect eLink = EffectLinkEffects(eHide, eVis);

    float fDuration = TurnsToSeconds(GetPalRngCasterLevel()); // * Duration 1 turn/level
    fDuration = ApplyMetamagicDurationMods(fDuration);
    int nDurType = ApplyMetamagicDurationTypeMods(DURATION_TYPE_TEMPORARY);

    //Fire spell cast at event for target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 421, FALSE));

    //Apply VFX impact and bonus effects
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);	// NWN1 VFX
    ApplyEffectToObject(nDurType, eLink, oTarget, fDuration);
}

void cmi_HealHarmNearby(effect eVis, effect eVis2, int nCasterLvl, int nSpellId )
{
    //Get first target in shape
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
		// this won't effect oTarget unless it is a friendly non-undead or enemy undead
 		HealHarmObject( oTarget, eVis, eVis2, nCasterLvl, nSpellId );

        //Get next target in the shape
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
    }
}
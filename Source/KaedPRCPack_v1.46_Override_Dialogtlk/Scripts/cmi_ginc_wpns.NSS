//::///////////////////////////////////////////////
//:: General Include for Weapons Effects
//:: cmi_ginc_wpns
//:: Utility script for Weapons
//:: Created By: Kaedrin (Matt)
//:: Created On: May 18, 2008
//:://////////////////////////////////////////////

#include "x2_inc_itemprop"

int GetDamageByIPConstDamageBonus(int nDamageBonus)
{
	switch (nDamageBonus)
	{
		case IP_CONST_DAMAGEBONUS_1: 
			return 1;
			break;
			
		case IP_CONST_DAMAGEBONUS_10: 
			return 10;
			break;
			
		case IP_CONST_DAMAGEBONUS_1d10: 
			return d10(1);
			break;	
			
		case IP_CONST_DAMAGEBONUS_1d12: 
			return d12(1);
			break;
			
		case IP_CONST_DAMAGEBONUS_1d4: 
			return d4(1);
			break;
			
		case IP_CONST_DAMAGEBONUS_1d6: 
			return d6(1);
			break;	
		
		case IP_CONST_DAMAGEBONUS_1d8: 
			return d8(1);
			break;
			
		case IP_CONST_DAMAGEBONUS_2: 
			return 2;
			break;
			
		case IP_CONST_DAMAGEBONUS_2d10: 
			return d10(2);
			break;	
			
		case IP_CONST_DAMAGEBONUS_2d12: 
			return d12(2);
			break;
			
		case IP_CONST_DAMAGEBONUS_2d4: 
			return d4(2);
			break;
			
		case IP_CONST_DAMAGEBONUS_2d6: 
			return d6(2);
			break;	
			
		case IP_CONST_DAMAGEBONUS_2d8: 
			return d8(2);
			break;
			
		case IP_CONST_DAMAGEBONUS_3: 
			return 3;
			break;
			
		case IP_CONST_DAMAGEBONUS_3d10: 
			return d10(3);
			break;	
		
		case IP_CONST_DAMAGEBONUS_3d12: 
			return d12(3);
			break;
			
		case IP_CONST_DAMAGEBONUS_3d6: 
			return d6(3);
			break;
			
		case IP_CONST_DAMAGEBONUS_4: 
			return 4;
			break;	
			
		case IP_CONST_DAMAGEBONUS_4d10: 
			return d10(4);
			break;
			
		case IP_CONST_DAMAGEBONUS_4d12: 
			return d12(4);
			break;
			
		case IP_CONST_DAMAGEBONUS_4d6: 
			return d6(4);
			break;	
			
		case IP_CONST_DAMAGEBONUS_4d8: 
			return d8(4);
			break;
			
		case IP_CONST_DAMAGEBONUS_5: 
			return 5;
			break;
			
		case IP_CONST_DAMAGEBONUS_5d12: 
			return d12(5);
			break;	
		
		case IP_CONST_DAMAGEBONUS_5d6: 
			return d6(5);
			break;
			
		case IP_CONST_DAMAGEBONUS_6: 
			return 6;
			break;
			
		case IP_CONST_DAMAGEBONUS_6d12: 
			return d12(6);
			break;	
			
		case IP_CONST_DAMAGEBONUS_6d6: 
			return d6(6);
			break;
			
		case IP_CONST_DAMAGEBONUS_7: 
			return 7;
			break;
			
		case IP_CONST_DAMAGEBONUS_8: 
			return 8;
			break;	
			
		case IP_CONST_DAMAGEBONUS_9: 
			return 9;
			break;
			
		default: 
			return 1;
			break;																				
			
	}
	
	return 1;
}

int GetDamageByDamageBonus(int nDamageBonus)
{
	switch (nDamageBonus)
	{
		case DAMAGE_BONUS_1: 
			return 1;
			break;
			
		case DAMAGE_BONUS_10: 
			return 10;
			break;	
	
		case DAMAGE_BONUS_11: 
			return 11;
			break;	
			
		case DAMAGE_BONUS_12: 
			return 12;
			break;	
		
		case DAMAGE_BONUS_13: 
			return 13;
			break;	
			
		case DAMAGE_BONUS_14: 
			return 14;
			break;	
			
		case DAMAGE_BONUS_15: 
			return 15;
			break;	
			
		case DAMAGE_BONUS_16: 
			return 16;
			break;	
			
		case DAMAGE_BONUS_17: 
			return 17;
			break;	
			
		case DAMAGE_BONUS_18: 
			return 18;
			break;	
			
		case DAMAGE_BONUS_19: 
			return 19;
			break;	
			
		case DAMAGE_BONUS_1d10: 
			return d10(1);
			break;	
			
		case DAMAGE_BONUS_1d12: 
			return d12(1);
			break;	
			
		case DAMAGE_BONUS_1d4: 
			return d4(1);
			break;	
			
		case DAMAGE_BONUS_1d6: 
			return d6(1);
			break;	
			
		case DAMAGE_BONUS_1d8: 
			return d8(1);
			break;	
			
		case DAMAGE_BONUS_2: 
			return 2;
			break;	
			
		case DAMAGE_BONUS_20: 
			return 20;
			break;	
			
		case DAMAGE_BONUS_21: 
			return 21;
			break;	
			
		case DAMAGE_BONUS_22: 
			return 22;
			break;	
			
		case DAMAGE_BONUS_23: 
			return 23;
			break;	
			
		case DAMAGE_BONUS_24: 
			return 24;
			break;	
			
		case DAMAGE_BONUS_25: 
			return 25;
			break;	
			
		case DAMAGE_BONUS_26: 
			return 26;
			break;	
			
		case DAMAGE_BONUS_27: 
			return 27;
			break;	
			
		case DAMAGE_BONUS_28: 
			return 28;
			break;	
			
		case DAMAGE_BONUS_29: 
			return 29;
			break;	
			
		case DAMAGE_BONUS_2d10: 
			return d10(2);
			break;	
			
		case DAMAGE_BONUS_2d12: 
			return d12(2);
			break;
			
		case DAMAGE_BONUS_2d4: 
			return d4(2);
			break;	
			
		case DAMAGE_BONUS_2d6: 
			return d6(2);
			break;	
			
		case DAMAGE_BONUS_2d8: 
			return d8(2);
			break;	
			
		case DAMAGE_BONUS_3: 
			return 3;
			break;	
			
		case DAMAGE_BONUS_30: 
			return 30;
			break;	
			
		case DAMAGE_BONUS_31: 
			return 31;
			break;
			
		case DAMAGE_BONUS_32: 
			return 32;
			break;	
			
		case DAMAGE_BONUS_33: 
			return 33;
			break;	
			
		case DAMAGE_BONUS_34: 
			return 34;
			break;	
			
		case DAMAGE_BONUS_35: 
			return 35;
			break;	
			
		case DAMAGE_BONUS_36: 
			return 36;
			break;	
			
		case DAMAGE_BONUS_37: 
			return 37;
			break;
			
		case DAMAGE_BONUS_38: 
			return 38;
			break;	
			
		case DAMAGE_BONUS_39: 
			return 39;
			break;	
			
		case DAMAGE_BONUS_4: 
			return 4;
			break;	
			
		case DAMAGE_BONUS_40: 
			return 40;
			break;	
			
		case DAMAGE_BONUS_5: 
			return 5;
			break;	
			
		case DAMAGE_BONUS_6: 
			return 6;
			break;	
			
		case DAMAGE_BONUS_7: 
			return 7;
			break;	
			
		case DAMAGE_BONUS_8: 
			return 8;
			break;	
			
		case DAMAGE_BONUS_9: 
			return 9;
			break;	
			
		default: 
			return 1;
			break;																																																																				
	}
	return 1;
}

int GetDamageByDiceString(string sDice, int nNum)
{

	int nDamage = 1;
	if (sDice == "d2")
		nDamage = d3(nNum);
	else
	if (sDice == "d3")
		nDamage = d3(nNum);
	else
	if (sDice == "d4")
		nDamage = d3(nNum);
	else
	if (sDice == "d6")
		nDamage = d3(nNum);
	else
	if (sDice == "d8")
		nDamage = d3(nNum);
	else
	if (sDice == "d10")
		nDamage = d3(nNum);
	else
	if (sDice == "d12")
		nDamage = d3(nNum);													
	
	return nDamage;	
}

effect GenerateAttackEffect(object oPC, object oWeapon, 
	int nbSlash = 0, int nbBlunt = 0, int nbPierce = 1, int nbAcid = 0, int nbCold = 0,
	int nbElec = 0, int nbFire = 0, int nbSonic = 0, int nbDivine = 0, 	int nbMagic = 0,
	int nbPosit = 0, int nbNegat = 0 )
	
{

	int nBaseItemType = GetBaseItemType(oWeapon); 
	int nIsRanged = GetWeaponRanged(oWeapon);
	
	string basedice = Get2DAString("baseitems", "DieToRoll", nBaseItemType);
	int nDiceNum = StringToInt( Get2DAString("baseitems", "NumDice", nBaseItemType) );
	int nBaseDamage = GetDamageByDiceString(basedice, nDiceNum);
	int nWeaponType = GetWeaponType(oWeapon);
	int nSlash = 0 + nbSlash;
	int nBlunt = 0 + nbBlunt;
	int nPierce = 1 + nbPierce;
	int nAcid = 0 + nbAcid;
	int nCold = 0 + nbCold;
	int nElec = 0 + nbElec;
	int nFire = 0 + nbFire;
	int nSonic = 0 + nbSonic;
	int nDivine = 0 + nbDivine;
	int nMagic = 0 + nbMagic;
	int nPosit = 0 + nbPosit;
	int nNegat = 0 + nbNegat;		
	
	int nStrMod = GetAbilityModifier(ABILITY_STRENGTH, oPC);
	
	if (GetHasFeat(1957, oPC)) //Combat Insight
	{
		int nIntMod = GetAbilityModifier(ABILITY_INTELLIGENCE, oPC);
		if (nIntMod > nStrMod)
		{
			if (!nIsRanged)
			{
				object oLeftHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
				if (!GetIsObjectValid(oLeftHand))
				{
					//Two-Handed
					nStrMod = nStrMod + (((nIntMod - nStrMod)*3)/2);
				}
				else
				{
					//One-Handed
					nStrMod = nStrMod + (nIntMod - nStrMod);
				}	
			}
		
		}
				
	}
	nBaseDamage += nStrMod;
	
	//Needs Wpn Spec, Epic Wpn Spec
	
	if (GetHasFeat(1740, oPC)) //FEAT_PRECISE_STRIKE
	{
		object oLeftHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
		if (!GetIsObjectValid(oLeftHand))
		{
			//Nothing in the left hand
			if (nWeaponType == WEAPON_TYPE_PIERCING || nWeaponType == WEAPON_TYPE_PIERCING_AND_SLASHING)
			{
				//Valid Precise Strike weapon
				if (GetLevelByClass(CLASS_TYPE_DUELIST, oPC) == 10)
					nPierce += d6(2);
				else
					nPierce += d6(1);
			}
		}	
			
	}
	
	if (nWeaponType == WEAPON_TYPE_SLASHING || nWeaponType == WEAPON_TYPE_PIERCING_AND_SLASHING)
		nSlash = nBaseDamage;
	else
	if (nWeaponType == WEAPON_TYPE_PIERCING)
		nPierce = nBaseDamage;
	else
	if (nWeaponType == WEAPON_TYPE_BLUDGEONING)
		nBlunt = nBaseDamage;		
	
	effect eEffect = GetFirstEffect(oPC);
	while(GetIsEffectValid(eEffect))
	{
		int nType = GetEffectType(eEffect);
		if(nType == EFFECT_TYPE_DAMAGE_INCREASE)
		{
//			int i0 = GetEffectInteger(eEffect, 0); //DamageBonus
//			int i1 = GetEffectInteger(eEffect, 1); //DamageType
			int nDamage = GetDamageByDamageBonus(GetEffectInteger(eEffect, 0)); //DamageBonus
			
			switch (GetEffectInteger(eEffect, 1))  //DamageType
			{
				case DAMAGE_TYPE_ACID:
					nAcid += nDamage;
					break;
					
				case DAMAGE_TYPE_BLUDGEONING:
					nBlunt += nDamage;
					break;
					
				case DAMAGE_TYPE_COLD:
					nCold += nDamage;
					break;
					
				case DAMAGE_TYPE_DIVINE:
					nDivine += nDamage;
					break;	
					
				case DAMAGE_TYPE_ELECTRICAL:
					nElec += nDamage;
					break;
					
				case DAMAGE_TYPE_FIRE:
					nFire += nDamage;
					break;
					
				case DAMAGE_TYPE_MAGICAL:
					nMagic += nDamage;
					break;
					
				case DAMAGE_TYPE_NEGATIVE:
					nNegat += nDamage;
					break;	
					
				case DAMAGE_TYPE_PIERCING:
					nPierce += nDamage;
					break;
					
				case DAMAGE_TYPE_POSITIVE:
					nPosit += nDamage;
					break;
					
				case DAMAGE_TYPE_SLASHING:
					nSlash += nDamage;
					break;
					
				case DAMAGE_TYPE_SONIC:
					nSonic += nDamage;
					break;																									
					
			}
														
		}
		eEffect = GetNextEffect(oPC);
	}	
		
	int nEnhance = 0;	
	itemproperty iProp = GetFirstItemProperty(oWeapon);
	while (GetIsItemPropertyValid(iProp))
	{

		if (GetItemPropertyType(iProp)==ITEM_PROPERTY_DAMAGE_BONUS)
		{
		  	GetItemPropertyCostTableValue(iProp); //IP_CONST_DAMAGEBONUS
			GetItemPropertySubType(iProp); //IP_CONST_DAMAGETYPE
			
			int nDamage = GetDamageByIPConstDamageBonus(GetItemPropertyCostTableValue(iProp));
			
			switch (GetItemPropertySubType(iProp))  //DamageType
			{
				case IP_CONST_DAMAGETYPE_ACID:
					nAcid += nDamage;
					break;
					
				case IP_CONST_DAMAGETYPE_BLUDGEONING:
					nBlunt += nDamage;
					break;
					
				case IP_CONST_DAMAGETYPE_COLD:
					nCold += nDamage;
					break;
					
				case IP_CONST_DAMAGETYPE_DIVINE:
					nDivine += nDamage;
					break;	
					
				case IP_CONST_DAMAGETYPE_ELECTRICAL:
					nElec += nDamage;
					break;
					
				case IP_CONST_DAMAGETYPE_FIRE:
					nFire += nDamage;
					break;
					
				case IP_CONST_DAMAGETYPE_MAGICAL:
					nMagic += nDamage;
					break;
					
				case IP_CONST_DAMAGETYPE_NEGATIVE:
					nNegat += nDamage;
					break;	
					
				case IP_CONST_DAMAGETYPE_PHYSICAL:
					nSlash += nDamage;
					break;
					
				case IP_CONST_DAMAGETYPE_PIERCING:
					nPierce += nDamage;
					break;
					
				case IP_CONST_DAMAGETYPE_POSITIVE:
					nPosit += nDamage;
					break;
					
				case IP_CONST_DAMAGETYPE_SLASHING:
					nSlash += nDamage;
					break;		
					
				case IP_CONST_DAMAGETYPE_SONIC:
					nSonic += nDamage;
					break;																														
			}			
			
		}		
		else
		if (GetItemPropertyType(iProp)==ITEM_PROPERTY_ENHANCEMENT_BONUS)
		{
		  	int nItemEnhance = GetItemPropertyCostTableValue(iProp); //Enhance bonus
			if (nItemEnhance > nEnhance)
				nEnhance = nItemEnhance;
		}			
		iProp=GetNextItemProperty(oWeapon);
	}

	if (nWeaponType == WEAPON_TYPE_SLASHING || nWeaponType == WEAPON_TYPE_PIERCING_AND_SLASHING)
		nSlash += nEnhance;
	else
	if (nWeaponType == WEAPON_TYPE_PIERCING)
		nPierce += nEnhance;
	else
	if (nWeaponType == WEAPON_TYPE_BLUDGEONING)
		nBlunt += nEnhance;	
		
	if ( nIsRanged )
	{
		int nBaseType = GetBaseItemType(oWeapon);
		object oAmmo;
		if (nBaseType == BASE_ITEM_LIGHTCROSSBOW || nBaseType == BASE_ITEM_HEAVYCROSSBOW)
			oAmmo = GetItemInSlot(INVENTORY_SLOT_BOLTS);
		if (nBaseType == BASE_ITEM_LONGBOW || nBaseType == BASE_ITEM_SHORTBOW)
			oAmmo = GetItemInSlot(INVENTORY_SLOT_ARROWS);
		if (nBaseType == BASE_ITEM_SLING)
			oAmmo = GetItemInSlot(INVENTORY_SLOT_BULLETS);						
		
		int nEnhance = 0;	
		itemproperty iProp = GetFirstItemProperty(oAmmo);
		while (GetIsItemPropertyValid(iProp))
		{
	
			if (GetItemPropertyType(iProp)==ITEM_PROPERTY_DAMAGE_BONUS)
			{
			  	GetItemPropertyCostTableValue(iProp); //IP_CONST_DAMAGEBONUS
				GetItemPropertySubType(iProp); //IP_CONST_DAMAGETYPE
				
				int nDamage = GetDamageByIPConstDamageBonus(GetItemPropertyCostTableValue(iProp));
				
				switch (GetItemPropertySubType(iProp))  //DamageType
				{
					case IP_CONST_DAMAGETYPE_ACID:
						nAcid += nDamage;
						break;
						
					case IP_CONST_DAMAGETYPE_BLUDGEONING:
						nBlunt += nDamage;
						break;
						
					case IP_CONST_DAMAGETYPE_COLD:
						nCold += nDamage;
						break;
						
					case IP_CONST_DAMAGETYPE_DIVINE:
						nDivine += nDamage;
						break;	
						
					case IP_CONST_DAMAGETYPE_ELECTRICAL:
						nElec += nDamage;
						break;
						
					case IP_CONST_DAMAGETYPE_FIRE:
						nFire += nDamage;
						break;
						
					case IP_CONST_DAMAGETYPE_MAGICAL:
						nMagic += nDamage;
						break;
						
					case IP_CONST_DAMAGETYPE_NEGATIVE:
						nNegat += nDamage;
						break;	
						
					case IP_CONST_DAMAGETYPE_PHYSICAL:
						nSlash += nDamage;
						break;
						
					case IP_CONST_DAMAGETYPE_PIERCING:
						nPierce += nDamage;
						break;
						
					case IP_CONST_DAMAGETYPE_POSITIVE:
						nPosit += nDamage;
						break;
						
					case IP_CONST_DAMAGETYPE_SLASHING:
						nSlash += nDamage;
						break;		
						
					case IP_CONST_DAMAGETYPE_SONIC:
						nSonic += nDamage;
						break;																														
				}			
				
			}		
			else
			if (GetItemPropertyType(iProp)==ITEM_PROPERTY_ENHANCEMENT_BONUS)
			{
			  	int nItemEnhance = GetItemPropertyCostTableValue(iProp); //Enhance bonus
				if (nItemEnhance > nEnhance)
					nEnhance = nItemEnhance;
			}			
			iProp=GetNextItemProperty(oAmmo);
		}
	
		if (nWeaponType == WEAPON_TYPE_SLASHING || nWeaponType == WEAPON_TYPE_PIERCING_AND_SLASHING)
			nSlash += nEnhance;
		else
		if (nWeaponType == WEAPON_TYPE_PIERCING)
			nPierce += nEnhance;
		else
		if (nWeaponType == WEAPON_TYPE_BLUDGEONING)
			nBlunt += nEnhance;	
	
	
	}
	
	//SendMessageToPC(oPC, "nWeaponType: " + IntToString(nWeaponType));
	//SendMessageToPC(oPC, "nPierce: " + IntToString(nPierce));
				
	//Time to build a mega damage event	
	effect eLink = EffectDamage(nPierce, DAMAGE_TYPE_PIERCING);
	
	//= EffectVisualEffect(VFX_HIT_SPELL_SONIC);
	
	if (nAcid > 0)
	{
		effect eDmg = EffectDamage(nAcid, DAMAGE_TYPE_ACID);
		eLink = EffectLinkEffects(eDmg, eLink);
	}
	
	if (nSlash > 0)
	{
		effect eDmg = EffectDamage(nSlash, DAMAGE_TYPE_SLASHING);
		eLink = EffectLinkEffects(eDmg, eLink);
	}
	
	if (nBlunt > 0)
	{
		effect eDmg = EffectDamage(nBlunt, DAMAGE_TYPE_BLUDGEONING);
		eLink = EffectLinkEffects(eDmg, eLink);
	}
	
	if (nCold > 0)
	{
		effect eDmg = EffectDamage(nCold, DAMAGE_TYPE_COLD);
		eLink = EffectLinkEffects(eDmg, eLink);
	}			
	
	if (nElec > 0)
	{
		effect eDmg = EffectDamage(nElec, DAMAGE_TYPE_ELECTRICAL);
		eLink = EffectLinkEffects(eDmg, eLink);
	}
	
	if (nFire > 0)
	{
		effect eDmg = EffectDamage(nFire, DAMAGE_TYPE_FIRE);
		eLink = EffectLinkEffects(eDmg, eLink);
	}
	
	if (nSonic > 0)
	{
		effect eDmg = EffectDamage(nSonic, DAMAGE_TYPE_SONIC);
		eLink = EffectLinkEffects(eDmg, eLink);
	}		
	
	if (nDivine > 0)
	{
		effect eDmg = EffectDamage(nDivine, DAMAGE_TYPE_DIVINE);
		eLink = EffectLinkEffects(eDmg, eLink);
	}			
	
	if (nMagic > 0)
	{
		effect eDmg = EffectDamage(nMagic, DAMAGE_TYPE_MAGICAL);
		eLink = EffectLinkEffects(eDmg, eLink);
	}
	
	if (nPosit > 0)
	{
		effect eDmg = EffectDamage(nPosit, DAMAGE_TYPE_POSITIVE);
		eLink = EffectLinkEffects(eDmg, eLink);
	}
	
	if (nNegat > 0)
	{
		effect eDmg = EffectDamage(nNegat, DAMAGE_TYPE_NEGATIVE);
		eLink = EffectLinkEffects(eDmg, eLink);
	}	
	
	return eLink;	

}
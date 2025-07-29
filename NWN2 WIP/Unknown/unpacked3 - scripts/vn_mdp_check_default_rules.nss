//------------------------------------------------------------------------------
//  C Daniel Vale 2005
//  djvale@gmail.com
//
//  C Laurie Vale 2005
//  charlievale@gmail.com
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
//------------------------------------------------------------------------------
// Script Name: vn_mdp_check_default_rules
// Description: Item restrictions rules - default to NWN2. 
//
// DO NOT MODIFY
// Restrictions based on Item Type are necessary for the correct
// function of the modifier and GUI. For example you can't put mighty on a longsword
// and Unique Power self only isn't listed as an available spell.
// These will always be checked by "vn_mdp_check_allow"
//
// To restrict which properties are available in your module make changes to the 
// script "vn_mdp_check_custom_rules" only. 
//------------------------------------------------------------------------------
#include "vn_mdp__inc"
// can't have magic/enchanted or blank wands able to be crafted on by this system
// as only a few spells can go on them - to make all cast spells available they have to
// be put on misc items
int GetIsItemCraftable (int nType)
{
	switch (nType)
	{
		case BASE_ITEM_ALLUSE_SWORD: return FALSE;
		case BASE_ITEM_BLANK_POTION: return FALSE;
		case BASE_ITEM_BLANK_SCROLL: return FALSE;
		case BASE_ITEM_BLANK_WAND: return FALSE;
		case BASE_ITEM_CBLUDGWEAPON: return FALSE;
		case BASE_ITEM_CGIANT_AXE: return FALSE;
		case BASE_ITEM_CGIANT_SWORD: return FALSE;
		case BASE_ITEM_CPIERCWEAPON: return FALSE;
		case BASE_ITEM_CRAFTMATERIALMED: return FALSE;
		case BASE_ITEM_CRAFTMATERIALSML: return FALSE;
		case BASE_ITEM_CREATUREITEM: return FALSE;
		case BASE_ITEM_CSLASHWEAPON: return FALSE;
		case BASE_ITEM_CSLSHPRCWEAP: return FALSE;
		case BASE_ITEM_ENCHANTED_POTION: return FALSE;
		case BASE_ITEM_ENCHANTED_SCROLL: return FALSE;
		case BASE_ITEM_ENCHANTED_WAND: return FALSE;		
		case BASE_ITEM_GOLD: return FALSE;
		case BASE_ITEM_GRENADE: return FALSE;
		case BASE_ITEM_HEALERSKIT: return FALSE;
		case BASE_ITEM_INVALID: return FALSE;
		case BASE_ITEM_KEY: return FALSE;
		case BASE_ITEM_LARGEBOX: return FALSE;
		case BASE_ITEM_MAGICWAND: return FALSE;		
		case BASE_ITEM_POTIONS: return FALSE;
		case BASE_ITEM_SCROLL: return FALSE;
		case BASE_ITEM_SPELLSCROLL: return FALSE;
		case BASE_ITEM_THIEVESTOOLS: return FALSE;
		case BASE_ITEM_TRAPKIT: return FALSE;
		case BASE_ITEM_TORCH: FALSE;
		case BASE_ITEM_TRAINING_CLUB: FALSE;
		case BASE_ITEM_GEM: return FALSE;
	}
    return TRUE;

}

int GetIsWeapon (int nType)
{
	switch(nType)
	{
	    case BASE_ITEM_BASTARDSWORD: return TRUE;
		case BASE_ITEM_BATTLEAXE: return TRUE;
		case BASE_ITEM_CLUB: return TRUE;
		case BASE_ITEM_DAGGER: return TRUE;
		case BASE_ITEM_DART: return TRUE;
		case BASE_ITEM_DIREMACE: return TRUE;
		case BASE_ITEM_DOUBLEAXE: return TRUE;
		case BASE_ITEM_DWARVENWARAXE: return TRUE;
		case BASE_ITEM_FALCHION: return TRUE;
		case BASE_ITEM_FLAIL: return TRUE;
		case BASE_ITEM_GLOVES: return TRUE;
		case BASE_ITEM_GREATAXE: return TRUE;
		case BASE_ITEM_GREATSWORD: return TRUE;
		case BASE_ITEM_HALBERD: return TRUE;
		case BASE_ITEM_HANDAXE: return TRUE;
		case BASE_ITEM_HEAVYCROSSBOW: return TRUE;
		case BASE_ITEM_HEAVYFLAIL: return TRUE;
		case BASE_ITEM_KAMA: return TRUE;
		case BASE_ITEM_KATANA: return TRUE;
		case BASE_ITEM_KUKRI: return TRUE;
		case BASE_ITEM_LIGHTCROSSBOW: return TRUE;
		case BASE_ITEM_LIGHTFLAIL: return TRUE;
		case BASE_ITEM_LIGHTHAMMER: return TRUE;
		case BASE_ITEM_LIGHTMACE: return TRUE;
		case BASE_ITEM_LONGBOW: return TRUE;
		case BASE_ITEM_LONGSWORD: return TRUE;
		case BASE_ITEM_MACE: return TRUE;
		case BASE_ITEM_MAGICSTAFF: return TRUE;
		case BASE_ITEM_MORNINGSTAR: return TRUE;
		case BASE_ITEM_QUARTERSTAFF: return TRUE;
		case BASE_ITEM_RAPIER: return TRUE;
		case BASE_ITEM_SCIMITAR: return TRUE;
		case BASE_ITEM_SCYTHE: return TRUE;
		case BASE_ITEM_SHORTBOW: return TRUE;
		case BASE_ITEM_SHORTSPEAR: return TRUE;
		case BASE_ITEM_SHORTSWORD: return TRUE;
		case BASE_ITEM_SHURIKEN: return TRUE;
		case BASE_ITEM_SICKLE: return TRUE;
		case BASE_ITEM_SLING: return TRUE;
		case BASE_ITEM_SPEAR: return TRUE;
		case BASE_ITEM_THROWINGAXE: return TRUE;
		case BASE_ITEM_TWOBLADEDSWORD: return TRUE;
		case BASE_ITEM_WARHAMMER: return TRUE;
		case BASE_ITEM_WARMACE: return TRUE;
		case BASE_ITEM_WHIP: return TRUE;
	}
	return FALSE;
}

int GetIsMeleeWeapon(int nType)
{
    switch(nType)
    {
        case BASE_ITEM_BASTARDSWORD: return TRUE;
	 	case BASE_ITEM_BATTLEAXE: return TRUE;
	 	case BASE_ITEM_CLUB: return TRUE;
	 	case BASE_ITEM_DAGGER: return TRUE;
 		case BASE_ITEM_DIREMACE: return TRUE;
 		case BASE_ITEM_DOUBLEAXE: return TRUE;
 		case BASE_ITEM_DWARVENWARAXE: return TRUE;
 		case BASE_ITEM_FALCHION: return TRUE;
 		case BASE_ITEM_FLAIL: return TRUE;
		case BASE_ITEM_GLOVES: return TRUE;
 		case BASE_ITEM_GREATAXE: return TRUE;
 		case BASE_ITEM_GREATSWORD: return TRUE;
 		case BASE_ITEM_HALBERD: return TRUE;
 		case BASE_ITEM_HANDAXE: return TRUE;
 		case BASE_ITEM_HEAVYFLAIL: return TRUE;
 		case BASE_ITEM_KAMA: return TRUE;
 		case BASE_ITEM_KATANA: return TRUE;
 		case BASE_ITEM_KUKRI: return TRUE;
 		case BASE_ITEM_LIGHTFLAIL: return TRUE;
 		case BASE_ITEM_LIGHTHAMMER: return TRUE;
 		case BASE_ITEM_LIGHTMACE: return TRUE;
 		case BASE_ITEM_LONGSWORD: return TRUE;
 		case BASE_ITEM_MACE: return TRUE;
 		case BASE_ITEM_MAGICSTAFF: return TRUE;
 		case BASE_ITEM_MORNINGSTAR: return TRUE;
 		case BASE_ITEM_QUARTERSTAFF: return TRUE;
 		case BASE_ITEM_RAPIER: return TRUE;
 		case BASE_ITEM_SCIMITAR: return TRUE;
 		case BASE_ITEM_SCYTHE: return TRUE;
 		case BASE_ITEM_SHORTSPEAR: return TRUE;
 		case BASE_ITEM_SHORTSWORD: return TRUE;
 		case BASE_ITEM_SICKLE: return TRUE;
 		case BASE_ITEM_SPEAR: return TRUE;
 		case BASE_ITEM_TWOBLADEDSWORD: return TRUE;
 		case BASE_ITEM_WARHAMMER: return TRUE;
 		case BASE_ITEM_WARMACE: return TRUE;
 		case BASE_ITEM_WHIP: return TRUE;
    }
	return FALSE;	
}

int GetIsThrownWeapon(int nType)
{
	switch (nType)
	{
		case BASE_ITEM_DART: return TRUE;
		case BASE_ITEM_SHURIKEN: return TRUE;
		case BASE_ITEM_THROWINGAXE: return TRUE;	
	}
	return FALSE;
}

int GetIsProjectileWeapon(int nType)
	// this is for mighty, unlimited ammo etc
{
    switch (nType)
    {
        case BASE_ITEM_HEAVYCROSSBOW: return TRUE;
		case BASE_ITEM_LIGHTCROSSBOW: return TRUE;
		case BASE_ITEM_LONGBOW: return TRUE;
		case BASE_ITEM_SHORTBOW: return TRUE;
		case BASE_ITEM_SLING: return TRUE;
    }
	return FALSE;
}	

int GetIsAmmunition(int nType)
{
	switch (nType)
	{
		case BASE_ITEM_ARROW: return TRUE;
		case BASE_ITEM_BOLT: return TRUE;	
		case BASE_ITEM_BULLET: return TRUE;	
	}
	return FALSE;
}
int GetIsWearable(int nType) 
// For AC and the like  so shields are included
{
	switch(nType)
	{
        case BASE_ITEM_AMULET: return TRUE;
		case BASE_ITEM_ARMOR: return TRUE;
		case BASE_ITEM_BELT: return TRUE;
		case BASE_ITEM_BOOTS: return TRUE;
		case BASE_ITEM_BRACER: return TRUE;
		case BASE_ITEM_CLOAK: return TRUE;
		case BASE_ITEM_GLOVES: return TRUE;
		case BASE_ITEM_HELMET: return TRUE;
		case BASE_ITEM_LARGESHIELD: return TRUE;
		case BASE_ITEM_RING: return TRUE;
		case BASE_ITEM_SMALLSHIELD: return TRUE;
		case BASE_ITEM_TOWERSHIELD: return TRUE;
	}
	return FALSE;
}

int GetIsArmor(int nType) 
// For arcane spell failure
{
	switch(nType)
	{
		case BASE_ITEM_ARMOR: return TRUE;
		case BASE_ITEM_LARGESHIELD: return TRUE;
		case BASE_ITEM_SMALLSHIELD: return TRUE;
		case BASE_ITEM_TOWERSHIELD: return TRUE;
	}
	return FALSE;
}

int GetIsItemOther(int nType)
// Some miscellaneous items can have cast spell on them, but nothing else
// as they can't be "equiped"
{
	switch(nType)
	{
		case BASE_ITEM_DRUM: return TRUE;
		case BASE_ITEM_FLUTE: return TRUE;
		case BASE_ITEM_MAGICROD: return TRUE;
		case BASE_ITEM_MANDOLIN: return TRUE;
		case BASE_ITEM_MISCLARGE: return TRUE;
		case BASE_ITEM_MISCMEDIUM: return TRUE;
		case BASE_ITEM_MISCSMALL: return TRUE;
		case BASE_ITEM_MISCTALL: return TRUE;
		case BASE_ITEM_MISCTHIN: return TRUE;
		case BASE_ITEM_MISCWIDE: return TRUE;
		case BASE_ITEM_BOOK: return TRUE;
	}
	return FALSE;
}

int GetIsSpellCastingClass(int nIndex)
{
	// only return true on classes that can have bonus spell slots
	switch (nIndex)
	{
		case CLASS_TYPE_BARD: return TRUE;
		case CLASS_TYPE_CLERIC: return TRUE;
		case CLASS_TYPE_DRUID: return TRUE;
		case CLASS_TYPE_PALADIN: return TRUE;
		case CLASS_TYPE_RANGER: return TRUE;
		case CLASS_TYPE_SORCERER: return TRUE;
		case CLASS_TYPE_WIZARD: return TRUE;
		case CLASS_TYPE_WARLOCK: return TRUE;
	}
	return FALSE;
}


// this function only determines whether the item type can have that property applied
// DO NOT CHANGE as this is decided purely on what the base game allows
// the ONLY exception is the negative modifiers
// we have decided not to implement negative or "cursed" items within the treasure system
// and feel it highly unlikely any one with willinly curse their item with the crafter.
int mdpGetModificationTypeValid(int nType, string s2DA, int nIndex)
{
	if (s2DA == "itempropdef")
	{
       	// Ammunition and Thrown weapons checked first as they have few properties
		// that can be added to them.
		
		if (GetIsAmmunition(nType) || GetIsThrownWeapon(nType))
		{
			if (nIndex == IP_CONST_DAMAGE_BONUS ||
				nIndex == IP_CONST_VAMPIRIC_REGENERATION ||
				nIndex == IP_CONST_ON_HIT
				)
				return TRUE;
			else 
				return FALSE;	
		}
		if (GetIsThrownWeapon(nType))
		{
			if (nIndex == IP_CONST_ATTACK_BONUS ||
				nIndex == IP_CONST_MASSIVE_CRITICAL
				)  
				return TRUE;
			else 
				return FALSE;	
		}
				
       	//Misc other items i.e. gems are checked here as they can only have cast spell
		// added to them as they aren't equiped.		
		if (GetIsItemOther(nType))
		{
			if (nIndex == IP_CONST_CAST_SPELL)
				return TRUE;
			else
				return FALSE;
		}	
		switch(nIndex)
        {
			case IP_CONST_ABILITY_BONUS: 
				return TRUE;

			case IP_CONST_AC_V_ALIGN:
			case IP_CONST_AC_V_DAMAGE:
			case IP_CONST_AC_V_RACE: 
			case IP_CONST_AC_V_SALIGN:
			case IP_CONST_AC_BONUS: 
				return TRUE;

			case IP_CONST_ARCANE_SPELL_FAILURE: 
				return GetIsArmor(nType);

			case IP_CONST_ATTACK_V_ALIGN: 
			case IP_CONST_ATTACK_V_RACE: 
			case IP_CONST_ATTACK_V_SALIGN:
			case IP_CONST_ATTACK_BONUS:
				return GetIsWeapon (nType);

			case IP_CONST_BONUS_FEAT: 
					return TRUE;

			case IP_CONST_BONUS_HITPOINTS: 
				return TRUE;

			case IP_CONST_BONUS_LEVEL_SPELL: 
					return TRUE;

			case IP_CONST_IMPROVED_SAVING_THROW:
				return TRUE;

			case IP_CONST_IMPROVED_SAVING_THROW_SPECIFIC: 
				return TRUE;

			case IP_CONST_BONUS_SPELL_RESISTANCE: 
				return TRUE;

			case IP_CONST_CAST_SPELL: 
				return TRUE;
				
			case IP_CONST_DAMAGE_V_ALIGN: 
			case IP_CONST_DAMAGE_V_RACE: 
			case IP_CONST_DAMAGE_V_SALIGN:
			case IP_CONST_DAMAGE_BONUS: 
			// can put damage bonus on melee weapons but not ranged 
			// weapons - already checked for ammun and thrown weapons above
				return GetIsWeapon(nType);
				
			case IP_CONST_DAMAGE_IMMUNITY: 
				return TRUE;
				
			case IP_CONST_DAMAGE_RESISTANCE: 
				return TRUE;
				
			case IP_CONST_DARKVISION: 
				return TRUE;
		// gloves are a melee weapon for damage bonus etc 
		// but can't have enhancement property added				
			case IP_CONST_ENHANCEMENT_V_ALIGN:
			case IP_CONST_ENHANCEMENT_V_RACE: 
			case IP_CONST_ENHANCEMENT_V_SALIGN:
			case IP_CONST_ENHANCEMENT_BONUS: 
				if (nType != BASE_ITEM_GLOVES && GetIsWeapon(nType))
					return TRUE;
				else
					return FALSE;
			case IP_CONST_FREE_ACTION: 
				return TRUE;
				
			case IP_CONST_HASTE: 
				return TRUE;
					
		// gloves are a melee weapon for damage bonus etc 
		// but can't have holy avenger property added
			case IP_CONST_HOLY_AVENGER:
				if (nType != BASE_ITEM_GLOVES && GetIsMeleeWeapon(nType))
					return TRUE;
				else
					return FALSE;	

			case IP_CONST_IMMUNITY_SPELL_LEVEL: 
				return GetIsWearable(nType);
				
			case IP_CONST_IMMUNITY_MISC: 
					return TRUE;
					
			case IP_CONST_IMPROVED_EVASION: 
					return TRUE;
					
			case IP_CONST_VISUAL_EFFECT:
				if (nType != BASE_ITEM_GLOVES && GetIsMeleeWeapon(nType))
					return TRUE;
				else
					return FALSE;
				
					
		// gloves are a melee weapon but CAN'T have keen added
		// adding keen to weapons not normally allowed is now allowed due
		// to weapon of impact
			case IP_CONST_KEEN:
				if (nType != BASE_ITEM_GLOVES && GetIsMeleeWeapon(nType))
					return TRUE;
				else
					return FALSE;
						
			case IP_CONST_LIGHT: 
				return TRUE;
				
		// gloves are a melee weapon for damage bonus etc 
		// but can't have massive criticals property added
			case IP_CONST_MASSIVE_CRITICAL: 
				if (nType != BASE_ITEM_GLOVES && GetIsWeapon (nType))
					return TRUE;
				else
					return FALSE;
					
			case IP_CONST_MIGHTY: 
				return GetIsProjectileWeapon(nType);
				
			case IP_CONST_ON_HIT: 
				return GetIsMeleeWeapon(nType);
						
			case IP_CONST_REGENERATION: 
					return TRUE;
								
			case IP_CONST_SKILL_BONUS:
				 return TRUE;
			
			case IP_CONST_SPELL_IMMUNITY_SCHOOL: 
				return TRUE;
				
			case IP_CONST_SPELL_IMMUNITY_SPECIFIC: 
				return TRUE;
				
			case IP_CONST_TRUE_SEEING: 
				return TRUE;
								
			case IP_CONST_UNLIMITED_AMMO: 
				return GetIsProjectileWeapon(nType);
				
			case IP_CONST_VAMPIRIC_REGENERATION: 
				return ( ( nType != BASE_ITEM_GLOVES ) && GetIsMeleeWeapon(nType) ) ;
					
			case IP_CONST_WEIGHT_REDUCTION: 
				if (GetIsWeapon (nType) || GetIsArmor(nType))
					return TRUE;
				else
					return FALSE;
		}
		// anything else within itempropdef is disallowed
		return FALSE;
	}
	
	// Alignment group none is not valid as a property
	if (s2DA == "iprp_aligngrp" && nIndex == 0)
		return FALSE;
	
	// Skills Animal Empathy (0) and Ride (28) are not valid
	if (s2DA == "skills" && 
		(nIndex == 0 || nIndex == 28))
			return FALSE;
	
	// 0 Charges / Use denied 
	// if module restriction is on then only charges/use will be allowed
	// otherwise all others will be
	
	if (s2DA == "iprp_chargecost")
	{
		if (nIndex == 7)
			return FALSE;
		else
			return TRUE;
	}		
	// "iprp_damagetype" is used for adding damage bonus, resistance
	// immunity.  We have removed "Subdual"(3) "Physical (4) as they don't
	// seem to work and don't have a cost associated with them.  
	// These damage types are removed for resistances etc as well as damage bonus'.
	if (s2DA == "iprp_damagetype")
	{
		if (nIndex == 3 || nIndex == 4)
			return FALSE;
		else
			return TRUE;
	}

	if (s2DA == "classes")
		return GetIsSpellCastingClass(nIndex);
	
	// passed through all restrictions so go ahead
	return TRUE;

}


//void main(){}
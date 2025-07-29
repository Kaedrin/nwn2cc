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
// Script Name: vn_mdp_check_custom_rules
// Description: if MODULE_SWITCH_MDP_CRAFTER_RESTRICTIONS is set to true
// on the module this script will check to see if the crafter in the PC's 
// area can make that particular modification.
// All areas where crafting is available must be listed as an added
// safety precaution - to stop the GUI script being run by PC's
// in non crafting area's
// Other custom rules regarding property restrictions are also found here.
//
// These rules are unique to Fournoi and should only be modified by experienced
// scripters.
//
//------------------------------------------------------------------------------
#include "vn_mdp__inc"


/******************************************************************/
// Item property restrictions unique to Fournoi
/******************************************************************/
// Not allowed to double up on bonuses that cause damage
// i.e. can't have Damage Bonus AND Holy Avenger
// i.e. can't have Keen AND OnHit

int GetDamageBonusAllowed(object oModifyItem)
{
	itemproperty ipDamageBonus = GetFirstItemProperty(oModifyItem);
	while (GetIsItemPropertyValid(ipDamageBonus))
	{
		switch(GetItemPropertyType(ipDamageBonus))
		{
			case ITEM_PROPERTY_HOLY_AVENGER: return FALSE;
            case ITEM_PROPERTY_KEEN: return FALSE;
            case ITEM_PROPERTY_MASSIVE_CRITICALS: return FALSE;
			case ITEM_PROPERTY_ON_HIT_PROPERTIES: return FALSE;
            case ITEM_PROPERTY_REGENERATION_VAMPIRIC: return FALSE;
		}
		ipDamageBonus = GetNextItemProperty(oModifyItem);
	}
	return TRUE; 
}

int GetHolyAvengerAllowed(object oModifyItem)
{
	itemproperty ipHolyAvenger = GetFirstItemProperty(oModifyItem);
	while (GetIsItemPropertyValid(ipHolyAvenger))
	{
		switch(GetItemPropertyType(ipHolyAvenger))
		{
			case ITEM_PROPERTY_DAMAGE_BONUS: return FALSE;
            case ITEM_PROPERTY_KEEN: return FALSE;
            case ITEM_PROPERTY_MASSIVE_CRITICALS: return FALSE;
			case ITEM_PROPERTY_ON_HIT_PROPERTIES: return FALSE;
            case ITEM_PROPERTY_REGENERATION_VAMPIRIC: return FALSE;
		}
		ipHolyAvenger = GetNextItemProperty(oModifyItem);
	}
	return TRUE; 
}

int GetKeenAllowed(object oModifyItem)
{
	itemproperty ipKeen = GetFirstItemProperty(oModifyItem);
	while (GetIsItemPropertyValid(ipKeen))
	{
		switch(GetItemPropertyType(ipKeen))
		{	
			case ITEM_PROPERTY_DAMAGE_BONUS: return FALSE;
            case ITEM_PROPERTY_HOLY_AVENGER: return FALSE;
            case ITEM_PROPERTY_MASSIVE_CRITICALS: return FALSE;
			case ITEM_PROPERTY_ON_HIT_PROPERTIES: return FALSE;
            case ITEM_PROPERTY_REGENERATION_VAMPIRIC: return FALSE;
		}
		ipKeen = GetNextItemProperty(oModifyItem);
	}
	return TRUE; 
}

int GetMassiveCriticalAllowed(object oModifyItem)
{
	itemproperty ipMassiveCritical = GetFirstItemProperty(oModifyItem);
	while (GetIsItemPropertyValid(ipMassiveCritical))
	{
		switch(GetItemPropertyType(ipMassiveCritical))
		{
			case ITEM_PROPERTY_DAMAGE_BONUS: return FALSE;
            case ITEM_PROPERTY_HOLY_AVENGER: return FALSE;
            case ITEM_PROPERTY_KEEN: return FALSE;
			case ITEM_PROPERTY_ON_HIT_PROPERTIES: return FALSE;
            case ITEM_PROPERTY_REGENERATION_VAMPIRIC: return FALSE;
		}
		ipMassiveCritical = GetNextItemProperty(oModifyItem);
	}
	return TRUE; 
}

int GetOnHitAllowed(object oModifyItem)
{
	itemproperty ipOnHit = GetFirstItemProperty(oModifyItem);
	while (GetIsItemPropertyValid(ipOnHit))
	{
		switch(GetItemPropertyType(ipOnHit))
		{	
			case ITEM_PROPERTY_DAMAGE_BONUS: return FALSE;
            case ITEM_PROPERTY_HOLY_AVENGER: return FALSE;
            case ITEM_PROPERTY_KEEN: return FALSE;
			case ITEM_PROPERTY_MASSIVE_CRITICALS: return FALSE;
            case ITEM_PROPERTY_REGENERATION_VAMPIRIC: return FALSE;
		}
		ipOnHit = GetNextItemProperty(oModifyItem);
	}
	return TRUE; 
}

int GetVampiricRegenerationAllowed(object oModifyItem)
{
	itemproperty ipVampRegen = GetFirstItemProperty(oModifyItem);
	while (GetIsItemPropertyValid(ipVampRegen))
	{
		switch(GetItemPropertyType(ipVampRegen))
		{	
			case ITEM_PROPERTY_DAMAGE_BONUS: return FALSE;
            case ITEM_PROPERTY_HOLY_AVENGER: return FALSE;
            case ITEM_PROPERTY_KEEN: return FALSE;
			case ITEM_PROPERTY_MASSIVE_CRITICALS: return FALSE;
            case ITEM_PROPERTY_ON_HIT_PROPERTIES: return FALSE;
		}
		ipVampRegen = GetNextItemProperty(oModifyItem);
	}
	return TRUE; 
}

int GetDamageBonusTypeAllowed(object oModifyItem, int nIndex)
// if the weapon already has a damage bonus, you can only put change the
// existing bonus. If there is no damage bonus on the weapon any type
// of damage bonus can be put on it.
{
	
	itemproperty ipDamageBonus = GetFirstItemProperty(oModifyItem);
	while (GetIsItemPropertyValid(ipDamageBonus))
	{
		if (GetItemPropertyType(ipDamageBonus) == ITEM_PROPERTY_DAMAGE_BONUS)
        {    
			int nHasDamageType = GetItemPropertySubType(ipDamageBonus);
			if (nIndex == nHasDamageType)
				return TRUE;
			else
				return FALSE;
		}
	ipDamageBonus = GetNextItemProperty(oModifyItem);
	}
	return TRUE;

}

int GetOnHitSpellAllowed(object oModifyItem, int nIndex)
// if the weapon already has an on hit spell, you can only change the
// existing stats(eg DC)
{	
	itemproperty ipOnHitSpell = GetFirstItemProperty(oModifyItem);
	while (GetIsItemPropertyValid(ipOnHitSpell))
	{
		if (GetItemPropertyType(ipOnHitSpell) == ITEM_PROPERTY_ON_HIT_PROPERTIES)
        {    
			{
			int nHasSpell = GetItemPropertySubType(ipOnHitSpell);
			if (nIndex == nHasSpell)
				return TRUE;
			else
				return FALSE;
			}
		}
		ipOnHitSpell = GetNextItemProperty(oModifyItem);
	}
	return TRUE;

}

int GetIsHelmAmuletRing(int nType)
// For restriction Regen and spell slots to helm, amulet and ring
{
	switch(nType)
	{
		case BASE_ITEM_AMULET: return TRUE;
		case BASE_ITEM_HELMET: return TRUE;
		case BASE_ITEM_RING: return TRUE;
	}
	return FALSE;
}

int GetIsBuffingSpell(int nIndex)
{
// For restriction of CastSpell to buffing spells only
// index ranges partitioned for optimization
	if (nIndex <= 100) // 0 - 100
	{	
		if (nIndex <= 10)// 0 - 10
		{
			if (nIndex == 1)return TRUE;	/*	Aid	*/
			if (nIndex > 1 && nIndex < 5) return FALSE;
			if (nIndex >= 5 && nIndex <= 7 )return TRUE;
			/* 5 Barkskin	*/
			/* 6 Barkskin	*/
			/* 7 Barkskin	*/
			return FALSE;
		}
		else if (nIndex <= 20) // 11 - 20
		{
			if (nIndex == 11)return TRUE;	/*	Bless	*/
			if (nIndex > 11 && nIndex < 15) return FALSE;
			if (nIndex >= 15 & nIndex <= 17 )return TRUE;
			/* 15 Bulls_Strength	*/
			/* 16 Bulls_Strength	*/
			/* 17 Bulls_Strength	*/
			return FALSE;
		}
		else if (nIndex <= 50) // 21 - 50
		{
			if (nIndex < 25) return FALSE;
			if (nIndex >= 25 && nIndex <= 27 )return TRUE;	
			/* 25 Cats_Grace	*/
			/* 26 Cats_Grace	*/
			/* 27 Cats_Grace	*/
			if (nIndex > 27 && nIndex < 43) return FALSE;
			if (nIndex >= 43 && nIndex <= 45)return TRUE;	
			/* 43 Clairaudience/Clairvoyance	*/
			/* 44 Clairaudience/Clairvoyance	*/
			/* 45 Clairaudience/Clairvoyance	*/
			return FALSE;
		}
		else // <= 51 - 100
		{
			if (nIndex < 77) return FALSE;
			if (nIndex == 77)return TRUE;	/*	Death_Ward	*/
			if (nIndex > 77 && nIndex < 95) return FALSE;
			if (nIndex >= 95 && nIndex <= 98)return TRUE;	
			/* 95 Bears_Endurance	*/
			/* 96 Bears_Endurance	*/
			/* 97 Bears_Endurance	*/
			/* 98 Endure_Elements	*/		
			return FALSE;
		}
	}
	else if (nIndex <= 200) // 101 - 200
	{
		if (nIndex <= 150) // 101 - 150
		{
			if (nIndex < 118) return FALSE;
			if (nIndex == 118)return TRUE;	/*	Freedom_of_Movement	*/
			if (nIndex > 118 && nIndex < 137) return FALSE;
			if (nIndex == 137)return TRUE;	/*	Haste	*/
			if (nIndex == 138)return TRUE;	/*	Haste	*/
			if (nIndex > 138 && nIndex < 149) return FALSE;
			if (nIndex == 149)return TRUE;	/*	Greater_Invisibility	*/
			return FALSE;
		}
		else if (nIndex < 175) // 151 - 174
		{
			if (nIndex == 151)return TRUE;	/*	Invisibility	*/
			if (nIndex > 151 && nIndex < 157) return FALSE;
			if (nIndex == 157)return TRUE;	/*	Lesser_Mind_Blank	*/
			if (nIndex > 157 && nIndex < 162) return FALSE;
			if (nIndex == 162)return TRUE;	/*	Light	*/
			if (nIndex == 163)return TRUE;	/*	Light	*/
			if (nIndex > 163 && nIndex < 167) return FALSE;
			if (nIndex == 167)return TRUE;	/*	Mage_Armor	*/
			return FALSE;
		}
		else // 175 - 200
		{
			if (nIndex >= 175 && nIndex <= 178 )return TRUE;	
			/* 175 Magic_Vestment	*/
			/* 176 Magic_Vestment	*/
			/* 177 Magic_Vestment	*/
			/* 178 Magic_Weapon	*/
			if (nIndex > 178 && nIndex < 188) return FALSE;
			if (nIndex == 188)return TRUE;	/*	Mind_Blank	*/
			if (nIndex > 188 && nIndex < 191) return FALSE;
			if (nIndex >= 192 && nIndex <= 194 )return TRUE;	
			/* 192 Ghostly_Visage	*/
			/* 193 Ghostly_Visage	*/
			/* 194 Ghostly_Visage	*/
			return FALSE;
		}
	}
	else if (nIndex <= 280) // 201 - 280
	{
		if (nIndex <= 220) // 201 - 220
		{
			if (nIndex < 216) return FALSE;
			if (nIndex == 216)return TRUE;	/*	Protection_from_Energy	*/
			if (nIndex == 217)return TRUE;	/*	Protection_from_Energy	*/
			return FALSE;
		}
		else if (nIndex <= 250) // 221 - 250
		{
			if (nIndex < 234) return FALSE;
			if (nIndex >= 234 && nIndex <= 237) return TRUE;
			/* 234 Resist_Energy	*/
			/* 235 Resist_Energy	*/
			/* 236 Resistance	*/
			/* 237 Resistance	*/
			if (nIndex > 237 && nIndex < 240) return FALSE;
			if (nIndex == 240)return TRUE;	/*	Sanctuary	*/
			if (nIndex > 240 && nIndex < 243) return FALSE;
			if (nIndex == 243)return TRUE;	/*	See_Invisibility	*/
			return FALSE;
		}
		else // 251 - 280
		{
			if (nIndex < 255) return FALSE;
			if (nIndex == 255)return TRUE;	/*	Spell_Resistance	*/
			if (nIndex > 255 && nIndex < 260) return FALSE;
			if (nIndex == 260)return TRUE;	/*	Stoneskin	*/
			if (nIndex > 260 && nIndex < 275) return FALSE;
			if (nIndex == 275)return TRUE;	/*	True_Seeing	*/
			if (nIndex > 275 && nIndex < 278) return FALSE;
			if (nIndex == 278)return TRUE;	/*	Virtue	*/
			return FALSE;
		}
	}
	else if (nIndex <= 350) // 281 - 350
	{
		if (nIndex < 284) return FALSE;
		if (nIndex == 284)return TRUE;	/*	Protection_from_Alignment	*/
		if (nIndex == 285)return TRUE;	/*	Protection_from_Alignment	*/
		if (nIndex == 286) return FALSE;
		if (nIndex >= 287 && nIndex <= 303) return TRUE;
		/* 287 Aura_versus_Alignment	*/
		/* 288 Eagle_Spledor	*/
		/* 289 Eagle_Spledor	*/
		/* 290 Eagle_Spledor	*/
		/* 291 Owls_Wisdom	*/
		/* 292 Owls_Wisdom	*/
		/* 293 Owls_Wisdom	*/
		/* 294 Foxs_Cunning	*/
		/* 295 Foxs_Cunning	*/
		/* 296 Foxs_Cunning	*/
		/* 297 Greater_Eagles_Splendor	*/
		/* 298 Greater_Owls_Wisdom	*/
		/* 299 Greater_Foxs_Cunning	*/
		/* 300 Greater_Bulls_Strength	*/
		/* 301 Greater_Cats_Grace	*/
		/* 302 Greater_Endurance	*/
		/* 303 Awaken	*/
		if (nIndex > 303 && nIndex < 321) return FALSE;
		if (nIndex == 321)return TRUE;	/*	Aura_of_Vitality	*/
		if (nIndex == 322) return FALSE;
		if (nIndex == 323)return TRUE;	/*	Regenerate	*/	
		return FALSE;	
	}
	else if (nIndex <= 470) // 351 - 400
	{
		if (nIndex <= 375)
		{
			if (nIndex < 352) return FALSE;
			if (nIndex == 352)return TRUE;	/*	Camouflage	*/
			if (nIndex > 352 && nIndex < 360) return FALSE;
			if (nIndex == 360)return TRUE;	/*	Aura_of_Glory	*/
			if (nIndex > 360 && nIndex < 369) return FALSE;
			if (nIndex == 369)return TRUE;	/*	Owls_Insight	*/
			if (nIndex > 369 && nIndex < 373) return FALSE;
			if (nIndex == 373)return TRUE;	/*	Amplify	*/
			return FALSE;
		}
		else 
		{
			if (nIndex < 381) return FALSE;
			if (nIndex == 381)return TRUE;	/*	Shield_of_Faith	*/
			if (nIndex == 382) return FALSE;
			if (nIndex == 383)return TRUE;	/*	Magic_Fang	*/
			if (nIndex == 384)return TRUE;	/*	Greater_Magic_Fang	*/
			if (nIndex == 385) return FALSE;
			if (nIndex == 386)return TRUE;	/*	Mass_Camouflage	*/
			if (nIndex == 387)return TRUE;	/*	Expeditious_Retreat	*/
			if (nIndex == 388) return FALSE;
			if (nIndex == 389)return TRUE;	/*	Displacement	*/
			return FALSE;
		}
		
	}
	else if (nIndex <= 500) // 401 - 500
	{
		if (nIndex < 424) return FALSE;
		if (nIndex == 424)return TRUE;	/*	Spellstaff	*/
		if (nIndex > 424 && nIndex < 472) return FALSE;
		if (nIndex == 472)return TRUE;	/*	Bless_Weapon	*/
		if (nIndex == 473) return FALSE;
		if (nIndex == 474)return TRUE;	/*	Keen_Edge	*/
		if (nIndex == 475 || nIndex == 476) return FALSE;
		if (nIndex == 477)return TRUE;	/*	Flame_Weapon	*/
		if (nIndex == 478) return FALSE;
		if (nIndex == 479)return TRUE;	/*	Magic_Weapon	*/
		if (nIndex == 480)return TRUE;	/*	Greater_Magic_Weapon	*/
		return FALSE;
	}
	else if (nIndex <= 600) // 501 - 600
	{
		if (nIndex <= 520) // 501 - 520
		{
			if (nIndex < 503)return FALSE;
			if (nIndex == 503)return TRUE;	/*	Jagged_Tooth	*/
			if (nIndex > 503 && nIndex < 511) return FALSE;
			if (nIndex == 511)return TRUE;	/*	Greater_Magic_Weapon	*/
			if (nIndex == 512)return TRUE;	/*	Greater_Magic_Weapon	*/
			if (nIndex == 513)return FALSE;
			if (nIndex >= 514 && nIndex <= 517) return TRUE;
			/* 514 Flame_Weapon	*/
			/* 515 Flame_Weapon	*/
			/* 516 Bless_Weapon	*/
			/* 517 Bless_Weapon	*/
			if (nIndex == 518)return FALSE;
			if (nIndex == 519)return TRUE;	/*	Keen_Edge	*/
			if (nIndex == 520)return TRUE;	/*	Keen_Edge	*/
			return FALSE;
			
		}
		else if (nIndex <= 550) // 521 - 550
		{
			if (nIndex == 542)return TRUE;	/*	Blindsight	*/
			return FALSE;
		}
		else // 551 - 600
		{
			if (nIndex < 559) return FALSE;
			if (nIndex == 559)return TRUE;	/*	Energy_Immunity	*/
			if (nIndex == 560)return TRUE;	/*	Enlarge_Person	*/
			if (nIndex > 560 && nIndex < 572) return FALSE;
			if (nIndex >= 572 && nIndex <= 575)return TRUE;	
			/* 572 Heroism	*/
			/* 573 Greater_Heroism	*/
			/* 574 Greater_Heroism	*/
			/* 575 Greater_Heroism	*/
			if (nIndex > 575 && nIndex < 593) return FALSE;
			if (nIndex >= 593 && nIndex <= 595)return TRUE;	
			/* 593 Improved_Mage_Armor	*/
			/* 594 Improved_Mage_Armor	*/
			/* 595 Improved_Mage_Armor	*/
			return FALSE;
		}
	}
	else
	{
		if (nIndex <= 620)// 601 - 620
		{
			if (nIndex >= 601 && nIndex <= 603)return TRUE;	
			/* 601 Protection_From_Arrows	*/
			/* 602 Protection_From_Arrows	*/
			/* 603 Protection_From_Arrows	*/
			if (nIndex > 603 && nIndex < 613) return FALSE;
			if (nIndex >= 613 && nIndex <= 615)return TRUE;	
			/* 613 Shield_Other	*/
			/* 614 Shield_Other	*/
			/* 615 Shield_Other	*/
			return FALSE;
		}
		else if (nIndex <= 650) // 621 - 650
		{
			if (nIndex < 625) return FALSE;
			if (nIndex >= 625 && nIndex <= 627 )return TRUE;	
			/* 625 Spiderskin	*/
			/* 626 Spiderskin	*/
			/* 627 Spiderskin	*/
			if (nIndex > 627 && nIndex < 634) return FALSE;
			if (nIndex >= 634 && nIndex <= 636)return TRUE;	
			/* 634 Weapon_of_Impact	*/
			/* 635 Weapon_of_Impact	*/
			/* 636 Weapon_of_Impact	*/
			if (nIndex == 637 || nIndex == 638) return FALSE;
			if (nIndex == 639)return TRUE;	/*	Flee_the_Scene	*/
			if (nIndex > 639 && nIndex < 646) return FALSE;
			if (nIndex == 646)return TRUE;	/*	Mass_Bear_Endurance	*/
			if (nIndex == 647) return FALSE;
			if (nIndex == 648)return TRUE;	/*	Mass_Bull_Strength	*/
			return FALSE;
		}
		else // 651 +
		{
			if (nIndex < 652) return FALSE;
			if (nIndex == 652)return TRUE;	/*	Mass_Cat_Grace	*/
			if (nIndex > 652 && nIndex < 655) return FALSE;
			if (nIndex == 655)return TRUE;	/*	Greater_Creeping_Cold	*/
			if (nIndex == 656) return FALSE;
			if (nIndex == 657)return TRUE;	/*	Mass_Death_Ward	*/
			if (nIndex == 658) return FALSE;
			if (nIndex == 659)return TRUE;	/*	Mass_Eagle_Splendor	*/
			if (nIndex == 660)return TRUE;	/*	Mass_Fox_Cunning	*/
			if (nIndex > 660 && nIndex < 664) return FALSE;
			if (nIndex == 664)return TRUE;	/*	Mass_Owl_Wisdom	*/
			if (nIndex > 664 && nIndex < 685) return FALSE;
			if (nIndex == 685)return TRUE;	/*	Mass_Aid	*/
			return FALSE;
		}
	}
}

int GetIsFeatAllowed(int nIndex)
{
	if ( nIndex >= 387 && nIndex <= 397)
		return FALSE;
	else
		return TRUE;

			// 387 FEAT_IOUNSTONE_STR
			// 388 FEAT_IOUNSTONE_DEX
			// 389 FEAT_IOUNSTONE_CON
			// 390 FEAT_IOUNSTONE_INT
			// 391 FEAT_IOUNSTONE_WIS
			// 392 FEAT_IOUNSTONE_CHA
			// 393 FEAT_DEATHS_RUIN
			// 394 FEAT_ELEMENTALS_RUIN
			// 395 FEAT_NATURES_RUIN
			// 396 FEAT_SPIRITS_RUIN
			// 397 FEAT_BUILDERS_RUIN
}

// we have already gotten rid of anything not allowed due to games rules
// so we are only returning TRUE or FALSE based on what we want within the module
// and the property strength - this is module wide 
// limitation of properties based on crafter/area is checked last

int mdpGetModificationAllowedInModule(object oPC, object oModifyItem, int nType, string s2DA, int nIndex)
{
	if (s2DA == "itempropdef")
	{
		switch(nIndex)
        {
			case IP_CONST_DAMAGE_V_RACE: 
			case IP_CONST_DAMAGE_BONUS: 
				return GetDamageBonusAllowed(oModifyItem);
			
			case IP_CONST_HOLY_AVENGER:
				return GetHolyAvengerAllowed(oModifyItem);
			
			case IP_CONST_KEEN:
				return GetKeenAllowed(oModifyItem);
			
			case IP_CONST_MASSIVE_CRITICAL: 
				return GetMassiveCriticalAllowed(oModifyItem);
			
			case IP_CONST_REGENERATION: 
				return GetIsHelmAmuletRing(nType);
			
			case IP_CONST_VAMPIRIC_REGENERATION: 
				return GetVampiricRegenerationAllowed(oModifyItem);
	
			case IP_CONST_ABILITY_BONUS: 
			case IP_CONST_AC_V_DAMAGE:
			case IP_CONST_AC_V_RACE: 
			case IP_CONST_AC_BONUS: 
			case IP_CONST_ARCANE_SPELL_FAILURE: 
			case IP_CONST_ATTACK_V_RACE: 
			case IP_CONST_ATTACK_BONUS:
			case IP_CONST_BONUS_FEAT: 
			case IP_CONST_BONUS_HITPOINTS: 
			case IP_CONST_BONUS_LEVEL_SPELL: 
			case IP_CONST_IMPROVED_SAVING_THROW:
			case IP_CONST_IMPROVED_SAVING_THROW_SPECIFIC: 
			case IP_CONST_BONUS_SPELL_RESISTANCE: 
			case IP_CONST_CAST_SPELL: 
			case IP_CONST_DAMAGE_RESISTANCE: 
			case IP_CONST_DARKVISION: 
			case IP_CONST_ENHANCEMENT_V_RACE: 
			case IP_CONST_ENHANCEMENT_BONUS: 
			case IP_CONST_FREE_ACTION: 
			case IP_CONST_HASTE: 
			case IP_CONST_IMMUNITY_SPELL_LEVEL: 
			case IP_CONST_IMMUNITY_MISC: 
			case IP_CONST_IMPROVED_EVASION: 
			case IP_CONST_VISUAL_EFFECT:
			case IP_CONST_LIGHT: 
			case IP_CONST_MIGHTY: 
			case IP_CONST_SKILL_BONUS:
			case IP_CONST_SPELL_IMMUNITY_SCHOOL: 
			case IP_CONST_SPELL_IMMUNITY_SPECIFIC: 
			case IP_CONST_TRUE_SEEING: 
			case IP_CONST_UNLIMITED_AMMO: 
			case IP_CONST_WEIGHT_REDUCTION: 
				return TRUE;
		}
		return FALSE;
	}
	

	if (s2DA == "iprp_damagetype")
	{
		// we restrict putting different types of damage bonus on one item
		// i.e. a flame and acid on one sword. if you want this set you
		// have to put the module restricton on your module.  See script
		// description 
	
		int nPropertyTypeChoosen = GetArrayInt(oPC, "MDP_PropertySelectionIndex", 0); 
		if (nPropertyTypeChoosen == IP_CONST_DAMAGE_BONUS) 
		{
			switch(nIndex)
			{
			case 0: /*Bludgeoning */ 
			case 1: /*Piercing */ 
			case 2: /*Slashing */ 
			case 5: /* Magic */
			case 6: /*Acid */ 
			case 7: /*Cold */ 
				return GetDamageBonusTypeAllowed(oModifyItem, nIndex);
			case 8: /*Divine */ 
				return FALSE;
			case 9: /*Electrical */ 	
			case 10: /* Fire */
				return GetDamageBonusTypeAllowed(oModifyItem, nIndex);
			case 12: /* Positive */ 
				return FALSE;
			case 13: /* Sonic */ 	 
				return GetDamageBonusTypeAllowed(oModifyItem, nIndex);
			}
			return FALSE;
		}
		return TRUE;
	}
	// Only one on hit spell allowed on an item at a time
	if (s2DA == "iprp_onhit")
		return GetOnHitSpellAllowed(oModifyItem, nIndex);		
		
	// only buffing spells allowed
	if (s2DA == "iprp_spells")
	{
		return GetIsBuffingSpell(nIndex);
	}
	// only 1 use or charges permitted in this module
	if (s2DA == "iprp_chargecost")
	{
		if (nIndex >= 1 && nIndex <= 6)
			return TRUE;
		else
			return FALSE;
	}
	// removed some feats
	if (s2DA == "iprp_feats")
	{
		return GetIsFeatAllowed(nIndex);
	}
	// skill bonus tops at 12
	// may be capped with individual crafters via vn_mdp_check_custom_rules

	if (s2DA == "iprp_skillcost")
	{
		if (nIndex != 0 && nIndex <= 12)
			return TRUE;
		else
			return FALSE;
	}
	// enhancement/attack bonus tops at 5
	// may be capped with individual crafters via vn_mdp_check_custom_rules		
	if (s2DA == "iprp_meleecost")
	{	
		if (nIndex != 0 && nIndex <= 5)
			return TRUE;
		else
			return FALSE;
	}	
	// ability bonus tops at 6
	// may be capped with individual crafters via vn_mdp_check_custom_rules			
	if (s2DA == "iprp_bonuscost")
	{	
		if (nIndex != 0 && nIndex <= 6)
			return TRUE;
		else
			return FALSE;
	}	
	// damage bonus 1, 2, 3, 1D4 or 1D6
	// may be capped with individual crafters via vn_mdp_check_custom_rules	
	if (s2DA == "iprp_damagecost")
	{	
		if (nIndex <= 7 && nIndex != 4 && nIndex != 5)
			return TRUE;
		else
			return FALSE;
	}	
	
	// damage immunity restricted to a maximum of 50%
	if (s2DA == "iprp_immuncost")
	{
		switch (nIndex)
		{
		case 1: // 5%
		case 2: // 10%
		case 3: // 25%
		case 4: // 50%
		case 8: // 15%
		case 9: // 20%
		case 10: // 30%
			return TRUE;
		default: 
			return FALSE;
		}
	}
	
	// passed through all restrictions so go ahead
	return TRUE;
		
}

/******************************************************************/
// Area filter list unique to Fournoi
// Only areas in this list will allow crafting
/******************************************************************/
int mdpGetModificationAllowedInArea(object oPC, string sTag, int nType, string s2DA, int nIndex)
{

	// at the moment there is only one area in this module available for crafting and it's tag is set as a constant in in vn_mdp__inc
	// to add your own area's you can set them as extra constants in vn_mdp__inc  or just check the tag directly
	// eg if(sTag == "MyCraftingArea") with "MyCraftingArea being the tag of the area you want to allow crafting in. Multiple areas can be allowed this way
	if (s2DA == "itempropdef")
	{
		switch(nIndex)
		{
			case IP_CONST_ABILITY_BONUS:
			case IP_CONST_AC_V_ALIGN:
			case IP_CONST_AC_V_DAMAGE:
			case IP_CONST_AC_V_RACE: 
			case IP_CONST_AC_V_SALIGN:
			case IP_CONST_AC_BONUS:
			case IP_CONST_ATTACK_V_ALIGN:
			case IP_CONST_ATTACK_V_RACE: 
			case IP_CONST_ATTACK_V_SALIGN:
			case IP_CONST_ATTACK_BONUS:
			case IP_CONST_DAMAGE_V_ALIGN: 
			case IP_CONST_DAMAGE_V_RACE: 
			case IP_CONST_DAMAGE_V_SALIGN:
			case IP_CONST_DAMAGE_BONUS:
			case IP_CONST_DAMAGE_IMMUNITY:
			case IP_CONST_DAMAGE_RESISTANCE:
			case IP_CONST_ENHANCEMENT_V_ALIGN: 
			case IP_CONST_ENHANCEMENT_V_RACE: 
			case IP_CONST_ENHANCEMENT_V_SALIGN: 
			case IP_CONST_ENHANCEMENT_BONUS:
			case IP_CONST_VISUAL_EFFECT:
			case IP_CONST_KEEN:
			case IP_CONST_LIGHT:
			case IP_CONST_MASSIVE_CRITICAL:
			case IP_CONST_MIGHTY:
			case IP_CONST_WEIGHT_REDUCTION:
			{
				if (sTag == CRAFTING_ALLOWED  || sTag  == GUGOTHO_SMITH)
					return TRUE;
				else 
					return FALSE;
			}
			case IP_CONST_ARCANE_SPELL_FAILURE:
			case IP_CONST_BONUS_HITPOINTS: 
			case IP_CONST_BONUS_LEVEL_SPELL: 
			case IP_CONST_IMPROVED_SAVING_THROW: 
			case IP_CONST_IMPROVED_SAVING_THROW_SPECIFIC:
			case IP_CONST_BONUS_SPELL_RESISTANCE: 
			case IP_CONST_CAST_SPELL: 
			case IP_CONST_DARKVISION:
			case IP_CONST_FREE_ACTION:
			case IP_CONST_HOLY_AVENGER:
			case IP_CONST_ON_HIT: 		
			case IP_CONST_REGENERATION:
			case IP_CONST_SKILL_BONUS:
			case IP_CONST_SPELL_IMMUNITY_SPECIFIC:
			case IP_CONST_TRUE_SEEING:
			case IP_CONST_UNLIMITED_AMMO:
			case IP_CONST_VAMPIRIC_REGENERATION:
			case IP_CONST_BONUS_FEAT: 			
			case IP_CONST_HASTE:
			case IP_CONST_IMMUNITY_MISC:
			case IP_CONST_IMMUNITY_SPELL_LEVEL:
			case IP_CONST_IMPROVED_EVASION:
			case IP_CONST_SPELL_IMMUNITY_SCHOOL:
				return FALSE;
			}
			return FALSE;
		}
/************************************************************************************
// can restrict the strength of a modification to a particular area by adding the 
// 2DA here.  For example
// remember that you may have set a maximum strength by disallowing certain indexes in
// mdpGetModificationAllowedInModule
// so this will only allow you to futher split the strength of certain attributes and
// assign them to crafter areas

	if (s2DA == "iprp_skillcost")
	{
		if (nIndex != 0 && nIndex <= 6)
		{
			if (sTag == CRAFTING_ALLOWED)
				return TRUE;
			else
				return FALSE;
		}
		if (nIndex > 12)
		{
			if (sTag == "MyUberCrafterArea"
				return TRUE;
			else
				return FALSE;	
		}
	}
/**************************************************************************************/
	// passed through all restrictions so go ahead
	return TRUE;
}
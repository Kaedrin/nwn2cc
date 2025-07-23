//	i_nx1_silver_sword_aq
/*
	OnAcquire script for the expansion's Silver Sword of Gith - dynamically assigns attributes based on PC class.
	Based off of the i_silver_sword.nss file created by CGaw.
*/
//	OMP-OEI 6/8/07	- Used the original swords' OnAcquire script as a blueprint for this one.
//	OMP-OEI 6/15/07	- Updated the class-specific properties.
//	OMP-OEI 6/18/07	- Added the RemoveStandardProps function (putting a call to it in the main function) and
//						removed code we no longer want to use (PC-only code from first sword).
//	OMP-OEI 6/18/07	- Removed all code relating to Damage Reduction.
//	OMP-OEI 7/1/07	- Lowered Fighter and Barbarian Enhancement Bonuses from 11 to 10, commented out call to 
//						AddStandardProperties() and rearranged the hitpoint bonuses so that caster classes get more.


#include "x2_inc_itemprop"
#include "ginc_debug"
#include "cmi_includes"

void RemoveStandardProps( object oItem )
{
	IPRemoveMatchingItemProperties( oItem, ITEM_PROPERTY_ABILITY_BONUS, DURATION_TYPE_PERMANENT, -1 );

	IPRemoveMatchingItemProperties( oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS, DURATION_TYPE_PERMANENT, -1 );

	IPRemoveMatchingItemProperties( oItem, 66, DURATION_TYPE_PERMANENT, -1 );	//	Bonus Hit Points

	IPRemoveMatchingItemProperties( oItem, ITEM_PROPERTY_SPELL_RESISTANCE, DURATION_TYPE_PERMANENT, -1 );

	IPRemoveMatchingItemProperties( oItem, ITEM_PROPERTY_MASSIVE_CRITICALS, DURATION_TYPE_PERMANENT, -1 );
}


void AddStandardProps( object oItem )
{
//	itemproperty ipMagDmgBonus = ItemPropertyDamageBonus( IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_2d6 );
//	itemproperty ipDmgBonus = ItemPropertyDamageBonusVsRace( IP_CONST_RACIALTYPE_OUTSIDER, IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_3d6 );
//	itemproperty ipKeen = ItemPropertyKeen();

	itemproperty ipDR1 = ItemPropertyDamageResistance( IP_CONST_DAMAGETYPE_ACID, IP_CONST_DAMAGERESIST_10 );	
	itemproperty ipDR2 = ItemPropertyDamageResistance( IP_CONST_DAMAGETYPE_COLD, IP_CONST_DAMAGERESIST_10 );
	itemproperty ipDR3 = ItemPropertyDamageResistance( IP_CONST_DAMAGETYPE_ELECTRICAL, IP_CONST_DAMAGERESIST_10 );
	itemproperty ipDR4 = ItemPropertyDamageResistance( IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGERESIST_10 );

	itemproperty ipStrength = ItemPropertyAbilityBonus( IP_CONST_ABILITY_STR, 2 );
	itemproperty ipDexterity = ItemPropertyAbilityBonus( IP_CONST_ABILITY_DEX, 2 );
	itemproperty ipConstitution = ItemPropertyAbilityBonus( IP_CONST_ABILITY_CON, 2 );
	itemproperty ipIntelligence = ItemPropertyAbilityBonus( IP_CONST_ABILITY_INT, 2 );
	itemproperty ipWisdom = ItemPropertyAbilityBonus( IP_CONST_ABILITY_WIS, 2 );
	itemproperty ipCharisma = ItemPropertyAbilityBonus( IP_CONST_ABILITY_CHA, 2 );

//	IPSafeAddItemProperty( oItem, ipMagDmgBonus, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE );
//	IPSafeAddItemProperty( oItem, ipDmgBonus, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE );

//	IPSafeAddItemProperty( oItem, ipKeen, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE );

	IPSafeAddItemProperty( oItem, ipDR1, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE );
	IPSafeAddItemProperty( oItem, ipDR2, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE );
	IPSafeAddItemProperty( oItem, ipDR3, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE );
	IPSafeAddItemProperty( oItem, ipDR4, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE );

	IPSafeAddItemProperty( oItem, ipStrength, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE );
	IPSafeAddItemProperty( oItem, ipDexterity, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE );
	IPSafeAddItemProperty( oItem, ipConstitution, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE );
	IPSafeAddItemProperty( oItem, ipIntelligence, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE );
	IPSafeAddItemProperty( oItem, ipWisdom, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE );
	IPSafeAddItemProperty( oItem, ipCharisma, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE );
}


void AddItemPropsBarbarian( object oItem )
{
	itemproperty ipStrength = ItemPropertyAbilityBonus( IP_CONST_ABILITY_STR, 6 );
	itemproperty ipConstitution = ItemPropertyAbilityBonus( IP_CONST_ABILITY_CON, 4 );

	itemproperty ipEnhancement = ItemPropertyEnhancementBonus( 10 );
	itemproperty ipHP = ItemPropertyBonusHitpoints( 20 );	// 20 hp
	itemproperty ipSR = ItemPropertyBonusSpellResistance( IP_CONST_SPELLRESISTANCEBONUS_20 );
	itemproperty ipMCrit = ItemPropertyMassiveCritical( IP_CONST_DAMAGEBONUS_2d10 );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipStrength, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipConstitution, oItem );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipEnhancement, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipHP, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipSR, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipMCrit, oItem );
	
	SetLocalInt(oItem, "Enhance_Bonus", 10);
}


void AddItemPropsBard( object oItem )
{
	itemproperty ipCharisma = ItemPropertyAbilityBonus( IP_CONST_ABILITY_CHA, 6 );
	itemproperty ipDexterity = ItemPropertyAbilityBonus( IP_CONST_ABILITY_DEX, 4 );

	itemproperty ipEnhancement = ItemPropertyEnhancementBonus( 10 );
	itemproperty ipHP = ItemPropertyBonusHitpoints( 22 );	// 30 hp
	itemproperty ipSR = ItemPropertyBonusSpellResistance( IP_CONST_SPELLRESISTANCEBONUS_24 );
	itemproperty ipMCrit = ItemPropertyMassiveCritical( IP_CONST_DAMAGEBONUS_1d10 );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipCharisma, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipDexterity, oItem );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipEnhancement, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipHP, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipSR, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipMCrit, oItem );
	
	SetLocalInt(oItem, "Enhance_Bonus", 10);
}


void AddItemPropsCleric( object oItem )
{
	itemproperty ipWisdom = ItemPropertyAbilityBonus( IP_CONST_ABILITY_WIS, 6 );
	itemproperty ipConstitution = ItemPropertyAbilityBonus( IP_CONST_ABILITY_CON, 4 );

	itemproperty ipEnhancement = ItemPropertyEnhancementBonus( 9 );
	itemproperty ipHP = ItemPropertyBonusHitpoints( 23 );	// 35 hp
	itemproperty ipSR = ItemPropertyBonusSpellResistance( IP_CONST_SPELLRESISTANCEBONUS_28 );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipWisdom, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipConstitution, oItem );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipEnhancement, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipHP, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipSR, oItem );
	
	SetLocalInt(oItem, "Enhance_Bonus", 9);
}


void AddItemPropsDruid( object oItem )
{
	itemproperty ipWisdom = ItemPropertyAbilityBonus( IP_CONST_ABILITY_WIS, 6 );
	itemproperty ipDexterity = ItemPropertyAbilityBonus( IP_CONST_ABILITY_DEX, 4 );

	itemproperty ipEnhancement = ItemPropertyEnhancementBonus( 9 );
	itemproperty ipHP = ItemPropertyBonusHitpoints( 23 );	// 35 hp
	itemproperty ipSR = ItemPropertyBonusSpellResistance( IP_CONST_SPELLRESISTANCEBONUS_28 );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipWisdom, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipDexterity, oItem );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipEnhancement, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipHP, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipSR, oItem );
	
	SetLocalInt(oItem, "Enhance_Bonus", 9);
}


void AddItemPropsFavoredSoul( object oItem )
{
	itemproperty ipWisdom = ItemPropertyAbilityBonus( IP_CONST_ABILITY_WIS, 6 );
	itemproperty ipConstitution = ItemPropertyAbilityBonus( IP_CONST_ABILITY_CON, 4 );
	itemproperty ipCharisma = ItemPropertyAbilityBonus( IP_CONST_ABILITY_CHA, 6 );

	itemproperty ipEnhancement = ItemPropertyEnhancementBonus( 9 );
	itemproperty ipHP = ItemPropertyBonusHitpoints( 23 );	// 35 hp
	itemproperty ipSR = ItemPropertyBonusSpellResistance( IP_CONST_SPELLRESISTANCEBONUS_28 );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipWisdom, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipConstitution, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipCharisma, oItem );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipEnhancement, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipHP, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipSR, oItem );
	
	SetLocalInt(oItem, "Enhance_Bonus", 9);
}


void AddItemPropsFighter( object oItem )
{
	itemproperty ipStrength = ItemPropertyAbilityBonus( IP_CONST_ABILITY_STR, 4 );
	itemproperty ipConstitution = ItemPropertyAbilityBonus( IP_CONST_ABILITY_CON, 6 );

	itemproperty ipEnhancement = ItemPropertyEnhancementBonus( 10 );
	itemproperty ipHP = ItemPropertyBonusHitpoints( 20 );	// 20 hp
	itemproperty ipSR = ItemPropertyBonusSpellResistance( IP_CONST_SPELLRESISTANCEBONUS_20 );
	itemproperty ipMCrit = ItemPropertyMassiveCritical( IP_CONST_DAMAGEBONUS_2d10 );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipStrength, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipConstitution, oItem );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipEnhancement, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipHP, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipSR, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipMCrit, oItem );
	
	SetLocalInt(oItem, "Enhance_Bonus", 10);
}


void AddItemPropsMonk( object oItem )
{
	itemproperty ipDexterity = ItemPropertyAbilityBonus( IP_CONST_ABILITY_DEX, 6 );
	itemproperty ipWisdom = ItemPropertyAbilityBonus( IP_CONST_ABILITY_WIS, 4 );

	itemproperty ipEnhancement = ItemPropertyEnhancementBonus( 10 );
	itemproperty ipHP = ItemPropertyBonusHitpoints( 22 );	// 30 hp
	itemproperty ipSR = ItemPropertyBonusSpellResistance( IP_CONST_SPELLRESISTANCEBONUS_24 );
	itemproperty ipMCrit = ItemPropertyMassiveCritical( IP_CONST_DAMAGEBONUS_1d10 );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipDexterity, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipWisdom, oItem );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipEnhancement, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipHP, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipSR, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipMCrit, oItem );
	
	SetLocalInt(oItem, "Enhance_Bonus", 10);
}


void AddItemPropsPaladin( object oItem )
{
	itemproperty ipStrength = ItemPropertyAbilityBonus( IP_CONST_ABILITY_STR, 4 );
	itemproperty ipConstitution = ItemPropertyAbilityBonus( IP_CONST_ABILITY_CON, 4 );
	itemproperty ipWisdom = ItemPropertyAbilityBonus( IP_CONST_ABILITY_WIS, 4 );

	itemproperty ipEnhancement = ItemPropertyEnhancementBonus( 10 );
	itemproperty ipHP = ItemPropertyBonusHitpoints( 21 );	// 25 hp
	itemproperty ipSR = ItemPropertyBonusSpellResistance( IP_CONST_SPELLRESISTANCEBONUS_20 );
	itemproperty ipMCrit = ItemPropertyMassiveCritical( IP_CONST_DAMAGEBONUS_1d10 );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipStrength, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipConstitution, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipWisdom, oItem );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipEnhancement, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipHP, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipSR, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipMCrit, oItem );
	
	SetLocalInt(oItem, "Enhance_Bonus", 10);
}


void AddItemPropsRanger( object oItem )
{
	itemproperty ipDexterity = ItemPropertyAbilityBonus( IP_CONST_ABILITY_DEX, 6 );
	itemproperty ipWisdom = ItemPropertyAbilityBonus( IP_CONST_ABILITY_WIS, 4 );

	itemproperty ipEnhancement = ItemPropertyEnhancementBonus( 10 );
	itemproperty ipHP = ItemPropertyBonusHitpoints( 21 );	// 25 hp
	itemproperty ipSR = ItemPropertyBonusSpellResistance( IP_CONST_SPELLRESISTANCEBONUS_20 );
	itemproperty ipMCrit = ItemPropertyMassiveCritical( IP_CONST_DAMAGEBONUS_1d10 );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipDexterity, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipWisdom, oItem );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipEnhancement, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipHP, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipSR, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipMCrit, oItem );
	
	SetLocalInt(oItem, "Enhance_Bonus", 10);
}


void AddItemPropsRogue( object oItem )
{
	itemproperty ipDexterity = ItemPropertyAbilityBonus( IP_CONST_ABILITY_DEX, 8 );

	itemproperty ipEnhancement = ItemPropertyEnhancementBonus( 10 );
	itemproperty ipHP = ItemPropertyBonusHitpoints( 22 );	// 30 hp
	itemproperty ipSR = ItemPropertyBonusSpellResistance( IP_CONST_SPELLRESISTANCEBONUS_24 );
	itemproperty ipMCrit = ItemPropertyMassiveCritical( IP_CONST_DAMAGEBONUS_1d10 );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipDexterity, oItem );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipEnhancement, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipHP, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipSR, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipMCrit, oItem );
	
	SetLocalInt(oItem, "Enhance_Bonus", 10);
}


void AddItemPropsSorcerer( object oItem )
{
	itemproperty ipCharisma = ItemPropertyAbilityBonus( IP_CONST_ABILITY_CHA, 8 );

	itemproperty ipEnhancement = ItemPropertyEnhancementBonus( 8 );
	itemproperty ipHP = ItemPropertyBonusHitpoints( 24 );	// 40 hp
	itemproperty ipSR = ItemPropertyBonusSpellResistance( IP_CONST_SPELLRESISTANCEBONUS_32 );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipCharisma, oItem );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipEnhancement, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipHP, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipSR, oItem );
	
	SetLocalInt(oItem, "Enhance_Bonus", 8);
}


void AddItemPropsSpiritShaman( object oItem )
{
	itemproperty ipWisdom = ItemPropertyAbilityBonus( IP_CONST_ABILITY_WIS, 6 );
	itemproperty ipCharisma = ItemPropertyAbilityBonus( IP_CONST_ABILITY_CHA, 6 );

	itemproperty ipEnhancement = ItemPropertyEnhancementBonus( 9 );
	itemproperty ipHP = ItemPropertyBonusHitpoints( 23 );	// 35 hp
	itemproperty ipSR = ItemPropertyBonusSpellResistance( IP_CONST_SPELLRESISTANCEBONUS_28 );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipWisdom, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipCharisma, oItem );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipEnhancement, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipHP, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipSR, oItem );
	
	SetLocalInt(oItem, "Enhance_Bonus", 9);
}


void AddItemPropsWarlock( object oItem )
{
	itemproperty ipCharisma = ItemPropertyAbilityBonus( IP_CONST_ABILITY_CHA, 6 );
	itemproperty ipDexterity = ItemPropertyAbilityBonus( IP_CONST_ABILITY_DEX, 4 );

	itemproperty ipEnhancement = ItemPropertyEnhancementBonus( 8 );
	itemproperty ipHP = ItemPropertyBonusHitpoints( 24 );	// 40 hp
	itemproperty ipSR = ItemPropertyBonusSpellResistance( IP_CONST_SPELLRESISTANCEBONUS_32 );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipCharisma, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipDexterity, oItem );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipEnhancement, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipHP, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipSR, oItem );
	
	SetLocalInt(oItem, "Enhance_Bonus", 8);
}


void AddItemPropsWizard( object oItem )
{
	itemproperty ipIntelligence = ItemPropertyAbilityBonus( IP_CONST_ABILITY_INT, 8 );

	itemproperty ipEnhancement = ItemPropertyEnhancementBonus( 8 );
	itemproperty ipHP = ItemPropertyBonusHitpoints( 24 );	// 40 hp
	itemproperty ipSR = ItemPropertyBonusSpellResistance( IP_CONST_SPELLRESISTANCEBONUS_32 );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipIntelligence, oItem );

	AddItemProperty( DURATION_TYPE_PERMANENT, ipEnhancement, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipHP, oItem );
	AddItemProperty( DURATION_TYPE_PERMANENT, ipSR, oItem );
	
	SetLocalInt(oItem, "Enhance_Bonus", 8);
}


void main()
{
	// * This code runs when the item is acquired
	object oPC = GetModuleItemAcquiredBy();
	object oItem = GetModuleItemAcquired();
//	int iStackSize = GetModuleItemAcquiredStackSize();
//	object oFrom = GetModuleItemAcquiredFrom();

/*	if ( GetIsOwnedByPlayer( oPC ) == TRUE)
	{
		IPRemoveAllItemProperties( oItem, DURATION_TYPE_PERMANENT );
	}
	else
	{
		return;
	}
*/
	RemoveStandardProps( oItem );

	int nNewClass = CLASS_TYPE_BARBARIAN;

	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_BARD, oPC ) )
	{
		nNewClass = CLASS_TYPE_BARD;
	}

	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_CLERIC, oPC ) )
	{
		nNewClass = CLASS_TYPE_CLERIC;
	}

	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_DRUID, oPC ) )
	{
		nNewClass = CLASS_TYPE_DRUID;
	}

	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_FAVORED_SOUL, oPC ) )
	{
		nNewClass = CLASS_TYPE_FAVORED_SOUL;
	}

	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_FIGHTER, oPC ) )
	{
		nNewClass = CLASS_TYPE_FIGHTER;
	}

	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_MONK, oPC ) )
	{
		nNewClass = CLASS_TYPE_MONK;
	}

	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_PALADIN, oPC ) )
	{
		nNewClass = CLASS_TYPE_PALADIN;
	}

	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_RANGER, oPC ) )
	{
		nNewClass = CLASS_TYPE_RANGER;
	}

	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_ROGUE, oPC ) )
	{
		nNewClass = CLASS_TYPE_ROGUE;
	}

	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_SORCERER, oPC ) )
	{
		nNewClass = CLASS_TYPE_SORCERER;
	}

	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_SPIRIT_SHAMAN, oPC ) )
	{
		nNewClass = CLASS_TYPE_SPIRIT_SHAMAN;
	}

	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_WARLOCK, oPC ) )
	{
		nNewClass = CLASS_TYPE_WARLOCK;
	}

	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_WIZARD, oPC ) )
	{
		nNewClass = CLASS_TYPE_WIZARD;
	}
	
	//New Content by Kaedrin		
	
	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_THUG, oPC ) )
	{
		nNewClass = CLASS_TYPE_FIGHTER;
	}	
	
	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_SCOUT, oPC ) )
	{
		nNewClass = CLASS_TYPE_RANGER;
	}	
	
	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_NINJA, oPC ) )
	{
		nNewClass = CLASS_TYPE_ROGUE;
	}	
	
	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_SWASHBUCKLER, oPC ) ) 
	{
		nNewClass = CLASS_TYPE_FIGHTER;
	}		
	
	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_HEXBLADE, oPC ) ) 
	{
		nNewClass = CLASS_TYPE_FIGHTER;
	}			

	switch ( nNewClass )
	{
		case 0:		// BARBARIAN
			AddItemPropsBarbarian( oItem );
			break;
		case 1:		// BARD
			AddItemPropsBard( oItem );
			break;
		case 2:		// CLERIC
			AddItemPropsCleric( oItem );
			break;
		case 3:		// DRUID
			AddItemPropsDruid( oItem );
			break;
		case 58:	// FAVORED SOUL
			AddItemPropsFavoredSoul( oItem );
			break;
		case 4:		// FIGHTER
			AddItemPropsFighter( oItem );
			break;
		case 5:		// MONK
			AddItemPropsMonk( oItem );
			break;
		case 6:		// PALADIN
			AddItemPropsPaladin( oItem );
			break;
		case 7:		// RANGER
			AddItemPropsRanger( oItem );
			break;
		case 8:		// ROGUE
			AddItemPropsRogue( oItem );
			break;
		case 9:		// SORCERER
			AddItemPropsSorcerer( oItem );
			break;
		case 55:	// SPIRIT SHAMAN
			AddItemPropsSpiritShaman( oItem );
			break;
		case 39:	// WARLOCK
			AddItemPropsWarlock( oItem );
			break;
		case 10:	// WIZARD
			AddItemPropsWizard( oItem );
			break;
	}

//	AddStandardProps( oItem );
}
/////////////////////////////////////////////
// *
// * Created by Christopher Aulepp
// * Date: 12 May 2008
// * contact information: cdaulepp@juno.com
// * VERSION 2.0
// * copyright 2008 Christopher Aulepp. All rights reserved.
// *
//////////////////////////////////////////////

//////////////////////////////////////////////
// *
// *
// *		UPDATES
// *
// *
//////////////////////////////////////////////
// 

//////////////////////////////////////////////
// *
// *
// *		FILE DESCRIPTION
// *
// *
//////////////////////////////////////////////
/*
This file is completely new to Version 1.2  This file handles cr scaling of loot
based off of a formula method.  This is a great time saving device for those
who want a quick and easy way to scale loot based off of the power of the monster
that the PC fights.  Formula based CR scaling does NOT give you as much control
as constant based scaling does, but is much easier to edit.  Feel free to change
the default values of the modifiers.  Changing the modifiers will result in 
different ranges for each item property.
*/

// VERY IMPORTANT NOTE: I indicate next to each item property below telling you 
// what the hard-coded limits are. For example, attack penalties can range from 1 
// to 5. These limits are not things I set, but are hard coded into 
// the game by Obsidian.  I note these limits to remind you of the max and min
// values possible.  I also show you what the default range is for a level 20
// monster using the default formula and the default values I have set for
// the modifiers.  By altering the modifiers you can adjust to whatever range
// you want.  The range will automatically scale according to the CR
// of the monster that the PC faces.
//
// I'm hoping this will help you in picking a modifier for each
// item property.  In ALL of the function implementations I have checks that
// keep the values inside the hard-coded bounds.  So you don't need to worry
// about resulting values greater than or less than the limits.  Continuing
// the example of attack penalties...  If a value > 5 would result, the value is 
// changed to 5 because that's the maximum attack penalty possible.  If a value 
// less than 1 results, the value is changed to 1 because that is the minimum
// attack penalty allowed.  Even though I am using attack penalty as the 
// example, I made sure all of the item properties have checks to keep values
// inside the legal bounds of the game. You don't have to worry about that.

// ABILITY BONUS
// Can range from 1 to 12
// Default Formula: (CR * Modifier) + 1 
// Default range for CR 20 monster: 3-6  
// (This means a level 20 CR monster could drop an item with +3, +4, +5, or +6 
// using the default modifiers) If you change the modifiers it will change
// the range possible, not just at level 20, but at every level.
const float FW_MAX_ABILITY_BONUS_MODIFIER = 0.25;
const float FW_MIN_ABILITY_BONUS_MODIFIER = 0.1;

// AC BONUS
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5 
const float FW_MAX_AC_BONUS_MODIFIER = 0.2;
const float FW_MIN_AC_BONUS_MODIFIER = 0.1;

// AC BONUS VS. ALIGN GROUP
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1 
// Default range for CR 20 monster: 3-5
const float FW_MAX_AC_BONUS_VS_ALIGN_MODIFIER = 0.2;
const float FW_MIN_AC_BONUS_VS_ALIGN_MODIFIER = 0.1;

// AC BONUS VS DAMAGE TYPE
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_AC_BONUS_VS_DAMAGE_MODIFIER = 0.2;
const float FW_MIN_AC_BONUS_VS_DAMAGE_MODIFIER = 0.1;

// AC BONUS VS RACE
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_AC_BONUS_VS_RACE_MODIFIER = 0.2;
const float FW_MIN_AC_BONUS_VS_RACE_MODIFIER = 0.1;

// AC BONUS VS SPECIFIC ALIGNMENT
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_AC_BONUS_VS_SALIGN_MODIFIER = 0.2;
const float FW_MIN_AC_BONUS_VS_SALIGN_MODIFIER = 0.1;

// ARCANE SPELL FAILURE
// There is no min/max formula to limit arcane spell failure.  To change what 
// can or can't appear on items for this item property, you need to go into the
// function FW_Choose_IP_Arcane_Spell_Failure and comment out the case 
// statements that you don't want to appear. By default, all types (both 
// positive and negative) arcane spell failure can appear on an item. Only
// an experienced scripter should modify that function. That function is found
// in the file "fw_inc_choose_ip"

// ATTACK BONUS
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_ATTACK_BONUS_MODIFIER = 0.2;
const float FW_MIN_ATTACK_BONUS_MODIFIER = 0.1;

// ATTACK BONUS VS ALIGNMENT GROUP
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_ATTACK_BONUS_VS_ALIGN_MODIFIER = 0.2;
const float FW_MIN_ATTACK_BONUS_VS_ALIGN_MODIFIER = 0.1;

// ATTACK BONUS VS RACE
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_ATTACK_BONUS_VS_RACE_MODIFIER = 0.2;
const float FW_MIN_ATTACK_BONUS_VS_RACE_MODIFIER = 0.1;

// ATTACK BONUS VS. SPECIFIC ALIGNMENT
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_ATTACK_BONUS_VS_SALIGN_MODIFIER = 0.2;
const float FW_MIN_ATTACK_BONUS_VS_SALIGN_MODIFIER = 0.1;

// ATTACK PENALTY
// Can range from 1 to 5
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 0-5
const float FW_MAX_ATTACK_PENALTY_MODIFIER = 0.2;
const float FW_MIN_ATTACK_PENALTY_MODIFIER = 0.0;

// * ITEM_PROPERTY_BONUS_FEAT
// There is no switch to change what feats can or can't appear on an item.
// If you want to change what feats can or can't appear you need to go into the
// function FW_Choose_IP_Bonus_Feat and comment out the case statements for the
// feats that you don't want to appear.  By default, all feats can appear on an
// item.  That function is found in the file "fw_inc_choose_ip". Only an
// experienced scripter should change it though.

// BONUS HIT POINTS
// Can range from 1 to 50
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 10-30
const float FW_MAX_BONUS_HIT_POINTS_MODIFIER = 1.45; 
const float FW_MIN_BONUS_HIT_POINTS_MODIFIER = 0.45;

// BONUS LEVEL SPELL
// Can range from 0 to 9
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 0-9
const float FW_MAX_BONUS_LEVEL_SPELL_MODIFIER = 0.4;
const float FW_MIN_BONUS_LEVEL_SPELL_MODIFIER = 0.0;

// BONUS SAVING THROW
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_BONUS_SAVING_THROW_MODIFIER = 0.2;
const float FW_MIN_BONUS_SAVING_THROW_MODIFIER = 0.1;

// BONUS_SAVING_THROW_VSX
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_BONUS_SAVING_THROW_VSX_MODIFIER = 0.2;
const float FW_MIN_BONUS_SAVING_THROW_VSX_MODIFIER = 0.1;

// BONUS_SPELL_RESISTANCE
// Can range from 10 to 32 in increments of 2: 10,12,14,...,32
// Default Formula: (CR * Modifier)
// Note: Different formula than normal. No "+1".
// Default range for CR 20 monster: 20-32
const float FW_MAX_BONUS_SPELL_RESISTANCE_MODIFIER = 2.0;
const float FW_MIN_BONUS_SPELL_RESISTANCE_MODIFIER = 1.0;

// * ITEM_PROPERTY_CAST_SPELL_*
// By default the function that chooses ItemProperty
// CastSpell will choose from every single spell available (there are hundreds)
// If you want to disallow certain spells from being added to an item, then you
// need to go into the function: FW_Choose_IP_Cast_Spell and edit it.  That 
// function is found in the file "fw_inc_choose_ip"  Only an
// experienced scripter should change it though.

// * ITEM_PROPERTY_DAMAGE_BONUS_*
// Setting a formula for damage bonuses requires a bit of explaining.
// I have ranked all the damage bonus item properties in ascending order based
// off of the average damage dealt by each item property. In cases where the
// average was a tie (i.e. 7 dmg and 2d6 dmg both average 7 dmg) I gave a higher
// ranking to the random amount because it can potentially roll much higher. 
// See the table below for the rankings of the damage bonuses. 
//
// When you set the modifier for the formula, the resulting value is equal to the
// index in the table below.  For example, FW_DAMAGE_BONUS_MODIFIER has a formula 
// of: (CR * Modifier) + 1.  The default value for FW_DAMAGE_BONUS_MODIFIER is 1.0
//
// Example 1: (using the default value for modifier)
// A CR level 10 monster will have a maximum **possible** value that corresponds
// to index 11 because (CR * 1.0) + 1 = 11.  Index 11 = 1d12 bonus damage.  The
// random loot generator in this example could roll anything from measly 1 bonus 
// damage up to 1d12 bonus damage or anything inbetween.
//
// Example 2: (using the default value for modifier)
// A CR level 15 monster will have a maximum **possible** value that corresponds
// to index 16 because (CR * 1.0) + 1 = 16.  Index 16 = 2d8 bonus damage.  The
// random loot generator in this example could roll anything from measly 1 bonus 
// damage up to 2d8 bonus damage or anything inbetween.
//
// NOTE: You don't have to worry about going outside (either below index 0 or above
// index 19.  For example, a CR level 25 monster (with the default modifier value
// and default formula of CR * Modifier - 1) would give an index value = 24. 
// But, remember what I said at the top of this file about going out of bounds.
// You don't have to worry about going outside the bounds allowed by the game.  I 
// have checks that stop this from happening. If, as in the example above, a CR
// 25 monster yields a result of 24, the result is changed to 19.  For this item
// property, index 19 is the highest value possible. 
//
// TABLE: IP_CONST_DAMAGE_BONUS
//
// INDEX = ITEM_PROPERTY...AVERAGE DAMAGE
//   0   = 1    damage  ...avg = 1
//   1   = 2    damage  ...avg = 2
//   2   = 1d4  damage  ...avg = 2.5
//   3   = 3    damage  ...avg = 3
//   4   = 1d6  damage  ...avg = 3.5
//   5   = 4    damage  ...avg = 4
//   6   = 1d8  damage  ...avg = 4.5
//   7   = 5    damage  ...avg = 5
//   8   = 2d4  damage  ...avg = 5
//   9   = 1d10 damage  ...avg = 5.5
//   10  = 6    damage  ...avg = 6
//   11  = 1d12 damage  ...avg = 6.5
//   12  = 7    damage  ...avg = 7
//   13  = 2d6  damage  ...avg = 7
//   14  = 8    damage  ...avg = 8
//   15  = 9    damage  ...avg = 9
//   16  = 2d8  damage  ...avg = 9
//   17  = 10   damage  ...avg = 10
//   18  = 2d10 damage  ...avg = 11
//   19  = 2d12 damage  ...avg = 13
//
// The above table is used for the following item properties:
//   Damage Bonus
//   Damage Bonus Vs. Alignment Group
//   Damage Bonus Vs. Race
//   Damage Bonus vs. Specific Alignment
//   Massive Critical

// DAMAGE_BONUS
// Can range from 0 to 19
// Default Formula: (CR * Modifier) - 1
// Default range for CR 20 monster: +1 to +2d12 dmg.
const float FW_MAX_DAMAGE_BONUS_MODIFIER = 1.0;
const float FW_MIN_DAMAGE_BONUS_MODIFIER = 0.0;

// DAMAGE_BONUS_VS_ALIGN
// Can range from 0 to 19
// Default Formula: (CR * Modifier) - 1
// Default range for CR 20 monster: +1 to +2d12 dmg.
const float FW_MAX_DAMAGE_BONUS_VS_ALIGN_MODIFIER = 1.0;
const float FW_MIN_DAMAGE_BONUS_VS_ALIGN_MODIFIER = 0.0;

// DAMAGE_BONUS_VS_RACE
// Can range from 0 to 19
// Default Formula: (CR * Modifier) - 1
// Default range for CR 20 monster: +1 to +2d12 dmg.
const float FW_MAX_DAMAGE_BONUS_VS_RACE_MODIFIER = 1.0;
const float FW_MIN_DAMAGE_BONUS_VS_RACE_MODIFIER = 0.0;

// DAMAGE_BONUS_VS_SALIGN
// Can range from 0 to 19
// Default Formula: (CR * Modifier) - 1
// Default range for CR 20 monster: +1 to +2d12 dmg.
const float FW_MAX_DAMAGE_BONUS_VS_SALIGN_MODIFIER = 1.0;
const float FW_MIN_DAMAGE_BONUS_VS_SALIGN_MODIFIER = 0.0;

// MASSIVE_CRITICAL_DAMAGE_BONUS
// Can range from 0 to 19
// Default Formula: (CR * Modifier) - 1
// Default range for CR 20 monster: +1 to +2d12 dmg.
const float FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_MODIFIER = 1.0;
const float FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_MODIFIER = 0.0;

// *DAMAGE SHIELDS*  
// Damage Shields scale according to the PC's level, not the spawning monster's 
// level.  Therefore, there is no modifier for Damage 
// Shields.  I already took care of damage shield scaling.  If you want to change
// the formula for damage shields to scale in some manner other than the way I have
// it set up already, you'll need to edit the file: "i_fw_damage_shield_ac".  But
// I recommend only a VERY EXPERIENCED programmer even attempt to change that file.
// And make sure you know all about tag based scripting before you do change it or 
// else you'll mess it up. Whatever you do, DON'T change the name of that file or 
// else it will definitely NOT work. 

// * ITEM_PROPERTY_DAMAGE_IMMUNITY
// There is no switch to control min/max damage immunity amounts.  To disallow certain
// amounts you have to comment out the case statements inside the function
// FW_Choose_IP_Damage_Immunity ();  This function is found in the file:
// "fw_inc_choose_ip" Only an experienced scripter should change it though.

// DAMAGE_PENALTY
// Can range from 1 to 5
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 0-5
const float FW_MAX_DAMAGE_PENALTY_MODIFIER = 0.2;
const float FW_MIN_DAMAGE_PENALTY_MODIFIER = 0.0;

// DAMAGE_REDUCTION 
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_DAMAGE_REDUCTION_MODIFIER = 0.2;
const float FW_MIN_DAMAGE_REDUCTION_MODIFIER = 0.1;

// DAMAGESOAK_HP
// Can range from 5 to 50, in increments of 5. i.e. 5,10,15,...,50
// Default Formula: (CR * Modifier) * 5
// NOTE the different formula than normal
// Default range for CR 20 monster: 5-50
const float FW_MAX_DAMAGESOAK_HP_MODIFIER = 0.5;
const float FW_MIN_DAMAGESOAK_HP_MODIFIER = 0.05;

// DAMAGE_RESISTANCE
// Can range from 5 to 50, in increments of 5. i.e. 5,10,15,...,50
// Default Formula: (CR * Modifier) * 5
// NOTE the different formula than normal
// Default range for CR 20 monster: 5-50
const float FW_MAX_DAMAGE_RESISTANCE_MODIFIER = 0.5;
const float FW_MIN_DAMAGE_RESISTANCE_MODIFIER = 0.05;

// * ITEM_PROPERTY_DAMAGE_VULNERABILITY
// There is no switch to control damage vulnerability amounts. To disallow
// certain amounts you have to comment out the case statements inside the
// function FW_Choose_IP_Damage_Vulnerability ();  This function is found
// in the file "fw_inc_choose_ip" Only an experienced scripter should change 
// it.

// ABILITY_PENALTY
// Can range from 1 to 10
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 0-6
const float FW_MAX_ABILITY_PENALTY_MODIFIER = 0.25;
const float FW_MIN_ABILITY_PENALTY_MODIFIER = 0.0;

// AC_PENALTY
// Can range from 1 to 5
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 0-5
const float FW_MAX_AC_PENALTY_MODIFIER = 0.2;
const float FW_MIN_AC_PENALTY_MODIFIER = 0.0;

// SKILL_DECREASE
// Can range from 1 to 10
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 0-5
const float FW_MAX_SKILL_DECREASE_MODIFIER = 0.2;
const float FW_MIN_SKILL_DECREASE_MODIFIER = 0.0;

// ENHANCEMENT_BONUS
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_ENHANCEMENT_BONUS_MODIFIER = 0.2;
const float FW_MIN_ENHANCEMENT_BONUS_MODIFIER = 0.1;

// ENHANCEMENT_BONUS_VS_ALIGN
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_MODIFIER = 0.2;
const float FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_MODIFIER = 0.1;

// ENHANCEMENT_BONUS_VS_RACE
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_ENHANCEMENT_BONUS_VS_RACE_MODIFIER = 0.2;
const float FW_MIN_ENHANCEMENT_BONUS_VS_RACE_MODIFIER = 0.1;

// ENHANCEMENT_BONUS_VS_SALIGN
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_MODIFIER = 0.2;
const float FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_MODIFIER = 0.1;

// ENHANCEMENT_PENALTY
// Can range from 1 to 5
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_ENHANCEMENT_PENALTY_MODIFIER = 0.2;
const float FW_MIN_ENHANCEMENT_PENALTY_MODIFIER = 0.0;

// * ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE
// There is no formula. Edit the function: 
// FW_Choose_IP_Extra_Melee_Damage_Type() if you want to change anything.
// Only an experienced scripter should change it though.

// * ITEM_PROPERTY_EXTRA_RANGE_DAMAGE_TYPE
// There is no formula. Edit the function:
// FW_Choose_IP_Extra_Range_Damage_Type() if you want to change anything.
// Only an experienced scripter should change it though.

// HEALER_KIT
// Healer kit item properties don't work dynamically.  I'm waiting for Obsidian to
// fix that.  But even if they do fix it, I don't think anyone would want to 
// make their items into healing kits. The reason is if you use a healing kit, 
// it disappears from your inventory - just like any healing kit does when you 
// use it.  So if someone used their armor, or bracer, or whatever as a healing kit
// their armor/bracer/whatever would disappear.  And that doesn't make sense to me.
// I've included them here, even though they don't work.  Right now it doesn't
// matter what you put for the modifiers for this item property. 
// Can range from 1 to 12.
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 5-12
const float FW_MAX_HEALER_KIT_MODIFIER = 0.55;
const float FW_MIN_HEALER_KIT_MODIFIER = 0.2;


// * ITEM_PROPERTY_IMMUNITY_MISC * 
// There isn't a formula to control miscellaneous immunities. You can
// disallow all miscellaneous immunities in the file "fw_inc_loot_switches"
// If you want to exclude some, but not all immunities you can do so by
// editing the function FW_Choose_IP_Immunity_Misc in the file 
// "fw_inc_choose_ip"  Only an experienced scripter should change it though.

// IMMUNITY_TO_SPELL_LEVEL
// Can range from 1 to 9
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 0-9
const float FW_MAX_IMMUNITY_TO_SPELL_LEVEL_MODIFIER = 0.4;
const float FW_MIN_IMMUNITY_TO_SPELL_LEVEL_MODIFIER = 0.0;

// * ITEM_PROPERTY_LIGHT
// There is no formula to control the brightness or color of light that
// could be added to an item.  To disallow a light brightness or color,
// comment out the case statements inside function: FW_Choose_IP_Light ();
// This function is found in the file "fw_inc_choose_ip"  Only an experienced
// scripter should change this.

// * ITEM_PROPERTY_LIMIT_USE_BY_ALIGN
// * ITEM_PROPERTY_LIMIT_USE_BY_CLASS
// * ITEM_PROPERTY_LIMIT_USE_BY_RACE
// * ITEM_PROPERTY_LIMIT_USE_BY_SALIGN
// There is no formula to control specifics of the four item properties above. 
// I can't see why someone would want to allow some limitations but not 
// others.  If you want to disallow specifics, then go edit the functions:
// FW_Choose_IP_Limit_Use_By_*  in the file "fw_inc_choose_ip" Only an experienced
// scripter should change this.

// MIGHTY_BONUS
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 3-5
const float FW_MAX_MIGHTY_BONUS_MODIFIER = 0.2;
const float FW_MIN_MIGHTY_BONUS_MODIFIER = 0.1;

// * ITEM_PROPERTY_ON_HIT_CAST_SPELL
// There is no formula for on hit cast spell because this item property
// doesn't scale with CR.  Either an item has this property or it doesn't.
// You can disallow the property in the file "fw_inc_loot_switches" or you can
// disallow some, but not all spells by editing the function "FW_Choose_IP_On_Hit_Cast_Spell"
// in the file "fw_inc_choose_ip"  Only an experienced scripter should change this.

// ON_HIT_SPELL_LEVEL
// This is in conjunction with On Hit Cast Spell.  It must be determined what spell level
// your on hit spell is cast at (for things like breaking down spell mantles, etc). You could 
// allow on hit cast spells, but limit the level here if you wanted. If you disallowed on hit
// cast spell entirely in the file "fw_inc_switches" then it doesn't matter what these values are.
// Can range from 1 to 9
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 0-9
const float FW_MAX_ON_HIT_SPELL_LEVEL_MODIFIER = 0.4;
const float FW_MIN_ON_HIT_SPELL_LEVEL_MODIFIER = 0.0;

// * ITEM_PROPERTY_ON_HIT_PROPS *
// This item property doesn't scale with CR.  Either an item has an immunity
// or it doesn't.  There's no way to scale it. You can disallow ALL on hit props
// in the file "fw_inc_loot_switches" by setting the switch to FALSE.  If you
// just want to disallow some, but not all on hit props, then edit the function
// FW_Choose_IP_On_Hit_Props in the file "fw_inc_choose_ip" 
// Only an experienced scripter should change it though.

// ON_HIT_SAVE_DC
// This goes in conjunction with On Hit Props. Some of the onhitprops have save
// DC components. If you disallowed on hit props entirley, then these values 
// don't matter. Acceptable values: 14,16,18,20,22,24, or 26.  Anything less than 14
// gets rounded up to 14. Anything higher than 26 gets rounded down to 26. 
// Default Formula: (CR * Modifier)
// NOTE: different formula than normal, no "+1".
// Default range for CR 20 monster: 14-26
const float FW_MAX_ON_HIT_SAVE_DC_MODIFIER = 1.5;
const float FW_MIN_ON_HIT_SAVE_DC_MODIFIER = 0.5;

// SAVING_THROW_PENALTY
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 0-5
const float FW_MAX_SAVING_THROW_PENALTY_MODIFIER = 0.2;
const float FW_MIN_SAVING_THROW_PENALTY_MODIFIER = 0.0;

// SAVING_THROW_PENALTY_VSX
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 0-5
const float FW_MAX_SAVING_THROW_PENALTY_VSX_MODIFIER = 0.2;
const float FW_MIN_SAVING_THROW_PENALTY_VSX_MODIFIER = 0.0;

// REGENERATION
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 5-10
const float FW_MAX_REGENERATION_MODIFIER = 0.45;
const float FW_MIN_REGENERATION_MODIFIER = 0.2;

// SKILL_BONUS
// Can range from 1 to 50
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 5-10
const float FW_MAX_SKILL_BONUS_MODIFIER = 0.45;
const float FW_MIN_SKILL_BONUS_MODIFIER = 0.2;

// * ITEM_PROPERTY_SPELL_IMMUNITY_SCHOOL *
// * ITEM_PROPERTY_SPELL_IMMUNITY_SPECIFIC *
// There is no formula to control the above two item properties.  
// Either an item is immune to something or it isn't. No way to scale this.
// You can disallow it in the file "fw_inc_loot_switches"
// Only an experienced scripter should change it though.

// THIEVES_TOOLS
// Thieves tools are not working dynamically right now. Hopefully Obsidian
// fixes them soon.  Right now it doesn't matter what you put for these
// modifier values, but I've included them here for when Obsidian finally
// fixes them. They aren't used right now.
// Can range from 1 to 12
// Default Formula: (CR * Modifier) + 1 
// Default range for CR 20 monster: 5-10
const float FW_MAX_THIEVES_TOOLS_MODIFIER = 0.45;
const float FW_MIN_THIEVES_TOOLS_MODIFIER = 0.2;

// TURN_RESISTANCE
// Turn Resistance seems to only be added to creature skins.  But PC's 
// cannot equip creature skins.  I probably don't need to include this
// item property, but in case Obsidian changes it so that turn resistance
// can be added to items other than creature skins, I've included this
// here.  It doesn't matter what you put for this item property modifiers
// at this time.  They aren't used.
// Can range from 1 to 50
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 10-20
const float FW_MAX_TURN_RESISTANCE_MODIFIER = 0.95;
const float FW_MIN_TURN_RESISTANCE_MODIFIER = 0.45;

// * ITEM_PROPERTY_UNLIMITED_AMMO
// There is no formula to control the type(s) of unlimited ammo.
// To change the default go into the function FW_Choose_IP_Unlimited_Ammo
// and comment out the case statements you don't want as options.  This
// function is found in the file "fw_inc_choose_ip"
// Only an experienced scripter should change it though.

// VAMPIRIC_REGENERATION
// Can range from 1 to 20
// Default Formula: (CR * Modifier) + 1
// Default range for CR 20 monster: 5-10
const float FW_MAX_VAMPIRIC_REGENERATION_MODIFIER = 0.45;
const float FW_MIN_VAMPIRIC_REGENERATION_MODIFIER = 0.2;

// * ITEM_PROPERTY_WEIGHT_INCREASE
// Weight Increase is bugged in NWN 2.  It cannot be added dynamically
// to items as of this time.  Even if it did work properly, there 
// wouldn't be modifiers for this property because of the nature of the
// different choices for weight increases.

// * ITEM_PROPERTY_WEIGHT_REDUCTION
// There are no modifiers to control weight reduction on an item. By
// default all weight increase/decrease amounts are possible.  To disallow
// any/some of the possibles comment out the undesired amounts inside the
// functions: FW_Choose_IP_Weight_Increase and FW_Choose_IP_Weight_Reduction.
// Only an experienced scripter should change it though.

// TRAP_LEVEL
//   0 = Minor, 1 = Average, 2 = Strong, 3 = Deadly 
// Can range from 0 to 3.
// Default Formula: (CR * Modifier) - 1
// NOTE the different formula. Rounds to the nearest whole integer.
// Default range for CR 20 monster: 0-3
const float FW_MAX_TRAP_LEVEL_MODIFIER = 0.22;
const float FW_MIN_TRAP_LEVEL_MODIFIER = 0.0;
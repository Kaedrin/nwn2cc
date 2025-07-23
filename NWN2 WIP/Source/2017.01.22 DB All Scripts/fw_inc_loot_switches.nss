/////////////////////////////////////////////
// *
// * Created by Christopher Aulepp
// * Date: 12 May 2008
// * contact information: cdaulepp@juno.com
// * VERSION 2.0
// * copyright 2008 Christopher Aulepp.  All rights reserved.
// *
//////////////////////////////////////////////


// *****************************************
//
//
//				UPDATES
//				
//
// *****************************************
// VERSION 2.0
// -28 March 2008. I added switches to turn on/off Darkvision, Freedom
//     of Movement, Haste, Holy Avenger, Improved Evasion, Keen, and 
//	   True Seeing.  Like everything else, the default switch is set to TRUE, 
//     meaning these item properties are allowed by default.
//
// -13 April 2008. I added a switch that controls whether or not boss loot
//     will follow GP restrictions. The new constant is called:
//     FW_NO_GP_RESTRICTIONS_ON_BOSS_LOOT and is set to TRUE by default. This
//     means that creatures marked as bosses will have no GP limits on the 
//     loot they drop.  If you change to FALSE, then bosses will go back to
//     following GP restrictions.  This switch will only come into play if
//     if you proactively set a local integer variable on a monster.  I explain
//     how to do that below, right before the constant declaration.
// 
// -13 April 2008.  I added a switch that controls whether or not the loot
//     that appears will have a random name assigned.  The switch is called:
//     FW_ALLOW_RANDOM_NAMES_OF_LOOT and the default is set to TRUE, which 
//     means that if you do nothing unique names will be assigned to every
//     item.  For a more detailed explanation of how this all works, see the
//     file "fw_inc_loot_names."
//
// VERSION 1.2
// -27 August 2007. I wanted this file to contain all of the switches
//     for the random loot generator.  I moved a couple of the misc
//     switches that were previously in other files to this file to 
//     try to be consistent.  This file now contains ONLY switches
//     that turn things on/off.
//
// -5  Sept 2007.  I added several more switches to this file for more
//     end-user control.


// *****************************************
//
//    ITEM PROPERTY SWITCHES FOR MORE CONTROL
//
//	  YOU CAN CHANGE THESE IF YOU WANT				
//
// *****************************************

// These switches are set up by default to allow every item property that
// is not broken at the time this version of my random loot generator was
// released. 
//
// The item properties that Obsidian has not fixed yet are set to FALSE.
// Changing them to TRUE accidentally (or on purpose) will NOT cause any 
// errors.
//
// TRUE means the item property is allowed (and could POSSIBLY appear on 
// an item).
// FALSE means the item property is disallowed (and will never appear
// on an item).
//
// If you want to allow an item property, but you want to exclude some of
// its sub-types you should set the item property equal to TRUE in this
// file. For example, maybe you want to allow some, but not all types of
// immunities. Set the switch that controls immunities to TRUE. I explain
// each item property and how to limit them in the files: 
// "fw_inc_loot_cr_scaling_formulas" and "fw_inc_loot_cr_scaling_constants"  
//
// If you set something here to FALSE, then you have completely eliminated
// that property from ever showing up on an item, including all of its 
// sub-types.  Setting something to TRUE does not necessarily mean all 
// sub-types will be allowed because you can limit them in the files I just
// named above.   
//
const int FW_ALLOW_ABILITY_BONUS = TRUE;

const int FW_ALLOW_ABILITY_PENALTY = TRUE;

const int FW_ALLOW_AC_BONUS = TRUE;
const int FW_ALLOW_AC_BONUS_VS_ALIGN = TRUE;
const int FW_ALLOW_AC_BONUS_VS_DMG_TYPE = FALSE;
const int FW_ALLOW_AC_BONUS_VS_RACE = TRUE;
const int FW_ALLOW_AC_BONUS_VS_SALIGN = FALSE;

const int FW_ALLOW_AC_PENALTY = TRUE;

const int FW_ALLOW_ARCANE_SPELL_FAILURE = FALSE;

const int FW_ALLOW_ATTACK_BONUS = TRUE;
const int FW_ALLOW_ATTACK_BONUS_VS_ALIGN = TRUE;
const int FW_ALLOW_ATTACK_BONUS_VS_RACE = TRUE;
const int FW_ALLOW_ATTACK_BONUS_VS_SALIGN = FALSE;

const int FW_ALLOW_ATTACK_PENALTY = TRUE;

const int FW_ALLOW_BONUS_FEAT = FALSE;

const int FW_ALLOW_BONUS_LEVEL_SPELL = FALSE;

const int FW_ALLOW_BONUS_HIT_POINTS = TRUE;

const int FW_ALLOW_BONUS_SAVING_THROW = TRUE;
const int FW_ALLOW_BONUS_SAVING_THROW_VSX = TRUE;

const int FW_ALLOW_BONUS_SPELL_RESISTANCE = FALSE;

const int FW_ALLOW_CAST_SPELL = FALSE; // this controls per day castings on non wands & Rods
const int FW_ALLOW_CAST_PERDAY_WANDS = FALSE; // if this is false no per day casting wands will be produced

const int FW_ALLOW_DAMAGE_BONUS = TRUE;
const int FW_ALLOW_DAMAGE_BONUS_VS_ALIGNMENT = TRUE;
const int FW_ALLOW_DAMAGE_BONUS_VS_RACE = TRUE;
const int FW_ALLOW_DAMAGE_BONUS_VS_SALIGNMENT = FALSE;

const int FW_ALLOW_MASSIVE_CRITICAL_DAMAGE_BONUS = TRUE;

const int FW_ALLOW_DAMAGE_SHIELDS = TRUE;

const int FW_ALLOW_DAMAGE_IMMUNITY = FALSE;

const int FW_ALLOW_DAMAGE_PENALTY = TRUE;

// NWN 2 is bugged when it comes to damage reduction.  By default
// this is set to FALSE. Until they fix it anyway.
const int FW_ALLOW_DAMAGE_REDUCTION = TRUE;

const int FW_ALLOW_DAMAGE_RESISTANCE = TRUE;

const int FW_ALLOW_DAMAGE_VULNERABILITY = TRUE;

const int FW_ALLOW_DARKVISION = FALSE;

const int FW_ALLOW_ENHANCEMENT_BONUS = TRUE;
const int FW_ALLOW_ENHANCEMENT_BONUS_VS_ALIGN = TRUE;
const int FW_ALLOW_ENHANCEMENT_BONUS_VS_RACE = TRUE;
const int FW_ALLOW_ENHANCEMENT_BONUS_VS_SALIGN = FALSE;
const int FW_ALLOW_ENHANCEMENT_PENALTY = TRUE;

const int FW_ALLOW_EXTRA_MELEE_DAMAGE_TYPE = TRUE;

const int FW_ALLOW_EXTRA_RANGE_DAMAGE_TYPE = TRUE;

const int FW_ALLOW_FREEDOM_OF_MOVEMENT = FALSE;

const int FW_ALLOW_HASTE = FALSE;

const int FW_ALLOW_HEALER_KIT = TRUE;

const int FW_ALLOW_HOLY_AVENGER = FALSE;

const int FW_ALLOW_IMMUNITY_MISC = FALSE;

const int FW_ALLOW_IMMUNITY_TO_SPELL_LEVEL = FALSE;

const int FW_ALLOW_IMPROVED_EVASION = FALSE;

const int FW_ALLOW_KEEN = FALSE;

const int FW_ALLOW_LIGHT = TRUE;

const int FW_ALLOW_LIMIT_USE_BY_ALIGN = TRUE;
const int FW_ALLOW_LIMIT_USE_BY_CLASS = TRUE;
const int FW_ALLOW_LIMIT_USE_BY_RACE = TRUE;
const int FW_ALLOW_LIMIT_USE_BY_SALIGN = TRUE;

const int FW_ALLOW_MIGHTY_BONUS = TRUE;

const int FW_ALLOW_ON_HIT_CAST_SPELL = FALSE;

const int FW_ALLOW_ON_HIT_PROPS = FALSE;

const int FW_ALLOW_SAVING_THROW_PENALTY = TRUE;
const int FW_ALLOW_SAVING_THROW_PENALTY_VSX = TRUE;

const int FW_ALLOW_REGENERATION = FALSE;

const int FW_ALLOW_SKILL_BONUS = TRUE;

const int FW_ALLOW_SKILL_DECREASE = TRUE;

const int FW_ALLOW_SPELL_IMMUNITY_SCHOOL = FALSE;

const int FW_ALLOW_SPELL_IMMUNITY_SPECIFIC = FALSE;

// Thieves tools are bugged in NWN 2 and cannot be added to an item 
// dynamically. Default is FALSE.
const int FW_ALLOW_THIEVES_TOOLS = FALSE;

const int FW_ALLOW_TRUE_SEEING = FALSE;

// Turn Resistance can only be added to a skin of a creature.  If a PC finds a 
// creature skin they can't equip it, so I couldn't implement this.  Default is
// set to FALSE.
const int FW_ALLOW_TURN_RESISTANCE = FALSE;

const int FW_ALLOW_UNLIMITED_AMMO = FALSE;

const int FW_ALLOW_VAMPIRIC_REGENERATION = TRUE;

// Weight increase is bugged in NWN 2 and cannot be added to an item
// dynamically. Default is FALSE.
const int FW_ALLOW_WEIGHT_INCREASE = FALSE;

// Weight reduction works fine though.  
const int FW_ALLOW_WEIGHT_REDUCTION = TRUE;

// *****************************************
//
//    MISCELLANEOUS SWITCHES FOR MORE CONTROL
//
//	  YOU CAN CHANGE THESE IF YOU WANT				
//
// *****************************************

// If set to TRUE there is a chance that an item is cursed.  If you change this
// to FALSE then there is NO CHANCE ever of a cursed item.  Cursed Items 
// are not the same thing as items with negative properties.  A cursed 
// item cannot be dropped by a PC.  It might have positive or negative
// item properties, or both.
//  
const int FW_ALLOW_CURSED_ITEMS = FALSE;
 
// *****************************************
// When determining the ranges of the different item properties that can 
// appear on an item there are different ways to set "acceptable" ranges.
// One method is to set ranges at every CR value by setting a lower and upper
// limit using constants.  Another way is using formulas that calculate the
// limits for each item property.  Either way works. Both methods have
// benefits and drawbacks.    
//
// Scaling loot based off constants that control upper and lower limits
// gives not just greater control, but COMPLETE control to the end-user.
// However, this method is VERY time-consuming to edit because there are 
// over 2000 constants to set values on.  For those willing to invest the
// time, CR scaling using constants gives you total control. The constants
// along with explanations on how to use them are found in the file:
// "fw_inc_loot_cr_scaling_constants".   
//
// Formula based CR scaling tends to be MUCH easier to use for an end-user 
// because there are not nearly so many things to edit/change compared to 
// constant based CR Scaling.  The formulas, along with explanations on how
// to use them are found in the file "fw_inc_loot_cr_scaling_formulas".
//
// My random loot generator allows you to choose which way to control CR
// scaling of your loot.  I've chosen what I consider "reasonable" limits
// for the formulas. On the other hand, the constants are set up to allow
// for any item property of any power at any CR level. You need to decide
// which way to handle CR scaling of the power of your loot. 
//
// If set to TRUE (the default) then CR scaling will be done through 
// formulas.  If you set this to FALSE then CR scaling will be handled 
// through constants.  You cannot have both formula and constant scaling
// of your loot at the same time.  You have to pick one or the other. 
// TRUE = formula based scaling of loot.
// FALSE = constant based scaling of loot.
//
const int FW_ALLOW_FORMULA_BASED_CR_SCALING = FALSE;

// *****************************************
// Overall GP restrictions;
// When set to TRUE, the overall value of an item is restricted 
// to certain gold piece limits you set in the file:
// "fw_inc_item_value_restrictions" for each CR level of a monster.
// When set to TRUE the overall GP restrictions are applied in
// addition to the formula or constant based limitations on
// specific item properties.  
//
// If you set this to FALSE, then there is no limit to the 
// overall value of an item that could drop, but there will still
// be limits on individual item properties.  CR scaling always
// applies (either formula or constant based), but GP restrictions
// on items does not always apply.  You choose to enable it or
// disable gp restrictions. 
//
// If you plan to have item level restrictions in your world,
// then you probably want to leave this set to TRUE.  The reason
// is because if you set this to FALSE, then the random loot
// generator will eventually create an item too high of level
// for any PC to ever wear.  If an item is rolled that is too 
// expensive, the loot generator rerolls a new item, up to a default
// number of times to try to reroll.  If the loot generator still
// can't make an item within GP limits then it exits and just drops
// gold on the monster or in the treasure chest.
//
// I set default values to the overall gp restrictions in the
// file "fw_inc_item_value_restrictions". You can change those
// values to whatever you want. 
//
const int FW_ALLOW_OVERALL_GP_RESTRICTIONS = TRUE;

// *****************************************
// Gold Piece caps for bosses.  After much feedback from the community, 
// some have commented that they always want their bosses to drop loot.
// Others have mentioned they want the boss to be able to drop loot that 
// might be too expensive for the Challenge Rating (CR) of the boss.  So 
// starting in update 2.0 I have added this new switch.  The default is TRUE.
// When set to TRUE, there are no restrictions on how cheap or expensive the
// loot a boss monster can drop.  When set to FALSE, any boss loot will 
// follow the default GP restrictions. 
//
// Don't confuse this with increasing the probability of items appearing on 
// a boss monster. Also, don't confuse this with the probability of the # of
// item properties appearing on boss loot. Those are different things than
// GP restrictions (caps) on the loot.  
//
// For your convenience, I give step by step instructions here on how to 
// set a local variable on a boss so that the random loot generator will
// recognize your boss creatures. 
//
// To set a local varible on your boss creatures, do the following in the 
// toolset.  1) Click on the blueprint of your boss.  2) Open the boss' properties.
// 3) Under the "Scripts" section you will see a field called "Variables".  Click on 
// Variables.  4) To the right of "Variables" you will see three dots "..."  Click on the 
// three dots.  This opens up a new window.  5) Click on "Add".  6) In the "Name" field 
// type in exactly the following:  "FW_BOSS" without the quotation " " marks.
// 7) In the "ValueInt" field change the "0" to a "1"  without the quotation " " marks.
// 8) When you type in the number 1 you should see the "VariableType" automatically
// change to "Integer".  If you do not see it change to "Integer" on its own then you 
// should choose "Integer" manually. 9) Hit the "OK" button and you are done.  Now this
// creature has been identified as a boss creature.
//
const int FW_NO_GP_RESTRICTIONS_ON_BOSS_LOOT = FALSE;

// *****************************************
// If you set the switch below to TRUE, then the type of loot category
// that will appear on a spawning monster is determined by race specific
// loot probability tables in the file "fw_inc_race_prob_tables".
//  
// If you set the switch below to FALSE, then the type of loot category
// that will appear on a spawning monster is determined by the 'default'
// loot category probability table in the file "fw_inc_race_prob_tables"
// (at the very bottom of that file).
// 
const int FW_RACE_SPECIFIC_LOOT_DROPS = TRUE;

// *****************************************
// Random name generator for loot.  The switch below turns on/off the naming
// convention I implemented for the random loot generator.  The default is
// set to TRUE which means that the random loot generator will not only 
// generate items for the monsters, but will also randomly generate a unique
// name for every item.  If you set this to FALSE, the item will just use
// the generic name for every item.  For example, a dagger will just be 
// called "dagger" if you set this to FALSE.  If you leave this switch set
// to TRUE, then the item gets a name.  For example: "The bewildering dagger."
//
const int FW_ALLOW_RANDOM_NAMES_OF_LOOT = TRUE;
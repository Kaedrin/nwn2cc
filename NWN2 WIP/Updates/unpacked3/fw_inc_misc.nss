// *******************************
//
// Created by: Christopher Aulepp
// Date: 12 May 2008
// VERSION 2.0
// contact info: cdaulepp@juno.com
// Copyright 2008 Christopher Aulepp. All rights reserved.
//
// *******************************

/////////////////////////////////////////////
//
//				FILE DESCRIPTION
//
/////////////////////////////////////////////
// This file is new to version 1.2.  I rearranged several things to try
// to be consistent.  There were a couple of constants that didn't quite 
// fit into any of the other script files.  So they ended up here. At the
// very end of this file are the custom data types and global variables
// that the random loot generator uses.  

// *****************************************
//
//
//				UPDATES
//				
//
// *****************************************
// VERSION 2.0
// -12 May 2008.  Added a constant that controls the delay timer for closing
//     placeable objects.  The constant is called: FW_CLOSE_DOOR_TIMER_DELAY
//     and the default is 15 seconds.
//
//     Also added a constant: FW_TREASURE_CHEST_RESPAWN_TIMER and the default
//     is 10 minutes (600 seconds).
//
// -19 April 2008. Added the constant: const int FW_NUMBER_OF_REROLLS = 10;
//     The above constant controls the number of times the loot generator
//     will reroll, if needed.  By default the number of rerolls = 10. There are two times
//     the loot generator might need to reroll.  (1) if the base item is too expensive; or
//     (2) if the item property added to the item makes the item too expensive. 
//
//     An example of number 1 would be: suppose the loot generator rolls a "Lens of
//     Detection" and the monster is a CR 0 monster. That item costs about 15K Gold. 
//     So it would obviously be way too for a CR 0 monster. In this case, the loot generator 
//     destroys the old item and picks a new base item.  It rerolls up to 10 times by default.
//     After 10 rerolls if the base item is still too expensive, then the loot generator 
//     defaults to putting gold on the monster and there are no more rerolls.  
//
//	   An example of number 2 would be: when an item is chosen that can have item properties
//     added to it.  Suppose the loot generator rolls boots and it needs to add at least 1 item
//     property.  Again, we'll suppose a CR 0 monster.  When the loot generator is picking 
//     an item property to add, it might pick something (e.g. haste) that might put the item
//     value over the GP limit for the CR of the monster.  Or the loot generator might pick 
//     something you have disallowed.  In either case, the item property rolled is NOT added
//     but we need to roll a new item property.  The random loot generator rerolls up to 10 
//     times trying to pick an item property that won't put the item value over the limit or
//     to pick an item property that you have allowed.   
//
//
// *****************************************
//
//				CONSTANTS
//
//				YOU CAN CHANGE THESE				
//
// *****************************************

// FW_CLOSE_DOOR_TIMER_DELAY
// When a placeable object is opened, if you use my onOpen script
// called "fw_container_on_open" the placeable object will close itself after
// a delay.  This constant determines how long the container will stay open until 
// it closes itself. Default is 15 seconds.
// Value should be a float (decimal point).
const float FW_CLOSE_DOOR_TIMER_DELAY = 15.0;

// FW_TREASURE_CHEST_RESPAWN_TIMER
// Assuming you use my onOpen script "fw_container_on_open" then there needs
// to be a delay timer that will count down the time until it is safe to 
// possibly spawn new loot in the container.  By having a countdown timer, a
// PC can open and close the placeable many times in a minute, but he won't
// get loot each time.  Instead, new loot won't be able to be spawned into 
// the container until this timer has counted down to zero.  This constant is
// set to 600 seconds by default (10 minutes). 
// Value should be a float (decimal point).
const float FW_TREASURE_CHEST_RESPAWN_TIMER = 600.0;

// NUMBER_OF_REROLLS
// This constant controls how many times the random loot generator will reroll, if needed.
// Occasionally the loot generator will either select a base item that is too expensive, or
// try to put an item property on an item that would make the item too expensive, or the 
// loot generator might have randomly chosen an item property that you have disallowed.
// In all these cases, we need to reroll a new item or a new item property.  This constant
// lets you decide how many times to reroll.  The default is 10 rerolls.  If the loot 
// generator can't pick an acceptable item or item property after rerolling up to FW_NUMBER_OF_REROLLS
// times, then the loot generator defaults back to creating gold on the monster or else not
// adding an item property.  10 rerolls is probably fine by default.  
//
// If you find yourself disallowing more than 60% of the item properties in the file 
// "fw_inc_loot_switches" you may wish to up the number of rerolls to 100 to make sure you
// get an acceptable item property.
//
// Similarly, if you lower the default constants "FW_MAX_ITEM_VALUE_CR_*" in the file
// "fw_inc_item_value_restrictions" to very low values, then you may also wish to up the
// number of rerolls.  The lower you make the limits on the value of an item that can drop,
// the harder time the loot generator will have of finding something within bounds.  Therefore,
// the more chances the loot generator will need to reroll before it can find an acceptably
// low valued item.
//
// The loot generator has had code in it to reroll since version 1.2, but with version 2.0 I 
// decided to give you control of how many rerolls the loot generator will make.  I have had
// absolutely no complaint of lag with the current 10 rerolls.  More than a thousand people
// have downloaded and are using version 1.2 with its 10 rerolls.  I have not tested anything
// above 10, but I am 99.999% sure you can up the number of rerolls to 100 and there will be 
// no difference at all.  
// NOTE: There is no upper limit for the number of rerolls. 
const int FW_NUMBER_OF_REROLLS = 10;


// GOLD_AWARDED
// I should explain how I determine how much gold drops. First, you must understand
// a monster won't always drop gold.  The only way he drops gold is if
// the gold category was rolled by the random loot generator.  If gold 
// was the category chosen, then we have to decide how many GP the monster
// will drop. I use a formula to determine this, so that the amount 
// dropped will scale as the monsters get more and more powerful 
// throughout the game.  
//
// The random loot generator will roll a number between a lower and
// upper limit. These limits are defined using the default formula and
// the gold modifier constants below.  
// The default formula for max is: (CR * FW_MAX_GOLD_MODIFIER)
// The default formula for min is: (CR * FW_MIN_GOLD_MODIFIER)
// Once a max and min have been chosen, the random generator rolls a
// number between these two values. 
//
// Finally, the number chosen is checked against the module minimum
// and maximum amounts to make sure we didn't accidentally go too 
// high or low.  
//
// Example 1: A CR level 10 monster dies.  The maximum amount of gold
// 		he could drop is: (CR * Modifier) or (10 * 5.0) = 50 gold. The
//		minimum amount is: (CR * Modifier) or (10 * 2.5) = 25 gold. 
//      The random loot generator then rolls a number between 25 and
//		50 and this is how many GP the monster will drop.  Let's say the
//		random generator rolled 34 gold.
//
//		As long as 34 gold is more than the module minimum per kill and 
//		less than the module maximum per kill, then he'll drop 34 gold.
//	    If 34 gold isn't within the module limits then it is lowered or
//		raised to fit within the module limits.
//
// 34 gold probably isn't an amount that most worlds would consider too
// much for a kill.  But as the monsters get tougher and tougher the 
// amount of gold they could drop goes up with their CR. This creates a
// potential problem if there wasn't a way to cap very high amounts (or
// also to cap very low amounts). Imagine a level 40 CR monster dies.
// Using the min and max MODIFIERs this monster could possibly drop 100-200 gold. 
// This could be an amount that some worlds want to disallow.
// That's why I have included a minimum and maximum module limit constant.
// You could keep the modifier at 5.0 if you want (or change it), but cap the 
// amount of gold at some level you feel is appropriate by setting module
// limits.  
//
// Basically the gold modifiers set the range the random loot generator
// will select from, but then the number chosen is subject to the module
// limits. As far as I know, there is no hard coded upper limit.
// NOTE: These are float values (include a decimal)  
const float FW_MAX_GOLD_MODIFIER = 10.0;
const float FW_MIN_GOLD_MODIFIER = 3.0;

// Module Limits per monster kill as explained above.
// NOTE: These are integer values (no decimal)
const int FW_MIN_MODULE_GOLD = 1;
const int FW_MAX_MODULE_GOLD = 500;

// *DAMAGE SHIELDS*  Damage shields already in existence in the game are:
// Elemental Shield (spell) and Death Armor (spell).  As part of the random loot
// generation system, I've made it possible to have damage shields of other types
// of damage besides just fire and sonic appear on an item.  Do not confuse with
// IP CONST Damage Bonus. Not the same thing.
// Setting min and max switches (see below) for damage shield bonuses requires
// a bit of explaining. I have ranked all the damage bonuses a damage shield
// can have in ascending order based off of the average damage dealt by each
// damage_bonus_* constant. In cases where the average was a tie (i.e. 7 dmg
// and 2d6 dmg both average 7 dmg) I gave a higher ranking to the random amount
// because it can potentially roll much higher. By default I have the damage
// bonus constants set to min=0 and max=49.  This allows any amount of damage
// ranging from index 0 (measly +1 dmg.) up to and including index 49 (a whopping
// +40 dmg.) By changing the values of the constants you can specify the range
// of values you want to allow / disallow as possibilities. Here's a couple
// examples to show you what I mean.
//
// Example 1: You set FW_MIN_DAMAGE_SHIELD_BONUS = 5;
//    and you set     FW_MAX_DAMAGE_SHIELD_BONUS = 8;
//    Possibilities are now from index 5 to 8, or: +4, +1d8, +5, or +2d4 damage.
//
// Example 2: You set FW_MIN_DAMAGE_SHIELD_BONUS = 3
//    and you set     FW_MAX_DAMAGE_SHIELD_BONUS = 8.
//    Possibilites are from index 3 to 8, or: +3, +1d6, +4, +1d8, +5, or +2d4
//    damage.
//
// Note: It's okay to set min = max.  There just wouldn't be any randomness
//    if you do that.
//
// TABLE: DAMAGE_BONUS  (Used only for Damage Shields)
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
//   18  = 11   damage  ...avg = 11
//   19  = 2d10 damage  ...avg = 11
//   20  = 12   damage  ...avg = 12
//   21  = 13   damage  ...avg = 13
//   22  = 2d12 damage  ...avg = 13
//   23  = 14   damage  ...avg = 14
//   24  = 15   damage  ...avg = 15
//   25  = 16   damage  ...avg = 16
//   26  = 17   damage  ...avg = 17
//   27  = 18   damage  ...avg = 18
//   28  = 19   damage  ...avg = 19
//   29  = 20   damage  ...avg = 20
//   30  = 21   damage  ...avg = 21
//   31  = 22   damage  ...avg = 22
//   32  = 23   damage  ...avg = 23
//   33  = 24   damage  ...avg = 24
//   34  = 25   damage  ...avg = 25
//   35  = 26   damage  ...avg = 26
//   36  = 27   damage  ...avg = 27
//   37  = 28   damage  ...avg = 28
//   38  = 29   damage  ...avg = 29
//   39  = 30   damage  ...avg = 30
//   40  = 31   damage  ...avg = 31
//   41  = 32   damage  ...avg = 32
//   42  = 33   damage  ...avg = 33
//   43  = 34   damage  ...avg = 34
//   44  = 35   damage  ...avg = 35
//   45  = 36   damage  ...avg = 36
//   46  = 37   damage  ...avg = 37
//   47  = 38   damage  ...avg = 38
//   48  = 39   damage  ...avg = 39
//   49  = 40   damage  ...avg = 40
//
// INDEX = ITEM_PROPERTY...AVERAGE DAMAGE
//
// - The above table is used ONLY for Damage Shields.
//
// - There is no need to have minimum and maximum values for every CR
//   because the formula that calculates damage shield power doesn't 
//   use monster CR as a variable.  Instead, it uses the PC level.  And
//   the formula I wrote automatically scales with the PC's level. So
//   that's why you only see 2 constants here instead of seeing 42.
//
// The minimum and maximum damage shield bonus.  See explanation and table above.
// Acceptable values range from 0 to 49.  0,1,2,3,...,49
const int FW_MIN_DAMAGE_SHIELD_BONUS = 0;
const int FW_MAX_DAMAGE_SHIELD_BONUS = 2;

// The minimum and maximum damage shield bonus time length (in seconds). As far
// as I know there is no limit for the maximum amount of time.  I suggest a
// minimum of 60 seconds.  Must be any positive integer.
// This is the amount of time the damage shield will last before it 
// expires.  It is only useable once per day. That info. may help you
// in determining how long you want the damage shield to last.
const int FW_MIN_DAMAGE_SHIELD_LENGTH_TIME = 60;   // 1 minute by default.
const int FW_MAX_DAMAGE_SHIELD_LENGTH_TIME = 600;  // 10 minutes by default.

// *****************************************
//
//              GLOBAL VARIABLES
//
// 		DON'T CHANGE THESE EVER OR YOU COULD
//  	BREAK THE LOOT GENERATION SYSTEM
//
//
// *****************************************
const int FW_ARMOR_BOOT = 0;
const int FW_ARMOR_CLOTHING = 1;
const int FW_ARMOR_HEAVY = 2;
const int FW_ARMOR_HELMET = 3;
const int FW_ARMOR_LIGHT = 4;
const int FW_ARMOR_MEDIUM = 5;
const int FW_ARMOR_SHIELDS = 6;
const int FW_WEAPON_AMMUNITION = 7;
const int FW_WEAPON_SIMPLE = 8;
const int FW_WEAPON_MARTIAL = 9;
const int FW_WEAPON_EXOTIC = 10;
const int FW_WEAPON_MAGE_SPECIFIC = 11;
const int FW_WEAPON_RANGED = 12;
const int FW_WEAPON_THROWN = 13;
const int FW_MISC_CLOTHING = 14;
const int FW_MISC_JEWELRY = 15;
const int FW_MISC_GAUNTLET = 16;
const int FW_MISC_POTION = 17;
const int FW_MISC_TRAPS = 18;
const int FW_MISC_BOOKS = 19;
const int FW_MISC_GOLD = 20;
const int FW_MISC_GEMS = 21;
const int FW_MISC_HEAL_KIT = 22;
const int FW_MISC_SCROLL = 23;
const int FW_MISC_CRAFTING_MATERIAL = 24;
const int FW_MISC_OTHER = 25;
const int FW_MISC_DAMAGE_SHIELD = 26;
const int FW_MISC_CUSTOM_ITEM = 27;
const int FW_MISC_RECIPE = 28;

const int FW_MATERIAL_NON_SPECIFIC = 1;
const int FW_MATERIAL_ADAMANTINE = 2;
const int FW_MATERIAL_ALCHEMICAL_SILVER = 3; 
const int FW_MATERIAL_COLD_IRON = 4;
const int FW_MATERIAL_DARK_STEEL =5;
const int FW_MATERIAL_DUSKWOOD = 6;
const int FW_MATERIAL_IRON = 7;
const int FW_MATERIAL_MITHRAL = 8;
const int FW_MATERIAL_ZALANTAR = 9;

const int FW_ARMOR_HEAVY_BANDED = 1 ;
const int FW_ARMOR_HEAVY_FULLPLATE = 2;
const int FW_ARMOR_HEAVY_HALFPLATE = 3;
const int FW_ARMOR_LIGHT_CHAINSHIRT = 4;
const int FW_ARMOR_MEDIUM_SCALEMAIL = 5;
const int FW_ARMOR_MEDIUM_CHAINMAIL = 6;
const int FW_ARMOR_MEDIUM_BREASTPLATE = 7;
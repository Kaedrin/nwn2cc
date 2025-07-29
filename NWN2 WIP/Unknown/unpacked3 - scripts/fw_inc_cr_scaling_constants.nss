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
//
//
//			UPDATES
//
//////////////////////////////////////////////
// VERSION 1.2
// -renamed this file to be consistent with naming conventions
//
//
//////////////////////////////////////////////
//
//
//			DESCRIPTION OF FILE
//
/////////////////////////////////////////////
// I apologize for the length of this file.  You can leave this file alone
// if you want and I have already set up default values.  However, to give
// you complete control, I had to account for every CR range inside of every
// single item property. This necessarily enlarged this file to be rather 
// long. The good thing is, you should only have to go through this file one
// time.  Warning: Because the default values for these constants allows for
// any item property that is possible, you will get some weird results
// unless you go through and edit this file.  OR you can ignore this file
// if you are using formula based cr scaling of your loot.  The switch
// that turns on formula based cr scaling is in the file: "fw_inc_loot_switches"
// 
// This whole file is where you set the ranges for what item properties can appear
// on an item.  You are able to set the range for every CR value. In this way, you
// can limit lower level monsters from dropping super uber gear.  Similarly, you 
// can limit high level monsters from dropping junk.  
//
// When a monster spawns, loot is created and put in the monster's inventory.  This
// treasure will be dropped by the monster when it dies (or if it is pick pocketed).
//  
// The preset values in these constants allow ALL item property values to appear on
// an item, irregardless of how strong or weak a monster is.  Which means, a level 3 
// CR goblin could drop up to a +20 attack bonus weapon.  For most people you probably
// don't want that to happen in your wrld, so you'll need to go through this file at least
// one time and set these constants to the range of values you want for each CR value.  

// I'm going to give one example to show what a modified table might look like
//
// 		EXAMPLE 1: A modified ATTACK BONUS table.
// 
// The minimum and maximum ATTACK_BONUS values an item could have (for every CR value)
// Acceptable values: 1,2,3,...,20
/*
const int FW_MIN_ATTACK_BONUS_CR_0 = 1; const int FW_MAX_ATTACK_BONUS_CR_0 = 1;

const int FW_MIN_ATTACK_BONUS_CR_1 = 1; const int FW_MAX_ATTACK_BONUS_CR_1 = 1;
const int FW_MIN_ATTACK_BONUS_CR_2 = 1; const int FW_MAX_ATTACK_BONUS_CR_2 = 1;
const int FW_MIN_ATTACK_BONUS_CR_3 = 1; const int FW_MAX_ATTACK_BONUS_CR_3 = 1;
const int FW_MIN_ATTACK_BONUS_CR_4 = 1; const int FW_MAX_ATTACK_BONUS_CR_4 = 1;
const int FW_MIN_ATTACK_BONUS_CR_5 = 1; const int FW_MAX_ATTACK_BONUS_CR_5 = 2;
const int FW_MIN_ATTACK_BONUS_CR_6 = 1; const int FW_MAX_ATTACK_BONUS_CR_6 = 2;
const int FW_MIN_ATTACK_BONUS_CR_7 = 1; const int FW_MAX_ATTACK_BONUS_CR_7 = 2;
const int FW_MIN_ATTACK_BONUS_CR_8 = 1; const int FW_MAX_ATTACK_BONUS_CR_8 = 2;
const int FW_MIN_ATTACK_BONUS_CR_9 = 1; const int FW_MAX_ATTACK_BONUS_CR_9 = 3;
const int FW_MIN_ATTACK_BONUS_CR_10 = 1; const int FW_MAX_ATTACK_BONUS_CR_10 = 3;

const int FW_MIN_ATTACK_BONUS_CR_11 = 1; const int FW_MAX_ATTACK_BONUS_CR_11 = 3;
const int FW_MIN_ATTACK_BONUS_CR_12 = 1; const int FW_MAX_ATTACK_BONUS_CR_12 = 3;
const int FW_MIN_ATTACK_BONUS_CR_13 = 2; const int FW_MAX_ATTACK_BONUS_CR_13 = 4;
const int FW_MIN_ATTACK_BONUS_CR_14 = 2; const int FW_MAX_ATTACK_BONUS_CR_14 = 4;
const int FW_MIN_ATTACK_BONUS_CR_15 = 2; const int FW_MAX_ATTACK_BONUS_CR_15 = 4;
const int FW_MIN_ATTACK_BONUS_CR_16 = 2; const int FW_MAX_ATTACK_BONUS_CR_16 = 4;
const int FW_MIN_ATTACK_BONUS_CR_17 = 3; const int FW_MAX_ATTACK_BONUS_CR_17 = 5;
const int FW_MIN_ATTACK_BONUS_CR_18 = 3; const int FW_MAX_ATTACK_BONUS_CR_18 = 5;
const int FW_MIN_ATTACK_BONUS_CR_19 = 3; const int FW_MAX_ATTACK_BONUS_CR_19 = 5;
const int FW_MIN_ATTACK_BONUS_CR_20 = 3; const int FW_MAX_ATTACK_BONUS_CR_20 = 5;

const int FW_MIN_ATTACK_BONUS_CR_21 = 4; const int FW_MAX_ATTACK_BONUS_CR_21 = 6;
const int FW_MIN_ATTACK_BONUS_CR_22 = 4; const int FW_MAX_ATTACK_BONUS_CR_22 = 6;
const int FW_MIN_ATTACK_BONUS_CR_23 = 4; const int FW_MAX_ATTACK_BONUS_CR_23 = 6;
const int FW_MIN_ATTACK_BONUS_CR_24 = 4; const int FW_MAX_ATTACK_BONUS_CR_24 = 6;
const int FW_MIN_ATTACK_BONUS_CR_25 = 5; const int FW_MAX_ATTACK_BONUS_CR_25 = 7;
const int FW_MIN_ATTACK_BONUS_CR_26 = 5; const int FW_MAX_ATTACK_BONUS_CR_26 = 7;
const int FW_MIN_ATTACK_BONUS_CR_27 = 5; const int FW_MAX_ATTACK_BONUS_CR_27 = 7;
const int FW_MIN_ATTACK_BONUS_CR_28 = 5; const int FW_MAX_ATTACK_BONUS_CR_28 = 7;
const int FW_MIN_ATTACK_BONUS_CR_29 = 6; const int FW_MAX_ATTACK_BONUS_CR_29 = 8;
const int FW_MIN_ATTACK_BONUS_CR_30 = 6; const int FW_MAX_ATTACK_BONUS_CR_30 = 8;

const int FW_MIN_ATTACK_BONUS_CR_31 = 6; const int FW_MAX_ATTACK_BONUS_CR_31 = 8;
const int FW_MIN_ATTACK_BONUS_CR_32 = 6; const int FW_MAX_ATTACK_BONUS_CR_32 = 8;
const int FW_MIN_ATTACK_BONUS_CR_33 = 7; const int FW_MAX_ATTACK_BONUS_CR_33 = 9;
const int FW_MIN_ATTACK_BONUS_CR_34 = 7; const int FW_MAX_ATTACK_BONUS_CR_34 = 9;
const int FW_MIN_ATTACK_BONUS_CR_35 = 7; const int FW_MAX_ATTACK_BONUS_CR_35 = 9;
const int FW_MIN_ATTACK_BONUS_CR_36 = 7; const int FW_MAX_ATTACK_BONUS_CR_36 = 9;
const int FW_MIN_ATTACK_BONUS_CR_37 = 8; const int FW_MAX_ATTACK_BONUS_CR_37 = 1;
const int FW_MIN_ATTACK_BONUS_CR_38 = 8; const int FW_MAX_ATTACK_BONUS_CR_38 = 10;
const int FW_MIN_ATTACK_BONUS_CR_39 = 8; const int FW_MAX_ATTACK_BONUS_CR_39 = 10;
const int FW_MIN_ATTACK_BONUS_CR_40 = 8; const int FW_MAX_ATTACK_BONUS_CR_40 = 10;

const int FW_MIN_ATTACK_BONUS_CR_41_OR_HIGHER = 8; const int FW_MAX_ATTACK_BONUS_CR_41_OR_HIGHER = 10;
*/

// Example 1 explained: 
//
// For CR monsters 0,1,2,3,4  I limited the min and max values to 1.  This means
// that if attack bonus is randomly chosen as the item property to add to a weapon
// then for these CR monsters there is only one option, +1, and that is what would
// get added.
//   
// For CR monsters 5,6,7,8 I limited the min to 1 and max value to 2. This means
// that if attack bonus is randomly chosen as the item property to add to a weapon
// then for these CR monsters it could be a +1 or a +2 attack bonus.  
// 
// For CR monsters 9,10,11,12 I limited the min to 1 and max value to 3. This means
// that if attack bonus is randomly chosen as the item property to add to a weapon
// then for these CR monsters it could be a +1, +2, or +3 attack bonus.
//
// Notice that for CR monsters 13,14,15,16 I raised the minimum to 2.  The max was
// also raised to 4.  If attack bonus is chosen as the random property to
// add to an item, the lowest attack bonus these monsters could have is +2.
// The highest attack bonus they would have on their loot is +4.  (they could also
// have +3).  In this way, you set the range for every CR of monster, up to level 41
//
// The rest of the example is the same as above.  CR monsters 17,18,19,20 can drop
// +3, +4, or +5 attack bonus weapons.  But they can't drop a +1 or +2 weapon because
// in the example I set the minimum at 3 for these CR.  Got it?  I hope so.
//
// You're on your own from here on.  Set ranges to what you want.  By default
// the min value allows the lowest amount possible and by default the max allows
// the highest amount possible. 
//
// Each category of item property in this file only comes into play if the switch
// that allows them was set to TRUE in the file "fw_inc_loot_switches".  If you set 
// something to FALSE in "fw_inc_loot_switches" then it doesn't matter what the 
// corresponding item property constant values are in this file.  

// ABILITY BONUS
// The minimum and maximum Ability Bonus an item could have (for each CR level).
// Acceptable values: 1,2,3,...,12
const int FW_MIN_ABILITY_BONUS_CR_0 = 1; const int FW_MAX_ABILITY_BONUS_CR_0 = 1;

const int FW_MIN_ABILITY_BONUS_CR_1 = 1; const int FW_MAX_ABILITY_BONUS_CR_1 = 1;
const int FW_MIN_ABILITY_BONUS_CR_2 = 1; const int FW_MAX_ABILITY_BONUS_CR_2 = 1;
const int FW_MIN_ABILITY_BONUS_CR_3 = 1; const int FW_MAX_ABILITY_BONUS_CR_3 = 1;
const int FW_MIN_ABILITY_BONUS_CR_4 = 1; const int FW_MAX_ABILITY_BONUS_CR_4 = 1;
const int FW_MIN_ABILITY_BONUS_CR_5 = 1; const int FW_MAX_ABILITY_BONUS_CR_5 = 1;
const int FW_MIN_ABILITY_BONUS_CR_6 = 1; const int FW_MAX_ABILITY_BONUS_CR_6 = 1;
const int FW_MIN_ABILITY_BONUS_CR_7 = 1; const int FW_MAX_ABILITY_BONUS_CR_7 = 1;
const int FW_MIN_ABILITY_BONUS_CR_8 = 1; const int FW_MAX_ABILITY_BONUS_CR_8 = 1;
const int FW_MIN_ABILITY_BONUS_CR_9 = 1; const int FW_MAX_ABILITY_BONUS_CR_9 = 1;
const int FW_MIN_ABILITY_BONUS_CR_10 = 1; const int FW_MAX_ABILITY_BONUS_CR_10 = 1;

const int FW_MIN_ABILITY_BONUS_CR_11 = 1; const int FW_MAX_ABILITY_BONUS_CR_11 = 2;
const int FW_MIN_ABILITY_BONUS_CR_12 = 1; const int FW_MAX_ABILITY_BONUS_CR_12 = 2;
const int FW_MIN_ABILITY_BONUS_CR_13 = 1; const int FW_MAX_ABILITY_BONUS_CR_13 = 2;
const int FW_MIN_ABILITY_BONUS_CR_14 = 1; const int FW_MAX_ABILITY_BONUS_CR_14 = 2;
const int FW_MIN_ABILITY_BONUS_CR_15 = 1; const int FW_MAX_ABILITY_BONUS_CR_15 = 2;
const int FW_MIN_ABILITY_BONUS_CR_16 = 1; const int FW_MAX_ABILITY_BONUS_CR_16 = 2;
const int FW_MIN_ABILITY_BONUS_CR_17 = 1; const int FW_MAX_ABILITY_BONUS_CR_17 = 2;
const int FW_MIN_ABILITY_BONUS_CR_18 = 1; const int FW_MAX_ABILITY_BONUS_CR_18 = 2;
const int FW_MIN_ABILITY_BONUS_CR_19 = 1; const int FW_MAX_ABILITY_BONUS_CR_19 = 2;
const int FW_MIN_ABILITY_BONUS_CR_20 = 1; const int FW_MAX_ABILITY_BONUS_CR_20 = 2;

const int FW_MIN_ABILITY_BONUS_CR_21 = 1; const int FW_MAX_ABILITY_BONUS_CR_21 = 2;
const int FW_MIN_ABILITY_BONUS_CR_22 = 1; const int FW_MAX_ABILITY_BONUS_CR_22 = 2;
const int FW_MIN_ABILITY_BONUS_CR_23 = 1; const int FW_MAX_ABILITY_BONUS_CR_23 = 2;
const int FW_MIN_ABILITY_BONUS_CR_24 = 1; const int FW_MAX_ABILITY_BONUS_CR_24 = 2;
const int FW_MIN_ABILITY_BONUS_CR_25 = 1; const int FW_MAX_ABILITY_BONUS_CR_25 = 2;
const int FW_MIN_ABILITY_BONUS_CR_26 = 1; const int FW_MAX_ABILITY_BONUS_CR_26 = 2;
const int FW_MIN_ABILITY_BONUS_CR_27 = 1; const int FW_MAX_ABILITY_BONUS_CR_27 = 2;
const int FW_MIN_ABILITY_BONUS_CR_28 = 1; const int FW_MAX_ABILITY_BONUS_CR_28 = 2;
const int FW_MIN_ABILITY_BONUS_CR_29 = 1; const int FW_MAX_ABILITY_BONUS_CR_29 = 2;
const int FW_MIN_ABILITY_BONUS_CR_30 = 1; const int FW_MAX_ABILITY_BONUS_CR_30 = 2;

const int FW_MIN_ABILITY_BONUS_CR_31 = 1; const int FW_MAX_ABILITY_BONUS_CR_31 = 2;
const int FW_MIN_ABILITY_BONUS_CR_32 = 1; const int FW_MAX_ABILITY_BONUS_CR_32 = 2;
const int FW_MIN_ABILITY_BONUS_CR_33 = 1; const int FW_MAX_ABILITY_BONUS_CR_33 = 2;
const int FW_MIN_ABILITY_BONUS_CR_34 = 1; const int FW_MAX_ABILITY_BONUS_CR_34 = 2;
const int FW_MIN_ABILITY_BONUS_CR_35 = 1; const int FW_MAX_ABILITY_BONUS_CR_35 = 2;
const int FW_MIN_ABILITY_BONUS_CR_36 = 1; const int FW_MAX_ABILITY_BONUS_CR_36 = 2;
const int FW_MIN_ABILITY_BONUS_CR_37 = 1; const int FW_MAX_ABILITY_BONUS_CR_37 = 2;
const int FW_MIN_ABILITY_BONUS_CR_38 = 1; const int FW_MAX_ABILITY_BONUS_CR_38 = 2;
const int FW_MIN_ABILITY_BONUS_CR_39 = 1; const int FW_MAX_ABILITY_BONUS_CR_39 = 2;
const int FW_MIN_ABILITY_BONUS_CR_40 = 1; const int FW_MAX_ABILITY_BONUS_CR_40 = 2;

const int FW_MIN_ABILITY_BONUS_CR_41_OR_HIGHER = 1; const int FW_MAX_ABILITY_BONUS_CR_41_OR_HIGHER = 2;

// AC BONUS
// The minimum and maximum AC Bonus values an item could have (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_AC_BONUS_CR_0 = 1; const int FW_MAX_AC_BONUS_CR_0 = 1;

const int FW_MIN_AC_BONUS_CR_1 = 1; const int FW_MAX_AC_BONUS_CR_1 = 1;
const int FW_MIN_AC_BONUS_CR_2 = 1; const int FW_MAX_AC_BONUS_CR_2 = 1;
const int FW_MIN_AC_BONUS_CR_3 = 1; const int FW_MAX_AC_BONUS_CR_3 = 1;
const int FW_MIN_AC_BONUS_CR_4 = 1; const int FW_MAX_AC_BONUS_CR_4 = 1;
const int FW_MIN_AC_BONUS_CR_5 = 1; const int FW_MAX_AC_BONUS_CR_5 = 1;
const int FW_MIN_AC_BONUS_CR_6 = 1; const int FW_MAX_AC_BONUS_CR_6 = 1;
const int FW_MIN_AC_BONUS_CR_7 = 1; const int FW_MAX_AC_BONUS_CR_7 = 1;
const int FW_MIN_AC_BONUS_CR_8 = 1; const int FW_MAX_AC_BONUS_CR_8 = 1;
const int FW_MIN_AC_BONUS_CR_9 = 1; const int FW_MAX_AC_BONUS_CR_9 = 1;
const int FW_MIN_AC_BONUS_CR_10 = 1; const int FW_MAX_AC_BONUS_CR_10 = 1;

const int FW_MIN_AC_BONUS_CR_11 = 1; const int FW_MAX_AC_BONUS_CR_11 = 1;
const int FW_MIN_AC_BONUS_CR_12 = 1; const int FW_MAX_AC_BONUS_CR_12 = 1;
const int FW_MIN_AC_BONUS_CR_13 = 1; const int FW_MAX_AC_BONUS_CR_13 = 2;
const int FW_MIN_AC_BONUS_CR_14 = 1; const int FW_MAX_AC_BONUS_CR_14 = 2;
const int FW_MIN_AC_BONUS_CR_15 = 1; const int FW_MAX_AC_BONUS_CR_15 = 2;
const int FW_MIN_AC_BONUS_CR_16 = 1; const int FW_MAX_AC_BONUS_CR_16 = 2;
const int FW_MIN_AC_BONUS_CR_17 = 1; const int FW_MAX_AC_BONUS_CR_17 = 2;
const int FW_MIN_AC_BONUS_CR_18 = 1; const int FW_MAX_AC_BONUS_CR_18 = 2;
const int FW_MIN_AC_BONUS_CR_19 = 1; const int FW_MAX_AC_BONUS_CR_19 = 2;
const int FW_MIN_AC_BONUS_CR_20 = 1; const int FW_MAX_AC_BONUS_CR_20 = 2;

const int FW_MIN_AC_BONUS_CR_21 = 1; const int FW_MAX_AC_BONUS_CR_21 = 2;
const int FW_MIN_AC_BONUS_CR_22 = 1; const int FW_MAX_AC_BONUS_CR_22 = 2;
const int FW_MIN_AC_BONUS_CR_23 = 1; const int FW_MAX_AC_BONUS_CR_23 = 2;
const int FW_MIN_AC_BONUS_CR_24 = 1; const int FW_MAX_AC_BONUS_CR_24 = 2;
const int FW_MIN_AC_BONUS_CR_25 = 1; const int FW_MAX_AC_BONUS_CR_25 = 2;
const int FW_MIN_AC_BONUS_CR_26 = 1; const int FW_MAX_AC_BONUS_CR_26 = 2;
const int FW_MIN_AC_BONUS_CR_27 = 1; const int FW_MAX_AC_BONUS_CR_27 = 2;
const int FW_MIN_AC_BONUS_CR_28 = 1; const int FW_MAX_AC_BONUS_CR_28 = 2;
const int FW_MIN_AC_BONUS_CR_29 = 1; const int FW_MAX_AC_BONUS_CR_29 = 2;
const int FW_MIN_AC_BONUS_CR_30 = 1; const int FW_MAX_AC_BONUS_CR_30 = 2;

const int FW_MIN_AC_BONUS_CR_31 = 1; const int FW_MAX_AC_BONUS_CR_31 = 2;
const int FW_MIN_AC_BONUS_CR_32 = 1; const int FW_MAX_AC_BONUS_CR_32 = 2;
const int FW_MIN_AC_BONUS_CR_33 = 1; const int FW_MAX_AC_BONUS_CR_33 = 2;
const int FW_MIN_AC_BONUS_CR_34 = 1; const int FW_MAX_AC_BONUS_CR_34 = 2;
const int FW_MIN_AC_BONUS_CR_35 = 1; const int FW_MAX_AC_BONUS_CR_35 = 2;
const int FW_MIN_AC_BONUS_CR_36 = 1; const int FW_MAX_AC_BONUS_CR_36 = 2;
const int FW_MIN_AC_BONUS_CR_37 = 1; const int FW_MAX_AC_BONUS_CR_37 = 2;
const int FW_MIN_AC_BONUS_CR_38 = 1; const int FW_MAX_AC_BONUS_CR_38 = 2;
const int FW_MIN_AC_BONUS_CR_39 = 1; const int FW_MAX_AC_BONUS_CR_39 = 2;
const int FW_MIN_AC_BONUS_CR_40 = 1; const int FW_MAX_AC_BONUS_CR_40 = 2;

const int FW_MIN_AC_BONUS_CR_41_OR_HIGHER = 1; const int FW_MAX_AC_BONUS_CR_41_OR_HIGHER = 2;

// AC BONUS VS. ALIGN GROUP
// The minimum and maximum AC Bonus vs. Align GROUP values an item could
// have (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_0 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_0 = 2;

const int FW_MIN_AC_BONUS_VS_ALIGN_CR_1 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_1 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_2 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_2 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_3 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_3 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_4 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_4 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_5 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_5 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_6 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_6 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_7 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_7 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_8 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_8 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_9 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_9 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_10 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_10 = 2;

const int FW_MIN_AC_BONUS_VS_ALIGN_CR_11 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_11 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_12 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_12 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_13 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_13 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_14 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_14 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_15 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_15 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_16 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_16 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_17 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_17 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_18 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_18 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_19 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_19 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_20 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_20 = 2;

const int FW_MIN_AC_BONUS_VS_ALIGN_CR_21 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_21 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_22 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_22 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_23 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_23 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_24 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_24 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_25 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_25 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_26 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_26 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_27 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_27 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_28 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_28 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_29 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_29 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_30 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_30 = 2;

const int FW_MIN_AC_BONUS_VS_ALIGN_CR_31 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_31 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_32 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_32 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_33 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_33 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_34 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_34 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_35 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_35 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_36 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_36 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_37 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_37 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_38 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_38 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_39 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_39 = 2;
const int FW_MIN_AC_BONUS_VS_ALIGN_CR_40 = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_40 = 2;

const int FW_MIN_AC_BONUS_VS_ALIGN_CR_41_OR_HIGHER = 1; const int FW_MAX_AC_BONUS_VS_ALIGN_CR_41_OR_HIGHER = 2;

// AC BONUS VS DAMAGE TYPE
// The minimum and maximum AC Bonus Vs. Damage Type values an item could
// have (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_0 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_0 = 2;

const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_1 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_1 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_2 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_2 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_3 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_3 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_4 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_4 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_5 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_5 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_6 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_6 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_7 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_7 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_8 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_8 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_9 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_9 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_10 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_10 = 2;

const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_11 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_11 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_12 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_12 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_13 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_13 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_14 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_14 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_15 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_15 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_16 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_16 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_17 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_17 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_18 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_18 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_19 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_19 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_20 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_20 = 2;

const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_21 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_21 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_22 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_22 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_23 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_23 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_24 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_24 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_25 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_25 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_26 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_26 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_27 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_27 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_28 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_28 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_29 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_29 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_30 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_30 = 2;

const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_31 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_31 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_32 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_32 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_33 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_33 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_34 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_34 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_35 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_35 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_36 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_36 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_37 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_37 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_38 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_38 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_39 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_39 = 2;
const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_40 = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_40 = 2;

const int FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_41_OR_HIGHER = 1; const int FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_41_OR_HIGHER = 2;

// AC BONUS VS RACE
// The minimum and maximum AC Bonus Vs. Race values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_AC_BONUS_VS_RACE_CR_0 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_0 = 2;

const int FW_MIN_AC_BONUS_VS_RACE_CR_1 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_1 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_2 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_2 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_3 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_3 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_4 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_4 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_5 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_5 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_6 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_6 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_7 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_7 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_8 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_8 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_9 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_9 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_10 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_10 = 2;

const int FW_MIN_AC_BONUS_VS_RACE_CR_11 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_11 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_12 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_12 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_13 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_13 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_14 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_14 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_15 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_15 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_16 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_16 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_17 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_17 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_18 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_18 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_19 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_19 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_20 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_20 = 2;

const int FW_MIN_AC_BONUS_VS_RACE_CR_21 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_21 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_22 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_22 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_23 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_23 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_24 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_24 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_25 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_25 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_26 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_26 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_27 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_27 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_28 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_28 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_29 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_29 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_30 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_30 = 2;

const int FW_MIN_AC_BONUS_VS_RACE_CR_31 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_31 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_32 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_32 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_33 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_33 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_34 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_34 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_35 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_35 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_36 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_36 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_37 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_37 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_38 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_38 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_39 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_39 = 2;
const int FW_MIN_AC_BONUS_VS_RACE_CR_40 = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_40 = 2;

const int FW_MIN_AC_BONUS_VS_RACE_CR_41_OR_HIGHER = 1; const int FW_MAX_AC_BONUS_VS_RACE_CR_41_OR_HIGHER = 2;

// AC BONUS VS SPECIFIC ALIGNMENT
// The minimum and maximum AC Bonus Vs Specific Alignment values an item
// could have (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_0 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_0 = 2;

const int FW_MIN_AC_BONUS_VS_SALIGN_CR_1 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_1 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_2 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_2 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_3 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_3 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_4 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_4 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_5 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_5 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_6 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_6 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_7 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_7 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_8 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_8 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_9 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_9 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_10 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_10 = 2;

const int FW_MIN_AC_BONUS_VS_SALIGN_CR_11 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_11 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_12 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_12 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_13 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_13 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_14 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_14 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_15 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_15 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_16 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_16 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_17 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_17 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_18 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_18 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_19 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_19 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_20 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_20 = 2;

const int FW_MIN_AC_BONUS_VS_SALIGN_CR_21 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_21 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_22 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_22 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_23 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_23 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_24 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_24 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_25 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_25 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_26 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_26 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_27 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_27 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_28 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_28 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_29 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_29 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_30 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_30 = 2;

const int FW_MIN_AC_BONUS_VS_SALIGN_CR_31 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_31 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_32 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_32 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_33 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_33 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_34 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_34 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_35 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_35 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_36 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_36 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_37 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_37 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_38 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_38 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_39 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_39 = 2;
const int FW_MIN_AC_BONUS_VS_SALIGN_CR_40 = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_40 = 2;

const int FW_MIN_AC_BONUS_VS_SALIGN_CR_41_OR_HIGHER = 1; const int FW_MAX_AC_BONUS_VS_SALIGN_CR_41_OR_HIGHER = 2;

// ARCANE SPELL FAILURE
// There is no min/max switch to limit arcane spell failure.  To change what 
// can or can't appear on items for this item property, you need to go into the
// function FW_Choose_IP_Arcane_Spell_Failure and comment out the case 
// statements that you don't want to appear. By default, all types (both 
// positive and negative) arcane spell failure can appear on an item. Only
// an experienced scripter should modify the function.

// ATTACK BONUS
// The minimum and maximum Attack Bonus values an item could have (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_ATTACK_BONUS_CR_0 = 1; const int FW_MAX_ATTACK_BONUS_CR_0 = 2;

const int FW_MIN_ATTACK_BONUS_CR_1 = 1; const int FW_MAX_ATTACK_BONUS_CR_1 = 2;
const int FW_MIN_ATTACK_BONUS_CR_2 = 1; const int FW_MAX_ATTACK_BONUS_CR_2 = 2;
const int FW_MIN_ATTACK_BONUS_CR_3 = 1; const int FW_MAX_ATTACK_BONUS_CR_3 = 2;
const int FW_MIN_ATTACK_BONUS_CR_4 = 1; const int FW_MAX_ATTACK_BONUS_CR_4 = 2;
const int FW_MIN_ATTACK_BONUS_CR_5 = 1; const int FW_MAX_ATTACK_BONUS_CR_5 = 2;
const int FW_MIN_ATTACK_BONUS_CR_6 = 1; const int FW_MAX_ATTACK_BONUS_CR_6 = 2;
const int FW_MIN_ATTACK_BONUS_CR_7 = 1; const int FW_MAX_ATTACK_BONUS_CR_7 = 2;
const int FW_MIN_ATTACK_BONUS_CR_8 = 1; const int FW_MAX_ATTACK_BONUS_CR_8 = 2;
const int FW_MIN_ATTACK_BONUS_CR_9 = 1; const int FW_MAX_ATTACK_BONUS_CR_9 = 2;
const int FW_MIN_ATTACK_BONUS_CR_10 = 1; const int FW_MAX_ATTACK_BONUS_CR_10 = 2;

const int FW_MIN_ATTACK_BONUS_CR_11 = 1; const int FW_MAX_ATTACK_BONUS_CR_11 = 2;
const int FW_MIN_ATTACK_BONUS_CR_12 = 1; const int FW_MAX_ATTACK_BONUS_CR_12 = 2;
const int FW_MIN_ATTACK_BONUS_CR_13 = 1; const int FW_MAX_ATTACK_BONUS_CR_13 = 2;
const int FW_MIN_ATTACK_BONUS_CR_14 = 1; const int FW_MAX_ATTACK_BONUS_CR_14 = 2;
const int FW_MIN_ATTACK_BONUS_CR_15 = 1; const int FW_MAX_ATTACK_BONUS_CR_15 = 2;
const int FW_MIN_ATTACK_BONUS_CR_16 = 1; const int FW_MAX_ATTACK_BONUS_CR_16 = 2;
const int FW_MIN_ATTACK_BONUS_CR_17 = 1; const int FW_MAX_ATTACK_BONUS_CR_17 = 2;
const int FW_MIN_ATTACK_BONUS_CR_18 = 1; const int FW_MAX_ATTACK_BONUS_CR_18 = 2;
const int FW_MIN_ATTACK_BONUS_CR_19 = 1; const int FW_MAX_ATTACK_BONUS_CR_19 = 2;
const int FW_MIN_ATTACK_BONUS_CR_20 = 1; const int FW_MAX_ATTACK_BONUS_CR_20 = 2;

const int FW_MIN_ATTACK_BONUS_CR_21 = 1; const int FW_MAX_ATTACK_BONUS_CR_21 = 2;
const int FW_MIN_ATTACK_BONUS_CR_22 = 1; const int FW_MAX_ATTACK_BONUS_CR_22 = 2;
const int FW_MIN_ATTACK_BONUS_CR_23 = 1; const int FW_MAX_ATTACK_BONUS_CR_23 = 2;
const int FW_MIN_ATTACK_BONUS_CR_24 = 1; const int FW_MAX_ATTACK_BONUS_CR_24 = 2;
const int FW_MIN_ATTACK_BONUS_CR_25 = 1; const int FW_MAX_ATTACK_BONUS_CR_25 = 2;
const int FW_MIN_ATTACK_BONUS_CR_26 = 1; const int FW_MAX_ATTACK_BONUS_CR_26 = 2;
const int FW_MIN_ATTACK_BONUS_CR_27 = 1; const int FW_MAX_ATTACK_BONUS_CR_27 = 2;
const int FW_MIN_ATTACK_BONUS_CR_28 = 1; const int FW_MAX_ATTACK_BONUS_CR_28 = 2;
const int FW_MIN_ATTACK_BONUS_CR_29 = 1; const int FW_MAX_ATTACK_BONUS_CR_29 = 2;
const int FW_MIN_ATTACK_BONUS_CR_30 = 1; const int FW_MAX_ATTACK_BONUS_CR_30 = 2;

const int FW_MIN_ATTACK_BONUS_CR_31 = 1; const int FW_MAX_ATTACK_BONUS_CR_31 = 2;
const int FW_MIN_ATTACK_BONUS_CR_32 = 1; const int FW_MAX_ATTACK_BONUS_CR_32 = 2;
const int FW_MIN_ATTACK_BONUS_CR_33 = 1; const int FW_MAX_ATTACK_BONUS_CR_33 = 2;
const int FW_MIN_ATTACK_BONUS_CR_34 = 1; const int FW_MAX_ATTACK_BONUS_CR_34 = 2;
const int FW_MIN_ATTACK_BONUS_CR_35 = 1; const int FW_MAX_ATTACK_BONUS_CR_35 = 2;
const int FW_MIN_ATTACK_BONUS_CR_36 = 1; const int FW_MAX_ATTACK_BONUS_CR_36 = 2;
const int FW_MIN_ATTACK_BONUS_CR_37 = 1; const int FW_MAX_ATTACK_BONUS_CR_37 = 2;
const int FW_MIN_ATTACK_BONUS_CR_38 = 1; const int FW_MAX_ATTACK_BONUS_CR_38 = 2;
const int FW_MIN_ATTACK_BONUS_CR_39 = 1; const int FW_MAX_ATTACK_BONUS_CR_39 = 2;
const int FW_MIN_ATTACK_BONUS_CR_40 = 1; const int FW_MAX_ATTACK_BONUS_CR_40 = 2;

const int FW_MIN_ATTACK_BONUS_CR_41_OR_HIGHER = 1; const int FW_MAX_ATTACK_BONUS_CR_41_OR_HIGHER = 2;

// ATTACK BONUS VS ALIGNMENT GROUP
// The minimum and maximum Attack Bonus vs. Alignment GROUP values an item
// could have (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_0 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_0 = 2;

const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_1 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_1 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_2 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_2 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_3 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_3 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_4 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_4 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_5 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_5 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_6 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_6 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_7 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_7 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_8 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_8 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_9 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_9 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_10 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_10 = 2;

const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_11 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_11 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_12 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_12 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_13 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_13 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_14 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_14 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_15 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_15 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_16 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_16 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_17 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_17 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_18 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_18 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_19 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_19 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_20 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_20 = 2;

const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_21 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_21 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_22 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_22 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_23 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_23 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_24 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_24 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_25 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_25 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_26 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_26 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_27 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_27 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_28 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_28 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_29 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_29 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_30 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_30 = 2;

const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_31 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_31 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_32 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_32 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_33 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_33 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_34 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_34 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_35 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_35 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_36 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_36 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_37 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_37 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_38 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_38 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_39 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_39 = 2;
const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_40 = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_40 = 2;

const int FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_41_OR_HIGHER = 1; const int FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_41_OR_HIGHER = 2;

// ATTACK BONUS VS RACE
// The minimum and maximum Attack Bonus Vs. Race values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_0 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_0 = 2;

const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_1 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_1 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_2 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_2 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_3 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_3 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_4 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_4 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_5 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_5 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_6 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_6 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_7 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_7 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_8 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_8 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_9 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_9 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_10 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_10 = 2;

const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_11 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_11 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_12 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_12 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_13 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_13 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_14 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_14 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_15 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_15 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_16 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_16 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_17 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_17 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_18 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_18 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_19 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_19 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_20 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_20 = 2;

const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_21 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_21 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_22 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_22 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_23 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_23 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_24 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_24 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_25 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_25 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_26 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_26 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_27 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_27 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_28 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_28 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_29 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_29 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_30 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_30 = 2;

const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_31 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_31 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_32 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_32 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_33 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_33 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_34 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_34 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_35 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_35 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_36 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_36 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_37 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_37 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_38 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_38 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_39 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_39 = 2;
const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_40 = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_40 = 2;

const int FW_MIN_ATTACK_BONUS_VS_RACE_CR_41_OR_HIGHER = 1; const int FW_MAX_ATTACK_BONUS_VS_RACE_CR_41_OR_HIGHER = 2;

// ATTACK BONUS VS. SPECIFIC ALIGNMENT
// The minimum and maximum Attack Bonus vs. SPECIFIC Alignment values an
// item could have (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_0 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_0 = 2;

const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_1 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_1 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_2 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_2 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_3 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_3 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_4 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_4 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_5 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_5 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_6 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_6 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_7 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_7 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_8 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_8 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_9 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_9 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_10 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_10 = 2;

const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_11 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_11 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_12 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_12 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_13 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_13 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_14 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_14 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_15 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_15 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_16 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_16 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_17 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_17 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_18 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_18 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_19 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_19 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_20 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_20 = 2;

const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_21 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_21 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_22 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_22 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_23 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_23 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_24 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_24 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_25 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_25 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_26 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_26 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_27 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_27 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_28 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_28 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_29 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_29 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_30 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_30 = 2;

const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_31 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_31 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_32 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_32 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_33 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_33 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_34 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_34 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_35 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_35 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_36 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_36 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_37 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_37 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_38 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_38 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_39 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_39 = 2;
const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_40 = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_40 = 2;

const int FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_41_OR_HIGHER = 1; const int FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_41_OR_HIGHER = 2;

// ATTACK PENALTY
// The minimum and maximum Attack Penalty an item could have (for each CR level).
// Acceptable values: 1 to 5. 1 = -1.  2 = -2 and so forth.  Max is 5!
const int FW_MIN_ATTACK_PENALTY_CR_0 = 1; const int FW_MAX_ATTACK_PENALTY_CR_0 = 5;

const int FW_MIN_ATTACK_PENALTY_CR_1 = 1; const int FW_MAX_ATTACK_PENALTY_CR_1 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_2 = 1; const int FW_MAX_ATTACK_PENALTY_CR_2 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_3 = 1; const int FW_MAX_ATTACK_PENALTY_CR_3 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_4 = 1; const int FW_MAX_ATTACK_PENALTY_CR_4 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_5 = 1; const int FW_MAX_ATTACK_PENALTY_CR_5 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_6 = 1; const int FW_MAX_ATTACK_PENALTY_CR_6 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_7 = 1; const int FW_MAX_ATTACK_PENALTY_CR_7 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_8 = 1; const int FW_MAX_ATTACK_PENALTY_CR_8 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_9 = 1; const int FW_MAX_ATTACK_PENALTY_CR_9 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_10 = 1; const int FW_MAX_ATTACK_PENALTY_CR_10 = 5;

const int FW_MIN_ATTACK_PENALTY_CR_11 = 1; const int FW_MAX_ATTACK_PENALTY_CR_11 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_12 = 1; const int FW_MAX_ATTACK_PENALTY_CR_12 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_13 = 1; const int FW_MAX_ATTACK_PENALTY_CR_13 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_14 = 1; const int FW_MAX_ATTACK_PENALTY_CR_14 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_15 = 1; const int FW_MAX_ATTACK_PENALTY_CR_15 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_16 = 1; const int FW_MAX_ATTACK_PENALTY_CR_16 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_17 = 1; const int FW_MAX_ATTACK_PENALTY_CR_17 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_18 = 1; const int FW_MAX_ATTACK_PENALTY_CR_18 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_19 = 1; const int FW_MAX_ATTACK_PENALTY_CR_19 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_20 = 1; const int FW_MAX_ATTACK_PENALTY_CR_20 = 5;

const int FW_MIN_ATTACK_PENALTY_CR_21 = 1; const int FW_MAX_ATTACK_PENALTY_CR_21 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_22 = 1; const int FW_MAX_ATTACK_PENALTY_CR_22 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_23 = 1; const int FW_MAX_ATTACK_PENALTY_CR_23 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_24 = 1; const int FW_MAX_ATTACK_PENALTY_CR_24 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_25 = 1; const int FW_MAX_ATTACK_PENALTY_CR_25 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_26 = 1; const int FW_MAX_ATTACK_PENALTY_CR_26 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_27 = 1; const int FW_MAX_ATTACK_PENALTY_CR_27 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_28 = 1; const int FW_MAX_ATTACK_PENALTY_CR_28 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_29 = 1; const int FW_MAX_ATTACK_PENALTY_CR_29 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_30 = 1; const int FW_MAX_ATTACK_PENALTY_CR_30 = 5;

const int FW_MIN_ATTACK_PENALTY_CR_31 = 1; const int FW_MAX_ATTACK_PENALTY_CR_31 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_32 = 1; const int FW_MAX_ATTACK_PENALTY_CR_32 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_33 = 1; const int FW_MAX_ATTACK_PENALTY_CR_33 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_34 = 1; const int FW_MAX_ATTACK_PENALTY_CR_34 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_35 = 1; const int FW_MAX_ATTACK_PENALTY_CR_35 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_36 = 1; const int FW_MAX_ATTACK_PENALTY_CR_36 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_37 = 1; const int FW_MAX_ATTACK_PENALTY_CR_37 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_38 = 1; const int FW_MAX_ATTACK_PENALTY_CR_38 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_39 = 1; const int FW_MAX_ATTACK_PENALTY_CR_39 = 5;
const int FW_MIN_ATTACK_PENALTY_CR_40 = 1; const int FW_MAX_ATTACK_PENALTY_CR_40 = 5;

const int FW_MIN_ATTACK_PENALTY_CR_41_OR_HIGHER = 1; const int FW_MAX_ATTACK_PENALTY_CR_41_OR_HIGHER = 5;

// * ITEM_PROPERTY_BONUS_FEAT
// There is no switch to change what feats can or can't appear on an item.
// If you want to change what feats can or can't appear you need to go into the
// function FW_Choose_IP_Bonus_Feat and comment out the case statements for the
// feats that you don't want to appear.  By default, all feats can appear on an
// item.

// BONUS LEVEL SPELL
// The minimum and maximum bonus spell level values an item could have
// (for each CR level).
// Acceptable values: 0,1,2,...9
const int FW_MIN_BONUS_LEVEL_SPELL_CR_0 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_0 = 2;

const int FW_MIN_BONUS_LEVEL_SPELL_CR_1 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_1 = 2;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_2 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_2 = 2;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_3 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_3 = 2;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_4 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_4 = 2;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_5 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_5 = 2;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_6 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_6 = 2;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_7 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_7 = 2;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_8 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_8 = 2;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_9 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_9 = 2;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_10 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_10 = 2;

const int FW_MIN_BONUS_LEVEL_SPELL_CR_11 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_11 = 2;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_12 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_12 = 2;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_13 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_13 = 2;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_14 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_14 = 3;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_15 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_15 = 3;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_16 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_16 = 3;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_17 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_17 = 3;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_18 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_18 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_19 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_19 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_20 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_20 = 4;

const int FW_MIN_BONUS_LEVEL_SPELL_CR_21 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_21 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_22 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_22 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_23 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_23 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_24 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_24 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_25 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_25 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_26 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_26 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_27 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_27 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_28 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_28 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_29 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_29 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_30 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_30 = 4;

const int FW_MIN_BONUS_LEVEL_SPELL_CR_31 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_31 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_32 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_32 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_33 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_33 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_34 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_34 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_35 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_35 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_36 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_36 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_37 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_37 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_38 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_38 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_39 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_39 = 4;
const int FW_MIN_BONUS_LEVEL_SPELL_CR_40 = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_40 = 4;

const int FW_MIN_BONUS_LEVEL_SPELL_CR_41_OR_HIGHER = 0; const int FW_MAX_BONUS_LEVEL_SPELL_CR_41_OR_HIGHER = 5;

// BONUS HIT POINTS
// The minimum and maximum Bonus Hit Point values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,50
const int FW_MIN_BONUS_HIT_POINTS_CR_0 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_0 = 5;

const int FW_MIN_BONUS_HIT_POINTS_CR_1 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_1 = 5;
const int FW_MIN_BONUS_HIT_POINTS_CR_2 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_2 = 5;
const int FW_MIN_BONUS_HIT_POINTS_CR_3 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_3 = 5;
const int FW_MIN_BONUS_HIT_POINTS_CR_4 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_4 = 5;
const int FW_MIN_BONUS_HIT_POINTS_CR_5 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_5 = 5;
const int FW_MIN_BONUS_HIT_POINTS_CR_6 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_6 = 5;
const int FW_MIN_BONUS_HIT_POINTS_CR_7 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_7 = 5;
const int FW_MIN_BONUS_HIT_POINTS_CR_8 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_8 = 5;
const int FW_MIN_BONUS_HIT_POINTS_CR_9 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_9 = 5;
const int FW_MIN_BONUS_HIT_POINTS_CR_10 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_10 = 5;

const int FW_MIN_BONUS_HIT_POINTS_CR_11 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_11 = 5;
const int FW_MIN_BONUS_HIT_POINTS_CR_12 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_12 = 5;
const int FW_MIN_BONUS_HIT_POINTS_CR_13 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_13 = 5;
const int FW_MIN_BONUS_HIT_POINTS_CR_14 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_14 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_15 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_15 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_16 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_16 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_17 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_17 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_18 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_18 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_19 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_19 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_20 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_20 = 10;

const int FW_MIN_BONUS_HIT_POINTS_CR_21 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_21 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_22 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_22 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_23 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_23 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_24 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_24 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_25 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_25 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_26 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_26 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_27 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_27 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_28 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_28 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_29 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_29 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_30 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_30 = 10;

const int FW_MIN_BONUS_HIT_POINTS_CR_31 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_31 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_32 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_32 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_33 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_33 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_34 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_34 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_35 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_35 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_36 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_36 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_37 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_37 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_38 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_38 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_39 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_39 = 10;
const int FW_MIN_BONUS_HIT_POINTS_CR_40 = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_40 = 10;

const int FW_MIN_BONUS_HIT_POINTS_CR_41_OR_HIGHER = 1; const int FW_MAX_BONUS_HIT_POINTS_CR_41_OR_HIGHER = 10;

// BONUS SAVING THROW
// The minimum and maximum Bonus Saving Throw values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_BONUS_SAVING_THROW_CR_0 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_0 = 2;

const int FW_MIN_BONUS_SAVING_THROW_CR_1 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_1 = 2;
const int FW_MIN_BONUS_SAVING_THROW_CR_2 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_2 = 2;
const int FW_MIN_BONUS_SAVING_THROW_CR_3 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_3 = 2;
const int FW_MIN_BONUS_SAVING_THROW_CR_4 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_4 = 2;
const int FW_MIN_BONUS_SAVING_THROW_CR_5 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_5 = 2;
const int FW_MIN_BONUS_SAVING_THROW_CR_6 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_6 = 2;
const int FW_MIN_BONUS_SAVING_THROW_CR_7 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_7 = 2;
const int FW_MIN_BONUS_SAVING_THROW_CR_8 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_8 = 2;
const int FW_MIN_BONUS_SAVING_THROW_CR_9 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_9 = 2;
const int FW_MIN_BONUS_SAVING_THROW_CR_10 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_10 = 2;

const int FW_MIN_BONUS_SAVING_THROW_CR_11 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_11 = 2;
const int FW_MIN_BONUS_SAVING_THROW_CR_12 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_12 = 2;
const int FW_MIN_BONUS_SAVING_THROW_CR_13 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_13 = 2;
const int FW_MIN_BONUS_SAVING_THROW_CR_14 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_14 = 3;
const int FW_MIN_BONUS_SAVING_THROW_CR_15 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_15 = 3;
const int FW_MIN_BONUS_SAVING_THROW_CR_16 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_16 = 3;
const int FW_MIN_BONUS_SAVING_THROW_CR_17 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_17 = 3;
const int FW_MIN_BONUS_SAVING_THROW_CR_18 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_18 = 3;
const int FW_MIN_BONUS_SAVING_THROW_CR_19 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_19 = 3;
const int FW_MIN_BONUS_SAVING_THROW_CR_20 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_20 = 3;

const int FW_MIN_BONUS_SAVING_THROW_CR_21 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_21 = 4;
const int FW_MIN_BONUS_SAVING_THROW_CR_22 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_22 = 4;
const int FW_MIN_BONUS_SAVING_THROW_CR_23 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_23 = 4;
const int FW_MIN_BONUS_SAVING_THROW_CR_24 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_24 = 4;
const int FW_MIN_BONUS_SAVING_THROW_CR_25 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_25 = 4;
const int FW_MIN_BONUS_SAVING_THROW_CR_26 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_26 = 4;
const int FW_MIN_BONUS_SAVING_THROW_CR_27 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_27 = 4;
const int FW_MIN_BONUS_SAVING_THROW_CR_28 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_28 = 4;
const int FW_MIN_BONUS_SAVING_THROW_CR_29 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_29 = 4;
const int FW_MIN_BONUS_SAVING_THROW_CR_30 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_30 = 4;

const int FW_MIN_BONUS_SAVING_THROW_CR_31 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_31 = 5;
const int FW_MIN_BONUS_SAVING_THROW_CR_32 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_32 = 5;
const int FW_MIN_BONUS_SAVING_THROW_CR_33 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_33 = 5;
const int FW_MIN_BONUS_SAVING_THROW_CR_34 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_34 = 5;
const int FW_MIN_BONUS_SAVING_THROW_CR_35 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_35 = 5;
const int FW_MIN_BONUS_SAVING_THROW_CR_36 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_36 = 5;
const int FW_MIN_BONUS_SAVING_THROW_CR_37 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_37 = 5;
const int FW_MIN_BONUS_SAVING_THROW_CR_38 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_38 = 5;
const int FW_MIN_BONUS_SAVING_THROW_CR_39 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_39 = 5;
const int FW_MIN_BONUS_SAVING_THROW_CR_40 = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_40 = 5;

const int FW_MIN_BONUS_SAVING_THROW_CR_41_OR_HIGHER = 1; const int FW_MAX_BONUS_SAVING_THROW_CR_41_OR_HIGHER = 5;

// BONUS_SAVING_THROW_VSX
// The minimum and maximum Bonus Saving Throw Vs X values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_0 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_0 = 2;

const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_1 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_1 = 2;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_2 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_2 = 2;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_3 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_3 = 2;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_4 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_4 = 2;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_5 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_5 = 2;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_6 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_6 = 2;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_7 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_7 = 2;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_8 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_8 = 2;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_9 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_9 = 2;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_10 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_10 = 2;

const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_11 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_11 = 3;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_12 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_12 = 3;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_13 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_13 = 3;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_14 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_14 = 3;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_15 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_15 = 3;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_16 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_16 = 3;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_17 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_17 = 3;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_18 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_18 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_19 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_19 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_20 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_20 = 4;

const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_21 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_21 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_22 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_22 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_23 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_23 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_24 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_24 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_25 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_25 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_26 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_26 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_27 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_27 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_28 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_28 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_29 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_29 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_30 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_30 = 4;

const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_31 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_31 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_32 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_32 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_33 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_33 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_34 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_34 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_35 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_35 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_36 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_36 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_37 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_37 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_38 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_38 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_39 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_39 = 4;
const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_40 = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_40 = 4;

const int FW_MIN_BONUS_SAVING_THROW_VSX_CR_41_OR_HIGHER = 1; const int FW_MAX_BONUS_SAVING_THROW_VSX_CR_41_OR_HIGHER = 5;

// This constant is a dalelands custom restriction to prevent saves vs UNIVERSAL from being too large... but still allow other types.
const int FW_MAX_BONUS_SAVING_THROW_VS_UNIVERSAL = 3; 

// BONUS_SPELL_RESISTANCE
// The minimum and maximum Bonus Spell Resistance an item could have. Min=10, Max=32
// (for each CR level).  Acceptable values for min and max are 
// increments of 2 starting at 10 and ending at 32:  10,12,14,...,32
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_0 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_0 = 16;

const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_1 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_1 = 16;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_2 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_2 = 16;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_3 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_3 = 16;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_4 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_4 = 16;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_5 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_5 = 16;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_6 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_6 = 16;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_7 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_7 = 16;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_8 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_8 = 16;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_9 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_9 = 16;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_10 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_10 = 16;

const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_11 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_11 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_12 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_12 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_13 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_13 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_14 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_14 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_15 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_15 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_16 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_16 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_17 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_17 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_18 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_18 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_19 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_19 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_20 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_20 = 22;

const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_21 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_21 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_22 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_22 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_23 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_23 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_24 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_24 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_25 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_25 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_26 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_26 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_27 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_27 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_28 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_28 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_29 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_29 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_30 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_30 = 22;

const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_31 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_31 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_32 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_32 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_33 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_33 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_34 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_34 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_35 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_35 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_36 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_36 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_37 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_37 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_38 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_38 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_39 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_39 = 22;
const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_40 = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_40 = 22;

const int FW_MIN_BONUS_SPELL_RESISTANCE_CR_41_OR_HIGHER = 10; const int FW_MAX_BONUS_SPELL_RESISTANCE_CR_41_OR_HIGHER = 22;

// * ITEM_PROPERTY_CAST_SPELL_*
// By default the function that chooses ItemProperty
// CastSpell will choose from every single spell available (there are hundreds)
// If you want to disallow certain spells from being added to an item, then you
// need to go into the function: FW_Choose_IP_Cast_Spell and edit it.

// * ITEM_PROPERTY_DAMAGE_BONUS_*
// Setting min and max switches for damage bonuses requires a bit of explaining.
// I have ranked all the damage bonus item properties in ascending order based
// off of the average damage dealt by each item property. In cases where the
// average was a tie (i.e. 7 dmg and 2d6 dmg both average 7 dmg) I gave a higher
// ranking to the random amount because it can potentially roll much higher.
// By default I have the damage bonus constants set to min=0 and max=19.  This
// allows any amount of damage ranging from index 0 (measly +1 dmg.) up to and
// including index 19 (the powerful +2d12 dmg.) By changing the values of the
// constants you can specify the range of values you want to allow / disallow
// as possibilities. Here's a couple examples to show you what I mean.
// Example 1: You set FW_MIN_DAMAGE_BONUS = 5 and FW_MAX_DAMAGE_BONUS = 8.
//    Possibilities are now from index 5 to 8, or: +4, +1d8, +5, or +2d4 damage.
// Example 2: You set FW_MIN_DAMAGE_BONUS = 3 and FW_MAX_DAMAGE_BONUS = 8.
//    Possibilites are from index 3 to 8, or: +3, +1d6, +4, +1d8, +5, or +2d4
//    damage.
// Note: It's okay to set min = max.  There just wouldn't be any randomness
//    if you do that.
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
// The minimum and maximum Damage Bonus values an item could have
// (for each CR level).    See explanation and table above.
// Acceptable values: 0,1,2,3,...,19
const int FW_MIN_DAMAGE_BONUS_CR_0 = 0; const int FW_MAX_DAMAGE_BONUS_CR_0 = 0;

const int FW_MIN_DAMAGE_BONUS_CR_1 = 0; const int FW_MAX_DAMAGE_BONUS_CR_1 = 0;
const int FW_MIN_DAMAGE_BONUS_CR_2 = 0; const int FW_MAX_DAMAGE_BONUS_CR_2 = 0;
const int FW_MIN_DAMAGE_BONUS_CR_3 = 0; const int FW_MAX_DAMAGE_BONUS_CR_3 = 0;
const int FW_MIN_DAMAGE_BONUS_CR_4 = 0; const int FW_MAX_DAMAGE_BONUS_CR_4 = 0;
const int FW_MIN_DAMAGE_BONUS_CR_5 = 0; const int FW_MAX_DAMAGE_BONUS_CR_5 = 0;
const int FW_MIN_DAMAGE_BONUS_CR_6 = 0; const int FW_MAX_DAMAGE_BONUS_CR_6 = 1;
const int FW_MIN_DAMAGE_BONUS_CR_7 = 0; const int FW_MAX_DAMAGE_BONUS_CR_7 = 1;
const int FW_MIN_DAMAGE_BONUS_CR_8 = 0; const int FW_MAX_DAMAGE_BONUS_CR_8 = 1;
const int FW_MIN_DAMAGE_BONUS_CR_9 = 0; const int FW_MAX_DAMAGE_BONUS_CR_9 = 1;
const int FW_MIN_DAMAGE_BONUS_CR_10 = 0; const int FW_MAX_DAMAGE_BONUS_CR_10 = 1;

const int FW_MIN_DAMAGE_BONUS_CR_11 = 0; const int FW_MAX_DAMAGE_BONUS_CR_11 = 1;
const int FW_MIN_DAMAGE_BONUS_CR_12 = 0; const int FW_MAX_DAMAGE_BONUS_CR_12 = 1;
const int FW_MIN_DAMAGE_BONUS_CR_13 = 0; const int FW_MAX_DAMAGE_BONUS_CR_13 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_14 = 0; const int FW_MAX_DAMAGE_BONUS_CR_14 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_15 = 0; const int FW_MAX_DAMAGE_BONUS_CR_15 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_16 = 0; const int FW_MAX_DAMAGE_BONUS_CR_16 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_17 = 0; const int FW_MAX_DAMAGE_BONUS_CR_17 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_18 = 0; const int FW_MAX_DAMAGE_BONUS_CR_18 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_19 = 0; const int FW_MAX_DAMAGE_BONUS_CR_19 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_20 = 0; const int FW_MAX_DAMAGE_BONUS_CR_20 = 2;

const int FW_MIN_DAMAGE_BONUS_CR_21 = 0; const int FW_MAX_DAMAGE_BONUS_CR_21 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_22 = 0; const int FW_MAX_DAMAGE_BONUS_CR_22 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_23 = 0; const int FW_MAX_DAMAGE_BONUS_CR_23 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_24 = 0; const int FW_MAX_DAMAGE_BONUS_CR_24 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_25 = 0; const int FW_MAX_DAMAGE_BONUS_CR_25 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_26 = 0; const int FW_MAX_DAMAGE_BONUS_CR_26 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_27 = 0; const int FW_MAX_DAMAGE_BONUS_CR_27 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_28 = 0; const int FW_MAX_DAMAGE_BONUS_CR_28 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_29 = 0; const int FW_MAX_DAMAGE_BONUS_CR_29 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_30 = 0; const int FW_MAX_DAMAGE_BONUS_CR_30 = 2;

const int FW_MIN_DAMAGE_BONUS_CR_31 = 0; const int FW_MAX_DAMAGE_BONUS_CR_31 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_32 = 0; const int FW_MAX_DAMAGE_BONUS_CR_32 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_33 = 0; const int FW_MAX_DAMAGE_BONUS_CR_33 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_34 = 0; const int FW_MAX_DAMAGE_BONUS_CR_34 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_35 = 0; const int FW_MAX_DAMAGE_BONUS_CR_35 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_36 = 0; const int FW_MAX_DAMAGE_BONUS_CR_36 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_37 = 0; const int FW_MAX_DAMAGE_BONUS_CR_37 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_38 = 0; const int FW_MAX_DAMAGE_BONUS_CR_38 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_39 = 0; const int FW_MAX_DAMAGE_BONUS_CR_39 = 2;
const int FW_MIN_DAMAGE_BONUS_CR_40 = 0; const int FW_MAX_DAMAGE_BONUS_CR_40 = 2;

const int FW_MIN_DAMAGE_BONUS_CR_41_OR_HIGHER = 0; const int FW_MAX_DAMAGE_BONUS_CR_41_OR_HIGHER = 2;

// DAMAGE_BONUS_VS_ALIGNMENT
// The minimum and maximum DAMAGE_BONUS_VS_ALIGNMENT values an item could have
// (for each CR level).   See explanation and table above.
// Acceptable values: 0,1,2,3,...,19
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_0 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_0 = 1;

const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_1 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_1 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_2 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_2 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_3 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_3 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_4 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_4 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_5 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_5 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_6 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_6 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_7 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_7 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_8 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_8 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_9 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_9 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_10 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_10 = 2;

const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_11 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_11 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_12 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_12 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_13 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_13 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_14 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_14 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_15 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_15 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_16 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_16 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_17 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_17 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_18 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_18 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_19 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_19 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_20 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_20 = 2;

const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_21 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_21 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_22 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_22 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_23 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_23 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_24 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_24 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_25 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_25 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_26 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_26 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_27 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_27 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_28 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_28 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_29 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_29 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_30 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_30 = 2;

const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_31 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_31 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_32 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_32 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_33 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_33 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_34 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_34 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_35 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_35 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_36 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_36 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_37 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_37 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_38 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_38 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_39 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_39 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_40 = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_40 = 2;

const int FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_41_OR_HIGHER = 0; const int FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_41_OR_HIGHER = 2;

// DAMAGE_BONUS_VS_RACE
// The minimum and maximum DAMAGE_BONUS_VS_RACE values an item could have
// (for each CR level).     See explanation and table above.
// Acceptable values: 0,1,2,3,...,19
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_0 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_0 = 0;

const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_1 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_1 = 0;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_2 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_2 = 0;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_3 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_3 = 0;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_4 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_4 = 0;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_5 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_5 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_6 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_6 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_7 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_7 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_8 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_8 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_9 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_9 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_10 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_10 = 2;

const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_11 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_11 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_12 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_12 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_13 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_13 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_14 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_14 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_15 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_15 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_16 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_16 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_17 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_17 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_18 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_18 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_19 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_19 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_20 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_20 = 2;

const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_21 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_21 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_22 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_22 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_23 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_23 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_24 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_24 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_25 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_25 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_26 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_26 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_27 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_27 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_28 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_28 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_29 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_29 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_30 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_30 = 2;

const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_31 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_31 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_32 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_32 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_33 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_33 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_34 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_34 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_35 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_35 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_36 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_36 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_37 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_37 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_38 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_38 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_39 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_39 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_40 = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_40 = 2;

const int FW_MIN_DAMAGE_BONUS_VS_RACE_CR_41_OR_HIGHER = 0; const int FW_MAX_DAMAGE_BONUS_VS_RACE_CR_41_OR_HIGHER = 2;

// DAMAGE_BONUS_VS_SALIGNMENT
// The minimum and maximum Damage Bonus vs. SPECIFIC Alignment values an item could have
// (for each CR level). See explanation and table above.
// Acceptable values: 0,1,2,3,...,19
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_0 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_0 = 0;

const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_1 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_1 = 0;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_2 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_2 = 0;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_3 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_3 = 0;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_4 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_4 = 0;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_5 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_5 = 0;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_6 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_6 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_7 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_7 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_8 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_8 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_9 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_9 = 1;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_10 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_10 = 1;

const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_11 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_11 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_12 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_12 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_13 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_13 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_14 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_14 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_15 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_15 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_16 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_16 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_17 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_17 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_18 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_18 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_19 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_19 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_20 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_20 = 2;

const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_21 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_21 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_22 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_22 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_23 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_23 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_24 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_24 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_25 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_25 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_26 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_26 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_27 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_27 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_28 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_28 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_29 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_29 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_30 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_30 = 2;

const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_31 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_31 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_32 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_32 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_33 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_33 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_34 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_34 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_35 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_35 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_36 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_36 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_37 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_37 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_38 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_38 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_39 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_39 = 2;
const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_40 = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_40 = 2;

const int FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_41_OR_HIGHER = 0; const int FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_41_OR_HIGHER = 2;

// MASSIVE_CRITICAL_DAMAGE_BONUS
// The minimum and maximum MASSIVE_CRITICAL_DAMAGE_BONUS values an item could have
// (for each CR level).   See table and explanation above.
// Acceptable values: 0,1,2,3,...,20
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_0 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_0 = 0;

const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_1 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_1 = 0;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_2 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_2 = 0;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_3 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_3 = 0;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_4 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_4 = 0;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_5 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_5 = 1;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_6 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_6 = 1;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_7 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_7 = 1;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_8 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_8 = 1;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_9 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_9 = 1;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_10 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_10 = 1;

const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_11 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_11 = 1;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_12 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_12 = 1;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_13 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_13 = 1;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_14 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_14 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_15 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_15 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_16 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_16 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_17 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_17 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_18 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_18 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_19 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_19 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_20 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_20 = 2;

const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_21 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_21 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_22 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_22 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_23 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_23 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_24 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_24 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_25 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_25 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_26 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_26 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_27 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_27 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_28 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_28 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_29 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_29 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_30 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_30 = 2;

const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_31 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_31 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_32 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_32 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_33 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_33 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_34 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_34 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_35 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_35 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_36 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_36 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_37 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_37 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_38 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_38 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_39 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_39 = 2;
const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_40 = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_40 = 2;

const int FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_41_OR_HIGHER = 0; const int FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_41_OR_HIGHER = 2;

// * ITEM_PROPERTY_DAMAGE_IMMUNITY
// There is no switch to control min/max damage immunity amounts.  To disallow certain
// amounts you have to comment out the case statements inside the function
// FW_Choose_IP_Damage_Immunity ();  

// DAMAGE_PENALTY
// The minimum and maximum DAMAGE_PENALTY values an item could have
// (for each CR level).
// Acceptable values: 1 to 5.  I.E. 1 = -1, 2 = -2, etc.
const int FW_MIN_DAMAGE_PENALTY_CR_0 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_0 = 5;

const int FW_MIN_DAMAGE_PENALTY_CR_1 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_1 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_2 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_2 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_3 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_3 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_4 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_4 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_5 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_5 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_6 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_6 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_7 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_7 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_8 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_8 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_9 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_9 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_10 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_10 = 5;

const int FW_MIN_DAMAGE_PENALTY_CR_11 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_11 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_12 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_12 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_13 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_13 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_14 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_14 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_15 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_15 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_16 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_16 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_17 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_17 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_18 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_18 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_19 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_19 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_20 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_20 = 5;

const int FW_MIN_DAMAGE_PENALTY_CR_21 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_21 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_22 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_22 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_23 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_23 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_24 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_24 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_25 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_25 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_26 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_26 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_27 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_27 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_28 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_28 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_29 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_29 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_30 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_30 = 5;

const int FW_MIN_DAMAGE_PENALTY_CR_31 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_31 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_32 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_32 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_33 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_33 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_34 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_34 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_35 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_35 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_36 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_36 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_37 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_37 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_38 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_38 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_39 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_39 = 5;
const int FW_MIN_DAMAGE_PENALTY_CR_40 = 1; const int FW_MAX_DAMAGE_PENALTY_CR_40 = 5;

const int FW_MIN_DAMAGE_PENALTY_CR_41_OR_HIGHER = 1; const int FW_MAX_DAMAGE_PENALTY_CR_41_OR_HIGHER = 5;

// DAMAGE_REDUCTION 
// The minimum and maximum DAMAGE_REDUCTION values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_DAMAGE_REDUCTION_CR_0 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_0 = 2;

const int FW_MIN_DAMAGE_REDUCTION_CR_1 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_1 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_2 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_2 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_3 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_3 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_4 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_4 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_5 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_5 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_6 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_6 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_7 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_7 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_8 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_8 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_9 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_9 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_10 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_10 = 2;

const int FW_MIN_DAMAGE_REDUCTION_CR_11 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_11 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_12 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_12 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_13 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_13 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_14 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_14 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_15 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_15 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_16 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_16 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_17 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_17 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_18 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_18 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_19 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_19 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_20 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_20 = 2;

const int FW_MIN_DAMAGE_REDUCTION_CR_21 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_21 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_22 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_22 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_23 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_23 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_24 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_24 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_25 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_25 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_26 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_26 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_27 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_27 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_28 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_28 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_29 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_29 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_30 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_30 = 2;

const int FW_MIN_DAMAGE_REDUCTION_CR_31 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_31 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_32 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_32 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_33 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_33 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_34 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_34 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_35 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_35 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_36 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_36 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_37 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_37 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_38 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_38 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_39 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_39 = 2;
const int FW_MIN_DAMAGE_REDUCTION_CR_40 = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_40 = 2;

const int FW_MIN_DAMAGE_REDUCTION_CR_41_OR_HIGHER = 1; const int FW_MAX_DAMAGE_REDUCTION_CR_41_OR_HIGHER = 2;

// *DAMAGE SHIELDS*  
// Damage Shields scale according to the PC's level, not the spawning monster's 
// level.  Therefore, there is no constant to control scaling for Damage 
// Shields.  I already took care of damage shield scaling.  If you want to change
// the formula for damage shields to scale in some manner other than the way I have
// it set up already, you'll need to edit the file: "i_fw_damage_shield_ac".  But
// I recommend only a VERY EXPERIENCED programmer even attempt to change that file.
// And make sure you know all about tag based scripting before you do change it or 
// else you'll mess it up. Whatever you do, DON'T change the name of that file or 
// else it will definitely NOT work. 

// DAMAGESOAK_HP
// The minimum and maximum number of hit points that will be soaked up if your
// weapon is not of high enough enhancement. Acceptable values: 5,10,15,...,50
// Note: 0 is NOT an acceptable value.
const int FW_MIN_DAMAGESOAK_HP_CR_0 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_0 = 1;

const int FW_MIN_DAMAGESOAK_HP_CR_1 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_1 = 1;
const int FW_MIN_DAMAGESOAK_HP_CR_2 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_2 = 1;
const int FW_MIN_DAMAGESOAK_HP_CR_3 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_3 = 2;
const int FW_MIN_DAMAGESOAK_HP_CR_4 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_4 = 2;
const int FW_MIN_DAMAGESOAK_HP_CR_5 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_5 = 2;
const int FW_MIN_DAMAGESOAK_HP_CR_6 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_6 = 2;
const int FW_MIN_DAMAGESOAK_HP_CR_7 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_7 = 2;
const int FW_MIN_DAMAGESOAK_HP_CR_8 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_8 = 2;
const int FW_MIN_DAMAGESOAK_HP_CR_9 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_9 = 2;
const int FW_MIN_DAMAGESOAK_HP_CR_10 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_10 = 2;

const int FW_MIN_DAMAGESOAK_HP_CR_11 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_11 = 3;
const int FW_MIN_DAMAGESOAK_HP_CR_12 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_12 = 3;
const int FW_MIN_DAMAGESOAK_HP_CR_13 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_13 = 3;
const int FW_MIN_DAMAGESOAK_HP_CR_14 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_14 = 3;
const int FW_MIN_DAMAGESOAK_HP_CR_15 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_15 = 3;
const int FW_MIN_DAMAGESOAK_HP_CR_16 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_16 = 3;
const int FW_MIN_DAMAGESOAK_HP_CR_17 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_17 = 3;
const int FW_MIN_DAMAGESOAK_HP_CR_18 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_18 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_19 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_19 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_20 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_20 = 4;

const int FW_MIN_DAMAGESOAK_HP_CR_21 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_21 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_22 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_22 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_23 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_23 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_24 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_24 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_25 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_25 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_26 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_26 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_27 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_27 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_28 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_28 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_29 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_29 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_30 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_30 = 4;

const int FW_MIN_DAMAGESOAK_HP_CR_31 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_31 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_32 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_32 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_33 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_33 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_34 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_34 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_35 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_35 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_36 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_36 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_37 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_37 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_38 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_38 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_39 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_39 = 4;
const int FW_MIN_DAMAGESOAK_HP_CR_40 = 1; const int FW_MAX_DAMAGESOAK_HP_CR_40 = 4;

const int FW_MIN_DAMAGESOAK_HP_CR_41_OR_HIGHER = 5; const int FW_MAX_DAMAGESOAK_HP_CR_41_OR_HIGHER = 4;

// DAMAGE RESISTANCE
// The minimum and maximum number of HP that can be resisted each round as part
// of damage resistance. Acceptable values for min and max: 5,10,15,...,50
// Note: 0 is NOT an acceptable value.
const int FW_MIN_DAMAGERESIST_HP_CR_0 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_0 = 3;

const int FW_MIN_DAMAGERESIST_HP_CR_1 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_1 = 3;
const int FW_MIN_DAMAGERESIST_HP_CR_2 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_2 = 3;
const int FW_MIN_DAMAGERESIST_HP_CR_3 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_3 = 3;
const int FW_MIN_DAMAGERESIST_HP_CR_4 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_4 = 3;
const int FW_MIN_DAMAGERESIST_HP_CR_5 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_5 = 3;
const int FW_MIN_DAMAGERESIST_HP_CR_6 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_6 = 3;
const int FW_MIN_DAMAGERESIST_HP_CR_7 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_7 = 3;
const int FW_MIN_DAMAGERESIST_HP_CR_8 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_8 = 3;
const int FW_MIN_DAMAGERESIST_HP_CR_9 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_9 = 3;
const int FW_MIN_DAMAGERESIST_HP_CR_10 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_10 = 3;

const int FW_MIN_DAMAGERESIST_HP_CR_11 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_11 = 4;
const int FW_MIN_DAMAGERESIST_HP_CR_12 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_12 = 4;
const int FW_MIN_DAMAGERESIST_HP_CR_13 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_13 = 4;
const int FW_MIN_DAMAGERESIST_HP_CR_14 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_14 = 4;
const int FW_MIN_DAMAGERESIST_HP_CR_15 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_15 = 4;
const int FW_MIN_DAMAGERESIST_HP_CR_16 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_16 = 4;
const int FW_MIN_DAMAGERESIST_HP_CR_17 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_17 = 4;
const int FW_MIN_DAMAGERESIST_HP_CR_18 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_18 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_19 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_19 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_20 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_20 = 5;

const int FW_MIN_DAMAGERESIST_HP_CR_21 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_21 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_22 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_22 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_23 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_23 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_24 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_24 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_25 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_25 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_26 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_26 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_27 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_27 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_28 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_28 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_29 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_29 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_30 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_30 = 5;

const int FW_MIN_DAMAGERESIST_HP_CR_31 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_31 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_32 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_32 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_33 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_33 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_34 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_34 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_35 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_35 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_36 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_36 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_37 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_37 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_38 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_38 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_39 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_39 = 5;
const int FW_MIN_DAMAGERESIST_HP_CR_40 = 1; const int FW_MAX_DAMAGERESIST_HP_CR_40 = 5;

const int FW_MIN_DAMAGERESIST_HP_CR_41_OR_HIGHER = 5; const int FW_MAX_DAMAGERESIST_HP_CR_41_OR_HIGHER = 5;

// * ITEM_PROPERTY_DAMAGE_VULNERABILITY
// There is no switch to control damage vulnerability amounts. To disallow
// certain amounts you have to comment out the case statements inside the
// function FW_Choose_IP_Damage_Vulnerability ();

// ABILITY_PENALTY
// The minimum and maximum ABILITY_PENALTY values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,10
const int FW_MIN_ABILITY_PENALTY_CR_0 = 1; const int FW_MAX_ABILITY_PENALTY_CR_0 = 4;

const int FW_MIN_ABILITY_PENALTY_CR_1 = 1; const int FW_MAX_ABILITY_PENALTY_CR_1 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_2 = 1; const int FW_MAX_ABILITY_PENALTY_CR_2 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_3 = 1; const int FW_MAX_ABILITY_PENALTY_CR_3 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_4 = 1; const int FW_MAX_ABILITY_PENALTY_CR_4 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_5 = 1; const int FW_MAX_ABILITY_PENALTY_CR_5 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_6 = 1; const int FW_MAX_ABILITY_PENALTY_CR_6 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_7 = 1; const int FW_MAX_ABILITY_PENALTY_CR_7 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_8 = 1; const int FW_MAX_ABILITY_PENALTY_CR_8 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_9 = 1; const int FW_MAX_ABILITY_PENALTY_CR_9 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_10 = 1; const int FW_MAX_ABILITY_PENALTY_CR_10 = 4;

const int FW_MIN_ABILITY_PENALTY_CR_11 = 1; const int FW_MAX_ABILITY_PENALTY_CR_11 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_12 = 1; const int FW_MAX_ABILITY_PENALTY_CR_12 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_13 = 1; const int FW_MAX_ABILITY_PENALTY_CR_13 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_14 = 1; const int FW_MAX_ABILITY_PENALTY_CR_14 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_15 = 1; const int FW_MAX_ABILITY_PENALTY_CR_15 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_16 = 1; const int FW_MAX_ABILITY_PENALTY_CR_16 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_17 = 1; const int FW_MAX_ABILITY_PENALTY_CR_17 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_18 = 1; const int FW_MAX_ABILITY_PENALTY_CR_18 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_19 = 1; const int FW_MAX_ABILITY_PENALTY_CR_19 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_20 = 1; const int FW_MAX_ABILITY_PENALTY_CR_20 = 4;

const int FW_MIN_ABILITY_PENALTY_CR_21 = 1; const int FW_MAX_ABILITY_PENALTY_CR_21 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_22 = 1; const int FW_MAX_ABILITY_PENALTY_CR_22 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_23 = 1; const int FW_MAX_ABILITY_PENALTY_CR_23 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_24 = 1; const int FW_MAX_ABILITY_PENALTY_CR_24 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_25 = 1; const int FW_MAX_ABILITY_PENALTY_CR_25 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_26 = 1; const int FW_MAX_ABILITY_PENALTY_CR_26 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_27 = 1; const int FW_MAX_ABILITY_PENALTY_CR_27 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_28 = 1; const int FW_MAX_ABILITY_PENALTY_CR_28 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_29 = 1; const int FW_MAX_ABILITY_PENALTY_CR_29 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_30 = 1; const int FW_MAX_ABILITY_PENALTY_CR_30 = 4;

const int FW_MIN_ABILITY_PENALTY_CR_31 = 1; const int FW_MAX_ABILITY_PENALTY_CR_31 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_32 = 1; const int FW_MAX_ABILITY_PENALTY_CR_32 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_33 = 1; const int FW_MAX_ABILITY_PENALTY_CR_33 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_34 = 1; const int FW_MAX_ABILITY_PENALTY_CR_34 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_35 = 1; const int FW_MAX_ABILITY_PENALTY_CR_35 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_36 = 1; const int FW_MAX_ABILITY_PENALTY_CR_36 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_37 = 1; const int FW_MAX_ABILITY_PENALTY_CR_37 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_38 = 1; const int FW_MAX_ABILITY_PENALTY_CR_38 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_39 = 1; const int FW_MAX_ABILITY_PENALTY_CR_39 = 4;
const int FW_MIN_ABILITY_PENALTY_CR_40 = 1; const int FW_MAX_ABILITY_PENALTY_CR_40 = 4;

const int FW_MIN_ABILITY_PENALTY_CR_41_OR_HIGHER = 1; const int FW_MAX_ABILITY_PENALTY_CR_41_OR_HIGHER = 4;

// AC_PENALTY
// The minimum and maximum AC_PENALTY values an item could have (for each CR level).
// Acceptable values: 1 to 5.  Yes 5.
const int FW_MIN_AC_PENALTY_CR_0 = 1; const int FW_MAX_AC_PENALTY_CR_0 = 5;

const int FW_MIN_AC_PENALTY_CR_1 = 1; const int FW_MAX_AC_PENALTY_CR_1 = 5;
const int FW_MIN_AC_PENALTY_CR_2 = 1; const int FW_MAX_AC_PENALTY_CR_2 = 5;
const int FW_MIN_AC_PENALTY_CR_3 = 1; const int FW_MAX_AC_PENALTY_CR_3 = 5;
const int FW_MIN_AC_PENALTY_CR_4 = 1; const int FW_MAX_AC_PENALTY_CR_4 = 5;
const int FW_MIN_AC_PENALTY_CR_5 = 1; const int FW_MAX_AC_PENALTY_CR_5 = 5;
const int FW_MIN_AC_PENALTY_CR_6 = 1; const int FW_MAX_AC_PENALTY_CR_6 = 5;
const int FW_MIN_AC_PENALTY_CR_7 = 1; const int FW_MAX_AC_PENALTY_CR_7 = 5;
const int FW_MIN_AC_PENALTY_CR_8 = 1; const int FW_MAX_AC_PENALTY_CR_8 = 5;
const int FW_MIN_AC_PENALTY_CR_9 = 1; const int FW_MAX_AC_PENALTY_CR_9 = 5;
const int FW_MIN_AC_PENALTY_CR_10 = 1; const int FW_MAX_AC_PENALTY_CR_10 = 5;

const int FW_MIN_AC_PENALTY_CR_11 = 1; const int FW_MAX_AC_PENALTY_CR_11 = 5;
const int FW_MIN_AC_PENALTY_CR_12 = 1; const int FW_MAX_AC_PENALTY_CR_12 = 5;
const int FW_MIN_AC_PENALTY_CR_13 = 1; const int FW_MAX_AC_PENALTY_CR_13 = 5;
const int FW_MIN_AC_PENALTY_CR_14 = 1; const int FW_MAX_AC_PENALTY_CR_14 = 5;
const int FW_MIN_AC_PENALTY_CR_15 = 1; const int FW_MAX_AC_PENALTY_CR_15 = 5;
const int FW_MIN_AC_PENALTY_CR_16 = 1; const int FW_MAX_AC_PENALTY_CR_16 = 5;
const int FW_MIN_AC_PENALTY_CR_17 = 1; const int FW_MAX_AC_PENALTY_CR_17 = 5;
const int FW_MIN_AC_PENALTY_CR_18 = 1; const int FW_MAX_AC_PENALTY_CR_18 = 5;
const int FW_MIN_AC_PENALTY_CR_19 = 1; const int FW_MAX_AC_PENALTY_CR_19 = 5;
const int FW_MIN_AC_PENALTY_CR_20 = 1; const int FW_MAX_AC_PENALTY_CR_20 = 5;

const int FW_MIN_AC_PENALTY_CR_21 = 1; const int FW_MAX_AC_PENALTY_CR_21 = 5;
const int FW_MIN_AC_PENALTY_CR_22 = 1; const int FW_MAX_AC_PENALTY_CR_22 = 5;
const int FW_MIN_AC_PENALTY_CR_23 = 1; const int FW_MAX_AC_PENALTY_CR_23 = 5;
const int FW_MIN_AC_PENALTY_CR_24 = 1; const int FW_MAX_AC_PENALTY_CR_24 = 5;
const int FW_MIN_AC_PENALTY_CR_25 = 1; const int FW_MAX_AC_PENALTY_CR_25 = 5;
const int FW_MIN_AC_PENALTY_CR_26 = 1; const int FW_MAX_AC_PENALTY_CR_26 = 5;
const int FW_MIN_AC_PENALTY_CR_27 = 1; const int FW_MAX_AC_PENALTY_CR_27 = 5;
const int FW_MIN_AC_PENALTY_CR_28 = 1; const int FW_MAX_AC_PENALTY_CR_28 = 5;
const int FW_MIN_AC_PENALTY_CR_29 = 1; const int FW_MAX_AC_PENALTY_CR_29 = 5;
const int FW_MIN_AC_PENALTY_CR_30 = 1; const int FW_MAX_AC_PENALTY_CR_30 = 5;

const int FW_MIN_AC_PENALTY_CR_31 = 1; const int FW_MAX_AC_PENALTY_CR_31 = 5;
const int FW_MIN_AC_PENALTY_CR_32 = 1; const int FW_MAX_AC_PENALTY_CR_32 = 5;
const int FW_MIN_AC_PENALTY_CR_33 = 1; const int FW_MAX_AC_PENALTY_CR_33 = 5;
const int FW_MIN_AC_PENALTY_CR_34 = 1; const int FW_MAX_AC_PENALTY_CR_34 = 5;
const int FW_MIN_AC_PENALTY_CR_35 = 1; const int FW_MAX_AC_PENALTY_CR_35 = 5;
const int FW_MIN_AC_PENALTY_CR_36 = 1; const int FW_MAX_AC_PENALTY_CR_36 = 5;
const int FW_MIN_AC_PENALTY_CR_37 = 1; const int FW_MAX_AC_PENALTY_CR_37 = 5;
const int FW_MIN_AC_PENALTY_CR_38 = 1; const int FW_MAX_AC_PENALTY_CR_38 = 5;
const int FW_MIN_AC_PENALTY_CR_39 = 1; const int FW_MAX_AC_PENALTY_CR_39 = 5;
const int FW_MIN_AC_PENALTY_CR_40 = 1; const int FW_MAX_AC_PENALTY_CR_40 = 5;

const int FW_MIN_AC_PENALTY_CR_41_OR_HIGHER = 1; const int FW_MAX_AC_PENALTY_CR_41_OR_HIGHER = 5;

// SKILL_DECREASE
// The minimum and maximum SKILL_DECREASE values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,10
const int FW_MIN_SKILL_DECREASE_CR_0 = 1; const int FW_MAX_SKILL_DECREASE_CR_0 = 10;

const int FW_MIN_SKILL_DECREASE_CR_1 = 1; const int FW_MAX_SKILL_DECREASE_CR_1 = 10;
const int FW_MIN_SKILL_DECREASE_CR_2 = 1; const int FW_MAX_SKILL_DECREASE_CR_2 = 10;
const int FW_MIN_SKILL_DECREASE_CR_3 = 1; const int FW_MAX_SKILL_DECREASE_CR_3 = 10;
const int FW_MIN_SKILL_DECREASE_CR_4 = 1; const int FW_MAX_SKILL_DECREASE_CR_4 = 10;
const int FW_MIN_SKILL_DECREASE_CR_5 = 1; const int FW_MAX_SKILL_DECREASE_CR_5 = 10;
const int FW_MIN_SKILL_DECREASE_CR_6 = 1; const int FW_MAX_SKILL_DECREASE_CR_6 = 10;
const int FW_MIN_SKILL_DECREASE_CR_7 = 1; const int FW_MAX_SKILL_DECREASE_CR_7 = 10;
const int FW_MIN_SKILL_DECREASE_CR_8 = 1; const int FW_MAX_SKILL_DECREASE_CR_8 = 10;
const int FW_MIN_SKILL_DECREASE_CR_9 = 1; const int FW_MAX_SKILL_DECREASE_CR_9 = 10;
const int FW_MIN_SKILL_DECREASE_CR_10 = 1; const int FW_MAX_SKILL_DECREASE_CR_10 = 10;

const int FW_MIN_SKILL_DECREASE_CR_11 = 1; const int FW_MAX_SKILL_DECREASE_CR_11 = 10;
const int FW_MIN_SKILL_DECREASE_CR_12 = 1; const int FW_MAX_SKILL_DECREASE_CR_12 = 10;
const int FW_MIN_SKILL_DECREASE_CR_13 = 1; const int FW_MAX_SKILL_DECREASE_CR_13 = 10;
const int FW_MIN_SKILL_DECREASE_CR_14 = 1; const int FW_MAX_SKILL_DECREASE_CR_14 = 10;
const int FW_MIN_SKILL_DECREASE_CR_15 = 1; const int FW_MAX_SKILL_DECREASE_CR_15 = 10;
const int FW_MIN_SKILL_DECREASE_CR_16 = 1; const int FW_MAX_SKILL_DECREASE_CR_16 = 10;
const int FW_MIN_SKILL_DECREASE_CR_17 = 1; const int FW_MAX_SKILL_DECREASE_CR_17 = 10;
const int FW_MIN_SKILL_DECREASE_CR_18 = 1; const int FW_MAX_SKILL_DECREASE_CR_18 = 10;
const int FW_MIN_SKILL_DECREASE_CR_19 = 1; const int FW_MAX_SKILL_DECREASE_CR_19 = 10;
const int FW_MIN_SKILL_DECREASE_CR_20 = 1; const int FW_MAX_SKILL_DECREASE_CR_20 = 10;

const int FW_MIN_SKILL_DECREASE_CR_21 = 1; const int FW_MAX_SKILL_DECREASE_CR_21 = 10;
const int FW_MIN_SKILL_DECREASE_CR_22 = 1; const int FW_MAX_SKILL_DECREASE_CR_22 = 10;
const int FW_MIN_SKILL_DECREASE_CR_23 = 1; const int FW_MAX_SKILL_DECREASE_CR_23 = 10;
const int FW_MIN_SKILL_DECREASE_CR_24 = 1; const int FW_MAX_SKILL_DECREASE_CR_24 = 10;
const int FW_MIN_SKILL_DECREASE_CR_25 = 1; const int FW_MAX_SKILL_DECREASE_CR_25 = 10;
const int FW_MIN_SKILL_DECREASE_CR_26 = 1; const int FW_MAX_SKILL_DECREASE_CR_26 = 10;
const int FW_MIN_SKILL_DECREASE_CR_27 = 1; const int FW_MAX_SKILL_DECREASE_CR_27 = 10;
const int FW_MIN_SKILL_DECREASE_CR_28 = 1; const int FW_MAX_SKILL_DECREASE_CR_28 = 10;
const int FW_MIN_SKILL_DECREASE_CR_29 = 1; const int FW_MAX_SKILL_DECREASE_CR_29 = 10;
const int FW_MIN_SKILL_DECREASE_CR_30 = 1; const int FW_MAX_SKILL_DECREASE_CR_30 = 10;

const int FW_MIN_SKILL_DECREASE_CR_31 = 1; const int FW_MAX_SKILL_DECREASE_CR_31 = 10;
const int FW_MIN_SKILL_DECREASE_CR_32 = 1; const int FW_MAX_SKILL_DECREASE_CR_32 = 10;
const int FW_MIN_SKILL_DECREASE_CR_33 = 1; const int FW_MAX_SKILL_DECREASE_CR_33 = 10;
const int FW_MIN_SKILL_DECREASE_CR_34 = 1; const int FW_MAX_SKILL_DECREASE_CR_34 = 10;
const int FW_MIN_SKILL_DECREASE_CR_35 = 1; const int FW_MAX_SKILL_DECREASE_CR_35 = 10;
const int FW_MIN_SKILL_DECREASE_CR_36 = 1; const int FW_MAX_SKILL_DECREASE_CR_36 = 10;
const int FW_MIN_SKILL_DECREASE_CR_37 = 1; const int FW_MAX_SKILL_DECREASE_CR_37 = 10;
const int FW_MIN_SKILL_DECREASE_CR_38 = 1; const int FW_MAX_SKILL_DECREASE_CR_38 = 10;
const int FW_MIN_SKILL_DECREASE_CR_39 = 1; const int FW_MAX_SKILL_DECREASE_CR_39 = 10;
const int FW_MIN_SKILL_DECREASE_CR_40 = 1; const int FW_MAX_SKILL_DECREASE_CR_40 = 10;

const int FW_MIN_SKILL_DECREASE_CR_41_OR_HIGHER = 1; const int FW_MAX_SKILL_DECREASE_CR_41_OR_HIGHER = 10;

// ENHANCEMENT_BONUS
// The minimum and maximum ENHANCEMENT_BONUS values an item could have (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_ENHANCEMENT_BONUS_CR_0 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_0 = 1;

const int FW_MIN_ENHANCEMENT_BONUS_CR_1 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_1 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_CR_2 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_2 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_CR_3 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_3 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_CR_4 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_4 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_CR_5 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_5 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_CR_6 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_6 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_CR_7 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_7 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_CR_8 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_8 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_CR_9 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_9 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_CR_10 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_10 = 2;

const int FW_MIN_ENHANCEMENT_BONUS_CR_11 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_11 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_12 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_12 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_13 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_13 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_14 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_14 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_15 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_15 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_16 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_16 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_17 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_17 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_18 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_18 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_19 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_19 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_20 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_20 = 2;

const int FW_MIN_ENHANCEMENT_BONUS_CR_21 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_21 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_22 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_22 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_23 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_23 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_24 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_24 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_25 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_25 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_26 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_26 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_27 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_27 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_28 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_28 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_29 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_29 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_CR_30 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_30 = 2;

const int FW_MIN_ENHANCEMENT_BONUS_CR_31 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_31 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_CR_32 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_32 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_CR_33 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_33 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_CR_34 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_34 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_CR_35 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_35 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_CR_36 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_36 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_CR_37 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_37 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_CR_38 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_38 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_CR_39 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_39 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_CR_40 = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_40 = 3;

const int FW_MIN_ENHANCEMENT_BONUS_CR_41_OR_HIGHER = 1; const int FW_MAX_ENHANCEMENT_BONUS_CR_41_OR_HIGHER = 4;

// ENHANCEMENT_BONUS_VS_ALIGN
// The minimum and maximum ENHANCEMENT_BONUS_VS_ALIGN GROUP values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_0 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_0 = 2;

const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_1 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_1 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_2 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_2 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_3 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_3 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_4 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_4 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_5 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_5 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_6 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_6 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_7 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_7 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_8 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_8 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_9 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_9 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_10 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_10 = 2;

const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_11 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_11 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_12 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_12 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_13 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_13 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_14 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_14 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_15 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_15 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_16 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_16 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_17 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_17 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_18 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_18 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_19 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_19 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_20 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_20 = 2;

const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_21 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_21 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_22 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_22 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_23 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_23 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_24 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_24 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_25 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_25 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_26 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_26 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_27 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_27 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_28 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_28 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_29 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_29 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_30 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_30 = 3;

const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_31 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_31 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_32 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_32 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_33 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_33 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_34 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_34 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_35 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_35 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_36 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_36 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_37 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_37 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_38 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_38 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_39 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_39 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_40 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_40 = 4;

const int FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_41_OR_HIGHER = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_41_OR_HIGHER = 4;

// ENHANCEMENT_BONUS_VS_RACE
// The minimum and maximum ENHANCEMENT_BONUS_VS_RACE values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_0 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_0 = 2;

const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_1 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_1 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_2 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_2 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_3 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_3 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_4 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_4 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_5 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_5 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_6 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_6 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_7 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_7 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_8 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_8 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_9 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_9 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_10 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_10 = 2;

const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_11 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_11 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_12 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_12 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_13 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_13 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_14 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_14 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_15 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_15 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_16 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_16 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_17 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_17 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_18 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_18 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_19 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_19 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_20 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_20 = 3;

const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_21 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_21 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_22 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_22 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_23 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_23 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_24 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_24 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_25 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_25 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_26 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_26 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_27 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_27 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_28 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_28 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_29 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_29 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_30 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_30 = 4;

const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_31 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_31 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_32 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_32 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_33 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_33 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_34 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_34 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_35 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_35 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_36 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_36 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_37 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_37 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_38 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_38 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_39 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_39 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_40 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_40 = 4;

const int FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_41_OR_HIGHER = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_41_OR_HIGHER = 4;

// ENHANCEMENT_BONUS_VS_SALIGN
// The minimum and maximum ENHANCEMENT_BONUS_VS_SALIGN values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_0 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_0 = 1;

const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_1 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_1 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_2 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_2 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_3 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_3 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_4 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_4 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_5 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_5 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_6 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_6 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_7 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_7 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_8 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_8 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_9 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_9 = 1;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_10 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_10 = 2;

const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_11 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_11 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_12 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_12 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_13 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_13 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_14 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_14 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_15 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_15 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_16 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_16 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_17 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_17 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_18 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_18 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_19 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_19 = 2;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_20 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_20 = 2;

const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_21 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_21 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_22 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_22 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_23 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_23 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_24 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_24 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_25 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_25 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_26 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_26 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_27 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_27 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_28 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_28 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_29 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_29 = 3;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_30 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_30 = 3;

const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_31 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_31 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_32 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_32 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_33 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_33 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_34 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_34 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_35 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_35 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_36 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_36 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_37 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_37 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_38 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_38 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_39 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_39 = 4;
const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_40 = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_40 = 4;

const int FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_41_OR_HIGHER = 1; const int FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_41_OR_HIGHER = 4;

// ENHANCEMENT_PENALTY
// The minimum and maximum ENHANCEMENT_PENALTY values an item could have
// (for each CR level).
// Acceptable values: 1 TO 5.
const int FW_MIN_ENHANCEMENT_PENALTY_CR_0 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_0 = 5;

const int FW_MIN_ENHANCEMENT_PENALTY_CR_1 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_1 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_2 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_2 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_3 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_3 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_4 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_4 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_5 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_5 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_6 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_6 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_7 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_7 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_8 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_8 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_9 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_9 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_10 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_10 = 5;

const int FW_MIN_ENHANCEMENT_PENALTY_CR_11 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_11 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_12 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_12 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_13 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_13 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_14 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_14 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_15 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_15 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_16 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_16 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_17 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_17 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_18 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_18 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_19 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_19 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_20 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_20 = 5;

const int FW_MIN_ENHANCEMENT_PENALTY_CR_21 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_21 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_22 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_22 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_23 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_23 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_24 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_24 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_25 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_25 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_26 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_26 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_27 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_27 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_28 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_28 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_29 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_29 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_30 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_30 = 5;

const int FW_MIN_ENHANCEMENT_PENALTY_CR_31 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_31 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_32 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_32 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_33 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_33 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_34 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_34 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_35 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_35 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_36 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_36 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_37 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_37 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_38 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_38 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_39 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_39 = 5;
const int FW_MIN_ENHANCEMENT_PENALTY_CR_40 = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_40 = 5;

const int FW_MIN_ENHANCEMENT_PENALTY_CR_41_OR_HIGHER = 1; const int FW_MAX_ENHANCEMENT_PENALTY_CR_41_OR_HIGHER = 5;

// * ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE
// There is no min/max switch. Edit the function: FW_Choose_IP_Extra_Melee_Damage_Type()
// if you want to change anything.

// * ITEM_PROPERTY_EXTRA_RANGE_DAMAGE_TYPE
// There is no switch. Edit the function: FW_Choose_IP_Extra_Range_Damage_Type
// if you want to change anything.

// HEALER_KIT
// The minimum and maximum HEALER_KIT values an item could have (for each CR level).
// Acceptable values: 1,2,3,...,12
const int FW_MIN_HEALER_KIT_CR_0 = 1; const int FW_MAX_HEALER_KIT_CR_0 = 3;

const int FW_MIN_HEALER_KIT_CR_1 = 1; const int FW_MAX_HEALER_KIT_CR_1 = 3;
const int FW_MIN_HEALER_KIT_CR_2 = 1; const int FW_MAX_HEALER_KIT_CR_2 = 3;
const int FW_MIN_HEALER_KIT_CR_3 = 1; const int FW_MAX_HEALER_KIT_CR_3 = 3;
const int FW_MIN_HEALER_KIT_CR_4 = 1; const int FW_MAX_HEALER_KIT_CR_4 = 3;
const int FW_MIN_HEALER_KIT_CR_5 = 1; const int FW_MAX_HEALER_KIT_CR_5 = 3;
const int FW_MIN_HEALER_KIT_CR_6 = 1; const int FW_MAX_HEALER_KIT_CR_6 = 3;
const int FW_MIN_HEALER_KIT_CR_7 = 1; const int FW_MAX_HEALER_KIT_CR_7 = 3;
const int FW_MIN_HEALER_KIT_CR_8 = 1; const int FW_MAX_HEALER_KIT_CR_8 = 3;
const int FW_MIN_HEALER_KIT_CR_9 = 1; const int FW_MAX_HEALER_KIT_CR_9 = 3;
const int FW_MIN_HEALER_KIT_CR_10 = 1; const int FW_MAX_HEALER_KIT_CR_10 = 3;

const int FW_MIN_HEALER_KIT_CR_11 = 1; const int FW_MAX_HEALER_KIT_CR_11 = 6;
const int FW_MIN_HEALER_KIT_CR_12 = 1; const int FW_MAX_HEALER_KIT_CR_12 = 6;
const int FW_MIN_HEALER_KIT_CR_13 = 1; const int FW_MAX_HEALER_KIT_CR_13 = 6;
const int FW_MIN_HEALER_KIT_CR_14 = 1; const int FW_MAX_HEALER_KIT_CR_14 = 6;
const int FW_MIN_HEALER_KIT_CR_15 = 1; const int FW_MAX_HEALER_KIT_CR_15 = 6;
const int FW_MIN_HEALER_KIT_CR_16 = 1; const int FW_MAX_HEALER_KIT_CR_16 = 6;
const int FW_MIN_HEALER_KIT_CR_17 = 1; const int FW_MAX_HEALER_KIT_CR_17 = 6;
const int FW_MIN_HEALER_KIT_CR_18 = 1; const int FW_MAX_HEALER_KIT_CR_18 = 6;
const int FW_MIN_HEALER_KIT_CR_19 = 1; const int FW_MAX_HEALER_KIT_CR_19 = 6;
const int FW_MIN_HEALER_KIT_CR_20 = 1; const int FW_MAX_HEALER_KIT_CR_20 = 6;

const int FW_MIN_HEALER_KIT_CR_21 = 1; const int FW_MAX_HEALER_KIT_CR_21 = 12;
const int FW_MIN_HEALER_KIT_CR_22 = 1; const int FW_MAX_HEALER_KIT_CR_22 = 12;
const int FW_MIN_HEALER_KIT_CR_23 = 1; const int FW_MAX_HEALER_KIT_CR_23 = 12;
const int FW_MIN_HEALER_KIT_CR_24 = 1; const int FW_MAX_HEALER_KIT_CR_24 = 12;
const int FW_MIN_HEALER_KIT_CR_25 = 1; const int FW_MAX_HEALER_KIT_CR_25 = 12;
const int FW_MIN_HEALER_KIT_CR_26 = 1; const int FW_MAX_HEALER_KIT_CR_26 = 12;
const int FW_MIN_HEALER_KIT_CR_27 = 1; const int FW_MAX_HEALER_KIT_CR_27 = 12;
const int FW_MIN_HEALER_KIT_CR_28 = 1; const int FW_MAX_HEALER_KIT_CR_28 = 12;
const int FW_MIN_HEALER_KIT_CR_29 = 1; const int FW_MAX_HEALER_KIT_CR_29 = 12;
const int FW_MIN_HEALER_KIT_CR_30 = 1; const int FW_MAX_HEALER_KIT_CR_30 = 12;

const int FW_MIN_HEALER_KIT_CR_31 = 1; const int FW_MAX_HEALER_KIT_CR_31 = 12;
const int FW_MIN_HEALER_KIT_CR_32 = 1; const int FW_MAX_HEALER_KIT_CR_32 = 12;
const int FW_MIN_HEALER_KIT_CR_33 = 1; const int FW_MAX_HEALER_KIT_CR_33 = 12;
const int FW_MIN_HEALER_KIT_CR_34 = 1; const int FW_MAX_HEALER_KIT_CR_34 = 12;
const int FW_MIN_HEALER_KIT_CR_35 = 1; const int FW_MAX_HEALER_KIT_CR_35 = 12;
const int FW_MIN_HEALER_KIT_CR_36 = 1; const int FW_MAX_HEALER_KIT_CR_36 = 12;
const int FW_MIN_HEALER_KIT_CR_37 = 1; const int FW_MAX_HEALER_KIT_CR_37 = 12;
const int FW_MIN_HEALER_KIT_CR_38 = 1; const int FW_MAX_HEALER_KIT_CR_38 = 12;
const int FW_MIN_HEALER_KIT_CR_39 = 1; const int FW_MAX_HEALER_KIT_CR_39 = 12;
const int FW_MIN_HEALER_KIT_CR_40 = 1; const int FW_MAX_HEALER_KIT_CR_40 = 12;

const int FW_MIN_HEALER_KIT_CR_41_OR_HIGHER = 1; const int FW_MAX_HEALER_KIT_CR_41_OR_HIGHER = 12;

// * ITEM_PROPERTY_IMMUNITY_MISC
// If you want to disallow ALL immunities from appearing on an item change the 
// above statement to FALSE. 
// If you want to exclude SOME, but not all then comment out the unwanted 
// immunity(s) inside the function: FW_Choose_IP_Immunity_Misc and leave the above 
// set to TRUE.

// IMMUNITY_TO_SPELL_LEVEL
// The minimum and maximum IMMUNITY_TO_SPELL_LEVEL values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,9
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_0 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_0 = 2;

const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_1 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_1 = 2;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_2 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_2 = 2;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_3 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_3 = 2;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_4 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_4 = 2;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_5 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_5 = 2;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_6 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_6 = 2;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_7 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_7 = 2;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_8 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_8 = 3;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_9 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_9 = 3;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_10 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_10 = 3;

const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_11 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_11 = 4;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_12 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_12 = 4;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_13 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_13 = 4;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_14 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_14 = 4;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_15 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_15 = 4;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_16 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_16 = 4;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_17 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_17 = 4;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_18 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_18 = 4;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_19 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_19 = 5;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_20 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_20 = 5;

const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_21 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_21 = 5;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_22 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_22 = 5;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_23 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_23 = 5;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_24 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_24 = 5;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_25 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_25 = 6;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_26 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_26 = 6;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_27 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_27 = 6;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_28 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_28 = 6;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_29 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_29 = 7;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_30 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_30 = 7;

const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_31 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_31 = 8;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_32 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_32 = 8;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_33 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_33 = 8;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_34 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_34 = 8;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_35 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_35 = 8;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_36 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_36 = 8;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_37 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_37 = 8;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_38 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_38 = 8;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_39 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_39 = 8;
const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_40 = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_40 = 8;

const int FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_41_OR_HIGHER = 1; const int FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_41_OR_HIGHER = 9;

// * ITEM_PROPERTY_LIGHT
// There is no switch to control the brightness or color of light that could be
// added to an item.  To disallow a light brightness or color, comment out the
// case statements inside function: FW_Choose_IP_Light ();

// * ITEM_PROPERTY_LIMIT_USE_BY_ALIGN
// * ITEM_PROPERTY_LIMIT_USE_BY_CLASS
// * ITEM_PROPERTY_LIMIT_USE_BY_RACE
// * ITEM_PROPERTY_LIMIT_USE_BY_SALIGN
// There is no switch to control specifics of the four item properties above.  I can't see
// why someone would want to allow some limitations but not others.  If you want
// to disallow specifics, then go edit the functions: FW_Choose_IP_Limit_Use_By_*

// MIGHTY_BONUS
// The minimum and maximum MIGHTY_BONUS values an item could have (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_MIGHTY_BONUS_CR_0 = 1; const int FW_MAX_MIGHTY_BONUS_CR_0 = 2;

const int FW_MIN_MIGHTY_BONUS_CR_1 = 1; const int FW_MAX_MIGHTY_BONUS_CR_1 = 2;
const int FW_MIN_MIGHTY_BONUS_CR_2 = 1; const int FW_MAX_MIGHTY_BONUS_CR_2 = 2;
const int FW_MIN_MIGHTY_BONUS_CR_3 = 1; const int FW_MAX_MIGHTY_BONUS_CR_3 = 2;
const int FW_MIN_MIGHTY_BONUS_CR_4 = 1; const int FW_MAX_MIGHTY_BONUS_CR_4 = 2;
const int FW_MIN_MIGHTY_BONUS_CR_5 = 1; const int FW_MAX_MIGHTY_BONUS_CR_5 = 2;
const int FW_MIN_MIGHTY_BONUS_CR_6 = 1; const int FW_MAX_MIGHTY_BONUS_CR_6 = 2;
const int FW_MIN_MIGHTY_BONUS_CR_7 = 1; const int FW_MAX_MIGHTY_BONUS_CR_7 = 2;
const int FW_MIN_MIGHTY_BONUS_CR_8 = 1; const int FW_MAX_MIGHTY_BONUS_CR_8 = 2;
const int FW_MIN_MIGHTY_BONUS_CR_9 = 1; const int FW_MAX_MIGHTY_BONUS_CR_9 = 2;
const int FW_MIN_MIGHTY_BONUS_CR_10 = 1; const int FW_MAX_MIGHTY_BONUS_CR_10 = 2;

const int FW_MIN_MIGHTY_BONUS_CR_11 = 1; const int FW_MAX_MIGHTY_BONUS_CR_11 = 3;
const int FW_MIN_MIGHTY_BONUS_CR_12 = 1; const int FW_MAX_MIGHTY_BONUS_CR_12 = 3;
const int FW_MIN_MIGHTY_BONUS_CR_13 = 1; const int FW_MAX_MIGHTY_BONUS_CR_13 = 3;
const int FW_MIN_MIGHTY_BONUS_CR_14 = 1; const int FW_MAX_MIGHTY_BONUS_CR_14 = 3;
const int FW_MIN_MIGHTY_BONUS_CR_15 = 1; const int FW_MAX_MIGHTY_BONUS_CR_15 = 3;
const int FW_MIN_MIGHTY_BONUS_CR_16 = 1; const int FW_MAX_MIGHTY_BONUS_CR_16 = 4;
const int FW_MIN_MIGHTY_BONUS_CR_17 = 1; const int FW_MAX_MIGHTY_BONUS_CR_17 = 4;
const int FW_MIN_MIGHTY_BONUS_CR_18 = 1; const int FW_MAX_MIGHTY_BONUS_CR_18 = 4;
const int FW_MIN_MIGHTY_BONUS_CR_19 = 1; const int FW_MAX_MIGHTY_BONUS_CR_19 = 4;
const int FW_MIN_MIGHTY_BONUS_CR_20 = 1; const int FW_MAX_MIGHTY_BONUS_CR_20 = 4;

const int FW_MIN_MIGHTY_BONUS_CR_21 = 1; const int FW_MAX_MIGHTY_BONUS_CR_21 = 5;
const int FW_MIN_MIGHTY_BONUS_CR_22 = 1; const int FW_MAX_MIGHTY_BONUS_CR_22 = 5;
const int FW_MIN_MIGHTY_BONUS_CR_23 = 1; const int FW_MAX_MIGHTY_BONUS_CR_23 = 5;
const int FW_MIN_MIGHTY_BONUS_CR_24 = 1; const int FW_MAX_MIGHTY_BONUS_CR_24 = 5;
const int FW_MIN_MIGHTY_BONUS_CR_25 = 1; const int FW_MAX_MIGHTY_BONUS_CR_25 = 5;
const int FW_MIN_MIGHTY_BONUS_CR_26 = 1; const int FW_MAX_MIGHTY_BONUS_CR_26 = 5;
const int FW_MIN_MIGHTY_BONUS_CR_27 = 1; const int FW_MAX_MIGHTY_BONUS_CR_27 = 5;
const int FW_MIN_MIGHTY_BONUS_CR_28 = 1; const int FW_MAX_MIGHTY_BONUS_CR_28 = 5;
const int FW_MIN_MIGHTY_BONUS_CR_29 = 1; const int FW_MAX_MIGHTY_BONUS_CR_29 = 5;
const int FW_MIN_MIGHTY_BONUS_CR_30 = 1; const int FW_MAX_MIGHTY_BONUS_CR_30 = 5;

const int FW_MIN_MIGHTY_BONUS_CR_31 = 1; const int FW_MAX_MIGHTY_BONUS_CR_31 = 6;
const int FW_MIN_MIGHTY_BONUS_CR_32 = 1; const int FW_MAX_MIGHTY_BONUS_CR_32 = 6;
const int FW_MIN_MIGHTY_BONUS_CR_33 = 1; const int FW_MAX_MIGHTY_BONUS_CR_33 = 6;
const int FW_MIN_MIGHTY_BONUS_CR_34 = 1; const int FW_MAX_MIGHTY_BONUS_CR_34 = 6;
const int FW_MIN_MIGHTY_BONUS_CR_35 = 1; const int FW_MAX_MIGHTY_BONUS_CR_35 = 6;
const int FW_MIN_MIGHTY_BONUS_CR_36 = 1; const int FW_MAX_MIGHTY_BONUS_CR_36 = 6;
const int FW_MIN_MIGHTY_BONUS_CR_37 = 1; const int FW_MAX_MIGHTY_BONUS_CR_37 = 6;
const int FW_MIN_MIGHTY_BONUS_CR_38 = 1; const int FW_MAX_MIGHTY_BONUS_CR_38 = 6;
const int FW_MIN_MIGHTY_BONUS_CR_39 = 1; const int FW_MAX_MIGHTY_BONUS_CR_39 = 6;
const int FW_MIN_MIGHTY_BONUS_CR_40 = 1; const int FW_MAX_MIGHTY_BONUS_CR_40 = 6;

const int FW_MIN_MIGHTY_BONUS_CR_41_OR_HIGHER = 1; const int FW_MAX_MIGHTY_BONUS_CR_41_OR_HIGHER = 6;

// * ITEM_PROPERTY_ON_HIT_CAST_SPELL
// I saw no easy way to have a switch to allow/disallow certain spells from the
// item property OnHitCastSpell.  By default the function that chooses the prop.
// OnHitCastSpell will choose from every single spell available (there are lots)
// If you want to disallow certain spells from being added to an item, then you
// need to go into the function: FW_Choose_IP_On_Hit_Cast_Spell and comment out
// the case statements for the spells you don't want to be included. 

// ON_HIT_SPELL_LEVEL
// This is in conjunction with On Hit Cast Spell.  It must be determined what spell level
// your on hit spell is cast at (for things like breaking down spell mantles, etc). You could 
// allow on hit cast spells, but limit the level here if you wanted. If you disallowed on hit
// cast spell entirely in the file "fw_inc_switches" then it doesn't matter what these values are.
// The minimum and maximum ON_HIT_SPELL_LEVEL values an item could have (for each CR level).
// Acceptable values: 1,2,3,...,9
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_0 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_0 = 1;

const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_1 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_1 = 1;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_2 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_2 = 1;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_3 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_3 = 1;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_4 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_4 = 1;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_5 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_5 = 1;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_6 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_6 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_7 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_7 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_8 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_8 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_9 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_9 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_10 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_10 = 2;

const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_11 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_11 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_12 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_12 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_13 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_13 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_14 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_14 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_15 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_15 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_16 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_16 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_17 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_17 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_18 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_18 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_19 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_19 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_20 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_20 = 2;

const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_21 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_21 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_22 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_22 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_23 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_23 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_24 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_24 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_25 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_25 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_26 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_26 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_27 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_27 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_28 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_28 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_29 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_29 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_30 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_30 = 2;

const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_31 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_31 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_32 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_32 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_33 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_33 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_34 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_34 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_35 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_35 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_36 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_36 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_37 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_37 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_38 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_38 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_39 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_39 = 2;
const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_40 = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_40 = 2;

const int FW_MIN_ON_HIT_SPELL_LEVEL_CR_41_OR_HIGHER = 1; const int FW_MAX_ON_HIT_SPELL_LEVEL_CR_41_OR_HIGHER = 2; 

// * ITEM_PROPERTY_ON_HIT_PROPS
// Same description basically as on hit cast spell.  Either comment out specifics
// inside the function: FW_Choose_IP_On_Hit_Props or change to FALSE to exclude 
// everything.

// ON_HIT_SAVE_DC
// This goes in conjunction with On Hit Props. Some of the onhitprops have save DC components.
// If you disallowed on hit props entirley, then these values don't matter.
// The minimum and maximum ON_HIT_SAVE_DC values an item could have
// (for each CR level).
// Acceptable values: 14,16,18,20,22,24, or 26.  Nothing else.
const int FW_MIN_ON_HIT_SAVE_DC_CR_0 = 1; const int FW_MAX_ON_HIT_SAVE_DC_CR_0 = 14;

const int FW_MIN_ON_HIT_SAVE_DC_CR_1 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_1 = 14;
const int FW_MIN_ON_HIT_SAVE_DC_CR_2 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_2 = 14;
const int FW_MIN_ON_HIT_SAVE_DC_CR_3 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_3 = 14;
const int FW_MIN_ON_HIT_SAVE_DC_CR_4 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_4 = 14;
const int FW_MIN_ON_HIT_SAVE_DC_CR_5 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_5 = 14;
const int FW_MIN_ON_HIT_SAVE_DC_CR_6 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_6 = 14;
const int FW_MIN_ON_HIT_SAVE_DC_CR_7 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_7 = 14;
const int FW_MIN_ON_HIT_SAVE_DC_CR_8 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_8 = 14;
const int FW_MIN_ON_HIT_SAVE_DC_CR_9 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_9 = 16;
const int FW_MIN_ON_HIT_SAVE_DC_CR_10 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_10 = 16;

const int FW_MIN_ON_HIT_SAVE_DC_CR_11 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_11 = 16;
const int FW_MIN_ON_HIT_SAVE_DC_CR_12 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_12 = 16;
const int FW_MIN_ON_HIT_SAVE_DC_CR_13 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_13 = 16;
const int FW_MIN_ON_HIT_SAVE_DC_CR_14 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_14 = 16;
const int FW_MIN_ON_HIT_SAVE_DC_CR_15 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_15 = 16;
const int FW_MIN_ON_HIT_SAVE_DC_CR_16 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_16 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_17 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_17 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_18 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_18 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_19 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_19 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_20 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_20 = 18;

const int FW_MIN_ON_HIT_SAVE_DC_CR_21 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_21 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_22 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_22 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_23 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_23 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_24 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_24 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_25 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_25 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_26 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_26 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_27 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_27 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_28 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_28 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_29 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_29 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_30 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_30 = 18;

const int FW_MIN_ON_HIT_SAVE_DC_CR_31 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_31 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_32 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_32 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_33 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_33 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_34 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_34 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_35 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_35 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_36 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_36 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_37 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_37 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_38 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_38 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_39 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_39 = 18;
const int FW_MIN_ON_HIT_SAVE_DC_CR_40 = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_40 = 18;

const int FW_MIN_ON_HIT_SAVE_DC_CR_41_OR_HIGHER = 14; const int FW_MAX_ON_HIT_SAVE_DC_CR_41_OR_HIGHER = 18;

// SAVING_THROW_PENALTY
// The minimum and maximum SAVING_THROW_PENALTY values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_SAVING_THROW_PENALTY_CR_0 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_0 = 2;

const int FW_MIN_SAVING_THROW_PENALTY_CR_1 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_1 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_CR_2 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_2 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_CR_3 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_3 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_CR_4 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_4 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_CR_5 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_5 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_CR_6 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_6 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_CR_7 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_7 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_CR_8 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_8 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_CR_9 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_9 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_CR_10 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_10 = 2;

const int FW_MIN_SAVING_THROW_PENALTY_CR_11 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_11 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_12 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_12 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_13 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_13 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_14 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_14 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_15 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_15 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_16 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_16 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_17 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_17 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_18 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_18 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_19 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_19 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_20 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_20 = 3;

const int FW_MIN_SAVING_THROW_PENALTY_CR_21 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_21 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_22 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_22 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_23 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_23 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_24 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_24 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_25 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_25 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_26 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_26 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_27 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_27 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_28 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_28 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_29 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_29 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_30 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_30 = 3;

const int FW_MIN_SAVING_THROW_PENALTY_CR_31 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_31 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_32 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_32 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_33 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_33 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_34 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_34 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_35 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_35 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_36 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_36 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_37 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_37 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_38 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_38 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_39 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_39 = 3;
const int FW_MIN_SAVING_THROW_PENALTY_CR_40 = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_40 = 3;

const int FW_MIN_SAVING_THROW_PENALTY_CR_41_OR_HIGHER = 1; const int FW_MAX_SAVING_THROW_PENALTY_CR_41_OR_HIGHER = 3;

// SAVING_THROW_PENALTY_VSX
// The minimum and maximum SAVING_THROW_PENALTY_VSX values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_0 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_0 = 2;

const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_1 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_1 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_2 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_2 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_3 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_3 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_4 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_4 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_5 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_5 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_6 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_6 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_7 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_7 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_8 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_8 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_9 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_9 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_10 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_10 = 2;

const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_11 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_11 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_12 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_12 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_13 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_13 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_14 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_14 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_15 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_15 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_16 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_16 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_17 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_17 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_18 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_18 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_19 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_19 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_20 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_20 = 2;

const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_21 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_21 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_22 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_22 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_23 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_23 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_24 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_24 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_25 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_25 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_26 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_26 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_27 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_27 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_28 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_28 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_29 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_29 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_30 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_30 = 2;

const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_31 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_31 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_32 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_32 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_33 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_33 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_34 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_34 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_35 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_35 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_36 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_36 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_37 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_37 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_38 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_38 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_39 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_39 = 2;
const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_40 = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_40 = 2;

const int FW_MIN_SAVING_THROW_PENALTY_VSX_CR_41_OR_HIGHER = 1; const int FW_MAX_SAVING_THROW_PENALTY_VSX_CR_41_OR_HIGHER = 2;

// REGENERATION
// The minimum and maximum REGENERATION values an item could have (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_REGENERATION_CR_0 = 1; const int FW_MAX_REGENERATION_CR_0 = 1;

const int FW_MIN_REGENERATION_CR_1 = 1; const int FW_MAX_REGENERATION_CR_1 = 1;
const int FW_MIN_REGENERATION_CR_2 = 1; const int FW_MAX_REGENERATION_CR_2 = 1;
const int FW_MIN_REGENERATION_CR_3 = 1; const int FW_MAX_REGENERATION_CR_3 = 1;
const int FW_MIN_REGENERATION_CR_4 = 1; const int FW_MAX_REGENERATION_CR_4 = 1;
const int FW_MIN_REGENERATION_CR_5 = 1; const int FW_MAX_REGENERATION_CR_5 = 1;
const int FW_MIN_REGENERATION_CR_6 = 1; const int FW_MAX_REGENERATION_CR_6 = 1;
const int FW_MIN_REGENERATION_CR_7 = 1; const int FW_MAX_REGENERATION_CR_7 = 1;
const int FW_MIN_REGENERATION_CR_8 = 1; const int FW_MAX_REGENERATION_CR_8 = 1;
const int FW_MIN_REGENERATION_CR_9 = 1; const int FW_MAX_REGENERATION_CR_9 = 1;
const int FW_MIN_REGENERATION_CR_10 = 1; const int FW_MAX_REGENERATION_CR_10 = 1;

const int FW_MIN_REGENERATION_CR_11 = 1; const int FW_MAX_REGENERATION_CR_11 = 1;
const int FW_MIN_REGENERATION_CR_12 = 1; const int FW_MAX_REGENERATION_CR_12 = 1;
const int FW_MIN_REGENERATION_CR_13 = 1; const int FW_MAX_REGENERATION_CR_13 = 1;
const int FW_MIN_REGENERATION_CR_14 = 1; const int FW_MAX_REGENERATION_CR_14 = 1;
const int FW_MIN_REGENERATION_CR_15 = 1; const int FW_MAX_REGENERATION_CR_15 = 1;
const int FW_MIN_REGENERATION_CR_16 = 1; const int FW_MAX_REGENERATION_CR_16 = 1;
const int FW_MIN_REGENERATION_CR_17 = 1; const int FW_MAX_REGENERATION_CR_17 = 1;
const int FW_MIN_REGENERATION_CR_18 = 1; const int FW_MAX_REGENERATION_CR_18 = 1;
const int FW_MIN_REGENERATION_CR_19 = 1; const int FW_MAX_REGENERATION_CR_19 = 1;
const int FW_MIN_REGENERATION_CR_20 = 1; const int FW_MAX_REGENERATION_CR_20 = 1;

const int FW_MIN_REGENERATION_CR_21 = 1; const int FW_MAX_REGENERATION_CR_21 = 1;
const int FW_MIN_REGENERATION_CR_22 = 1; const int FW_MAX_REGENERATION_CR_22 = 1;
const int FW_MIN_REGENERATION_CR_23 = 1; const int FW_MAX_REGENERATION_CR_23 = 1;
const int FW_MIN_REGENERATION_CR_24 = 1; const int FW_MAX_REGENERATION_CR_24 = 1;
const int FW_MIN_REGENERATION_CR_25 = 1; const int FW_MAX_REGENERATION_CR_25 = 1;
const int FW_MIN_REGENERATION_CR_26 = 1; const int FW_MAX_REGENERATION_CR_26 = 1;
const int FW_MIN_REGENERATION_CR_27 = 1; const int FW_MAX_REGENERATION_CR_27 = 1;
const int FW_MIN_REGENERATION_CR_28 = 1; const int FW_MAX_REGENERATION_CR_28 = 1;
const int FW_MIN_REGENERATION_CR_29 = 1; const int FW_MAX_REGENERATION_CR_29 = 1;
const int FW_MIN_REGENERATION_CR_30 = 1; const int FW_MAX_REGENERATION_CR_30 = 1;

const int FW_MIN_REGENERATION_CR_31 = 1; const int FW_MAX_REGENERATION_CR_31 = 1;
const int FW_MIN_REGENERATION_CR_32 = 1; const int FW_MAX_REGENERATION_CR_32 = 1;
const int FW_MIN_REGENERATION_CR_33 = 1; const int FW_MAX_REGENERATION_CR_33 = 1;
const int FW_MIN_REGENERATION_CR_34 = 1; const int FW_MAX_REGENERATION_CR_34 = 1;
const int FW_MIN_REGENERATION_CR_35 = 1; const int FW_MAX_REGENERATION_CR_35 = 1;
const int FW_MIN_REGENERATION_CR_36 = 1; const int FW_MAX_REGENERATION_CR_36 = 1;
const int FW_MIN_REGENERATION_CR_37 = 1; const int FW_MAX_REGENERATION_CR_37 = 1;
const int FW_MIN_REGENERATION_CR_38 = 1; const int FW_MAX_REGENERATION_CR_38 = 1;
const int FW_MIN_REGENERATION_CR_39 = 1; const int FW_MAX_REGENERATION_CR_39 = 1;
const int FW_MIN_REGENERATION_CR_40 = 1; const int FW_MAX_REGENERATION_CR_40 = 1;

const int FW_MIN_REGENERATION_CR_41_OR_HIGHER = 1; const int FW_MAX_REGENERATION_CR_41_OR_HIGHER = 1;

// SKILL_BONUS
// The minimum and maximum SKILL_BONUS values an item could have (for each CR level).
// Acceptable values: 1,2,3,...,50
const int FW_MIN_SKILL_BONUS_CR_0 = 1; const int FW_MAX_SKILL_BONUS_CR_0 = 1;

const int FW_MIN_SKILL_BONUS_CR_1 = 1; const int FW_MAX_SKILL_BONUS_CR_1 = 1;
const int FW_MIN_SKILL_BONUS_CR_2 = 1; const int FW_MAX_SKILL_BONUS_CR_2 = 1;
const int FW_MIN_SKILL_BONUS_CR_3 = 1; const int FW_MAX_SKILL_BONUS_CR_3 = 1;
const int FW_MIN_SKILL_BONUS_CR_4 = 1; const int FW_MAX_SKILL_BONUS_CR_4 = 1;
const int FW_MIN_SKILL_BONUS_CR_5 = 1; const int FW_MAX_SKILL_BONUS_CR_5 = 1;
const int FW_MIN_SKILL_BONUS_CR_6 = 1; const int FW_MAX_SKILL_BONUS_CR_6 = 1;
const int FW_MIN_SKILL_BONUS_CR_7 = 1; const int FW_MAX_SKILL_BONUS_CR_7 = 2;
const int FW_MIN_SKILL_BONUS_CR_8 = 1; const int FW_MAX_SKILL_BONUS_CR_8 = 2;
const int FW_MIN_SKILL_BONUS_CR_9 = 1; const int FW_MAX_SKILL_BONUS_CR_9 = 2;
const int FW_MIN_SKILL_BONUS_CR_10 = 1; const int FW_MAX_SKILL_BONUS_CR_10 = 2;

const int FW_MIN_SKILL_BONUS_CR_11 = 1; const int FW_MAX_SKILL_BONUS_CR_11 = 2;
const int FW_MIN_SKILL_BONUS_CR_12 = 1; const int FW_MAX_SKILL_BONUS_CR_12 = 2;
const int FW_MIN_SKILL_BONUS_CR_13 = 1; const int FW_MAX_SKILL_BONUS_CR_13 = 2;
const int FW_MIN_SKILL_BONUS_CR_14 = 1; const int FW_MAX_SKILL_BONUS_CR_14 = 2;
const int FW_MIN_SKILL_BONUS_CR_15 = 1; const int FW_MAX_SKILL_BONUS_CR_15 = 3;
const int FW_MIN_SKILL_BONUS_CR_16 = 1; const int FW_MAX_SKILL_BONUS_CR_16 = 3;
const int FW_MIN_SKILL_BONUS_CR_17 = 1; const int FW_MAX_SKILL_BONUS_CR_17 = 3;
const int FW_MIN_SKILL_BONUS_CR_18 = 1; const int FW_MAX_SKILL_BONUS_CR_18 = 3;
const int FW_MIN_SKILL_BONUS_CR_19 = 1; const int FW_MAX_SKILL_BONUS_CR_19 = 3;
const int FW_MIN_SKILL_BONUS_CR_20 = 1; const int FW_MAX_SKILL_BONUS_CR_20 = 4;

const int FW_MIN_SKILL_BONUS_CR_21 = 1; const int FW_MAX_SKILL_BONUS_CR_21 = 4;
const int FW_MIN_SKILL_BONUS_CR_22 = 1; const int FW_MAX_SKILL_BONUS_CR_22 = 4;
const int FW_MIN_SKILL_BONUS_CR_23 = 1; const int FW_MAX_SKILL_BONUS_CR_23 = 4;
const int FW_MIN_SKILL_BONUS_CR_24 = 1; const int FW_MAX_SKILL_BONUS_CR_24 = 4;
const int FW_MIN_SKILL_BONUS_CR_25 = 1; const int FW_MAX_SKILL_BONUS_CR_25 = 4;
const int FW_MIN_SKILL_BONUS_CR_26 = 1; const int FW_MAX_SKILL_BONUS_CR_26 = 4;
const int FW_MIN_SKILL_BONUS_CR_27 = 1; const int FW_MAX_SKILL_BONUS_CR_27 = 4;
const int FW_MIN_SKILL_BONUS_CR_28 = 1; const int FW_MAX_SKILL_BONUS_CR_28 = 4;
const int FW_MIN_SKILL_BONUS_CR_29 = 1; const int FW_MAX_SKILL_BONUS_CR_29 = 4;
const int FW_MIN_SKILL_BONUS_CR_30 = 1; const int FW_MAX_SKILL_BONUS_CR_30 = 4;

const int FW_MIN_SKILL_BONUS_CR_31 = 1; const int FW_MAX_SKILL_BONUS_CR_31 = 4;
const int FW_MIN_SKILL_BONUS_CR_32 = 1; const int FW_MAX_SKILL_BONUS_CR_32 = 4;
const int FW_MIN_SKILL_BONUS_CR_33 = 1; const int FW_MAX_SKILL_BONUS_CR_33 = 4;
const int FW_MIN_SKILL_BONUS_CR_34 = 1; const int FW_MAX_SKILL_BONUS_CR_34 = 4;
const int FW_MIN_SKILL_BONUS_CR_35 = 1; const int FW_MAX_SKILL_BONUS_CR_35 = 4;
const int FW_MIN_SKILL_BONUS_CR_36 = 1; const int FW_MAX_SKILL_BONUS_CR_36 = 4;
const int FW_MIN_SKILL_BONUS_CR_37 = 1; const int FW_MAX_SKILL_BONUS_CR_37 = 4;
const int FW_MIN_SKILL_BONUS_CR_38 = 1; const int FW_MAX_SKILL_BONUS_CR_38 = 4;
const int FW_MIN_SKILL_BONUS_CR_39 = 1; const int FW_MAX_SKILL_BONUS_CR_39 = 4;
const int FW_MIN_SKILL_BONUS_CR_40 = 1; const int FW_MAX_SKILL_BONUS_CR_40 = 4;

const int FW_MIN_SKILL_BONUS_CR_41_OR_HIGHER = 1; const int FW_MAX_SKILL_BONUS_CR_41_OR_HIGHER = 4;

// * ITEM_PROPERTY_SPELL_IMMUNITY_SCHOOL
// * ITEM_PROPERTY_SPELL_IMMUNITY_SPECIFIC
// There is no switch to control min/max for the above two item properties.  
// You can disallow individual items by editing the functions:
// FW_Choose_IP_Spell_Immunity_School  and  FW_Choose_Spell_Immunity_Specific.

// THIEVES_TOOLS
// The minimum and maximum THIEVES_TOOLS values an item could have (for each CR level).
// Acceptable values: 1,2,3,...,12
const int FW_MIN_THIEVES_TOOLS_CR_0 = 1; const int FW_MAX_THIEVES_TOOLS_CR_0 = 12;

const int FW_MIN_THIEVES_TOOLS_CR_1 = 1; const int FW_MAX_THIEVES_TOOLS_CR_1 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_2 = 1; const int FW_MAX_THIEVES_TOOLS_CR_2 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_3 = 1; const int FW_MAX_THIEVES_TOOLS_CR_3 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_4 = 1; const int FW_MAX_THIEVES_TOOLS_CR_4 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_5 = 1; const int FW_MAX_THIEVES_TOOLS_CR_5 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_6 = 1; const int FW_MAX_THIEVES_TOOLS_CR_6 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_7 = 1; const int FW_MAX_THIEVES_TOOLS_CR_7 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_8 = 1; const int FW_MAX_THIEVES_TOOLS_CR_8 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_9 = 1; const int FW_MAX_THIEVES_TOOLS_CR_9 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_10 = 1; const int FW_MAX_THIEVES_TOOLS_CR_10 = 12;

const int FW_MIN_THIEVES_TOOLS_CR_11 = 1; const int FW_MAX_THIEVES_TOOLS_CR_11 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_12 = 1; const int FW_MAX_THIEVES_TOOLS_CR_12 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_13 = 1; const int FW_MAX_THIEVES_TOOLS_CR_13 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_14 = 1; const int FW_MAX_THIEVES_TOOLS_CR_14 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_15 = 1; const int FW_MAX_THIEVES_TOOLS_CR_15 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_16 = 1; const int FW_MAX_THIEVES_TOOLS_CR_16 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_17 = 1; const int FW_MAX_THIEVES_TOOLS_CR_17 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_18 = 1; const int FW_MAX_THIEVES_TOOLS_CR_18 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_19 = 1; const int FW_MAX_THIEVES_TOOLS_CR_19 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_20 = 1; const int FW_MAX_THIEVES_TOOLS_CR_20 = 12;

const int FW_MIN_THIEVES_TOOLS_CR_21 = 1; const int FW_MAX_THIEVES_TOOLS_CR_21 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_22 = 1; const int FW_MAX_THIEVES_TOOLS_CR_22 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_23 = 1; const int FW_MAX_THIEVES_TOOLS_CR_23 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_24 = 1; const int FW_MAX_THIEVES_TOOLS_CR_24 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_25 = 1; const int FW_MAX_THIEVES_TOOLS_CR_25 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_26 = 1; const int FW_MAX_THIEVES_TOOLS_CR_26 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_27 = 1; const int FW_MAX_THIEVES_TOOLS_CR_27 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_28 = 1; const int FW_MAX_THIEVES_TOOLS_CR_28 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_29 = 1; const int FW_MAX_THIEVES_TOOLS_CR_29 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_30 = 1; const int FW_MAX_THIEVES_TOOLS_CR_30 = 12;

const int FW_MIN_THIEVES_TOOLS_CR_31 = 1; const int FW_MAX_THIEVES_TOOLS_CR_31 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_32 = 1; const int FW_MAX_THIEVES_TOOLS_CR_32 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_33 = 1; const int FW_MAX_THIEVES_TOOLS_CR_33 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_34 = 1; const int FW_MAX_THIEVES_TOOLS_CR_34 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_35 = 1; const int FW_MAX_THIEVES_TOOLS_CR_35 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_36 = 1; const int FW_MAX_THIEVES_TOOLS_CR_36 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_37 = 1; const int FW_MAX_THIEVES_TOOLS_CR_37 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_38 = 1; const int FW_MAX_THIEVES_TOOLS_CR_38 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_39 = 1; const int FW_MAX_THIEVES_TOOLS_CR_39 = 12;
const int FW_MIN_THIEVES_TOOLS_CR_40 = 1; const int FW_MAX_THIEVES_TOOLS_CR_40 = 12;

const int FW_MIN_THIEVES_TOOLS_CR_41_OR_HIGHER = 1; const int FW_MAX_THIEVES_TOOLS_CR_41_OR_HIGHER = 12;

// TURN_RESISTANCE
// The minimum and maximum TURN_RESISTANCE values an item could have (for each CR level).
// Acceptable values: 1,2,3,...,50
const int FW_MIN_TURN_RESISTANCE_CR_0 = 1; const int FW_MAX_TURN_RESISTANCE_CR_0 = 5;

const int FW_MIN_TURN_RESISTANCE_CR_1 = 1; const int FW_MAX_TURN_RESISTANCE_CR_1 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_2 = 1; const int FW_MAX_TURN_RESISTANCE_CR_2 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_3 = 1; const int FW_MAX_TURN_RESISTANCE_CR_3 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_4 = 1; const int FW_MAX_TURN_RESISTANCE_CR_4 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_5 = 1; const int FW_MAX_TURN_RESISTANCE_CR_5 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_6 = 1; const int FW_MAX_TURN_RESISTANCE_CR_6 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_7 = 1; const int FW_MAX_TURN_RESISTANCE_CR_7 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_8 = 1; const int FW_MAX_TURN_RESISTANCE_CR_8 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_9 = 1; const int FW_MAX_TURN_RESISTANCE_CR_9 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_10 = 1; const int FW_MAX_TURN_RESISTANCE_CR_10 = 5;

const int FW_MIN_TURN_RESISTANCE_CR_11 = 1; const int FW_MAX_TURN_RESISTANCE_CR_11 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_12 = 1; const int FW_MAX_TURN_RESISTANCE_CR_12 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_13 = 1; const int FW_MAX_TURN_RESISTANCE_CR_13 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_14 = 1; const int FW_MAX_TURN_RESISTANCE_CR_14 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_15 = 1; const int FW_MAX_TURN_RESISTANCE_CR_15 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_16 = 1; const int FW_MAX_TURN_RESISTANCE_CR_16 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_17 = 1; const int FW_MAX_TURN_RESISTANCE_CR_17 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_18 = 1; const int FW_MAX_TURN_RESISTANCE_CR_18 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_19 = 1; const int FW_MAX_TURN_RESISTANCE_CR_19 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_20 = 1; const int FW_MAX_TURN_RESISTANCE_CR_20 = 5;

const int FW_MIN_TURN_RESISTANCE_CR_21 = 1; const int FW_MAX_TURN_RESISTANCE_CR_21 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_22 = 1; const int FW_MAX_TURN_RESISTANCE_CR_22 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_23 = 1; const int FW_MAX_TURN_RESISTANCE_CR_23 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_24 = 1; const int FW_MAX_TURN_RESISTANCE_CR_24 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_25 = 1; const int FW_MAX_TURN_RESISTANCE_CR_25 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_26 = 1; const int FW_MAX_TURN_RESISTANCE_CR_26 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_27 = 1; const int FW_MAX_TURN_RESISTANCE_CR_27 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_28 = 1; const int FW_MAX_TURN_RESISTANCE_CR_28 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_29 = 1; const int FW_MAX_TURN_RESISTANCE_CR_29 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_30 = 1; const int FW_MAX_TURN_RESISTANCE_CR_30 = 5;

const int FW_MIN_TURN_RESISTANCE_CR_31 = 1; const int FW_MAX_TURN_RESISTANCE_CR_31 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_32 = 1; const int FW_MAX_TURN_RESISTANCE_CR_32 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_33 = 1; const int FW_MAX_TURN_RESISTANCE_CR_33 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_34 = 1; const int FW_MAX_TURN_RESISTANCE_CR_34 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_35 = 1; const int FW_MAX_TURN_RESISTANCE_CR_35 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_36 = 1; const int FW_MAX_TURN_RESISTANCE_CR_36 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_37 = 1; const int FW_MAX_TURN_RESISTANCE_CR_37 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_38 = 1; const int FW_MAX_TURN_RESISTANCE_CR_38 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_39 = 1; const int FW_MAX_TURN_RESISTANCE_CR_39 = 5;
const int FW_MIN_TURN_RESISTANCE_CR_40 = 1; const int FW_MAX_TURN_RESISTANCE_CR_40 = 5;

const int FW_MIN_TURN_RESISTANCE_CR_41_OR_HIGHER = 1; const int FW_MAX_TURN_RESISTANCE_CR_41_OR_HIGHER = 5;

// * ITEM_PROPERTY_UNLIMITED_AMMO
// There is no switch to control the type(s) of unlimited ammo.  To change the
// default go into the function FW_Choose_IP_Unlimited_Ammo and comment out the
// case statements you don't want as options.

// VAMPIRIC_REGENERATION
// The minimum and maximum VAMPIRIC_REGENERATION values an item could have
// (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_VAMPIRIC_REGENERATION_CR_0 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_0 = 1;

const int FW_MIN_VAMPIRIC_REGENERATION_CR_1 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_1 = 1;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_2 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_2 = 1;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_3 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_3 = 1;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_4 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_4 = 1;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_5 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_5 = 1;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_6 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_6 = 1;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_7 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_7 = 1;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_8 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_8 = 1;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_9 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_9 = 1;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_10 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_10 = 2;

const int FW_MIN_VAMPIRIC_REGENERATION_CR_11 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_11 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_12 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_12 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_13 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_13 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_14 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_14 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_15 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_15 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_16 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_16 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_17 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_17 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_18 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_18 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_19 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_19 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_20 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_20 = 2;

const int FW_MIN_VAMPIRIC_REGENERATION_CR_21 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_21 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_22 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_22 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_23 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_23 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_24 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_24 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_25 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_25 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_26 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_26 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_27 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_27 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_28 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_28 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_29 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_29 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_30 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_30 = 2;

const int FW_MIN_VAMPIRIC_REGENERATION_CR_31 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_31 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_32 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_32 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_33 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_33 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_34 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_34 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_35 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_35 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_36 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_36 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_37 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_37 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_38 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_38 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_39 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_39 = 2;
const int FW_MIN_VAMPIRIC_REGENERATION_CR_40 = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_40 = 2;

const int FW_MIN_VAMPIRIC_REGENERATION_CR_41_OR_HIGHER = 1; const int FW_MAX_VAMPIRIC_REGENERATION_CR_41_OR_HIGHER = 2;

// * ITEM_PROPERTY_WEIGHT_INCREASE
// Weight Increase is bugged in NWN 2.  Even if it worked properly there wouldn't be a set of
// min / max values to control the amounts because they are sporadic all over the place values

// * ITEM_PROPERTY_WEIGHT_REDUCTION
// There is no switch to control the Weight Increase or Decrease on an item. By
// default all weight increase/decrease amounts are possible.  To disallow
// any/some of the possibles comment out the undesired amounts inside the
// functions: FW_Choose_IP_Weight_Increase and FW_Choose_IP_Weight_Reduction.

// TRAP_LEVEL
// The minimum and maximum trap types that could drop from a monster spawn.
//   0 = Minor, 1 = Average, 2 = Strong, 3 = Deadly  This does not account
// for epic traps yet as they come out with Mask of the Betrayer.
// This will need to be updated for the expansion.
const int FW_MIN_TRAP_LEVEL_CR_0 = 0; const int FW_MAX_TRAP_LEVEL_CR_0 = 3;

const int FW_MIN_TRAP_LEVEL_CR_1 = 0; const int FW_MAX_TRAP_LEVEL_CR_1 = 3;
const int FW_MIN_TRAP_LEVEL_CR_2 = 0; const int FW_MAX_TRAP_LEVEL_CR_2 = 3;
const int FW_MIN_TRAP_LEVEL_CR_3 = 0; const int FW_MAX_TRAP_LEVEL_CR_3 = 3;
const int FW_MIN_TRAP_LEVEL_CR_4 = 0; const int FW_MAX_TRAP_LEVEL_CR_4 = 3;
const int FW_MIN_TRAP_LEVEL_CR_5 = 0; const int FW_MAX_TRAP_LEVEL_CR_5 = 3;
const int FW_MIN_TRAP_LEVEL_CR_6 = 0; const int FW_MAX_TRAP_LEVEL_CR_6 = 3;
const int FW_MIN_TRAP_LEVEL_CR_7 = 0; const int FW_MAX_TRAP_LEVEL_CR_7 = 3;
const int FW_MIN_TRAP_LEVEL_CR_8 = 0; const int FW_MAX_TRAP_LEVEL_CR_8 = 3;
const int FW_MIN_TRAP_LEVEL_CR_9 = 0; const int FW_MAX_TRAP_LEVEL_CR_9 = 3;
const int FW_MIN_TRAP_LEVEL_CR_10 = 0; const int FW_MAX_TRAP_LEVEL_CR_10 = 3;

const int FW_MIN_TRAP_LEVEL_CR_11 = 0; const int FW_MAX_TRAP_LEVEL_CR_11 = 3;
const int FW_MIN_TRAP_LEVEL_CR_12 = 0; const int FW_MAX_TRAP_LEVEL_CR_12 = 3;
const int FW_MIN_TRAP_LEVEL_CR_13 = 0; const int FW_MAX_TRAP_LEVEL_CR_13 = 3;
const int FW_MIN_TRAP_LEVEL_CR_14 = 0; const int FW_MAX_TRAP_LEVEL_CR_14 = 3;
const int FW_MIN_TRAP_LEVEL_CR_15 = 0; const int FW_MAX_TRAP_LEVEL_CR_15 = 3;
const int FW_MIN_TRAP_LEVEL_CR_16 = 0; const int FW_MAX_TRAP_LEVEL_CR_16 = 3;
const int FW_MIN_TRAP_LEVEL_CR_17 = 0; const int FW_MAX_TRAP_LEVEL_CR_17 = 3;
const int FW_MIN_TRAP_LEVEL_CR_18 = 0; const int FW_MAX_TRAP_LEVEL_CR_18 = 3;
const int FW_MIN_TRAP_LEVEL_CR_19 = 0; const int FW_MAX_TRAP_LEVEL_CR_19 = 3;
const int FW_MIN_TRAP_LEVEL_CR_20 = 0; const int FW_MAX_TRAP_LEVEL_CR_20 = 3;

const int FW_MIN_TRAP_LEVEL_CR_21 = 0; const int FW_MAX_TRAP_LEVEL_CR_21 = 3;
const int FW_MIN_TRAP_LEVEL_CR_22 = 0; const int FW_MAX_TRAP_LEVEL_CR_22 = 3;
const int FW_MIN_TRAP_LEVEL_CR_23 = 0; const int FW_MAX_TRAP_LEVEL_CR_23 = 3;
const int FW_MIN_TRAP_LEVEL_CR_24 = 0; const int FW_MAX_TRAP_LEVEL_CR_24 = 3;
const int FW_MIN_TRAP_LEVEL_CR_25 = 0; const int FW_MAX_TRAP_LEVEL_CR_25 = 3;
const int FW_MIN_TRAP_LEVEL_CR_26 = 0; const int FW_MAX_TRAP_LEVEL_CR_26 = 3;
const int FW_MIN_TRAP_LEVEL_CR_27 = 0; const int FW_MAX_TRAP_LEVEL_CR_27 = 3;
const int FW_MIN_TRAP_LEVEL_CR_28 = 0; const int FW_MAX_TRAP_LEVEL_CR_28 = 3;
const int FW_MIN_TRAP_LEVEL_CR_29 = 0; const int FW_MAX_TRAP_LEVEL_CR_29 = 3;
const int FW_MIN_TRAP_LEVEL_CR_30 = 0; const int FW_MAX_TRAP_LEVEL_CR_30 = 3;

const int FW_MIN_TRAP_LEVEL_CR_31 = 0; const int FW_MAX_TRAP_LEVEL_CR_31 = 3;
const int FW_MIN_TRAP_LEVEL_CR_32 = 0; const int FW_MAX_TRAP_LEVEL_CR_32 = 3;
const int FW_MIN_TRAP_LEVEL_CR_33 = 0; const int FW_MAX_TRAP_LEVEL_CR_33 = 3;
const int FW_MIN_TRAP_LEVEL_CR_34 = 0; const int FW_MAX_TRAP_LEVEL_CR_34 = 3;
const int FW_MIN_TRAP_LEVEL_CR_35 = 0; const int FW_MAX_TRAP_LEVEL_CR_35 = 3;
const int FW_MIN_TRAP_LEVEL_CR_36 = 0; const int FW_MAX_TRAP_LEVEL_CR_36 = 3;
const int FW_MIN_TRAP_LEVEL_CR_37 = 0; const int FW_MAX_TRAP_LEVEL_CR_37 = 3;
const int FW_MIN_TRAP_LEVEL_CR_38 = 0; const int FW_MAX_TRAP_LEVEL_CR_38 = 3;
const int FW_MIN_TRAP_LEVEL_CR_39 = 0; const int FW_MAX_TRAP_LEVEL_CR_39 = 3;
const int FW_MIN_TRAP_LEVEL_CR_40 = 0; const int FW_MAX_TRAP_LEVEL_CR_40 = 3;

const int FW_MIN_TRAP_LEVEL_CR_41_OR_HIGHER = 0; const int FW_MAX_TRAP_LEVEL_CR_41_OR_HIGHER = 3;


/*  NOTES TO SELF (cdaulepp)

Here's the template I used to cut and paste all those hundreds of min / max
constants above. Then use the replace function tab to quickly replace 'Z'
with the item property you want.

// The minimum and maximum **** values an item could have (for each CR level).
// Acceptable values: 1,2,3,...,20
const int FW_MIN_Z_CR_0 = 1; const int FW_MAX_Z_CR_0 = 20;

const int FW_MIN_Z_CR_1 = 1; const int FW_MAX_Z_CR_1 = 20;
const int FW_MIN_Z_CR_2 = 1; const int FW_MAX_Z_CR_2 = 20;
const int FW_MIN_Z_CR_3 = 1; const int FW_MAX_Z_CR_3 = 20;
const int FW_MIN_Z_CR_4 = 1; const int FW_MAX_Z_CR_4 = 20;
const int FW_MIN_Z_CR_5 = 1; const int FW_MAX_Z_CR_5 = 20;
const int FW_MIN_Z_CR_6 = 1; const int FW_MAX_Z_CR_6 = 20;
const int FW_MIN_Z_CR_7 = 1; const int FW_MAX_Z_CR_7 = 20;
const int FW_MIN_Z_CR_8 = 1; const int FW_MAX_Z_CR_8 = 20;
const int FW_MIN_Z_CR_9 = 1; const int FW_MAX_Z_CR_9 = 20;
const int FW_MIN_Z_CR_10 = 1; const int FW_MAX_Z_CR_10 = 20;

const int FW_MIN_Z_CR_11 = 1; const int FW_MAX_Z_CR_11 = 20;
const int FW_MIN_Z_CR_12 = 1; const int FW_MAX_Z_CR_12 = 20;
const int FW_MIN_Z_CR_13 = 1; const int FW_MAX_Z_CR_13 = 20;
const int FW_MIN_Z_CR_14 = 1; const int FW_MAX_Z_CR_14 = 20;
const int FW_MIN_Z_CR_15 = 1; const int FW_MAX_Z_CR_15 = 20;
const int FW_MIN_Z_CR_16 = 1; const int FW_MAX_Z_CR_16 = 20;
const int FW_MIN_Z_CR_17 = 1; const int FW_MAX_Z_CR_17 = 20;
const int FW_MIN_Z_CR_18 = 1; const int FW_MAX_Z_CR_18 = 20;
const int FW_MIN_Z_CR_19 = 1; const int FW_MAX_Z_CR_19 = 20;
const int FW_MIN_Z_CR_20 = 1; const int FW_MAX_Z_CR_20 = 20;

const int FW_MIN_Z_CR_21 = 1; const int FW_MAX_Z_CR_21 = 20;
const int FW_MIN_Z_CR_22 = 1; const int FW_MAX_Z_CR_22 = 20;
const int FW_MIN_Z_CR_23 = 1; const int FW_MAX_Z_CR_23 = 20;
const int FW_MIN_Z_CR_24 = 1; const int FW_MAX_Z_CR_24 = 20;
const int FW_MIN_Z_CR_25 = 1; const int FW_MAX_Z_CR_25 = 20;
const int FW_MIN_Z_CR_26 = 1; const int FW_MAX_Z_CR_26 = 20;
const int FW_MIN_Z_CR_27 = 1; const int FW_MAX_Z_CR_27 = 20;
const int FW_MIN_Z_CR_28 = 1; const int FW_MAX_Z_CR_28 = 20;
const int FW_MIN_Z_CR_29 = 1; const int FW_MAX_Z_CR_29 = 20;
const int FW_MIN_Z_CR_30 = 1; const int FW_MAX_Z_CR_30 = 20;

const int FW_MIN_Z_CR_31 = 1; const int FW_MAX_Z_CR_31 = 20;
const int FW_MIN_Z_CR_32 = 1; const int FW_MAX_Z_CR_32 = 20;
const int FW_MIN_Z_CR_33 = 1; const int FW_MAX_Z_CR_33 = 20;
const int FW_MIN_Z_CR_34 = 1; const int FW_MAX_Z_CR_34 = 20;
const int FW_MIN_Z_CR_35 = 1; const int FW_MAX_Z_CR_35 = 20;
const int FW_MIN_Z_CR_36 = 1; const int FW_MAX_Z_CR_36 = 20;
const int FW_MIN_Z_CR_37 = 1; const int FW_MAX_Z_CR_37 = 20;
const int FW_MIN_Z_CR_38 = 1; const int FW_MAX_Z_CR_38 = 20;
const int FW_MIN_Z_CR_39 = 1; const int FW_MAX_Z_CR_39 = 20;
const int FW_MIN_Z_CR_40 = 1; const int FW_MAX_Z_CR_40 = 20;

const int FW_MIN_Z_CR_41_OR_HIGHER = 1; const int FW_MAX_Z_CR_41_OR_HIGHER = 20;

*/

/*
NOTE TO SELF (cdaulepp): Here's the code I cut and pasted to quickly populate the 
item property functions in the file "fw_inc_choose_ip".  Replace "__CR"
with the constants you want. Example "_ATTACK_BONUS_CR".  This will quickly
populate everything!  That way I don't have to type 1000 lines over and 
over!!! 

  
   int min;
   int max;
   
   switch (nCR)
   {
		case 0: min = FW_MIN__CR_0 ; max = FW_MAX__CR_0 ;    break;
		
		case 1: min = FW_MIN__CR_1 ; max = FW_MAX__CR_1 ;    break;
		case 2: min = FW_MIN__CR_2 ; max = FW_MAX__CR_2 ;    break;
		case 3: min = FW_MIN__CR_3 ; max = FW_MAX__CR_3 ;    break;
   		case 4: min = FW_MIN__CR_4 ; max = FW_MAX__CR_4 ;    break;
		case 5: min = FW_MIN__CR_5 ; max = FW_MAX__CR_5 ;    break;
		case 6: min = FW_MIN__CR_6 ; max = FW_MAX__CR_6 ;    break;
   		case 7: min = FW_MIN__CR_7 ; max = FW_MAX__CR_7 ;    break;
		case 8: min = FW_MIN__CR_8 ; max = FW_MAX__CR_8 ;    break;
		case 9: min = FW_MIN__CR_9 ; max = FW_MAX__CR_9 ;    break;
   		case 10: min = FW_MIN__CR_10 ; max = FW_MAX__CR_10 ; break;
		
		case 11: min = FW_MIN__CR_11 ; max = FW_MAX__CR_11 ;  break;
		case 12: min = FW_MIN__CR_12 ; max = FW_MAX__CR_12 ;  break;
		case 13: min = FW_MIN__CR_13 ; max = FW_MAX__CR_13 ;  break;
   		case 14: min = FW_MIN__CR_14 ; max = FW_MAX__CR_14 ;  break;
		case 15: min = FW_MIN__CR_15 ; max = FW_MAX__CR_15 ;  break;
		case 16: min = FW_MIN__CR_16 ; max = FW_MAX__CR_16 ;  break;
   		case 17: min = FW_MIN__CR_17 ; max = FW_MAX__CR_17 ;  break;
		case 18: min = FW_MIN__CR_18 ; max = FW_MAX__CR_18 ;  break;
		case 19: min = FW_MIN__CR_19 ; max = FW_MAX__CR_19 ;  break;
   		case 20: min = FW_MIN__CR_20 ; max = FW_MAX__CR_20 ;  break;
   
   		case 21: min = FW_MIN__CR_21 ; max = FW_MAX__CR_21 ;  break;
		case 22: min = FW_MIN__CR_22 ; max = FW_MAX__CR_22 ;  break;
		case 23: min = FW_MIN__CR_23 ; max = FW_MAX__CR_23 ;  break;
   		case 24: min = FW_MIN__CR_24 ; max = FW_MAX__CR_24 ;  break;
		case 25: min = FW_MIN__CR_25 ; max = FW_MAX__CR_25 ;  break;
		case 26: min = FW_MIN__CR_26 ; max = FW_MAX__CR_26 ;  break;
   		case 27: min = FW_MIN__CR_27 ; max = FW_MAX__CR_27 ;  break;
		case 28: min = FW_MIN__CR_28 ; max = FW_MAX__CR_28 ;  break;
		case 29: min = FW_MIN__CR_29 ; max = FW_MAX__CR_29 ;  break;
   		case 30: min = FW_MIN__CR_30 ; max = FW_MAX__CR_30 ;  break;		
		
		case 31: min = FW_MIN__CR_31 ; max = FW_MAX__CR_31 ;  break;
		case 32: min = FW_MIN__CR_32 ; max = FW_MAX__CR_32 ;  break;
		case 33: min = FW_MIN__CR_33 ; max = FW_MAX__CR_33 ;  break;
   		case 34: min = FW_MIN__CR_34 ; max = FW_MAX__CR_34 ;  break;
		case 35: min = FW_MIN__CR_35 ; max = FW_MAX__CR_35 ;  break;
		case 36: min = FW_MIN__CR_36 ; max = FW_MAX__CR_36 ;  break;
   		case 37: min = FW_MIN__CR_37 ; max = FW_MAX__CR_37 ;  break;
		case 38: min = FW_MIN__CR_38 ; max = FW_MAX__CR_38 ;  break;
		case 39: min = FW_MIN__CR_39 ; max = FW_MAX__CR_39 ;  break;
   		case 40: min = FW_MIN__CR_40 ; max = FW_MAX__CR_40 ;  break;
		
		case 41: min = FW_MIN__CR_41_OR_HIGHER; max = FW_MAX__CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   
*/	  
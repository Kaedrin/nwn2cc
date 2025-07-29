// *******************************
//
// Created by: Christopher Aulepp
// Date: 12 May 2008
// VERSION 2.0
// contact info: cdaulepp@juno.com
// Copyright 2008 Christopher Aulepp.  All rights reserved.
//
// *******************************

/////////////////////////////////////////
//
//			UPDATES
//
/////////////////////////////////////////
//
// VERSION 2.0
// - 9 April 2008.  The function "FW_IsItemRolledTooExpensive" was updated to fix
//	   a logic error.  Unidentified items return a GP value = 1.  This in turn would
//     cause, in some very limited situations, some loot to appear on a monster that
//     was out of bounds set by the end-user.  I fixed this by Identifying the item
//     immediately before checking its GP value.  No worries, I change all items back
//     to un-identified in the file "fw_random_loot."
//
// -13 April 2008. The function "FW_IsItemRolledTooExpensive" was updated to check for
//     whether or not the spawning monster is a boss creature.  If it is a boss, then 
//     a check is done to see if GP restrictions are allowed/disallowed for bosses.
//     You can turn off GP restrictions for loot that drops on bosses by setting the
//     switch "FW_NO_GP_RESTRICTIONS_ON_BOSS_LOOT" = TRUE in the file "fw_inc_loot_switches".
//     You will also have to let the random loot generator know that the monster spawning
//     is a boss by setting a local variable on the boss in the toolset.  I explain how
//     to do this in the file "fw_inc_loot_switches".
//
/////////////////////////////////////////
/*			FILE DESCRIPTION
This file contains constants that control scaling of loot
based off the idea of item level restrictions.  Some
properties are inherently better than others.  Generally,
for example, immunity to critical hits is better than a +1
enhancement.  Because immunity to critical hits is generally
a better feat, it is valued higher than a +1 enhancement.
However, in combination immunity to critical hits with a 
+1 enhancement is worth MORE than either of the seperate
parts.  That's important to know for my explanation below.  

When an item is being created dynamically (like the random
loot generator does) we don't know ahead of time what 
property(s) will be chosen, or what type of item will drop, or
how many item properties an item will have, or if it will be
an item that can have item properties added to it (like a weapon)
or if the item chosen will be something like a gem or trap
(can't have item properties added to it).

While you can scale the range of power of most of the item 
properties by editing the constants and formulas in the files: 
"fw_inc_cr_scaling_constants" and "fw_inc_cr_scaling_formulas" 
respectively, those files do not address the 'overall' value of
an item drop and those files do not address value of an item
when it has a combination of multiple properties. 

A problem arises that we need to somehow limit the overall value
of an item so that the power of the treasure that drops still fits
the difficulty of the monster killed. The cr scaling through 
constants and formulas (in the above mentioned files) limits any
SINGLE item property very effectively based off the CR of the 
monster.  Editing those files lets you put each item property
into ranges that you feel are appropriate. 

But sometimes items will drop that have MULTIPLE item 
properties.  Alone, a single item property will fit into the 
ranges you set, but in combination with other item properties,
an item will sometimes be too powerful for the CR of the monster
unless we limit the overall gold value somehow. That is what
this file does.

This file contains constants where you set the maximum gold
value that an item drop could have for the corresponding 
monster's creature rating (CR).  Don't confuse this file with 
the constants in the file "fw_inc_misc".  They are not the same
thing.  This file sets limits on the value of an item (if an
item category other than gold was chosen), while 
the file "fw_inc_misc" sets limits on the number of Gold Pieces
dropped (if the gold category was chosen).

The default values in the constants below I took from the
standard item level restriction table in the 2da file 
"itemvalue.2da". 
*/
// *****************************************
//
//              INCLUDED FILES
//
// *****************************************
// I need the switches to see if boss loot is turned on/off.
#include "fw_inc_loot_switches"


/////////////////////////////////////////////////////////////
// The max value in gold pieces (GP) an item could have 
// for each creature rating.
//
const int FW_MAX_ITEM_VALUE_CR_0  = 500;

const int FW_MAX_ITEM_VALUE_CR_1  = 500;
const int FW_MAX_ITEM_VALUE_CR_2  = 1000;
const int FW_MAX_ITEM_VALUE_CR_3  = 1500;
const int FW_MAX_ITEM_VALUE_CR_4  = 2000;
const int FW_MAX_ITEM_VALUE_CR_5  = 3000;

const int FW_MAX_ITEM_VALUE_CR_6  = 4000;
const int FW_MAX_ITEM_VALUE_CR_7  = 6000;
const int FW_MAX_ITEM_VALUE_CR_8  = 8000;
const int FW_MAX_ITEM_VALUE_CR_9  = 10000;
const int FW_MAX_ITEM_VALUE_CR_10 = 12500;

const int FW_MAX_ITEM_VALUE_CR_11 = 15000;
const int FW_MAX_ITEM_VALUE_CR_12 = 17500;
const int FW_MAX_ITEM_VALUE_CR_13 = 20000;
const int FW_MAX_ITEM_VALUE_CR_14 = 23000;
const int FW_MAX_ITEM_VALUE_CR_15 = 26000;

const int FW_MAX_ITEM_VALUE_CR_16 = 30000;
const int FW_MAX_ITEM_VALUE_CR_17 = 35000;
const int FW_MAX_ITEM_VALUE_CR_18 = 40000;
const int FW_MAX_ITEM_VALUE_CR_19 = 50000;
const int FW_MAX_ITEM_VALUE_CR_20 = 60000;

const int FW_MAX_ITEM_VALUE_CR_21 = 70000;
const int FW_MAX_ITEM_VALUE_CR_22 = 70000;
const int FW_MAX_ITEM_VALUE_CR_23 = 70000;
const int FW_MAX_ITEM_VALUE_CR_24 = 70000;  // 1 MILLION
const int FW_MAX_ITEM_VALUE_CR_25 = 80000;

const int FW_MAX_ITEM_VALUE_CR_26 = 90000;
const int FW_MAX_ITEM_VALUE_CR_27 = 100000;
const int FW_MAX_ITEM_VALUE_CR_28 = 100000;
const int FW_MAX_ITEM_VALUE_CR_29 = 100000;  // 2 MILLION
const int FW_MAX_ITEM_VALUE_CR_30 = 100000;

const int FW_MAX_ITEM_VALUE_CR_31 = 100000;
const int FW_MAX_ITEM_VALUE_CR_32 = 100000;
const int FW_MAX_ITEM_VALUE_CR_33 = 100000;
const int FW_MAX_ITEM_VALUE_CR_34 = 100000;  // 3 MILLION
const int FW_MAX_ITEM_VALUE_CR_35 = 100000;

const int FW_MAX_ITEM_VALUE_CR_36 = 100000;
const int FW_MAX_ITEM_VALUE_CR_37 = 100000;
const int FW_MAX_ITEM_VALUE_CR_38 = 100000;
const int FW_MAX_ITEM_VALUE_CR_39 = 100000;  // 4 MILLION
const int FW_MAX_ITEM_VALUE_CR_40 = 100000;

// I deviated from the 2da file for CR 41 or higher.  I put a limit
// of 10 million gold pieces for this one.  I did this because I 
// am grouping CR 41,42,43,...,60 together.  I didn't want 
// the default value to have a low limit for the super awesomely tough
// monster category of CR 41 or higher.
const int FW_MAX_ITEM_VALUE_CR_41_OR_HIGHER = 100000; // 10 MILLION

///////////////////////////////////////////////
//
//
//			FUNCTION DECLARATIONS
//			 DON'T CHANGE THESE
//
//
///////////////////////////////////////////////

//////////////////////////////////////////////
// * This function looks up the maximum overall Gold Piece value
// * an item could have, as defined in the constants:
// * FW_MAX_ITEM_VALUE_CR_* where * = the CR of the spawning
// * monster.
//
int FW_GetMaxItemValue (int nCR = 0);

//////////////////////////////////////////////
// * This function checks to see if the item chosen by the random
// * loot generator is less than the allowable GP limit for the
// * spawning monster.  If the Item is too expensive for the CR of
// * the monster, then this returns TRUE (and the loot generator
// * will reroll a new item).  If the item is within appropriate
// * GP limits then this returns FALSE.
//
int FW_IsItemRolledTooExpensive (object oItem, int nCR = 0);

///////////////////////////////////////////////
//
//
//			FUNCTION IMPLEMENTATION
//			  DON'T CHANGE THESE
//
//
///////////////////////////////////////////////

//////////////////////////////////////////////
// * This function looks up the maximum overall Gold Piece value
// * an item could have, as defined in the constants:
// * FW_MAX_ITEM_VALUE_CR_* where * = the CR of the spawning
// * monster.
//
int FW_GetMaxItemValue (int nCR = 0)
{
	int nReturnValue;
	
	if (nCR < 0)
		nCR = 0;
	if (nCR > 41)
		nCR = 41;
	
	switch (nCR)
	{
		case 0: nReturnValue = FW_MAX_ITEM_VALUE_CR_0;
			break;
			
		case 1: nReturnValue = FW_MAX_ITEM_VALUE_CR_1;
			break;
		case 2: nReturnValue = FW_MAX_ITEM_VALUE_CR_2;
			break;
		case 3: nReturnValue = FW_MAX_ITEM_VALUE_CR_3;
			break;
		case 4: nReturnValue = FW_MAX_ITEM_VALUE_CR_4;
			break;
		case 5: nReturnValue = FW_MAX_ITEM_VALUE_CR_5;
			break;
		case 6: nReturnValue = FW_MAX_ITEM_VALUE_CR_6;
			break;
		case 7: nReturnValue = FW_MAX_ITEM_VALUE_CR_7;
			break;
		case 8: nReturnValue = FW_MAX_ITEM_VALUE_CR_8;
			break;
		case 9: nReturnValue = FW_MAX_ITEM_VALUE_CR_9;
			break;
		case 10: nReturnValue = FW_MAX_ITEM_VALUE_CR_10;
			break;
		
		case 11: nReturnValue = FW_MAX_ITEM_VALUE_CR_11;
			break;
		case 12: nReturnValue = FW_MAX_ITEM_VALUE_CR_12;
			break;
		case 13: nReturnValue = FW_MAX_ITEM_VALUE_CR_13;
			break;
		case 14: nReturnValue = FW_MAX_ITEM_VALUE_CR_14;
			break;
		case 15: nReturnValue = FW_MAX_ITEM_VALUE_CR_15;
			break;
		case 16: nReturnValue = FW_MAX_ITEM_VALUE_CR_16;
			break;
		case 17: nReturnValue = FW_MAX_ITEM_VALUE_CR_17;
			break;
		case 18: nReturnValue = FW_MAX_ITEM_VALUE_CR_18;
			break;
		case 19: nReturnValue = FW_MAX_ITEM_VALUE_CR_19;
			break;
		case 20: nReturnValue = FW_MAX_ITEM_VALUE_CR_20;
			break;
		
		case 21: nReturnValue = FW_MAX_ITEM_VALUE_CR_21;
			break;
		case 22: nReturnValue = FW_MAX_ITEM_VALUE_CR_22;
			break;
		case 23: nReturnValue = FW_MAX_ITEM_VALUE_CR_23;
			break;
		case 24: nReturnValue = FW_MAX_ITEM_VALUE_CR_24;
			break;
		case 25: nReturnValue = FW_MAX_ITEM_VALUE_CR_25;
			break;
		case 26: nReturnValue = FW_MAX_ITEM_VALUE_CR_26;
			break;
		case 27: nReturnValue = FW_MAX_ITEM_VALUE_CR_27;
			break;
		case 28: nReturnValue = FW_MAX_ITEM_VALUE_CR_28;
			break;
		case 29: nReturnValue = FW_MAX_ITEM_VALUE_CR_29;
			break;
		case 30: nReturnValue = FW_MAX_ITEM_VALUE_CR_30;
			break;
		
		case 31: nReturnValue = FW_MAX_ITEM_VALUE_CR_31;
			break;
		case 32: nReturnValue = FW_MAX_ITEM_VALUE_CR_32;
			break;
		case 33: nReturnValue = FW_MAX_ITEM_VALUE_CR_33;
			break;
		case 34: nReturnValue = FW_MAX_ITEM_VALUE_CR_34;
			break;
		case 35: nReturnValue = FW_MAX_ITEM_VALUE_CR_35;
			break;
		case 36: nReturnValue = FW_MAX_ITEM_VALUE_CR_36;
			break;
		case 37: nReturnValue = FW_MAX_ITEM_VALUE_CR_37;
			break;
		case 38: nReturnValue = FW_MAX_ITEM_VALUE_CR_38;
			break;
		case 39: nReturnValue = FW_MAX_ITEM_VALUE_CR_39;
			break;
		case 40: nReturnValue = FW_MAX_ITEM_VALUE_CR_40;
			break;
		
		case 41: nReturnValue = FW_MAX_ITEM_VALUE_CR_41_OR_HIGHER;
	}
	return nReturnValue;
}

//////////////////////////////////////////////
// * This function checks to see if the item chosen by the random
// * loot generator is less than the allowable GP limit for the
// * spawning monster.  If the Item is too expensive for the CR of
// * the monster, then this returns TRUE (and the loot generator
// * will reroll a new item).  If the item is within appropriate
// * GP limits then this returns FALSE.
//
int FW_IsItemRolledTooExpensive (object oItem, int nCR = 0)
{
	// See if the spawning monster has a local int variable "FW_BOSS" set to "1"
	int nBossCheck = GetLocalInt (OBJECT_SELF, "FW_BOSS");
	// If the spawning monster is a boss and there are no GP limits on boss
	// loot then return false because the loot price is irrelevant.
	if (nBossCheck && FW_NO_GP_RESTRICTIONS_ON_BOSS_LOOT)
	{
		return FALSE;
	}
	// otherwise, it is a normal monster spawning or a boss with default GP
	// restrictions.  Either way, here we want to check the value to make
	// sure the spawning loot is not too expensive for the CR of the monster.
	// Also, we don't want the spawning loot to be too expensive for a treasure
	// chest.  this "else" clause handles everything.
	else
	{
		
		SetIdentified (oItem, TRUE);
		int nMaxItemValue = FW_GetMaxItemValue(nCR);		    		
		int nItemGPValue = GetGoldPieceValue (oItem);			
		if (nItemGPValue > nMaxItemValue)
		{
			return TRUE;
		}
		return FALSE;
	}
	// We should never get to this point in the code, but in case we do 
	// (which would be an error) return true so that the loot generator
	// rerolls something else.
	return TRUE;	
}
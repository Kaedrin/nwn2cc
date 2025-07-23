/////////////////////////////////////////////
// *
// * Created by Christopher Aulepp
// * Date: 12 May 2008
// * contact information: cdaulepp@juno.com
// * VERSION 2.0
// * copyright 2008 Christopher Aulepp.  All rights reserved.
// *
//////////////////////////////////////////////

/*
This file contains basic probability tables for the loot generation 
system.  You can change things in this file to set the probabilities 
you want.  When there is something you shouldn't change, I say so
in big capital letters.  Only an experienced scripter ought to even 
consider changing the things I say to leave alone.
*/

// *****************************************
//
//
//    				UPDATES			
//
//
// *****************************************
// VERSION 2.0
// - 5 April 2008.  I added 3 probability tables for boss loot.  You can now
//     indicate boss loot should drop by setting a local int variable on your
//     monster/placeable.  The name should be: "FW_BOSS" (remove the " " marks).
//     The integer value should be the number "1" (no " " marks).
//     When the random loot generator sees the monster or placeable has been marked
//     as boss loot, it will use the boss probability tables for determining
//     (1) if loot drops, (2)how many items to drop, and (3) how many
//     item properties to put on the item.  Of course, I had to update the function
//     implementations that make everything happen.  But all you need to do is 
//     adjust the probability tables to whatever you want the default frequencies
//     to be.  The boss tables work just like the regular tables from earlier versions
//     of the loot generator.  I also added in 3 probability tables for placeable 
//     loot (i.e. treasure chests). 
//
//	   Because the random loot generator in version 2.0 will now work with both monsters
//     and placeable objects, if you put "FW_BOSS" int 1 on your treasure chests they will
//     use the boss probability tables instead of the default probability tables.
//     And actually, you can use the random loot generator not just with monsters and
//     treasure chests, but you can have any item with an inventory use the random loot
//     generator.  Thus, my system will work on things like armoires, book shelves, weapon
//     racks, etc.   
//
//	   To signify Boss loot do the following to your monster or placeable.  
//		1) Click on the blueprint of your boss/placeable.  
//		2) Open the boss'/placeable's properties.
//	    3) Under the "Scripts" section you will see a field called "Variables".  Click on 
//     		Variables.  
//		4) To the right of "Variables" you will see three dots "..."  Click on the 
//     		three dots.  This opens up a new window.  
//		5) Click on "Add".  
//		6) In the "Name" field type exactly the following:  "FW_BOSS" without the quotation
//			 " " marks.
//      7) In the "ValueInt" field change the "0" to a "1"  without the quotation " " marks.
//	    8) Click on the "VariableType" field.  You should see the "VariableType" automatically
//   		change to "Integer".  If you do not see it change to "Integer" on its own 
//			then you should choose "Integer" manually. 
//		9) Hit the "OK" button and you are done.  
//
// 	   Now this creature/placeable has been identified for boss loot and the 
//     random loot generator will use the boss probability tables instead of normal 
//     probability tables to determine what loot drops.
//
//	   Besides a set of 3 probability tables to use on boss loot, in this new version you have
//     another set of 3 probability tables that you can use for your placeable (e.g. treasure
//     chest) loot.  The placeable probability tables work just like the boss and regular 
//     probability tables.  If you want something to use the placeable probability tables
//     you must put *TWO* local int variables on the object.  
//
//	   WARNING: YOU MUST PUT TWO VARIABLES ON PLACEABLE OBJECTS IF THEY ARE GOING TO USE
// 		        THE RANDOM LOOT GENERATOR.  PLACEABLE OBJECTS DO NOT HAVE A CHALLENGE RATING
//              ON THEIR OWN, SO YOU MUST FOLLOW THE STEPS BELOW FOR PLACEABLE OBJECTS IF
//			    YOU WANT THEM TO WORK PROPERLY.
//
//	   The reason for this is that placeable objects don't have a Challenge Rating.  Thus,
//     you must provide this information for the loot generator or else no loot will 
//     appear on your placeable objects (treasure chests, etc.).  You'll notice the
//     instructions below are very similar to how we marked a boss.
//
//     To set the required TWO variables on placeable loot do the following:  
//		1) Click on the blueprint of your placeable item.  
//		2) Open the placeable's properties.
//		3) Under the "Scripts" section you will see a field called "Variables".  Click on 
//   		Variables.  
//		4) To the right of "Variables" you will see three dots "..."  Click on the 
//   		three dots.  This opens up a new window.
//  
//		5) Click on "Add".  
//		6) In the "Name" field type in exactly the following:  "FW_TREASURE_CHEST" without 
//			the quotation " " marks.
//   	7) In the "ValueInt" field change the "0" to a "1"  without the quotation " " marks.
//   	8) Click on the "VariableType" field.  You should see the "VariableType" automatically
//   		change to "Integer".  If you do not see it change to "Integer" on its own 
//			then you should choose "Integer" manually. 
//
//		9) Click on "Add."
//		10) In the "Name" field type in exactly the following: "CR" without the quotation
//			" " marks.
//		11) In the "ValueInt" field change the "0" to whatever number of CR you wish this
//			placeable object to use.  Remember that the lower the CR, the weaker the 
//			loot that will appear on this placeable. Acceptable values range from 0 to
//			41.  I.E. 0,1,2,3,...,41 will work.  
//
//		12) Hit the "OK" button and you are done.  Now this placeable has the necessary
//		variables on it.
// 
//	   ALL PLACEABLE OBJECTS (E.G. TREASURE CHESTS, ARMOIRES, WEAPONS RACKS, ETC.) MUST HAVE
//     THE ABOVE TWO VARIABLES ON THEM OR THEY WILL NOT SPAWN LOOT.
//
//     Monsters do not need the placeable variables on them because I can get their Challenge
//     Rating without adding any variables.  
//
//	   The default frequency for regular monsters to drop loot is only 50%.  
//     This seemed a little low to me for treasure chests.  That is why I created a
//     separate category of tables to determine the frequencies of 
//     loot drops associated with placeable objects.  
//
//     The loot generator has a certain order of operations.  
//	   Boss >> Placeable >> regular loot.   
//
//     Thus, if something has the variable "FW_BOSS" int 1 on it, then the boss probability 
//     tables override everything else.  Anything marked for boss loot will use the boss 
//     tables, period.  If you mark your tresure chests for boss loot, they will use the boss
//     probability tables.  Similarly, if you mark a monster for boss loot, it will use the
//     boss probability tables.  Marking a placeable for boss loot DOES NOT relieve you of
//     putting the two required placeable variables on your placeable loot.  
//
//     Something marked as a placeable comes second in priority.  Thus, if someting has the
//     variable "FW_TREASURE_CHEST" int 1 on it, then the placeable tables override normal
//     treasure probability tables.  Anything marked as placeable loot will use the placeable
//     tables unless it was marked as boss loot, period.  If you wanted some (or all) of 
//     your monsters to use the placeable probability tables, you could technically do that
//     as well.  But remember, if you put the variable FW_TREASURE_CHEST on something, you 
//     must follow up by putting a CR variable on the object.  Once the loot generator sees
//     the variable FW_TREASURE_CHEST it assumes this is a placeable object (that has no CR)
//     and it immediately looks for another local variable "CR" int (whatever).  So if you
//     really want some of your monsters to use the placeable probability tables, don't forget
//     that you will have to manually put a CR variable on them besides putting the FW_TREASURE_CHEST
//     variable on them.
//
//     Last in priority is normal monster loot.  If the random loot generator sees no "FW_BOSS"
//     and sees no "FW_TREASURE_CHEST" variable, then it assumes this is a normal spawning 
//     monster and will do what it has always done...spawn random treasure in the monster's
//     inventory. 
//
//     I apologize for the length of these instructions, but I want to make sure you understand
//     exactly how the random loot generator works, so that you can use it with no problems.
//     Most of you probably already have an onOpen script that you use with treasure chests
//     in your module or world.  If you use your own onOpen script, you will need to add one
//     line of code to your script that will execute the random loot generator when a PC opens
//     the treasure chest (or other placeable).  Add the following to your own script, exactly
//     as spelled here:  ExecuteScript("fw_random_loot", OBJECT_SELF); 
//
//     OR, for those who don't have an onOpen script, I made one for you.  I made things as 
//     easy for you as I could.  I created an onOpen script that you can put on containers 
//     and it will automatically do everything for you.  If you want to use my script:
//     in the toolset, click on your container, open its properties, scroll down to the 
//     scripts section, and in the onOpen field, put my script.  It is called
//     "fw_container_on_open." That's it. 
//
//     So to recap you need to do a total of 3 things, explained above, to get your 
//     containers to spawn randomly created loot.
//     1.  Add the variable "FW_TREASURE_CHEST = 1" (explained above).
//     2.  Add the variable "CR = [whatever number you want]" (explained above).
//     3.  Put your onOpen script, or mine, in the container's onOpen field.
//
//
// VERSION 1.2  
// -28 August 2007.  I removed several things from this file and put them
//      in the other files because they fit better somewhere else. 
//
// VERSION 1.1 
// - 29 July 2007.  I added probability tables that determine what type of
//      armor and weapon material drops (i.e. adamantine, cold iron, etc.)
//      along with corresponding function declarations and implementations.    


// *****************************************
//
//
//    				INCLUDED FILES		
//
//
// *****************************************
// I need the MyStruct data type and some category constants
#include "fw_inc_misc"



// *****************************************
//
//
//    PROBABILITY CONSTANTS AND TABLES
//
//	  YOU CAN CHANGE THESE IF YOU WANT				
//
//
// *****************************************

// This constant expresses how many rolls out of 1,000 a piece of loot is
// cursed. Default is 1 piece of loot out of 1,000 is cursed. The value
// of this constant only matters if you turned on (set to TRUE) the
// switch "FW_ALLOW_CURSED_ITEMS" in the file "fw_inc_loot_switches"
//
const int FW_PROB_CURSED_LOOT = 1;
 

// ******** PROBABILITY THAT A MONSTER DROPS LOOT ********************
//
// The FW_PROB_LOOT_CR_* constants.
//
// Probability of a monster dropping loot based off Creature Challenge Rating.
// Expressed as a percentage out of 100.  Default value for every CR rating is
// 50%.  This means exactly half of the monsters will drop some form of loot. 
// Acceptable values range from 0% to 100%.  This gives you total control over
// every CR rating and the probability of that monster CR dropping loot. 
// Here's 1 example of how to change it from the default to something else.
//
// Example 1: Changing the line for level 0 Challenge Rating Monsters
// 		   from: "const int FW_PROB_LOOT_CR_0 = 50;"
// 	         to: "const int FW_PROB_LOOT_CR_0 = 33;"   means CR level 0 monsters
//    would have a 33% chance of dropping loot instead of the default 50%.
//  
// NOTE: Acceptable values: 0,1,2,...,100  
//
// NOTE 2: Don't use negative values for the probability. You'll get unpredictable
// results.
//
const int FW_PROB_LOOT_CR_0 = 50; 

const int FW_PROB_LOOT_CR_1 = 50;  const int FW_PROB_LOOT_CR_11 = 50;  
const int FW_PROB_LOOT_CR_2 = 50;  const int FW_PROB_LOOT_CR_12 = 50;  
const int FW_PROB_LOOT_CR_3 = 50;  const int FW_PROB_LOOT_CR_13 = 50;  
const int FW_PROB_LOOT_CR_4 = 50;  const int FW_PROB_LOOT_CR_14 = 50;  
const int FW_PROB_LOOT_CR_5 = 50;  const int FW_PROB_LOOT_CR_15 = 50;  
const int FW_PROB_LOOT_CR_6 = 50;  const int FW_PROB_LOOT_CR_16 = 50;  
const int FW_PROB_LOOT_CR_7 = 50;  const int FW_PROB_LOOT_CR_17 = 50;  
const int FW_PROB_LOOT_CR_8 = 50;  const int FW_PROB_LOOT_CR_18 = 50;  
const int FW_PROB_LOOT_CR_9 = 50;  const int FW_PROB_LOOT_CR_19 = 50;  
const int FW_PROB_LOOT_CR_10 = 50; const int FW_PROB_LOOT_CR_20 = 50; 

const int FW_PROB_LOOT_CR_21 = 50;  const int FW_PROB_LOOT_CR_31 = 50;  
const int FW_PROB_LOOT_CR_22 = 50;  const int FW_PROB_LOOT_CR_32 = 50;  
const int FW_PROB_LOOT_CR_23 = 50;  const int FW_PROB_LOOT_CR_33 = 50;  
const int FW_PROB_LOOT_CR_24 = 50;  const int FW_PROB_LOOT_CR_34 = 50;  
const int FW_PROB_LOOT_CR_25 = 50;  const int FW_PROB_LOOT_CR_35 = 50;  
const int FW_PROB_LOOT_CR_26 = 50;  const int FW_PROB_LOOT_CR_36 = 50;  
const int FW_PROB_LOOT_CR_27 = 50;  const int FW_PROB_LOOT_CR_37 = 50;  
const int FW_PROB_LOOT_CR_28 = 50;  const int FW_PROB_LOOT_CR_38 = 50;  
const int FW_PROB_LOOT_CR_29 = 50;  const int FW_PROB_LOOT_CR_39 = 50;  
const int FW_PROB_LOOT_CR_30 = 50;  const int FW_PROB_LOOT_CR_40 = 50; 

const int FW_PROB_LOOT_CR_41_OR_HIGHER = 50;


// ******** PROBABILITY THAT A BOSS DROPS LOOT ********************
//
// The FW_PROB_BOSS_LOOT_CR_* constants.
//
// These constants work exactly the same way as the FW_PROB_LOOT_CR_* constants work.
// If you have a creature tagged as a boss then these constants will apply.  Otherwise,
// the constants above apply.  The default is set to 100% so that a boss will always
// drop at least something.  You can change the frequency if you wish by lowering
// the value to something other than 100.
//
// NOTE: Acceptable values: 0,1,2,...,100  
//
// NOTE 2: Don't use negative values for the probability. You'll get unpredictable
// results.
//
const int FW_PROB_BOSS_LOOT_CR_0 = 100; 

const int FW_PROB_BOSS_LOOT_CR_1 = 100;  const int FW_PROB_BOSS_LOOT_CR_11 = 100;  
const int FW_PROB_BOSS_LOOT_CR_2 = 100;  const int FW_PROB_BOSS_LOOT_CR_12 = 100;  
const int FW_PROB_BOSS_LOOT_CR_3 = 100;  const int FW_PROB_BOSS_LOOT_CR_13 = 100;  
const int FW_PROB_BOSS_LOOT_CR_4 = 100;  const int FW_PROB_BOSS_LOOT_CR_14 = 100;  
const int FW_PROB_BOSS_LOOT_CR_5 = 100;  const int FW_PROB_BOSS_LOOT_CR_15 = 100;  
const int FW_PROB_BOSS_LOOT_CR_6 = 100;  const int FW_PROB_BOSS_LOOT_CR_16 = 100;  
const int FW_PROB_BOSS_LOOT_CR_7 = 100;  const int FW_PROB_BOSS_LOOT_CR_17 = 100;  
const int FW_PROB_BOSS_LOOT_CR_8 = 100;  const int FW_PROB_BOSS_LOOT_CR_18 = 100;  
const int FW_PROB_BOSS_LOOT_CR_9 = 100;  const int FW_PROB_BOSS_LOOT_CR_19 = 100;  
const int FW_PROB_BOSS_LOOT_CR_10 = 100; const int FW_PROB_BOSS_LOOT_CR_20 = 100; 

const int FW_PROB_BOSS_LOOT_CR_21 = 100;  const int FW_PROB_BOSS_LOOT_CR_31 = 100;  
const int FW_PROB_BOSS_LOOT_CR_22 = 100;  const int FW_PROB_BOSS_LOOT_CR_32 = 100;  
const int FW_PROB_BOSS_LOOT_CR_23 = 100;  const int FW_PROB_BOSS_LOOT_CR_33 = 100;  
const int FW_PROB_BOSS_LOOT_CR_24 = 100;  const int FW_PROB_BOSS_LOOT_CR_34 = 100;  
const int FW_PROB_BOSS_LOOT_CR_25 = 100;  const int FW_PROB_BOSS_LOOT_CR_35 = 100;  
const int FW_PROB_BOSS_LOOT_CR_26 = 100;  const int FW_PROB_BOSS_LOOT_CR_36 = 100;  
const int FW_PROB_BOSS_LOOT_CR_27 = 100;  const int FW_PROB_BOSS_LOOT_CR_37 = 100;  
const int FW_PROB_BOSS_LOOT_CR_28 = 100;  const int FW_PROB_BOSS_LOOT_CR_38 = 100;  
const int FW_PROB_BOSS_LOOT_CR_29 = 100;  const int FW_PROB_BOSS_LOOT_CR_39 = 100;  
const int FW_PROB_BOSS_LOOT_CR_30 = 100;  const int FW_PROB_BOSS_LOOT_CR_40 = 100; 

const int FW_PROB_BOSS_LOOT_CR_41_OR_HIGHER = 100;

// ******** PROBABILITY THAT A PLACEABLE DROPS LOOT ********************
//
// The FW_PROB_PLACEABLE_LOOT_CR_* constants.
// Just like the above two (boss and regular loot)
// 
// NOTE: Acceptable values: 0,1,2,...,100  
//
// NOTE 2: Don't use negative values for the probability. You'll get unpredictable
// results.
//
const int FW_PROB_PLACEABLE_LOOT_CR_0 = 100; 

const int FW_PROB_PLACEABLE_LOOT_CR_1 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_11 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_2 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_12 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_3 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_13 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_4 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_14 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_5 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_15 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_6 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_16 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_7 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_17 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_8 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_18 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_9 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_19 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_10 = 100; const int FW_PROB_PLACEABLE_LOOT_CR_20 = 100; 

const int FW_PROB_PLACEABLE_LOOT_CR_21 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_31 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_22 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_32 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_23 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_33 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_24 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_34 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_25 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_35 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_26 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_36 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_27 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_37 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_28 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_38 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_29 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_39 = 100;  
const int FW_PROB_PLACEABLE_LOOT_CR_30 = 100;  const int FW_PROB_PLACEABLE_LOOT_CR_40 = 100; 

const int FW_PROB_PLACEABLE_LOOT_CR_41_OR_HIGHER = 100;



// ********** HOW MANY ITEMS DROP ************************
//
// The FW_PROB_*_ITEMS_DROPPED constants.
//
// This section handles the probability of how many items drop.  These
// constants are only used when it has already been determined that a monster
// will drop an item (at least 1). Then the question becomes: "How many items 
// will the monster drop?"  That's why there's nothing for zero items.
//
// You control the probability of the number of items that will drop.  
// The higher the number you put, the more likely that quantity of item(s) 
// drop(s).  You'll note that these constants add up to 1000 (easy to figure 
// percentage for each number of items that way), but they do NOT have to add
// up to 1000.  By default I have the lower number of items dropping more 
// frequently than many items. 
//
// These probabilities are relative to the total value of all the categories
// added together.  (I made my numbers add up to 1,000 to make it easy to
// figure out the probability, you don't have to follow my lead, but it's 
// easier if you do). 
//
// If you put a zero in for any of the values that is the same as excluding
// it from ever being possible.  I figure most people aren't going to want a 
// creature dropping 10 items, so in the default values below I have a zero
// in the 10 items dropped constant to remind you that you can have zeros for
// an acceptable value.
//
// NOTE: Although in the default the probabilities get smaller as the number
// of items goes up, that doesn't have to be the case.  
//
// NOTE 2: Don't use negative values for the probability. You'll get unpredictable
// results.
//
const int FW_PROB_1_ITEMS_DROPPED = 1000;  // 60%   default (600/1000) = most frequent
const int FW_PROB_2_ITEMS_DROPPED = 0;  // 25%   default (250/1000)  
const int FW_PROB_3_ITEMS_DROPPED = 0;  // 10%   default (100/1000)  
const int FW_PROB_4_ITEMS_DROPPED = 0;   //  2.5% default (25/1000)  
const int FW_PROB_5_ITEMS_DROPPED = 0;   //  1.5% default (15/1000)  
const int FW_PROB_6_ITEMS_DROPPED = 0;    //  0.5% default (5/1000)  
const int FW_PROB_7_ITEMS_DROPPED = 0;    //  0.2% default (2/1000)  
const int FW_PROB_8_ITEMS_DROPPED = 0;    //  0.2% default (2/1000)  
const int FW_PROB_9_ITEMS_DROPPED = 0;    //  0.1% default (1/1000)  
const int FW_PROB_10_ITEMS_DROPPED = 0;   //  0.0% default (0/1000) = not possible

// Version 2.0 update:  I added in separate probabilities for boss creatures.
// These work exactly the same as the ones just above.  I raised the default values
// for bosses so that when they drop items, they consistently drop a higher number
// of items than normal creatures.  
//
// NOTE: Remember not to use negative values. You'll get unexpected results.
//
const int FW_PROB_BOSS_1_ITEMS_DROPPED = 500;  // 20%   default (200/1000) 
const int FW_PROB_BOSS_2_ITEMS_DROPPED = 500;  // 20%   default (200/1000)  
const int FW_PROB_BOSS_3_ITEMS_DROPPED = 0;  // 30%   default (300/1000) = most frequent
const int FW_PROB_BOSS_4_ITEMS_DROPPED = 0;  // 20%   default (200/1000)  
const int FW_PROB_BOSS_5_ITEMS_DROPPED = 0;   //  5.0% default (50/1000)  
const int FW_PROB_BOSS_6_ITEMS_DROPPED = 0;   //  2.5% default (25/1000)  
const int FW_PROB_BOSS_7_ITEMS_DROPPED = 0;   //  1.3% default (13/1000)  
const int FW_PROB_BOSS_8_ITEMS_DROPPED = 0;    //  0.7% default (7/1000)  
const int FW_PROB_BOSS_9_ITEMS_DROPPED = 0;    //  0.5% default (5/1000)  
const int FW_PROB_BOSS_10_ITEMS_DROPPED = 0;   //  0.0% default (0/1000) = not possible

// Version 2.0 update. Just like the above, but for placeables this time.
// This probability table is used for treasure chests and any other placeable
// that uses the random loot generator.
// NOTE: Remember not to use negative values.  You'll get unexpected results.
//
const int FW_PROB_PLACEABLE_1_ITEMS_DROPPED = 1000;  // 60%   default (600/1000) = most frequent
const int FW_PROB_PLACEABLE_2_ITEMS_DROPPED = 0;  // 25%   default (250/1000)  
const int FW_PROB_PLACEABLE_3_ITEMS_DROPPED = 0;  // 10%   default (100/1000)  
const int FW_PROB_PLACEABLE_4_ITEMS_DROPPED = 0;   //  2.5% default (25/1000)  
const int FW_PROB_PLACEABLE_5_ITEMS_DROPPED = 0;   //  1.5% default (15/1000)  
const int FW_PROB_PLACEABLE_6_ITEMS_DROPPED = 0;    //  0.5% default (5/1000)  
const int FW_PROB_PLACEABLE_7_ITEMS_DROPPED = 0;    //  0.2% default (2/1000)  
const int FW_PROB_PLACEABLE_8_ITEMS_DROPPED = 0;    //  0.2% default (2/1000)  
const int FW_PROB_PLACEABLE_9_ITEMS_DROPPED = 0;    //  0.1% default (1/1000)  
const int FW_PROB_PLACEABLE_10_ITEMS_DROPPED = 0;   //  0.0% default (0/1000) = not possible



// *************** HOW MANY ITEM PROPERTIES *******************
//
// The FW_PROB_*_ITEM_PROPERTYS constants. 
//
// This is basically the same as above except we have to allow for zero item
// properties or else we would never get generic loot.  Just like 
// FW_PROB_*_ITEMS_DROPPED, these constants don't come into play unless it
// has already been determined that a monster will drop some loot and the
// loot can have item properties added to it (i.e. not gold or crafting material).
//
// NOTE: Same as above. Although the probabilities get smaller as the number
// of item properties goes up, that doesn't have to be the case.  You can use
// zero as a value to exclude something from being possible, like I did with
// the 10 item properties constant.
//
// NOTE 2: Don't use negative values for the probability. You'll get unpredictable
// results.
//
const int FW_PROB_0_ITEM_PROPERTYS = 750; // 35%   default (350/1000) = most frequent 
const int FW_PROB_1_ITEM_PROPERTYS = 225; // 25%   default (250/1000) 
const int FW_PROB_2_ITEM_PROPERTYS = 25; // 15%   default (150/1000) 
const int FW_PROB_3_ITEM_PROPERTYS = 0; // 10%   default (100/1000) 
const int FW_PROB_4_ITEM_PROPERTYS = 0;  //  7.5% default (75/1000) 
const int FW_PROB_5_ITEM_PROPERTYS = 0;  //  4.0% default (40/1000) 
const int FW_PROB_6_ITEM_PROPERTYS = 0;  //  2.0% default (20/1000) 
const int FW_PROB_7_ITEM_PROPERTYS = 0;  //  1.0% default (10/1000) 
const int FW_PROB_8_ITEM_PROPERTYS = 0;   //  0.3% default (3/1000) 
const int FW_PROB_9_ITEM_PROPERTYS = 0;   //  0.2% default (2/1000) 
const int FW_PROB_10_ITEM_PROPERTYS = 0;  //  0.0% default (0/1000) = not possible 

// With update 2.0 I added in the probability table for boss creatures below.
// This works the same as the table right above.  But I raised the default values
// to make bosses more likely to drop magically enchanged loot.  You'll notice I 
// set the default value for 0 item properties equal to 0% chance.  That means the
// default boss loot will always be something magical.  If you want a boss to have 
// a chance at dropping something mundane with no magical properties, just switch
// the values to whatever you want.
//
// NOTE: Remember DO NOT use negative numbers for probabilities. You'll get 
// unexpected results.
//
const int FW_PROB_BOSS_0_ITEM_PROPERTYS  = 500;   //  0.0% default (0/1000) = not possible 
const int FW_PROB_BOSS_1_ITEM_PROPERTYS  = 400; // 25%   default (250/1000) 
const int FW_PROB_BOSS_2_ITEM_PROPERTYS  = 100; // 25%   default (250/1000) 
const int FW_PROB_BOSS_3_ITEM_PROPERTYS  = 0; // 25%   default (250/1000) 
const int FW_PROB_BOSS_4_ITEM_PROPERTYS  = 0; // 10%   default (100/1000) 
const int FW_PROB_BOSS_5_ITEM_PROPERTYS  = 0; // 10%   default (100/1000) 
const int FW_PROB_BOSS_6_ITEM_PROPERTYS  = 0;  //  2.5% default (25/1000) 
const int FW_PROB_BOSS_7_ITEM_PROPERTYS  = 0;  //  1.5% default (15/1000) 
const int FW_PROB_BOSS_8_ITEM_PROPERTYS  = 0;   //  0.6% default (6/1000) 
const int FW_PROB_BOSS_9_ITEM_PROPERTYS  = 0;   //  0.4% default (4/1000) 
const int FW_PROB_BOSS_10_ITEM_PROPERTYS = 0;   //  0.0% default (0/1000) = not possible 

// with update 2.0 I added in the ability to use the random loot generator with
// monsters and with placeable objects.  Same as above basically, except these
// control for placeable objects like treasure chests.
//
// NOTE: Remember DO NOT use negative numbers for probabilities. You'll get 
// unexpected results.
//
const int FW_PROB_PLACEABLE_0_ITEM_PROPERTYS = 750; // 35%   default (350/1000) = most frequent 
const int FW_PROB_PLACEABLE_1_ITEM_PROPERTYS = 225; // 25%   default (250/1000) 
const int FW_PROB_PLACEABLE_2_ITEM_PROPERTYS = 25; // 15%   default (150/1000) 
const int FW_PROB_PLACEABLE_3_ITEM_PROPERTYS = 0; // 10%   default (100/1000) 
const int FW_PROB_PLACEABLE_4_ITEM_PROPERTYS = 0;  //  7.5% default (75/1000) 
const int FW_PROB_PLACEABLE_5_ITEM_PROPERTYS = 0;  //  4.0% default (40/1000) 
const int FW_PROB_PLACEABLE_6_ITEM_PROPERTYS = 0;  //  2.0% default (20/1000) 
const int FW_PROB_PLACEABLE_7_ITEM_PROPERTYS = 0;  //  1.0% default (10/1000) 
const int FW_PROB_PLACEABLE_8_ITEM_PROPERTYS = 0;   //  0.3% default (3/1000) 
const int FW_PROB_PLACEABLE_9_ITEM_PROPERTYS = 0;   //  0.2% default (2/1000) 
const int FW_PROB_PLACEABLE_10_ITEM_PROPERTYS = 0;  //  0.0% default (0/1000) = not possible 


// *************** WHAT TYPE OF ARMOR MATERIAL DROPS *******************
//
// The FW_PROB_ARMOR_MATERIAL_* constants. 
//
// For the purposes of determining damage reduction (armors), we have
// to decide if the armor dropped will be of generic material or some 
// special type.
//
// The types for armors are: 
//
// Non-Specific,
// Metal Adamantine,
// Metal Darksteel,
// Metal Iron,
// Metal Mithral
//
// You set the probability of each metal type dropping with the constants
// below.  The higher the value you put in relation to the other values,
// the more likely that type of material drops. The default values add up
// to 1000, making calculation of probability easy for me. 
//
// NOTE: No negative numbers for probability. That would mess things up. 
//
// NOTE 2: Zero is an acceptable value.  That is how you would exclude 
//    something entirely.   
//
const int FW_PROB_ARMOR_MATERIAL_NON_SPECIFIC  = 750; // 35  % default (350/1000)
const int FW_PROB_ARMOR_MATERIAL_IRON          = 200; // 30  % default (300/1000)
const int FW_PROB_ARMOR_MATERIAL_DARKSTEEL     = 50; // 17.5% default (175/1000)
const int FW_PROB_ARMOR_MATERIAL_ADAMANTINE    = 0; // 12.5% default (125/1000)
const int FW_PROB_ARMOR_MATERIAL_MITHRAL       = 0; //  5  % default (50/1000)


// *********** WHAT TYPE OF METAL WEAPON MATERIAL DROPS *******************
//
// The FW_PROB_METAL_WEAP_MATERIAL_* constants.   
//
// For the purposes of overcoming damage reduction (weapons), we have
// to decide if the weapon dropped will be of generic material or some 
// special type.
//
// The material types for metal weapons are: 
//
// Non-Specific,
// Metal Adamantine,
// Metal Alchemical Silver,
// Metal Cold Iron,
// Metal Darksteel,
// Metal Mithral
//
// You set the probability of each metal type dropping with the constants
// below.  The higher the value you put in relation to the other values,
// the more likely that type of material drops. The default values add up
// to 1000, making calculation of probability easy for me. 
//
// NOTE: No negative numbers for probability. That would mess things up. 
//
// NOTE 2: Zero is an acceptable value.  That is how you would exclude 
//    something entirely.   
//
const int FW_PROB_METAL_WEAP_MATERIAL_NON_SPECIFIC      = 850; // 50   % default (500/1000)
const int FW_PROB_METAL_WEAP_MATERIAL_COLD_IRON         = 50; // 12.5 % default (125/1000)
const int FW_PROB_METAL_WEAP_MATERIAL_DARKSTEEL			= 50; // 12.5 % default (125/1000)
const int FW_PROB_METAL_WEAP_MATERIAL_ALCHEMICAL_SILVER = 50; // 12.5 % default (125/1000)
const int FW_PROB_METAL_WEAP_MATERIAL_ADAMANTINE 		= 0; //  7.5 % default (75/1000)
const int FW_PROB_METAL_WEAP_MATERIAL_MITHRAL			= 0; //  5   % default (50/1000)


// *********** WHAT TYPE OF WOODEN WEAPON MATERIAL DROPS *******************
//
// The FW_PROB_WOOD_WEAP_MATERIAL_* constants.   
//
// For the purposes of overcoming damage reduction (weapons), we have
// to decide if the weapon dropped will be of generic material or some 
// special type.
//
// The material types for wooden weapons are:
//
// Non-Specific,
// Duskwood,
// Zalantar
//
// You set the probability of each type dropping with the constants
// below.  The higher the value you put in relation to the other values,
// the more likely that type of material drops. The default values add up
// to 1000, making calculation of probability easy for me. 
//
// NOTE: No negative numbers for probability. That would mess things up. 
//
// NOTE 2: Zero is an acceptable value.  That is how you would exclude 
//    something entirely.   
//
const int FW_PROB_WOOD_WEAP_MATERIAL_NON_SPECIFIC = 1000; // 65   % default (650/1000)
const int FW_PROB_WOOD_WEAP_MATERIAL_ZALANTAR     = 0; // 17.5 % default (175/1000)
const int FW_PROB_WOOD_WEAP_MATERIAL_DUSKWOOD     = 0; // 17.5 % default (175/1000)


// *********** WHAT TYPE OF RECIPE DROPS *******************
//
// The FW_PROB_RECIPE_* constants.   
//
// The types of Recipies are:
//
// Non-Specific,
// Duskwood,
// Zalantar
//
// You set the probability of each type dropping with the constants
// below.  The higher the value you put in relation to the other values,
// the more likely that type of material drops. The default values add up
// to 1000, making calculation of probability easy for me. 
//
// NOTE: No negative numbers for probability. That would mess things up. 
//
// NOTE 2: Zero is an acceptable value.  That is how you would exclude 
//    something entirely.   
//
// NOTE 3: The default values furnish an equal chance of each item dropping
//
const int FW_TYPE_RECIPE_ABILITY2 = 1; 
const int FW_TYPE_RECIPE_ABILITY3 = 2; 
const int FW_TYPE_RECIPE_ABILITY4 = 3; 
const int FW_TYPE_RECIPE_ADAMANTINE = 4; 
const int FW_TYPE_RECIPE_COLDIRON = 5; 
const int FW_TYPE_RECIPE_DAMAGE_RESISTANCE = 6; 
const int FW_TYPE_RECIPE_DAMAGE1 = 7; 
const int FW_TYPE_RECIPE_DAMAGE1D6 = 8; 
const int FW_TYPE_RECIPE_DARKSTEEL = 9; 
const int FW_TYPE_RECIPE_ESSENCE_FAINT = 10; 
const int FW_TYPE_RECIPE_ESSENCE_GLOWING = 11; 
const int FW_TYPE_RECIPE_ESSENCE_RADIANT = 12; 
const int FW_TYPE_RECIPE_ESSENCE_WEAK = 13; 
const int FW_TYPE_RECIPE_MITHRAL = 14; 
const int FW_TYPE_RECIPE_NON_SPECIFIC = 15; 
const int FW_TYPE_RECIPE_ENCHANTMENT3 = 16; 
const int FW_TYPE_RECIPE_ENCHANTMENT4 = 17; 
const int FW_TYPE_RECIPE_SAVE2 = 18; 
const int FW_TYPE_RECIPE_SAVE3 = 19; 
const int FW_TYPE_RECIPE_SAVE4 = 20; 
const int FW_TYPE_RECIPE_SILVER = 21; 
const int FW_TYPE_RECIPE_SKILL4 = 22; 
const int FW_TYPE_RECIPE_SKILL8 = 23; 

// Note: EVEN odds means if ALL categories equaled this value then all recipies would have the same chance of being the one dropped
const int FW_PROB_RECIPE_NON_SPECIFIC = 334; // 146 items in category
const int FW_PROB_RECIPE_ADAMANTINE = 30; // 138 items in category
const int FW_PROB_RECIPE_DARKSTEEL = 143; // 134 items in category
const int FW_PROB_RECIPE_MITHRAL = 29; // 134 items in category
const int FW_PROB_RECIPE_COLDIRON = 104; // 7 items in category
const int FW_PROB_RECIPE_SILVER = 104; // 7 items in category
const int FW_PROB_RECIPE_ABILITY2 = 52; // 24 items in category
const int FW_PROB_RECIPE_ABILITY3 = 17; // 24 items in category
const int FW_PROB_RECIPE_ABILITY4 = 6; // 24 items in category
const int FW_PROB_RECIPE_ESSENCE_FAINT = 20; // 20 items in category
const int FW_PROB_RECIPE_ESSENCE_WEAK = 10; // 20 items in category
const int FW_PROB_RECIPE_ESSENCE_GLOWING = 5; // 20 items in category
const int FW_PROB_RECIPE_ESSENCE_RADIANT = 2; // 20 items in category
const int FW_PROB_RECIPE_DAMAGE_RESISTANCE = 35; // 16 items in category
const int FW_PROB_RECIPE_DAMAGE1 = 35; // 16 items in category
const int FW_PROB_RECIPE_DAMAGE1D6 = 12; // 16 items in category
const int FW_PROB_RECIPE_SKILL4 = 26; // 12 items in category
const int FW_PROB_RECIPE_SKILL8 = 0; // 12 items in category
const int FW_PROB_RECIPE_ENCHANTMENT3 = 17; // 8 items in category
const int FW_PROB_RECIPE_ENCHANTMENT4 = 6; // 8 items in category
const int FW_PROB_RECIPE_SAVE2 = 9; // 4 items in category
const int FW_PROB_RECIPE_SAVE3 = 3; // 4 items in category
const int FW_PROB_RECIPE_SAVE4 = 1; // 4 items in category






// *****************************************
//
//      DON'T CHANGE ANYTHING IN THIS FILE
// 		FROM HERE DOWN TO THE END UNLESS
// 		YOU ARE AN EXPERIENCED SCRIPTER
//
// *****************************************

/////////////////////////////////////////////
// *
// * 
// *		FUNCTION DECLARATIONS
// * 			DON'T CHANGE 
// *
// *
//////////////////////////////////////////////

//////////////////////////////////////////
// * Function that decides if an item is cursed.
// - nChance is how often out of a 1,000 rolls will an item be cursed.
//   By default 1 out of 1,000 items will be cursed. You can change this to
//   any frequency you want up to 1,000 out of 1,000 (all items) cursed.
//   Return TRUE if item is cursed.  Returns FALSE if item is not cursed.
//
int FW_IsItemCursed (int nChance = FW_PROB_CURSED_LOOT);

//////////////////////////////////////////
// * Function that decides if a monster spawn will drop loot or not.
// - nCR is the Challenge Rating of the spawning monster.
// - nCR can also be a user defined local variable put on a treasure chest
//
int FW_DoesMonsterDropLoot (int nCR = 0);

//////////////////////////////////////////
// * Function that decides how many items drop from a spawning monster.
//
int FW_HowManyItemsDrop ();

//////////////////////////////////////////
// * Function that decides how many item PROPERTIES appear on loot
//
int FW_HowManyIP ();

//////////////////////////////////////////
// * Function that decides what metal armor material type drops.
//
int FW_WhatMetalArmorMaterial ();

//////////////////////////////////////////
// * Function that decides what metal weapon material type drops.
//
int FW_WhatMetalWeaponMaterial ();

//////////////////////////////////////////
// * Function that decides what wooden weapon material type drops.
//
int FW_WhatWoodWeaponMaterial ();


/////////////////////////////////////////////
// *
// * 
// *			IMPLEMENTATION 
// *			 DON'T CHANGE
// *
// * 
//////////////////////////////////////////////

//////////////////////////////////////////
// * Function that decides if an item is cursed.
// - nChance is how often out of a 1,000 rolls will an item be cursed.
//   By default 1 out of 1,000 items will be cursed. You can change this to
//   any frequency you want up to 1,000 out of 1,000 (all items) cursed.
//   Return TRUE if item is cursed.  Returns FALSE if item is not cursed.
//
int FW_IsItemCursed (int nChance = FW_PROB_CURSED_LOOT)
{
   int nRoll = Random (1000);
   if (nChance >= nRoll)
         {  return TRUE;  }
   else  {  return FALSE; }
}

//////////////////////////////////////////
// * Function that decides if a monster spawn will drop loot or not.
// - nCR is the Challenge Rating of the spawning monster.
// - nCR can also be a user defined local variable put on a treasure chest
//
int FW_DoesMonsterDropLoot (int nCR = 0)
{		
	// Keep nCR within the bounds set.	
	if (nCR <= 0)
		nCR = 0;
	if (nCR >= 41)
		nCR = 41;
		
	int nRoll = Random (100) + 1;
	
	// See if the spawning monster has a local int variable "FW_BOSS" set to "1"
	// This will also check to see if a treasure chest is marked as a boss loot.
	int nBossCheck = GetLocalInt (OBJECT_SELF, "FW_BOSS");
	
	// See if the spawning monster has a local int variable "FW_TREASURE_CHEST" set to "1"
	int nPlaceableCheck = GetLocalInt(OBJECT_SELF, "FW_TREASURE_CHEST");
	
	// If the monster is a boss creature/treasure chest, 
	// then use the boss probability table.
	if (nBossCheck)
	{
		switch (nCR)
		{
		case 0: if (nRoll <= FW_PROB_BOSS_LOOT_CR_0  ) return TRUE; else return FALSE; break;
		
	    case 1: if (nRoll <= FW_PROB_BOSS_LOOT_CR_1  ) return TRUE; else return FALSE; break;
	    case 2: if (nRoll <= FW_PROB_BOSS_LOOT_CR_2  ) return TRUE; else return FALSE; break;
	    case 3: if (nRoll <= FW_PROB_BOSS_LOOT_CR_3  ) return TRUE; else return FALSE; break;
	    case 4: if (nRoll <= FW_PROB_BOSS_LOOT_CR_4  ) return TRUE; else return FALSE; break;
	    case 5: if (nRoll <= FW_PROB_BOSS_LOOT_CR_5  ) return TRUE; else return FALSE; break;
	    case 6: if (nRoll <= FW_PROB_BOSS_LOOT_CR_6  ) return TRUE; else return FALSE; break;
	    case 7: if (nRoll <= FW_PROB_BOSS_LOOT_CR_7  ) return TRUE; else return FALSE; break;
	    case 8: if (nRoll <= FW_PROB_BOSS_LOOT_CR_8  ) return TRUE; else return FALSE; break;
	    case 9: if (nRoll <= FW_PROB_BOSS_LOOT_CR_9  ) return TRUE; else return FALSE; break;
	    case 10: if (nRoll <= FW_PROB_BOSS_LOOT_CR_10  ) return TRUE; else return FALSE; break;
	    		
		case 11: if (nRoll <= FW_PROB_BOSS_LOOT_CR_11  ) return TRUE; else return FALSE; break;
	    case 12: if (nRoll <= FW_PROB_BOSS_LOOT_CR_12  ) return TRUE; else return FALSE; break;
	    case 13: if (nRoll <= FW_PROB_BOSS_LOOT_CR_13  ) return TRUE; else return FALSE; break;
	    case 14: if (nRoll <= FW_PROB_BOSS_LOOT_CR_14  ) return TRUE; else return FALSE; break;
	    case 15: if (nRoll <= FW_PROB_BOSS_LOOT_CR_15  ) return TRUE; else return FALSE; break;
	    case 16: if (nRoll <= FW_PROB_BOSS_LOOT_CR_16  ) return TRUE; else return FALSE; break;
	    case 17: if (nRoll <= FW_PROB_BOSS_LOOT_CR_17  ) return TRUE; else return FALSE; break;
	    case 18: if (nRoll <= FW_PROB_BOSS_LOOT_CR_18  ) return TRUE; else return FALSE; break;
	    case 19: if (nRoll <= FW_PROB_BOSS_LOOT_CR_19  ) return TRUE; else return FALSE; break;
	    case 20: if (nRoll <= FW_PROB_BOSS_LOOT_CR_20  ) return TRUE; else return FALSE; break;
	    
		case 21: if (nRoll <= FW_PROB_BOSS_LOOT_CR_21  ) return TRUE; else return FALSE; break;
	    case 22: if (nRoll <= FW_PROB_BOSS_LOOT_CR_22  ) return TRUE; else return FALSE; break;
	    case 23: if (nRoll <= FW_PROB_BOSS_LOOT_CR_23  ) return TRUE; else return FALSE; break;
	    case 24: if (nRoll <= FW_PROB_BOSS_LOOT_CR_24  ) return TRUE; else return FALSE; break;
	    case 25: if (nRoll <= FW_PROB_BOSS_LOOT_CR_25  ) return TRUE; else return FALSE; break;
	    case 26: if (nRoll <= FW_PROB_BOSS_LOOT_CR_26  ) return TRUE; else return FALSE; break;
	    case 27: if (nRoll <= FW_PROB_BOSS_LOOT_CR_27  ) return TRUE; else return FALSE; break;
	    case 28: if (nRoll <= FW_PROB_BOSS_LOOT_CR_28  ) return TRUE; else return FALSE; break;
	    case 29: if (nRoll <= FW_PROB_BOSS_LOOT_CR_29  ) return TRUE; else return FALSE; break;
	    case 30: if (nRoll <= FW_PROB_BOSS_LOOT_CR_30  ) return TRUE; else return FALSE; break;
	    
		case 31: if (nRoll <= FW_PROB_BOSS_LOOT_CR_31  ) return TRUE; else return FALSE; break;
	    case 32: if (nRoll <= FW_PROB_BOSS_LOOT_CR_32  ) return TRUE; else return FALSE; break;
	    case 33: if (nRoll <= FW_PROB_BOSS_LOOT_CR_33  ) return TRUE; else return FALSE; break;
	    case 34: if (nRoll <= FW_PROB_BOSS_LOOT_CR_34  ) return TRUE; else return FALSE; break;
	    case 35: if (nRoll <= FW_PROB_BOSS_LOOT_CR_35  ) return TRUE; else return FALSE; break;
	    case 36: if (nRoll <= FW_PROB_BOSS_LOOT_CR_36  ) return TRUE; else return FALSE; break;
	    case 37: if (nRoll <= FW_PROB_BOSS_LOOT_CR_37  ) return TRUE; else return FALSE; break;
	    case 38: if (nRoll <= FW_PROB_BOSS_LOOT_CR_38  ) return TRUE; else return FALSE; break;
	    case 39: if (nRoll <= FW_PROB_BOSS_LOOT_CR_39  ) return TRUE; else return FALSE; break;
	    case 40: if (nRoll <= FW_PROB_BOSS_LOOT_CR_40  ) return TRUE; else return FALSE; break;
	    
		case 41: if (nRoll <= FW_PROB_BOSS_LOOT_CR_41_OR_HIGHER  ) return TRUE; else return FALSE; break;
	    
		default: return FALSE; break;
		} // end of switch
	
	} // end of if
	
	// Because I checked for the boss marker first, boss >> placeable >> regular loot.
	else if (nPlaceableCheck)
	{
		switch (nCR)
		{
		case 0: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_0  ) return TRUE; else return FALSE; break;
		
	    case 1: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_1  ) return TRUE; else return FALSE; break;
	    case 2: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_2  ) return TRUE; else return FALSE; break;
	    case 3: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_3  ) return TRUE; else return FALSE; break;
	    case 4: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_4  ) return TRUE; else return FALSE; break;
	    case 5: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_5  ) return TRUE; else return FALSE; break;
	    case 6: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_6  ) return TRUE; else return FALSE; break;
	    case 7: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_7  ) return TRUE; else return FALSE; break;
	    case 8: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_8  ) return TRUE; else return FALSE; break;
	    case 9: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_9  ) return TRUE; else return FALSE; break;
	    case 10: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_10  ) return TRUE; else return FALSE; break;
	    		
		case 11: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_11  ) return TRUE; else return FALSE; break;
	    case 12: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_12  ) return TRUE; else return FALSE; break;
	    case 13: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_13  ) return TRUE; else return FALSE; break;
	    case 14: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_14  ) return TRUE; else return FALSE; break;
	    case 15: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_15  ) return TRUE; else return FALSE; break;
	    case 16: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_16  ) return TRUE; else return FALSE; break;
	    case 17: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_17  ) return TRUE; else return FALSE; break;
	    case 18: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_18  ) return TRUE; else return FALSE; break;
	    case 19: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_19  ) return TRUE; else return FALSE; break;
	    case 20: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_20  ) return TRUE; else return FALSE; break;
	    
		case 21: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_21  ) return TRUE; else return FALSE; break;
	    case 22: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_22  ) return TRUE; else return FALSE; break;
	    case 23: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_23  ) return TRUE; else return FALSE; break;
	    case 24: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_24  ) return TRUE; else return FALSE; break;
	    case 25: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_25  ) return TRUE; else return FALSE; break;
	    case 26: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_26  ) return TRUE; else return FALSE; break;
	    case 27: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_27  ) return TRUE; else return FALSE; break;
	    case 28: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_28  ) return TRUE; else return FALSE; break;
	    case 29: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_29  ) return TRUE; else return FALSE; break;
	    case 30: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_30  ) return TRUE; else return FALSE; break;
	    
		case 31: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_31  ) return TRUE; else return FALSE; break;
	    case 32: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_32  ) return TRUE; else return FALSE; break;
	    case 33: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_33  ) return TRUE; else return FALSE; break;
	    case 34: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_34  ) return TRUE; else return FALSE; break;
	    case 35: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_35  ) return TRUE; else return FALSE; break;
	    case 36: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_36  ) return TRUE; else return FALSE; break;
	    case 37: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_37  ) return TRUE; else return FALSE; break;
	    case 38: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_38  ) return TRUE; else return FALSE; break;
	    case 39: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_39  ) return TRUE; else return FALSE; break;
	    case 40: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_40  ) return TRUE; else return FALSE; break;
	    
		case 41: if (nRoll <= FW_PROB_PLACEABLE_LOOT_CR_41_OR_HIGHER  ) return TRUE; else return FALSE; break;
	    
		default: return FALSE; break;
		} // end of switch
	
	} // end of if
	
	
	// If not marked as boss loot or placeable loot, use the regular probability table.
	// Remember:  boss >> placeable >> regular loot.  That's the heirarchy.
	switch (nCR)
	{
		case 0: if (nRoll <= FW_PROB_LOOT_CR_0  ) return TRUE; else return FALSE; break;
		
	    case 1: if (nRoll <= FW_PROB_LOOT_CR_1  ) return TRUE; else return FALSE; break;
	    case 2: if (nRoll <= FW_PROB_LOOT_CR_2  ) return TRUE; else return FALSE; break;
	    case 3: if (nRoll <= FW_PROB_LOOT_CR_3  ) return TRUE; else return FALSE; break;
	    case 4: if (nRoll <= FW_PROB_LOOT_CR_4  ) return TRUE; else return FALSE; break;
	    case 5: if (nRoll <= FW_PROB_LOOT_CR_5  ) return TRUE; else return FALSE; break;
	    case 6: if (nRoll <= FW_PROB_LOOT_CR_6  ) return TRUE; else return FALSE; break;
	    case 7: if (nRoll <= FW_PROB_LOOT_CR_7  ) return TRUE; else return FALSE; break;
	    case 8: if (nRoll <= FW_PROB_LOOT_CR_8  ) return TRUE; else return FALSE; break;
	    case 9: if (nRoll <= FW_PROB_LOOT_CR_9  ) return TRUE; else return FALSE; break;
	    case 10: if (nRoll <= FW_PROB_LOOT_CR_10  ) return TRUE; else return FALSE; break;
	    		
		case 11: if (nRoll <= FW_PROB_LOOT_CR_11  ) return TRUE; else return FALSE; break;
	    case 12: if (nRoll <= FW_PROB_LOOT_CR_12  ) return TRUE; else return FALSE; break;
	    case 13: if (nRoll <= FW_PROB_LOOT_CR_13  ) return TRUE; else return FALSE; break;
	    case 14: if (nRoll <= FW_PROB_LOOT_CR_14  ) return TRUE; else return FALSE; break;
	    case 15: if (nRoll <= FW_PROB_LOOT_CR_15  ) return TRUE; else return FALSE; break;
	    case 16: if (nRoll <= FW_PROB_LOOT_CR_16  ) return TRUE; else return FALSE; break;
	    case 17: if (nRoll <= FW_PROB_LOOT_CR_17  ) return TRUE; else return FALSE; break;
	    case 18: if (nRoll <= FW_PROB_LOOT_CR_18  ) return TRUE; else return FALSE; break;
	    case 19: if (nRoll <= FW_PROB_LOOT_CR_19  ) return TRUE; else return FALSE; break;
	    case 20: if (nRoll <= FW_PROB_LOOT_CR_20  ) return TRUE; else return FALSE; break;
	    
		case 21: if (nRoll <= FW_PROB_LOOT_CR_21  ) return TRUE; else return FALSE; break;
	    case 22: if (nRoll <= FW_PROB_LOOT_CR_22  ) return TRUE; else return FALSE; break;
	    case 23: if (nRoll <= FW_PROB_LOOT_CR_23  ) return TRUE; else return FALSE; break;
	    case 24: if (nRoll <= FW_PROB_LOOT_CR_24  ) return TRUE; else return FALSE; break;
	    case 25: if (nRoll <= FW_PROB_LOOT_CR_25  ) return TRUE; else return FALSE; break;
	    case 26: if (nRoll <= FW_PROB_LOOT_CR_26  ) return TRUE; else return FALSE; break;
	    case 27: if (nRoll <= FW_PROB_LOOT_CR_27  ) return TRUE; else return FALSE; break;
	    case 28: if (nRoll <= FW_PROB_LOOT_CR_28  ) return TRUE; else return FALSE; break;
	    case 29: if (nRoll <= FW_PROB_LOOT_CR_29  ) return TRUE; else return FALSE; break;
	    case 30: if (nRoll <= FW_PROB_LOOT_CR_30  ) return TRUE; else return FALSE; break;
	    
		case 31: if (nRoll <= FW_PROB_LOOT_CR_31  ) return TRUE; else return FALSE; break;
	    case 32: if (nRoll <= FW_PROB_LOOT_CR_32  ) return TRUE; else return FALSE; break;
	    case 33: if (nRoll <= FW_PROB_LOOT_CR_33  ) return TRUE; else return FALSE; break;
	    case 34: if (nRoll <= FW_PROB_LOOT_CR_34  ) return TRUE; else return FALSE; break;
	    case 35: if (nRoll <= FW_PROB_LOOT_CR_35  ) return TRUE; else return FALSE; break;
	    case 36: if (nRoll <= FW_PROB_LOOT_CR_36  ) return TRUE; else return FALSE; break;
	    case 37: if (nRoll <= FW_PROB_LOOT_CR_37  ) return TRUE; else return FALSE; break;
	    case 38: if (nRoll <= FW_PROB_LOOT_CR_38  ) return TRUE; else return FALSE; break;
	    case 39: if (nRoll <= FW_PROB_LOOT_CR_39  ) return TRUE; else return FALSE; break;
	    case 40: if (nRoll <= FW_PROB_LOOT_CR_40  ) return TRUE; else return FALSE; break;
	    
		case 41: if (nRoll <= FW_PROB_LOOT_CR_41_OR_HIGHER  ) return TRUE; else return FALSE; break;
	    
		default: return FALSE; break;
	} // end of switch
	// I don't see how we would ever get out of this switch without 
	// returning TRUE or FALSE. But just in case...
	return FALSE;
} // end of function

//////////////////////////////////////////
// * Function that decides how many items drop from a spawning monster.
//
int FW_HowManyItemsDrop ()
{	
	int nTotalProbability;
	int nRoll;
	
	// See if the spawning monster has a local int variable "FW_BOSS" set to "1"
	// This will also check to see if a treasure chest is marked as a boss loot.
	int nBossCheck = GetLocalInt (OBJECT_SELF, "FW_BOSS");
	
	// See if the spawning monster has a local int variable "FW_TREASURE_CHEST" set to "1"
	int nPlaceableCheck = GetLocalInt(OBJECT_SELF, "FW_TREASURE_CHEST");
	
	// If the monster is marked as a boss, then use the boss probability table.
	if (nBossCheck)
	{		
		nTotalProbability = FW_PROB_BOSS_1_ITEMS_DROPPED + FW_PROB_BOSS_2_ITEMS_DROPPED +
							FW_PROB_BOSS_3_ITEMS_DROPPED + FW_PROB_BOSS_4_ITEMS_DROPPED +
							FW_PROB_BOSS_5_ITEMS_DROPPED + FW_PROB_BOSS_6_ITEMS_DROPPED +
							FW_PROB_BOSS_7_ITEMS_DROPPED + FW_PROB_BOSS_8_ITEMS_DROPPED +
							FW_PROB_BOSS_9_ITEMS_DROPPED + FW_PROB_BOSS_10_ITEMS_DROPPED;
						
		nRoll = Random (nTotalProbability) + 1;
	
		if      (nRoll <= FW_PROB_BOSS_1_ITEMS_DROPPED) 
			return 1;  
		else if (nRoll <= (FW_PROB_BOSS_1_ITEMS_DROPPED + 
					  FW_PROB_BOSS_2_ITEMS_DROPPED)) 
			return 2;
	    else
		    return 1;  
		/*else if (nRoll <= (FW_PROB_BOSS_1_ITEMS_DROPPED + 
					  FW_PROB_BOSS_2_ITEMS_DROPPED + 
					  FW_PROB_BOSS_3_ITEMS_DROPPED)) 
			return 3;  
		else if (nRoll <= (FW_PROB_BOSS_1_ITEMS_DROPPED + 
					  FW_PROB_BOSS_2_ITEMS_DROPPED +
					  FW_PROB_BOSS_3_ITEMS_DROPPED + 
					  FW_PROB_BOSS_4_ITEMS_DROPPED)) 
			return 4;  
		else if (nRoll <= (FW_PROB_BOSS_1_ITEMS_DROPPED + 
					  FW_PROB_BOSS_2_ITEMS_DROPPED +
					  FW_PROB_BOSS_3_ITEMS_DROPPED + 
					  FW_PROB_BOSS_4_ITEMS_DROPPED + 
					  FW_PROB_BOSS_5_ITEMS_DROPPED)) 
			return 5;  
		else if (nRoll <= (FW_PROB_BOSS_1_ITEMS_DROPPED + 
					  FW_PROB_BOSS_2_ITEMS_DROPPED +
					  FW_PROB_BOSS_3_ITEMS_DROPPED + 
					  FW_PROB_BOSS_4_ITEMS_DROPPED + 
					  FW_PROB_BOSS_5_ITEMS_DROPPED + 
					  FW_PROB_BOSS_6_ITEMS_DROPPED)) 
			return 6;  
		else if (nRoll <= (FW_PROB_BOSS_1_ITEMS_DROPPED + 
					  FW_PROB_BOSS_2_ITEMS_DROPPED +
					  FW_PROB_BOSS_3_ITEMS_DROPPED + 
					  FW_PROB_BOSS_4_ITEMS_DROPPED + 
					  FW_PROB_BOSS_5_ITEMS_DROPPED + 
					  FW_PROB_BOSS_6_ITEMS_DROPPED + 
					  FW_PROB_BOSS_7_ITEMS_DROPPED)) 
			return 7;  
		else if (nRoll <= (FW_PROB_BOSS_1_ITEMS_DROPPED + 
					  FW_PROB_BOSS_2_ITEMS_DROPPED +
					  FW_PROB_BOSS_3_ITEMS_DROPPED + 
					  FW_PROB_BOSS_4_ITEMS_DROPPED + 
					  FW_PROB_BOSS_5_ITEMS_DROPPED + 
					  FW_PROB_BOSS_6_ITEMS_DROPPED + 
					  FW_PROB_BOSS_7_ITEMS_DROPPED + 
					  FW_PROB_BOSS_8_ITEMS_DROPPED)) 
			return 8;  
		else if (nRoll <= (FW_PROB_BOSS_1_ITEMS_DROPPED + 
					  FW_PROB_BOSS_2_ITEMS_DROPPED +
					  FW_PROB_BOSS_3_ITEMS_DROPPED + 
					  FW_PROB_BOSS_4_ITEMS_DROPPED + 
					  FW_PROB_BOSS_5_ITEMS_DROPPED + 
					  FW_PROB_BOSS_6_ITEMS_DROPPED + 
					  FW_PROB_BOSS_7_ITEMS_DROPPED + 
					  FW_PROB_BOSS_8_ITEMS_DROPPED + 
					  FW_PROB_BOSS_9_ITEMS_DROPPED)) 
			return 9;  
		else // The boss dropped 10 items!!! Holy Cow.
			return 10;*/
	}
	
	// Because I checked for the boss marker first, boss >> placeable >> regular loot.
	else if (nPlaceableCheck)
	{
		nTotalProbability = FW_PROB_PLACEABLE_1_ITEMS_DROPPED + FW_PROB_PLACEABLE_2_ITEMS_DROPPED +
							FW_PROB_PLACEABLE_3_ITEMS_DROPPED + FW_PROB_PLACEABLE_4_ITEMS_DROPPED +
							FW_PROB_PLACEABLE_5_ITEMS_DROPPED + FW_PROB_PLACEABLE_6_ITEMS_DROPPED +
							FW_PROB_PLACEABLE_7_ITEMS_DROPPED + FW_PROB_PLACEABLE_8_ITEMS_DROPPED +
							FW_PROB_PLACEABLE_9_ITEMS_DROPPED + FW_PROB_PLACEABLE_10_ITEMS_DROPPED;
						
		nRoll = Random (nTotalProbability) + 1;
	
		if      (nRoll <= FW_PROB_PLACEABLE_1_ITEMS_DROPPED) 
			return 1;  
		else if (nRoll <= (FW_PROB_PLACEABLE_1_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_2_ITEMS_DROPPED)) 
			return 2;
		else
			return 1;  
		/*else if (nRoll <= (FW_PROB_PLACEABLE_1_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_2_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_3_ITEMS_DROPPED)) 
			return 3;  
		else if (nRoll <= (FW_PROB_PLACEABLE_1_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_2_ITEMS_DROPPED +
					  FW_PROB_PLACEABLE_3_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_4_ITEMS_DROPPED)) 
			return 4;  
		else if (nRoll <= (FW_PROB_PLACEABLE_1_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_2_ITEMS_DROPPED +
					  FW_PROB_PLACEABLE_3_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_4_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_5_ITEMS_DROPPED)) 
			return 5;  
		else if (nRoll <= (FW_PROB_PLACEABLE_1_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_2_ITEMS_DROPPED +
					  FW_PROB_PLACEABLE_3_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_4_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_5_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_6_ITEMS_DROPPED)) 
			return 6;  
		else if (nRoll <= (FW_PROB_PLACEABLE_1_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_2_ITEMS_DROPPED +
					  FW_PROB_PLACEABLE_3_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_4_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_5_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_6_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_7_ITEMS_DROPPED)) 
			return 7;  
		else if (nRoll <= (FW_PROB_PLACEABLE_1_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_2_ITEMS_DROPPED +
					  FW_PROB_PLACEABLE_3_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_4_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_5_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_6_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_7_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_8_ITEMS_DROPPED)) 
			return 8;  
		else if (nRoll <= (FW_PROB_PLACEABLE_1_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_2_ITEMS_DROPPED +
					  FW_PROB_PLACEABLE_3_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_4_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_5_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_6_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_7_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_8_ITEMS_DROPPED + 
					  FW_PROB_PLACEABLE_9_ITEMS_DROPPED)) 
			return 9;  
		else // The placeable dropped 10 items!!! Holy Cow.
			return 10; */	
	}	
	
	// Remember:  boss >> placeable >> regular loot.
	// Otherwise, the not a boss nor a placeable so use the normal 
	// probability table.	
	nTotalProbability = FW_PROB_1_ITEMS_DROPPED + FW_PROB_2_ITEMS_DROPPED +
						FW_PROB_3_ITEMS_DROPPED + FW_PROB_4_ITEMS_DROPPED +
						FW_PROB_5_ITEMS_DROPPED + FW_PROB_6_ITEMS_DROPPED +
						FW_PROB_7_ITEMS_DROPPED + FW_PROB_8_ITEMS_DROPPED +
						FW_PROB_9_ITEMS_DROPPED + FW_PROB_10_ITEMS_DROPPED;
						
	nRoll = Random (nTotalProbability) + 1;
	
	if      (nRoll <= FW_PROB_1_ITEMS_DROPPED) 
		return 1;  
	else if (nRoll <= (FW_PROB_1_ITEMS_DROPPED + 
					  FW_PROB_2_ITEMS_DROPPED)) 
		return 2;
	else
		return 1;
	/*else if (nRoll <= (FW_PROB_1_ITEMS_DROPPED + 
					  FW_PROB_2_ITEMS_DROPPED + 
					  FW_PROB_3_ITEMS_DROPPED)) 
		return 3;  
	else if (nRoll <= (FW_PROB_1_ITEMS_DROPPED + 
					  FW_PROB_2_ITEMS_DROPPED +
					  FW_PROB_3_ITEMS_DROPPED + 
					  FW_PROB_4_ITEMS_DROPPED)) 
		return 4;  
	else if (nRoll <= (FW_PROB_1_ITEMS_DROPPED + 
					  FW_PROB_2_ITEMS_DROPPED +
					  FW_PROB_3_ITEMS_DROPPED + 
					  FW_PROB_4_ITEMS_DROPPED + 
					  FW_PROB_5_ITEMS_DROPPED)) 
		return 5;  
	else if (nRoll <= (FW_PROB_1_ITEMS_DROPPED + 
					  FW_PROB_2_ITEMS_DROPPED +
					  FW_PROB_3_ITEMS_DROPPED + 
					  FW_PROB_4_ITEMS_DROPPED + 
					  FW_PROB_5_ITEMS_DROPPED + 
					  FW_PROB_6_ITEMS_DROPPED)) 
		return 6;  
	else if (nRoll <= (FW_PROB_1_ITEMS_DROPPED + 
					  FW_PROB_2_ITEMS_DROPPED +
					  FW_PROB_3_ITEMS_DROPPED + 
					  FW_PROB_4_ITEMS_DROPPED + 
					  FW_PROB_5_ITEMS_DROPPED + 
					  FW_PROB_6_ITEMS_DROPPED + 
					  FW_PROB_7_ITEMS_DROPPED)) 
		return 7;  
	else if (nRoll <= (FW_PROB_1_ITEMS_DROPPED + 
					  FW_PROB_2_ITEMS_DROPPED +
					  FW_PROB_3_ITEMS_DROPPED + 
					  FW_PROB_4_ITEMS_DROPPED + 
					  FW_PROB_5_ITEMS_DROPPED + 
					  FW_PROB_6_ITEMS_DROPPED + 
					  FW_PROB_7_ITEMS_DROPPED + 
					  FW_PROB_8_ITEMS_DROPPED)) 
		return 8;  
	else if (nRoll <= (FW_PROB_1_ITEMS_DROPPED + 
					  FW_PROB_2_ITEMS_DROPPED +
					  FW_PROB_3_ITEMS_DROPPED + 
					  FW_PROB_4_ITEMS_DROPPED + 
					  FW_PROB_5_ITEMS_DROPPED + 
					  FW_PROB_6_ITEMS_DROPPED + 
					  FW_PROB_7_ITEMS_DROPPED + 
					  FW_PROB_8_ITEMS_DROPPED + 
					  FW_PROB_9_ITEMS_DROPPED)) 
		return 9;  
	else // A monster dropped 10 items!!! Holy Cow.
		return 10; */
} // end of function

//////////////////////////////////////////
// * Function that decides how many item PROPERTIES appear on loot
//
int FW_HowManyIP ()
{	
	int nTotalProbability;
	int nRoll;
	
	// Update for version 2.0.  This section added to account for boss creatures.
	// See if the spawning monster has a local int variable "FW_BOSS" set to "1"
	// This check also applies to treasure chests.
	int nBossCheck = GetLocalInt (OBJECT_SELF, "FW_BOSS");
	
	// See if the spawning monster has a local int variable "FW_TREASURE_CHEST" set to "1"
	int nPlaceableCheck = GetLocalInt(OBJECT_SELF, "FW_TREASURE_CHEST");
	
	// If the loot is marked as a boss, then use the boss probability table to
	// determine the number of items to drop.
	// Remember: boss >> placeable >> regular loot.
	if (nBossCheck)
	{
		nTotalProbability = FW_PROB_BOSS_0_ITEM_PROPERTYS + FW_PROB_BOSS_1_ITEM_PROPERTYS +
						FW_PROB_BOSS_2_ITEM_PROPERTYS + FW_PROB_BOSS_3_ITEM_PROPERTYS + 
						FW_PROB_BOSS_4_ITEM_PROPERTYS + FW_PROB_BOSS_5_ITEM_PROPERTYS + 
						FW_PROB_BOSS_6_ITEM_PROPERTYS + FW_PROB_BOSS_7_ITEM_PROPERTYS + 
						FW_PROB_BOSS_8_ITEM_PROPERTYS + FW_PROB_BOSS_9_ITEM_PROPERTYS + 
						FW_PROB_BOSS_10_ITEM_PROPERTYS;
				
		nRoll = Random (nTotalProbability) + 1;
	
		if      (nRoll <=  FW_PROB_BOSS_0_ITEM_PROPERTYS) 
			return 0;
		else if (nRoll <= (FW_PROB_BOSS_0_ITEM_PROPERTYS +
					   FW_PROB_BOSS_1_ITEM_PROPERTYS ))
			return 1;
		else if (nRoll <= (FW_PROB_BOSS_0_ITEM_PROPERTYS +
					   FW_PROB_BOSS_1_ITEM_PROPERTYS +
					   FW_PROB_BOSS_2_ITEM_PROPERTYS ))
			return 2;
		else if (nRoll <= (FW_PROB_BOSS_0_ITEM_PROPERTYS +
					   FW_PROB_BOSS_1_ITEM_PROPERTYS +
					   FW_PROB_BOSS_2_ITEM_PROPERTYS +
					   FW_PROB_BOSS_3_ITEM_PROPERTYS ))
			return 3;
		else if (nRoll <= (FW_PROB_BOSS_0_ITEM_PROPERTYS +
					   FW_PROB_BOSS_1_ITEM_PROPERTYS +
					   FW_PROB_BOSS_2_ITEM_PROPERTYS +
					   FW_PROB_BOSS_3_ITEM_PROPERTYS +
					   FW_PROB_BOSS_4_ITEM_PROPERTYS ))
			return 4;
		else if (nRoll <= (FW_PROB_BOSS_0_ITEM_PROPERTYS +
					   FW_PROB_BOSS_1_ITEM_PROPERTYS +
					   FW_PROB_BOSS_2_ITEM_PROPERTYS +
					   FW_PROB_BOSS_3_ITEM_PROPERTYS +
					   FW_PROB_BOSS_4_ITEM_PROPERTYS +
					   FW_PROB_BOSS_5_ITEM_PROPERTYS ))
			return 5;
		else if (nRoll <= (FW_PROB_BOSS_0_ITEM_PROPERTYS +
					   FW_PROB_BOSS_1_ITEM_PROPERTYS +
					   FW_PROB_BOSS_2_ITEM_PROPERTYS +
					   FW_PROB_BOSS_3_ITEM_PROPERTYS +
					   FW_PROB_BOSS_4_ITEM_PROPERTYS +
					   FW_PROB_BOSS_5_ITEM_PROPERTYS +
					   FW_PROB_BOSS_6_ITEM_PROPERTYS ))
			return 6;
		else if (nRoll <= (FW_PROB_BOSS_0_ITEM_PROPERTYS +
					   FW_PROB_BOSS_1_ITEM_PROPERTYS +
					   FW_PROB_BOSS_2_ITEM_PROPERTYS +
					   FW_PROB_BOSS_3_ITEM_PROPERTYS +
					   FW_PROB_BOSS_4_ITEM_PROPERTYS +
					   FW_PROB_BOSS_5_ITEM_PROPERTYS +
					   FW_PROB_BOSS_6_ITEM_PROPERTYS +
					   FW_PROB_BOSS_7_ITEM_PROPERTYS ))
			return 7;
		else if (nRoll <= (FW_PROB_BOSS_0_ITEM_PROPERTYS +
					   FW_PROB_BOSS_1_ITEM_PROPERTYS +
					   FW_PROB_BOSS_2_ITEM_PROPERTYS +
					   FW_PROB_BOSS_3_ITEM_PROPERTYS +
					   FW_PROB_BOSS_4_ITEM_PROPERTYS +
					   FW_PROB_BOSS_5_ITEM_PROPERTYS +
					   FW_PROB_BOSS_6_ITEM_PROPERTYS +
					   FW_PROB_BOSS_7_ITEM_PROPERTYS +
					   FW_PROB_BOSS_8_ITEM_PROPERTYS ))
			return 8;
		else if (nRoll <= (FW_PROB_BOSS_0_ITEM_PROPERTYS +
					   FW_PROB_BOSS_1_ITEM_PROPERTYS +
					   FW_PROB_BOSS_2_ITEM_PROPERTYS +
					   FW_PROB_BOSS_3_ITEM_PROPERTYS +
					   FW_PROB_BOSS_4_ITEM_PROPERTYS +
					   FW_PROB_BOSS_5_ITEM_PROPERTYS +
					   FW_PROB_BOSS_6_ITEM_PROPERTYS +
					   FW_PROB_BOSS_7_ITEM_PROPERTYS +
					   FW_PROB_BOSS_8_ITEM_PROPERTYS +
					   FW_PROB_BOSS_9_ITEM_PROPERTYS ))
			return 9;
		else // Wow 10 Item properties on a single item! You can technically have
	    	 // 25 item properties on an item, but I didn't code that many possibilities
			 // because that is beyond ridiculous.  Most people will probably say even
		 	 // coding for 10 item properties is ridiculous, but hey, I had to stop
		 	 // at something.  I chose to stop at 10 IP.
			return 10;	
	} // end of if (nBossCheck)
	
	else if (nPlaceableCheck)
	{
		nTotalProbability = FW_PROB_PLACEABLE_0_ITEM_PROPERTYS + FW_PROB_PLACEABLE_1_ITEM_PROPERTYS +
						FW_PROB_PLACEABLE_2_ITEM_PROPERTYS + FW_PROB_PLACEABLE_3_ITEM_PROPERTYS + 
						FW_PROB_PLACEABLE_4_ITEM_PROPERTYS + FW_PROB_PLACEABLE_5_ITEM_PROPERTYS + 
						FW_PROB_PLACEABLE_6_ITEM_PROPERTYS + FW_PROB_PLACEABLE_7_ITEM_PROPERTYS + 
						FW_PROB_PLACEABLE_8_ITEM_PROPERTYS + FW_PROB_PLACEABLE_9_ITEM_PROPERTYS + 
						FW_PROB_PLACEABLE_10_ITEM_PROPERTYS;
				
		nRoll = Random (nTotalProbability) + 1;
	
		if      (nRoll <=  FW_PROB_PLACEABLE_0_ITEM_PROPERTYS) 
			return 0;
		else if (nRoll <= (FW_PROB_PLACEABLE_0_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_1_ITEM_PROPERTYS ))
			return 1;
		else if (nRoll <= (FW_PROB_PLACEABLE_0_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_1_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_2_ITEM_PROPERTYS ))
			return 2;
		else if (nRoll <= (FW_PROB_PLACEABLE_0_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_1_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_2_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_3_ITEM_PROPERTYS ))
			return 3;
		else if (nRoll <= (FW_PROB_PLACEABLE_0_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_1_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_2_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_3_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_4_ITEM_PROPERTYS ))
			return 4;
		else if (nRoll <= (FW_PROB_PLACEABLE_0_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_1_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_2_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_3_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_4_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_5_ITEM_PROPERTYS ))
			return 5;
		else if (nRoll <= (FW_PROB_PLACEABLE_0_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_1_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_2_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_3_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_4_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_5_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_6_ITEM_PROPERTYS ))
			return 6;
		else if (nRoll <= (FW_PROB_PLACEABLE_0_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_1_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_2_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_3_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_4_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_5_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_6_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_7_ITEM_PROPERTYS ))
			return 7;
		else if (nRoll <= (FW_PROB_PLACEABLE_0_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_1_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_2_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_3_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_4_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_5_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_6_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_7_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_8_ITEM_PROPERTYS ))
			return 8;
		else if (nRoll <= (FW_PROB_PLACEABLE_0_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_1_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_2_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_3_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_4_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_5_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_6_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_7_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_8_ITEM_PROPERTYS +
					   FW_PROB_PLACEABLE_9_ITEM_PROPERTYS ))
			return 9;
		else // Wow 10 Item properties on a single item! You can technically have
	    	 // 25 item properties on an item, but I didn't code that many possibilities
			 // because that is beyond ridiculous.  Most people will probably say even
		 	 // coding for 10 item properties is ridiculous, but hey, I had to stop
		 	 // at something.  I chose to stop at 10 IP.
			return 10;	
	} // end of if (nPlaceableCheck)
	
	// Remember:  boss >> placeable >> regular loot.
	// Otherwise, it is normal loot.  Determine how many item properties
	// will appear on the item.	
	nTotalProbability = FW_PROB_0_ITEM_PROPERTYS + FW_PROB_1_ITEM_PROPERTYS +
						FW_PROB_2_ITEM_PROPERTYS + FW_PROB_3_ITEM_PROPERTYS + 
						FW_PROB_4_ITEM_PROPERTYS + FW_PROB_5_ITEM_PROPERTYS + 
						FW_PROB_6_ITEM_PROPERTYS + FW_PROB_7_ITEM_PROPERTYS + 
						FW_PROB_8_ITEM_PROPERTYS + FW_PROB_9_ITEM_PROPERTYS + 
						FW_PROB_10_ITEM_PROPERTYS;
				
	nRoll = Random (nTotalProbability) + 1;
	
	if      (nRoll <=  FW_PROB_0_ITEM_PROPERTYS) 
		return 0;
	else if (nRoll <= (FW_PROB_0_ITEM_PROPERTYS +
					   FW_PROB_1_ITEM_PROPERTYS ))
		return 1;
	else if (nRoll <= (FW_PROB_0_ITEM_PROPERTYS +
					   FW_PROB_1_ITEM_PROPERTYS +
					   FW_PROB_2_ITEM_PROPERTYS ))
		return 2;
	else if (nRoll <= (FW_PROB_0_ITEM_PROPERTYS +
					   FW_PROB_1_ITEM_PROPERTYS +
					   FW_PROB_2_ITEM_PROPERTYS +
					   FW_PROB_3_ITEM_PROPERTYS ))
		return 3;
	else if (nRoll <= (FW_PROB_0_ITEM_PROPERTYS +
					   FW_PROB_1_ITEM_PROPERTYS +
					   FW_PROB_2_ITEM_PROPERTYS +
					   FW_PROB_3_ITEM_PROPERTYS +
					   FW_PROB_4_ITEM_PROPERTYS ))
		return 4;
	else if (nRoll <= (FW_PROB_0_ITEM_PROPERTYS +
					   FW_PROB_1_ITEM_PROPERTYS +
					   FW_PROB_2_ITEM_PROPERTYS +
					   FW_PROB_3_ITEM_PROPERTYS +
					   FW_PROB_4_ITEM_PROPERTYS +
					   FW_PROB_5_ITEM_PROPERTYS ))
		return 5;
	else if (nRoll <= (FW_PROB_0_ITEM_PROPERTYS +
					   FW_PROB_1_ITEM_PROPERTYS +
					   FW_PROB_2_ITEM_PROPERTYS +
					   FW_PROB_3_ITEM_PROPERTYS +
					   FW_PROB_4_ITEM_PROPERTYS +
					   FW_PROB_5_ITEM_PROPERTYS +
					   FW_PROB_6_ITEM_PROPERTYS ))
		return 6;
	else if (nRoll <= (FW_PROB_0_ITEM_PROPERTYS +
					   FW_PROB_1_ITEM_PROPERTYS +
					   FW_PROB_2_ITEM_PROPERTYS +
					   FW_PROB_3_ITEM_PROPERTYS +
					   FW_PROB_4_ITEM_PROPERTYS +
					   FW_PROB_5_ITEM_PROPERTYS +
					   FW_PROB_6_ITEM_PROPERTYS +
					   FW_PROB_7_ITEM_PROPERTYS ))
		return 7;
	else if (nRoll <= (FW_PROB_0_ITEM_PROPERTYS +
					   FW_PROB_1_ITEM_PROPERTYS +
					   FW_PROB_2_ITEM_PROPERTYS +
					   FW_PROB_3_ITEM_PROPERTYS +
					   FW_PROB_4_ITEM_PROPERTYS +
					   FW_PROB_5_ITEM_PROPERTYS +
					   FW_PROB_6_ITEM_PROPERTYS +
					   FW_PROB_7_ITEM_PROPERTYS +
					   FW_PROB_8_ITEM_PROPERTYS ))
		return 8;
	else if (nRoll <= (FW_PROB_0_ITEM_PROPERTYS +
					   FW_PROB_1_ITEM_PROPERTYS +
					   FW_PROB_2_ITEM_PROPERTYS +
					   FW_PROB_3_ITEM_PROPERTYS +
					   FW_PROB_4_ITEM_PROPERTYS +
					   FW_PROB_5_ITEM_PROPERTYS +
					   FW_PROB_6_ITEM_PROPERTYS +
					   FW_PROB_7_ITEM_PROPERTYS +
					   FW_PROB_8_ITEM_PROPERTYS +
					   FW_PROB_9_ITEM_PROPERTYS ))
		return 9;
	else // Wow 10 Item properties on a single item! You can technically have
	     // 25 item properties on an item, but I didn't code that many possibilities
		 // because that is beyond ridiculous.  Most people will probably say even
		 // coding for 10 item properties is ridiculous, but hey, I had to stop
		 // at something.  I chose to stop at 10 IP.
		return 10;
} // end of function


//////////////////////////////////////////
// * Function that decides what metal armor material type drops.
//
int FW_WhatMetalArmorMaterial ()
{
	int nTotalProbability = FW_PROB_ARMOR_MATERIAL_NON_SPECIFIC +
							FW_PROB_ARMOR_MATERIAL_ADAMANTINE +
							FW_PROB_ARMOR_MATERIAL_DARKSTEEL +
							FW_PROB_ARMOR_MATERIAL_IRON +
							FW_PROB_ARMOR_MATERIAL_MITHRAL;
	
	int nRoll = Random (nTotalProbability) + 1;
	
	if      (nRoll <=  FW_PROB_ARMOR_MATERIAL_NON_SPECIFIC)
	
		return FW_MATERIAL_NON_SPECIFIC;
		
	else if (nRoll <= (FW_PROB_ARMOR_MATERIAL_NON_SPECIFIC +
					   FW_PROB_ARMOR_MATERIAL_ADAMANTINE))
					  
		return FW_MATERIAL_IRON; //return FW_MATERIAL_ADAMANTINE;
		
	else if (nRoll <= (FW_PROB_ARMOR_MATERIAL_NON_SPECIFIC +
					   FW_PROB_ARMOR_MATERIAL_ADAMANTINE +
					   FW_PROB_ARMOR_MATERIAL_DARKSTEEL))
					  
		return FW_MATERIAL_DARK_STEEL;
		
	else if (nRoll <= (FW_PROB_ARMOR_MATERIAL_NON_SPECIFIC +
					   FW_PROB_ARMOR_MATERIAL_ADAMANTINE +
					   FW_PROB_ARMOR_MATERIAL_DARKSTEEL +
					   FW_PROB_ARMOR_MATERIAL_IRON))
					  
		return FW_MATERIAL_IRON;
		
	else    
		return FW_MATERIAL_IRON; //return FW_MATERIAL_MITHRAL;
}

//////////////////////////////////////////
// * Function that decides what metal weapon material type drops.
//
int FW_WhatMetalWeaponMaterial ()
{
	int nTotalProbability = FW_PROB_METAL_WEAP_MATERIAL_NON_SPECIFIC +
							FW_PROB_METAL_WEAP_MATERIAL_COLD_IRON +
							FW_PROB_METAL_WEAP_MATERIAL_DARKSTEEL +
							FW_PROB_METAL_WEAP_MATERIAL_ALCHEMICAL_SILVER +
							FW_PROB_METAL_WEAP_MATERIAL_ADAMANTINE +
							FW_PROB_METAL_WEAP_MATERIAL_MITHRAL ;
							
	int nRoll = Random (nTotalProbability) + 1;
	
	
	if      (nRoll <= (FW_PROB_METAL_WEAP_MATERIAL_NON_SPECIFIC))
	
		return FW_MATERIAL_NON_SPECIFIC;
	
	else if (nRoll <= (FW_PROB_METAL_WEAP_MATERIAL_NON_SPECIFIC +
					   FW_PROB_METAL_WEAP_MATERIAL_COLD_IRON))
	
		return FW_MATERIAL_COLD_IRON;
	
	else if (nRoll <= (FW_PROB_METAL_WEAP_MATERIAL_NON_SPECIFIC +
					   FW_PROB_METAL_WEAP_MATERIAL_COLD_IRON +
					   FW_PROB_METAL_WEAP_MATERIAL_DARKSTEEL ))
	
		return FW_MATERIAL_DARK_STEEL;

	else if (nRoll <= (FW_PROB_METAL_WEAP_MATERIAL_NON_SPECIFIC +
					   FW_PROB_METAL_WEAP_MATERIAL_COLD_IRON +
					   FW_PROB_METAL_WEAP_MATERIAL_DARKSTEEL +
					   FW_PROB_METAL_WEAP_MATERIAL_ALCHEMICAL_SILVER ))
	
		return FW_MATERIAL_ALCHEMICAL_SILVER;

	else if (nRoll <= (FW_PROB_METAL_WEAP_MATERIAL_NON_SPECIFIC +
					   FW_PROB_METAL_WEAP_MATERIAL_COLD_IRON +
					   FW_PROB_METAL_WEAP_MATERIAL_DARKSTEEL +
					   FW_PROB_METAL_WEAP_MATERIAL_ALCHEMICAL_SILVER +
					   FW_PROB_METAL_WEAP_MATERIAL_ADAMANTINE ))
	
		return FW_MATERIAL_NON_SPECIFIC;//return FW_MATERIAL_ADAMANTINE;

	else 
	
		return FW_MATERIAL_NON_SPECIFIC;//return FW_MATERIAL_MITHRAL;
}

//////////////////////////////////////////
// * Function that decides what wooden weapon material type drops.
//
int FW_WhatWoodWeaponMaterial ()
{
	int nTotalProbability = FW_PROB_WOOD_WEAP_MATERIAL_NON_SPECIFIC +
							FW_PROB_WOOD_WEAP_MATERIAL_DUSKWOOD +
							FW_PROB_WOOD_WEAP_MATERIAL_ZALANTAR;
							
	int nRoll = Random (nTotalProbability) + 1;
	
	if      (nRoll <= (FW_PROB_WOOD_WEAP_MATERIAL_NON_SPECIFIC))
	
		return FW_MATERIAL_NON_SPECIFIC;

	else if (nRoll <= (FW_PROB_WOOD_WEAP_MATERIAL_NON_SPECIFIC +
					   FW_PROB_WOOD_WEAP_MATERIAL_DUSKWOOD))
					   
		return FW_MATERIAL_NON_SPECIFIC;//return FW_MATERIAL_DUSKWOOD;
	
	else  
	
		return FW_MATERIAL_NON_SPECIFIC;//return FW_MATERIAL_ZALANTAR;		
}

//////////////////////////////////////////
// * Function that decides what recipe type drops.
//
int FW_WhatRecipeType ()
{
	int nTotalProbability = FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4 +
				FW_PROB_RECIPE_ESSENCE_FAINT +
				FW_PROB_RECIPE_ESSENCE_GLOWING +
				FW_PROB_RECIPE_ESSENCE_RADIANT +
				FW_PROB_RECIPE_ESSENCE_WEAK +
				FW_PROB_RECIPE_DAMAGE_RESISTANCE +
				FW_PROB_RECIPE_DAMAGE1 +
				FW_PROB_RECIPE_DAMAGE1D6 +
				FW_PROB_RECIPE_SKILL4 +
				FW_PROB_RECIPE_SKILL8 +
				FW_PROB_RECIPE_ENCHANTMENT3 +
				FW_PROB_RECIPE_ENCHANTMENT4 +
				FW_PROB_RECIPE_SAVE2 +
				FW_PROB_RECIPE_SAVE3 +
				FW_PROB_RECIPE_SAVE4;
							
	int nRoll = Random (nTotalProbability) + 1;
	
	if      (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC)) return FW_TYPE_RECIPE_NON_SPECIFIC;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE)) return FW_TYPE_RECIPE_ADAMANTINE;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL)) return FW_TYPE_RECIPE_DARKSTEEL;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL)) return FW_TYPE_RECIPE_MITHRAL;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON)) return FW_TYPE_RECIPE_COLDIRON;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER)) return FW_TYPE_RECIPE_SILVER;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2)) return FW_TYPE_RECIPE_ABILITY2;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3)) return FW_TYPE_RECIPE_ABILITY3;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4)) return FW_TYPE_RECIPE_ABILITY4;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4 +
				FW_PROB_RECIPE_ESSENCE_FAINT)) return FW_TYPE_RECIPE_ESSENCE_FAINT;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4 +
				FW_PROB_RECIPE_ESSENCE_FAINT +
				FW_PROB_RECIPE_ESSENCE_GLOWING)) return FW_TYPE_RECIPE_ESSENCE_GLOWING;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4 +
				FW_PROB_RECIPE_ESSENCE_FAINT +
				FW_PROB_RECIPE_ESSENCE_GLOWING +
				FW_PROB_RECIPE_ESSENCE_RADIANT)) return FW_TYPE_RECIPE_ESSENCE_RADIANT;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4 +
				FW_PROB_RECIPE_ESSENCE_FAINT +
				FW_PROB_RECIPE_ESSENCE_GLOWING +
				FW_PROB_RECIPE_ESSENCE_RADIANT +
				FW_PROB_RECIPE_ESSENCE_WEAK)) return FW_TYPE_RECIPE_ESSENCE_WEAK;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4 +
				FW_PROB_RECIPE_ESSENCE_FAINT +
				FW_PROB_RECIPE_ESSENCE_GLOWING +
				FW_PROB_RECIPE_ESSENCE_RADIANT +
				FW_PROB_RECIPE_ESSENCE_WEAK +
				FW_PROB_RECIPE_DAMAGE_RESISTANCE)) return FW_TYPE_RECIPE_DAMAGE_RESISTANCE;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4 +
				FW_PROB_RECIPE_ESSENCE_FAINT +
				FW_PROB_RECIPE_ESSENCE_GLOWING +
				FW_PROB_RECIPE_ESSENCE_RADIANT +
				FW_PROB_RECIPE_ESSENCE_WEAK +
				FW_PROB_RECIPE_DAMAGE_RESISTANCE +
				FW_PROB_RECIPE_DAMAGE1)) return FW_TYPE_RECIPE_DAMAGE1;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4 +
				FW_PROB_RECIPE_ESSENCE_FAINT +
				FW_PROB_RECIPE_ESSENCE_GLOWING +
				FW_PROB_RECIPE_ESSENCE_RADIANT +
				FW_PROB_RECIPE_ESSENCE_WEAK +
				FW_PROB_RECIPE_DAMAGE_RESISTANCE +
				FW_PROB_RECIPE_DAMAGE1 +
				FW_PROB_RECIPE_DAMAGE1D6)) return FW_TYPE_RECIPE_DAMAGE1D6;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4 +
				FW_PROB_RECIPE_ESSENCE_FAINT +
				FW_PROB_RECIPE_ESSENCE_GLOWING +
				FW_PROB_RECIPE_ESSENCE_RADIANT +
				FW_PROB_RECIPE_ESSENCE_WEAK +
				FW_PROB_RECIPE_DAMAGE_RESISTANCE +
				FW_PROB_RECIPE_DAMAGE1 +
				FW_PROB_RECIPE_DAMAGE1D6 +
				FW_PROB_RECIPE_SKILL4)) return FW_TYPE_RECIPE_SKILL4;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4 +
				FW_PROB_RECIPE_ESSENCE_FAINT +
				FW_PROB_RECIPE_ESSENCE_GLOWING +
				FW_PROB_RECIPE_ESSENCE_RADIANT +
				FW_PROB_RECIPE_ESSENCE_WEAK +
				FW_PROB_RECIPE_DAMAGE_RESISTANCE +
				FW_PROB_RECIPE_DAMAGE1 +
				FW_PROB_RECIPE_DAMAGE1D6 +
				FW_PROB_RECIPE_SKILL4 +
				FW_PROB_RECIPE_SKILL8)) return FW_TYPE_RECIPE_SKILL8;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4 +
				FW_PROB_RECIPE_ESSENCE_FAINT +
				FW_PROB_RECIPE_ESSENCE_GLOWING +
				FW_PROB_RECIPE_ESSENCE_RADIANT +
				FW_PROB_RECIPE_ESSENCE_WEAK +
				FW_PROB_RECIPE_DAMAGE_RESISTANCE +
				FW_PROB_RECIPE_DAMAGE1 +
				FW_PROB_RECIPE_DAMAGE1D6 +
				FW_PROB_RECIPE_SKILL4 +
				FW_PROB_RECIPE_SKILL8 +
				FW_PROB_RECIPE_ENCHANTMENT3)) return FW_TYPE_RECIPE_ENCHANTMENT3;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4 +
				FW_PROB_RECIPE_ESSENCE_FAINT +
				FW_PROB_RECIPE_ESSENCE_GLOWING +
				FW_PROB_RECIPE_ESSENCE_RADIANT +
				FW_PROB_RECIPE_ESSENCE_WEAK +
				FW_PROB_RECIPE_DAMAGE_RESISTANCE +
				FW_PROB_RECIPE_DAMAGE1 +
				FW_PROB_RECIPE_DAMAGE1D6 +
				FW_PROB_RECIPE_SKILL4 +
				FW_PROB_RECIPE_SKILL8+
				FW_PROB_RECIPE_ENCHANTMENT3 +
				FW_PROB_RECIPE_ENCHANTMENT4)) return FW_TYPE_RECIPE_ENCHANTMENT4;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4 +
				FW_PROB_RECIPE_ESSENCE_FAINT +
				FW_PROB_RECIPE_ESSENCE_GLOWING +
				FW_PROB_RECIPE_ESSENCE_RADIANT +
				FW_PROB_RECIPE_ESSENCE_WEAK +
				FW_PROB_RECIPE_DAMAGE_RESISTANCE +
				FW_PROB_RECIPE_DAMAGE1 +
				FW_PROB_RECIPE_DAMAGE1D6 +
				FW_PROB_RECIPE_SKILL4 +
				FW_PROB_RECIPE_SKILL8 +
				FW_PROB_RECIPE_ENCHANTMENT3 +
				FW_PROB_RECIPE_ENCHANTMENT4 +
				FW_PROB_RECIPE_SAVE2)) return FW_TYPE_RECIPE_SAVE2;
	else if (nRoll <= (FW_PROB_RECIPE_NON_SPECIFIC +
				FW_PROB_RECIPE_ADAMANTINE +
				FW_PROB_RECIPE_DARKSTEEL +
				FW_PROB_RECIPE_MITHRAL +
				FW_PROB_RECIPE_COLDIRON +
				FW_PROB_RECIPE_SILVER +
				FW_PROB_RECIPE_ABILITY2 +
				FW_PROB_RECIPE_ABILITY3 +
				FW_PROB_RECIPE_ABILITY4 +
				FW_PROB_RECIPE_ESSENCE_FAINT +
				FW_PROB_RECIPE_ESSENCE_GLOWING +
				FW_PROB_RECIPE_ESSENCE_RADIANT +
				FW_PROB_RECIPE_ESSENCE_WEAK +
				FW_PROB_RECIPE_DAMAGE_RESISTANCE +
				FW_PROB_RECIPE_DAMAGE1 +
				FW_PROB_RECIPE_DAMAGE1D6 +
				FW_PROB_RECIPE_SKILL4 +
				FW_PROB_RECIPE_SKILL8 +
				FW_PROB_RECIPE_ENCHANTMENT3 +
				FW_PROB_RECIPE_ENCHANTMENT4 +
				FW_PROB_RECIPE_SAVE2 +
				FW_PROB_RECIPE_SAVE3)) return FW_TYPE_RECIPE_SAVE3;
	else return FW_TYPE_RECIPE_SAVE4;
	
}
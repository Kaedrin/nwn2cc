
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
//        FILE DESCRIPTION
//
//
// *****************************************

/*
This file contains probability tables that are used to determine
what type of loot category will appear on a monster when it spawns.
Each race has its own probability table to control how frequently
the different loot categories will drop.  There is also a default 
loot category probability table at the end of this file.  This is 
one of the most important files because with it you determine the
frequency of what type of loot category will drop.  Once you see
how I've set up the probability tables, I think you'll agree it is
also one of the easiest to edit and understand. 

I have chosen what I consider to be "reasonable" default values for
each race.  For example, I don't find it reasonable that vermin
(rats, beetles, etc) could drop Heavy Armor.  So inside the table
for vermin, I have the value of Heavy Armor set equal to zero.  
Setting the frequency to zero means that particular loot category 
will never drop for that particular race of monster. You can edit
or change any of the values in these tables simply by erasing the
value I had and putting in your own value.  You are not "stuck"
with what I chose.  Feel free to edit to your heart's content.

Race specific loot drops is a switch that you can turn on or off in
the file "fw_inc_loot_switches".  Normally this switch is turned on
(set to TRUE).  

I realize that some people may want any type of loot to drop for any
monster in the game.  You can achieve this the hard, or easy way. 
The hard way would be to leave that switch set to TRUE and then go 
into every single race table below and edit every single constant. 
The easy way is to set the switch to FALSE.  If you turn the switch 
off (by setting it to FALSE) then the race tables are ignored and the
default loot category probability table (found at the very end of 
this file) is used to determine what category of loot drops for 
EVERY monster, no matter what race they are.  I placed what I 
considered "reasonable" frequencies in the default table (for example,
I made exotic weapons rarer than martial weapons) but I made sure
NOT to set any frequency for any category equal to zero.  Every 
type of loot category is possible with the default table.  If you 
use the values I have it will make some types of loot more frequent
than other types.  You can edit the default table just like you can
the race specific tables.

new paragraph for update 2.0
In update 2.0 I made the random loot generator capable of working with
treasure chests.  For no explainable reason the function GetRacialType,
when used on a treasure chest, always returns RACIAL_TYPE_DWARF which was
causing somewhat of a problem as I coded update 2.0. So I added in a couple
of checks in the file "fw_random_loot" that will stop every treasure chest
in the game from using the dwarf probability table below.  Instead, treasure
chests (ALL of them) will use the default loot probability table. So it
is important what values you put for the default probability table (found
at the end of this file).
*/

// *****************************************
//
//				UPDATES
//
// *****************************************
// VERSION 2.0
// -11 March 2008.  I added a couple of new paragraphs in the file 
//     description above to reflect the fact that the random loot generator
//     now works with monsters and treasure chests.  I also added a 
//     paragraph of comments at the very end (in the default table) that
//     wasn't previously there.
//
// VERSION 1.2
// -28 August 2007. At the very end of this file is the default loot 
//     category constants.  I renamed them to fit the syntax used
//     by the race specific constants.  Previously they were:
//     FW_PROB_TREAS_CAT_*  Now they have the word "DEFAULT" added. 
//     I did this for consistency purposes and because I wanted to 
//     make sure the default values would be recognizable from race
//     specific ones.
//
// -28 August 2007. I used to have the race specific loot probabilities
//     ALL set equal to the default table.  This is not the case anymore
//     Many of the races still have the same distribution as the default
//     table.  This includes all the intelligent, biped, walks-upright
//     monsters. That's because they are smart enough and physically 
//     capable of carrying any type of item.  Where you'll notice the 
//     biggest difference is in the Beast, Animal, Vermin, etc. categories.
//     I couldn't stomach the idea of a beetle dropping plate armor.
//     So most of the loot categories for these races have been significantly
//     changed to represent what I think are more "reasonable" values.
//     As with anything in this file, you can change the values from 
//     the defaults I have to anything you want.  You have complete control
//     over how rare or frequent the different loot categories are.
//
// -28 August 2007.  I added a miscellaneous custom item loot category
//     to every race and to the default table.  Any custom items you have
//     will drop according to the frequency you set here for that loot
//     category.

// *****************************************
//
//
//        RACE SPECIFIC PROBABILITY TABLES
// 				FOR MORE CONTROL
//
//			  YOU CAN CHANGE THESE
//
//
// *****************************************

// ********* WHAT CATEGORY OF LOOT DROPS ***************
//
// The FW_PROB_*_TREAS_CAT_*2 constants.
//
// *  = Race of monster  
// *2 = the category of loot that will drop.
//
// This section handles the probability of a specific category of loot dropping.  
// These constants are only used when it has been determined that a monster will
// drop loot AND you the switch FW_RACE_SPECIFIC_LOOT_DROPS is set to TRUE;  
// If that switch is set to FALSE then it doesn't matter what you put in
// for the race specific values because they'll never get used and instead the 
// default values (found at the very end of this file) get used.
// 
// You control the probability of loot category that will drop for each race.  
// The higher the number you put, the more likely that category of item(s) 
// drop(s).  You'll note that these constants add up to 1000 (easy to figure 
// percentage for each category that way), but they do NOT have to add
// up to 1000.  By default I have Gold appearing as the most frequent type of loot,
// followed by consumable items, followed by rarer items, etc.  
//
// As you move down the list of constants, the frequency decreases.  This makes since
// from a traditional D&D perspective.  It is only natural that simple weapons be
// more common than martial weapons.  Similarly, martial weapons are more common than
// exotic weapons, and so forth.   
//
// One of the great things about my loot generation system is its robustness.  For 
// example, suppose you want to make heavy armors the most frequent item drop in
// your module, you can certainly do so by increasing the frequency of heavy armor 
// drops compared to the other categories of loot below.  The same holds true for any
// of the categories.  You get to decide what's rare and what isn't!!!!
//  
// The probabilities are relative to the total value of all the categories
// added together (within each race). I made my numbers add up to 1,000 to make it 
// easy to figure out the probability.  You don't have to follow my lead, but it's 
// easier if you do.  The same thing goes for armors: clothes are more common than
// plate mail, etc.  
//
// IMPORTANT: Since you are deciding what category of loot can drop for each
// race, you will most likely want to exclude certain types of loot for certain
// races.  For example, vermin (rats, beetles, etc.) probably shouldn't drop 
// heavy armor (unless your world is a little wacky and you want them to drop
// heavy armor).  If you put a zero in for any of the values that is the same 
// as excluding that type of loot from ever being possible for that particular
// race.  
//
// NOTE: Don't use negative values for the probability. You'll get unpredictable
// results.  
//
// NOTE 2: Zero is an acceptable value.  
//  
//
// ********* ABERRATION ********************
const int FW_PROB_ABERRATION_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_ABERRATION_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_ABERRATION_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_ABERRATION_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_ABERRATION_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_ABERRATION_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_ABERRATION_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_ABERRATION_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_ABERRATION_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_ABERRATION_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_ABERRATION_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_ABERRATION_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_ABERRATION_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_ABERRATION_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_ABERRATION_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_ABERRATION_TREAS_CAT_ARMOR_LIGHT 				= 25;  //  2.5% default
const int FW_PROB_ABERRATION_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_ABERRATION_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_ABERRATION_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_ABERRATION_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_ABERRATION_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_ABERRATION_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_ABERRATION_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_ABERRATION_TREAS_CAT_ARMOR_HEAVY 				= 16;  //  1.6% default
const int FW_PROB_ABERRATION_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_ABERRATION_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_ABERRATION_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_ABERRATION_TREAS_CAT_RECIPE		 			= 10;  //  2  % default
const int FW_PROB_ABERRATION_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0  % default = not possible

// ********* ANIMAL ********************
const int FW_PROB_ANIMAL_TREAS_CAT_MISC_GOLD				= 650; // 65  % default = most frequent
const int FW_PROB_ANIMAL_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0; // 15  % default
const int FW_PROB_ANIMAL_TREAS_CAT_MISC_POTION				= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_MISC_SCROLL				= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_MISC_OTHER 				= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_WEAPON_THROWN 			= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_WEAPON_AMMUNITION 		= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_MISC_BOOKS 				= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_MISC_GEMS 				= 0; // 10  % default
const int FW_PROB_ANIMAL_TREAS_CAT_MISC_TRAPS				= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_MISC_HEAL_KIT			= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_ARMOR_CLOTHING 			= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_ARMOR_BOOT 				= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_MISC_CLOTHING 			= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_MISC_JEWELRY 			= 100; // 10  % default
const int FW_PROB_ANIMAL_TREAS_CAT_ARMOR_LIGHT 				= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_ARMOR_HELMET 			= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_WEAPON_SIMPLE 			= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_MISC_GAUNTLET 			= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_ARMOR_MEDIUM 			= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_ARMOR_SHIELDS 			= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_WEAPON_MARTIAL 			= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_WEAPON_RANGED 			= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_ARMOR_HEAVY 				= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_WEAPON_EXOTIC 			= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_MISC_DAMAGE_SHIELD		= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_RECIPE					= 0;   //  0  % default
const int FW_PROB_ANIMAL_TREAS_CAT_MISC_CUSTOM_ITEM			= 0;   //  0  % default = not possible

// ********* BEAST ********************
const int FW_PROB_BEAST_TREAS_CAT_MISC_GOLD					= 650; // 65  % default = most frequent
const int FW_PROB_BEAST_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0; // 15  % default
const int FW_PROB_BEAST_TREAS_CAT_MISC_POTION				= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_MISC_SCROLL				= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_MISC_OTHER 				= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_WEAPON_THROWN 			= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_WEAPON_AMMUNITION 		= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_MISC_BOOKS 				= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_MISC_GEMS 				= 0; // 10  % default
const int FW_PROB_BEAST_TREAS_CAT_MISC_TRAPS				= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_MISC_HEAL_KIT				= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_ARMOR_CLOTHING 			= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_ARMOR_BOOT 				= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_MISC_CLOTHING 			= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_MISC_JEWELRY 				= 100; // 10  % default
const int FW_PROB_BEAST_TREAS_CAT_ARMOR_LIGHT 				= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_ARMOR_HELMET 				= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_WEAPON_SIMPLE 			= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_MISC_GAUNTLET 			= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_ARMOR_MEDIUM 				= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_ARMOR_SHIELDS 			= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_WEAPON_MARTIAL 			= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_WEAPON_RANGED 			= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_ARMOR_HEAVY 				= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_WEAPON_EXOTIC 			= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_WEAPON_MAGE_SPECIFIC 		= 0;   //  0  % default
const int FW_PROB_BEAST_TREAS_CAT_MISC_DAMAGE_SHIELD		= 0;   //  0  % default 
const int FW_PROB_BEAST_TREAS_CAT_RECIPE					= 0;   //  0  % default 
const int FW_PROB_BEAST_TREAS_CAT_MISC_CUSTOM_ITEM 			= 0;   //  0  % default = not possible

// ********* CONSTRUCT ********************
const int FW_PROB_CONSTRUCT_TREAS_CAT_MISC_GOLD					= 185; // 17.5% default = most frequent
const int FW_PROB_CONSTRUCT_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_CONSTRUCT_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_MISC_HEAL_KIT				= 30;  //  3  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_MISC_JEWELRY 				= 30;  //  3  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_ARMOR_LIGHT 				= 25;  //  2.5% default
const int FW_PROB_CONSTRUCT_TREAS_CAT_ARMOR_HELMET 				= 25;  //  2.5% default
const int FW_PROB_CONSTRUCT_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_CONSTRUCT_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_CONSTRUCT_TREAS_CAT_ARMOR_MEDIUM 				= 20;  //  2  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_ARMOR_HEAVY 				= 16;  //  1.6% default
const int FW_PROB_CONSTRUCT_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_CONSTRUCT_TREAS_CAT_WEAPON_MAGE_SPECIFIC	 	= 16;  //  1.6% default
const int FW_PROB_CONSTRUCT_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_CONSTRUCT_TREAS_CAT_RECIPE		 			= 10;  //  2  % default
const int FW_PROB_CONSTRUCT_TREAS_CAT_MISC_CUSTOM_ITEM			= 0;   //  0.0% default = not possible

// ********* DRAGON ********************
const int FW_PROB_DRAGON_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_DRAGON_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_DRAGON_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_DRAGON_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_DRAGON_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_DRAGON_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_DRAGON_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_DRAGON_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_DRAGON_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_DRAGON_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_DRAGON_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_DRAGON_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_DRAGON_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_DRAGON_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_DRAGON_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_DRAGON_TREAS_CAT_ARMOR_LIGHT 				= 25;  //  2.5% default
const int FW_PROB_DRAGON_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_DRAGON_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_DRAGON_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_DRAGON_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_DRAGON_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_DRAGON_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_DRAGON_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_DRAGON_TREAS_CAT_ARMOR_HEAVY 				= 16;  //  1.6% default
const int FW_PROB_DRAGON_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_DRAGON_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_DRAGON_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_DRAGON_TREAS_CAT_RECIPE		 			= 10;  //  2  % default
const int FW_PROB_DRAGON_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0.0% default = not possible

// ********* DWARF ********************
const int FW_PROB_DWARF_TREAS_CAT_MISC_GOLD					= 185; // 17.5% default = most frequent
const int FW_PROB_DWARF_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_DWARF_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_DWARF_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_DWARF_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_DWARF_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_DWARF_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_DWARF_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_DWARF_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_DWARF_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_DWARF_TREAS_CAT_MISC_HEAL_KIT				= 30;  //  3  % default
const int FW_PROB_DWARF_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_DWARF_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_DWARF_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_DWARF_TREAS_CAT_MISC_JEWELRY 				= 30;  //  3  % default
const int FW_PROB_DWARF_TREAS_CAT_ARMOR_LIGHT 				= 25;  //  2.5% default
const int FW_PROB_DWARF_TREAS_CAT_ARMOR_HELMET 				= 25;  //  2.5% default
const int FW_PROB_DWARF_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_DWARF_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_DWARF_TREAS_CAT_ARMOR_MEDIUM 				= 20;  //  2  % default
const int FW_PROB_DWARF_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_DWARF_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_DWARF_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_DWARF_TREAS_CAT_ARMOR_HEAVY 				= 16;  //  1.6% default
const int FW_PROB_DWARF_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_DWARF_TREAS_CAT_WEAPON_MAGE_SPECIFIC 		= 16;  //  1.6% default
const int FW_PROB_DWARF_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_DWARF_TREAS_CAT_RECIPE		 			= 10;  //  2  % default
const int FW_PROB_DWARF_TREAS_CAT_MISC_CUSTOM_ITEM 			= 0;   //  0.0% default = not possible

// ********* ELEMENTAL ********************
const int FW_PROB_ELEMENTAL_TREAS_CAT_MISC_GOLD					= 185; // 17.5% default = most frequent
const int FW_PROB_ELEMENTAL_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_ELEMENTAL_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_MISC_HEAL_KIT				= 30;  //  3  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_MISC_JEWELRY 				= 30;  //  3  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_ARMOR_LIGHT 				= 25;  //  2.5% default
const int FW_PROB_ELEMENTAL_TREAS_CAT_ARMOR_HELMET 				= 25;  //  2.5% default
const int FW_PROB_ELEMENTAL_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_ELEMENTAL_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_ELEMENTAL_TREAS_CAT_ARMOR_MEDIUM 				= 20;  //  2  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_ARMOR_HEAVY 				= 16;  //  1.6% default
const int FW_PROB_ELEMENTAL_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_ELEMENTAL_TREAS_CAT_WEAPON_MAGE_SPECIFIC 		= 16;  //  1.6% default
const int FW_PROB_ELEMENTAL_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_ELEMENTAL_TREAS_CAT_RECIPE		 			= 10;  //  2  % default
const int FW_PROB_ELEMENTAL_TREAS_CAT_MISC_CUSTOM_ITEM 			= 0;   //  0.0% default = not possible

// ********* ELF ********************
const int FW_PROB_ELF_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_ELF_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_ELF_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_ELF_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_ELF_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_ELF_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_ELF_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_ELF_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_ELF_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_ELF_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_ELF_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_ELF_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_ELF_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_ELF_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_ELF_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_ELF_TREAS_CAT_ARMOR_LIGHT 			= 25;  //  2.5% default
const int FW_PROB_ELF_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_ELF_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_ELF_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_ELF_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_ELF_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_ELF_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_ELF_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_ELF_TREAS_CAT_ARMOR_HEAVY 			= 16;  //  1.6% default
const int FW_PROB_ELF_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_ELF_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_ELF_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_ELF_TREAS_CAT_RECIPE					= 10;  //  2  % default
const int FW_PROB_ELF_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0.0% default = not possible

// ********* FEY ********************
const int FW_PROB_FEY_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_FEY_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_FEY_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_FEY_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_FEY_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_FEY_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_FEY_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_FEY_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_FEY_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_FEY_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_FEY_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_FEY_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_FEY_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_FEY_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_FEY_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_FEY_TREAS_CAT_ARMOR_LIGHT 			= 25;  //  2.5% default
const int FW_PROB_FEY_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_FEY_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_FEY_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_FEY_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_FEY_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_FEY_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_FEY_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_FEY_TREAS_CAT_ARMOR_HEAVY 			= 16;  //  1.6% default
const int FW_PROB_FEY_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_FEY_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_FEY_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_FEY_TREAS_CAT_RECIPE		 			= 10;  //  2  % default
const int FW_PROB_FEY_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0.0% default = not possible

// ********* GIANT ********************
const int FW_PROB_GIANT_TREAS_CAT_MISC_GOLD					= 185; // 17.5% default = most frequent
const int FW_PROB_GIANT_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_GIANT_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_GIANT_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_GIANT_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_GIANT_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_GIANT_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_GIANT_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_GIANT_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_GIANT_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_GIANT_TREAS_CAT_MISC_HEAL_KIT				= 30;  //  3  % default
const int FW_PROB_GIANT_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_GIANT_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_GIANT_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_GIANT_TREAS_CAT_MISC_JEWELRY 				= 30;  //  3  % default
const int FW_PROB_GIANT_TREAS_CAT_ARMOR_LIGHT 				= 25;  //  2.5% default
const int FW_PROB_GIANT_TREAS_CAT_ARMOR_HELMET 				= 25;  //  2.5% default
const int FW_PROB_GIANT_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_GIANT_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_GIANT_TREAS_CAT_ARMOR_MEDIUM 				= 20;  //  2  % default
const int FW_PROB_GIANT_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_GIANT_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_GIANT_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_GIANT_TREAS_CAT_ARMOR_HEAVY 				= 16;  //  1.6% default
const int FW_PROB_GIANT_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_GIANT_TREAS_CAT_WEAPON_MAGE_SPECIFIC 		= 16;  //  1.6% default
const int FW_PROB_GIANT_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_GIANT_TREAS_CAT_RECIPE		 			= 10;  //  2  % default
const int FW_PROB_GIANT_TREAS_CAT_MISC_CUSTOM_ITEM 			= 0;   //  0.0% default = not possible

// ********* GNOME ********************
const int FW_PROB_GNOME_TREAS_CAT_MISC_GOLD					= 185; // 17.5% default = most frequent
const int FW_PROB_GNOME_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_GNOME_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_GNOME_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_GNOME_TREAS_CAT_MISC_OTHER 				= 00;  //  4  % default
const int FW_PROB_GNOME_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_GNOME_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_GNOME_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_GNOME_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_GNOME_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_GNOME_TREAS_CAT_MISC_HEAL_KIT				= 30;  //  3  % default
const int FW_PROB_GNOME_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_GNOME_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_GNOME_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_GNOME_TREAS_CAT_MISC_JEWELRY 				= 30;  //  3  % default
const int FW_PROB_GNOME_TREAS_CAT_ARMOR_LIGHT 				= 25;  //  2.5% default
const int FW_PROB_GNOME_TREAS_CAT_ARMOR_HELMET 				= 25;  //  2.5% default
const int FW_PROB_GNOME_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_GNOME_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_GNOME_TREAS_CAT_ARMOR_MEDIUM 				= 20;  //  2  % default
const int FW_PROB_GNOME_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_GNOME_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_GNOME_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_GNOME_TREAS_CAT_ARMOR_HEAVY 				= 16;  //  1.6% default
const int FW_PROB_GNOME_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_GNOME_TREAS_CAT_WEAPON_MAGE_SPECIFIC 		= 16;  //  1.6% default
const int FW_PROB_GNOME_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_GNOME_TREAS_CAT_RECIPE		 			= 10;  //  2  % default
const int FW_PROB_GNOME_TREAS_CAT_MISC_CUSTOM_ITEM 			= 0;   //  0.0% default = not possible

// ********* HALFELF ********************
const int FW_PROB_HALFELF_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_HALFELF_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_HALFELF_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_HALFELF_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_HALFELF_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_HALFELF_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_HALFELF_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_HALFELF_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_HALFELF_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_HALFELF_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_HALFELF_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_HALFELF_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_HALFELF_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_HALFELF_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_HALFELF_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_HALFELF_TREAS_CAT_ARMOR_LIGHT 			= 25;  //  2.5% default
const int FW_PROB_HALFELF_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_HALFELF_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_HALFELF_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_HALFELF_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_HALFELF_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_HALFELF_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_HALFELF_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_HALFELF_TREAS_CAT_ARMOR_HEAVY 			= 16;  //  1.6% default
const int FW_PROB_HALFELF_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_HALFELF_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_HALFELF_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_HALFELF_TREAS_CAT_RECIPE		 			= 10;  //  2  % default
const int FW_PROB_HALFELF_TREAS_CAT_MISC_CUSTOM_ITEM		= 0;   //  0.0% default = not possible

// ********* HALFLING ********************
const int FW_PROB_HALFLING_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_HALFLING_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_HALFLING_TREAS_CAT_MISC_POTION			= 70;  //  7  % default
const int FW_PROB_HALFLING_TREAS_CAT_MISC_SCROLL			= 70;  //  7  % default
const int FW_PROB_HALFLING_TREAS_CAT_MISC_OTHER 			= 0;  //  4  % default
const int FW_PROB_HALFLING_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_HALFLING_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_HALFLING_TREAS_CAT_MISC_BOOKS 			= 30;  //  3  % default
const int FW_PROB_HALFLING_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_HALFLING_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_HALFLING_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_HALFLING_TREAS_CAT_ARMOR_CLOTHING 		= 30;  //  3  % default
const int FW_PROB_HALFLING_TREAS_CAT_ARMOR_BOOT 			= 30;  //  3  % default
const int FW_PROB_HALFLING_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_HALFLING_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_HALFLING_TREAS_CAT_ARMOR_LIGHT 			= 25;  //  2.5% default
const int FW_PROB_HALFLING_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_HALFLING_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_HALFLING_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_HALFLING_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_HALFLING_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_HALFLING_TREAS_CAT_WEAPON_MARTIAL 		= 20;  //  2  % default
const int FW_PROB_HALFLING_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_HALFLING_TREAS_CAT_ARMOR_HEAVY 			= 16;  //  1.6% default
const int FW_PROB_HALFLING_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_HALFLING_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_HALFLING_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_HALFLING_TREAS_CAT_RECIPE			 		= 10;  //  2  % default
const int FW_PROB_HALFLING_TREAS_CAT_MISC_CUSTOM_ITEM		= 0;   //  0.0% default = not possible

// ********* HALFORC ********************
const int FW_PROB_HALFORC_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_HALFORC_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_HALFORC_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_HALFORC_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_HALFORC_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_HALFORC_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_HALFORC_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_HALFORC_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_HALFORC_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_HALFORC_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_HALFORC_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_HALFORC_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_HALFORC_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_HALFORC_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_HALFORC_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_HALFORC_TREAS_CAT_ARMOR_LIGHT 			= 25;  //  2.5% default
const int FW_PROB_HALFORC_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_HALFORC_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_HALFORC_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_HALFORC_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_HALFORC_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_HALFORC_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_HALFORC_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_HALFORC_TREAS_CAT_ARMOR_HEAVY 			= 16;  //  1.6% default
const int FW_PROB_HALFORC_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_HALFORC_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_HALFORC_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_HALFORC_TREAS_CAT_RECIPE			 		= 10;  //  2  % default
const int FW_PROB_HALFORC_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0.0% default = not possible

// ********* HUMAN ********************
const int FW_PROB_HUMAN_TREAS_CAT_MISC_GOLD				    = 185; // 17.5% default = most frequent
const int FW_PROB_HUMAN_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_HUMAN_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_HUMAN_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_HUMAN_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_HUMAN_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_HUMAN_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_HUMAN_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_HUMAN_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_HUMAN_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_HUMAN_TREAS_CAT_MISC_HEAL_KIT			    = 30;  //  3  % default
const int FW_PROB_HUMAN_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_HUMAN_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_HUMAN_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_HUMAN_TREAS_CAT_MISC_JEWELRY 				= 30;  //  3  % default
const int FW_PROB_HUMAN_TREAS_CAT_ARMOR_LIGHT 				= 25;  //  2.5% default
const int FW_PROB_HUMAN_TREAS_CAT_ARMOR_HELMET 				= 25;  //  2.5% default
const int FW_PROB_HUMAN_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_HUMAN_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_HUMAN_TREAS_CAT_ARMOR_MEDIUM 				= 20;  //  2  % default
const int FW_PROB_HUMAN_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_HUMAN_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_HUMAN_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_HUMAN_TREAS_CAT_ARMOR_HEAVY 				= 16;  //  1.6% default
const int FW_PROB_HUMAN_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_HUMAN_TREAS_CAT_WEAPON_MAGE_SPECIFIC 		= 16;  //  1.6% default
const int FW_PROB_HUMAN_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_HUMAN_TREAS_CAT_RECIPE			 		= 10;  //  2  % default
const int FW_PROB_HUMAN_TREAS_CAT_MISC_CUSTOM_ITEM 			= 0;   //  0.0% default = not possible

// ********* HUMANOID GOBLINOID ********************
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_ARMOR_LIGHT 		    	= 25;  //  2.5% default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_ARMOR_HEAVY 			    = 16;  //  1.6% default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_RECIPE			 		= 10;  //  2  % default
const int FW_PROB_HUMANOID_GOBLINOID_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0.0% default = not possible

// ********* HUMANOID MONSTROUS ********************
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_ARMOR_LIGHT 			    = 25;  //  2.5% default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_ARMOR_HEAVY 			    = 16;  //  1.6% default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_RECIPE			 		= 10;  //  2  % default
const int FW_PROB_HUMANOID_MONSTROUS_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0.0% default = not possible

// ********* HUMANOID ORC ********************
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_MISC_POTION			= 70;  //  7  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_MISC_SCROLL			= 70;  //  7  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_MISC_OTHER 			= 0;  //  4  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_MISC_BOOKS 			= 30;  //  3  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_ARMOR_CLOTHING 		= 30;  //  3  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_ARMOR_BOOT 			= 30;  //  3  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_ARMOR_LIGHT 			= 25;  //  2.5% default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_WEAPON_MARTIAL 		= 20;  //  2  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_ARMOR_HEAVY 			= 16;  //  1.6% default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_RECIPE			 		= 10;  //  2  % default
const int FW_PROB_HUMANOID_ORC_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0.0% default = not possible

// ********* HUMANOID REPTILIAN ********************
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_ARMOR_LIGHT 			    = 25;  //  2.5% default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_ARMOR_HEAVY 			    = 16;  //  1.6% default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_RECIPE			 		= 10;  //  2  % default
const int FW_PROB_HUMANOID_REPTILIAN_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0.0% default = not possible

// ********* INCORPOREAL ********************
const int FW_PROB_INCORPOREAL_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_INCORPOREAL_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_INCORPOREAL_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_ARMOR_LIGHT 			= 25;  //  2.5% default
const int FW_PROB_INCORPOREAL_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_INCORPOREAL_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_INCORPOREAL_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_INCORPOREAL_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_ARMOR_HEAVY 			= 16;  //  1.6% default
const int FW_PROB_INCORPOREAL_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_INCORPOREAL_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_INCORPOREAL_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_INCORPOREAL_TREAS_CAT_RECIPE			 		= 10;  //  2  % default
const int FW_PROB_INCORPOREAL_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0.0% default = not possible

// ********* MAGICAL BEAST ********************
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_MISC_GOLD				    = 650; // 65  % default = most frequent
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0; // 15  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_MISC_POTION				= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_MISC_SCROLL				= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_MISC_OTHER 				= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_WEAPON_THROWN 			= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_WEAPON_AMMUNITION 		= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_MISC_BOOKS 				= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_MISC_GEMS 				= 0; // 10  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_MISC_TRAPS				= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_MISC_HEAL_KIT			    = 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_ARMOR_CLOTHING 			= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_ARMOR_BOOT 				= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_MISC_CLOTHING 			= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_MISC_JEWELRY 			    = 100; // 10  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_ARMOR_LIGHT 			    = 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_ARMOR_HELMET 			    = 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_WEAPON_SIMPLE 			= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_MISC_GAUNTLET 			= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_ARMOR_MEDIUM 			    = 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_ARMOR_SHIELDS 			= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_WEAPON_MARTIAL 			= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_WEAPON_RANGED 			= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_ARMOR_HEAVY 			    = 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_WEAPON_EXOTIC 			= 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	    = 0;   //  0  % default
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_MISC_DAMAGE_SHIELD		= 0;   //  0  % default 
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_RECIPE				= 0;   //  0  % default 
const int FW_PROB_MAGICAL_BEAST_TREAS_CAT_MISC_CUSTOM_ITEM 			= 0;   //  0  % default = not possible

// ********* OOZE ********************
const int FW_PROB_OOZE_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_OOZE_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_OOZE_TREAS_CAT_MISC_POTION			= 70;  //  7  % default
const int FW_PROB_OOZE_TREAS_CAT_MISC_SCROLL			= 70;  //  7  % default
const int FW_PROB_OOZE_TREAS_CAT_MISC_OTHER 			= 0;  //  4  % default
const int FW_PROB_OOZE_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_OOZE_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_OOZE_TREAS_CAT_MISC_BOOKS 			= 30;  //  3  % default
const int FW_PROB_OOZE_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_OOZE_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_OOZE_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_OOZE_TREAS_CAT_ARMOR_CLOTHING 		= 30;  //  3  % default
const int FW_PROB_OOZE_TREAS_CAT_ARMOR_BOOT 			= 30;  //  3  % default
const int FW_PROB_OOZE_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_OOZE_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_OOZE_TREAS_CAT_ARMOR_LIGHT 			= 25;  //  2.5% default
const int FW_PROB_OOZE_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_OOZE_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_OOZE_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_OOZE_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_OOZE_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_OOZE_TREAS_CAT_WEAPON_MARTIAL 		= 20;  //  2  % default
const int FW_PROB_OOZE_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_OOZE_TREAS_CAT_ARMOR_HEAVY 			= 16;  //  1.6% default
const int FW_PROB_OOZE_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_OOZE_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_OOZE_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_OOZE_TREAS_CAT_RECIPE		 			= 10;  //  2  % default
const int FW_PROB_OOZE_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0.0% default = not possible

// ********* OUTSIDER ********************
const int FW_PROB_OUTSIDER_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_OUTSIDER_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_OUTSIDER_TREAS_CAT_MISC_POTION			= 70;  //  7  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_MISC_SCROLL			= 70;  //  7  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_MISC_OTHER 			= 0;  //  4  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_MISC_BOOKS 			= 30;  //  3  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_ARMOR_CLOTHING 		= 30;  //  3  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_ARMOR_BOOT 			= 30;  //  3  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_ARMOR_LIGHT 			= 25;  //  2.5% default
const int FW_PROB_OUTSIDER_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_OUTSIDER_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_OUTSIDER_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_OUTSIDER_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_WEAPON_MARTIAL 		= 20;  //  2  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_ARMOR_HEAVY 			= 16;  //  1.6% default
const int FW_PROB_OUTSIDER_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_OUTSIDER_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_OUTSIDER_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_OUTSIDER_TREAS_CAT_RECIPE			 		= 10;  //  2  % default
const int FW_PROB_OUTSIDER_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0.0% default = not possible

// ********* SHAPECHANGER ********************
const int FW_PROB_SHAPECHANGER_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_SHAPECHANGER_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_MISC_POTION			= 70;  //  7  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_MISC_SCROLL			= 70;  //  7  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_MISC_OTHER 			= 0;  //  4  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_MISC_BOOKS 			= 30;  //  3  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_ARMOR_CLOTHING 		= 30;  //  3  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_ARMOR_BOOT 			= 30;  //  3  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_ARMOR_LIGHT 			= 25;  //  2.5% default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_WEAPON_MARTIAL 		= 20;  //  2  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_ARMOR_HEAVY 			= 16;  //  1.6% default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_SHAPECHANGER_TREAS_CAT_RECIPE		 			= 10;  //  2  % default
const int FW_PROB_SHAPECHANGER_TREAS_CAT_MISC_CUSTOM_ITEM		= 0;   //  0.0% default = not possible

// ********* UNDEAD ********************
const int FW_PROB_UNDEAD_TREAS_CAT_MISC_GOLD				= 185; // 17.5% default = most frequent
const int FW_PROB_UNDEAD_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_UNDEAD_TREAS_CAT_MISC_POTION				= 70;  //  7  % default
const int FW_PROB_UNDEAD_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_UNDEAD_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_UNDEAD_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_UNDEAD_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_UNDEAD_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_UNDEAD_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_UNDEAD_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_UNDEAD_TREAS_CAT_MISC_HEAL_KIT			= 30;  //  3  % default
const int FW_PROB_UNDEAD_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_UNDEAD_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_UNDEAD_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_UNDEAD_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_UNDEAD_TREAS_CAT_ARMOR_LIGHT 			    = 25;  //  2.5% default
const int FW_PROB_UNDEAD_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_UNDEAD_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_UNDEAD_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_UNDEAD_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_UNDEAD_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_UNDEAD_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_UNDEAD_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_UNDEAD_TREAS_CAT_ARMOR_HEAVY 		    	= 16;  //  1.6% default
const int FW_PROB_UNDEAD_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_UNDEAD_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_UNDEAD_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_UNDEAD_TREAS_CAT_RECIPE		 			= 10;  //  2  % default
const int FW_PROB_UNDEAD_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0.0% default = not possible

// ********* VERMIN ********************
const int FW_PROB_VERMIN_TREAS_CAT_MISC_GOLD				= 650; // 65  % default = most frequent
const int FW_PROB_VERMIN_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0; // 15  % default
const int FW_PROB_VERMIN_TREAS_CAT_MISC_POTION				= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_MISC_SCROLL				= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_MISC_OTHER 				= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_WEAPON_THROWN 			= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_WEAPON_AMMUNITION 		= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_MISC_BOOKS 				= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_MISC_GEMS 				= 0; // 10  % default
const int FW_PROB_VERMIN_TREAS_CAT_MISC_TRAPS				= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_MISC_HEAL_KIT			= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_ARMOR_CLOTHING 			= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_ARMOR_BOOT 				= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_MISC_CLOTHING 			= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_MISC_JEWELRY 			= 100; // 10  % default
const int FW_PROB_VERMIN_TREAS_CAT_ARMOR_LIGHT 			    = 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_ARMOR_HELMET 			= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_WEAPON_SIMPLE 			= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_MISC_GAUNTLET 			= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_ARMOR_MEDIUM 			= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_ARMOR_SHIELDS 			= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_WEAPON_MARTIAL 			= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_WEAPON_RANGED 			= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_ARMOR_HEAVY 			    = 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_WEAPON_EXOTIC 			= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_MISC_DAMAGE_SHIELD		= 0;   //  0  % default 
const int FW_PROB_VERMIN_TREAS_CAT_RECIPE				 	= 0;   //  0  % default
const int FW_PROB_VERMIN_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0  % default = not possible

// ********* WHAT DEFAULT CATEGORY OF LOOT DROPS ***************
//
// The FW_PROB_DEFAULT_TREAS_CAT_* constants.
//
// This is the default probability table for determining the category
// of loot that will drop when a monster spawns. I am guessing that most
// people will want to control what type of loot category can drop for
// each race.  All the other probabilities above in this file handle race
// specific loot category drops.  
//
// If you don't care about race specific loot drops, then the random 
// loot generator still needs some type of default to rely on so that
// it can generate loot.  That's what this table does. These values
// are only used if you set: "FW_RACE_SPECIFIC_LOOT_DROPS = FALSE;"
// in the file "fw_inc_loot_switches".  If you set that switch to 
// FALSE, then all of the other constants in this file up above don't
// get used and you won't have race specific loot drops.  You can ignore
// this table if you have that switch set to TRUE.
//
// However, treasure chests work differently than spawning monsters.  When
// a PC opens a treasure chest, the default table below is always used to
// determine what random loot (if any) will drop. 
//
// NOTE: If you put a zero in for any of the values that is the same
// as excluding it from ever being possible.  
//
// NOTE 2: Do NOT use negative values for the probability. 
// You'll get unpredictable results.  
//
const int FW_PROB_DEFAULT_TREAS_CAT_MISC_GOLD				= 260; // 17.5% default = most frequent
const int FW_PROB_DEFAULT_TREAS_CAT_MISC_CRAFTING_MATERIAL	= 0;  //  9.5% default
const int FW_PROB_DEFAULT_TREAS_CAT_MISC_POTION				= 110;  //  7  % default
const int FW_PROB_DEFAULT_TREAS_CAT_MISC_SCROLL				= 70;  //  7  % default
const int FW_PROB_DEFAULT_TREAS_CAT_MISC_OTHER 				= 0;  //  4  % default
const int FW_PROB_DEFAULT_TREAS_CAT_WEAPON_THROWN 			= 40;  //  4  % default
const int FW_PROB_DEFAULT_TREAS_CAT_WEAPON_AMMUNITION 		= 40;  //  4  % default
const int FW_PROB_DEFAULT_TREAS_CAT_MISC_BOOKS 				= 30;  //  3  % default
const int FW_PROB_DEFAULT_TREAS_CAT_MISC_GEMS 				= 0;  //  3  % default
const int FW_PROB_DEFAULT_TREAS_CAT_MISC_TRAPS				= 30;  //  3  % default
const int FW_PROB_DEFAULT_TREAS_CAT_MISC_HEAL_KIT			= 60;  //  3  % default
const int FW_PROB_DEFAULT_TREAS_CAT_ARMOR_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_DEFAULT_TREAS_CAT_ARMOR_BOOT 				= 30;  //  3  % default
const int FW_PROB_DEFAULT_TREAS_CAT_MISC_CLOTHING 			= 30;  //  3  % default
const int FW_PROB_DEFAULT_TREAS_CAT_MISC_JEWELRY 			= 30;  //  3  % default
const int FW_PROB_DEFAULT_TREAS_CAT_ARMOR_LIGHT 			= 25;  //  2.5% default
const int FW_PROB_DEFAULT_TREAS_CAT_ARMOR_HELMET 			= 25;  //  2.5% default
const int FW_PROB_DEFAULT_TREAS_CAT_WEAPON_SIMPLE 			= 25;  //  2.5% default
const int FW_PROB_DEFAULT_TREAS_CAT_MISC_GAUNTLET 			= 25;  //  2.5% default
const int FW_PROB_DEFAULT_TREAS_CAT_ARMOR_MEDIUM 			= 20;  //  2  % default
const int FW_PROB_DEFAULT_TREAS_CAT_ARMOR_SHIELDS 			= 20;  //  2  % default
const int FW_PROB_DEFAULT_TREAS_CAT_WEAPON_MARTIAL 			= 20;  //  2  % default
const int FW_PROB_DEFAULT_TREAS_CAT_WEAPON_RANGED 			= 20;  //  2  % default
const int FW_PROB_DEFAULT_TREAS_CAT_ARMOR_HEAVY 			= 16;  //  1.6% default
const int FW_PROB_DEFAULT_TREAS_CAT_WEAPON_EXOTIC 			= 16;  //  1.6% default
const int FW_PROB_DEFAULT_TREAS_CAT_WEAPON_MAGE_SPECIFIC 	= 16;  //  1.6% default
const int FW_PROB_DEFAULT_TREAS_CAT_MISC_DAMAGE_SHIELD		= 2;   //  0.2% default = the rarest of treasure
const int FW_PROB_DEFAULT_TREAS_CAT_RECIPE 					= 10;  //  1.0% default
const int FW_PROB_DEFAULT_TREAS_CAT_MISC_CUSTOM_ITEM 		= 0;   //  0.0% default = not possible
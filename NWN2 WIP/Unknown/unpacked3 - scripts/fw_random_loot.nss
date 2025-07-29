/////////////////////////////////////////////
// *
// * Created by Christopher Aulepp
// * Date: 12 May 2008
// * contact information: cdaulepp@juno.com
// * VERSION 2.0
// * copyright 2008 Christopher Aulepp.  All rights reserved.
// *
//////////////////////////////////////////////

/////////////////////////////////////////////
// *
// *  WARNING: ONLY AN EXPERIENCED SCRIPTER
// *  	       SHOULD CHANGE ANYTHING IN THIS 
// *		   FILE
// *
//////////////////////////////////////////////

// *****************************************
//
//              FILE DESCRIPTION
//
// *****************************************
/*
This is my random loot generation system. Anyone can change the switches
and probability tables in the following files: 
"fw_inc_loot_switches"  
"fw_inc_probability_tables_misc"
"fw_inc_probability_tables_races"
"fw_inc_cr_scaling_formulas" 
"fw_inc_cr_scaling_constants"
"fw_inc_misc"
"fw_inc_item_value_restrictions"

ONLY an EXPERIENCED scripter should change anything else. 
If you mess with the other things and break it, you've been warned.
*/

// *****************************************
//
//              UPDATES
//
// *****************************************
//
// VERSION 2.0
// -12 March 2008. I updated the function "FW_CreateLootOnObject" to check if the spawning
//     loot is to appear in a treasure chest or if it is spawning on a monster.  I also 
//     updated the main() program at the very end of this file to take into account whether
//     or not the firing event was a monster spawn or a treasure chest.
//
// - 9 April 2008. I noticed a logic error in the end of the function "FW_CreateLootOnObject."
//     I added a "DestroyObject" line of code to the else clause where I do gold piece 
//     value checks.  This is so that after rerolling possibly 10 times the original intance
//     of an item is destroyed before switching to the default of gold.  Previously, I was
//     destroying the rerolls, but I forgot about the original that was too expensive.  Now
//     this is obviously fixed.  
//
// -20 April 2008. I updated the function "FW_CreateLootOnObject" to account for the new function
//     that gets a random magic rod.  
//
// -20 April 2008. I made several updates to the main program at the very end of this file.
//     In the main program I added some code that will by default loop through 10 times to try
//     to pick a new item property in the event that the original item property rolled was 
//     disallowed or might make the item too expensive.  There is also a constant you can
//     change to set the number of rerolls.  It is called "FW_NUMBER_OF_REROLLS" and is found
//     in the file "fw_inc_misc".  By default the loot generator tries to reroll at least 10 times
//     before giving up.  Although this will hardly ever happen.  Usually the loot generator will
//     pick an acceptable item within the first couple of tries.
//
// -20 April 2008.  I added some code into the main program at the very end of this file that
//     makes a call to get a random name on an object.  Not all objects need names (I filter out
//     the ones that don't).  I also added a switch to turn on/off random names for your items.
//     The new switch is in the file "fw_inc_loot_switches".
//
// VERSION 1.2
//
// -28 August 2007. I had made the classical assignment vs. boolean check
//     error on a couple of the items inside the function FW_Create_Loot_On_Object.
//     I fixed these.
//
// - 5 Sept. 2007.  I added some Item Level Restriction code to the function
//     FW_CreateLootOnObject.  I also added Item Level Restriction code
//     to the main function at the very bottom of this file.  Item Level
//     Restrictions can be enabled/disabled in the file "fw_inc_loot_switches"
//     
// - 9 Sept. 2007.  I changed the function: FW_WhatItemPropertyToAdd.
//     I had not included (until now) a probability table that lets you set
//     probabilities for individual item properties.  This meant that
//     some properties were appearing on items more frequently that I 
//     liked.  For example, the Limit Use by Alignment, Race, SAlign,
//     or Class item properties represented 4 entries in every single
//     category of loot.  While something like Item Property Light only
//     had one entry.  This meant you were 4 times more likely to get
//     some type of limit use on your item than a light bonus.  I decided
//     to combine similar properties and this is what you see in the edit
//     to the function FW_WhatItemPropertyToAdd.  I also didn't like the
//     frequency with which negative item properties were showing up, so
//     I combined them into single entries in this function.  This makes
//     them still possible, but lowers the likelihood of getting a negative
//     item property.  
//
// VERSION 1.1
//
// -27 July 2007. I updated the function FW_WhatItemPropertyToAdd to take
//     into consideration monster CR.  This allows for CR scaling now for
//     almost all of the item properties.
//
// -29 July 2007. I updated the function FW_CreateLootOnObject to make calls
//     to handle different types of metals and wood.  For example, the exotic
//     weapons now make a call to FW_Get_Random_Weapon_Exotic and this function
//     chooses a random exotic weapon and also chooses an appropriate metal
//     type based on the probability tables.  The same thing was done with 
//     simple, ranged, and martial weapons as well as metal armors.
//
// -31 July 2007. I added race specific loot drop checks.  I updated the 
//     function "FW_CreateLootOnObject" to do a race loot switch check.
//
// -20 Aug. 2007. I had an assignment error in the function FW_CreateLootOnObject.
//     I fixed it.
//
// *****************************************
//
//              INCLUDED FILES
//
// *****************************************
// I need the item property functions.

#include "fw_random_loot_core"
#include "fw_inc_struct"


// *****************************************
//
//
//              MAIN
//
// For convenience I show here the basic logic flow of how
// this main () works.
//
/*
	1. Monster spawns or placeable item is opened (e.g. treasure
	   chest, armoire, book shelf, etc.)

	2. Does the monster/placeable drop loot? 
		a. If yes, go to step 3.
		b. If no, exit.

	3. Determine how many items drop.

	4. Pick an item to put in monster/placeable's inventory.
		a. If the item picked can have item properties added
		   to it (i.e. weapon, armor, etc), go to step 5. 
		b. If the item picked can NOT have item properties added
		   to it (i.e. gold, books, traps, etc) go to step 9.

	5. Determine how many item PROPERTIES the item will have.
		a. If zero properties (i.e. generic weapon, armor, etc), 
		   go to step 9.
		b. If one or more properties (magical loot) go to step 6.

	6. Choose an acceptable item property for the type of item chosen.
		a. If Overall item Value Restrictions are turned OFF,
		   go to step 7.
		b. If Overall Item Value Restrictions are turned ON
		   and the acceptable item property will NOT put the item's
		   value over the limit go to step 7.
		c. If Overall Item Value Restrictions are turned ON
		   and the acceptable item property will put the item's
		   value over the limit go to step 9.
		   
	7. Add the item property to the item.

	8. Repeat steps 6-7 for all additional item properties (if any).
	
	9. Make the item droppable.

	10. Make the item pick-pocketable.
	
	11. Make the item unidentified.

	12. Determine if the item is cursed.
		a. If cursed, set it to cursed.
		b. If NOT cursed, leave the item alone.

	13. Repeat steps 4-12 for all additional items (if any).

	14. Done. Monster spawns into the game with random loot in its 
	    inventory.  Or if placeable item called this script, then 
		random loot appears in the inventory of the placeable item.
*/	
//
// *****************************************
void main()
{
   
   object oTarget = OBJECT_SELF;
   // CR is used for sliding scale and probabilities.
   int nCR;
   
   // Added in 2.0 -- Treasure Chests.  The next couple of lines simply check
   // if the object that called this script was a spawning monster or a 
   // treasure chest.  If it is a treasure chest, we use the CR marked on
   // the chest for determining the power of the loot.  If the object that 
   // called this script is not a treasure chest (it has to be a monster then)
   // and we would use the monster's CR instead.  Actually this applies
   // to not only treasure chests, but any placeable that has an inventory.
   // Thus the random loot generator can be used with things like armoirs,
   // bookshelves, treasure chests, weapons racks, etc. It also works 
   // obviously with monsters.	
   int nTreasureChestCheck = GetLocalInt(oTarget, "FW_TREASURE_CHEST");
   if (nTreasureChestCheck)
   {
   	  // use the CR set by the module builder.
      nCR = GetLocalInt(oTarget, "CR");	  
   }
   else 
   {
      // It is a monster spawning. Use the monster's CR.
   	  nCR = FloatToInt(GetChallengeRating (oTarget));   	  
   }
	  	  
   struct MyStruct strStruct = FW_CompleteRandomLootGeneration(oTarget, strStruct, nCR);
	  }
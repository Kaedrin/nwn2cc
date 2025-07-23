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
#include "x2_inc_itemprop"

// I need the FW_Get_Random_* functions.
#include "fw_inc_get_random"
// I need the FW_Choose_IP_* functions. 
#include "fw_inc_choose_ip"
// I need the racial loot implementations.
#include "fw_inc_choose_loot_category"

// I need all the constants and switches.
#include "fw_inc_loot_switches"

// I need the probability tables.
#include "fw_inc_probability_tables_misc"
// I need the racial loot probability tables.
#include "fw_inc_probability_tables_races"

// I need the formula based CR scaling.
#include "fw_inc_cr_scaling_formulas"
// I need the constant based CR scaling
#include "fw_inc_cr_scaling_constants"

// I need the MyStruct data types and global variables
#include "fw_inc_misc"
// I need the Item Value Restriction constants and functions
#include "fw_inc_item_value_restrictions"

// I need the name functions to set a name on the item.
#include "fw_inc_loot_names"

// *****************************************
//
//
//              FUNCTION DECLARATIONS
//
//				DON'T CHANGE
//
//
// *****************************************

//////////////////////////////////////////
// * This function returns the generic loot struct we're going to add
// * item property(s) to.  By default any type of loot can drop.  This 
// * function (as of version 1.1) now checks for race specific loot drops
// * when the switch for race specific loot drops is set.
//
struct MyStruct FW_CreateLootOnObject (object oTarget, struct MyStruct strStruct, int nCR = 0, int nNumReRolls = FW_NUMBER_OF_REROLLS);

//////////////////////////////////////////
// * Function that determines what itemproperty to add to the dropping loot.
// * By default any type of item property can be chosen.  You can now set
// * upper and lower limits for each CR by editing the constants in the 
// * file "fw_inc_loot_cr_scaling"
//
itemproperty FW_WhatItemPropertyToAdd (struct MyStruct strStruct, int nCR = 0);



struct MyStruct FW_CompleteRandomLootGeneration(object oTarget, struct MyStruct strStruct, int nCR = 0);

// *****************************************
//
//
//              IMPLEMENTATION
//
//			ONLY AN EXPERIENCED SCRIPTER
//			SHOULD CHANGE THE IMPLEMENTATION
//
// *****************************************

//////////////////////////////////////////
// * This function returns the generic loot struct we're going to add
// * item property(s) to.  By default any type of loot can drop.  This 
// * function (as of version 1.1) now checks for race specific loot drops
// * when the switch for race specific loot drops is set.
//
struct MyStruct FW_CreateLootOnObject(object oTarget, struct MyStruct strStruct, int nCR = 0, int nNumReRolls = FW_NUMBER_OF_REROLLS)
{
    int nRoll;
    int nMaterial;
    // Check to see if we're doing race specific loot drops.
    if (FW_RACE_SPECIFIC_LOOT_DROPS == TRUE)
    {
		strStruct.nLootType = FW_Get_Racial_Loot_Category (oTarget);	
    } 
	// Otherwise, we don't care what race the monster is, just drop
	// anything! That's what the else does.
	else
	{
		strStruct.nLootType = FW_Get_Default_Loot_Category ();	
	}
	
	// For some reason the game engine thinks that treasure chests are
	// of racial type dwarf.  The next couple of lines check to see  
	// what caused this script to fire.  If it was a treasure chest, 
	// I'm guessing you don't always want to use the dwarven loot category
	// so I'm changing it to the default loot category.   This means that
	// all treasure chests will use the default loot category probability
	// tables.  You can adjust the default probabilities in the file
	// "fw_inc_probability_tables_races"
	int nTreasureChestCheck = GetLocalInt(oTarget, "FW_TREASURE_CHEST");
    if (nTreasureChestCheck)
	{
		strStruct.nLootType = FW_Get_Default_Loot_Category ();		
	}
	
	
//    SendMessageToPC(oTarget, "Creating Item Type: " + IntToString(strStruct.nLootType));   
      switch (strStruct.nLootType)
      {
            case FW_ARMOR_BOOT:    { strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_boot", oTarget); }
               break;
            case FW_ARMOR_CLOTHING:{ strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_clothes", oTarget); }
               break;
            case FW_ARMOR_HEAVY:
               nRoll = Random (3);
               // 0 = Banded, 1 = HalfPlate, 2 = FullPlate
               if      (nRoll == 0) { strStruct.oItem = FW_Get_Random_Metal_Armor (oTarget, FW_ARMOR_HEAVY_BANDED);     }									
               else if (nRoll == 1) { strStruct.oItem = FW_Get_Random_Metal_Armor (oTarget, FW_ARMOR_HEAVY_HALFPLATE); }
               else /* (nRoll == 2)*/{ strStruct.oItem = FW_Get_Random_Metal_Armor (oTarget,FW_ARMOR_HEAVY_FULLPLATE); }
               break;
            case FW_ARMOR_HELMET:  { strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_helmet", oTarget);		 }
               break;
            case FW_ARMOR_LIGHT:
               nRoll = Random (4);
               // 0 = Padded, 1 = Leather, 2 = Studded Leather, 3 = Chain Shirt
               if      (nRoll == 0) { strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_padded", oTarget);		}
               else if (nRoll == 1) { strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_leather", oTarget);      }
               else if (nRoll == 2) { strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_studded", oTarget);        }
               else /* (nRoll == 3)*/{ strStruct.oItem = FW_Get_Random_Metal_Armor (oTarget, FW_ARMOR_LIGHT_CHAINSHIRT); }
               break;
            case FW_ARMOR_MEDIUM:
               nRoll = Random (4);
               // 0 = Hide, 1 = ScaleMail, 2 = ChainMail, 3 = Breastplate
               if      (nRoll == 0) { strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_hide", oTarget);          }
               else if (nRoll == 1) { strStruct.oItem = FW_Get_Random_Metal_Armor (oTarget, FW_ARMOR_MEDIUM_SCALEMAIL);  }
               else if (nRoll == 2) { strStruct.oItem = FW_Get_Random_Metal_Armor (oTarget, FW_ARMOR_MEDIUM_CHAINMAIL);  }
               else /* (nRoll == 3)*/{ strStruct.oItem = FW_Get_Random_Metal_Armor (oTarget, FW_ARMOR_MEDIUM_BREASTPLATE);}
               break;
            case FW_ARMOR_SHIELDS:
               nRoll = Random (3);
               // 0 = Light, 1 = Heavy, 2 = Tower
               if      (nRoll == 0) { strStruct.oItem = CreateItemOnObject ("fw_itm_armor_shield_generic_ligh", oTarget);    }
               else if (nRoll == 1) { strStruct.oItem = CreateItemOnObject ("fw_itm_armor_shield_generic_heav", oTarget);    }
               else                 { strStruct.oItem = CreateItemOnObject ("fw_itm_armor_shield_generic_towe", oTarget);    }
               break;
            case FW_WEAPON_AMMUNITION:
                nRoll = Random (3);
                // 0 = Arrow, 1 = Bolt, 2 = Bullet
                if      (nRoll == 0) { strStruct.oItem = CreateItemOnObject ("nw_wamar001", oTarget, 99);     }
                else if (nRoll == 1) { strStruct.oItem = CreateItemOnObject ("nw_wambo001", oTarget, 99);     }
                else /* (nRoll == 2)*/{ strStruct.oItem = CreateItemOnObject ("nw_wambu001", oTarget, 99);     }
                break;
            case FW_WEAPON_SIMPLE:  { strStruct.oItem = FW_Get_Random_Weapon_Simple (oTarget);  }
                break;
            case FW_WEAPON_MARTIAL: { strStruct.oItem = FW_Get_Random_Weapon_Martial (oTarget); }
                break;
            case FW_WEAPON_EXOTIC:  { strStruct.oItem = FW_Get_Random_Weapon_Exotic (oTarget);  }
                break;
            case FW_WEAPON_MAGE_SPECIFIC:				
                nRoll = Random (3);
                // 0 = Rod, 1 = Staff, 2 = Wand
                if      (nRoll == 0) { strStruct.oItem = CreateItemOnObject ("fw_itm_weap_generic_rod", oTarget);
									    FW_Get_Random_Rod (strStruct);								}
                else if (nRoll == 1) { strStruct.oItem = CreateItemOnObject ("nw_wdbqs001", oTarget); }//("fw_itm_weap_generic_staff", oTarget); }
                else /* (nRoll == 2)*/{ //strStruct.oItem = CreateItemOnObject ("fw_itm_weap_generic_wand", oTarget);
									    //FW_Get_Random_Wand (strStruct);								
										}
                break;
            case FW_WEAPON_RANGED:  { strStruct.oItem = FW_Get_Random_Weapon_Ranged (oTarget);  }
                break;
            case FW_WEAPON_THROWN:
                nRoll = Random (3);
                // 0 = Throwing Axe, 1 = Dart, 2 = Shuriken
                if      (nRoll == 0) { strStruct.oItem = CreateItemOnObject ("nw_wthax001", oTarget, 50); }
                else if (nRoll == 1) { strStruct.oItem = CreateItemOnObject ("nw_wthdt001", oTarget, 50); }
                else /* (nRoll == 2)*/{ strStruct.oItem = CreateItemOnObject ("nw_wthsh001", oTarget, 50); }
			    break;
            case FW_MISC_CLOTHING:
               nRoll = Random (4);
               // 0 = Belt, 1 = Boot, 2 = Bracer, 3 = Cloak
               if      (nRoll == 0) { strStruct.oItem = CreateItemOnObject ("fw_itm_misc_generic_belt", oTarget);   }
               else if (nRoll == 1) { strStruct.oItem = CreateItemOnObject ("fw_itm_misc_generic_boot", oTarget);   }
               else if (nRoll == 2) { strStruct.oItem = CreateItemOnObject ("fw_itm_misc_generic_bracer", oTarget); }
               else /* (nRoll ==3 )*/{ strStruct.oItem = CreateItemOnObject ("fw_itm_misc_generic_cloak", oTarget);  }
               break;
            case FW_MISC_JEWELRY:
               nRoll = Random (2);
               // 0 = Amulet, 1 = Ring
               if      (nRoll == 0)  { strStruct.oItem = CreateItemOnObject ("fw_itm_misc_generic_amulet", oTarget);   }
               else /* (nRoll == 1)*/{ strStruct.oItem = CreateItemOnObject ("fw_itm_misc_generic_ring", oTarget);    }
               break;
            case FW_MISC_GAUNTLET: { strStruct.oItem = CreateItemOnObject ("fw_itm_misc_generic_gauntlet", oTarget); }
               break;
			case FW_MISC_POTION:   { strStruct.oItem = FW_Get_Random_Potion (oTarget, strStruct); }
               break;       
		    case FW_MISC_TRAPS:    { strStruct.oItem = FW_Get_Random_Trap (oTarget,strStruct, nCR);   }
			   break;  
			case FW_MISC_BOOKS:    { strStruct.oItem = FW_Get_Random_Book (oTarget, strStruct);   }
               break; 
			case FW_MISC_GOLD:     { strStruct.oItem = FW_Get_Random_Gold (oTarget, nCR);            }
               break;               
            case FW_MISC_GEMS:     { strStruct.oItem = FW_Get_Random_Gem (oTarget, strStruct);    }
               break;
            case FW_MISC_HEAL_KIT: { strStruct.oItem = FW_Get_Random_Heal_Kit (oTarget, strStruct); }
                break;
			case FW_MISC_SCROLL:   { strStruct.oItem = FW_Get_Random_Scroll (oTarget, strStruct);  }
                break; 
			case FW_MISC_CRAFTING_MATERIAL: { strStruct.oItem = FW_Get_Random_Crafting_Material (oTarget, strStruct);   }
                break;
            case FW_MISC_OTHER:    { strStruct.oItem = FW_Get_Random_Misc_Other (oTarget, strStruct);   }
                break; 
			case FW_MISC_DAMAGE_SHIELD: { strStruct.oItem = FW_Get_Random_Misc_Damage_Shield_Item (oTarget, strStruct);      }
				break;                      
		    case FW_MISC_CUSTOM_ITEM:  { strStruct.oItem = FW_Get_Random_Misc_Custom_Item (oTarget, strStruct);  		}
				break;
			case FW_MISC_RECIPE: { strStruct.oItem = FW_Get_Random_Recipe (oTarget);   		}
				break;
				
			// It's always safe to add gold, so that's default
            default:               { strStruct.oItem = FW_Get_Random_Gold (oTarget, nCR);            }                              
			    break;
        } // end of switch        		

	// SendMessageToPC(oTarget, "Item created:" + GetName(strStruct.oItem) + " Type:" + IntToString(strStruct.nLootType));   
	// Now that we have an item chosen, if overall gold piece restrictions
	// are turned on, then this section makes sure the item isn't too valuable
	// for the CR of the monster.
	if ((FW_ALLOW_OVERALL_GP_RESTRICTIONS) && (FW_IsItemRolledTooExpensive(strStruct.oItem, nCR)))
	{
		if (nNumReRolls > 0)
		{
			// Destroy the item that is too valuable.
//	        SendMessageToPC(oTarget, "Item Destroyed, too valuable retrying");
			DestroyObject (strStruct.oItem);
			nNumReRolls--;			
			// Pick a new item
			strStruct = FW_CreateLootOnObject (oTarget, strStruct, nCR, nNumReRolls);
			
		}
		// When we've rerolled nNumReRolls times but we still haven't found acceptable
		// treasure yet, we default to gold.  I also have to let the random
		// loot generator know I switched loot type categories.
		// Remember nNumReRolls gets its value from FW_NUMBER_OF_REROLLS that you set in
		// the file "fw_inc_misc"		
		else // nNumReRolls <= 0
		{
			// Destroy the item that is too expensive
			DestroyObject (strStruct.oItem);
//	        SendMessageToPC(oTarget, "Item Destroyed, too valuable giving gold");
			// Change the loot type to Gold.
			strStruct.nLootType = FW_MISC_GOLD;
			strStruct.oItem = FW_Get_Random_Gold (oTarget, nCR);			
		}			
	} // end of if
		
	return strStruct;
} // end of function


//////////////////////////////////////////
// * Function that determines what itemproperty to add to the dropping loot.
// * By default any type of item property can be chosen.  You can now set
// * upper and lower limits for each CR by editing the constants in the 
// * file "fw_inc_loot_cr_scaling"
//
itemproperty FW_WhatItemPropertyToAdd (struct MyStruct strStruct, int nCR = 0)
{
   itemproperty ipAdd; 
   int nRoll;  
      
   if (strStruct.nLootType == FW_ARMOR_CLOTHING ||
       strStruct.nLootType == FW_ARMOR_HEAVY    ||
	   strStruct.nLootType == FW_ARMOR_LIGHT    ||
	   strStruct.nLootType == FW_ARMOR_MEDIUM   ||
	   strStruct.nLootType == FW_ARMOR_SHIELDS  ||
	   strStruct.nLootType == FW_MISC_DAMAGE_SHIELD )
   {
      nRoll = Random (32);
      switch (nRoll)
      {
      case 0: ipAdd = FW_Choose_IP_Ability_Bonus (nCR);
         break;
      case 1: ipAdd = FW_Choose_IP_AC_Bonus (nCR);
         break;
      case 2: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Align (nCR);
         break;
      case 3: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Damage_Type (nCR);
         break;
      case 4: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Race (nCR);
         break;
      case 5: ipAdd = FW_Choose_IP_AC_Bonus_Vs_SAlign (nCR);
         break;
      case 6: ipAdd = FW_Choose_IP_Arcane_Spell_Failure ();
         break;
      case 7: ipAdd = FW_Choose_IP_Weight_Reduction ();
         break;
      case 8: ipAdd = FW_Choose_IP_Bonus_Feat ();
         break;
      case 9: ipAdd = FW_Choose_IP_Bonus_Hit_Points (nCR);
         break;
      case 10: ipAdd = FW_Choose_IP_Bonus_Level_Spell (nCR);
         break;
      case 11: ipAdd = FW_Choose_IP_Cast_Spell ();
         break;
      /* Damage Reduction doesn't work in NWN 2 yet. If you uncomment this case
         then you'll need to go to the bottom and change LimitUseBySAlign.
      case 12: ipAdd = FW_Choose_IP_Damage_Reduction (nCR);
         break;
      */
      case 12: ipAdd = FW_Choose_IP_Damage_Resistance (nCR);
         break;
      case 13: 
	     nRoll = Random(6) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Damage_Vulnerability ();	     }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Decrease_Ability (nCR); 	 	 }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Decrease_AC (nCR); 		 	 }
		 else if (nRoll == 4)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw (nCR);	 }
		 else if (nRoll == 5)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw_VsX (nCR); }
		 else /* (nRoll == 6)*/ { ipAdd = FW_Choose_IP_Decrease_Skill (nCR);			 }
		 break;
      case 14: ipAdd = FW_Choose_IP_Darkvision();
         break;      
      case 15: ipAdd = FW_Choose_IP_Freedom_Of_Movement();
         break;
      case 16: ipAdd = FW_Choose_IP_Haste();
         break;
      case 17: ipAdd = FW_Choose_IP_Immunity_Misc ();
         break;
      case 18: ipAdd = FW_Choose_IP_Immunity_To_Spell_Level (nCR);
         break;
      case 19: ipAdd = FW_Choose_IP_Spell_Immunity_School ();
         break;
      case 20: ipAdd = FW_Choose_IP_Spell_Immunity_Specific ();
         break;
      case 21: ipAdd = FW_Choose_IP_Damage_Immunity ();
         break;
      case 22: ipAdd = FW_Choose_IP_Improved_Evasion();
         break;
      case 23: ipAdd = FW_Choose_IP_Light();
         break;
      case 24: ipAdd = FW_Choose_IP_On_Hit_Cast_Spell ();
         break;
      case 25: ipAdd = FW_Choose_IP_Regeneration (nCR);
         break;
      case 26: ipAdd = FW_Choose_IP_Bonus_Saving_Throw (nCR);
         break;
      case 27: ipAdd = FW_Choose_IP_Bonus_Saving_Throw_VsX (nCR);
         break;
      case 28: ipAdd = FW_Choose_IP_Skill_Bonus (nCR);
         break;
      case 29: ipAdd = FW_Choose_IP_Bonus_Spell_Resistance (nCR);
         break;
      case 30: ipAdd = FW_Choose_IP_True_Seeing();
         break;
      case 31: 
	  	 nRoll = Random(4) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Limit_Use_By_Align ();  }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Limit_Use_By_Class ();  }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Limit_Use_By_Race ();   }
		 else /* (nRoll == 4)*/ { ipAdd = FW_Choose_IP_Limit_Use_By_SAlign (); }
	     break;
      
      default: break;
      }// end of switch
      return ipAdd;
   } // end of if

   else if (strStruct.nLootType == FW_ARMOR_HELMET ||
            strStruct.nLootType == FW_ARMOR_BOOT   || 
			strStruct.nLootType == FW_MISC_JEWELRY ||
			strStruct.nLootType == FW_MISC_CLOTHING )
   {      
      nRoll = Random (30);
      switch (nRoll)
      {
      case 0: ipAdd = FW_Choose_IP_Ability_Bonus (nCR);
         break;
      case 1: ipAdd = FW_Choose_IP_AC_Bonus (nCR);
         break;
      case 2: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Align (nCR);
         break;
      case 3: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Damage_Type (nCR);
         break;
      case 4: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Race (nCR);
         break;
      case 5: ipAdd = FW_Choose_IP_AC_Bonus_Vs_SAlign (nCR);
         break;
      case 6: ipAdd = FW_Choose_IP_Weight_Reduction ();
         break;
      case 7: ipAdd = FW_Choose_IP_Bonus_Feat ();
         break;
      case 8: ipAdd = FW_Choose_IP_Bonus_Hit_Points (nCR);
         break;
      case 9: ipAdd = FW_Choose_IP_Bonus_Level_Spell (nCR);
         break;
      case 10: ipAdd = FW_Choose_IP_Cast_Spell ();
         break;
      /* Damage Reduction doesn't work in NWN 2 yet.
      case 11: ipAdd = FW_Choose_IP_Damage_Reduction (nCR);
         break;
      */
      case 11: ipAdd = FW_Choose_IP_Damage_Resistance (nCR);
         break;
      case 12: 
	     nRoll = Random(6) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Damage_Vulnerability ();	     }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Decrease_Ability (nCR); 	 	 }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Decrease_AC (nCR); 		 	 }
		 else if (nRoll == 4)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw (nCR);	 }
		 else if (nRoll == 5)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw_VsX (nCR); }
		 else /* (nRoll == 6)*/ { ipAdd = FW_Choose_IP_Decrease_Skill (nCR);			 }
		 break;
      case 13: ipAdd = FW_Choose_IP_Darkvision();
         break;
      case 14: ipAdd = FW_Choose_IP_Freedom_Of_Movement();
         break;
      case 15: ipAdd = FW_Choose_IP_Haste();
         break;
      case 16: ipAdd = FW_Choose_IP_Immunity_Misc ();
         break;
      case 17: ipAdd = FW_Choose_IP_Immunity_To_Spell_Level (nCR);
         break;
      case 18: ipAdd = FW_Choose_IP_Spell_Immunity_School ();
         break;
      case 19: ipAdd = FW_Choose_IP_Spell_Immunity_Specific ();
         break;
      case 20: ipAdd = FW_Choose_IP_Damage_Immunity ();
         break;
      case 21: ipAdd = FW_Choose_IP_Improved_Evasion();
         break;
      case 22: ipAdd = FW_Choose_IP_Light();
         break;
      case 23: ipAdd = FW_Choose_IP_Regeneration (nCR);
         break;
      case 24: ipAdd = FW_Choose_IP_Bonus_Saving_Throw (nCR);
         break;
      case 25: ipAdd = FW_Choose_IP_Bonus_Saving_Throw_VsX (nCR);
         break;
      case 26: ipAdd = FW_Choose_IP_Skill_Bonus (nCR);
         break;
      case 27: ipAdd = FW_Choose_IP_Bonus_Spell_Resistance (nCR);
         break;
      case 28: ipAdd = FW_Choose_IP_True_Seeing();
         break;
      case 29: 
	     nRoll = Random(4) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Limit_Use_By_Align ();  }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Limit_Use_By_Class ();  }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Limit_Use_By_Race ();   }
		 else /* (nRoll == 4)*/ { ipAdd = FW_Choose_IP_Limit_Use_By_SAlign (); }
	     break;
      default: break;
      }// end of switch
      return ipAdd;
   } // end of if

   else if (strStruct.nLootType == FW_WEAPON_MARTIAL ||
            strStruct.nLootType == FW_WEAPON_SIMPLE  ||
			strStruct.nLootType == FW_WEAPON_EXOTIC )
   {
      nRoll =  Random (49);
	  
      switch (nRoll)
      {
      case 0: ipAdd = FW_Choose_IP_Ability_Bonus (nCR);
         break;
      case 1: ipAdd = FW_Choose_IP_AC_Bonus (nCR);
         break;
      case 2: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Align (nCR);
         break;
      case 3: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Damage_Type (nCR);
         break;
      case 4: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Race (nCR);
         break;
      case 5: ipAdd = FW_Choose_IP_AC_Bonus_Vs_SAlign (nCR);
         break;
      case 6: ipAdd = FW_Choose_IP_Attack_Bonus (nCR);
         break;
      case 7: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_Align (nCR);
         break;
      case 8: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_Race (nCR);
         break;
      case 9: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_SAlign (nCR);
         break;
      case 10:
	     nRoll = Random(10) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Damage_Vulnerability ();	    	 }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Decrease_Ability (nCR); 	 	 	 }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Decrease_AC (nCR); 		 	 	 }
		 else if (nRoll == 4)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw (nCR);	 	 }
		 else if (nRoll == 5)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw_VsX (nCR);   }
		 else if (nRoll == 6)   { ipAdd = FW_Choose_IP_Decrease_Skill (nCR);			 }
		 else if (nRoll == 7)   { ipAdd = FW_Choose_IP_Enhancement_Penalty (nCR);		 }
		 else if (nRoll == 8)   { ipAdd = FW_Choose_IP_Damage_Penalty (nCR);			 }
		 else if (nRoll == 9)   { ipAdd = ItemPropertyNoDamage ();						 }
		 else /* (nRoll == 10)*/ { ipAdd = FW_Choose_IP_Attack_Penalty (nCR);			 }
		 break;          
      case 11: ipAdd = FW_Choose_IP_Weight_Reduction ();
         break;
      case 12: ipAdd = FW_Choose_IP_Bonus_Feat ();
         break;
      case 13: ipAdd = FW_Choose_IP_Bonus_Hit_Points (nCR);
         break;
      case 14: ipAdd = FW_Choose_IP_Bonus_Level_Spell (nCR);
         break;
      case 15: ipAdd = FW_Choose_IP_Cast_Spell ();
         break;
      case 16: ipAdd = FW_Choose_IP_Damage_Bonus (nCR);
         break;
      case 17: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_Align (nCR);
         break;
      case 18: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_Race (nCR);
         break;
      case 19: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_SAlign (nCR);
         break;
      /* Damage Reduction doesn't work in NWN 2 yet.
      case 25: ipAdd = FW_Choose_IP_Damage_Reduction (nCR);
         break;
      */
      case 20: ipAdd = FW_Choose_IP_Damage_Resistance (nCR);
         break;      
      case 21: ipAdd = FW_Choose_IP_Darkvision();
         break;
      case 22: ipAdd = FW_Choose_IP_Enhancement_Bonus (nCR);
         break;
      case 23: ipAdd = FW_Choose_IP_Enhancement_Bonus_Vs_Align (nCR);
         break;
      case 24: ipAdd = FW_Choose_IP_Enhancement_Bonus_Vs_Race (nCR);
         break;
      case 25: ipAdd = FW_Choose_IP_Enhancement_Bonus_Vs_SAlign (nCR);
         break;
      case 26: ipAdd = FW_Choose_IP_Extra_Melee_Damage_Type ();
         break;
      case 27: ipAdd = FW_Choose_IP_Freedom_Of_Movement();
         break;
      case 28: ipAdd = FW_Choose_IP_Haste();
         break;
      case 29: ipAdd = FW_Choose_IP_Holy_Avenger();
         break;
      case 30: ipAdd = FW_Choose_IP_Immunity_Misc ();
         break;
      case 31: ipAdd = FW_Choose_IP_Immunity_To_Spell_Level (nCR);
         break;
      case 32: ipAdd = FW_Choose_IP_Spell_Immunity_School ();
         break;
      case 33: ipAdd = FW_Choose_IP_Spell_Immunity_Specific ();
         break;
      case 34: ipAdd = FW_Choose_IP_Damage_Immunity ();
         break;
      case 35: ipAdd = FW_Choose_IP_Improved_Evasion();
         break;
      case 36: ipAdd = FW_Choose_IP_Keen();
         break;
      case 37: ipAdd = FW_Choose_IP_Light();
         break;
      case 38: ipAdd = FW_Choose_IP_Massive_Critical (nCR);
         break;      
      case 39: ipAdd = FW_Choose_IP_On_Hit_Cast_Spell ();
         break;
      case 40: ipAdd = FW_Choose_IP_On_Hit_Props ();
         break;
      case 41: ipAdd = FW_Choose_IP_Regeneration (nCR);
         break;
      case 42: ipAdd = FW_Choose_IP_Vampiric_Regeneration (nCR);
         break;
      case 43: ipAdd = FW_Choose_IP_Bonus_Saving_Throw (nCR);
         break;
      case 44: ipAdd = FW_Choose_IP_Bonus_Saving_Throw_VsX (nCR);
         break;
      case 45: ipAdd = FW_Choose_IP_Skill_Bonus (nCR);
         break;
      case 46: ipAdd = FW_Choose_IP_Bonus_Spell_Resistance (nCR);
         break;
      case 47: ipAdd = FW_Choose_IP_True_Seeing();
         break;
      case 48: 
	     nRoll = Random(4) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Limit_Use_By_Align ();  }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Limit_Use_By_Class ();  }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Limit_Use_By_Race ();   }
		 /*else  (nRoll == 4) { ipAdd = FW_Choose_IP_Limit_Use_By_SAlign (); }*/
	     break;
      default: break;
      } // end of switch
      return ipAdd;
   } // end of if

   else if (strStruct.nLootType == FW_WEAPON_AMMUNITION)
   {
      nRoll = Random (11);
      switch (nRoll)
      {
      case 0: ipAdd = FW_Choose_IP_Weight_Reduction ();
         break;
      case 1: ipAdd = FW_Choose_IP_Damage_Bonus (nCR);
         break;
      case 2: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_Align (nCR);
         break;
      case 3: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_Race (nCR);
         break;
      case 4: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_SAlign (nCR);
         break;
      case 5: 
	     nRoll = Random(2) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw (nCR);      }
		 else /* (nRoll == 2)*/ { ipAdd = FW_Choose_IP_Reduced_Saving_Throw_VsX (nCR);  }
	     break;      
      case 6: ipAdd = FW_Choose_IP_Extra_Range_Damage_Type ();
         break;
      case 7: ipAdd = FW_Choose_IP_On_Hit_Cast_Spell ();
         break;
      case 8: ipAdd = FW_Choose_IP_On_Hit_Props ();
         break;
      case 9: ipAdd = FW_Choose_IP_Vampiric_Regeneration (nCR);
         break;
      case 10: 
	     nRoll = Random(4) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Limit_Use_By_Align ();  }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Limit_Use_By_Class ();  }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Limit_Use_By_Race ();   }
		 else /* (nRoll == 4)*/ { ipAdd = FW_Choose_IP_Limit_Use_By_SAlign (); }
	     break;
      } // end of switch
      return ipAdd;
   } // end of if

   else if (strStruct.nLootType == FW_WEAPON_RANGED)
   {
      nRoll = Random (38);
      switch (nRoll)
      {
      case 0: ipAdd = FW_Choose_IP_Ability_Bonus (nCR);
         break;
      case 1: ipAdd = FW_Choose_IP_AC_Bonus (nCR);
         break;
      case 2: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Align (nCR);
         break;
      case 3: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Damage_Type(nCR);
         break;
      case 4: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Race (nCR);
         break;
      case 5: ipAdd = FW_Choose_IP_AC_Bonus_Vs_SAlign (nCR);
         break;
      case 6: ipAdd = FW_Choose_IP_Attack_Bonus (nCR);
         break;
      case 7: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_Align (nCR);
         break;
      case 8: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_Race (nCR);
         break;
      case 9: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_SAlign (nCR);
         break;
      case 10: ipAdd = FW_Choose_IP_Weight_Reduction ();
         break;
      case 11: ipAdd = FW_Choose_IP_Bonus_Feat ();
         break;
      case 12: ipAdd = FW_Choose_IP_Bonus_Hit_Points (nCR);
         break;
      case 13: ipAdd = FW_Choose_IP_Bonus_Level_Spell (nCR);
         break;
      case 14: ipAdd = FW_Choose_IP_Cast_Spell ();
         break;
      /* damage reduction doesn't work in NWN 2 yet.
      case 15: ipAdd = FW_Choose_IP_Damage_Reduction (nCR);
         break;
      */
      case 15: ipAdd = FW_Choose_IP_Damage_Resistance (nCR);
         break;
      case 16: 
	     nRoll = Random(8) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Damage_Vulnerability ();	    	 }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Decrease_Ability (nCR); 	 	 	 }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Decrease_AC (nCR); 		 	 	 }
		 else if (nRoll == 4)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw (nCR);	 	 }
		 else if (nRoll == 5)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw_VsX (nCR);   }
		 else if (nRoll == 6)   { ipAdd = FW_Choose_IP_Decrease_Skill (nCR);			 }
		 else if (nRoll == 7)   { ipAdd = ItemPropertyNoDamage ();						 }
		 else /* (nRoll == 8)*/ { ipAdd = FW_Choose_IP_Attack_Penalty (nCR);			 }
		 break;  	    
      case 17: ipAdd = FW_Choose_IP_Darkvision();
         break;      
      case 18: ipAdd = FW_Choose_IP_Extra_Range_Damage_Type ();
         break;
      case 19: ipAdd = FW_Choose_IP_Freedom_Of_Movement();
         break;
      case 20: ipAdd = FW_Choose_IP_Haste();
         break;
      case 21: ipAdd = FW_Choose_IP_Immunity_Misc ();
         break;
      case 22: ipAdd = FW_Choose_IP_Immunity_To_Spell_Level (nCR);
         break;
      case 23: ipAdd = FW_Choose_IP_Spell_Immunity_School ();
         break;
      case 24: ipAdd = FW_Choose_IP_Spell_Immunity_Specific ();
         break;
      case 25: ipAdd = FW_Choose_IP_Damage_Immunity ();
         break;
      case 26: ipAdd = FW_Choose_IP_Improved_Evasion();
         break;
      case 27: ipAdd = FW_Choose_IP_Light();
         break;
      case 28: ipAdd = FW_Choose_IP_Massive_Critical (nCR);
         break;
      case 29: ipAdd = FW_Choose_IP_Mighty (nCR);
         break;      
      case 30: ipAdd = FW_Choose_IP_Regeneration (nCR);
         break;
      case 31: ipAdd = FW_Choose_IP_Bonus_Saving_Throw (nCR);
         break;
      case 32: ipAdd = FW_Choose_IP_Bonus_Saving_Throw_VsX (nCR);
         break;
      case 33: ipAdd = FW_Choose_IP_Skill_Bonus (nCR);
         break;
      case 34: ipAdd = FW_Choose_IP_Bonus_Spell_Resistance (nCR);
         break;
      case 35: ipAdd = FW_Choose_IP_True_Seeing();
         break;
      case 36: ipAdd = FW_Choose_IP_Unlimited_Ammo ();
         break;
      case 37: 
	     nRoll = Random(4) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Limit_Use_By_Align ();  }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Limit_Use_By_Class ();  }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Limit_Use_By_Race ();   }
		 else /* (nRoll == 4)*/ { ipAdd = FW_Choose_IP_Limit_Use_By_SAlign (); }
	     break;
      } // end of switch
      return ipAdd;
   } // end of if

   else if (strStruct.nLootType == FW_WEAPON_THROWN)
   {     
      nRoll = Random (29);
      switch (nRoll)
      {
      case 0: ipAdd = FW_Choose_IP_Ability_Bonus (nCR);
         break;
      case 1: 
	     nRoll = Random(10) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Damage_Vulnerability ();	    	 }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Decrease_Ability (nCR); 	 	 	 }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Decrease_AC (nCR); 		 	 	 }
		 else if (nRoll == 4)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw (nCR);	 	 }
		 else if (nRoll == 5)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw_VsX (nCR);   }
		 else if (nRoll == 6)   { ipAdd = FW_Choose_IP_Decrease_Skill (nCR);			 }
		 else if (nRoll == 7)   { ipAdd = FW_Choose_IP_Enhancement_Penalty (nCR);		 }
		 else if (nRoll == 8)   { ipAdd = FW_Choose_IP_Damage_Penalty (nCR);			 }
		 else if (nRoll == 9)   { ipAdd = ItemPropertyNoDamage ();						 }
		 else /* (nRoll == 10)*/ { ipAdd = FW_Choose_IP_Attack_Penalty (nCR);			 }
		 break;  	 
      case 2: ipAdd = FW_Choose_IP_Attack_Bonus (nCR);
         break;
      case 3: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_Align (nCR);
         break;
      case 4: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_Race (nCR);
         break;
      case 5: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_SAlign (nCR);
         break;
      case 6: ipAdd = FW_Choose_IP_Weight_Reduction ();
         break;
      case 7: ipAdd = FW_Choose_IP_Bonus_Feat ();
         break;
      case 8: ipAdd = FW_Choose_IP_Bonus_Level_Spell (nCR);
         break;
      case 9: ipAdd = FW_Choose_IP_Damage_Bonus (nCR);
         break;
      case 10: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_Align (nCR);
         break;
      case 11: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_Race (nCR);
         break;
      case 12: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_SAlign (nCR);
         break;      
      case 13: ipAdd = FW_Choose_IP_Darkvision();
         break;     
      case 14: ipAdd = FW_Choose_IP_Enhancement_Bonus (nCR);
         break;
      case 15: ipAdd = FW_Choose_IP_Enhancement_Bonus_Vs_Align (nCR);
         break;
      case 16: ipAdd = FW_Choose_IP_Enhancement_Bonus_Vs_Race (nCR);
         break;
      case 17: ipAdd = FW_Choose_IP_Enhancement_Bonus_Vs_SAlign (nCR);
         break;
      case 18: ipAdd = FW_Choose_IP_Extra_Range_Damage_Type ();
         break;
      case 19: ipAdd = FW_Choose_IP_Haste();
         break;
      case 20: ipAdd = FW_Choose_IP_Light();
         break;
      case 21: ipAdd = FW_Choose_IP_Massive_Critical (nCR);
         break;
      case 22: ipAdd = FW_Choose_IP_Mighty (nCR);
         break;      
      case 23: ipAdd = FW_Choose_IP_On_Hit_Cast_Spell ();
         break;
      case 24: ipAdd = FW_Choose_IP_On_Hit_Props ();
         break;
      case 25: ipAdd = FW_Choose_IP_Vampiric_Regeneration (nCR);
         break;
      case 26: ipAdd = FW_Choose_IP_Skill_Bonus (nCR);
         break;
      case 27: ipAdd = FW_Choose_IP_Bonus_Spell_Resistance (nCR);
         break;
      case 28: 
	     nRoll = Random(4) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Limit_Use_By_Align ();  }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Limit_Use_By_Class ();  }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Limit_Use_By_Race ();   }
		 else /* (nRoll == 4)*/ { ipAdd = FW_Choose_IP_Limit_Use_By_SAlign (); }
	     break;
	  default: break;
      }	 // end of switch 
      return ipAdd;
   } // end of if
   
   else if (strStruct.nLootType == FW_MISC_GAUNTLET)
   {
      nRoll = Random (37);
      switch (nRoll)
      {
      case 0: ipAdd = FW_Choose_IP_Ability_Bonus (nCR);
         break;
      case 1: ipAdd = FW_Choose_IP_AC_Bonus (nCR);
         break;
      case 2: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Align (nCR);
         break;
      case 3: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Damage_Type (nCR);
         break;
      case 4: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Race (nCR);
         break;
      case 5: ipAdd = FW_Choose_IP_AC_Bonus_Vs_SAlign (nCR);
         break;
      case 6: ipAdd = FW_Choose_IP_Attack_Bonus (nCR);
         break;
      case 7: 
	     nRoll = Random(9) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Damage_Vulnerability ();	    	 }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Decrease_Ability (nCR); 	 	 	 }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Decrease_AC (nCR); 		 	 	 }
		 else if (nRoll == 4)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw (nCR);	 	 }
		 else if (nRoll == 5)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw_VsX (nCR);   }
		 else if (nRoll == 6)   { ipAdd = FW_Choose_IP_Decrease_Skill (nCR);			 }
		 else if (nRoll == 7)   { ipAdd = FW_Choose_IP_Enhancement_Penalty (nCR);		 }
		 else if (nRoll == 8)   { ipAdd = FW_Choose_IP_Damage_Penalty (nCR);			 }
		 else /* (nRoll == 9)*/ { ipAdd = FW_Choose_IP_Attack_Penalty (nCR);			 }
		 break;
      case 8: ipAdd = FW_Choose_IP_Weight_Reduction ();
         break;
      case 9: ipAdd = FW_Choose_IP_Bonus_Feat ();
         break;
      case 10: ipAdd = FW_Choose_IP_Bonus_Hit_Points (nCR);
         break;
      case 11: ipAdd = FW_Choose_IP_Bonus_Level_Spell (nCR);
         break;
      case 12: ipAdd = FW_Choose_IP_Cast_Spell ();
         break;
      case 13: ipAdd = FW_Choose_IP_Damage_Bonus (nCR);
         break;
      case 14: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_Align (nCR);
         break;
      case 15: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_Race (nCR);
         break;
      case 16: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_SAlign (nCR);
         break;
      /* Damage Reduction doesn't work in NWN 2 yet.
      case 25: ipAdd = FW_Choose_IP_Damage_Reduction (nCR);
         break;
      */
      case 17: ipAdd = FW_Choose_IP_Damage_Resistance (nCR);
         break;      
      case 18: ipAdd = FW_Choose_IP_Darkvision();
         break;  
      case 19: ipAdd = FW_Choose_IP_Freedom_Of_Movement();
         break;
      case 20: ipAdd = FW_Choose_IP_Haste();
         break;
      case 21: ipAdd = FW_Choose_IP_Immunity_Misc ();
         break;
      case 22: ipAdd = FW_Choose_IP_Immunity_To_Spell_Level (nCR);
         break;
      case 23: ipAdd = FW_Choose_IP_Spell_Immunity_School ();
         break;
      case 24: ipAdd = FW_Choose_IP_Spell_Immunity_Specific ();
         break;
      case 25: ipAdd = FW_Choose_IP_Damage_Immunity ();
         break;
      case 26: ipAdd = FW_Choose_IP_Improved_Evasion();
         break;
      case 27: ipAdd = FW_Choose_IP_Light();
         break;
      case 28: ipAdd = FW_Choose_IP_On_Hit_Cast_Spell ();
         break;
      case 29: ipAdd = FW_Choose_IP_On_Hit_Props ();
         break;
      case 30: ipAdd = FW_Choose_IP_Regeneration (nCR);
         break;
      case 31: ipAdd = FW_Choose_IP_Bonus_Saving_Throw (nCR);
         break;
      case 32: ipAdd = FW_Choose_IP_Bonus_Saving_Throw_VsX (nCR);
         break;
      case 33: ipAdd = FW_Choose_IP_Skill_Bonus (nCR);
         break;
      case 34: ipAdd = FW_Choose_IP_Bonus_Spell_Resistance (nCR);
         break;
      case 35: ipAdd = FW_Choose_IP_True_Seeing();
         break;
      case 36:
	     nRoll = Random(4) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Limit_Use_By_Align ();  }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Limit_Use_By_Class ();  }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Limit_Use_By_Race ();   }
		 else /* (nRoll == 4)*/ { ipAdd = FW_Choose_IP_Limit_Use_By_SAlign (); }
	     break; 
      default: break;
      } // end of switch
      return ipAdd;
   } // end of if

   else if ((strStruct.nLootType == FW_WEAPON_MAGE_SPECIFIC)
             && (BASE_ITEM_MAGICSTAFF == GetBaseItemType(strStruct.oItem)))
   {
   	  nRoll =  Random (46);
      switch (nRoll)
      {
      case 0: ipAdd = FW_Choose_IP_Ability_Bonus (nCR);
         break;
      case 1: ipAdd = FW_Choose_IP_AC_Bonus (nCR);
         break;
      case 2: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Align (nCR);
         break;
      case 3: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Damage_Type (nCR);
         break;
      case 4: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Race (nCR);
         break;
      case 5: ipAdd = FW_Choose_IP_AC_Bonus_Vs_SAlign (nCR);
         break;
      case 6: ipAdd = FW_Choose_IP_Attack_Bonus (nCR);
         break;
      case 7: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_Align (nCR);
         break;
      case 8: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_Race (nCR);
         break;
      case 9: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_SAlign (nCR);
         break;
      case 10: ipAdd = FW_Choose_IP_Weight_Reduction ();
         break;
      case 11: ipAdd = FW_Choose_IP_Bonus_Feat ();
         break;
      case 12: ipAdd = FW_Choose_IP_Bonus_Hit_Points (nCR);
         break;
      case 13: ipAdd = FW_Choose_IP_Bonus_Level_Spell(nCR);
         break;
      case 14: ipAdd = FW_Choose_IP_Cast_Spell ();
         break;
      case 15: ipAdd = FW_Choose_IP_Damage_Bonus (nCR);
         break;
      case 16: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_Align (nCR);
         break;
      case 17: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_Race (nCR);
         break;
      case 18: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_SAlign (nCR);
         break;
      /* Damage Reduction doesn't work in NWN 2 yet.
      case 25: ipAdd = FW_Choose_IP_Damage_Reduction (nCR);
         break;
      */
      case 19: ipAdd = FW_Choose_IP_Damage_Resistance (nCR);
         break;
      case 20: 
	     nRoll = Random(10) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Damage_Vulnerability ();	    	 }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Decrease_Ability (nCR); 	 	 	 }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Decrease_AC (nCR); 		 	 	 }
		 else if (nRoll == 4)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw (nCR);	 	 }
		 else if (nRoll == 5)   { ipAdd = FW_Choose_IP_Reduced_Saving_Throw_VsX (nCR);   }
		 else if (nRoll == 6)   { ipAdd = FW_Choose_IP_Decrease_Skill (nCR);			 }
		 else if (nRoll == 7)   { ipAdd = FW_Choose_IP_Enhancement_Penalty (nCR);		 }
		 else if (nRoll == 8)   { ipAdd = FW_Choose_IP_Damage_Penalty (nCR);			 }
		 else if (nRoll == 9)   { ipAdd = ItemPropertyNoDamage ();						 }
		 else /* (nRoll == 10)*/ { ipAdd = FW_Choose_IP_Attack_Penalty (nCR);			 }
		 break;  	  
      case 21: ipAdd = FW_Choose_IP_Darkvision();
         break;
      case 22: ipAdd = FW_Choose_IP_Enhancement_Bonus (nCR);
         break;
      case 23: ipAdd = FW_Choose_IP_Enhancement_Bonus_Vs_Align (nCR);
         break;
      case 24: ipAdd = FW_Choose_IP_Enhancement_Bonus_Vs_Race (nCR);
         break;
      case 25: ipAdd = FW_Choose_IP_Enhancement_Bonus_Vs_SAlign (nCR);
         break;
      case 26: ipAdd = FW_Choose_IP_Extra_Melee_Damage_Type ();
         break;     
      case 27: ipAdd = FW_Choose_IP_Haste();
         break;      
      case 28: ipAdd = FW_Choose_IP_Immunity_Misc ();
         break;
      case 29: ipAdd = FW_Choose_IP_Immunity_To_Spell_Level (nCR);
         break;
      case 30: ipAdd = FW_Choose_IP_Spell_Immunity_School ();
         break;
      case 31: ipAdd = FW_Choose_IP_Spell_Immunity_Specific ();
         break;
      case 32: ipAdd = FW_Choose_IP_Damage_Immunity ();
         break;
      case 33: ipAdd = FW_Choose_IP_Improved_Evasion();
         break;      
      case 34: ipAdd = FW_Choose_IP_Light();
         break;
      case 35: ipAdd = FW_Choose_IP_Massive_Critical (nCR);
         break;
      case 36: ipAdd = FW_Choose_IP_On_Hit_Cast_Spell ();
         break;
      case 37: ipAdd = FW_Choose_IP_On_Hit_Props ();
         break;
      case 38: ipAdd = FW_Choose_IP_Regeneration (nCR);
         break;
      case 39: ipAdd = FW_Choose_IP_Vampiric_Regeneration (nCR);
         break;
      case 40: ipAdd = FW_Choose_IP_Bonus_Saving_Throw (nCR);
         break;
      case 41: ipAdd = FW_Choose_IP_Bonus_Saving_Throw_VsX (nCR);
         break;
      case 42: ipAdd = FW_Choose_IP_Skill_Bonus (nCR);
         break;
      case 43: ipAdd = FW_Choose_IP_Bonus_Spell_Resistance (nCR);
         break;
      case 44: ipAdd = FW_Choose_IP_True_Seeing();
         break;
      case 45: 
	     nRoll = Random(4) + 1;
		 if      (nRoll == 1)   { ipAdd = FW_Choose_IP_Limit_Use_By_Align ();  }
		 else if (nRoll == 2)   { ipAdd = FW_Choose_IP_Limit_Use_By_Class ();  }
		 else if (nRoll == 3)   { ipAdd = FW_Choose_IP_Limit_Use_By_Race ();   }
		 else /* (nRoll == 4)*/ { ipAdd = FW_Choose_IP_Limit_Use_By_SAlign (); }
	     break;
		 
      default: break;
      } // end of switch
	  return ipAdd;   
   } // end of if   

   // Below is the listing of all 68 item properties.  This would only get
   // executed if for some reason there was an error above and some type
   // of loot was of a different category than the ones I have above.  I 
   // believe I got everything above, but just in case I didn't, I list
   // them all here.  All the categories above exclude 1 or more items from
   // the master list here.
   nRoll = Random (67);   
   switch (nRoll)
   {      
      case 0: ipAdd = FW_Choose_IP_Ability_Bonus (nCR);
         break;
      case 1: ipAdd = FW_Choose_IP_AC_Bonus (nCR);
         break;
      case 2: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Align (nCR);
         break;
      case 3: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Damage_Type (nCR);
         break;
      case 4: ipAdd = FW_Choose_IP_AC_Bonus_Vs_Race (nCR);
         break;
      case 5: ipAdd = FW_Choose_IP_AC_Bonus_Vs_SAlign (nCR);
         break;
      case 6: ipAdd = FW_Choose_IP_Arcane_Spell_Failure ();
         break;
      case 7: ipAdd = FW_Choose_IP_Attack_Bonus (nCR);
         break;
      case 8: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_Align (nCR);
         break;
      case 9: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_Race (nCR);
         break;
      case 10: ipAdd = FW_Choose_IP_Attack_Bonus_Vs_SAlign (nCR);
         break;
      case 11: ipAdd = FW_Choose_IP_Attack_Penalty (nCR);
         break;
      case 12: ipAdd = FW_Choose_IP_Bonus_Feat ();
         break;
      case 13: ipAdd = FW_Choose_IP_Bonus_Hit_Points (nCR);
         break;
      case 14: ipAdd = FW_Choose_IP_Bonus_Level_Spell (nCR);
         break;
      case 15: ipAdd = FW_Choose_IP_Bonus_Saving_Throw (nCR);
         break;
      case 16: ipAdd = FW_Choose_IP_Bonus_Saving_Throw_VsX (nCR);
         break;
      case 17: ipAdd = FW_Choose_IP_Bonus_Spell_Resistance (nCR);
         break;
      case 18: ipAdd = FW_Choose_IP_Cast_Spell ();
         break;
      case 19: ipAdd = FW_Choose_IP_Damage_Bonus (nCR);
         break;
      case 20: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_Align (nCR);
         break;
      case 21: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_Race (nCR);
         break;
      case 22: ipAdd = FW_Choose_IP_Damage_Bonus_Vs_SAlign (nCR);
         break;
      case 23: ipAdd = FW_Choose_IP_Damage_Immunity ();
         break;
      case 24: ipAdd = FW_Choose_IP_Damage_Penalty (nCR);
         break;
      case 25: ipAdd = FW_Choose_IP_Damage_Reduction (nCR);
         break;
      case 26: ipAdd = FW_Choose_IP_Damage_Resistance (nCR);
         break;
      case 27: ipAdd = FW_Choose_IP_Damage_Vulnerability ();
         break;
      case 28: ipAdd = FW_Choose_IP_Darkvision();
         break;
      case 29: ipAdd = FW_Choose_IP_Decrease_Ability (nCR);
         break;
      case 30: ipAdd = FW_Choose_IP_Decrease_AC (nCR);
         break;
      case 31: ipAdd = FW_Choose_IP_Decrease_Skill (nCR);
         break;
      case 32: ipAdd = FW_Choose_IP_Enhancement_Bonus (nCR);
         break;
      case 33: ipAdd = FW_Choose_IP_Enhancement_Bonus_Vs_Align (nCR);
         break;
      case 34: ipAdd = FW_Choose_IP_Enhancement_Bonus_Vs_Race (nCR);
         break;
      case 35: ipAdd = FW_Choose_IP_Enhancement_Bonus_Vs_SAlign (nCR);
         break;
      case 36: ipAdd = FW_Choose_IP_Enhancement_Penalty (nCR);
         break;
      case 37: ipAdd = FW_Choose_IP_Extra_Melee_Damage_Type ();
         break;
      case 38: ipAdd = FW_Choose_IP_Extra_Range_Damage_Type ();
         break;
      case 39: ipAdd = FW_Choose_IP_Freedom_Of_Movement();
         break;
      case 40: ipAdd = FW_Choose_IP_Haste();
         break;
      /* Making an item healer's kit doesn't work dynamically
      case 40: ipAdd = FW_Choose_IP_Healer_Kit (nCR);
         break;  */
      case 41: ipAdd = FW_Choose_IP_Holy_Avenger();
         break;
      case 42: ipAdd = FW_Choose_IP_Immunity_Misc ();
         break;
      case 43: ipAdd = FW_Choose_IP_Immunity_To_Spell_Level (nCR);
         break;
      case 44: ipAdd = FW_Choose_IP_Improved_Evasion();
         break;
      case 45: ipAdd = FW_Choose_IP_Keen();
         break;
      case 46: ipAdd = FW_Choose_IP_Light();
         break;
      case 47: ipAdd = FW_Choose_IP_Limit_Use_By_Align ();
         break;
      case 48: ipAdd = FW_Choose_IP_Limit_Use_By_Class ();
         break;
      case 49: ipAdd = FW_Choose_IP_Limit_Use_By_Race ();
         break;
      case 50: ipAdd = FW_Choose_IP_Limit_Use_By_SAlign ();
         break;
      case 51: ipAdd = FW_Choose_IP_Massive_Critical (nCR);
         break;
      case 52: ipAdd = FW_Choose_IP_Mighty (nCR);
         break;
      case 53: ipAdd = ItemPropertyNoDamage ();
         break;
      case 54: ipAdd = FW_Choose_IP_On_Hit_Cast_Spell ();
         break;
      case 55: ipAdd = FW_Choose_IP_On_Hit_Props ();
         break;
      case 56: ipAdd = FW_Choose_IP_Reduced_Saving_Throw (nCR);
         break;
      case 57: ipAdd = FW_Choose_IP_Reduced_Saving_Throw_VsX (nCR);
         break;
      case 58: ipAdd = FW_Choose_IP_Regeneration (nCR);
         break;
      case 59: ipAdd = FW_Choose_IP_Skill_Bonus (nCR);
         break;
      case 60: ipAdd = FW_Choose_IP_Spell_Immunity_School ();
         break;
      case 61: ipAdd = FW_Choose_IP_Spell_Immunity_Specific ();
         break;
      case 62: ipAdd = FW_Choose_IP_Thieves_Tools ();
         break;
      case 63: ipAdd = FW_Choose_IP_True_Seeing();
         break;
		 
      /* Turn Resistance is broken as of 10 July 2007
      case 64: ipAdd = FW_Choose_IP_Turn_Resistance (nCR);
         break;
      */
      case 64: ipAdd = FW_Choose_IP_Unlimited_Ammo ();
         break;
      case 65: ipAdd = FW_Choose_IP_Vampiric_Regeneration (nCR);
         break;
      /* Weight Increase.  Weight increase didn't work as of 10 July 2007.
      case 66: ipAdd = FW_Choose_IP_Weight_Increase ();
         break;
      */
      case 66: ipAdd = FW_Choose_IP_Weight_Reduction ();
         break;
      default: break;
   } // end of switch 
  
   return ipAdd;
}

   
struct MyStruct FW_CompleteRandomLootGeneration(object oTarget, struct MyStruct strStruct, int nCR = 0)
{  
   // Keep track of item properties.
   int nNumIP = 0;
   
   // We have to keep the CR within bounds.
   if (nCR < 0)
   	 nCR = 0;
   if (nCR > 41)
   	 nCR = 41;   
	 
   // Even though this function uses the word "monster" it also works
   // with placeables (like treasure chests, armoirs, book cases, etc.)
   // I just didn't want to rename this function when I made version
   // 2.0 of the random loot generator.
   int Loot = FW_DoesMonsterDropLoot (nCR);   
   if (Loot)
   {
   	  int nNumItems = FW_HowManyItemsDrop ();
	  	  
	  if(nNumItems > 2)
	  {
	  	nNumItems = 1;
	  }
      // SendMessageToPC(oTarget, "Number of Items of Loot:" + IntToString(nNumItems));
	  
      while (nNumItems > 0)
      {
	  	 // The call to FW_CreateLootOnObject does most of the work of this 
		 // program.  
         strStruct = FW_CreateLootOnObject (oTarget, strStruct, nCR);
		  
         if (strStruct.nLootType == FW_MISC_RECIPE   ||
		     strStruct.nLootType == FW_MISC_POTION   ||
		     strStruct.nLootType == FW_MISC_TRAPS    ||
			 strStruct.nLootType == FW_MISC_BOOKS    ||
			 strStruct.nLootType == FW_MISC_GOLD     ||
			 strStruct.nLootType == FW_MISC_GEMS     ||
			 strStruct.nLootType == FW_MISC_HEAL_KIT ||
			 strStruct.nLootType == FW_MISC_SCROLL   ||
			 strStruct.nLootType == FW_MISC_CRAFTING_MATERIAL ||
			 strStruct.nLootType == FW_MISC_OTHER    ||
			 ((strStruct.nLootType == FW_WEAPON_MAGE_SPECIFIC) && (BASE_ITEM_MAGICWAND == GetBaseItemType(strStruct.oItem))) ||
			 ((strStruct.nLootType == FW_WEAPON_MAGE_SPECIFIC) && (BASE_ITEM_MAGICROD == GetBaseItemType(strStruct.oItem)))
			 ) // close parenthesis on if.
		{
		    // Do nothing. Randomness already taken care of.	
		}		 
		else // we rolled an item that could have an IP added.
		{
		 	// Determine if we should add an item property.
			nNumIP = FW_HowManyIP ();
			
			//sanity check
			if (nNumIP > 2)
			{
				nNumIP = 1;
			}
							
			while (nNumIP > 0)
			{
				itemproperty ipAdd = FW_WhatItemPropertyToAdd (strStruct, nCR);    
				           
				// Overall Gold Piece value check added in version 1.2
				if (FW_ALLOW_OVERALL_GP_RESTRICTIONS)
				{               		
					int nIPNumReRolls = FW_NUMBER_OF_REROLLS;
					// ReRoll up to FW_NUMBER_OF_REROLLS (default 10 times).
					
					//Kaedrin - track the original stack size for ammo due to the copy item function
					int nOriginalStackSize = GetItemStackSize(strStruct.oItem); 
					
					while (nIPNumReRolls > 0)
					{     
						// Here's the new part for ILR.       						      		
						object oTemporaryItem = CopyItem(strStruct.oItem, oTarget, FALSE);
						IPSafeAddItemProperty (oTemporaryItem, ipAdd);                         		
 						if (FW_IsItemRolledTooExpensive (oTemporaryItem, nCR))
						{   					
//SendMessageToPC(oTarget, "Item Property: too expensive:" + IntToString(GetItemPropertyType(ipAdd)));
							nIPNumReRolls--;
							ipAdd = FW_WhatItemPropertyToAdd (strStruct, nCR);		  						
						}
						else
						{
							nIPNumReRolls = 0;
							IPSafeAddItemProperty (strStruct.oItem, ipAdd);   
//SendMessageToPC(oTarget, "Item Property: added1:" + IntToString(GetItemPropertyType(ipAdd)));
						}
						DestroyObject (oTemporaryItem);
					} // end of while	
					
					if (nOriginalStackSize > 1)
					{
						SetItemStackSize(strStruct.oItem, nOriginalStackSize, FALSE);
					}
								
				} // end of if											
				// If we don't care what the overall gp value is. 
				else  // FW_ALLOW_OVERALL_GP_RESTRICTIONS == FALSE;
				{
					IPSafeAddItemProperty (strStruct.oItem, ipAdd);
//SendMessageToPC(oTarget, "Item Property: added2:" + IntToString(GetItemPropertyType(ipAdd)));
				}
				// decrement so we don't get stuck forever in this loop.
				nNumIP--;
			} // end of while
			

			if (FW_ALLOW_CURSED_ITEMS == TRUE)
			{
				if (FW_IsItemCursed ())
				{
					SetItemCursedFlag (strStruct.oItem, TRUE);
				}
            }		
		 
	         itemproperty itemProp = GetFirstItemProperty(strStruct.oItem);
			 if(GetIsItemPropertyValid(itemProp)) { 
//SendMessageToPC(oTarget, "Item Property Found type:" + IntToString(GetItemPropertyType(itemProp)));
			    //if magical, make unidentified 
			 	SetIdentified (strStruct.oItem, FALSE);
				// Only magical loot gets a cool name.  
				FW_Name_Get_Random_Name (strStruct);
			 } else {
			    //if not magical, make identified
			 	SetIdentified (strStruct.oItem, TRUE);
				
				//if its really cheap non magical item drop gold rather than useless item
				if (strStruct.nLootType != FW_MISC_GOLD) {
					int nItemValue = GetGoldPieceValue(strStruct.oItem);
					if (nItemValue < 25) {
						// Destroy the item that is too cheap
						DestroyObject (strStruct.oItem);
//SendMessageToPC(oTarget, "Item Destroyed: too cheap, giving gold");
						// Change the loot type to Gold.
						strStruct.nLootType = FW_MISC_GOLD;
						strStruct.oItem = CreateItemOnObject("NW_IT_GOLD001", oTarget, 5 + nItemValue);				
					}
				}
			 }
		 } // end of else	
				 
         SetDroppableFlag (strStruct.oItem, TRUE);
         SetPickpocketableFlag (strStruct.oItem, FALSE);

         nNumItems--;
      } // end of while
   } // end of if (Loot)
   // else SendMessageToPC(oTarget, "Not dropping loot");
   return strStruct;
} // end of main
/////////////////////////////////////////////
// *
// * Created by Christopher Aulepp
// * Date: 12 May 2008
// * contact information: cdaulepp@juno.com
// * VERSION 2.0
// * copyright 2008 Christopher Aulepp. All rights reserved.
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
// This file works in conjunction with the random loot generation system.
// I couldn't find .2da files for all of the items in the standard toolset
// palette.  So, I had to hard-code many of the basic items to allow them
// to be generated as random loot.  The functions in this file get random
// objects from the various loot category types. (i.e. potions, scrolls, etc)

// *****************************************
//
//              MAIN
//
// *****************************************
// I shouldn't need a main because this will be a starting conditional. 

// *****************************************
//
//              UPDATES
//
// *****************************************
// VERSION 2.0
// - 12 May 2008. Fixed a logic error in the function "Fw_Get_Random_Gold"
// 	    that in a very limited number of circumstances would give too little
//      gold to a spawning monster.  Spawning monsters now respect GP lower
//      and upper limits placed by the end-user.
//
// - 12 May 2008. Updated all of the random rolls that reference a 2da file.  I accounted
//      for new material released or added in MotB.
//
// - 28 March 2008. Updated crafting items to account for new stuff from
//      Mask of the Betrayer.  Some new basic items came out with MotB and lots of
//      new essences.
// 
// - 28 March 2008. Updated Miscellaneous Other category to account for new MotB items.
//
// -  5 April 2008. Fixed an error in the function to get potions.  I was 
//	    previously trying to create a generic potion on monsters with the ResRef
// 	    of: "fw_itm_generic_potion"  This was wrong because I needed to have the 
// 	    word "misc" in the name of the ResRef.  It now reads correctly as:
//	    "fw_itm_misc_generic_potion"  This will mean that potions will now show up
//	    on monsters as loo, whereas they were not showing up at all in previous versions.
//      Depending on the A.I. you use, the monsters may drink some or all of the randomly
//	    appearing potions. 
//
// -  5 April 2008. Fixed the naming convention of Wands, Rods, Potions, and Scrolls so that
//      the random loot generator now gets the name from the .tlk file instead of "iprp_spells.2da"
//      This basically means that you won't see annoying underscore "_" characters in the 
//      names anymore.   
//
// - 20 April 2008. Fixed the ResRef spelling of Generic Heavy Crossbows.
//
// - 20 April 2008. Fixed the ResRef spelling of Generic Clubs.
//
// - 20 April 2008. Fixed the ResRef spelling of Generic Falchions.
//
// - 20 April 2008. Added a function to make random rods.  It is called:
//      "FW_Get_Random_Rod".  Unlike wands, rods have no use limitations. Rods
//      have a set number of charges and then disappear when used up.
//
//
// VERSION 1.2
// - 28 August 2007.  I added a new function: FW_Get_Random_Misc_Custom_Item.
//      This function is where people will need to edit the code to add
//      their own items into the random loot generator.
//
// - 28 August 2007.  I had accidentally left a line setting CR = 10; in 
//      the get gold function.  Oops.  I had that there when I was testing.
//      I removed that and now the monster's drop gold according to CR 
//      as I intended them to initially.  I also altered the formula that
//      determines how much gold a monster will drop.  I use a formula and
//      modifier method to calculate gold.  I also added module limit checks
//      on the amount of gold that will drop so that monsters will always
//      drop enough, but not too much gold (depending on what the end-user
//      sets for the module limits.  The module limits for gold are set in
//      the file "fw_inc_misc" as are the gold modifiers.
//
// VERSION 1.1 
// - 27 July 2007.  I updated the function FW_Get_Random_Trap to account
//      for CR sliding scale.  I also updated the function declarations
//      to account for the CR being passed in as a variable.
//
// - 29 July 2007.  I added functions to get metal types and wood types.
//      I updated the functions FW_Get_Random_Weapon_Simple and 
//      FW_Get_Random_Weapon_Martial to account for other metal and wood 
//      types instead of just generic items.  I also added two functions
//      that handle exotic and ranged weapons and the different types of
//      materials for those.

// *****************************************
//
//              INCLUDED FILES
//
// *****************************************
// I need the item property functions.
#include "x2_inc_itemprop"

// I need all the constants and switches.
#include "fw_inc_loot_switches"

// I need the probability tables.
#include "fw_inc_probability_tables_misc"
// I need race probability tables too.
#include "fw_inc_probability_tables_races"

// I need the CR scaling constants
#include "fw_inc_cr_scaling_constants"
// I need the CR scaling formulas
#include "fw_inc_cr_scaling_formulas"

// I need the gold values.
#include "fw_inc_misc"

// I need MyStruct
#include "fw_inc_struct"


// *****************************************
//
//              FUNCTION DECLARATIONS
//
// *****************************************

////////////////////////////////////////////
// * Function that chooses a random metal armor and returns it.
// -nArmorType is a constant of type: FW_ARMOR_*_*2, where * = HEAVY,
//  MEDIUM, or LIGHT and where *2 = one of the metal types of armor 
//  (i.e. Breastplate and FullPlate, but not hide or leather, etc.)
//
object FW_Get_Random_Metal_Armor (object oTarget, int nArmorType);

////////////////////////////////////////////
// * Function that chooses a random book and returns it.
//
object FW_Get_Random_Book (object oTarget, struct MyStruct strStruct);

////////////////////////////////////////////
// * Function that chooses a random crafting material and returns it.
//
object FW_Get_Random_Crafting_Material (object oTarget, struct MyStruct strStruct);

////////////////////////////////////////////
// * Function that chooses a random crafting ALCHEMY material and returns it.
//
object FW_Get_Random_Crafting_Alchemy (object oTarget);

////////////////////////////////////////////
// * Function that chooses a random crafting BASIC material and returns it.
//
object FW_Get_Random_Crafting_Basic (object oTarget);

////////////////////////////////////////////
// * Function that chooses a random crafting DISTILLABLE material and returns it.
//
object FW_Get_Random_Crafting_Distillable (object oTarget);

////////////////////////////////////////////
// * Function that chooses a random crafting ESSENCES material and returns it.
//
object FW_Get_Random_Crafting_Essence (object oTarget);

////////////////////////////////////////////
// * Function that chooses a random crafting MOLD material and returns it.
//
object FW_Get_Random_Crafting_Mold (object oTarget);

////////////////////////////////////////////
// * Function that chooses a random crafting TRADESKILL material and returns it.
//
object FW_Get_Random_Crafting_Tradeskill (object oTarget);

////////////////////////////////////////////
// * Function that chooses a random gem and returns it.
//
object FW_Get_Random_Gem (object oTarget, struct MyStruct strStruct);

////////////////////////////////////////////
// * Function that chooses a random amount of gold based off 
// * creature rating.  This scales with CR.
//
object FW_Get_Random_Gold (object oTarget, int nCR = 0, int min = FW_MIN_MODULE_GOLD, int max = FW_MAX_MODULE_GOLD);

////////////////////////////////////////////
// * Function that chooses a random heal kit and returns it.
//
object FW_Get_Random_Heal_Kit (object oTarget, struct MyStruct strStruct);

////////////////////////////////////////////
// * Function that chooses a random end-user custom item
// * and returns it.
//
object FW_Get_Random_Misc_Custom_Item (object oTarget, struct MyStruct strStruct);

////////////////////////////////////////////
// * Function that chooses a random piece of equippable item that a damage
// * shield will be added to.
// - This function also adds the "Unique Power Self Only: One Use Per Day"
//   item property to the returning item.
//
object FW_Get_Random_Misc_Damage_Shield_Item (object oTarget, struct MyStruct strStruct);

////////////////////////////////////////////
// * Function that chooses a random item from the misc | other
// * category and returns it.
//
object FW_Get_Random_Misc_Other (object oTarget, struct MyStruct strStruct);

////////////////////////////////////////////
// * Function that chooses a random potion and returns it.
//
object FW_Get_Random_Potion (object oTarget, struct MyStruct strStruct);

////////////////////////////////////////////
// * Function that chooses a random scroll and returns it.
//
object FW_Get_Random_Scroll (object oTarget, struct MyStruct strStruct);

////////////////////////////////////////////
// * Function that chooses a random trap and returns it.
// - min and max are determined by end-user constants. Translates as follows:
//   0 = Minor, 1 = Average, 2 = Strong, 3 = Deadly, 4 = Epic
// - nCR is the creature rating of the spawning monster and is used to
//   determine the level of trap that a monster spawns.
//
object FW_Get_Random_Trap (object oTarget ,struct MyStruct strStruct, int nCR = 0);

////////////////////////////////////////////
// * Function that chooses a random rod and returns it.
// * Rods do not have use limitations like wands do.  And rods
// * have a charges per use variable.
//
object FW_Get_Random_Rod (struct MyStruct strStruct);

////////////////////////////////////////////
// * Function that chooses a random wand and returns it.
//
object FW_Get_Random_Wand (struct MyStruct strStruct);

////////////////////////////////////////////
// * Function that iterates through all the types of exotic weapons and chooses
// * one randomly. Does not choose thrown or ranged weapons though.
//
object FW_Get_Random_Weapon_Exotic(object oTarget);

////////////////////////////////////////////
// * Function that iterates through all the types of simple weapons and chooses
// * one randomly. Does not choose thrown or ranged weapons though.
//
object FW_Get_Random_Weapon_Simple(object oTarget);

////////////////////////////////////////////
// * Function that iterates through all the types of martial weapons and chooses
// * one randomly. Does not choose thrown or ranged weapons though.
//
object FW_Get_Random_Weapon_Martial(object oTarget);


// *****************************************
//
//              IMPLEMENTATION
//
// *****************************************

////////////////////////////////////////////
// * Function that chooses a random metal armor and returns it.
// -nArmorType is a constant of type: FW_ARMOR_*_*2, where * = HEAVY,
//  MEDIUM, or LIGHT and where *2 = one of the metal types of armor 
//  (i.e. Breastplate and FullPlate, but not hide or leather, etc.)
//
object FW_Get_Random_Metal_Armor (object oTarget, int nArmorType)
{
	int nMaterial = FW_WhatMetalArmorMaterial();
	object oItem;
	
	switch (nArmorType)
	{
		case FW_ARMOR_HEAVY_BANDED:
			if      (nMaterial == FW_MATERIAL_NON_SPECIFIC) { oItem = CreateItemOnObject ("fw_itm_armor_generic_bandedmail", oTarget);    }
			else if (nMaterial == FW_MATERIAL_ADAMANTINE)	{ oItem = CreateItemOnObject ("mwa_hvbm_ada_3", oTarget);     }
			else if (nMaterial == FW_MATERIAL_DARK_STEEL)	{ oItem = CreateItemOnObject ("mwa_hvbm_drk_3", oTarget);     }
			else if (nMaterial == FW_MATERIAL_IRON) 		{ oItem = CreateItemOnObject ("nw_aarcl011", oTarget);        }
			else  /* nMaterial == FW_MATERIAL_MITHRAL */    { oItem = CreateItemOnObject ("mwa_hvbm_mth_3", oTarget);     }
			
			break;
		
		case FW_ARMOR_HEAVY_FULLPLATE:
			if      (nMaterial == FW_MATERIAL_NON_SPECIFIC) { oItem = CreateItemOnObject ("fw_itm_armor_generic_fullplate", oTarget);     }
			else if (nMaterial == FW_MATERIAL_ADAMANTINE)	{ oItem = CreateItemOnObject ("mwa_hvfp_ada_4", oTarget);     }
			else if (nMaterial == FW_MATERIAL_DARK_STEEL)	{ oItem = CreateItemOnObject ("mwa_hvfp_drk_3", oTarget);     }
			else if (nMaterial == FW_MATERIAL_IRON) 		{ oItem = CreateItemOnObject ("nw_aarcl007", oTarget);        }
			else  /* nMaterial == FW_MATERIAL_MITHRAL */    { oItem = CreateItemOnObject ("nw_aarcl007", oTarget);     }//Alex_Modify
					
			break;
			
		case FW_ARMOR_HEAVY_HALFPLATE:
			if      (nMaterial == FW_MATERIAL_NON_SPECIFIC) { oItem = CreateItemOnObject ("fw_itm_armor_generic_halfplate", oTarget);     }
			else if (nMaterial == FW_MATERIAL_ADAMANTINE)	{ oItem = CreateItemOnObject ("mwa_hvhp_ada_4", oTarget);     }
			else if (nMaterial == FW_MATERIAL_DARK_STEEL)	{ oItem = CreateItemOnObject ("mwa_hvhp_drk_3", oTarget);     }
			else if (nMaterial == FW_MATERIAL_IRON) 		{ oItem = CreateItemOnObject ("nw_aarcl006", oTarget);        }
			else  /* nMaterial == FW_MATERIAL_MITHRAL */    { oItem = CreateItemOnObject ("mwa_hvhp_mth_4", oTarget);     }
					
			break;
			
		case FW_ARMOR_LIGHT_CHAINSHIRT:
			if      (nMaterial == FW_MATERIAL_NON_SPECIFIC) { oItem = CreateItemOnObject ("fw_itm_armor_generic_chainshirt", oTarget);     }
			else if (nMaterial == FW_MATERIAL_ADAMANTINE)	{ oItem = CreateItemOnObject ("mwa_ltcs_ada_4", oTarget);     }
			else if (nMaterial == FW_MATERIAL_DARK_STEEL)	{ oItem = CreateItemOnObject ("mwa_ltcs_drk_3", oTarget);     }
			else if (nMaterial == FW_MATERIAL_IRON) 		{ oItem = CreateItemOnObject ("nw_aarcl012", oTarget);     }
			else  /* nMaterial == FW_MATERIAL_MITHRAL */    { oItem = CreateItemOnObject ("nw_aarcl012", oTarget);     }//Alex modify
				
			break;
			
		case FW_ARMOR_MEDIUM_BREASTPLATE:
			if      (nMaterial == FW_MATERIAL_NON_SPECIFIC) { oItem = CreateItemOnObject ("fw_itm_armor_generic_breastplate", oTarget);     }
			else if (nMaterial == FW_MATERIAL_ADAMANTINE)	{ oItem = CreateItemOnObject ("mwa_mdbp_ada_4", oTarget);     }
			else if (nMaterial == FW_MATERIAL_DARK_STEEL)	{ oItem = CreateItemOnObject ("mwa_mdbp_drk_3", oTarget);     }
			else if (nMaterial == FW_MATERIAL_IRON) 		{ oItem = CreateItemOnObject ("nw_aarcl010", oTarget);     }
			else  /* nMaterial == FW_MATERIAL_MITHRAL */    { oItem = CreateItemOnObject ("nw_aarcl010", oTarget);     }//Alex modify
				
			break;
			
		case FW_ARMOR_MEDIUM_CHAINMAIL:
			if      (nMaterial == FW_MATERIAL_NON_SPECIFIC) { oItem = CreateItemOnObject ("fw_itm_armor_generic_chainmail", oTarget);     }
			else if (nMaterial == FW_MATERIAL_ADAMANTINE)	{ oItem = CreateItemOnObject ("mwa_mdcm_ada_4", oTarget);     }
			else if (nMaterial == FW_MATERIAL_DARK_STEEL)	{ oItem = CreateItemOnObject ("mwa_mdcm_drk_3", oTarget);     }
			else if (nMaterial == FW_MATERIAL_IRON) 		{ oItem = CreateItemOnObject ("nw_aarcl004", oTarget);     }
			else  /* nMaterial == FW_MATERIAL_MITHRAL */    { oItem = CreateItemOnObject ("mwa_mdcm_mth_4", oTarget);     }
				
			break;
			
		case FW_ARMOR_MEDIUM_SCALEMAIL:
			if      (nMaterial == FW_MATERIAL_NON_SPECIFIC) { oItem = CreateItemOnObject ("fw_itm_armor_generic_scalemail", oTarget);     }
			else if (nMaterial == FW_MATERIAL_ADAMANTINE)	{ oItem = CreateItemOnObject ("mwa_mdsm_ada_4", oTarget);     }
			else if (nMaterial == FW_MATERIAL_DARK_STEEL)	{ oItem = CreateItemOnObject ("mwa_mdsm_drk_3", oTarget);     }
			else if (nMaterial == FW_MATERIAL_IRON) 		{ oItem = CreateItemOnObject ("nw_aarcl003", oTarget);     }
			else  /* nMaterial == FW_MATERIAL_MITHRAL */    { oItem = CreateItemOnObject ("mwa_mdsm_mth_4", oTarget);     }
				
			break;
			
		default: break;
	}
	return oItem;
}

////////////////////////////////////////////
// * Function that chooses a random book and returns it.
//
object FW_Get_Random_Book (object oTarget, struct MyStruct strStruct)
{		
	// Bioware's hard-coded systems do not allow for easy migration to NWN2 due
	// to an excess of hard-coded data values integrated with their logic. 
	// This is valid in NWN2, but not necessarily NWN1.
	int FW_MAX_NUM_ITEMS_BOOKS = 34;
   	int iBookRoll = Random(21) + 1;
			
		if (iBookRoll <= 17)
		{
			int iBook = Random(27) + 1;
			// highest book is 29, but 22 and 26 are skipped
			if (iBook>=22) iBook++;
			if (iBook>=26) iBook++;
			
        	string sRes = "n2_crft_book_recipe0";
        	if (iBook < 10)
        	{
            	sRes = sRes + "0";
        	}
        	sRes = sRes + IntToString(iBook);        	
			strStruct.oItem = CreateItemOnObject(sRes, oTarget);
		}
		else if ((iBookRoll >= 18) && (iBookRoll <= 20))
		{
			//int nBook1 = Random(34) + 1;	// totally awesome magic numbers, guys!;
            int nBook1 = Random(FW_MAX_NUM_ITEMS_BOOKS ) + 1;
        	string sRes = "NW_IT_BOOK0";
       		if (nBook1 < 10)
        	{
            	sRes = sRes + "0" + IntToString(nBook1);
        	}
        	else if ((nBook1 >= 10) && (nBook1 <= 32))
        	{
            	sRes = sRes + IntToString(nBook1);
        	}
			// new stuff from MotB added here.
			else // rolled a 33 or 34
			{
				int iBook123 = Random(2);
				if (iBook123 == 0)
				{
					sRes = "nx1_book_of_waves";
				}
				else // (iBook123 == 1)
				{
					sRes = "x1_it_mbook001";
				}			
			}
        	strStruct.oItem = CreateItemOnObject(sRes, oTarget);
		}
		else  // iBookRoll = 21.
		{
			strStruct.oItem = CreateItemOnObject ("fw_misc_book_cdaulepp_tribute", oTarget);		
		}
	return strStruct.oItem;
}

////////////////////////////////////////////
// * Function that chooses a random crafting material and returns it.
//
object FW_Get_Random_Crafting_Material (object oTarget, struct MyStruct strStruct)
{	
	int nRoll = Random (6) + 1;
	switch (nRoll)
	{
		case 1: strStruct.oItem = FW_Get_Random_Crafting_Alchemy(oTarget);
			break;
		case 2: strStruct.oItem = FW_Get_Random_Crafting_Basic(oTarget);
			break;
		case 3: strStruct.oItem = FW_Get_Random_Crafting_Distillable(oTarget);
			break;
		case 4: strStruct.oItem = FW_Get_Random_Crafting_Essence(oTarget);
			break;
		case 5: strStruct.oItem = FW_Get_Random_Crafting_Mold(oTarget);
			break;
		case 6: strStruct.oItem = FW_Get_Random_Crafting_Tradeskill(oTarget);
			break;
			
		default: break;
	}
	return strStruct.oItem;
}

////////////////////////////////////////////
// * Function that chooses a random crafting ALCHEMY material and returns it.
//
object FW_Get_Random_Crafting_Alchemy (object oTarget)
{
	object oItem;
	int nRoll = Random (11) + 1;
	switch (nRoll)
	{
		case 1: oItem = CreateItemOnObject ("nw_it_msmlmisc23", oTarget);
			break;
		case 2: oItem = CreateItemOnObject ("n2_alc_dmnddust", oTarget);
			break;
		case 3: oItem = CreateItemOnObject ("n2_alc_disalcohol", oTarget);
			break;
		case 4: oItem = CreateItemOnObject ("nw_it_msmlmisc19", oTarget);
			break;
		case 5: oItem = CreateItemOnObject ("nw_it_msmlmisc24", oTarget);
			break;
		case 6: oItem = CreateItemOnObject ("n2_alc_beegland", oTarget);
			break;	
		case 7: oItem = CreateItemOnObject ("n2_alc_centgland", oTarget);
			break;
		case 8: oItem = CreateItemOnObject ("n2_alc_scorpgland", oTarget);
			break;
		case 9: oItem = CreateItemOnObject ("n2_alc_powsilver", oTarget);
			break;
		case 10: oItem = CreateItemOnObject ("n2_alc_quicksilver", oTarget);
			break;
		case 11: oItem = CreateItemOnObject ("n2_alc_venomgland", oTarget);
			break;			
			
		default: break;
	}
	return oItem;
}

////////////////////////////////////////////
// * Function that chooses a random crafting BASIC material and returns it.
//
object FW_Get_Random_Crafting_Basic (object oTarget)
{
	object oItem;
	int nRoll = Random (22) + 1;
	switch (nRoll)
	{
		case 1: oItem = CreateItemOnObject ("mortar", oTarget);
			break;
		case 2: oItem = CreateItemOnObject ("smithhammer", oTarget);
			break;
		case 3: oItem = CreateItemOnObject ("n2_crft_ingadamant", oTarget);
			break;
		case 4: oItem = CreateItemOnObject ("n2_crft_ingsilver", oTarget);
			break;
		case 5: oItem = CreateItemOnObject ("n2_crft_ingcldiron", oTarget);
			break;
		case 6: oItem = CreateItemOnObject ("n2_crft_ingdrksteel", oTarget);
			break;	
		case 7: oItem = CreateItemOnObject ("n2_crft_plkdskwood", oTarget);
			break;
		case 8: oItem = CreateItemOnObject ("n2_crft_ingiron", oTarget);
			break;
		case 9: oItem = CreateItemOnObject ("n2_crft_hideleather", oTarget);
			break;
		case 10: oItem = CreateItemOnObject ("n2_crft_ingmithral", oTarget);
			break;
		case 11: oItem = CreateItemOnObject ("n2_crft_hidedragon", oTarget);
			break;
		case 12: oItem = CreateItemOnObject ("n2_crft_hidesalam", oTarget);
			break;
		case 13: oItem = CreateItemOnObject ("n2_crft_plkshed", oTarget);
			break;
		case 14: oItem = CreateItemOnObject ("n2_crft_hideumber", oTarget);
			break;
		case 15: oItem = CreateItemOnObject ("n2_crft_plkwood", oTarget);
			break;
		case 16: oItem = CreateItemOnObject ("n2_crft_hidewyvern", oTarget);
			break;	
		case 17: oItem = CreateItemOnObject ("n2_crft_plkzalantar", oTarget);
			break;	
		case 18: oItem = CreateItemOnObject ("nx1_crft_broken_scythe", oTarget);
			break;	
		case 19: oItem = CreateItemOnObject ("nx1_container01", oTarget);
			break;	
		case 20: oItem = CreateItemOnObject ("nx1_crft_hulmarra_emerald", oTarget);
			break;	
		case 21: oItem = CreateItemOnObject ("nx1_crft_charred_branch", oTarget);
			break;	
		case 22: oItem = CreateItemOnObject ("nx1_crft_shapers_alembic", oTarget);
			break;			
		default: break;
	}
	return oItem;
}

////////////////////////////////////////////
// * Function that chooses a random crafting DISTILLABLE material and returns it.
//
object FW_Get_Random_Crafting_Distillable (object oTarget)
{
	object oItem;
	int nRoll = Random (39) + 1;
	// item number n2_crft_dist013 seems not to be in the list, so
	// if we roll a 13 we create #14. This makes 14 appear slightly
	// more often than others, but oh well.  Only a 2% chance more of 
	// #14 than anything else.
	if (nRoll == 13)
	   nRoll++;
	string sMaterial = IntToString(nRoll);
	string sResRef = "n2_crft_dist0" + sMaterial;
	oItem = CreateItemOnObject (sResRef, oTarget);	
	return oItem;
}

////////////////////////////////////////////
// * Function that chooses a random crafting ESSENCES material and returns it.
//
object FW_Get_Random_Crafting_Essence (object oTarget)
{
	object oItem;
	// When MotB came out, new essences were added.
	
	string sResRef;
	int nOrigVsExp = Random (7) + 1;
	
	// Roll of 1-4 gets an original essence. 
	if (nOrigVsExp <= 4)
	{
    	int nElement = Random (5) + 1;
		string sElement;
		switch (nElement)
		{
			case 1: sElement = "air";  break;
			case 2: sElement = "earth"; break;
			case 3: sElement = "fire"; break;
			case 4: sElement = "power"; break;
			case 5: sElement = "water"; break;
		
			default: break;
		}
		// There are 4 categories of essences in the original.
		int nType = Random (4) + 1;
		sResRef = "cft_ess_" + sElement + IntToString(nType);
	}
	
	else  // Roll of 5-7 gets an exp1 (MotB) essence.
	{
		// Mask of the Betrayer added "spirit" essences.
		int nElement = Random (6) + 1;
		string sElement;
		switch (nElement)
		{
			case 1: sElement = "air";  break;
			case 2: sElement = "earth"; break;
			case 3: sElement = "fire"; break;
			case 4: sElement = "power"; break;
			case 5: sElement = "water"; break;
			case 6: sElement = "spirit"; break;
		
			default: break;
		}
		// Mask of the Betrayer added 3 categories.
		// Brilliant, Pristine, and Volatile
		int nType = Random (3) + 1;
	    sResRef = "nx1_cft_ess_" + sElement + "0" + IntToString(nType); 	
	}
	oItem = CreateItemOnObject (sResRef, oTarget);
	return oItem;
}

////////////////////////////////////////////
// * Function that chooses a random crafting MOLD material and returns it.
//
object FW_Get_Random_Crafting_Mold (object oTarget)
{
	object oItem;
	int nRoll = Random (46) + 1;
	switch (nRoll)
	{
		case 1: oItem = CreateItemOnObject ("n2_crft_mold_hvbm", oTarget);
			break;
		case 2: oItem = CreateItemOnObject ("n2_crft_mold_swbs", oTarget);
			break;
		case 3: oItem = CreateItemOnObject ("n2_crft_mold_axbt", oTarget);
			break;
		case 4: oItem = CreateItemOnObject ("n2_crft_mold_mdbp", oTarget);
			break;
		case 5: oItem = CreateItemOnObject ("n2_crft_mold_ltcs", oTarget);
			break;
		case 6: oItem = CreateItemOnObject ("n2_crft_mold_mdcm", oTarget);
			break;	
		case 7: oItem = CreateItemOnObject ("n2_crft_mold_blcl", oTarget);
			break;
		case 8: oItem = CreateItemOnObject ("n2_crft_mold_swdg", oTarget);
			break;
		case 9: oItem = CreateItemOnObject ("n2_crft_mold_axdv", oTarget);
			break;
		case 10: oItem = CreateItemOnObject ("n2_crft_mold_swfl", oTarget);
			break;
		case 11: oItem = CreateItemOnObject ("n2_crft_mold_blfl", oTarget);
			break;
		case 12: oItem = CreateItemOnObject ("n2_crft_mold_hvfp", oTarget);
			break;
		case 13: oItem = CreateItemOnObject ("n2_crft_mold_axgr", oTarget);
			break;
		case 14: oItem = CreateItemOnObject ("n2_crft_mold_swgs", oTarget);
			break;
		case 15: oItem = CreateItemOnObject ("n2_crft_mold_plhb", oTarget);
			break;
		case 16: oItem = CreateItemOnObject ("n2_crft_mold_hvhp", oTarget);
			break;	
		case 17: oItem = CreateItemOnObject ("n2_crft_mold_axhn", oTarget);
			break;
		case 18: oItem = CreateItemOnObject ("n2_crft_mold_bwxh", oTarget);
			break;	
		case 19: oItem = CreateItemOnObject ("n2_crft_mold_shhv", oTarget);
			break;
		case 20: oItem = CreateItemOnObject ("n2_crft_mold_mdhd", oTarget);
			break;
		case 21: oItem = CreateItemOnObject ("n2_crft_mold_spka", oTarget);
			break;
		case 22: oItem = CreateItemOnObject ("n2_crft_mold_ltlt", oTarget);
			break;
		case 23: oItem = CreateItemOnObject ("n2_crft_mold_bwxl", oTarget);
			break;
		case 24: oItem = CreateItemOnObject ("n2_crft_mold_blhl", oTarget);
			break;
		case 25: oItem = CreateItemOnObject ("n2_crft_mold_shlt", oTarget);
			break;
		case 26: oItem = CreateItemOnObject ("n2_crft_mold_bwln", oTarget);
			break;	
		case 27: oItem = CreateItemOnObject ("n2_crft_mold_swls", oTarget);
			break;
		case 28: oItem = CreateItemOnObject ("n2_crft_mold_blml", oTarget);
			break;
		case 29: oItem = CreateItemOnObject ("n2_crft_mold_blms", oTarget);
			break;
		case 30: oItem = CreateItemOnObject ("n2_crft_mold_ltpd", oTarget);
			break;
		case 31: oItem = CreateItemOnObject ("n2_crft_mold_dbqs", oTarget);
			break;
		case 32: oItem = CreateItemOnObject ("n2_crft_mold_swrp", oTarget);
			break;
		case 33: oItem = CreateItemOnObject ("n2_crft_mold_mdsm", oTarget);
			break;
		case 34: oItem = CreateItemOnObject ("n2_crft_mold_swsc", oTarget);
			break;
		case 35: oItem = CreateItemOnObject ("n2_crft_mold_plsc", oTarget);
			break;
		case 36: oItem = CreateItemOnObject ("n2_crft_mold_swss", oTarget);
			break;	
		case 37: oItem = CreateItemOnObject ("n2_crft_mold_bwsh", oTarget);
			break;
		case 38: oItem = CreateItemOnObject ("n2_crft_mold_spsc", oTarget);
			break;
		case 39: oItem = CreateItemOnObject ("n2_crft_mold_plss", oTarget);
			break;
		case 40: oItem = CreateItemOnObject ("n2_crft_mold_ltsl", oTarget);
			break;
		case 41: oItem = CreateItemOnObject ("n2_crft_mold_shtw", oTarget);
			break;
		case 42: oItem = CreateItemOnObject ("n2_crft_mold_trap", oTarget);
			break;
		case 43: oItem = CreateItemOnObject ("n2_crft_mold_blhw", oTarget);
			break;
		case 44: oItem = CreateItemOnObject ("n2_crft_mold_bldm", oTarget);
			break;
		case 45: oItem = CreateItemOnObject ("n2_crft_mold_swka", oTarget);
			break;
		case 46: oItem = CreateItemOnObject ("n2_crft_mold_spku", oTarget);
			break;	
			
		default: break;
	}
	return oItem;
}

////////////////////////////////////////////
// * Function that chooses a random crafting TRADESKILL material and returns it.
//
object FW_Get_Random_Crafting_Tradeskill (object oTarget)
{
	object oItem;
	int nRoll = Random (17) + 1;
	switch (nRoll)
	{
		case 1: oItem = CreateItemOnObject ("x2_it_cfm_bscrl", oTarget);
			break;
		case 2: oItem = CreateItemOnObject ("x2_it_cfm_wand", oTarget); 
			break;
		case 3: oItem = CreateItemOnObject ("x2_it_poison021", oTarget); 
			break;
		case 4: oItem = CreateItemOnObject ("x2_it_poison039", oTarget);
			break;
		case 5: oItem = CreateItemOnObject ("x2_it_poison015", oTarget);
			break;
		case 6: oItem = CreateItemOnObject ("x2_it_poison027", oTarget);
			break;
		case 7: oItem = CreateItemOnObject ("x2_it_poison020", oTarget); 
			break;
		case 8: oItem = CreateItemOnObject ("x2_it_poison038", oTarget); 
			break;
		case 9: oItem = CreateItemOnObject ("x2_it_poison014", oTarget);
			break;
		case 10: oItem = CreateItemOnObject ("x2_it_poison026", oTarget);
			break;
		case 11: oItem = CreateItemOnObject ("x2_it_poison019", oTarget);
			break;
		case 12: oItem = CreateItemOnObject ("x2_it_poison037", oTarget); 
			break;
		case 13: oItem = CreateItemOnObject ("x2_it_poison013", oTarget); 
			break;
		case 14: oItem = CreateItemOnObject ("x2_it_poison025", oTarget);
			break;
		case 15: oItem = CreateItemOnObject ("x2_it_pcpotion", oTarget);
			break;
		case 16: oItem = CreateItemOnObject ("x2_it_pcwand", oTarget);
			break;
		case 17: oItem = CreateItemOnObject ("x2_it_cfm_pbottl", oTarget); 
			break;		
			
		default: break;
	}
	return oItem;
}

////////////////////////////////////////////
// * Function that chooses a random gem and returns it.
//
object FW_Get_Random_Gem (object oTarget, struct MyStruct strStruct)
{
	int nRoll = Random (24);
	switch (nRoll)
	{   
		case 0: strStruct.oItem = CreateItemOnObject("nw_it_gem013", oTarget);
		   break;
		case 1: strStruct.oItem = CreateItemOnObject("nw_it_gem003", oTarget);
		   break;
		case 2: strStruct.oItem = CreateItemOnObject("nw_it_gem014", oTarget);
		   break;
		case 3: strStruct.oItem = CreateItemOnObject("nw_it_gem005", oTarget);
		   break;
		case 4: strStruct.oItem = CreateItemOnObject("nw_it_gem012", oTarget);
		   break;
		case 5: strStruct.oItem = CreateItemOnObject("nw_it_gem002", oTarget);
		   break;
		case 6: strStruct.oItem = CreateItemOnObject("nw_it_gem009", oTarget);
		   break;
		case 7: strStruct.oItem = CreateItemOnObject("nw_it_gem015", oTarget);
		   break;
		case 8: strStruct.oItem = CreateItemOnObject("nw_it_gem011", oTarget);
		   break;
		case 9: strStruct.oItem = CreateItemOnObject("nw_it_gem001", oTarget);
		   break;
		case 10: strStruct.oItem = CreateItemOnObject("nw_it_gem007", oTarget);
		   break;
		case 11: strStruct.oItem = CreateItemOnObject("nw_it_gem004", oTarget);
		   break;
		case 12: strStruct.oItem = CreateItemOnObject("nw_it_gem006", oTarget);
		   break;
		case 13: strStruct.oItem = CreateItemOnObject("nw_it_gem008", oTarget);
		   break;
		case 14: strStruct.oItem = CreateItemOnObject("nw_it_gem010", oTarget);
		   break;
		case 15: strStruct.oItem = CreateItemOnObject("cft_gem_14", oTarget);
		   break;
		case 16: strStruct.oItem = CreateItemOnObject("cft_gem_01", oTarget);
		   break;
		case 17: strStruct.oItem = CreateItemOnObject("cft_gem_12", oTarget);
		   break;
		case 18: strStruct.oItem = CreateItemOnObject("cft_gem_09", oTarget);
		   break;
		case 19: strStruct.oItem = CreateItemOnObject("cft_gem_11", oTarget);
		   break;
		case 20: strStruct.oItem = CreateItemOnObject("cft_gem_15", oTarget);
		   break;
		case 21: strStruct.oItem = CreateItemOnObject("cft_gem_03", oTarget);
		   break;
		case 22: strStruct.oItem = CreateItemOnObject("cft_gem_13", oTarget);
		   break;
		case 23: strStruct.oItem = CreateItemOnObject("cft_gem_10", oTarget);
		   break;
		default: break;
	} // end of switch	
	return strStruct.oItem;
}

////////////////////////////////////////////
// * Function that chooses a random amount of gold based off 
// * creature rating.  This scales with CR.
//
object FW_Get_Random_Gold (object oTarget, int nCR = 0, int min = FW_MIN_MODULE_GOLD, int max = FW_MAX_MODULE_GOLD)
{
    // CR is used for sliding scale and probabilities.
	
	int nUpperRange = FloatToInt(FW_MAX_GOLD_MODIFIER * IntToFloat(nCR));
	int nLowerRange = FloatToInt(FW_MIN_GOLD_MODIFIER * IntToFloat(nCR));	
	
	int nReturnValue;	
	int nValue = nUpperRange - nLowerRange + 1;
    nReturnValue = Random(nValue) + nLowerRange;

	if (nReturnValue < min)
	   nReturnValue = min;
	if (nReturnValue > max)
	   nReturnValue = max;
	  
	object oGold = CreateItemOnObject("NW_IT_GOLD001", oTarget, nReturnValue);
	return oGold;
}

////////////////////////////////////////////
// * Function that chooses a random heal kit and returns it.
//
object FW_Get_Random_Heal_Kit (object oTarget, struct MyStruct strStruct)
{
	int nRoll = Random (4);
	switch (nRoll)
	{
		case 0: strStruct.oItem = CreateItemOnObject ("nw_it_medkit001", oTarget);
			break;
		case 1: strStruct.oItem = CreateItemOnObject ("nw_it_medkit002", oTarget);
			break;
		case 2: strStruct.oItem = CreateItemOnObject ("nw_it_medkit003", oTarget);
			break;
		case 3: strStruct.oItem = CreateItemOnObject ("nw_it_medkit004", oTarget);
			break;	
		default: break;
	}
	return strStruct.oItem;
}

////////////////////////////////////////////
// * Function that chooses a random end-user custom item
// * and returns it.
//
object FW_Get_Random_Misc_Custom_Item (object oTarget, struct MyStruct strStruct)
{
	// Each time you add more items to this function you need to update
	// the value of the integer 'nTotalNumItems'.  By default it is set
	// to 0 until you put in some of your own custom items.  For example,
	// If I have 3 custom items, then 'nTotalNumItems' should be set = 3;
	// If I have 10 custom items, it should be set = 10; And so forth. 
	// Don't forget to update this value or else the random generator
	// won't roll your custom items.
	int nTotalNumItems = 0;
	
	int nRoll = Random (nTotalNumItems) + 1;	
	switch (nRoll)
	{
	
		// Here is an example of exactly how you would add your custom
		// item(s).  Find out what the ResRef of your custom item
		// is by looking at its properties in the toolset.
		
		// In this example, we'll say the custom item I want added to be
		// part of the random loot generator has a ResRef = custom_item_1
		// I've shown below exactly what the line should look like so that
		// your item will become available.
		
		case 1:  // strStruct.oItem = CreateItemOnObject ("custom_item_1", oTarget);
			break;
			
		// Did you see how I did that?  If you need more examples, 
		// just scroll up to the Get_Random_Heal_Kit function above this
		// one to see another example of how it works. 
		
		case 2:  // strStruct.oItem = CreateItemOnObject ("custom_item_2", oTarget); 
			break;
		case 3:  // strStruct.oItem = CreateItemOnObject ("custom_item_3", oTarget);
			break;
		case 4:  // strStruct.oItem = CreateItemOnObject ("custom_item_4", oTarget);
			break;
		case 5:  // strStruct.oItem = CreateItemOnObject ("custom_item_5", oTarget);
			break;
		case 6:  // strStruct.oItem = CreateItemOnObject ("custom_item_6", oTarget);
			break;
		/*		
		// You should have one case statement for each custom item.
		// Continue with as many case statements as you need.
		
		case 7:  // strStruct.oItem = CreateItemOnObject ("custom_item_7", oTarget);
			break;
		.
		.
		.
		case nth // strStruct.oItem = CreateItemOnObject ("custom_item_nth", oTarget);
			break;		
		*/
		
		default: break;
	}
	return strStruct.oItem;
}

////////////////////////////////////////////
// * Function that chooses a random piece of equippable item that a damage
// * shield will be added to.
// - This function also adds the "Unique Power Self Only: One Use Per Day"
//   item property to the returning item.
//
object FW_Get_Random_Misc_Damage_Shield_Item (object oTarget, struct MyStruct strStruct)
{
	itemproperty ipAdd;
			
	int nRoll = Random (15) + 1;
	switch (nRoll)
	{
		case 1: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_shield_generic_ligh" , oTarget, 1, "fw_damage_shield");
			break;
		case 2: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_shield_generic_heav" , oTarget, 1, "fw_damage_shield");
			break;
		case 3: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_shield_generic_towe" , oTarget, 1, "fw_damage_shield");
			break;
		case 4: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_clothes" , oTarget, 1, "fw_damage_shield");
			break;
		case 5: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_bandedmail" , oTarget, 1, "fw_damage_shield");
			break;
		case 6: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_halfplate" , oTarget, 1, "fw_damage_shield");
			break;
		case 7: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_fullplate" , oTarget, 1, "fw_damage_shield");
			break;		
		case 8: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_padded" , oTarget, 1, "fw_damage_shield");
			break;
		case 9: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_leather" , oTarget, 1, "fw_damage_shield");
			break;
		case 10: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_studded" , oTarget, 1, "fw_damage_shield");
			break;
		case 11: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_chainshirt" , oTarget, 1, "fw_damage_shield");
			break;
		case 12: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_hide" , oTarget, 1, "fw_damage_shield");
			break;
		case 13: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_scalemail" , oTarget, 1, "fw_damage_shield");
			break;
		case 14: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_chainmail" , oTarget, 1, "fw_damage_shield");
			break;
		case 15: strStruct.oItem = CreateItemOnObject ("fw_itm_armor_generic_breastplate" , oTarget, 1, "fw_damage_shield");
			break;
		
		default: break;
	} // end of switch
	
	// Check to see if damage shields are allowed or not. If they aren't allowed
	// we return the created item before adding the unique power activation 
	// item property.  Because we return before adding the activation property
	// the script that actually adds the damage shield would never fire if 
	// FW_ALLOW_DAMAGE_SHIELDS is set to FALSE because the onEventActivate would
	// never be an option for the PC to use.  
	if (FW_ALLOW_DAMAGE_SHIELDS == FALSE)
		return strStruct.oItem;
	// If damage shields are allowed, we need to add the activation property
	// unique power self only 1 time per day so the PC can activate the item
	// and cause the damage shield effect script (tag based) to fire.	
	ipAdd = ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY, IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY);
	IPSafeAddItemProperty (strStruct.oItem, ipAdd);
	
	// Set the description of the item, noting that it is of "GODLIKE RARE" quality
	// and give credit to cdaulepp for all his hard work!!!
	
	// As of 19 July 2007, it appears that SetDescription is broken.  I'm going to
	// send this to the PC as a message when they activate the item. Copying this
	// message over to file "i_fw_damage_shield_ac"
	// Whenever Obsidian fixes SetDescription, this will work!
	string sDescription;
	
	sDescription = "Long long ago, an ancient scholar named 'cdaulepp' sought knowledge where no one " +
		"had previously sought it.  His research lead him to discover a whole new " +
		"realm of defensive magical powers that he eventually learned to control.  " +
		"The Lesser and Greater Gods, unaware of this power's existence, had " +
		"not claimed it for their own portfolios.  Once mastered, cdaulepp used this power " +
		"to ascend to Godhood several millenia ago.  His magic portfolio, mainly of " +		
		"a defensive nature, was used to surround himself in a sphere of defensive " +
		"magical shields that protected him from the other Gods.  Legend has it that " +
		"artifacts dating from the time of cdaulepp's mortal existence and studies " +
		"still survive today.  Those artifacts, the rarest of all treasure, are " +
		"actually some of his experiments that failed.  These rejected items are " +
		"imbued with lesser versions of the defensive shields that cdaulepp uses " +
		"to protect himself.  If you should be so lucky as to be reading this message " +
		"it means you have found one of those rarest of rare artifacts.  Activate this " +
		"item and surround yourself in the power and protection of cdaulepp, the " +
		"ultimate master.";	
	
	DelayCommand(2.0, SetDescription (strStruct.oItem, sDescription));
	return strStruct.oItem;
}

////////////////////////////////////////////
// * Function that chooses a random item from the misc | other
// * category and returns it.
//
object FW_Get_Random_Misc_Other (object oTarget, struct MyStruct strStruct)
{
	int nRoll = Random (62) + 1;
	
	switch (nRoll)
	{
		case 1: strStruct.oItem = CreateItemOnObject ("nw_it_msmlmisc16", oTarget);
			break;
		case 2: strStruct.oItem = CreateItemOnObject ("x0_it_mmedmisc03", oTarget);
			break;
		case 3: strStruct.oItem = CreateItemOnObject ("nw_it_contain006", oTarget);
			break;
		case 4: strStruct.oItem = CreateItemOnObject ("nw_it_msmlmisc06", oTarget);
			break;
		case 5: strStruct.oItem = CreateItemOnObject ("x0_it_msmlmisc01", oTarget);
			break;
		case 6: strStruct.oItem = CreateItemOnObject ("x0_it_msmlmisc02", oTarget);
			break;
		case 7: strStruct.oItem = CreateItemOnObject ("n2_it_brokenitem", oTarget);
			break;
		case 8: strStruct.oItem = CreateItemOnObject ("x0_it_mmedmisc01", oTarget);
			break;
		case 9: strStruct.oItem = CreateItemOnObject ("x0_it_mthnmisc18", oTarget);
			break;
		case 10: strStruct.oItem = CreateItemOnObject ("x0_it_mthnmisc21", oTarget);
			break;
		case 11: strStruct.oItem = CreateItemOnObject ("x0_it_mthnmisc04", oTarget);
			break;
		case 12: strStruct.oItem = CreateItemOnObject ("x1_it_msmlmisc01", oTarget);
			break;
		case 13: strStruct.oItem = CreateItemOnObject ("x0_it_mthnmisc17", oTarget);
			break;
		case 14: strStruct.oItem = CreateItemOnObject ("n2_it_drum", oTarget);
			break;
		case 15: strStruct.oItem = CreateItemOnObject ("nw_it_mmidmisc02", oTarget);
			break;
		case 16: strStruct.oItem = CreateItemOnObject ("x0_it_mthnmisc05", oTarget);
			break;
		case 17: strStruct.oItem = CreateItemOnObject ("x0_it_mthnmisc06", oTarget);
			break;
		case 18: strStruct.oItem = CreateItemOnObject ("x0_it_mthnmisc13", oTarget);
			break;
		case 19: strStruct.oItem = CreateItemOnObject ("nw_it_thnmisc001", oTarget);
			break;
		case 20: strStruct.oItem = CreateItemOnObject ("nw_it_thnmisc002", oTarget);
			break;		
		case 21: strStruct.oItem = CreateItemOnObject ("nw_it_thnmisc003", oTarget);
			break;
		case 22: strStruct.oItem = CreateItemOnObject ("nw_it_thnmisc004", oTarget);
			break;
		case 23: strStruct.oItem = CreateItemOnObject ("x0_it_mthnmisc08", oTarget);
			break;
		case 24: strStruct.oItem = CreateItemOnObject ("nw_it_msmlmisc08", oTarget);
			break;
		case 25: strStruct.oItem = CreateItemOnObject ("nw_it_flute", oTarget);
			break;
		case 26: strStruct.oItem = CreateItemOnObject ("x0_it_mthnmisc15", oTarget);
			break;
		case 27: strStruct.oItem = CreateItemOnObject ("x0_it_msmlmisc03", oTarget);
			break;
		case 28: strStruct.oItem = CreateItemOnObject ("x0_it_msmlmisc04", oTarget);
			break;
		case 29: strStruct.oItem = CreateItemOnObject ("nw_it_gold001", oTarget);
			break;
		case 30: strStruct.oItem = CreateItemOnObject ("x0_it_mthnmisc14", oTarget);
			break;
		case 31: strStruct.oItem = CreateItemOnObject ("nw_it_contain005", oTarget);
			break;
		case 32: strStruct.oItem = CreateItemOnObject ("x0_it_msmlmisc06", oTarget);
			break;
		case 33: strStruct.oItem = CreateItemOnObject ("nw_it_msmlmisc18", oTarget);
			break;
		case 34: strStruct.oItem = CreateItemOnObject ("x0_it_mthnmisc10", oTarget);
			break;
		case 35: strStruct.oItem = CreateItemOnObject ("x0_it_mthnmisc11", oTarget);
			break;
		case 36: strStruct.oItem = CreateItemOnObject ("nw_it_contain003", oTarget);
			break;
		case 37: strStruct.oItem = CreateItemOnObject ("nw_it_lute", oTarget);
			break;
		case 38: strStruct.oItem = CreateItemOnObject ("x0_it_mthnmisc16", oTarget);
			break;
		case 39: strStruct.oItem = CreateItemOnObject ("nw_it_contain004", oTarget);
			break;
		case 40: strStruct.oItem = CreateItemOnObject ("nw_it_contain002", oTarget);
			break;
		case 41: strStruct.oItem = CreateItemOnObject ("nw_it_msmlmisc11", oTarget);
			break;
		case 42: strStruct.oItem = CreateItemOnObject ("nw_it_msmlmisc21", oTarget);
			break;
		case 43: strStruct.oItem = CreateItemOnObject ("nw_it_msmlmisc05", oTarget);
			break;
		case 44: strStruct.oItem = CreateItemOnObject ("nw_it_mmidmisc04", oTarget);
			break;
		case 45: strStruct.oItem = CreateItemOnObject ("n2_it_mmidmisc01", oTarget);
			break;
		case 46: strStruct.oItem = CreateItemOnObject ("nw_it_msmlmisc13", oTarget);
			break;
		case 47: strStruct.oItem = CreateItemOnObject ("nw_it_mmidmisc06", oTarget);
			break;
		case 48: strStruct.oItem = CreateItemOnObject ("n2_it_spoon", oTarget);
			break;
		case 49: strStruct.oItem = CreateItemOnObject ("nw_it_stein", oTarget);
			break;
		case 50: strStruct.oItem = CreateItemOnObject ("x2_it_msmlmisc05", oTarget);
			break;
		case 51: strStruct.oItem = CreateItemOnObject ("nw_it_picks001", oTarget);
			break;
		case 52: strStruct.oItem = CreateItemOnObject ("nw_it_picks002", oTarget);
			break;
		case 53: strStruct.oItem = CreateItemOnObject ("nw_it_picks003", oTarget);
			break;
		case 54: strStruct.oItem = CreateItemOnObject ("nw_it_picks004", oTarget);
			break;
		case 55: strStruct.oItem = CreateItemOnObject ("nw_it_torch001", oTarget);
			break;
		case 56: strStruct.oItem = CreateItemOnObject ("nx1_rodent_charm", oTarget);
			break;
		case 57: strStruct.oItem = CreateItemOnObject ("nx1_deea_pouch", oTarget);
			break;
		case 58: strStruct.oItem = CreateItemOnObject ("nx1_doldrum", oTarget);
			break;
		case 59: strStruct.oItem = CreateItemOnObject ("nx1_mandolin01", oTarget);
			break;
		case 60: strStruct.oItem = CreateItemOnObject ("nx1_malarite_totem", oTarget);
			break;
		case 61: strStruct.oItem = CreateItemOnObject ("nx1_orb_elem_summon", oTarget);
			break;
		case 62: strStruct.oItem = CreateItemOnObject ("nx1_telthori_totem", oTarget);
			break;
								
		default: break;		
	}
	return strStruct.oItem;
}

////////////////////////////////////////////
// * Function that chooses a random potion and returns it.
//
object FW_Get_Random_Potion (object oTarget, struct MyStruct strStruct)
{  
   itemproperty ipAdd;
   strStruct.oItem = CreateItemOnObject ("fw_itm_misc_generic_potion", oTarget);    
   int nReRoll = TRUE;
   int nDeletedMisprints = FALSE;
   
   while (nReRoll)
   {
      // There are 707 spells in NWN 2 as of 12 May 2008
	  int nSpell = Random (707);
	  switch (nSpell)
	  {
	     // this gets rid of all the spells that have potion use set to 1
		 // but shouldn't be. I.E. Ioun Stone, Dye Armor, Grenade Bombs, etc.
	     case 125: case 142: case 143: case 144: case 188: case 197: case 239: 
		 case 305: case 306: case 329: case 335: case 336: case 337: case 338: 
		 case 339: case 340: case 341: case 342: case 343: case 344: case 350:
		 case 351: case 353:
		 case 359: case 400: case 401: case 402: case 403: case 404: case 405: 
		 case 406: case 407: case 408: case 409: case 430: case 431: case 432:
		 case 433: case 434: case 435: case 436: case 437: case 460: case 490:
		 case 491: case 492: case 493: case 494: case 495: case 496: case 497:
		 case 498: case 499: case 500: case 513: case 526: case 527: case 528:
		 case 529: case 537: case 553: 
		 nDeletedMisprints = TRUE; break;		 
		 default: nDeletedMisprints = FALSE; break;	  
	  } // end of switch 	     
	   			
	  string sPotionUse = Get2DAString ("iprp_spells", "PotionUse", nSpell);
	  int nPotionUse = StringToInt (sPotionUse);
	  string s2DALabel = Get2DAString ("iprp_spells", "Label", nSpell);		
	  string sCheck = "";
      string s2DAName = Get2DAString ("iprp_spells", "Name", nSpell);
	  
	  // Gets the name of the spell from the .tlk file
	  string sName123 = GetStringByStrRef(StringToInt(Get2DAString("iprp_spells", "Name", nSpell)));

	  // Reroll if a deleted spell, or if not flagged for a potion.
      if (s2DAName == sCheck)
	  {  nReRoll = TRUE;  }
	  else if (nPotionUse == 0) 
	  {  nReRoll = TRUE;  }
	  else if (nDeletedMisprints)
      {  nReRoll = TRUE;  }
	  else
	  {   
	     nReRoll = FALSE;
		 strStruct.sName = "Potion of: " + sName123;
	     SetFirstName (strStruct.oItem, strStruct.sName);
		 // Now that we have a spell chosen that can be applied to a potion.	 
		 ipAdd = ItemPropertyCastSpell (nSpell, IP_CONST_CASTSPELL_NUMUSES_SINGLE_USE);
	  }  
	
   } // end of while   
   IPSafeAddItemProperty (strStruct.oItem, ipAdd);
   return strStruct.oItem;
} // end of function

////////////////////////////////////////////
// * Function that chooses a random scroll and returns it.
//
object FW_Get_Random_Scroll (object oTarget, struct MyStruct strStruct)
{
   itemproperty ipAdd;
   strStruct.oItem = CreateItemOnObject ("fw_itm_misc_generic_scroll", oTarget);    
   int nReRoll = TRUE;
   int nDeletedMisprints = FALSE;
   while (nReRoll)
   {
      // There are 708 spells in NWN 2 as of 12 May 2008.
	  int nSpell = Random (708);
	  switch (nSpell)
	  {
	  	 case 113: case 114: case 201: case 202: case 203: case 305: case 306:
		 case 314: case 315: case 316: case 317: case 318: case 319: case 320: 
	     case 329: case 330: case 331: case 332: case 335: case 336: case 337:
		 case 338: case 339: case 340: case 341: case 342: case 343: case 344: 
		 case 351: case 353: case 359: case 370: case 372: 
		 case 452: case 453: case 454: case 459: case 460: case 462: case 463:
		 case 465: case 468: case 469: case 470: case 471: case 478: 
		 case 490: case 491: case 492: case 493: case 494: case 495: case 496:
		 case 497: case 498: case 499: case 500: case 513: case 521: case 522:
		 case 523: case 524: case 526: case 527: case 536: case 537: case 538:
		 case 540: case 553: case 607: case 608: case 609: 
	     
		 nDeletedMisprints = TRUE; break;		 
		 default: nDeletedMisprints = FALSE; break;	  
	  } // end of switch 	     
	  	  
	  string s2DALabel = Get2DAString ("iprp_spells", "Label", nSpell);		
	  string sCheck = "";
      string s2DAName = Get2DAString ("iprp_spells", "Name", nSpell);
	  
	  // Gets the name of the spell from the .tlk file
	  string sName123 = GetStringByStrRef(StringToInt(Get2DAString("iprp_spells", "Name", nSpell)));
	  
	  // Reroll if a deleted spell, or if not flagged for general use.
      if (s2DAName == sCheck)
	  {  nReRoll = TRUE;  }	  
	  else if (nDeletedMisprints)
      {  nReRoll = TRUE;  }
	  else
	  {   
	     nReRoll = FALSE;
		 strStruct.sName = "Scroll of: " + sName123;
		 SetFirstName (strStruct.oItem, strStruct.sName);
		 // Now that we have a spell chosen that can be applied to a scroll.	 
		 ipAdd = ItemPropertyCastSpell (nSpell, IP_CONST_CASTSPELL_NUMUSES_SINGLE_USE);
		 
		 // We need to limit the use of the scroll to the appropriate classes
		 string sSpellIndex = Get2DAString ("iprp_spells", "SpellIndex", nSpell);
		 int nSpellIndex = StringToInt (sSpellIndex);
		 
		 itemproperty ipAddUseLimitation;		 
		 
		 string sBardCheck =  Get2DAString ("spells", "Bard", nSpellIndex);		 
		 if (sBardCheck == sCheck)  {  }
		 else
		 {
		 	ipAddUseLimitation = ItemPropertyLimitUseByClass (IP_CONST_CLASS_BARD);
			IPSafeAddItemProperty (strStruct.oItem, ipAddUseLimitation);
		 }
		 
		 string sClericCheck =  Get2DAString ("spells", "Cleric", nSpellIndex);
		 if (sClericCheck == sCheck)  {  }
		 else
		 {
		 	ipAddUseLimitation = ItemPropertyLimitUseByClass (IP_CONST_CLASS_CLERIC);
			IPSafeAddItemProperty (strStruct.oItem, ipAddUseLimitation);
		 }
		 
		 string sRangerCheck =  Get2DAString ("spells", "Ranger", nSpellIndex);
		 if (sRangerCheck == sCheck)  {  }
		 else
		 {
		 	ipAddUseLimitation = ItemPropertyLimitUseByClass (IP_CONST_CLASS_RANGER);
			IPSafeAddItemProperty (strStruct.oItem, ipAddUseLimitation);
		 }
		 
		 string sPaladinCheck =  Get2DAString ("spells", "Paladin", nSpellIndex);
		 if (sPaladinCheck == sCheck)  {  }
		 else
		 {
		 	ipAddUseLimitation = ItemPropertyLimitUseByClass (IP_CONST_CLASS_PALADIN);
			IPSafeAddItemProperty (strStruct.oItem, ipAddUseLimitation);
		 }
		 
		 string sDruidCheck =  Get2DAString ("spells", "Druid", nSpellIndex);
		 if (sDruidCheck == sCheck)  {  }
		 else
		 {
		 	ipAddUseLimitation = ItemPropertyLimitUseByClass (IP_CONST_CLASS_DRUID);
			IPSafeAddItemProperty (strStruct.oItem, ipAddUseLimitation);
		 }
		 
		 string sWiz_SorcCheck =  Get2DAString ("spells", "Wiz_Sorc", nSpellIndex);
		 if (sWiz_SorcCheck == sCheck)  {  }
		 else
		 {
		 	ipAddUseLimitation = ItemPropertyLimitUseByClass (IP_CONST_CLASS_SORCERER);
			IPSafeAddItemProperty (strStruct.oItem, ipAddUseLimitation);
			ipAddUseLimitation = ItemPropertyLimitUseByClass (IP_CONST_CLASS_WIZARD);
			IPSafeAddItemProperty (strStruct.oItem, ipAddUseLimitation);
		 }		 
	  } // end of else  
   } // end of while   
   IPSafeAddItemProperty (strStruct.oItem, ipAdd);
   return strStruct.oItem;
} // end of function

////////////////////////////////////////////
// * Function that chooses a random trap and returns it.
// - min and max are determined by end-user constants. Translates as follows:
//   0 = Minor, 1 = Average, 2 = Strong, 3 = Deadly, 4 = Epic
//
object FW_Get_Random_Trap (object oTarget, struct MyStruct strStruct, int nCR = 0)
{
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_TRAP_LEVEL_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_TRAP_LEVEL_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_TRAP_LEVEL_CR_0 ; max = FW_MAX_TRAP_LEVEL_CR_0 ;    break;
		
		case 1: min = FW_MIN_TRAP_LEVEL_CR_1 ; max = FW_MAX_TRAP_LEVEL_CR_1 ;    break;
		case 2: min = FW_MIN_TRAP_LEVEL_CR_2 ; max = FW_MAX_TRAP_LEVEL_CR_2 ;    break;
		case 3: min = FW_MIN_TRAP_LEVEL_CR_3 ; max = FW_MAX_TRAP_LEVEL_CR_3 ;    break;
   		case 4: min = FW_MIN_TRAP_LEVEL_CR_4 ; max = FW_MAX_TRAP_LEVEL_CR_4 ;    break;
		case 5: min = FW_MIN_TRAP_LEVEL_CR_5 ; max = FW_MAX_TRAP_LEVEL_CR_5 ;    break;
		case 6: min = FW_MIN_TRAP_LEVEL_CR_6 ; max = FW_MAX_TRAP_LEVEL_CR_6 ;    break;
   		case 7: min = FW_MIN_TRAP_LEVEL_CR_7 ; max = FW_MAX_TRAP_LEVEL_CR_7 ;    break;
		case 8: min = FW_MIN_TRAP_LEVEL_CR_8 ; max = FW_MAX_TRAP_LEVEL_CR_8 ;    break;
		case 9: min = FW_MIN_TRAP_LEVEL_CR_9 ; max = FW_MAX_TRAP_LEVEL_CR_9 ;    break;
   		case 10: min = FW_MIN_TRAP_LEVEL_CR_10 ; max = FW_MAX_TRAP_LEVEL_CR_10 ; break;
		
		case 11: min = FW_MIN_TRAP_LEVEL_CR_11 ; max = FW_MAX_TRAP_LEVEL_CR_11 ;  break;
		case 12: min = FW_MIN_TRAP_LEVEL_CR_12 ; max = FW_MAX_TRAP_LEVEL_CR_12 ;  break;
		case 13: min = FW_MIN_TRAP_LEVEL_CR_13 ; max = FW_MAX_TRAP_LEVEL_CR_13 ;  break;
   		case 14: min = FW_MIN_TRAP_LEVEL_CR_14 ; max = FW_MAX_TRAP_LEVEL_CR_14 ;  break;
		case 15: min = FW_MIN_TRAP_LEVEL_CR_15 ; max = FW_MAX_TRAP_LEVEL_CR_15 ;  break;
		case 16: min = FW_MIN_TRAP_LEVEL_CR_16 ; max = FW_MAX_TRAP_LEVEL_CR_16 ;  break;
   		case 17: min = FW_MIN_TRAP_LEVEL_CR_17 ; max = FW_MAX_TRAP_LEVEL_CR_17 ;  break;
		case 18: min = FW_MIN_TRAP_LEVEL_CR_18 ; max = FW_MAX_TRAP_LEVEL_CR_18 ;  break;
		case 19: min = FW_MIN_TRAP_LEVEL_CR_19 ; max = FW_MAX_TRAP_LEVEL_CR_19 ;  break;
   		case 20: min = FW_MIN_TRAP_LEVEL_CR_20 ; max = FW_MAX_TRAP_LEVEL_CR_20 ;  break;
   
   		case 21: min = FW_MIN_TRAP_LEVEL_CR_21 ; max = FW_MAX_TRAP_LEVEL_CR_21 ;  break;
		case 22: min = FW_MIN_TRAP_LEVEL_CR_22 ; max = FW_MAX_TRAP_LEVEL_CR_22 ;  break;
		case 23: min = FW_MIN_TRAP_LEVEL_CR_23 ; max = FW_MAX_TRAP_LEVEL_CR_23 ;  break;
   		case 24: min = FW_MIN_TRAP_LEVEL_CR_24 ; max = FW_MAX_TRAP_LEVEL_CR_24 ;  break;
		case 25: min = FW_MIN_TRAP_LEVEL_CR_25 ; max = FW_MAX_TRAP_LEVEL_CR_25 ;  break;
		case 26: min = FW_MIN_TRAP_LEVEL_CR_26 ; max = FW_MAX_TRAP_LEVEL_CR_26 ;  break;
   		case 27: min = FW_MIN_TRAP_LEVEL_CR_27 ; max = FW_MAX_TRAP_LEVEL_CR_27 ;  break;
		case 28: min = FW_MIN_TRAP_LEVEL_CR_28 ; max = FW_MAX_TRAP_LEVEL_CR_28 ;  break;
		case 29: min = FW_MIN_TRAP_LEVEL_CR_29 ; max = FW_MAX_TRAP_LEVEL_CR_29 ;  break;
   		case 30: min = FW_MIN_TRAP_LEVEL_CR_30 ; max = FW_MAX_TRAP_LEVEL_CR_30 ;  break;		
		
		case 31: min = FW_MIN_TRAP_LEVEL_CR_31 ; max = FW_MAX_TRAP_LEVEL_CR_31 ;  break;
		case 32: min = FW_MIN_TRAP_LEVEL_CR_32 ; max = FW_MAX_TRAP_LEVEL_CR_32 ;  break;
		case 33: min = FW_MIN_TRAP_LEVEL_CR_33 ; max = FW_MAX_TRAP_LEVEL_CR_33 ;  break;
   		case 34: min = FW_MIN_TRAP_LEVEL_CR_34 ; max = FW_MAX_TRAP_LEVEL_CR_34 ;  break;
		case 35: min = FW_MIN_TRAP_LEVEL_CR_35 ; max = FW_MAX_TRAP_LEVEL_CR_35 ;  break;
		case 36: min = FW_MIN_TRAP_LEVEL_CR_36 ; max = FW_MAX_TRAP_LEVEL_CR_36 ;  break;
   		case 37: min = FW_MIN_TRAP_LEVEL_CR_37 ; max = FW_MAX_TRAP_LEVEL_CR_37 ;  break;
		case 38: min = FW_MIN_TRAP_LEVEL_CR_38 ; max = FW_MAX_TRAP_LEVEL_CR_38 ;  break;
		case 39: min = FW_MIN_TRAP_LEVEL_CR_39 ; max = FW_MAX_TRAP_LEVEL_CR_39 ;  break;
   		case 40: min = FW_MIN_TRAP_LEVEL_CR_40 ; max = FW_MAX_TRAP_LEVEL_CR_40 ;  break;
		
		case 41: min = FW_MIN_TRAP_LEVEL_CR_41_OR_HIGHER; max = FW_MAX_TRAP_LEVEL_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else 
   // This stops people who put inappropriate values for min and max.   
   if (min < 0)
      min = 0;
   if (max < 0)
      max = 0;
   if (min > 3)
      min = 3;
   if (max > 3)
      max = 3;
   // check if someone accidentally swapped min and max.
   if (min > max)
      min = 0;      
   
   int nValue = max - min + 1;
   int nMinMaxRoll = Random (nValue) + min;	     
   // Determine trap type. There are 11 types.
   int nRoll = Random (11);        
   // Minor Traps.   
   if (nMinMaxRoll == 0)
   {  
      nRoll = nRoll * 4;	  	       
   }
   // Average Traps.
   else if (nMinMaxRoll == 1)   
   {
      nRoll = (nRoll * 4) + 1;	  	          
   }
   // Strong Traps.
   else if (nMinMaxRoll == 2)   
   {
      nRoll = (nRoll * 4) + 2;      
   }
   // Deadly Traps.
   else 
   {
      nRoll = (nRoll * 4) + 3;	  	           
   }    
   // Epic traps were not implemented as of MotB but there is room at 
   // the end of the traps.2da file for them.  But they're not 
   // functioning at this time.
   string s2DAResRef = Get2DAString ("traps", "ResRef", nRoll);
   strStruct.oItem = CreateItemOnObject (s2DAResRef, oTarget);
   return strStruct.oItem;
}

////////////////////////////////////////////
// * Function that chooses a random rod and returns it.
// * Rods do not have use limitations like wands do.  And rods
// * have a charges per use variable.
//
object FW_Get_Random_Rod (struct MyStruct strStruct)
{  
   itemproperty ipAdd;       
   int nReRoll = TRUE;
   int nDeletedMisprints = FALSE;
   int nRoll = 0;
   while (nReRoll)
   {
      // There are 708 spells in NWN 2. as of may 12, 2008.
	  int nSpell = Random (708);
	  switch (nSpell)
	  {
	     // this gets rid of all the spells that have wand use set to 1
		 // but shouldn't be. I.E. Ioun Stone, Dye Armor, Grenade Bombs, etc.
		 
		 case 46:
	     case 314: case 315: case 316: case 317: case 318: case 319: case 320:
		 case 329: case 335: case 344: case 351: case 353: case 359: 
		 case 370: case 372: case 431: case 432: case 433: case 434: case 435:
		 case 436: case 437: case 452: case 453: case 454: case 459: case 460:
		 case 462: case 463: case 465: case 478: case 482: case 490: case 491:
		 case 492: case 493: case 494: case 495: case 496: case 497: case 498:
		 case 499: case 500: case 513: case 526: case 527: case 528: case 529:
		 
		 nDeletedMisprints = TRUE; break;
		 		 
		 default: nDeletedMisprints = FALSE; break;	  
	  } // end of switch 	     
	   			
	  string sWandUse = Get2DAString ("iprp_spells", "WandUse", nSpell);
	  int nWandUse = StringToInt (sWandUse);
	  string s2DALabel = Get2DAString ("iprp_spells", "Label", nSpell);		
	  string sCheck = "";
      string s2DAName = Get2DAString ("iprp_spells", "Name", nSpell);
	  
	  // Gets the name of the spell from the .tlk file
	  string sName123 = GetStringByStrRef(StringToInt(Get2DAString("iprp_spells", "Name", nSpell)));
	  	  
	  // Reroll if a deleted spell, or if not flagged for wand use.
      if (s2DAName == sCheck)
	  {  nReRoll = TRUE;  }
	  else if (nWandUse == 0) 
	  {  nReRoll = TRUE;  }
	  else if (nDeletedMisprints)
      {  nReRoll = TRUE;  }
	  else
	  {   
	     nReRoll = FALSE;
		 strStruct.sName = "Rod of: " + sName123;   		 
		 SetFirstName (strStruct.oItem, strStruct.sName);
		 // Now we have to choose a random number of charges per use.
   		 nRoll = Random (5);
		 int nNumUses;
   		 switch (nRoll)
   		 {
      		case 0: nNumUses = IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE;
         		break;
     		case 1: nNumUses = IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE;
         		break;
      		case 2: nNumUses = IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE;
         		break;
      		case 3: nNumUses = IP_CONST_CASTSPELL_NUMUSES_4_CHARGES_PER_USE;
         		break;
      		case 4: nNumUses = IP_CONST_CASTSPELL_NUMUSES_5_CHARGES_PER_USE;
         		break;
      		default: break;
   		 }
		 
		 // Now that we have a spell chosen that can be applied to a rod.	 
		 ipAdd = ItemPropertyCastSpell (nSpell, nNumUses);
	  }  
   } // end of while 
   
   // Now it is time to set the number of charges.  When a rod reaches 0 charges
   // it is destroyed.  Number of starting charges can go up to 50.
   int nNumChargesToStart = (Random(10)+1) * (nRoll+1);
   SetItemCharges (strStruct.oItem, nNumChargesToStart);
   // Add the cast spell item property with the spell chosen.  
   IPSafeAddItemProperty (strStruct.oItem, ipAdd);
   return strStruct.oItem;
} // end of function

////////////////////////////////////////////
// * Function that chooses a random wand and returns it.
//
object FW_Get_Random_Wand (struct MyStruct strStruct)
{  
   itemproperty ipAdd;       
   int nReRoll = TRUE;
   int nDeletedMisprints = FALSE;
   while (nReRoll)
   {
      // There are 806 spell properties in Dalelands. as of 08 May 2011
	  int nSpell = Random (806);
	  switch (nSpell)
	  {
	     // this gets rid of all the spells that have wand use set to 1
		 // but shouldn't be. I.E. Ioun Stone, Dye Armor, Grenade Bombs, etc.
		 
		 case 46:
	     case 314: case 315: case 316: case 317: case 318: case 319: case 320:
		 case 329: case 335: case 344: case 351: case 353: case 359: 
		 case 370: case 372: case 431: case 432: case 433: case 434: case 435:
		 case 436: case 437: case 452: case 453: case 454: case 459: case 460:
		 case 462: case 463: case 465: case 478: case 482: case 490: case 491:
		 case 492: case 493: case 494: case 495: case 496: case 497: case 498:
		 case 499: case 500: case 513: case 526: case 527: case 528: case 529:
		 
		 nDeletedMisprints = TRUE; break;
		 		 
		 default: nDeletedMisprints = FALSE; break;	  
	  } // end of switch 	     
	   			
	  string sWandUse = Get2DAString ("iprp_spells", "WandUse", nSpell);
	  int nWandUse = StringToInt (sWandUse);
	  string sInnateLvl = Get2DAString ("iprp_spells", "InnateLvl", nSpell);
	  int nInnateLvl = StringToInt (sInnateLvl);
	  string s2DALabel = Get2DAString ("iprp_spells", "Label", nSpell);		
	  string sCheck = "";
      string s2DAName = Get2DAString ("iprp_spells", "Name", nSpell);
	  
	  // Gets the name of the spell from the .tlk file
	  string sName123 = GetStringByStrRef(StringToInt(Get2DAString("iprp_spells", "Name", nSpell)));
	  	  
	  // Reroll if a deleted spell, or if not flagged for wand use or if innate lvl is > 4
      if (s2DAName == sCheck)
	  {  nReRoll = TRUE;  }
	  else if (nWandUse == 0) 
	  {  nReRoll = TRUE;  }
	  else if (nInnateLvl > 4) 
	  {  nReRoll = TRUE;  }
	  else if (nDeletedMisprints)
      {  nReRoll = TRUE;  }
	  else
	  {   
	     nReRoll = FALSE;
		 strStruct.sName = "Wand of: " + sName123;  		 		 
		 SetFirstName (strStruct.oItem, strStruct.sName);
		 // Now we have to choose a random number of uses.
		 int nNumUses;
		 if (FW_ALLOW_CAST_PERDAY_WANDS == TRUE) {
	  		 int nRoll = Random (7);
	  		 switch (nRoll)
	  		 {
	     		case 0: nNumUses = IP_CONST_CASTSPELL_NUMUSES_SINGLE_USE;
	        		break;
	    		case 1: nNumUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
	        		break;
	     		case 2: nNumUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
	        		break;
	     		case 3: nNumUses = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
	        		break;
	     		case 4: nNumUses = IP_CONST_CASTSPELL_NUMUSES_4_USES_PER_DAY;
	        		break;
	     		case 5: nNumUses = IP_CONST_CASTSPELL_NUMUSES_5_USES_PER_DAY;
	        		break;
	     		case 6: nNumUses = IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE;
	        		break;
	  		 }
		 } else {
		 
			 // Now we have to choose a random number of charges per use.
	   		 int nRoll = 0; // Random (5); // naw dont roll.... just make it 1 charge per use
	   		 switch (nRoll)
	   		 {
	      		case 0: nNumUses = IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE;
	         		break;
	     		case 1: nNumUses = IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE;
	         		break;
	      		case 2: nNumUses = IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE;
	         		break;
	      		case 3: nNumUses = IP_CONST_CASTSPELL_NUMUSES_4_CHARGES_PER_USE;
	         		break;
	      		case 4: nNumUses = IP_CONST_CASTSPELL_NUMUSES_5_CHARGES_PER_USE;
	         		break;
	      		default: break;
	   		 }
			 // and a random number or starting charges... enough to cast it 1-10 times			 
   			 int nNumChargesToStart = (Random(10)+1) * (nRoll+1);
  			 SetItemCharges (strStruct.oItem, nNumChargesToStart);
		 }
		 // We need to limit the use of the wand/rod to the appropriate classes
		 string sSpellIndex = Get2DAString ("iprp_spells", "SpellIndex", nSpell);
		 int nSpellIndex = StringToInt (sSpellIndex);
		 
		 itemproperty ipAddUseLimitation;		 
		 
		 string sBardCheck =  Get2DAString ("spells", "Bard", nSpellIndex);		 
		 if (sBardCheck == sCheck)  {  }
		 else
		 {
		 	ipAddUseLimitation = ItemPropertyLimitUseByClass (IP_CONST_CLASS_BARD);
			IPSafeAddItemProperty (strStruct.oItem, ipAddUseLimitation);
		 }
		 
		 string sClericCheck =  Get2DAString ("spells", "Cleric", nSpellIndex);
		 if (sClericCheck == sCheck)  {  }
		 else
		 {
		 	ipAddUseLimitation = ItemPropertyLimitUseByClass (IP_CONST_CLASS_CLERIC);
			IPSafeAddItemProperty (strStruct.oItem, ipAddUseLimitation);
		 }
		 
		 string sRangerCheck =  Get2DAString ("spells", "Ranger", nSpellIndex);
		 if (sRangerCheck == sCheck)  {  }
		 else
		 {
		 	ipAddUseLimitation = ItemPropertyLimitUseByClass (IP_CONST_CLASS_RANGER);
			IPSafeAddItemProperty (strStruct.oItem, ipAddUseLimitation);
		 }
		 
		 string sPaladinCheck =  Get2DAString ("spells", "Paladin", nSpellIndex);
		 if (sPaladinCheck == sCheck)  {  }
		 else
		 {
		 	ipAddUseLimitation = ItemPropertyLimitUseByClass (IP_CONST_CLASS_PALADIN);
			IPSafeAddItemProperty (strStruct.oItem, ipAddUseLimitation);
		 }
		 
		 string sDruidCheck =  Get2DAString ("spells", "Druid", nSpellIndex);
		 if (sDruidCheck == sCheck)  {  }
		 else
		 {
		 	ipAddUseLimitation = ItemPropertyLimitUseByClass (IP_CONST_CLASS_DRUID);
			IPSafeAddItemProperty (strStruct.oItem, ipAddUseLimitation);
		 }
		 
		 string sWiz_SorcCheck =  Get2DAString ("spells", "Wiz_Sorc", nSpellIndex);
		 if (sWiz_SorcCheck == sCheck)  {  }
		 else
		 {
		 	ipAddUseLimitation = ItemPropertyLimitUseByClass (IP_CONST_CLASS_SORCERER);
			IPSafeAddItemProperty (strStruct.oItem, ipAddUseLimitation);
			ipAddUseLimitation = ItemPropertyLimitUseByClass (IP_CONST_CLASS_WIZARD);
			IPSafeAddItemProperty (strStruct.oItem, ipAddUseLimitation);
		 }		 
		 // Now that we have a spell chosen that can be applied to a wand/rod.	 
		 ipAdd = ItemPropertyCastSpell (nSpell, nNumUses);
	  }  
   } // end of while   
   IPSafeAddItemProperty (strStruct.oItem, ipAdd);
   return strStruct.oItem;
} // end of function

////////////////////////////////////////////
// * Function that iterates through all the types of exotic weapons and chooses
// * one randomly. Does not choose thrown or ranged weapons though.
//
object FW_Get_Random_Weapon_Exotic(object oTarget)
{
	object oItem;
    int nMaterial = FW_WhatMetalWeaponMaterial();
    int nRoll = Random(4);
    switch (nRoll)
    {
		// Kama
		case 0: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_wspka001", oTarget);
	  	   else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_spka_ada_3", oTarget);
		   else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_spka_slv_3", oTarget);
		   else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_spka_cld_3", oTarget);
		   else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_spka_drk_3", oTarget);
		   else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_spka_mth_3", oTarget);
         break;
		// Bastard Sword
		case 1: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_wswbs001", oTarget);
	  	   else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_swbs_ada_3", oTarget);
		   else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_swbs_slv_3", oTarget);
		   else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_swbs_cld_3", oTarget);
		   else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_swbs_drk_3", oTarget);
		   else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_swbs_mth_3", oTarget);
         break;
		// Dwarven Waraxe
		case 2: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("x2_wdwraxe001", oTarget);
	  	   else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_axdv_ada_3", oTarget);
		   else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_axdv_slv_3", oTarget);
		   else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_axdv_cld_3", oTarget);
		   else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_axdv_drk_3", oTarget);
		   else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_axdv_mth_3", oTarget);
         break;
		// Katana
		case 3: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_wswka001", oTarget);
	  	   else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_swka_ada_3", oTarget);
		   else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_swka_slv_3", oTarget);
		   else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_swka_cld_3", oTarget);
		   else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_swka_drk_3", oTarget);
		   else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_swka_mth_3", oTarget);
         break; 
		
		default: break;	
	} // end of switch
	return oItem;
} // end of function

////////////////////////////////////////////
// * Function that iterates through all the types of ranged weapons and chooses
// * one randomly. 
//
object FW_Get_Random_Weapon_Ranged(object oTarget)
{
	object oItem;
    int nMaterial2 = FW_WhatWoodWeaponMaterial();
    int nRoll = Random(5);
    switch (nRoll)
    {
		// Heavy Crossbow
		case 0:  if (nMaterial2 == FW_MATERIAL_NON_SPECIFIC)  oItem = CreateItemOnObject ("nw_wbwxh001", oTarget);
         	else if (nMaterial2 == FW_MATERIAL_DUSKWOOD)      oItem = CreateItemOnObject ("mwr_bwxh_dsk_4", oTarget);
			else /* (nMaterial2 == FW_MATERIAL_ZALANTAR)*/    oItem = CreateItemOnObject ("mwr_bwxh_zal_3", oTarget);		 
			break;
		// Light Crossbow
		case 1:  if (nMaterial2 == FW_MATERIAL_NON_SPECIFIC)  oItem = CreateItemOnObject ("nw_wbwxl001", oTarget);
         	else if (nMaterial2 == FW_MATERIAL_DUSKWOOD)      oItem = CreateItemOnObject ("mwr_bwxl_dsk_4", oTarget);
			else /* (nMaterial2 == FW_MATERIAL_ZALANTAR)*/    oItem = CreateItemOnObject ("mwr_bwxl_zal_3", oTarget);		 
			break;
		// Shortbow
		case 2:  if (nMaterial2 == FW_MATERIAL_NON_SPECIFIC)  oItem = CreateItemOnObject ("nw_wbwsh001", oTarget);
         	else if (nMaterial2 == FW_MATERIAL_DUSKWOOD)      oItem = CreateItemOnObject ("mwr_bwsh_dsk_4", oTarget);
			else /* (nMaterial2 == FW_MATERIAL_ZALANTAR)*/    oItem = CreateItemOnObject ("mwr_bwsh_zal_3", oTarget);		 
			break;
		// Longbow
		case 3:  if (nMaterial2 == FW_MATERIAL_NON_SPECIFIC)  oItem = CreateItemOnObject ("nw_wbwln001", oTarget);
         	else if (nMaterial2 == FW_MATERIAL_DUSKWOOD)      oItem = CreateItemOnObject ("mwr_bwln_dsk_4", oTarget);
			else /* (nMaterial2 == FW_MATERIAL_ZALANTAR)*/    oItem = CreateItemOnObject ("mwr_bwln_zal_3", oTarget);		 
			break;
		// Sling
		case 4:	 oItem = CreateItemOnObject ("nw_wbwsl001", oTarget);
			break;
			
		default: break;	
	}
	return oItem;
}

////////////////////////////////////////////
// * Function that iterates through all the types of simple weapons and chooses
// * one randomly. Does not choose thrown or ranged weapons though.
//
object FW_Get_Random_Weapon_Simple(object oTarget)
{
   object oItem;
   int nMaterial = FW_WhatMetalWeaponMaterial();
   int nMaterial2 = FW_WhatWoodWeaponMaterial(); 
   int nRoll = Random(7);
   switch (nRoll)
   {
      // Dagger
      case 0: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_wswdg001", oTarget);
	  	 else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_swdg_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_swdg_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_swdg_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_swdg_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_swdg_mth_3", oTarget);
         break;
      // Mace
      case 1: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_wblml001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_blml_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_blml_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_blml_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_blml_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_blml_mth_3", oTarget);
         break;
      // Sickle
      case 2: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_wspsc001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_spsc_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_spsc_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_spsc_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_spsc_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_spsc_mth_3", oTarget);
         break;
      // Club
      case 3: if (nMaterial2 == FW_MATERIAL_NON_SPECIFIC)       oItem = CreateItemOnObject ("nw_wblcl001", oTarget);
         else if (nMaterial2 == FW_MATERIAL_DUSKWOOD)           oItem = CreateItemOnObject ("mst_blcl_dsk_3", oTarget);
		 else /* (nMaterial2 == FW_MATERIAL_ZALANTAR)*/         oItem = CreateItemOnObject ("mst_blcl_zal_3", oTarget);
		 break;
      // Morningstar
      case 4: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_wblms001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_blms_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_blms_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_blms_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_blms_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_blms_mth_3", oTarget);
         break;
      // Quarterstaff
      case 5: if (nMaterial2 == FW_MATERIAL_NON_SPECIFIC)       oItem = CreateItemOnObject ("nw_wdbqs001", oTarget);
         else if (nMaterial2 == FW_MATERIAL_DUSKWOOD)           oItem = CreateItemOnObject ("mst_dbqs_dsk_3", oTarget);
		 else /* (nMaterial2 == FW_MATERIAL_ZALANTAR)*/         oItem = CreateItemOnObject ("mst_dbqs_zal_3", oTarget);
		 break;
      // Spear
      case 6: if (nMaterial2 == FW_MATERIAL_NON_SPECIFIC)       oItem = CreateItemOnObject ("nw_wplss001", oTarget);
         else if (nMaterial2 == FW_MATERIAL_DUSKWOOD)           oItem = CreateItemOnObject ("mst_plss_dsk_3", oTarget);
		 else /* (nMaterial2 == FW_MATERIAL_ZALANTAR)*/         oItem = CreateItemOnObject ("mst_plss_zal_3", oTarget);
		 break;

      default: break;
   }  // end of simple switch
   return oItem;
} // end of function

////////////////////////////////////////////
// * Function that iterates through all the types of martial weapons and chooses
// * one randomly. Does not choose thrown or ranged weapons though.
//
object FW_Get_Random_Weapon_Martial(object oTarget)
{
   object oItem;
   int nMaterial = FW_WhatMetalWeaponMaterial();
   int nRoll = Random(16);
   switch (nRoll)
   {
      // Light Hammer
      case 0: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_wblhl001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_blhl_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_blhl_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_blhl_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_blhl_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_blhl_mth_3", oTarget);
         break;
      // Handaxe
      case 1: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_waxhn001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_axhn_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_axhn_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_axhn_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_axhn_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_axhn_mth_3", oTarget);
         break;
      // Kukri
      case 2: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_wspku001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_spku_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_spku_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_spku_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_spku_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_spku_mth_3", oTarget);
         break;
      // ShortSword
      case 3: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_wswss001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_swss_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_swss_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_swss_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_swss_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_swss_mth_3", oTarget);
         break;
      // BattleAxe
      case 4: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_waxbt001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_axbt_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_axbt_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_axbt_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_axbt_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_axbt_mth_3", oTarget);
         break;
      // Longsword
      case 5: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_wswls001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_swls_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_swls_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_swls_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_swls_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_swls_mth_3", oTarget);
         break;
      // Rapier
      case 6: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_wswrp001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_swrp_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_swrp_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_swrp_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_swrp_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_swrp_mth_3", oTarget);
         break;
      // Scimitar
      case 7: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_wswsc001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_swsc_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_swsc_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_swsc_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_swsc_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_swsc_mth_3", oTarget);
         break;
      // Warhammer
      case 8: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("nw_wblhw001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_blhw_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_blhw_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_blhw_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_blhw_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_blhw_mth_3", oTarget);
         break;
      // Falchion
      case 9: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)        oItem = CreateItemOnObject ("n2_wswfl001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_swfl_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_swfl_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_swfl_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_swfl_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_swfl_mth_3", oTarget);
         break;
      // GreatAxe
      case 10: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)       oItem = CreateItemOnObject ("nw_waxgr001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_axgr_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_axgr_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_axgr_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_axgr_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_axgr_mth_3", oTarget);
         break;
      // Greatsword
      case 11: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)       oItem = CreateItemOnObject ("nw_wswgs001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_swgs_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_swgs_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_swgs_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_swgs_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_swgs_mth_3", oTarget);
         break;
      // Halberd
      case 12: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)       oItem = CreateItemOnObject ("nw_wplhb001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_plhb_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_plhb_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_plhb_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_plhb_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_plhb_mth_3", oTarget);
         break;
      // Scythe
      case 13: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)       oItem = CreateItemOnObject ("nw_wplsc001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_plsc_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_plsc_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_plsc_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_plsc_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_plsc_mth_3", oTarget);
         break;
      // warmace
      case 14: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)       oItem = CreateItemOnObject ("nw_wdbma001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_bldm_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_bldm_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_bldm_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_bldm_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_bldm_mth_3", oTarget);
         break;
      // light flail
      case 15: if (nMaterial == FW_MATERIAL_NON_SPECIFIC)       oItem = CreateItemOnObject ("nw_wblfl001", oTarget);
         else if (nMaterial == FW_MATERIAL_ADAMANTINE)          oItem = CreateItemOnObject ("mst_blfl_ada_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_ALCHEMICAL_SILVER)   oItem = CreateItemOnObject ("mst_blfl_slv_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_COLD_IRON)           oItem = CreateItemOnObject ("mst_blfl_cld_3", oTarget);
		 else if (nMaterial == FW_MATERIAL_DARK_STEEL)          oItem = CreateItemOnObject ("mst_blfl_drk_3", oTarget);
		 else /* (nMaterial == FW_MATERIAL_MITHRAL) */          oItem = CreateItemOnObject ("mst_blfl_mth_3", oTarget);
         break;

      default: break;
   }  // end of simple switch
   return oItem;
} // end of function


////////////////////////////////////////////
// * Function that chooses a random recipe.
//
object FW_Get_Random_Recipe(object oTarget)
{
   object oItem;
   int nType = FW_WhatRecipeType();
   
// SendMessageToPC(oTarget, "Creating Recipe Type: " + IntToString(nType)); 
   switch (nType)
   {
   case FW_TYPE_RECIPE_ABILITY2: 
      {
	      int nRoll = Random(6); // number of items in this group
	      switch(nRoll) 
	      {
		      case 0 : oItem = CreateItemOnObject ("ench_ability_char2", oTarget); break;
		      case 1 : oItem = CreateItemOnObject ("ench_ability_con2", oTarget); break;
		      case 2 : oItem = CreateItemOnObject ("ench_ability_dex2", oTarget); break;
		      case 3 : oItem = CreateItemOnObject ("ench_ability_int2", oTarget); break;
		      case 4 : oItem = CreateItemOnObject ("ench_ability_str2", oTarget); break;
		      case 5 : oItem = CreateItemOnObject ("ench_ability_wis2", oTarget); break;
      	  };
	  } break;
   case FW_TYPE_RECIPE_ABILITY3: 
      {
      int nRoll = Random(6); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_ability_char3", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_ability_con3", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_ability_dex3", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_ability_int3", oTarget); break;
      case 4 : oItem = CreateItemOnObject ("ench_ability_str3", oTarget); break;
      case 5 : oItem = CreateItemOnObject ("ench_ability_wis3", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_ABILITY4: 
      {
      int nRoll = Random(6); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_ability_char4", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_ability_con4", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_ability_dex4", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_ability_int4", oTarget); break;
      case 4 : oItem = CreateItemOnObject ("ench_ability_str4", oTarget); break;
      case 5 : oItem = CreateItemOnObject ("ench_ability_wis4", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_ADAMANTINE: 
      {
      int nRoll = Random(34); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_adamantine_bandedmail", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_adamantine_breastplate", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_adamantine_bsword_recipe", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_adamantine_chainmail", oTarget); break;
      case 4 : oItem = CreateItemOnObject ("ench_adamantine_chainshirt", oTarget); break;
      case 5 : oItem = CreateItemOnObject ("ench_adamantine_falchion_recipe", oTarget); break;
      case 6 : oItem = CreateItemOnObject ("ench_adamantine_flail_recipe", oTarget); break;
      case 7 : oItem = CreateItemOnObject ("ench_adamantine_fullplate", oTarget); break;
      case 8 : oItem = CreateItemOnObject ("ench_adamantine_gsword_recipe", oTarget); break;
      case 9 : oItem = CreateItemOnObject ("ench_adamantine_halberd_recipe", oTarget); break;
      case 10 : oItem = CreateItemOnObject ("ench_adamantine_halfplate", oTarget); break;
      case 11 : oItem = CreateItemOnObject ("ench_adamantine_heavyshield", oTarget); break;
      case 12 : oItem = CreateItemOnObject ("ench_adamantine_helm", oTarget); break;
      case 13 : oItem = CreateItemOnObject ("ench_adamantine_kama_recipe", oTarget); break;
      case 14 : oItem = CreateItemOnObject ("ench_adamantine_katana_recipe", oTarget); break;
      case 15 : oItem = CreateItemOnObject ("ench_adamantine_kukri_recipe", oTarget); break;
      case 16 : oItem = CreateItemOnObject ("ench_adamantine_lhammer_recipe", oTarget); break;
      case 17 : oItem = CreateItemOnObject ("ench_adamantine_lightshield", oTarget); break;
      case 18 : oItem = CreateItemOnObject ("ench_adamantine_lsword_recipe", oTarget); break;
      case 19 : oItem = CreateItemOnObject ("ench_adamantine_mace_recipe", oTarget); break;
      case 20 : oItem = CreateItemOnObject ("ench_adamantine_mstar_recipe", oTarget); break;
      case 21 : oItem = CreateItemOnObject ("ench_adamantine_rapier_recipe", oTarget); break;
      case 22 : oItem = CreateItemOnObject ("ench_adamantine_scalemail", oTarget); break;
      case 23 : oItem = CreateItemOnObject ("ench_adamantine_scimitar_recipe", oTarget); break;
      case 24 : oItem = CreateItemOnObject ("ench_adamantine_sickle_recipe", oTarget); break;
      case 25 : oItem = CreateItemOnObject ("ench_adamantine_ssword_recipe", oTarget); break;
      case 26 : oItem = CreateItemOnObject ("ench_adamantine_towershield", oTarget); break;
      case 27 : oItem = CreateItemOnObject ("ench_adamantine_whammer_recipe", oTarget); break;
      case 28 : oItem = CreateItemOnObject ("ench_adamantine_wmace_recipe", oTarget); break;
      case 29 : oItem = CreateItemOnObject ("ench_r_w_baxe_adamantine", oTarget); break;
      case 30 : oItem = CreateItemOnObject ("ench_r_w_dag_adamantine", oTarget); break;
      case 31 : oItem = CreateItemOnObject ("ench_r_w_dwaxe_adamantine", oTarget); break;
      case 32 : oItem = CreateItemOnObject ("ench_r_w_gaxe_adamantine", oTarget); break;
      case 33 : oItem = CreateItemOnObject ("ench_r_w_haxe_adamantine", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_COLDIRON: 
      {
      int nRoll = Random(24); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_cldiron_bsword_recipe", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_cldiron_falchion_recipe", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_cldiron_flail_recipe", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_cldiron_gsword_recipe", oTarget); break;
      case 4 : oItem = CreateItemOnObject ("ench_cldiron_halberd_recipe", oTarget); break;
      case 5 : oItem = CreateItemOnObject ("ench_cldiron_kama_recipe", oTarget); break;
      case 6 : oItem = CreateItemOnObject ("ench_cldiron_katana_recipe", oTarget); break;
      case 7 : oItem = CreateItemOnObject ("ench_cldiron_kukri_recipe", oTarget); break;
      case 8 : oItem = CreateItemOnObject ("ench_cldiron_lhammer_recipe", oTarget); break;
      case 9 : oItem = CreateItemOnObject ("ench_cldiron_lsword_recipe", oTarget); break;
      case 10 : oItem = CreateItemOnObject ("ench_cldiron_mace_recipe", oTarget); break;
      case 11 : oItem = CreateItemOnObject ("ench_cldiron_mstar_recipe", oTarget); break;
      case 12 : oItem = CreateItemOnObject ("ench_cldiron_rapier_recipe", oTarget); break;
      case 13 : oItem = CreateItemOnObject ("ench_cldiron_scimitar_recipe", oTarget); break;
      case 14 : oItem = CreateItemOnObject ("ench_cldiron_sickle_recipe", oTarget); break;
      case 15 : oItem = CreateItemOnObject ("ench_cldiron_ssword_recipe", oTarget); break;
      case 16 : oItem = CreateItemOnObject ("ench_cldiron_whammer_recipe", oTarget); break;
      case 17 : oItem = CreateItemOnObject ("ench_cldiron_wmace_recipe", oTarget); break;
      case 18 : oItem = CreateItemOnObject ("ench_r_w_baxe_cldiron", oTarget); break;
      case 19 : oItem = CreateItemOnObject ("ench_r_w_dag_cldiron", oTarget); break;
      case 20 : oItem = CreateItemOnObject ("ench_r_w_dwaxe_cldiron", oTarget); break;
      case 21 : oItem = CreateItemOnObject ("ench_r_w_gaxe_cldiron", oTarget); break;
      case 22 : oItem = CreateItemOnObject ("ench_r_w_haxe_cldiron", oTarget); break;
      case 23 : oItem = CreateItemOnObject ("ench_coldiron_ingot", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_DAMAGE_RESISTANCE: 
      {
      int nRoll = Random(4); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_acid_resistance10", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_cold_resistance10", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_elect_resistance10", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_fire_resistance10", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_DAMAGE1: 
      {
      int nRoll = Random(4); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_w_acid1", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_w_cold1", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_w_elect1", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_w_fire1", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_DAMAGE1D6: 
      {
      int nRoll = Random(4); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_w_acid1d6", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_w_cold1d6", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_w_elect1d6", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_w_fire1d6", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_DARKSTEEL: 
      {
      int nRoll = Random(33); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_darksteel_bandedmail", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_darksteel_breastplate", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_darksteel_chainmail", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_darksteel_chainshirt", oTarget); break;
      case 4 : oItem = CreateItemOnObject ("ench_darksteel_fullplate", oTarget); break;
      case 5 : oItem = CreateItemOnObject ("ench_darksteel_halfplate", oTarget); break;
      case 6 : oItem = CreateItemOnObject ("ench_darksteel_heavyshield", oTarget); break;
      case 7 : oItem = CreateItemOnObject ("ench_darksteel_lightshield", oTarget); break;
      case 8 : oItem = CreateItemOnObject ("ench_darksteel_scalemail", oTarget); break;
      case 9 : oItem = CreateItemOnObject ("ench_darksteel_towershield", oTarget); break;
      case 10 : oItem = CreateItemOnObject ("ench_drksteel_bsword_recipe", oTarget); break;
      case 11 : oItem = CreateItemOnObject ("ench_drksteel_falchion_recipe", oTarget); break;
      case 12 : oItem = CreateItemOnObject ("ench_drksteel_flail_recipe", oTarget); break;
      case 13 : oItem = CreateItemOnObject ("ench_drksteel_gsword_recipe", oTarget); break;
      case 14 : oItem = CreateItemOnObject ("ench_drksteel_halberd_recipe", oTarget); break;
      case 15 : oItem = CreateItemOnObject ("ench_drksteel_kama_recipe", oTarget); break;
      case 16 : oItem = CreateItemOnObject ("ench_drksteel_katana_recipe", oTarget); break;
      case 17 : oItem = CreateItemOnObject ("ench_drksteel_kukri_recipe", oTarget); break;
      case 18 : oItem = CreateItemOnObject ("ench_drksteel_lhammer_recipe", oTarget); break;
      case 19 : oItem = CreateItemOnObject ("ench_drksteel_lsword_recipe", oTarget); break;
      case 20 : oItem = CreateItemOnObject ("ench_drksteel_mace_recipe", oTarget); break;
      case 21 : oItem = CreateItemOnObject ("ench_drksteel_mstar_recipe", oTarget); break;
      case 22 : oItem = CreateItemOnObject ("ench_drksteel_rapier_recipe", oTarget); break;
      case 23 : oItem = CreateItemOnObject ("ench_drksteel_scimitar_recipe", oTarget); break;
      case 24 : oItem = CreateItemOnObject ("ench_drksteel_sickle_recipe", oTarget); break;
      case 25 : oItem = CreateItemOnObject ("ench_drksteel_ssword_recipe", oTarget); break;
      case 26 : oItem = CreateItemOnObject ("ench_drksteel_whammer_recipe", oTarget); break;
      case 27 : oItem = CreateItemOnObject ("ench_drksteel_wmace_recipe", oTarget); break;
      case 28 : oItem = CreateItemOnObject ("ench_r_w_baxe_drksteel", oTarget); break;
      case 29 : oItem = CreateItemOnObject ("ench_r_w_dag_drksteel", oTarget); break;
      case 30 : oItem = CreateItemOnObject ("ench_r_w_dwaxe_drksteel", oTarget); break;
      case 31 : oItem = CreateItemOnObject ("ench_r_w_gaxe_drksteel", oTarget); break;
      case 32 : oItem = CreateItemOnObject ("ench_r_w_haxe_drksteel", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_ENCHANTMENT3:
      {
      int nRoll = Random(2); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_a_ac3", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_w_3", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_ENCHANTMENT4: 
      {
      int nRoll = Random(2); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_a_ac4", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_w_4", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_ESSENCE_FAINT: 
      {
      int nRoll = Random(5); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_fair_essence", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_fearth_essence", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_ffire_essence", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_fpower_essence", oTarget); break;
      case 4 : oItem = CreateItemOnObject ("ench_fwater_essence", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_ESSENCE_GLOWING: 
      {
      int nRoll = Random(5); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_gair_essence", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_gearth_essence", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_gfire_essence", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_gpower_essence", oTarget); break;
      case 4 : oItem = CreateItemOnObject ("ench_gwater_essence", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_ESSENCE_RADIANT: 
      {
      int nRoll = Random(5); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_rair_essence", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_rearth_essence", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_rfire_essence", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_rpower_essence", oTarget); break;
      case 4 : oItem = CreateItemOnObject ("ench_rwater_essence", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_ESSENCE_WEAK: 
      {
      int nRoll = Random(5); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_wair_essence", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_wearth_essence", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_wfire_essence", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_wpower_essence", oTarget); break;
      case 4 : oItem = CreateItemOnObject ("ench_wwater_essence", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_MITHRAL: 
      {
      int nRoll = Random(33); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_mithral_bandedmail", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_mithral_breastplate", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_mithral_bsword_recipe", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_mithral_chainmail", oTarget); break;
      case 4 : oItem = CreateItemOnObject ("ench_mithral_chainshirt", oTarget); break;
      case 5 : oItem = CreateItemOnObject ("ench_mithral_falchion_recipe", oTarget); break;
      case 6 : oItem = CreateItemOnObject ("ench_mithral_flail_recipe", oTarget); break;
      case 7 : oItem = CreateItemOnObject ("ench_mithral_fullplate", oTarget); break;
      case 8 : oItem = CreateItemOnObject ("ench_mithral_gsword_recipe", oTarget); break;
      case 9 : oItem = CreateItemOnObject ("ench_mithral_halberd_recipe", oTarget); break;
      case 10 : oItem = CreateItemOnObject ("ench_mithral_halfplate", oTarget); break;
      case 11 : oItem = CreateItemOnObject ("ench_mithral_heavyshield", oTarget); break;
      case 12 : oItem = CreateItemOnObject ("ench_mithral_kama_recipe", oTarget); break;
      case 13 : oItem = CreateItemOnObject ("ench_mithral_katana_recipe", oTarget); break;
      case 14 : oItem = CreateItemOnObject ("ench_mithral_kukri_recipe", oTarget); break;
      case 15 : oItem = CreateItemOnObject ("ench_mithral_lhammer_recipe", oTarget); break;
      case 16 : oItem = CreateItemOnObject ("ench_mithral_lightshield", oTarget); break;
      case 17 : oItem = CreateItemOnObject ("ench_mithral_lsword_recipe", oTarget); break;
      case 18 : oItem = CreateItemOnObject ("ench_mithral_mace_recipe", oTarget); break;
      case 19 : oItem = CreateItemOnObject ("ench_mithral_mstar_recipe", oTarget); break;
      case 20 : oItem = CreateItemOnObject ("ench_mithral_rapier_recipe", oTarget); break;
      case 21 : oItem = CreateItemOnObject ("ench_mithral_scalemail", oTarget); break;
      case 22 : oItem = CreateItemOnObject ("ench_mithral_scimitar_recipe", oTarget); break;
      case 23 : oItem = CreateItemOnObject ("ench_mithral_sickle_recipe", oTarget); break;
      case 24 : oItem = CreateItemOnObject ("ench_mithral_ssword_recipe", oTarget); break;
      case 25 : oItem = CreateItemOnObject ("ench_mithral_towershield", oTarget); break;
      case 26 : oItem = CreateItemOnObject ("ench_mithral_whammer_recipe", oTarget); break;
      case 27 : oItem = CreateItemOnObject ("ench_mithral_wmace_recipe", oTarget); break;
      case 28 : oItem = CreateItemOnObject ("ench_r_w_baxe_mithral", oTarget); break;
      case 29 : oItem = CreateItemOnObject ("ench_r_w_dag_mithral", oTarget); break;
      case 30 : oItem = CreateItemOnObject ("ench_r_w_dwaxe_mithral", oTarget); break;
      case 31 : oItem = CreateItemOnObject ("ench_r_w_gaxe_mithral", oTarget); break;
      case 32 : oItem = CreateItemOnObject ("ench_r_w_haxe_mithral", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_NON_SPECIFIC: 
      {
      int nRoll = Random(36); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_iron_bandedmail", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_iron_breastplate", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_iron_bsword_recipe", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_iron_chainmail", oTarget); break;
      case 4 : oItem = CreateItemOnObject ("ench_iron_chainshirt", oTarget); break;
      case 5 : oItem = CreateItemOnObject ("ench_iron_falchion_recipe", oTarget); break;
      case 6 : oItem = CreateItemOnObject ("ench_iron_flail_recipe", oTarget); break;
      case 7 : oItem = CreateItemOnObject ("ench_iron_fullplate", oTarget); break;
      case 8 : oItem = CreateItemOnObject ("ench_iron_gsword_recipe", oTarget); break;
      case 9 : oItem = CreateItemOnObject ("ench_iron_halberd_recipe", oTarget); break;
      case 10 : oItem = CreateItemOnObject ("ench_iron_halfplate", oTarget); break;
      case 11 : oItem = CreateItemOnObject ("ench_iron_heavyshield", oTarget); break;
      case 12 : oItem = CreateItemOnObject ("ench_iron_kama_recipe", oTarget); break;
      case 13 : oItem = CreateItemOnObject ("ench_iron_katana_recipe", oTarget); break;
      case 14 : oItem = CreateItemOnObject ("ench_iron_kukri_recipe", oTarget); break;
      case 15 : oItem = CreateItemOnObject ("ench_iron_lhammer_recipe", oTarget); break;
      case 16 : oItem = CreateItemOnObject ("ench_iron_lightshield", oTarget); break;
      case 17 : oItem = CreateItemOnObject ("ench_iron_lsword_recipe", oTarget); break;
      case 18 : oItem = CreateItemOnObject ("ench_iron_mace_recipe", oTarget); break;
      case 19 : oItem = CreateItemOnObject ("ench_iron_mstar_recipe", oTarget); break;
      case 20 : oItem = CreateItemOnObject ("ench_iron_rapier_recipe", oTarget); break;
      case 21 : oItem = CreateItemOnObject ("ench_iron_scalemail", oTarget); break;
      case 22 : oItem = CreateItemOnObject ("ench_iron_scimitar_recipe", oTarget); break;
      case 23 : oItem = CreateItemOnObject ("ench_iron_sickle_recipe", oTarget); break;
      case 24 : oItem = CreateItemOnObject ("ench_iron_ssword_recipe", oTarget); break;
      case 25 : oItem = CreateItemOnObject ("ench_iron_towershield", oTarget); break;
      case 26 : oItem = CreateItemOnObject ("ench_iron_whammer_recipe", oTarget); break;
      case 27 : oItem = CreateItemOnObject ("ench_iron_wmace_recipe", oTarget); break;
      case 28 : oItem = CreateItemOnObject ("ench_normal_bow", oTarget); break;
      case 29 : oItem = CreateItemOnObject ("ench_r_w_baxe_iron", oTarget); break;
      case 30 : oItem = CreateItemOnObject ("ench_r_w_dag_iron", oTarget); break;
      case 31 : oItem = CreateItemOnObject ("ench_r_w_dwaxe_iron", oTarget); break;
      case 32 : oItem = CreateItemOnObject ("ench_r_w_gaxe_iron", oTarget); break;
      case 33 : oItem = CreateItemOnObject ("ench_r_w_haxe_iron", oTarget); break;
      case 34 : oItem = CreateItemOnObject ("ench_duskwood_bow", oTarget); break;
      case 35 : oItem = CreateItemOnObject ("ench_zalantar_bow", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_SAVE2:
      { oItem = CreateItemOnObject ("ench_saves2", oTarget); } break;
   case FW_TYPE_RECIPE_SAVE3:
      { oItem = CreateItemOnObject ("ench_saves3", oTarget); } break;
   case FW_TYPE_RECIPE_SAVE4:
      { oItem = CreateItemOnObject ("ench_saves4", oTarget); } break;
   case FW_TYPE_RECIPE_SILVER: 
      {
      int nRoll = Random(24); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_silver_bsword_recipe", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_silver_falchion_recipe", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_silver_flail_recipe", oTarget); break;
      case 3 : oItem = CreateItemOnObject ("ench_silver_gsword_recipe", oTarget); break;
      case 4 : oItem = CreateItemOnObject ("ench_silver_halberd_recipe", oTarget); break;
      case 5 : oItem = CreateItemOnObject ("ench_silver_ingot", oTarget); break;
      case 6 : oItem = CreateItemOnObject ("ench_silver_kama_recipe", oTarget); break;
      case 7 : oItem = CreateItemOnObject ("ench_silver_katana_recipe", oTarget); break;
      case 8 : oItem = CreateItemOnObject ("ench_silver_kukri_recipe", oTarget); break;
      case 9 : oItem = CreateItemOnObject ("ench_silver_lhammer_recipe", oTarget); break;
      case 10 : oItem = CreateItemOnObject ("ench_silver_lsword_recipe", oTarget); break;
      case 11 : oItem = CreateItemOnObject ("ench_silver_mace_recipe", oTarget); break;
      case 12 : oItem = CreateItemOnObject ("ench_silver_mstar_recipe", oTarget); break;
      case 13 : oItem = CreateItemOnObject ("ench_silver_rapier_recipe", oTarget); break;
      case 14 : oItem = CreateItemOnObject ("ench_silver_scimitar_recipe", oTarget); break;
      case 15 : oItem = CreateItemOnObject ("ench_silver_sickle_recipe", oTarget); break;
      case 16 : oItem = CreateItemOnObject ("ench_silver_ssword_recipe", oTarget); break;
      case 17 : oItem = CreateItemOnObject ("ench_silver_whammer_recipe", oTarget); break;
      case 18 : oItem = CreateItemOnObject ("ench_silver_wmace_recipe", oTarget); break;
      case 19 : oItem = CreateItemOnObject ("ench_r_w_baxe_silver", oTarget); break;
      case 20 : oItem = CreateItemOnObject ("ench_r_w_dag_silver", oTarget); break;
      case 21 : oItem = CreateItemOnObject ("ench_r_w_dwaxe_silver", oTarget); break;
      case 22 : oItem = CreateItemOnObject ("ench_r_w_gaxe_silver", oTarget); break;
      case 23 : oItem = CreateItemOnObject ("ench_r_w_haxe_silver", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_SKILL4: 
      {
      int nRoll = Random(3); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_skill_heal4", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_skill_hide4", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_skill_ms4", oTarget); break;
      }; 
	  } break;
   case FW_TYPE_RECIPE_SKILL8: 
      {
      int nRoll = Random(3); // number of items in this group
      switch(nRoll) 
      {
      case 0 : oItem = CreateItemOnObject ("ench_skill_heal8", oTarget); break;
      case 1 : oItem = CreateItemOnObject ("ench_skill_hide8", oTarget); break;
      case 2 : oItem = CreateItemOnObject ("ench_skill_ms8", oTarget); break;
      }; 
	  } break;
   default: break;
   }
   return oItem;
}
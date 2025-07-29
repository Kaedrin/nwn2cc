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
This file handles setting unique names for the random loot generator.
You can turn on/off random naming of loot in the file "fw_inc_loot_switches."
By default random naming of *magical* loot is turned on. Generic items still
get standard names like "Boots" or "Dagger."  However, if an item has 1 or
more magical properties, it will be given a unique random name, provided
that the switch that handles random naming of loot is set to TRUE.  The switch
that you would turn on/off is called:  FW_ALLOW_RANDOM_NAMES_OF_LOOT and like
I said is in the switches script file.

There are basically 8 different templates. Each template often has more than
one possibilitiy for each parameter.  Thus, there are really a lot more than
8 combinations.  For example, #1 below will choose either a color or an 
adjective for Param1.  Next, either the base name of the item or
a monster name is chosen for param2.  When you combine Param1 and 2, you get a
descriptive cool name.  There are hundreds of adjectives and nouns to choose
from. See the two .2da files: "FW_cdaulepp_adjectives.2da" and
"FW_cdaulepp_nouns.2da".  I will list all 8 templates now.

PARAM1.............PARAM2..............PARAM3.
1)
The [color]........[sName].  
[Adj_Any]          [Noun_Monster].    

2)
The [color]........[Adj_Any]...........[sName].

3)
[sName] of.........[Noun_nonproper].

4)
[Noun_Deity]'s.....[Noun_nonproper].
The [class]'s      [Noun_bodypart].

5)
[Noun_Deity]'s.....[Noun_color]........[Noun_nonproper].
The [class]'s      [Adj_Any]		   [Noun_monster].
									   [Noun_bodypart].
									   
6)
The [Adj_Any]......[sName] of..........[Noun_nonproper].

7)
[Noun_bodypart]....of the [Adj_Any]....[Noun_nonproper].
									   [Noun_monster].
									   
8)
[sName] of.........[Noun_Deity]'s......[Noun_nonproper].
				   [Noun_monster]
				   [class]'s
*/
// *****************************************
//
//              UPDATES
//
// *****************************************
// None.  This file is new to version 2.0


// *****************************************
//
//              INCLUDED FILES
//
// *****************************************
// I need the item property functions.
#include "x2_inc_itemprop"
// I need all the constants and switches.
#include "fw_inc_loot_switches"
// I need the MyStruct data types and global variables
#include "fw_inc_misc"


// *****************************************
//
//
//              FUNCTION DECLARATIONS
//
//				DON'T CHANGE
//
//
// *****************************************

////////////////////////////////////////////
// * This function gets a random name using 8 different templates and then
// * assigns the name to the spawning item.
//
void FW_Name_Get_Random_Name (struct MyStruct strStruct);

////////////////////////////////////////////
// * This function returns TRUE if the category of item that will appear as 
// * loot is a category that possibly could have a name added to it.
// * Some item categories do not need unique names added. For example, Gold,
// * Crafting Materials, Books, etc. already have unique names.
// 
int FW_Name_Does_Item_Need_Name (struct MyStruct strStruct);

////////////////////////////////////////////
// * This function gets a random adjective from the file: "fw_cdaulepp_adjectives.2da"
// * By default this function will get any adjective in the fiel, but if you want
// * an adjective from a specific column you can do so by specifying sCategory.
// - sCategory can = "Any", "Size", "Touch", "Shape", "Time", "Quantity", "Sound",
//   "Taste", "Feelings_Bad", "Feelings_Good", "Condition", or "Appearance".
//
string FW_Name_Get_Random_Adjective (string sCategory = "Any");

////////////////////////////////////////////
// * This function gets a random noun from the file: "fw_cdaulepp_nouns.2da"
// * By default this function will get any noun in the file, but if you want
// * a noun from a specific column you can do so by specifying sCategory.
// - sCategory can = "Any", "Deity", "Nouns_Colors", "Nouns_Non_Proper",
//   "Nouns_Monsters", or "Nouns_Bodyparts".  
//
string FW_Name_Get_Random_Noun (string sCategory = "Any");

////////////////////////////////////////////
// * This function gets a random class name and returns it
//
string FW_Name_Get_Random_Class ();


// *****************************************
//
//
//              IMPLEMENTATION
//
//				DON'T CHANGE
//
// *****************************************

////////////////////////////////////////////
// * This function gets a random name using 8 different templates and then
// * assigns the name to the spawning item.
//
void FW_Name_Get_Random_Name (struct MyStruct strStruct)
{
	// Check to see if the naming convention switch is turned on/off.
	// If random loot is turned off then exit and do nothing. (meaning your
	// items will be called generic things like "Dagger" or "Greatsword").
	if (FW_ALLOW_RANDOM_NAMES_OF_LOOT == FALSE)
	{
		return;
	}
	
	// Some items already have unique names. Some have generic names.
	// This line simply separates those that need a random name from those
	// that already have unique names (I.E. in the Misc / Other Category
	// the "Lens of Detection" already has a unique name, so no need
	// to create a name for that category of item. Same thing with the 
	// crafting materials and many other things.
	// If we need a random name, then the call below gets the base item
	// name.  (I.E. "Dagger" or "Adamantine Full Plate") and stores it so
	// I can then construct a name using the base name + other stuff below.
	int nNeedNameCheck = FW_Name_Does_Item_Need_Name(strStruct);
	
	if (nNeedNameCheck)
	{
		strStruct.sName = GetFirstName(strStruct.oItem);
	}
	// If the item already has a unique name then exit and we do NOT overwrite
	// the existing name.
	else 
	{
		return;
	}
	
	// Everything below this point only comes into play if the item needs
	// a random name added to it and obviously only if you turned on the 
	// switch that controls random loot names.
	string sReturnValue;
	string sParam1;
	string sParam2;
	string sParam3;	
		
	int nRoll = Random(8) + 1;	
	// Template 1 	
	if      (nRoll == 1)
	{
		nRoll = Random(2) + 1;
		if  (nRoll == 1)
		{
			sParam1 = FW_Name_Get_Random_Noun("Nouns_Colors");
			sParam1 = "The " + sParam1;
		}
		else /* (nRoll == 2) */
		{
			sParam1 = FW_Name_Get_Random_Adjective();			
		}	
		nRoll = Random(2) + 1;
		if  (nRoll == 1)
			sParam2 = strStruct.sName;
		else
			sParam2 = FW_Name_Get_Random_Noun("Nouns_Monsters");
		
		sReturnValue = sParam1 + " " + sParam2 + ".";
	}
	// Template 2
	else if (nRoll == 2)
	{
		sParam1 = FW_Name_Get_Random_Noun("Nouns_Colors");
		sParam2 = FW_Name_Get_Random_Adjective();
		sParam3 = strStruct.sName;
		
		sReturnValue = "The " + sParam1 + " " + sParam2 + " " + sParam3 + ".";	
	}
	// Template 3
	else if (nRoll == 3)
	{
		sParam1 = strStruct.sName;
		sParam2 = FW_Name_Get_Random_Noun("Nouns_Non_Proper");
		
		sReturnValue = sParam1 + " of " + sParam2 + ".";
	}
	// Template 4
	else if (nRoll == 4)
	{
		// sParam1
		nRoll = Random(100) + 1;
		if      ((nRoll >= 1) && (nRoll <= 10))
			sParam1 = "The " + FW_Name_Get_Random_Class ();
		else // ((nRoll >=11) && (nRoll <= 100))			
			sParam1 = FW_Name_Get_Random_Noun("Deity");
		
		// sParam2
		nRoll = Random(2) + 1;
		if      (nRoll == 1)
			sParam2 = FW_Name_Get_Random_Noun("Nouns_Non_Proper");
		else
			sParam2 = FW_Name_Get_Random_Noun("Nouns_Bodyparts");
		
		sReturnValue = sParam1 + "'s " + sParam2 + ".";
	}
	// Template 5
	else if (nRoll == 5)
	{
		// sParam1
		nRoll = Random(100) + 1;
		if      ((nRoll >= 1) && (nRoll <= 10))
			sParam1 = "The " + FW_Name_Get_Random_Class ();
		else // ((nRoll >=11) && (nRoll <= 100))			
			sParam1 = FW_Name_Get_Random_Noun("Deity");
		
		// sParam2
		nRoll = Random(2) + 1;
		if      (nRoll == 1)
			sParam2 = FW_Name_Get_Random_Noun("Nouns_Colors");
		else /* (nRoll == 2) */
			sParam2 = FW_Name_Get_Random_Adjective();
		
		// sParam3
		nRoll = Random(3) + 1;
		if      (nRoll == 1)
			sParam3 = FW_Name_Get_Random_Noun("Nouns_Non_Proper");
		else if (nRoll == 2)
			sParam3 = FW_Name_Get_Random_Noun("Nouns_Monsters");
		else /* (nRoll == 3) */
			sParam3 = FW_Name_Get_Random_Noun("Nouns_Bodyparts");
			
		sReturnValue = sParam1 + "'s " + sParam2 + " " + sParam3 + ".";
	}
	// Template 6
	else if (nRoll == 6)
	{
		sParam1 = FW_Name_Get_Random_Adjective();
		sParam2 = strStruct.sName;		
		sParam3 = FW_Name_Get_Random_Noun("Nouns_Non_Proper");
		
		sReturnValue = "The " + sParam1 + " " + sParam2 + " of " + sParam3 + ".";
	}
	// Template 7
	else if (nRoll == 7)
	{
		sParam1 = FW_Name_Get_Random_Noun("Nouns_Bodyparts");
		sParam2 = FW_Name_Get_Random_Adjective();
		
		// sParam3
		nRoll = Random(2) + 1;
		if      (nRoll == 1)
			sParam3 = FW_Name_Get_Random_Noun("Nouns_Non_Proper");
		else /* (nRoll == 2) */
			sParam3 = FW_Name_Get_Random_Noun("Nouns_Monsters");
		
		sReturnValue = sParam1 + " of the " + sParam2 + " " + sParam3 + ".";
	}
	// Template 8
	else /* (nRoll == 8) */
	{
		sParam1 = strStruct.sName;
		
		// sParam2  Slightly different depending on if it is possessive.
		nRoll = Random(3) + 1;
		if      (nRoll == 1)
		{
			sParam2 = FW_Name_Get_Random_Noun("Deity");
			sParam2 = sParam2 + "'s";	
		}
		else if (nRoll == 2)
		{
			sParam2 = FW_Name_Get_Random_Noun("Nouns_Monsters");
		}
		else // (nRoll == 3)
		{
			sParam2 = FW_Name_Get_Random_Class(); 
			sParam2 = sParam2 + "'s";
		}
		
		// sParam3
		sParam3 = FW_Name_Get_Random_Noun("Nouns_Non_Proper");
		
		sReturnValue = sParam1 + " of " + sParam2 + " " + sParam3 + ".";
	} // end of else	
	strStruct.sName = sReturnValue;	
	SetFirstName (strStruct.oItem, strStruct.sName);	
	
} // end of function

////////////////////////////////////////////
// * This function returns TRUE if the category of item that will appear as 
// * loot is a category that possibly could have a name added to it.
// * Some item categories do not need unique names added. For example, Gold,
// * Crafting Materials, Books, etc. already have unique names.
// 
int FW_Name_Does_Item_Need_Name (struct MyStruct strStruct)
{
	// Here I make a call to add a name to an item
	// if it is of the right category to get a name added.
	if (strStruct.nLootType ==  FW_ARMOR_BOOT ||
        strStruct.nLootType ==  FW_ARMOR_CLOTHING ||
	    strStruct.nLootType ==  FW_ARMOR_HEAVY ||
        strStruct.nLootType ==  FW_ARMOR_HELMET ||
	    strStruct.nLootType ==  FW_ARMOR_LIGHT ||
        strStruct.nLootType ==  FW_ARMOR_MEDIUM ||
	    strStruct.nLootType ==  FW_ARMOR_SHIELDS ||
        strStruct.nLootType ==  FW_WEAPON_AMMUNITION ||
	    strStruct.nLootType ==  FW_WEAPON_SIMPLE ||
        strStruct.nLootType ==  FW_WEAPON_MARTIAL ||
	    strStruct.nLootType ==  FW_WEAPON_EXOTIC ||
        strStruct.nLootType ==  FW_WEAPON_RANGED ||
	    strStruct.nLootType ==  FW_WEAPON_THROWN ||
        strStruct.nLootType ==  FW_MISC_CLOTHING ||
	    strStruct.nLootType ==  FW_MISC_JEWELRY ||
	    strStruct.nLootType ==  FW_MISC_GAUNTLET ||
	    strStruct.nLootType ==  FW_MISC_DAMAGE_SHIELD )
	{
		return TRUE;
	}	
	// If not one of the above categories then the item already has
	// a unique name and we return false.  
	return FALSE;
}

////////////////////////////////////////////
// * This function gets a random adjective from the file: "fw_cdaulepp_adjectives.2da"
// * By default this function will get any adjective in the fiel, but if you want
// * an adjective from a specific column you can do so by specifying sCategory.
// - sCategory can = "Any", "Size", "Touch", "Shape", "Time", "Quantity", "Sound",
//   "Taste", "Feelings_Bad", "Feelings_Good", "Condition", or "Appearance".
//
string FW_Name_Get_Random_Adjective (string sCategory = "Any")
{
	int nRoll;
	string sReturnValue;
	
	// If "Any" adjective is chosen, I randomly choose one of the columns in the
	// file fw_cdaulepp_adjectives.2da"
	if (sCategory == "Any")
	{
		nRoll = Random (11);
		switch (nRoll)
		{
			case 0: { sCategory = "Size";  break;		}
			case 1: { sCategory = "Touch"; break;		}
			case 2: { sCategory = "Shape"; break;		}
			case 3: { sCategory = "Time";  break;		}
			case 4: { sCategory = "Quantity"; break;	}
			case 5: { sCategory = "Sound"; break;		}
			case 6: { sCategory = "Taste"; break;		}
			case 7: { sCategory = "Feelings_Bad"; break;	}
			case 8: { sCategory = "Feelings_Good";break;	}
			case 9: { sCategory = "Condition"; break;		}
			case 10: { sCategory = "Appearance"; break;		}
					
			default: break;		
		} // end of switch
	} // end of if
	 
	if 		(sCategory ==  "Size")  		 {	nRoll = Random (37);
			sReturnValue = Get2DAString ("fw_cdaulepp_adjectives", sCategory, nRoll); 			}
			
	else if (sCategory ==  "Touch")			 {	nRoll = Random (20);
			sReturnValue = Get2DAString ("fw_cdaulepp_adjectives", sCategory, nRoll); 			}
				  
	else if (sCategory ==  "Shape") 	     {	nRoll = Random (17);
			sReturnValue = Get2DAString ("fw_cdaulepp_adjectives", sCategory, nRoll); 			}
			
	else if (sCategory ==  "Time")			 {	nRoll = Random (22);
			sReturnValue = Get2DAString ("fw_cdaulepp_adjectives", sCategory, nRoll); 			}
			
	else if (sCategory ==  "Quantity")		 {	nRoll = Random (38);
			sReturnValue = Get2DAString ("fw_cdaulepp_adjectives", sCategory, nRoll); 			}
		
	else if (sCategory ==  "Sound")			 {	nRoll = Random (25);
			sReturnValue = Get2DAString ("fw_cdaulepp_adjectives", sCategory, nRoll); 			}
			
	else if (sCategory ==  "Taste") 		 {	nRoll = Random (47);
			sReturnValue = Get2DAString ("fw_cdaulepp_adjectives", sCategory, nRoll); 			}
		
	else if (sCategory ==  "Feelings_Bad")   {	nRoll = Random (56);
			sReturnValue = Get2DAString ("fw_cdaulepp_adjectives", sCategory, nRoll); 			}
			
	else if (sCategory ==  "Feelings_Good")  {	nRoll = Random (54);
			sReturnValue = Get2DAString ("fw_cdaulepp_adjectives", sCategory, nRoll); 			}
		
	else if (sCategory ==  "Condition") 	 {	nRoll = Random (44);
			sReturnValue = Get2DAString ("fw_cdaulepp_adjectives", sCategory, nRoll); 			}
		
	else /* (sCategory ==  "Appearance") */	 {  nRoll = Random (95);
			sReturnValue = Get2DAString ("fw_cdaulepp_adjectives", sCategory, nRoll); 			}
			
	return sReturnValue;
}

////////////////////////////////////////////
// * This function gets a random noun from the file: "fw_cdaulepp_nouns.2da"
// * By default this function will get any noun in the file, but if you want
// * a noun from a specific column you can do so by specifying sCategory.
// - sCategory can = "Any", "Deity", "Nouns_Colors", "Nouns_Non_Proper",
//   "Nouns_Monsters", or "Nouns_Bodyparts".  
//
string FW_Name_Get_Random_Noun (string sCategory = "Any")
{
	int nRoll;
	string sReturnValue;
	
	// If "Any" noun is chosen, I randomly choose one of the columns in the
	// file fw_cdaulepp_nouns.2da".   
	if (sCategory == "Any")
	{
		// I am going to weight the categories because there is a hugely disproportionate
		// number of nouns in the various columns.  This will only matter if the category
		// is "Any".  A specific column can be set when calling this function by setting
		// sCategory equal to one of the column names, then that category's column is 
		// looked at and the "Any" portion of the code is bypassed.
		// 35% Deity
		//  5% Nouns_Color
		// 40% Nouns-non-proper
		// 15% Nouns_Monsters
		//  5% Nouns_Bodyparts
		nRoll = Random (100) + 1;
		
		     if ((nRoll >= 1) && (nRoll <= 35))     { sCategory = "Deity"; 				}
		else if ((nRoll >= 36) && (nRoll <= 40))    { sCategory = "Nouns_Colors";		}
		else if ((nRoll >= 41) && (nRoll <= 80))    { sCategory = "Nouns_Non_Proper";	}
		else if ((nRoll >= 81) && (nRoll <= 95))    { sCategory = "Nouns_Monsters";		}
		else /* ((nRoll >= 96) && (nRoll <= 100))*/ { sCategory = "Nouns_Bodyparts";	}
			
	} // end of if
	 
	// The Deity section is slightly different than all the rest because some Deities have
	// both first and last names.  Others have just a first name. So don't be alarmed
	// that the code here is different.  I have to query to see if the Deity has one or
	// two names.  
	if      (sCategory == "Deity")  		
		 	{	
				// All Deities have a first name, so pick one randomly.
				nRoll = Random (190);
				// Store the first name in sReturnValue
				sReturnValue = Get2DAString ("fw_cdaulepp_nouns", "Deity_First_Name", nRoll);
				// Now check to see if the Deity has a last name
				string sLastName = Get2DAString ("fw_cdaulepp_nouns", "Deity_Last_Name", nRoll);
				// If the Deity does NOT have a last name then
				// I can return just the first name. 				
				if (sLastName == "")  
				{ 
					return sReturnValue;	
				}
				// Otherwise, the Deity rolled has a last name.
				else 
				{ 	
					sReturnValue = sReturnValue + " " + sLastName;
				}
			} // end of if
			
	else if (sCategory ==  "Nouns_Colors")			 {	nRoll = Random (17);
			sReturnValue = Get2DAString ("fw_cdaulepp_nouns", sCategory, nRoll); 	}
				  
	else if (sCategory ==  "Nouns_Non_Proper") 	     {	nRoll = Random (277);
			sReturnValue = Get2DAString ("fw_cdaulepp_nouns", sCategory, nRoll); 	}
			
	else if (sCategory ==  "Nouns_Monsters")		 {	nRoll = Random (95);
			sReturnValue = Get2DAString ("fw_cdaulepp_nouns", sCategory, nRoll); 	}
			
	else /* (sCategory ==  "Nouns_Bodyparts") */	 {	nRoll = Random (33);
			sReturnValue = Get2DAString ("fw_cdaulepp_nouns", sCategory, nRoll); 	}
			
	return sReturnValue;
}

////////////////////////////////////////////
// * This function gets a random class name and returns it
//
string FW_Name_Get_Random_Class ()
{
	int nRoll;
	string sReturnValue;
	
	// As of May 11, 2008 there are 36 classes in NWN 2 (including MotB).
	nRoll = Random (36) + 1;
	switch (nRoll)
	{
		case 1: sReturnValue = "Barbarian";
			break;
		case 2: sReturnValue = "Bard";
			break;
		case 3: sReturnValue = "Cleric";
			break;
		case 4: sReturnValue = "Druid";
			break;
		case 5: sReturnValue = "Fighter";
			break;
		case 6: sReturnValue = "Monk";
			break;
		case 7: sReturnValue = "Paladin";
			break;
		case 8: sReturnValue = "Ranger";
			break;
		case 9: sReturnValue = "Rogue";
			break;
		case 10: sReturnValue = "Sorcerer";
			break;
		case 11: sReturnValue = "Warlock";
			break;
		case 12: sReturnValue = "Wizard";
			break;
		case 13: sReturnValue = "Arcane Archer";
			break;
		case 14: sReturnValue = "Arcane Trickster";
			break;
		case 15: sReturnValue = "Assassin";
			break;
		case 16: sReturnValue = "Blackguard";
			break;
		case 17: sReturnValue = "Divine Champion";
			break;
		case 18: sReturnValue = "Duelist";
			break;
		case 19: sReturnValue = "Dwarven Defender";
			break;
		case 20: sReturnValue = "Eldritch Knight";
			break;
		case 21: sReturnValue = "Frenzied Berserker";
			break;
		case 22: sReturnValue = "Harper Agent";
			break;
		case 23: sReturnValue = "Pale Master";
			break;
		case 24: sReturnValue = "Red Dragon Disciple";
			break;
		case 25: sReturnValue = "Shadow Thief of Amn";
			break;
		case 26: sReturnValue = "Shadowdancer";
			break;
		case 27: sReturnValue = "Warpriest";
			break;
		case 28: sReturnValue = "Weapon Master";
			break;
		case 29: sReturnValue = "Neverwinter Nine";
			break;
		case 30: sReturnValue = "Favored Soul";
			break;
		case 31: sReturnValue = "Spirit Shaman";
			break;
		case 32: sReturnValue = "Arcane Scholar of Candlekeep";
			break;
		case 33: sReturnValue = "Invisible Blade";
			break;
		case 34: sReturnValue = "Red Wizard of Thay";
			break;
		case 35: sReturnValue = "Sacred Fist";
			break;
		case 36: sReturnValue = "Stormlord";
			break;
		
		default: break;	
	}	
	return sReturnValue;
}
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
// This file contains all the functions that create item properties. 
// Based off of the range for min and max chosen by the end-user, each
// item property function chooses a random value and returns the 
// chosen item property. 

// *****************************************
//
//              MAIN
//
// *****************************************
// I shouldn't need a main because this will be a starting conditional. 

// *****************************************
//
//       UPDATES TO ORIGINAL VERSION
//
// *****************************************
//
// VERSION 2.0 UPDATES
// -12 May 2008.  A real quick update so that itemproperty bonus spell
//     uses a new random roll = the number of spells from the original
//     NWN 2 + Mask of the Betrayer.  All the functions in this file 
//     were updated (if needed) so they would roll the correct number.
//
// -12 May 2008.  Updated the function that gets Bonus Feats.  Although
//     there are a lot more than 27 feats to choose from, in NWN 2, you 
//     you can only add a very limited number of feats dynamically to items.
//	   The change here reflects this.
//
// -28 March 2008.  Added 7 functions to control darkvision, freedom of
//     movement, haste, holy avenger, improved evasion, keen, and true seeing.  
//     These item properties were previously not checked to see if they
//     are allowed or not.  Now they are checked.
//
// VERSION 1.2 UPDATES
// -28 August 2007.  Added formula based scaling for the item property
//	   functions.  End-users indirectly set min and max values through
//     modifiers in the file "fw_inc_cr_scaling_formulas".  This sets
//     the range allowed and then the functions in this file choose an 
//     acceptable value within that range.
//
// VERSION 1.1 UPDATES
// -27 July 2007.  Added CR based scaling for the item property functions.
// 	   End-users set min and max values in the file "fw_inc_cr_scaling_constants"
//     for each CR and for each item property.  This sets the range allowed.
//     I had to change the function declarations to get rid of the old constants
// 	   and in their place I pass in the monster's CR.  


// *****************************************
//
//              INCLUDED FILES
//
// *****************************************
#include "x2_inc_itemprop"
// I need the switches to see if something was allowed / disallowed
#include "fw_inc_loot_switches"

// I need the min / max constants for each IP
#include "fw_inc_cr_scaling_constants"
// I need the formula based cr scaling constants
#include "fw_inc_cr_scaling_formulas"

// *****************************************
//
//
//              FUNCTION DECLARATIONS
//
//
// *****************************************
////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_DAMAGEBONUS_* from min to max.
// * NOT to be confused with DAMAGE_BONUS_* (used for damage shields)
//
// TABLE: IP_CONST_DAMAGEBONUS
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
int FW_Choose_IP_CONST_DAMAGEBONUS (int min, int max);

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_DAMAGETYPE_*
//
int FW_Choose_IP_CONST_DAMAGETYPE ();

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_ALIGNMENTGROUP_*
//
int FW_Choose_IP_CONST_ALIGNMENTGROUP ();

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_RACIALTYPE_*
//
int FW_Choose_IP_CONST_RACIALTYPE ();

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_ALIGNMENT_*
//
int FW_Choose_IP_CONST_SALIGN ();

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_CLASS_*
//
int FW_Choose_IP_CONST_CLASS ();

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_DAMAGEREDUCTION_* subject to
// * min and max values. Acceptable values for min and max are: 1,2,3,...,20
//
int FW_Choose_IP_CONST_DAMAGEREDUCTION (int min, int max);

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_DAMAGESOAK_* subject to min and
// * max values.  Acceptable values for min and max are: 5,10,15,...,50
//
int FW_Choose_IP_CONST_DAMAGESOAK (int min, int max);

////////////////////////////////////////////
// * Function that randomly chooses an ability bonus type and amount.  You can
// * specify the min or max if you want, but any value less than 1 is changed to
// * 1 and any value greater than 12 is changed to 12.
//
itemproperty FW_Choose_IP_Ability_Bonus (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an Armor Class bonus.  Values for min and
// * max should be an integer between 1 and 20.  The type of bonus depends on
// * the item it is being applied to.
//
itemproperty FW_Choose_IP_AC_Bonus (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an Armor Class bonus vs. an alignment group.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_AC_Bonus_Vs_Align (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an Armor Class bonus vs. damage type.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_AC_Bonus_Vs_Damage_Type (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an Armor Class bonus vs. race.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_AC_Bonus_Vs_Race (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an Armor Class bonus vs. SPECIFIC alignment.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_AC_Bonus_Vs_SAlign (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an Arcane Spell Failure.
//
itemproperty FW_Choose_IP_Arcane_Spell_Failure ();

////////////////////////////////////////////
// * Function that randomly chooses an Attack bonus.  Values for min and
// * max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Attack_Bonus (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an Attack bonus vs. an alignment group.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Attack_Bonus_Vs_Align (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an attack bonus vs. race.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Attack_Bonus_Vs_Race (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an Attack bonus vs. SPECIFIC alignment.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Attack_Bonus_Vs_SAlign (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an Attack penalty.  Values for min and
// * max should be an integer between 1 and 5. Yes that is right. 5 is the max.
//
itemproperty FW_Choose_IP_Attack_Penalty (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses a feat to add to an item.
// * By default ALL bonus feats are allowed.
//
itemproperty FW_Choose_IP_Bonus_Feat ();

////////////////////////////////////////////
// * Function that chooses a random amount of bonus hit points to add to an item
// * min and max should be positive integers between 1 and 50.  Because of how
// * the item property bonus hit points is implemented in NWN 2, it goes like
// * this:  1,2,3,...,20, 25, 30, 35, 40, 45, 50.
//
itemproperty FW_Choose_IP_Bonus_Hit_Points (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses a bonus spell of level 0...9 to be added to
// * an item.  Values for min and max should be an integer between 0 and 9.
//
itemproperty FW_Choose_IP_Bonus_Level_Spell(int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses a bonus saving throw to add to an item.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Bonus_Saving_Throw (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses a bonus saving throw VS 'XYZ' to add to an
// * Item. Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Bonus_Saving_Throw_VsX (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses a bonus spell resistance to add to an item.
// * Values for min and max should be an integer between 10 and 32 in even
// * increments of 2. I.E. 10,12,14,16,18,20,22,24,26,28,30,32
//
itemproperty FW_Choose_IP_Bonus_Spell_Resistance (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses a spell to be added to an item as a cast
// * spell item property.
//
itemproperty FW_Choose_IP_Cast_Spell ();

////////////////////////////////////////////
// * Function that randomly chooses a damage type and damage bonus to be added
// * to an item.
//
itemproperty FW_Choose_IP_Damage_Bonus (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an alignment group, damage type, and damage
// * bonus to be added to an item.
//
itemproperty FW_Choose_IP_Damage_Bonus_Vs_Align (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses a race, damage type, and damage
// * bonus to be added to an item.
//
itemproperty FW_Choose_IP_Damage_Bonus_Vs_Race (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses a specific alignment, damage type, and damage
// * bonus to be added to an item.
//
itemproperty FW_Choose_IP_Damage_Bonus_Vs_SAlign (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses a damage type and damage immunity amount to
// * be added to an item.
//
itemproperty FW_Choose_IP_Damage_Immunity ();

////////////////////////////////////////////
// * Function that randomly chooses a damage penalty.  Values for min and
// * max should be an integer between 1 and 5. Yes that is right. 5 is the max.
//
itemproperty FW_Choose_IP_Damage_Penalty (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an enhancement level that is required to get
// * past the damage reduction as well as choosing the amount of hit points that
// * will be absorbed if the weapon is not of high enough enhancement.
//
itemproperty FW_Choose_IP_Damage_Reduction (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an amount of hit points that will be
// * resisted each round, subject to min and max values. Acceptable values for
// * min and max are: 5,10,15,...,50
//
itemproperty FW_Choose_IP_Damage_Resistance (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses a damage type and damage vulnerability
// * amount to be added to an item.
//
itemproperty FW_Choose_IP_Damage_Vulnerability ();

////////////////////////////////////////////
// * Function that returns the item property darvision (to be added to an item)
// * if darkvision is an allowed property.
//
itemproperty FW_Choose_IP_Darkvision ();

////////////////////////////////////////////
// * Function that randomly chooses an ability penalty type and amount.  You can
// * specify the min or max if you want, but any value less than 1 is changed to
// * 1 and any value greater than 10 is changed to 10.  Use ONLY positive
// * integers.  I.E. 1 = -1 penalty, 2 = -2 penalty, etc.
//
itemproperty FW_Choose_IP_Decrease_Ability (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an Armor Class type and penalty (subject to
// * min and max values.  Use only POSITIVE integers for min and max. 1...5
//
itemproperty FW_Choose_IP_Decrease_AC (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly decreases a skill between 1 and 10 points.
// * Acceptable values for min and max must be POSITIVE integers: 1,2,3,...,10
//
itemproperty FW_Choose_IP_Decrease_Skill (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an Enhancement bonus.  Values for min and
// * max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Enhancement_Bonus (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an Enhancement bonus vs. an alignment group.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Enhancement_Bonus_Vs_Align (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an attack bonus vs. race.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Enhancement_Bonus_Vs_Race (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an Enhancement bonus vs. SPECIFIC alignment.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Enhancement_Bonus_Vs_SAlign (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses an Enhancement penalty.  Values for min and
// * max should be an integer between 1 and 5. Yes that is right. 5 is the max.
//
itemproperty FW_Choose_IP_Enhancement_Penalty (int nCR = 0);

////////////////////////////////////////////
// * Function that chooses a base damage type to be added to a melee weapon.
// * Only adds Bludgeoning, Slashing, or Piercing damage to a weapon.
//
itemproperty FW_Choose_IP_Extra_Melee_Damage_Type ();

////////////////////////////////////////////
// * Function that chooses a base damage type to be added to a ranged weapon.
// * Only adds Bludgeoning, Slashing, or Piercing damage to a weapon.
//
itemproperty FW_Choose_IP_Extra_Range_Damage_Type ();

////////////////////////////////////////////
// * Function that returns the item property freedom of movement only
// * if freedom of movement is an allowed property.
//
itemproperty FW_Choose_IP_Freedom_Of_Movement ();

////////////////////////////////////////////
// * Function that returns the item property haste only
// * if haste is an allowed property.
//
itemproperty FW_Choose_IP_Haste ();

////////////////////////////////////////////
// * Function that chooses the level of a healer's kit subject to min and max.
// * Min and Max must be positive integers between 1 and 12:  1,2,3,...,12
//
itemproperty FW_Choose_IP_Healer_Kit (int nCR = 0);

////////////////////////////////////////////
// * Function that returns the item property holy avenger only
// * if holy avenger is an allowed property.
//
itemproperty FW_Choose_IP_Holy_Avenger ();

////////////////////////////////////////////
// * Function that chooses a miscellaneous immunity property for an item.
//
itemproperty FW_Choose_IP_Immunity_Misc ();

////////////////////////////////////////////
// * Function that chooses an immunity to spell level for an item.  The user
// * becomes immune to all spells of the number chosen and below. Acceptable
// * values for min and max are integers from 1 to 9.  0 is NOT acceptable.
//
itemproperty FW_Choose_IP_Immunity_To_Spell_Level (int nCR = 0);

////////////////////////////////////////////
// * Function that returns the item property improved evasion only
// * if improved evasion is an allowed property.
//
itemproperty FW_Choose_IP_Improved_Evasion ();

////////////////////////////////////////////
// * Function that returns the item property keen only
// * if keen is an allowed property.
//
itemproperty FW_Choose_IP_Keen ();

////////////////////////////////////////////
// * Function that chooses a color and brightness of light to be added to an
// * item.
//
itemproperty FW_Choose_IP_Light();

////////////////////////////////////////////
// * Function that limits an item's use to a certain Alignment GROUP.
//
itemproperty FW_Choose_IP_Limit_Use_By_Align ();

////////////////////////////////////////////
// * Function that limits an item's use to a certain Class.
//
itemproperty FW_Choose_IP_Limit_Use_By_Class ();

////////////////////////////////////////////
// * Function that limits an item's use to a certain Race.
//
itemproperty FW_Choose_IP_Limit_Use_By_Race ();

////////////////////////////////////////////
// * Function that limits an item's use to a certain SPECIFIC alignment.
//
itemproperty FW_Choose_IP_Limit_Use_By_SAlign ();

////////////////////////////////////////////
// * Function that chooses an amount of massive critical dmg. bonus to be added
// * to an item.  Min and Max must be POSITIVE integers between 0 and 19. See
// * the table: DAMAGE_BONUS for how to set these values to something different
// * than the default.
//
itemproperty FW_Choose_IP_Massive_Critical (int nCR = 0);

////////////////////////////////////////////
// * Function that chooses the Mighty Bonus on a ranged weapon (the maximum
// * strength bonus allowed.  min and max must be positive integers. 1...20
//
itemproperty FW_Choose_IP_Mighty (int nCR = 0);

////////////////////////////////////////////
// * Function that chooses an OnHitCastSpell to be added to an item. Obviously
// * this only works on weapons and armors.
//
itemproperty FW_Choose_IP_On_Hit_Cast_Spell (int nCR = 0);

////////////////////////////////////////////
// * Function that chooses an OnHitProps to be added to an item. Obviously
// * this only works on weapons and armors.
//
itemproperty FW_Choose_IP_On_Hit_Props (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses a saving throw penalty to add to an item.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Reduced_Saving_Throw (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses a bonus saving throw VS 'XYZ' to add to an
// * Item. Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Reduced_Saving_Throw_VsX (int nCR = 0);

////////////////////////////////////////////
// * Function that chooses a regeneration bonus that an item can have.  Subject
// * to min and max values as defined.  Limits for min and max are positive
// * integers between 1 and 20:  1,2,3,...,20
//
itemproperty FW_Choose_IP_Regeneration (int nCR = 0);

////////////////////////////////////////////
// * Function that chooses a skill bonus type and amount to be added to an item.
// * Limits for min and max are 1 and 50:  1,2,3,...,50
//
itemproperty FW_Choose_IP_Skill_Bonus (int nCR = 0);

////////////////////////////////////////////
// * Function that chooses a random spell school immunity to give to an item.
//
itemproperty FW_Choose_IP_Spell_Immunity_School ();

////////////////////////////////////////////
// * Function that chooses a random specific spell immunity to give to an item.
//
itemproperty FW_Choose_IP_Spell_Immunity_Specific ();

////////////////////////////////////////////
// * Function that chooses the thieves tools modifier to be added to an item.
// * You can specify the min or max if you want, but any value less than 1 is
// * changed to 1 and any value greater than 12 is changed to 12.
//
itemproperty FW_Choose_IP_Thieves_Tools (int nCR = 0);

////////////////////////////////////////////
// * Function that returns the item property true seeing only
// * if true seeing is an allowed property.
//
itemproperty FW_Choose_IP_True_Seeing ();

////////////////////////////////////////////
// * Function that chooses a random amount of turn resistance to be added to an
// * item. Limits for min and max are 1 and 50:  1,2,3,...,50
//
itemproperty FW_Choose_IP_Turn_Resistance (int nCR = 0);

////////////////////////////////////////////
// * Function that chooses the unlimited ammo item property and also the amount
// * (if any) of extra damage that will be done.
//
itemproperty FW_Choose_IP_Unlimited_Ammo ();

////////////////////////////////////////////
// * Function that chooses a vampiric regeneration bonus that an item can have.
// * Limits for min and max are positive integers: 1,2,3,...,20
//
itemproperty FW_Choose_IP_Vampiric_Regeneration (int nCR = 0);

////////////////////////////////////////////
// * Function that randomly chooses a weight increase to be added to an item
// * from the IP_CONST_WEIGHTINCREASE_* values.  Possible return values are: 5,
// * 10, 15, 30, 50, and 100 pounds.
//
itemproperty FW_Choose_IP_Weight_Increase ();

////////////////////////////////////////////
// * Function that randomly chooses a weight reduction % to be added to an item.
// * Possible return values are: 10%, 20%, 40%, 60%, and 80%.
//
itemproperty FW_Choose_IP_Weight_Reduction ();


// *****************************************
//
//
//              IMPLEMENTATION
//
//
// *****************************************

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_DAMAGEBONUS_* from min to max.
// * NOT to be confused with DAMAGE_BONUS_* (used for damage shields)
//
// TABLE: IP_CONST_DAMAGEBONUS
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
int FW_Choose_IP_CONST_DAMAGEBONUS (int min, int max)
{   
   int nRoll;
   int nDamage;
   if (min < 0)
      min = 0;
   if (min > 19)
      min = 19;
   if (max < 0)
      max = 0;
   if (max > 19)
      max = 19;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
   {
      nDamage = IP_CONST_DAMAGEBONUS_1;
   }
   else
   {
      int nValue = max - min + 1;
      nRoll = Random(nValue)+ min;
   }

   switch (nRoll)
   {
      case 0: nDamage = IP_CONST_DAMAGEBONUS_1;
         break;
      case 1: nDamage = IP_CONST_DAMAGEBONUS_2;
         break;
      case 2: nDamage = IP_CONST_DAMAGEBONUS_1d4;
         break;
      case 3: nDamage = IP_CONST_DAMAGEBONUS_3;
         break;
      case 4: nDamage = IP_CONST_DAMAGEBONUS_1d6;
         break;
      case 5: nDamage = IP_CONST_DAMAGEBONUS_4;
         break;
      case 6: nDamage = IP_CONST_DAMAGEBONUS_1d8;
         break;
      case 7: nDamage = IP_CONST_DAMAGEBONUS_5;
         break;
      case 8: nDamage = IP_CONST_DAMAGEBONUS_2d4;
         break;
      case 9: nDamage = IP_CONST_DAMAGEBONUS_1d10;
         break;
      case 10: nDamage = IP_CONST_DAMAGEBONUS_6;
         break;
      case 11: nDamage = IP_CONST_DAMAGEBONUS_1d12;
         break;
      case 12: nDamage = IP_CONST_DAMAGEBONUS_7;
         break;
      case 13: nDamage = IP_CONST_DAMAGEBONUS_2d6;
         break;
      case 14: nDamage = IP_CONST_DAMAGEBONUS_8;
         break;
      case 15: nDamage = IP_CONST_DAMAGEBONUS_9;
         break;
      case 16: nDamage = IP_CONST_DAMAGEBONUS_2d8;
         break;
      case 17: nDamage = IP_CONST_DAMAGEBONUS_10;
         break;
      case 18: nDamage = IP_CONST_DAMAGEBONUS_2d10;
         break;
      case 19: nDamage = IP_CONST_DAMAGEBONUS_2d12;
         break;
      default: break;
   }
   return nDamage;
}

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_DAMAGETYPE_*
//
int FW_Choose_IP_CONST_DAMAGETYPE ()
{
   int nDamageType;
   int nRoll = Random (12);
   switch (nRoll)
   {
      case 0: nDamageType = IP_CONST_DAMAGETYPE_BLUDGEONING;
         break;
      case 1: nDamageType = IP_CONST_DAMAGETYPE_PIERCING;
         break;
      case 2: nDamageType = IP_CONST_DAMAGETYPE_SLASHING;
         break;
      case 3: nDamageType = IP_CONST_DAMAGETYPE_ACID;
         break;
      case 4: nDamageType = IP_CONST_DAMAGETYPE_COLD;
         break;
      case 5: nDamageType = IP_CONST_DAMAGETYPE_ELECTRICAL;
         break;
      case 6: nDamageType = IP_CONST_DAMAGETYPE_FIRE;
         break;
      case 7: nDamageType = IP_CONST_DAMAGETYPE_SONIC;
         break;
      case 8: nDamageType = IP_CONST_DAMAGETYPE_NEGATIVE;
         break;
      case 9: nDamageType = IP_CONST_DAMAGETYPE_POSITIVE;
         break;
      case 10: nDamageType = IP_CONST_DAMAGETYPE_DIVINE;
         break;
      case 11: nDamageType = IP_CONST_DAMAGETYPE_MAGICAL;
         break;
      default: break;
   }
   return nDamageType;
}

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_ALIGNMENTGROUP_*
//
int FW_Choose_IP_CONST_ALIGNMENTGROUP ()
{
   int nAlignGroup;
   int nRoll = Random (6);
   switch (nRoll)
   {
      case 0: nAlignGroup = IP_CONST_ALIGNMENTGROUP_ALL;
         break;
      case 1: nAlignGroup = IP_CONST_ALIGNMENTGROUP_CHAOTIC;
         break;
      case 2: nAlignGroup = IP_CONST_ALIGNMENTGROUP_EVIL;
         break;
      case 3: nAlignGroup = IP_CONST_ALIGNMENTGROUP_GOOD;
         break;
      case 4: nAlignGroup = IP_CONST_ALIGNMENTGROUP_LAWFUL;
         break;
      case 5: nAlignGroup = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
         break;
      default: break;
   } // end of switch
   return nAlignGroup;
}

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_RACIALTYPE_*
//
int FW_Choose_IP_CONST_RACIALTYPE ()
{
   int nRace;
   int nRoll = Random (24);
   switch (nRoll)
   {
      case 0: nRace = IP_CONST_RACIALTYPE_ABERRATION;
         break;
      case 1: nRace = IP_CONST_RACIALTYPE_ANIMAL;
         break;
      case 2: nRace = IP_CONST_RACIALTYPE_BEAST;
         break;
      case 3: nRace = IP_CONST_RACIALTYPE_CONSTRUCT;
         break;
      case 4: nRace = IP_CONST_RACIALTYPE_DRAGON;
         break;
      case 5: nRace = IP_CONST_RACIALTYPE_DWARF;
         break;
      case 6: nRace = IP_CONST_RACIALTYPE_ELEMENTAL;
         break;
      case 7: nRace = IP_CONST_RACIALTYPE_ELF;
         break;
      case 8: nRace = IP_CONST_RACIALTYPE_FEY;
         break;
      case 9: nRace = IP_CONST_RACIALTYPE_GIANT;
         break;
      case 10: nRace = IP_CONST_RACIALTYPE_GNOME;
         break;
      case 11: nRace = IP_CONST_RACIALTYPE_HALFELF;
         break;
      case 12: nRace = IP_CONST_RACIALTYPE_HALFLING;
         break;
      case 13: nRace = IP_CONST_RACIALTYPE_HALFORC;
         break;
      case 14: nRace = IP_CONST_RACIALTYPE_HUMAN;
         break;
      case 15: nRace = IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID;
         break;
      case 16: nRace = IP_CONST_RACIALTYPE_HUMANOID_MONSTROUS;
         break;
      case 17: nRace = IP_CONST_RACIALTYPE_HUMANOID_ORC;
         break;
      case 18: nRace = IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN;
         break;
      case 19: nRace = IP_CONST_RACIALTYPE_MAGICAL_BEAST;
         break;
      case 20: nRace = IP_CONST_RACIALTYPE_OUTSIDER;
         break;
      case 21: nRace = IP_CONST_RACIALTYPE_SHAPECHANGER;
         break;
      case 22: nRace = IP_CONST_RACIALTYPE_UNDEAD;
         break;
      case 23: nRace = IP_CONST_RACIALTYPE_VERMIN;
         break;
      default: break;
   } // end of switch
   return nRace;
}

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_ALIGNMENT_*
//
int FW_Choose_IP_CONST_SALIGN ()
{
   int nAlign;
   int nRoll = Random (9);
   switch (nRoll)
   {
      case 0: nAlign = IP_CONST_ALIGNMENT_CE;
         break;
      case 1: nAlign = IP_CONST_ALIGNMENT_CG;
         break;
      case 2: nAlign = IP_CONST_ALIGNMENT_CN;
         break;
      case 3: nAlign = IP_CONST_ALIGNMENT_LE;
         break;
      case 4: nAlign = IP_CONST_ALIGNMENT_LG;
         break;
      case 5: nAlign = IP_CONST_ALIGNMENT_LN;
         break;
      case 6: nAlign = IP_CONST_ALIGNMENT_NE;
         break;
      case 7: nAlign = IP_CONST_ALIGNMENT_NG;
         break;
      case 8: nAlign = IP_CONST_ALIGNMENT_TN;
         break;
      default: break;
   } // end of switch
   return nAlign;
}

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_CLASS_*
//
int FW_Choose_IP_CONST_CLASS ()
{
   int nClass;
   int nRoll = Random (11);
   switch (nRoll)
   {
      case 0: nClass = IP_CONST_CLASS_BARBARIAN;
         break;
      case 1: nClass = IP_CONST_CLASS_BARD;
         break;
      case 2: nClass = IP_CONST_CLASS_CLERIC;
         break;
      case 3: nClass = IP_CONST_CLASS_DRUID;
         break;
      case 4: nClass = IP_CONST_CLASS_FIGHTER;
         break;
      case 5: nClass = IP_CONST_CLASS_MONK;
         break;
      case 6: nClass = IP_CONST_CLASS_PALADIN;
         break;
      case 7: nClass = IP_CONST_CLASS_RANGER;
         break;
      case 8: nClass = IP_CONST_CLASS_ROGUE;
         break;
      case 9: nClass = IP_CONST_CLASS_SORCERER;
         break;
      case 10: nClass = IP_CONST_CLASS_WIZARD;
         break;
      default: break;
   } // end of switch
   return nClass;
}

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_DAMAGEREDUCTION_* subject to
// * min and max values. Acceptable values for min and max are: 1,2,3,...,20
//
int FW_Choose_IP_CONST_DAMAGEREDUCTION (int min, int max)
{
   itemproperty ipAdd;
   
   int nRoll;
   int nReturnValue;
   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nReturnValue = IP_CONST_DAMAGEREDUCTION_1;  }
   else
   {
      int nValue = max - min + 1;
      nRoll = Random(nValue) + min;
   }
   switch (nRoll)
   {
      case 1: nReturnValue = IP_CONST_DAMAGEREDUCTION_1;
         break;
      case 2: nReturnValue = IP_CONST_DAMAGEREDUCTION_2;
         break;
      case 3: nReturnValue = IP_CONST_DAMAGEREDUCTION_3;
         break;
      case 4: nReturnValue = IP_CONST_DAMAGEREDUCTION_4;
         break;
      case 5: nReturnValue = IP_CONST_DAMAGEREDUCTION_5;
         break;
      case 6: nReturnValue = IP_CONST_DAMAGEREDUCTION_6;
         break;
      case 7: nReturnValue = IP_CONST_DAMAGEREDUCTION_7;
         break;
      case 8: nReturnValue = IP_CONST_DAMAGEREDUCTION_8;
         break;
      case 9: nReturnValue = IP_CONST_DAMAGEREDUCTION_9;
         break;
      case 10: nReturnValue = IP_CONST_DAMAGEREDUCTION_10;
         break;
      case 11: nReturnValue = IP_CONST_DAMAGEREDUCTION_11;
         break;
      case 12: nReturnValue = IP_CONST_DAMAGEREDUCTION_12;
         break;
      case 13: nReturnValue = IP_CONST_DAMAGEREDUCTION_13;
         break;
      case 14: nReturnValue = IP_CONST_DAMAGEREDUCTION_14;
         break;
      case 15: nReturnValue = IP_CONST_DAMAGEREDUCTION_15;
         break;
      case 16: nReturnValue = IP_CONST_DAMAGEREDUCTION_16;
         break;
      case 17: nReturnValue = IP_CONST_DAMAGEREDUCTION_17;
         break;
      case 18: nReturnValue = IP_CONST_DAMAGEREDUCTION_18;
         break;
      case 19: nReturnValue = IP_CONST_DAMAGEREDUCTION_19;
         break;
      case 20: nReturnValue = IP_CONST_DAMAGEREDUCTION_20;
         break;

      default: nReturnValue = IP_CONST_DAMAGEREDUCTION_1;
         break;
   }// end of switch
   return nReturnValue;
}

////////////////////////////////////////////
// * Function that randomly chooses an IP_CONST_DAMAGESOAK_* subject to min and
// * max values.  Acceptable values for min and max are: 5,10,15,...,50
//
int FW_Choose_IP_CONST_DAMAGESOAK (int min, int max)
{
   itemproperty ipAdd;
   
   int nRoll;
   int nReturnValue;
   if (min < 5)
      min = 5;
   if (min > 50)
      min = 50;
   if (max < 5)
      max = 5;
   if (max > 50)
      max = 50;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nReturnValue = IP_CONST_DAMAGESOAK_5_HP;  }
   else
   {
      int nValue = (max/5) - (min/5) + 1;
      nRoll = Random(nValue) + (min/5) - 1;
   }
   switch (nRoll)
   {
      case 0: nReturnValue = IP_CONST_DAMAGESOAK_5_HP;
         break;
      case 1: nReturnValue = IP_CONST_DAMAGESOAK_10_HP;
         break;
      case 2: nReturnValue = IP_CONST_DAMAGESOAK_15_HP;
         break;
      case 3: nReturnValue = IP_CONST_DAMAGESOAK_20_HP;
         break;
      case 4: nReturnValue = IP_CONST_DAMAGESOAK_25_HP;
         break;
      case 5: nReturnValue = IP_CONST_DAMAGESOAK_30_HP;
         break;
      case 6: nReturnValue = IP_CONST_DAMAGESOAK_35_HP;
         break;
      case 7: nReturnValue = IP_CONST_DAMAGESOAK_40_HP;
         break;
      case 8: nReturnValue = IP_CONST_DAMAGESOAK_45_HP;
         break;
      case 9: nReturnValue = IP_CONST_DAMAGESOAK_50_HP;
         break;
      default: nReturnValue = IP_CONST_DAMAGESOAK_5_HP;
         break;
   }
   return nReturnValue;
}


////////////////////////////////////////////
// * Function that randomly chooses an ability bonus type and amount.  You can
// * specify the min or max if you want, but any value less than 1 is changed to
// * 1 and any value greater than 12 is changed to 12.
//
itemproperty FW_Choose_IP_Ability_Bonus (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_ABILITY_BONUS == FALSE)
      return ipAdd;
   int min;
   int max;
   
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_ABILITY_BONUS_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_ABILITY_BONUS_MODIFIER) + 1;
   }
   else
   {   
   switch (nCR)
   {
		case 0: min = FW_MIN_ABILITY_BONUS_CR_0 ; max = FW_MAX_ABILITY_BONUS_CR_0 ;    break;
		
		case 1: min = FW_MIN_ABILITY_BONUS_CR_1 ; max = FW_MAX_ABILITY_BONUS_CR_1 ;    break;
		case 2: min = FW_MIN_ABILITY_BONUS_CR_2 ; max = FW_MAX_ABILITY_BONUS_CR_2 ;    break;
		case 3: min = FW_MIN_ABILITY_BONUS_CR_3 ; max = FW_MAX_ABILITY_BONUS_CR_3 ;    break;
   		case 4: min = FW_MIN_ABILITY_BONUS_CR_4 ; max = FW_MAX_ABILITY_BONUS_CR_4 ;    break;
		case 5: min = FW_MIN_ABILITY_BONUS_CR_5 ; max = FW_MAX_ABILITY_BONUS_CR_5 ;    break;
		case 6: min = FW_MIN_ABILITY_BONUS_CR_6 ; max = FW_MAX_ABILITY_BONUS_CR_6 ;    break;
   		case 7: min = FW_MIN_ABILITY_BONUS_CR_7 ; max = FW_MAX_ABILITY_BONUS_CR_7 ;    break;
		case 8: min = FW_MIN_ABILITY_BONUS_CR_8 ; max = FW_MAX_ABILITY_BONUS_CR_8 ;    break;
		case 9: min = FW_MIN_ABILITY_BONUS_CR_9 ; max = FW_MAX_ABILITY_BONUS_CR_9 ;    break;
   		case 10: min = FW_MIN_ABILITY_BONUS_CR_10 ; max = FW_MAX_ABILITY_BONUS_CR_10 ; break;
		
		case 11: min = FW_MIN_ABILITY_BONUS_CR_11 ; max = FW_MAX_ABILITY_BONUS_CR_11 ;  break;
		case 12: min = FW_MIN_ABILITY_BONUS_CR_12 ; max = FW_MAX_ABILITY_BONUS_CR_12 ;  break;
		case 13: min = FW_MIN_ABILITY_BONUS_CR_13 ; max = FW_MAX_ABILITY_BONUS_CR_13 ;  break;
   		case 14: min = FW_MIN_ABILITY_BONUS_CR_14 ; max = FW_MAX_ABILITY_BONUS_CR_14 ;  break;
		case 15: min = FW_MIN_ABILITY_BONUS_CR_15 ; max = FW_MAX_ABILITY_BONUS_CR_15 ;  break;
		case 16: min = FW_MIN_ABILITY_BONUS_CR_16 ; max = FW_MAX_ABILITY_BONUS_CR_16 ;  break;
   		case 17: min = FW_MIN_ABILITY_BONUS_CR_17 ; max = FW_MAX_ABILITY_BONUS_CR_17 ;  break;
		case 18: min = FW_MIN_ABILITY_BONUS_CR_18 ; max = FW_MAX_ABILITY_BONUS_CR_18 ;  break;
		case 19: min = FW_MIN_ABILITY_BONUS_CR_19 ; max = FW_MAX_ABILITY_BONUS_CR_19 ;  break;
   		case 20: min = FW_MIN_ABILITY_BONUS_CR_20 ; max = FW_MAX_ABILITY_BONUS_CR_20 ;  break;
   
   		case 21: min = FW_MIN_ABILITY_BONUS_CR_21 ; max = FW_MAX_ABILITY_BONUS_CR_21 ;  break;
		case 22: min = FW_MIN_ABILITY_BONUS_CR_22 ; max = FW_MAX_ABILITY_BONUS_CR_22 ;  break;
		case 23: min = FW_MIN_ABILITY_BONUS_CR_23 ; max = FW_MAX_ABILITY_BONUS_CR_23 ;  break;
   		case 24: min = FW_MIN_ABILITY_BONUS_CR_24 ; max = FW_MAX_ABILITY_BONUS_CR_24 ;  break;
		case 25: min = FW_MIN_ABILITY_BONUS_CR_25 ; max = FW_MAX_ABILITY_BONUS_CR_25 ;  break;
		case 26: min = FW_MIN_ABILITY_BONUS_CR_26 ; max = FW_MAX_ABILITY_BONUS_CR_26 ;  break;
   		case 27: min = FW_MIN_ABILITY_BONUS_CR_27 ; max = FW_MAX_ABILITY_BONUS_CR_27 ;  break;
		case 28: min = FW_MIN_ABILITY_BONUS_CR_28 ; max = FW_MAX_ABILITY_BONUS_CR_28 ;  break;
		case 29: min = FW_MIN_ABILITY_BONUS_CR_29 ; max = FW_MAX_ABILITY_BONUS_CR_29 ;  break;
   		case 30: min = FW_MIN_ABILITY_BONUS_CR_30 ; max = FW_MAX_ABILITY_BONUS_CR_30 ;  break;		
		
		case 31: min = FW_MIN_ABILITY_BONUS_CR_31 ; max = FW_MAX_ABILITY_BONUS_CR_31 ;  break;
		case 32: min = FW_MIN_ABILITY_BONUS_CR_32 ; max = FW_MAX_ABILITY_BONUS_CR_32 ;  break;
		case 33: min = FW_MIN_ABILITY_BONUS_CR_33 ; max = FW_MAX_ABILITY_BONUS_CR_33 ;  break;
   		case 34: min = FW_MIN_ABILITY_BONUS_CR_34 ; max = FW_MAX_ABILITY_BONUS_CR_34 ;  break;
		case 35: min = FW_MIN_ABILITY_BONUS_CR_35 ; max = FW_MAX_ABILITY_BONUS_CR_35 ;  break;
		case 36: min = FW_MIN_ABILITY_BONUS_CR_36 ; max = FW_MAX_ABILITY_BONUS_CR_36 ;  break;
   		case 37: min = FW_MIN_ABILITY_BONUS_CR_37 ; max = FW_MAX_ABILITY_BONUS_CR_37 ;  break;
		case 38: min = FW_MIN_ABILITY_BONUS_CR_38 ; max = FW_MAX_ABILITY_BONUS_CR_38 ;  break;
		case 39: min = FW_MIN_ABILITY_BONUS_CR_39 ; max = FW_MAX_ABILITY_BONUS_CR_39 ;  break;
   		case 40: min = FW_MIN_ABILITY_BONUS_CR_40 ; max = FW_MAX_ABILITY_BONUS_CR_40 ;  break;
		
		case 41: min = FW_MIN_ABILITY_BONUS_CR_41_OR_HIGHER; max = FW_MAX_ABILITY_BONUS_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nAbility;
   int nBonus;

   if (min < 1)
      min = 1;
   if (min > 12)
      min = 12;
   if (max < 1)
      max = 1;
   if (max > 12)
      max = 12;
   int nRoll = Random (6);
   switch (nRoll)
   {
      case 0: nAbility = IP_CONST_ABILITY_CHA;
         break;
      case 1: nAbility = IP_CONST_ABILITY_CON;
         break;
      case 2: nAbility = IP_CONST_ABILITY_DEX;
         break;
      case 3: nAbility = IP_CONST_ABILITY_INT;
         break;
      case 4: nAbility = IP_CONST_ABILITY_STR;
         break;
      case 5: nAbility = IP_CONST_ABILITY_WIS;
         break;
      default: break;
   } // end of switch
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyAbilityBonus(nAbility, nBonus);
   return ipAdd;
} // end of function

////////////////////////////////////////////
// * Function that randomly chooses an Armor Class bonus.  Values for min and
// * max should be an integer between 1 and 20.  The type of bonus depends on
// * the item it is being applied to.
//
itemproperty FW_Choose_IP_AC_Bonus (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_AC_BONUS == FALSE)
      return ipAdd;
   int min;
   int max;
   
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_AC_BONUS_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_AC_BONUS_MODIFIER) + 1;
   }
   else
   {  
   switch (nCR)
   {
		case 0: min = FW_MIN_AC_BONUS_CR_0 ; max = FW_MAX_AC_BONUS_CR_0 ;    break;
		
		case 1: min = FW_MIN_AC_BONUS_CR_1 ; max = FW_MAX_AC_BONUS_CR_1 ;    break;
		case 2: min = FW_MIN_AC_BONUS_CR_2 ; max = FW_MAX_AC_BONUS_CR_2 ;    break;
		case 3: min = FW_MIN_AC_BONUS_CR_3 ; max = FW_MAX_AC_BONUS_CR_3 ;    break;
   		case 4: min = FW_MIN_AC_BONUS_CR_4 ; max = FW_MAX_AC_BONUS_CR_4 ;    break;
		case 5: min = FW_MIN_AC_BONUS_CR_5 ; max = FW_MAX_AC_BONUS_CR_5 ;    break;
		case 6: min = FW_MIN_AC_BONUS_CR_6 ; max = FW_MAX_AC_BONUS_CR_6 ;    break;
   		case 7: min = FW_MIN_AC_BONUS_CR_7 ; max = FW_MAX_AC_BONUS_CR_7 ;    break;
		case 8: min = FW_MIN_AC_BONUS_CR_8 ; max = FW_MAX_AC_BONUS_CR_8 ;    break;
		case 9: min = FW_MIN_AC_BONUS_CR_9 ; max = FW_MAX_AC_BONUS_CR_9 ;    break;
   		case 10: min = FW_MIN_AC_BONUS_CR_10 ; max = FW_MAX_AC_BONUS_CR_10 ; break;
		
		case 11: min = FW_MIN_AC_BONUS_CR_11 ; max = FW_MAX_AC_BONUS_CR_11 ;  break;
		case 12: min = FW_MIN_AC_BONUS_CR_12 ; max = FW_MAX_AC_BONUS_CR_12 ;  break;
		case 13: min = FW_MIN_AC_BONUS_CR_13 ; max = FW_MAX_AC_BONUS_CR_13 ;  break;
   		case 14: min = FW_MIN_AC_BONUS_CR_14 ; max = FW_MAX_AC_BONUS_CR_14 ;  break;
		case 15: min = FW_MIN_AC_BONUS_CR_15 ; max = FW_MAX_AC_BONUS_CR_15 ;  break;
		case 16: min = FW_MIN_AC_BONUS_CR_16 ; max = FW_MAX_AC_BONUS_CR_16 ;  break;
   		case 17: min = FW_MIN_AC_BONUS_CR_17 ; max = FW_MAX_AC_BONUS_CR_17 ;  break;
		case 18: min = FW_MIN_AC_BONUS_CR_18 ; max = FW_MAX_AC_BONUS_CR_18 ;  break;
		case 19: min = FW_MIN_AC_BONUS_CR_19 ; max = FW_MAX_AC_BONUS_CR_19 ;  break;
   		case 20: min = FW_MIN_AC_BONUS_CR_20 ; max = FW_MAX_AC_BONUS_CR_20 ;  break;
   
   		case 21: min = FW_MIN_AC_BONUS_CR_21 ; max = FW_MAX_AC_BONUS_CR_21 ;  break;
		case 22: min = FW_MIN_AC_BONUS_CR_22 ; max = FW_MAX_AC_BONUS_CR_22 ;  break;
		case 23: min = FW_MIN_AC_BONUS_CR_23 ; max = FW_MAX_AC_BONUS_CR_23 ;  break;
   		case 24: min = FW_MIN_AC_BONUS_CR_24 ; max = FW_MAX_AC_BONUS_CR_24 ;  break;
		case 25: min = FW_MIN_AC_BONUS_CR_25 ; max = FW_MAX_AC_BONUS_CR_25 ;  break;
		case 26: min = FW_MIN_AC_BONUS_CR_26 ; max = FW_MAX_AC_BONUS_CR_26 ;  break;
   		case 27: min = FW_MIN_AC_BONUS_CR_27 ; max = FW_MAX_AC_BONUS_CR_27 ;  break;
		case 28: min = FW_MIN_AC_BONUS_CR_28 ; max = FW_MAX_AC_BONUS_CR_28 ;  break;
		case 29: min = FW_MIN_AC_BONUS_CR_29 ; max = FW_MAX_AC_BONUS_CR_29 ;  break;
   		case 30: min = FW_MIN_AC_BONUS_CR_30 ; max = FW_MAX_AC_BONUS_CR_30 ;  break;		
		
		case 31: min = FW_MIN_AC_BONUS_CR_31 ; max = FW_MAX_AC_BONUS_CR_31 ;  break;
		case 32: min = FW_MIN_AC_BONUS_CR_32 ; max = FW_MAX_AC_BONUS_CR_32 ;  break;
		case 33: min = FW_MIN_AC_BONUS_CR_33 ; max = FW_MAX_AC_BONUS_CR_33 ;  break;
   		case 34: min = FW_MIN_AC_BONUS_CR_34 ; max = FW_MAX_AC_BONUS_CR_34 ;  break;
		case 35: min = FW_MIN_AC_BONUS_CR_35 ; max = FW_MAX_AC_BONUS_CR_35 ;  break;
		case 36: min = FW_MIN_AC_BONUS_CR_36 ; max = FW_MAX_AC_BONUS_CR_36 ;  break;
   		case 37: min = FW_MIN_AC_BONUS_CR_37 ; max = FW_MAX_AC_BONUS_CR_37 ;  break;
		case 38: min = FW_MIN_AC_BONUS_CR_38 ; max = FW_MAX_AC_BONUS_CR_38 ;  break;
		case 39: min = FW_MIN_AC_BONUS_CR_39 ; max = FW_MAX_AC_BONUS_CR_39 ;  break;
   		case 40: min = FW_MIN_AC_BONUS_CR_40 ; max = FW_MAX_AC_BONUS_CR_40 ;  break;
		
		case 41: min = FW_MIN_AC_BONUS_CR_41_OR_HIGHER; max = FW_MAX_AC_BONUS_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyACBonus(nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an Armor Class bonus vs. an alignment group.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_AC_Bonus_Vs_Align (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_AC_BONUS_VS_ALIGN == FALSE)
      return ipAdd;
   int min;
   int max;
   
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_AC_BONUS_VS_ALIGN_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_AC_BONUS_VS_ALIGN_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_0 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_0 ;    break;
		
		case 1: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_1 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_1 ;    break;
		case 2: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_2 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_2 ;    break;
		case 3: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_3 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_3 ;    break;
   		case 4: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_4 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_4 ;    break;
		case 5: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_5 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_5 ;    break;
		case 6: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_6 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_6 ;    break;
   		case 7: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_7 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_7 ;    break;
		case 8: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_8 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_8 ;    break;
		case 9: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_9 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_9 ;    break;
   		case 10: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_10 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_10 ; break;
		
		case 11: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_11 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_11 ;  break;
		case 12: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_12 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_12 ;  break;
		case 13: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_13 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_13 ;  break;
   		case 14: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_14 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_14 ;  break;
		case 15: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_15 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_15 ;  break;
		case 16: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_16 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_16 ;  break;
   		case 17: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_17 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_17 ;  break;
		case 18: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_18 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_18 ;  break;
		case 19: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_19 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_19 ;  break;
   		case 20: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_20 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_20 ;  break;
   
   		case 21: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_21 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_21 ;  break;
		case 22: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_22 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_22 ;  break;
		case 23: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_23 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_23 ;  break;
   		case 24: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_24 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_24 ;  break;
		case 25: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_25 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_25 ;  break;
		case 26: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_26 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_26 ;  break;
   		case 27: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_27 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_27 ;  break;
		case 28: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_28 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_28 ;  break;
		case 29: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_29 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_29 ;  break;
   		case 30: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_30 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_30 ;  break;		
		
		case 31: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_31 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_31 ;  break;
		case 32: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_32 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_32 ;  break;
		case 33: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_33 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_33 ;  break;
   		case 34: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_34 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_34 ;  break;
		case 35: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_35 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_35 ;  break;
		case 36: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_36 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_36 ;  break;
   		case 37: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_37 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_37 ;  break;
		case 38: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_38 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_38 ;  break;
		case 39: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_39 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_39 ;  break;
   		case 40: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_40 ; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_40 ;  break;
		
		case 41: min = FW_MIN_AC_BONUS_VS_ALIGN_CR_41_OR_HIGHER; max = FW_MAX_AC_BONUS_VS_ALIGN_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nAlignGroup = FW_Choose_IP_CONST_ALIGNMENTGROUP();
   int nACBonus;
   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nACBonus = 1;  }
   else if (min == max)
      {  nACBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nACBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyACBonusVsAlign(nAlignGroup, nACBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an Armor Class bonus vs. damage type.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_AC_Bonus_Vs_Damage_Type (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_AC_BONUS_VS_DMG_TYPE == FALSE)
      return ipAdd;
   int min;
   int max;
   
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_AC_BONUS_VS_DAMAGE_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_AC_BONUS_VS_DAMAGE_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_0 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_0 ;    break;
		
		case 1: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_1 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_1 ;    break;
		case 2: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_2 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_2 ;    break;
		case 3: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_3 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_3 ;    break;
   		case 4: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_4 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_4 ;    break;
		case 5: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_5 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_5 ;    break;
		case 6: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_6 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_6 ;    break;
   		case 7: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_7 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_7 ;    break;
		case 8: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_8 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_8 ;    break;
		case 9: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_9 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_9 ;    break;
   		case 10: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_10 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_10 ; break;
		
		case 11: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_11 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_11 ;  break;
		case 12: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_12 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_12 ;  break;
		case 13: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_13 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_13 ;  break;
   		case 14: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_14 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_14 ;  break;
		case 15: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_15 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_15 ;  break;
		case 16: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_16 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_16 ;  break;
   		case 17: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_17 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_17 ;  break;
		case 18: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_18 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_18 ;  break;
		case 19: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_19 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_19 ;  break;
   		case 20: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_20 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_20 ;  break;
   
   		case 21: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_21 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_21 ;  break;
		case 22: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_22 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_22 ;  break;
		case 23: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_23 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_23 ;  break;
   		case 24: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_24 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_24 ;  break;
		case 25: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_25 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_25 ;  break;
		case 26: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_26 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_26 ;  break;
   		case 27: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_27 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_27 ;  break;
		case 28: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_28 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_28 ;  break;
		case 29: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_29 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_29 ;  break;
   		case 30: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_30 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_30 ;  break;		
		
		case 31: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_31 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_31 ;  break;
		case 32: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_32 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_32 ;  break;
		case 33: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_33 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_33 ;  break;
   		case 34: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_34 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_34 ;  break;
		case 35: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_35 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_35 ;  break;
		case 36: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_36 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_36 ;  break;
   		case 37: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_37 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_37 ;  break;
		case 38: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_38 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_38 ;  break;
		case 39: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_39 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_39 ;  break;
   		case 40: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_40 ; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_40 ;  break;
		
		case 41: min = FW_MIN_AC_BONUS_VS_DMG_TYPE_CR_41_OR_HIGHER; max = FW_MAX_AC_BONUS_VS_DMG_TYPE_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nDamageType;
   int nACBonus;

   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   int nRoll = Random (3);
   switch (nRoll)
   {
      case 0: nDamageType = IP_CONST_DAMAGETYPE_BLUDGEONING;
         break;
      case 1: nDamageType = IP_CONST_DAMAGETYPE_PIERCING;
         break;
      case 2: nDamageType = IP_CONST_DAMAGETYPE_SLASHING;
         break;
      default: break;
   } // end of switch
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nACBonus = 1;  }
   else if (min == max)
      {  nACBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nACBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyACBonusVsDmgType(nDamageType, nACBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an Armor Class bonus vs. race.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_AC_Bonus_Vs_Race (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_AC_BONUS_VS_RACE == FALSE)
      return ipAdd;
   int min;
   int max;
   
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_AC_BONUS_VS_RACE_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_AC_BONUS_VS_RACE_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_AC_BONUS_VS_RACE_CR_0 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_0 ;    break;
		
		case 1: min = FW_MIN_AC_BONUS_VS_RACE_CR_1 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_1 ;    break;
		case 2: min = FW_MIN_AC_BONUS_VS_RACE_CR_2 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_2 ;    break;
		case 3: min = FW_MIN_AC_BONUS_VS_RACE_CR_3 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_3 ;    break;
   		case 4: min = FW_MIN_AC_BONUS_VS_RACE_CR_4 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_4 ;    break;
		case 5: min = FW_MIN_AC_BONUS_VS_RACE_CR_5 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_5 ;    break;
		case 6: min = FW_MIN_AC_BONUS_VS_RACE_CR_6 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_6 ;    break;
   		case 7: min = FW_MIN_AC_BONUS_VS_RACE_CR_7 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_7 ;    break;
		case 8: min = FW_MIN_AC_BONUS_VS_RACE_CR_8 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_8 ;    break;
		case 9: min = FW_MIN_AC_BONUS_VS_RACE_CR_9 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_9 ;    break;
   		case 10: min = FW_MIN_AC_BONUS_VS_RACE_CR_10 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_10 ; break;
		
		case 11: min = FW_MIN_AC_BONUS_VS_RACE_CR_11 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_11 ;  break;
		case 12: min = FW_MIN_AC_BONUS_VS_RACE_CR_12 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_12 ;  break;
		case 13: min = FW_MIN_AC_BONUS_VS_RACE_CR_13 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_13 ;  break;
   		case 14: min = FW_MIN_AC_BONUS_VS_RACE_CR_14 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_14 ;  break;
		case 15: min = FW_MIN_AC_BONUS_VS_RACE_CR_15 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_15 ;  break;
		case 16: min = FW_MIN_AC_BONUS_VS_RACE_CR_16 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_16 ;  break;
   		case 17: min = FW_MIN_AC_BONUS_VS_RACE_CR_17 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_17 ;  break;
		case 18: min = FW_MIN_AC_BONUS_VS_RACE_CR_18 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_18 ;  break;
		case 19: min = FW_MIN_AC_BONUS_VS_RACE_CR_19 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_19 ;  break;
   		case 20: min = FW_MIN_AC_BONUS_VS_RACE_CR_20 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_20 ;  break;
   
   		case 21: min = FW_MIN_AC_BONUS_VS_RACE_CR_21 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_21 ;  break;
		case 22: min = FW_MIN_AC_BONUS_VS_RACE_CR_22 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_22 ;  break;
		case 23: min = FW_MIN_AC_BONUS_VS_RACE_CR_23 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_23 ;  break;
   		case 24: min = FW_MIN_AC_BONUS_VS_RACE_CR_24 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_24 ;  break;
		case 25: min = FW_MIN_AC_BONUS_VS_RACE_CR_25 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_25 ;  break;
		case 26: min = FW_MIN_AC_BONUS_VS_RACE_CR_26 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_26 ;  break;
   		case 27: min = FW_MIN_AC_BONUS_VS_RACE_CR_27 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_27 ;  break;
		case 28: min = FW_MIN_AC_BONUS_VS_RACE_CR_28 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_28 ;  break;
		case 29: min = FW_MIN_AC_BONUS_VS_RACE_CR_29 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_29 ;  break;
   		case 30: min = FW_MIN_AC_BONUS_VS_RACE_CR_30 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_30 ;  break;		
		
		case 31: min = FW_MIN_AC_BONUS_VS_RACE_CR_31 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_31 ;  break;
		case 32: min = FW_MIN_AC_BONUS_VS_RACE_CR_32 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_32 ;  break;
		case 33: min = FW_MIN_AC_BONUS_VS_RACE_CR_33 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_33 ;  break;
   		case 34: min = FW_MIN_AC_BONUS_VS_RACE_CR_34 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_34 ;  break;
		case 35: min = FW_MIN_AC_BONUS_VS_RACE_CR_35 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_35 ;  break;
		case 36: min = FW_MIN_AC_BONUS_VS_RACE_CR_36 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_36 ;  break;
   		case 37: min = FW_MIN_AC_BONUS_VS_RACE_CR_37 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_37 ;  break;
		case 38: min = FW_MIN_AC_BONUS_VS_RACE_CR_38 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_38 ;  break;
		case 39: min = FW_MIN_AC_BONUS_VS_RACE_CR_39 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_39 ;  break;
   		case 40: min = FW_MIN_AC_BONUS_VS_RACE_CR_40 ; max = FW_MAX_AC_BONUS_VS_RACE_CR_40 ;  break;
		
		case 41: min = FW_MIN_AC_BONUS_VS_RACE_CR_41_OR_HIGHER; max = FW_MAX_AC_BONUS_VS_RACE_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nRace = FW_Choose_IP_CONST_RACIALTYPE();
   int nACBonus;

   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nACBonus = 1;  }
   else if (min == max)
      {  nACBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nACBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyACBonusVsRace(nRace, nACBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an Armor Class bonus vs. SPECIFIC alignment.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_AC_Bonus_Vs_SAlign (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_AC_BONUS_VS_SALIGN == FALSE)
      return ipAdd;
   int min;
   int max;
   
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_AC_BONUS_VS_SALIGN_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_AC_BONUS_VS_SALIGN_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_0 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_0 ;    break;
		
		case 1: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_1 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_1 ;    break;
		case 2: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_2 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_2 ;    break;
		case 3: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_3 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_3 ;    break;
   		case 4: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_4 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_4 ;    break;
		case 5: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_5 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_5 ;    break;
		case 6: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_6 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_6 ;    break;
   		case 7: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_7 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_7 ;    break;
		case 8: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_8 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_8 ;    break;
		case 9: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_9 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_9 ;    break;
   		case 10: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_10 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_10 ; break;
		
		case 11: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_11 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_11 ;  break;
		case 12: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_12 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_12 ;  break;
		case 13: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_13 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_13 ;  break;
   		case 14: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_14 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_14 ;  break;
		case 15: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_15 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_15 ;  break;
		case 16: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_16 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_16 ;  break;
   		case 17: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_17 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_17 ;  break;
		case 18: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_18 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_18 ;  break;
		case 19: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_19 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_19 ;  break;
   		case 20: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_20 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_20 ;  break;
   
   		case 21: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_21 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_21 ;  break;
		case 22: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_22 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_22 ;  break;
		case 23: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_23 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_23 ;  break;
   		case 24: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_24 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_24 ;  break;
		case 25: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_25 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_25 ;  break;
		case 26: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_26 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_26 ;  break;
   		case 27: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_27 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_27 ;  break;
		case 28: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_28 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_28 ;  break;
		case 29: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_29 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_29 ;  break;
   		case 30: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_30 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_30 ;  break;		
		
		case 31: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_31 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_31 ;  break;
		case 32: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_32 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_32 ;  break;
		case 33: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_33 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_33 ;  break;
   		case 34: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_34 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_34 ;  break;
		case 35: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_35 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_35 ;  break;
		case 36: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_36 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_36 ;  break;
   		case 37: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_37 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_37 ;  break;
		case 38: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_38 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_38 ;  break;
		case 39: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_39 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_39 ;  break;
   		case 40: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_40 ; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_40 ;  break;
		
		case 41: min = FW_MIN_AC_BONUS_VS_SALIGN_CR_41_OR_HIGHER; max = FW_MAX_AC_BONUS_VS_SALIGN_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nAlign = FW_Choose_IP_CONST_SALIGN ();
   int nACBonus;

   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;

   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nACBonus = 1;  }
   else if (min == max)
      {  nACBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nACBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyACBonusVsSAlign(nAlign, nACBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an Arcane Spell Failure.
//
// Mustang change to limit for low level world.
itemproperty FW_Choose_IP_Arcane_Spell_Failure ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_ARCANE_SPELL_FAILURE == FALSE)
      return ipAdd;
   int nModLevel;
   int nRoll = Random (6); //(20);
   switch (nRoll)
   {
      case 0: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_10_PERCENT;
         break;
      case 1: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_15_PERCENT;
         break;
      //case 2: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_20_PERCENT;
      //   break;
      //case 3: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_25_PERCENT;
      //   break;
      //case 4: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_30_PERCENT;
      //   break;
      //case 5: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_35_PERCENT;
      //   break;
      //case 6: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_40_PERCENT;
      //  break;
      //case 7: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_45_PERCENT;
      //   break;
      case 2: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_5_PERCENT;
         break;
      //case 9: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_50_PERCENT;
      //   break;
      case 3: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_PLUS_10_PERCENT;
         break;
      case 4: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_PLUS_15_PERCENT;
         break;
      //case 12: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_PLUS_20_PERCENT;
      //  break;
      //case 13: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_PLUS_25_PERCENT;
      //   break;
      //case 14: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_PLUS_30_PERCENT;
      //   break;
      //case 15: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_PLUS_35_PERCENT;
      //   break;
      //case 16: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_PLUS_40_PERCENT;
      //   break;
      //case 17: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_PLUS_45_PERCENT;
      //   break;
      case 5: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_PLUS_5_PERCENT;
         break;
      //case 19: nModLevel = IP_CONST_ARCANE_SPELL_FAILURE_PLUS_50_PERCENT;
      //   break;
      default: break;
   } // end of switch
   ipAdd = ItemPropertyArcaneSpellFailure(nModLevel);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an Attack bonus.  Values for min and
// * max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Attack_Bonus (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_ATTACK_BONUS == FALSE)
      return ipAdd;
   int min;
   int max;
   
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_ATTACK_BONUS_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_ATTACK_BONUS_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_ATTACK_BONUS_CR_0 ; max = FW_MAX_ATTACK_BONUS_CR_0 ;    break;
		
		case 1: min = FW_MIN_ATTACK_BONUS_CR_1 ; max = FW_MAX_ATTACK_BONUS_CR_1 ;    break;
		case 2: min = FW_MIN_ATTACK_BONUS_CR_2 ; max = FW_MAX_ATTACK_BONUS_CR_2 ;    break;
		case 3: min = FW_MIN_ATTACK_BONUS_CR_3 ; max = FW_MAX_ATTACK_BONUS_CR_3 ;    break;
   		case 4: min = FW_MIN_ATTACK_BONUS_CR_4 ; max = FW_MAX_ATTACK_BONUS_CR_4 ;    break;
		case 5: min = FW_MIN_ATTACK_BONUS_CR_5 ; max = FW_MAX_ATTACK_BONUS_CR_5 ;    break;
		case 6: min = FW_MIN_ATTACK_BONUS_CR_6 ; max = FW_MAX_ATTACK_BONUS_CR_6 ;    break;
   		case 7: min = FW_MIN_ATTACK_BONUS_CR_7 ; max = FW_MAX_ATTACK_BONUS_CR_7 ;    break;
		case 8: min = FW_MIN_ATTACK_BONUS_CR_8 ; max = FW_MAX_ATTACK_BONUS_CR_8 ;    break;
		case 9: min = FW_MIN_ATTACK_BONUS_CR_9 ; max = FW_MAX_ATTACK_BONUS_CR_9 ;    break;
   		case 10: min = FW_MIN_ATTACK_BONUS_CR_10 ; max = FW_MAX_ATTACK_BONUS_CR_10 ; break;
		
		case 11: min = FW_MIN_ATTACK_BONUS_CR_11 ; max = FW_MAX_ATTACK_BONUS_CR_11 ;  break;
		case 12: min = FW_MIN_ATTACK_BONUS_CR_12 ; max = FW_MAX_ATTACK_BONUS_CR_12 ;  break;
		case 13: min = FW_MIN_ATTACK_BONUS_CR_13 ; max = FW_MAX_ATTACK_BONUS_CR_13 ;  break;
   		case 14: min = FW_MIN_ATTACK_BONUS_CR_14 ; max = FW_MAX_ATTACK_BONUS_CR_14 ;  break;
		case 15: min = FW_MIN_ATTACK_BONUS_CR_15 ; max = FW_MAX_ATTACK_BONUS_CR_15 ;  break;
		case 16: min = FW_MIN_ATTACK_BONUS_CR_16 ; max = FW_MAX_ATTACK_BONUS_CR_16 ;  break;
   		case 17: min = FW_MIN_ATTACK_BONUS_CR_17 ; max = FW_MAX_ATTACK_BONUS_CR_17 ;  break;
		case 18: min = FW_MIN_ATTACK_BONUS_CR_18 ; max = FW_MAX_ATTACK_BONUS_CR_18 ;  break;
		case 19: min = FW_MIN_ATTACK_BONUS_CR_19 ; max = FW_MAX_ATTACK_BONUS_CR_19 ;  break;
   		case 20: min = FW_MIN_ATTACK_BONUS_CR_20 ; max = FW_MAX_ATTACK_BONUS_CR_20 ;  break;
   
   		case 21: min = FW_MIN_ATTACK_BONUS_CR_21 ; max = FW_MAX_ATTACK_BONUS_CR_21 ;  break;
		case 22: min = FW_MIN_ATTACK_BONUS_CR_22 ; max = FW_MAX_ATTACK_BONUS_CR_22 ;  break;
		case 23: min = FW_MIN_ATTACK_BONUS_CR_23 ; max = FW_MAX_ATTACK_BONUS_CR_23 ;  break;
   		case 24: min = FW_MIN_ATTACK_BONUS_CR_24 ; max = FW_MAX_ATTACK_BONUS_CR_24 ;  break;
		case 25: min = FW_MIN_ATTACK_BONUS_CR_25 ; max = FW_MAX_ATTACK_BONUS_CR_25 ;  break;
		case 26: min = FW_MIN_ATTACK_BONUS_CR_26 ; max = FW_MAX_ATTACK_BONUS_CR_26 ;  break;
   		case 27: min = FW_MIN_ATTACK_BONUS_CR_27 ; max = FW_MAX_ATTACK_BONUS_CR_27 ;  break;
		case 28: min = FW_MIN_ATTACK_BONUS_CR_28 ; max = FW_MAX_ATTACK_BONUS_CR_28 ;  break;
		case 29: min = FW_MIN_ATTACK_BONUS_CR_29 ; max = FW_MAX_ATTACK_BONUS_CR_29 ;  break;
   		case 30: min = FW_MIN_ATTACK_BONUS_CR_30 ; max = FW_MAX_ATTACK_BONUS_CR_30 ;  break;		
		
		case 31: min = FW_MIN_ATTACK_BONUS_CR_31 ; max = FW_MAX_ATTACK_BONUS_CR_31 ;  break;
		case 32: min = FW_MIN_ATTACK_BONUS_CR_32 ; max = FW_MAX_ATTACK_BONUS_CR_32 ;  break;
		case 33: min = FW_MIN_ATTACK_BONUS_CR_33 ; max = FW_MAX_ATTACK_BONUS_CR_33 ;  break;
   		case 34: min = FW_MIN_ATTACK_BONUS_CR_34 ; max = FW_MAX_ATTACK_BONUS_CR_34 ;  break;
		case 35: min = FW_MIN_ATTACK_BONUS_CR_35 ; max = FW_MAX_ATTACK_BONUS_CR_35 ;  break;
		case 36: min = FW_MIN_ATTACK_BONUS_CR_36 ; max = FW_MAX_ATTACK_BONUS_CR_36 ;  break;
   		case 37: min = FW_MIN_ATTACK_BONUS_CR_37 ; max = FW_MAX_ATTACK_BONUS_CR_37 ;  break;
		case 38: min = FW_MIN_ATTACK_BONUS_CR_38 ; max = FW_MAX_ATTACK_BONUS_CR_38 ;  break;
		case 39: min = FW_MIN_ATTACK_BONUS_CR_39 ; max = FW_MAX_ATTACK_BONUS_CR_39 ;  break;
   		case 40: min = FW_MIN_ATTACK_BONUS_CR_40 ; max = FW_MAX_ATTACK_BONUS_CR_40 ;  break;
		
		case 41: min = FW_MIN_ATTACK_BONUS_CR_41_OR_HIGHER; max = FW_MAX_ATTACK_BONUS_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyAttackBonus(nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an Attack bonus vs. an alignment group.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Attack_Bonus_Vs_Align (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_ATTACK_BONUS_VS_ALIGN == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_ATTACK_BONUS_VS_ALIGN_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_ATTACK_BONUS_VS_ALIGN_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_0 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_0 ;    break;
		
		case 1: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_1 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_1 ;    break;
		case 2: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_2 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_2 ;    break;
		case 3: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_3 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_3 ;    break;
   		case 4: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_4 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_4 ;    break;
		case 5: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_5 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_5 ;    break;
		case 6: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_6 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_6 ;    break;
   		case 7: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_7 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_7 ;    break;
		case 8: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_8 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_8 ;    break;
		case 9: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_9 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_9 ;    break;
   		case 10: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_10 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_10 ; break;
		
		case 11: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_11 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_11 ;  break;
		case 12: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_12 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_12 ;  break;
		case 13: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_13 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_13 ;  break;
   		case 14: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_14 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_14 ;  break;
		case 15: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_15 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_15 ;  break;
		case 16: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_16 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_16 ;  break;
   		case 17: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_17 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_17 ;  break;
		case 18: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_18 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_18 ;  break;
		case 19: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_19 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_19 ;  break;
   		case 20: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_20 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_20 ;  break;
   
   		case 21: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_21 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_21 ;  break;
		case 22: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_22 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_22 ;  break;
		case 23: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_23 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_23 ;  break;
   		case 24: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_24 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_24 ;  break;
		case 25: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_25 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_25 ;  break;
		case 26: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_26 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_26 ;  break;
   		case 27: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_27 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_27 ;  break;
		case 28: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_28 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_28 ;  break;
		case 29: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_29 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_29 ;  break;
   		case 30: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_30 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_30 ;  break;		
		
		case 31: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_31 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_31 ;  break;
		case 32: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_32 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_32 ;  break;
		case 33: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_33 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_33 ;  break;
   		case 34: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_34 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_34 ;  break;
		case 35: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_35 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_35 ;  break;
		case 36: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_36 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_36 ;  break;
   		case 37: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_37 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_37 ;  break;
		case 38: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_38 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_38 ;  break;
		case 39: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_39 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_39 ;  break;
   		case 40: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_40 ; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_40 ;  break;
		
		case 41: min = FW_MIN_ATTACK_BONUS_VS_ALIGN_CR_41_OR_HIGHER; max = FW_MAX_ATTACK_BONUS_VS_ALIGN_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nAlignGroup = FW_Choose_IP_CONST_ALIGNMENTGROUP ();
   int nBonus;

   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyAttackBonusVsAlign(nAlignGroup, nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an attack bonus vs. race.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Attack_Bonus_Vs_Race (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_ATTACK_BONUS_VS_RACE == FALSE)
      return ipAdd;
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_ATTACK_BONUS_VS_RACE_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_ATTACK_BONUS_VS_RACE_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_0 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_0 ;    break;
		
		case 1: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_1 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_1 ;    break;
		case 2: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_2 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_2 ;    break;
		case 3: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_3 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_3 ;    break;
   		case 4: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_4 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_4 ;    break;
		case 5: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_5 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_5 ;    break;
		case 6: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_6 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_6 ;    break;
   		case 7: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_7 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_7 ;    break;
		case 8: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_8 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_8 ;    break;
		case 9: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_9 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_9 ;    break;
   		case 10: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_10 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_10 ; break;
		
		case 11: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_11 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_11 ;  break;
		case 12: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_12 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_12 ;  break;
		case 13: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_13 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_13 ;  break;
   		case 14: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_14 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_14 ;  break;
		case 15: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_15 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_15 ;  break;
		case 16: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_16 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_16 ;  break;
   		case 17: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_17 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_17 ;  break;
		case 18: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_18 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_18 ;  break;
		case 19: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_19 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_19 ;  break;
   		case 20: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_20 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_20 ;  break;
   
   		case 21: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_21 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_21 ;  break;
		case 22: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_22 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_22 ;  break;
		case 23: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_23 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_23 ;  break;
   		case 24: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_24 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_24 ;  break;
		case 25: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_25 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_25 ;  break;
		case 26: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_26 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_26 ;  break;
   		case 27: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_27 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_27 ;  break;
		case 28: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_28 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_28 ;  break;
		case 29: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_29 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_29 ;  break;
   		case 30: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_30 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_30 ;  break;		
		
		case 31: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_31 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_31 ;  break;
		case 32: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_32 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_32 ;  break;
		case 33: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_33 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_33 ;  break;
   		case 34: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_34 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_34 ;  break;
		case 35: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_35 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_35 ;  break;
		case 36: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_36 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_36 ;  break;
   		case 37: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_37 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_37 ;  break;
		case 38: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_38 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_38 ;  break;
		case 39: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_39 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_39 ;  break;
   		case 40: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_40 ; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_40 ;  break;
		
		case 41: min = FW_MIN_ATTACK_BONUS_VS_RACE_CR_41_OR_HIGHER; max = FW_MAX_ATTACK_BONUS_VS_RACE_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nRace = FW_Choose_IP_CONST_RACIALTYPE ();
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyAttackBonusVsRace(nRace, nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an Attack bonus vs. SPECIFIC alignment.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Attack_Bonus_Vs_SAlign (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_ATTACK_BONUS_VS_SALIGN == FALSE)
      return ipAdd;
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_ATTACK_BONUS_VS_SALIGN_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_ATTACK_BONUS_VS_SALIGN_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_0 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_0 ;    break;
		
		case 1: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_1 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_1 ;    break;
		case 2: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_2 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_2 ;    break;
		case 3: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_3 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_3 ;    break;
   		case 4: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_4 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_4 ;    break;
		case 5: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_5 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_5 ;    break;
		case 6: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_6 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_6 ;    break;
   		case 7: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_7 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_7 ;    break;
		case 8: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_8 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_8 ;    break;
		case 9: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_9 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_9 ;    break;
   		case 10: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_10 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_10 ; break;
		
		case 11: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_11 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_11 ;  break;
		case 12: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_12 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_12 ;  break;
		case 13: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_13 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_13 ;  break;
   		case 14: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_14 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_14 ;  break;
		case 15: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_15 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_15 ;  break;
		case 16: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_16 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_16 ;  break;
   		case 17: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_17 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_17 ;  break;
		case 18: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_18 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_18 ;  break;
		case 19: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_19 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_19 ;  break;
   		case 20: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_20 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_20 ;  break;
   
   		case 21: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_21 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_21 ;  break;
		case 22: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_22 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_22 ;  break;
		case 23: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_23 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_23 ;  break;
   		case 24: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_24 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_24 ;  break;
		case 25: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_25 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_25 ;  break;
		case 26: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_26 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_26 ;  break;
   		case 27: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_27 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_27 ;  break;
		case 28: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_28 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_28 ;  break;
		case 29: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_29 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_29 ;  break;
   		case 30: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_30 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_30 ;  break;		
		
		case 31: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_31 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_31 ;  break;
		case 32: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_32 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_32 ;  break;
		case 33: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_33 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_33 ;  break;
   		case 34: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_34 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_34 ;  break;
		case 35: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_35 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_35 ;  break;
		case 36: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_36 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_36 ;  break;
   		case 37: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_37 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_37 ;  break;
		case 38: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_38 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_38 ;  break;
		case 39: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_39 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_39 ;  break;
   		case 40: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_40 ; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_40 ;  break;
		
		case 41: min = FW_MIN_ATTACK_BONUS_VS_SALIGN_CR_41_OR_HIGHER; max = FW_MAX_ATTACK_BONUS_VS_SALIGN_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nAlign = FW_Choose_IP_CONST_SALIGN ();
   int nBonus;

   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyAttackBonusVsSAlign(nAlign, nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an Attack penalty.  Values for min and
// * max should be an integer between 1 and 5. Yes that is right. 5 is the max.
//
itemproperty FW_Choose_IP_Attack_Penalty (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_ATTACK_PENALTY == FALSE)
      return ipAdd;
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_ATTACK_PENALTY_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_ATTACK_PENALTY_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_ATTACK_PENALTY_CR_0 ; max = FW_MAX_ATTACK_PENALTY_CR_0 ;    break;
		
		case 1: min = FW_MIN_ATTACK_PENALTY_CR_1 ; max = FW_MAX_ATTACK_PENALTY_CR_1 ;    break;
		case 2: min = FW_MIN_ATTACK_PENALTY_CR_2 ; max = FW_MAX_ATTACK_PENALTY_CR_2 ;    break;
		case 3: min = FW_MIN_ATTACK_PENALTY_CR_3 ; max = FW_MAX_ATTACK_PENALTY_CR_3 ;    break;
   		case 4: min = FW_MIN_ATTACK_PENALTY_CR_4 ; max = FW_MAX_ATTACK_PENALTY_CR_4 ;    break;
		case 5: min = FW_MIN_ATTACK_PENALTY_CR_5 ; max = FW_MAX_ATTACK_PENALTY_CR_5 ;    break;
		case 6: min = FW_MIN_ATTACK_PENALTY_CR_6 ; max = FW_MAX_ATTACK_PENALTY_CR_6 ;    break;
   		case 7: min = FW_MIN_ATTACK_PENALTY_CR_7 ; max = FW_MAX_ATTACK_PENALTY_CR_7 ;    break;
		case 8: min = FW_MIN_ATTACK_PENALTY_CR_8 ; max = FW_MAX_ATTACK_PENALTY_CR_8 ;    break;
		case 9: min = FW_MIN_ATTACK_PENALTY_CR_9 ; max = FW_MAX_ATTACK_PENALTY_CR_9 ;    break;
   		case 10: min = FW_MIN_ATTACK_PENALTY_CR_10 ; max = FW_MAX_ATTACK_PENALTY_CR_10 ; break;
		
		case 11: min = FW_MIN_ATTACK_PENALTY_CR_11 ; max = FW_MAX_ATTACK_PENALTY_CR_11 ;  break;
		case 12: min = FW_MIN_ATTACK_PENALTY_CR_12 ; max = FW_MAX_ATTACK_PENALTY_CR_12 ;  break;
		case 13: min = FW_MIN_ATTACK_PENALTY_CR_13 ; max = FW_MAX_ATTACK_PENALTY_CR_13 ;  break;
   		case 14: min = FW_MIN_ATTACK_PENALTY_CR_14 ; max = FW_MAX_ATTACK_PENALTY_CR_14 ;  break;
		case 15: min = FW_MIN_ATTACK_PENALTY_CR_15 ; max = FW_MAX_ATTACK_PENALTY_CR_15 ;  break;
		case 16: min = FW_MIN_ATTACK_PENALTY_CR_16 ; max = FW_MAX_ATTACK_PENALTY_CR_16 ;  break;
   		case 17: min = FW_MIN_ATTACK_PENALTY_CR_17 ; max = FW_MAX_ATTACK_PENALTY_CR_17 ;  break;
		case 18: min = FW_MIN_ATTACK_PENALTY_CR_18 ; max = FW_MAX_ATTACK_PENALTY_CR_18 ;  break;
		case 19: min = FW_MIN_ATTACK_PENALTY_CR_19 ; max = FW_MAX_ATTACK_PENALTY_CR_19 ;  break;
   		case 20: min = FW_MIN_ATTACK_PENALTY_CR_20 ; max = FW_MAX_ATTACK_PENALTY_CR_20 ;  break;
   
   		case 21: min = FW_MIN_ATTACK_PENALTY_CR_21 ; max = FW_MAX_ATTACK_PENALTY_CR_21 ;  break;
		case 22: min = FW_MIN_ATTACK_PENALTY_CR_22 ; max = FW_MAX_ATTACK_PENALTY_CR_22 ;  break;
		case 23: min = FW_MIN_ATTACK_PENALTY_CR_23 ; max = FW_MAX_ATTACK_PENALTY_CR_23 ;  break;
   		case 24: min = FW_MIN_ATTACK_PENALTY_CR_24 ; max = FW_MAX_ATTACK_PENALTY_CR_24 ;  break;
		case 25: min = FW_MIN_ATTACK_PENALTY_CR_25 ; max = FW_MAX_ATTACK_PENALTY_CR_25 ;  break;
		case 26: min = FW_MIN_ATTACK_PENALTY_CR_26 ; max = FW_MAX_ATTACK_PENALTY_CR_26 ;  break;
   		case 27: min = FW_MIN_ATTACK_PENALTY_CR_27 ; max = FW_MAX_ATTACK_PENALTY_CR_27 ;  break;
		case 28: min = FW_MIN_ATTACK_PENALTY_CR_28 ; max = FW_MAX_ATTACK_PENALTY_CR_28 ;  break;
		case 29: min = FW_MIN_ATTACK_PENALTY_CR_29 ; max = FW_MAX_ATTACK_PENALTY_CR_29 ;  break;
   		case 30: min = FW_MIN_ATTACK_PENALTY_CR_30 ; max = FW_MAX_ATTACK_PENALTY_CR_30 ;  break;		
		
		case 31: min = FW_MIN_ATTACK_PENALTY_CR_31 ; max = FW_MAX_ATTACK_PENALTY_CR_31 ;  break;
		case 32: min = FW_MIN_ATTACK_PENALTY_CR_32 ; max = FW_MAX_ATTACK_PENALTY_CR_32 ;  break;
		case 33: min = FW_MIN_ATTACK_PENALTY_CR_33 ; max = FW_MAX_ATTACK_PENALTY_CR_33 ;  break;
   		case 34: min = FW_MIN_ATTACK_PENALTY_CR_34 ; max = FW_MAX_ATTACK_PENALTY_CR_34 ;  break;
		case 35: min = FW_MIN_ATTACK_PENALTY_CR_35 ; max = FW_MAX_ATTACK_PENALTY_CR_35 ;  break;
		case 36: min = FW_MIN_ATTACK_PENALTY_CR_36 ; max = FW_MAX_ATTACK_PENALTY_CR_36 ;  break;
   		case 37: min = FW_MIN_ATTACK_PENALTY_CR_37 ; max = FW_MAX_ATTACK_PENALTY_CR_37 ;  break;
		case 38: min = FW_MIN_ATTACK_PENALTY_CR_38 ; max = FW_MAX_ATTACK_PENALTY_CR_38 ;  break;
		case 39: min = FW_MIN_ATTACK_PENALTY_CR_39 ; max = FW_MAX_ATTACK_PENALTY_CR_39 ;  break;
   		case 40: min = FW_MIN_ATTACK_PENALTY_CR_40 ; max = FW_MAX_ATTACK_PENALTY_CR_40 ;  break;
		
		case 41: min = FW_MIN_ATTACK_PENALTY_CR_41_OR_HIGHER; max = FW_MAX_ATTACK_PENALTY_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 5)
      min = 5;
   if (max < 1)
      max = 1;
   if (max > 5)
      max = 5;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyAttackPenalty(nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a feat to add to an item.
// * By default ALL bonus feats are allowed.
//
itemproperty FW_Choose_IP_Bonus_Feat ()
{
  itemproperty ipAdd;
  if (FW_ALLOW_BONUS_FEAT == FALSE)
      return ipAdd;
  int nReRoll = TRUE;
  int nRoll;

  while (nReRoll)
  {
     // As of 12 March 2008 there are a ton of feats, but only feats
	 // that begin with IP_CONST_* can be used with ItemPropertyBonusFeat
	 // this severely limits what can be added to an item dynamically.
	 // This number (27) was chosen so that there is a good chance of getting 
	 // something when Bonus Feat is chosen as the category.
     nRoll = Random (27);
     switch (nRoll)
     {
        //**************************************
        //
        //  EXCLUDE FEATS IN THIS SECTION
        //
        // I gave 3 examples below of how to exclude a bonus feat from being
        // added to an item.  In the examples, if Alertness, Dodge, or
        // Weapon Finesse is rolled as a random bonus feat, then the generator
        // re-rolls until a feat that isn't below is found.  If you uncomment
        // this section of code, ALWAYS leave the default alone.  The default
        // guarantees that this function doesn't get stuck in a loop forever
        // by setting nContinue to FALSE.  Don't change it.  Substitute the
        // IP_CONST_FEAT_* that you do not want to appear for one of my
        // examples. If you desire to disallow more than 3, then you'll need
        // to make additional case statements like in the examples shown.
        //
        //
        // WARNING: There is a possibility of creating significant lag if you
        //    have a whole lot of disallowed feats with only a couple of
        //    acceptable ones. The reason is the while statement keeps
        //    re-rolling a number between 0 and 386.  It might take it a LONG
        //    time to pick an acceptable feat if you disallow almost everything.
        //    It would be better to rewrite this function a different way if you
        //    are going to disallow more than half of the bonus feats.
        // VITALLY IMPORTANT NOTE: Don't disallow everything or else this will
        //    crash the game because it will get stuck in a loop forever. If you
        //    want to disallow ALL bonus feats from appearing on an item, do so
        //    by setting FW_ALLOW_BONUS_FEAT = FALSE;
        /*
        case IP_CONST_FEAT_ALERTNESS: nReRoll = TRUE;
           break;
        case IP_CONST_FEAT_DODGE: nReRoll = TRUE;
           break;
        case IP_CONST_FEAT_WEAPFINESSE: nReRoll = TRUE;
           break;
        */
        //**************************************
        // We found an acceptable feat!!
        default: nReRoll = FALSE;
           break;
     }
  }
  ipAdd = ItemPropertyBonusFeat (nRoll);
  return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses a random amount of bonus hit points to add to an item
// * min and max should be positive integers between 1 and 50.  Because of how
// * the item property bonus hit points is implemented in NWN 2, it goes like
// * this:  1,2,3,...,20, 25, 30, 35, 40, 45, 50.
//
itemproperty FW_Choose_IP_Bonus_Hit_Points (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_BONUS_HIT_POINTS == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_BONUS_HIT_POINTS_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_BONUS_HIT_POINTS_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_BONUS_HIT_POINTS_CR_0 ; max = FW_MAX_BONUS_HIT_POINTS_CR_0 ;    break;
		
		case 1: min = FW_MIN_BONUS_HIT_POINTS_CR_1 ; max = FW_MAX_BONUS_HIT_POINTS_CR_1 ;    break;
		case 2: min = FW_MIN_BONUS_HIT_POINTS_CR_2 ; max = FW_MAX_BONUS_HIT_POINTS_CR_2 ;    break;
		case 3: min = FW_MIN_BONUS_HIT_POINTS_CR_3 ; max = FW_MAX_BONUS_HIT_POINTS_CR_3 ;    break;
   		case 4: min = FW_MIN_BONUS_HIT_POINTS_CR_4 ; max = FW_MAX_BONUS_HIT_POINTS_CR_4 ;    break;
		case 5: min = FW_MIN_BONUS_HIT_POINTS_CR_5 ; max = FW_MAX_BONUS_HIT_POINTS_CR_5 ;    break;
		case 6: min = FW_MIN_BONUS_HIT_POINTS_CR_6 ; max = FW_MAX_BONUS_HIT_POINTS_CR_6 ;    break;
   		case 7: min = FW_MIN_BONUS_HIT_POINTS_CR_7 ; max = FW_MAX_BONUS_HIT_POINTS_CR_7 ;    break;
		case 8: min = FW_MIN_BONUS_HIT_POINTS_CR_8 ; max = FW_MAX_BONUS_HIT_POINTS_CR_8 ;    break;
		case 9: min = FW_MIN_BONUS_HIT_POINTS_CR_9 ; max = FW_MAX_BONUS_HIT_POINTS_CR_9 ;    break;
   		case 10: min = FW_MIN_BONUS_HIT_POINTS_CR_10 ; max = FW_MAX_BONUS_HIT_POINTS_CR_10 ; break;
		
		case 11: min = FW_MIN_BONUS_HIT_POINTS_CR_11 ; max = FW_MAX_BONUS_HIT_POINTS_CR_11 ;  break;
		case 12: min = FW_MIN_BONUS_HIT_POINTS_CR_12 ; max = FW_MAX_BONUS_HIT_POINTS_CR_12 ;  break;
		case 13: min = FW_MIN_BONUS_HIT_POINTS_CR_13 ; max = FW_MAX_BONUS_HIT_POINTS_CR_13 ;  break;
   		case 14: min = FW_MIN_BONUS_HIT_POINTS_CR_14 ; max = FW_MAX_BONUS_HIT_POINTS_CR_14 ;  break;
		case 15: min = FW_MIN_BONUS_HIT_POINTS_CR_15 ; max = FW_MAX_BONUS_HIT_POINTS_CR_15 ;  break;
		case 16: min = FW_MIN_BONUS_HIT_POINTS_CR_16 ; max = FW_MAX_BONUS_HIT_POINTS_CR_16 ;  break;
   		case 17: min = FW_MIN_BONUS_HIT_POINTS_CR_17 ; max = FW_MAX_BONUS_HIT_POINTS_CR_17 ;  break;
		case 18: min = FW_MIN_BONUS_HIT_POINTS_CR_18 ; max = FW_MAX_BONUS_HIT_POINTS_CR_18 ;  break;
		case 19: min = FW_MIN_BONUS_HIT_POINTS_CR_19 ; max = FW_MAX_BONUS_HIT_POINTS_CR_19 ;  break;
   		case 20: min = FW_MIN_BONUS_HIT_POINTS_CR_20 ; max = FW_MAX_BONUS_HIT_POINTS_CR_20 ;  break;
   
   		case 21: min = FW_MIN_BONUS_HIT_POINTS_CR_21 ; max = FW_MAX_BONUS_HIT_POINTS_CR_21 ;  break;
		case 22: min = FW_MIN_BONUS_HIT_POINTS_CR_22 ; max = FW_MAX_BONUS_HIT_POINTS_CR_22 ;  break;
		case 23: min = FW_MIN_BONUS_HIT_POINTS_CR_23 ; max = FW_MAX_BONUS_HIT_POINTS_CR_23 ;  break;
   		case 24: min = FW_MIN_BONUS_HIT_POINTS_CR_24 ; max = FW_MAX_BONUS_HIT_POINTS_CR_24 ;  break;
		case 25: min = FW_MIN_BONUS_HIT_POINTS_CR_25 ; max = FW_MAX_BONUS_HIT_POINTS_CR_25 ;  break;
		case 26: min = FW_MIN_BONUS_HIT_POINTS_CR_26 ; max = FW_MAX_BONUS_HIT_POINTS_CR_26 ;  break;
   		case 27: min = FW_MIN_BONUS_HIT_POINTS_CR_27 ; max = FW_MAX_BONUS_HIT_POINTS_CR_27 ;  break;
		case 28: min = FW_MIN_BONUS_HIT_POINTS_CR_28 ; max = FW_MAX_BONUS_HIT_POINTS_CR_28 ;  break;
		case 29: min = FW_MIN_BONUS_HIT_POINTS_CR_29 ; max = FW_MAX_BONUS_HIT_POINTS_CR_29 ;  break;
   		case 30: min = FW_MIN_BONUS_HIT_POINTS_CR_30 ; max = FW_MAX_BONUS_HIT_POINTS_CR_30 ;  break;		
		
		case 31: min = FW_MIN_BONUS_HIT_POINTS_CR_31 ; max = FW_MAX_BONUS_HIT_POINTS_CR_31 ;  break;
		case 32: min = FW_MIN_BONUS_HIT_POINTS_CR_32 ; max = FW_MAX_BONUS_HIT_POINTS_CR_32 ;  break;
		case 33: min = FW_MIN_BONUS_HIT_POINTS_CR_33 ; max = FW_MAX_BONUS_HIT_POINTS_CR_33 ;  break;
   		case 34: min = FW_MIN_BONUS_HIT_POINTS_CR_34 ; max = FW_MAX_BONUS_HIT_POINTS_CR_34 ;  break;
		case 35: min = FW_MIN_BONUS_HIT_POINTS_CR_35 ; max = FW_MAX_BONUS_HIT_POINTS_CR_35 ;  break;
		case 36: min = FW_MIN_BONUS_HIT_POINTS_CR_36 ; max = FW_MAX_BONUS_HIT_POINTS_CR_36 ;  break;
   		case 37: min = FW_MIN_BONUS_HIT_POINTS_CR_37 ; max = FW_MAX_BONUS_HIT_POINTS_CR_37 ;  break;
		case 38: min = FW_MIN_BONUS_HIT_POINTS_CR_38 ; max = FW_MAX_BONUS_HIT_POINTS_CR_38 ;  break;
		case 39: min = FW_MIN_BONUS_HIT_POINTS_CR_39 ; max = FW_MAX_BONUS_HIT_POINTS_CR_39 ;  break;
   		case 40: min = FW_MIN_BONUS_HIT_POINTS_CR_40 ; max = FW_MAX_BONUS_HIT_POINTS_CR_40 ;  break;
		
		case 41: min = FW_MIN_BONUS_HIT_POINTS_CR_41_OR_HIGHER; max = FW_MAX_BONUS_HIT_POINTS_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nBonus;
   // Because at 20 the numbers jump by intervals of five in the iprp_bonushp
   // .2da file I am mapping the min and max to the row value inside the .2da
   // rounding down.
   if (min < 1)
      min = 1;
   if (max < 1)
      max = 1;
   if (min >= 21 && min <= 24)
      min = 20;
   if (max >= 21 && max <= 24)
      max = 20;
   if (min >= 25 && min <= 29)
      min = 21;
   if (max >= 25 && max <= 29)
      max = 21;
   if (min >= 30 && min <= 34)
      min = 22;
   if (max >= 30 && max <= 34)
      max = 22;
   if (min >= 35 && min <= 39)
      min = 23;
   if (max >= 35 && max<= 39)
      max = 23;
   if (min >= 40 && min <= 44)
      min = 24;
   if (max >= 40 && max <= 44)
      max = 24;
   if (min >= 45 && min <= 49)
      min = 25;
   if (max >= 45 && max <= 49)
      max = 25;
   if (min >= 50)
      min = 26;
   if (max >= 50)
      max = 26;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyBonusHitpoints(nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a bonus spell of level 0...9 to be added to
// * an item.  Values for min and max should be an integer between 0 and 9.
//
itemproperty FW_Choose_IP_Bonus_Level_Spell (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_BONUS_LEVEL_SPELL == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_BONUS_LEVEL_SPELL_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_BONUS_LEVEL_SPELL_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_BONUS_LEVEL_SPELL_CR_0 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_0 ;    break;
		
		case 1: min = FW_MIN_BONUS_LEVEL_SPELL_CR_1 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_1 ;    break;
		case 2: min = FW_MIN_BONUS_LEVEL_SPELL_CR_2 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_2 ;    break;
		case 3: min = FW_MIN_BONUS_LEVEL_SPELL_CR_3 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_3 ;    break;
   		case 4: min = FW_MIN_BONUS_LEVEL_SPELL_CR_4 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_4 ;    break;
		case 5: min = FW_MIN_BONUS_LEVEL_SPELL_CR_5 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_5 ;    break;
		case 6: min = FW_MIN_BONUS_LEVEL_SPELL_CR_6 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_6 ;    break;
   		case 7: min = FW_MIN_BONUS_LEVEL_SPELL_CR_7 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_7 ;    break;
		case 8: min = FW_MIN_BONUS_LEVEL_SPELL_CR_8 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_8 ;    break;
		case 9: min = FW_MIN_BONUS_LEVEL_SPELL_CR_9 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_9 ;    break;
   		case 10: min = FW_MIN_BONUS_LEVEL_SPELL_CR_10 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_10 ; break;
		
		case 11: min = FW_MIN_BONUS_LEVEL_SPELL_CR_11 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_11 ;  break;
		case 12: min = FW_MIN_BONUS_LEVEL_SPELL_CR_12 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_12 ;  break;
		case 13: min = FW_MIN_BONUS_LEVEL_SPELL_CR_13 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_13 ;  break;
   		case 14: min = FW_MIN_BONUS_LEVEL_SPELL_CR_14 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_14 ;  break;
		case 15: min = FW_MIN_BONUS_LEVEL_SPELL_CR_15 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_15 ;  break;
		case 16: min = FW_MIN_BONUS_LEVEL_SPELL_CR_16 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_16 ;  break;
   		case 17: min = FW_MIN_BONUS_LEVEL_SPELL_CR_17 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_17 ;  break;
		case 18: min = FW_MIN_BONUS_LEVEL_SPELL_CR_18 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_18 ;  break;
		case 19: min = FW_MIN_BONUS_LEVEL_SPELL_CR_19 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_19 ;  break;
   		case 20: min = FW_MIN_BONUS_LEVEL_SPELL_CR_20 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_20 ;  break;
   
   		case 21: min = FW_MIN_BONUS_LEVEL_SPELL_CR_21 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_21 ;  break;
		case 22: min = FW_MIN_BONUS_LEVEL_SPELL_CR_22 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_22 ;  break;
		case 23: min = FW_MIN_BONUS_LEVEL_SPELL_CR_23 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_23 ;  break;
   		case 24: min = FW_MIN_BONUS_LEVEL_SPELL_CR_24 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_24 ;  break;
		case 25: min = FW_MIN_BONUS_LEVEL_SPELL_CR_25 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_25 ;  break;
		case 26: min = FW_MIN_BONUS_LEVEL_SPELL_CR_26 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_26 ;  break;
   		case 27: min = FW_MIN_BONUS_LEVEL_SPELL_CR_27 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_27 ;  break;
		case 28: min = FW_MIN_BONUS_LEVEL_SPELL_CR_28 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_28 ;  break;
		case 29: min = FW_MIN_BONUS_LEVEL_SPELL_CR_29 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_29 ;  break;
   		case 30: min = FW_MIN_BONUS_LEVEL_SPELL_CR_30 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_30 ;  break;		
		
		case 31: min = FW_MIN_BONUS_LEVEL_SPELL_CR_31 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_31 ;  break;
		case 32: min = FW_MIN_BONUS_LEVEL_SPELL_CR_32 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_32 ;  break;
		case 33: min = FW_MIN_BONUS_LEVEL_SPELL_CR_33 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_33 ;  break;
   		case 34: min = FW_MIN_BONUS_LEVEL_SPELL_CR_34 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_34 ;  break;
		case 35: min = FW_MIN_BONUS_LEVEL_SPELL_CR_35 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_35 ;  break;
		case 36: min = FW_MIN_BONUS_LEVEL_SPELL_CR_36 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_36 ;  break;
   		case 37: min = FW_MIN_BONUS_LEVEL_SPELL_CR_37 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_37 ;  break;
		case 38: min = FW_MIN_BONUS_LEVEL_SPELL_CR_38 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_38 ;  break;
		case 39: min = FW_MIN_BONUS_LEVEL_SPELL_CR_39 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_39 ;  break;
   		case 40: min = FW_MIN_BONUS_LEVEL_SPELL_CR_40 ; max = FW_MAX_BONUS_LEVEL_SPELL_CR_40 ;  break;
		
		case 41: min = FW_MIN_BONUS_LEVEL_SPELL_CR_41_OR_HIGHER; max = FW_MAX_BONUS_LEVEL_SPELL_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nClass;
   int nSpellLevel;

   if (min < 0)
      min = 0;
   if (min > 9)
      min = 9;
   if (max < 0)
      max = 0;
   if (max > 9)
      max = 9;
   int nRoll = Random (7);
   switch (nRoll)
   {
      case 0: nClass = IP_CONST_CLASS_BARD;
              if (max > 6) { min = 0; max = 6; }
         break;
      case 1: nClass = IP_CONST_CLASS_CLERIC;
         break;
      case 2: nClass = IP_CONST_CLASS_DRUID;
         break;
      case 3: nClass = IP_CONST_CLASS_PALADIN;
              if (max > 4) { min = 0; max = 4; }
         break;
      case 4: nClass = IP_CONST_CLASS_RANGER;
              if (max > 4) { min = 0; max = 4; }
         break;
      case 5: nClass = IP_CONST_CLASS_SORCERER;
         break;
      case 6: nClass = IP_CONST_CLASS_WIZARD;
         break;
      default: break;
   } // end of switch
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nSpellLevel = 1;  }
   else if (min == max)
      {  nSpellLevel = min;  }
   else
   {
      int nValue = max - min + 1;
      nSpellLevel = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyBonusLevelSpell(nClass, nSpellLevel);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a bonus saving throw to add to an item.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Bonus_Saving_Throw (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_BONUS_SAVING_THROW == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_BONUS_SAVING_THROW_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_BONUS_SAVING_THROW_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_BONUS_SAVING_THROW_CR_0 ; max = FW_MAX_BONUS_SAVING_THROW_CR_0 ;    break;
		
		case 1: min = FW_MIN_BONUS_SAVING_THROW_CR_1 ; max = FW_MAX_BONUS_SAVING_THROW_CR_1 ;    break;
		case 2: min = FW_MIN_BONUS_SAVING_THROW_CR_2 ; max = FW_MAX_BONUS_SAVING_THROW_CR_2 ;    break;
		case 3: min = FW_MIN_BONUS_SAVING_THROW_CR_3 ; max = FW_MAX_BONUS_SAVING_THROW_CR_3 ;    break;
   		case 4: min = FW_MIN_BONUS_SAVING_THROW_CR_4 ; max = FW_MAX_BONUS_SAVING_THROW_CR_4 ;    break;
		case 5: min = FW_MIN_BONUS_SAVING_THROW_CR_5 ; max = FW_MAX_BONUS_SAVING_THROW_CR_5 ;    break;
		case 6: min = FW_MIN_BONUS_SAVING_THROW_CR_6 ; max = FW_MAX_BONUS_SAVING_THROW_CR_6 ;    break;
   		case 7: min = FW_MIN_BONUS_SAVING_THROW_CR_7 ; max = FW_MAX_BONUS_SAVING_THROW_CR_7 ;    break;
		case 8: min = FW_MIN_BONUS_SAVING_THROW_CR_8 ; max = FW_MAX_BONUS_SAVING_THROW_CR_8 ;    break;
		case 9: min = FW_MIN_BONUS_SAVING_THROW_CR_9 ; max = FW_MAX_BONUS_SAVING_THROW_CR_9 ;    break;
   		case 10: min = FW_MIN_BONUS_SAVING_THROW_CR_10 ; max = FW_MAX_BONUS_SAVING_THROW_CR_10 ; break;
		
		case 11: min = FW_MIN_BONUS_SAVING_THROW_CR_11 ; max = FW_MAX_BONUS_SAVING_THROW_CR_11 ;  break;
		case 12: min = FW_MIN_BONUS_SAVING_THROW_CR_12 ; max = FW_MAX_BONUS_SAVING_THROW_CR_12 ;  break;
		case 13: min = FW_MIN_BONUS_SAVING_THROW_CR_13 ; max = FW_MAX_BONUS_SAVING_THROW_CR_13 ;  break;
   		case 14: min = FW_MIN_BONUS_SAVING_THROW_CR_14 ; max = FW_MAX_BONUS_SAVING_THROW_CR_14 ;  break;
		case 15: min = FW_MIN_BONUS_SAVING_THROW_CR_15 ; max = FW_MAX_BONUS_SAVING_THROW_CR_15 ;  break;
		case 16: min = FW_MIN_BONUS_SAVING_THROW_CR_16 ; max = FW_MAX_BONUS_SAVING_THROW_CR_16 ;  break;
   		case 17: min = FW_MIN_BONUS_SAVING_THROW_CR_17 ; max = FW_MAX_BONUS_SAVING_THROW_CR_17 ;  break;
		case 18: min = FW_MIN_BONUS_SAVING_THROW_CR_18 ; max = FW_MAX_BONUS_SAVING_THROW_CR_18 ;  break;
		case 19: min = FW_MIN_BONUS_SAVING_THROW_CR_19 ; max = FW_MAX_BONUS_SAVING_THROW_CR_19 ;  break;
   		case 20: min = FW_MIN_BONUS_SAVING_THROW_CR_20 ; max = FW_MAX_BONUS_SAVING_THROW_CR_20 ;  break;
   
   		case 21: min = FW_MIN_BONUS_SAVING_THROW_CR_21 ; max = FW_MAX_BONUS_SAVING_THROW_CR_21 ;  break;
		case 22: min = FW_MIN_BONUS_SAVING_THROW_CR_22 ; max = FW_MAX_BONUS_SAVING_THROW_CR_22 ;  break;
		case 23: min = FW_MIN_BONUS_SAVING_THROW_CR_23 ; max = FW_MAX_BONUS_SAVING_THROW_CR_23 ;  break;
   		case 24: min = FW_MIN_BONUS_SAVING_THROW_CR_24 ; max = FW_MAX_BONUS_SAVING_THROW_CR_24 ;  break;
		case 25: min = FW_MIN_BONUS_SAVING_THROW_CR_25 ; max = FW_MAX_BONUS_SAVING_THROW_CR_25 ;  break;
		case 26: min = FW_MIN_BONUS_SAVING_THROW_CR_26 ; max = FW_MAX_BONUS_SAVING_THROW_CR_26 ;  break;
   		case 27: min = FW_MIN_BONUS_SAVING_THROW_CR_27 ; max = FW_MAX_BONUS_SAVING_THROW_CR_27 ;  break;
		case 28: min = FW_MIN_BONUS_SAVING_THROW_CR_28 ; max = FW_MAX_BONUS_SAVING_THROW_CR_28 ;  break;
		case 29: min = FW_MIN_BONUS_SAVING_THROW_CR_29 ; max = FW_MAX_BONUS_SAVING_THROW_CR_29 ;  break;
   		case 30: min = FW_MIN_BONUS_SAVING_THROW_CR_30 ; max = FW_MAX_BONUS_SAVING_THROW_CR_30 ;  break;		
		
		case 31: min = FW_MIN_BONUS_SAVING_THROW_CR_31 ; max = FW_MAX_BONUS_SAVING_THROW_CR_31 ;  break;
		case 32: min = FW_MIN_BONUS_SAVING_THROW_CR_32 ; max = FW_MAX_BONUS_SAVING_THROW_CR_32 ;  break;
		case 33: min = FW_MIN_BONUS_SAVING_THROW_CR_33 ; max = FW_MAX_BONUS_SAVING_THROW_CR_33 ;  break;
   		case 34: min = FW_MIN_BONUS_SAVING_THROW_CR_34 ; max = FW_MAX_BONUS_SAVING_THROW_CR_34 ;  break;
		case 35: min = FW_MIN_BONUS_SAVING_THROW_CR_35 ; max = FW_MAX_BONUS_SAVING_THROW_CR_35 ;  break;
		case 36: min = FW_MIN_BONUS_SAVING_THROW_CR_36 ; max = FW_MAX_BONUS_SAVING_THROW_CR_36 ;  break;
   		case 37: min = FW_MIN_BONUS_SAVING_THROW_CR_37 ; max = FW_MAX_BONUS_SAVING_THROW_CR_37 ;  break;
		case 38: min = FW_MIN_BONUS_SAVING_THROW_CR_38 ; max = FW_MAX_BONUS_SAVING_THROW_CR_38 ;  break;
		case 39: min = FW_MIN_BONUS_SAVING_THROW_CR_39 ; max = FW_MAX_BONUS_SAVING_THROW_CR_39 ;  break;
   		case 40: min = FW_MIN_BONUS_SAVING_THROW_CR_40 ; max = FW_MAX_BONUS_SAVING_THROW_CR_40 ;  break;
		
		case 41: min = FW_MIN_BONUS_SAVING_THROW_CR_41_OR_HIGHER; max = FW_MAX_BONUS_SAVING_THROW_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else	  
   int nBaseSaveType;
   int nBonus;

   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   int nRoll = Random (3);
   switch (nRoll)
   {
      case 0: nBaseSaveType = IP_CONST_SAVEBASETYPE_FORTITUDE;
         break;
      case 1: nBaseSaveType = IP_CONST_SAVEBASETYPE_REFLEX;
         break;
      case 2: nBaseSaveType = IP_CONST_SAVEBASETYPE_WILL;
         break;
      default: break;
   } // end of switch
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyBonusSavingThrow(nBaseSaveType, nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a bonus saving throw VS 'XYZ' to add to an
// * Item. Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Bonus_Saving_Throw_VsX (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_BONUS_SAVING_THROW_VSX == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_BONUS_SAVING_THROW_VSX_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_BONUS_SAVING_THROW_VSX_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_0 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_0 ;    break;
		
		case 1: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_1 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_1 ;    break;
		case 2: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_2 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_2 ;    break;
		case 3: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_3 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_3 ;    break;
   		case 4: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_4 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_4 ;    break;
		case 5: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_5 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_5 ;    break;
		case 6: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_6 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_6 ;    break;
   		case 7: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_7 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_7 ;    break;
		case 8: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_8 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_8 ;    break;
		case 9: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_9 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_9 ;    break;
   		case 10: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_10 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_10 ; break;
		
		case 11: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_11 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_11 ;  break;
		case 12: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_12 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_12 ;  break;
		case 13: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_13 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_13 ;  break;
   		case 14: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_14 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_14 ;  break;
		case 15: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_15 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_15 ;  break;
		case 16: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_16 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_16 ;  break;
   		case 17: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_17 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_17 ;  break;
		case 18: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_18 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_18 ;  break;
		case 19: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_19 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_19 ;  break;
   		case 20: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_20 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_20 ;  break;
   
   		case 21: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_21 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_21 ;  break;
		case 22: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_22 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_22 ;  break;
		case 23: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_23 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_23 ;  break;
   		case 24: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_24 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_24 ;  break;
		case 25: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_25 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_25 ;  break;
		case 26: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_26 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_26 ;  break;
   		case 27: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_27 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_27 ;  break;
		case 28: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_28 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_28 ;  break;
		case 29: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_29 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_29 ;  break;
   		case 30: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_30 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_30 ;  break;		
		
		case 31: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_31 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_31 ;  break;
		case 32: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_32 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_32 ;  break;
		case 33: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_33 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_33 ;  break;
   		case 34: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_34 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_34 ;  break;
		case 35: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_35 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_35 ;  break;
		case 36: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_36 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_36 ;  break;
   		case 37: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_37 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_37 ;  break;
		case 38: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_38 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_38 ;  break;
		case 39: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_39 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_39 ;  break;
   		case 40: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_40 ; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_40 ;  break;
		
		case 41: min = FW_MIN_BONUS_SAVING_THROW_VSX_CR_41_OR_HIGHER; max = FW_MAX_BONUS_SAVING_THROW_VSX_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nBonusType;
   int nBonus;

   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   int nRoll = Random (14);
   switch (nRoll)
   {
      case 0: nBonusType = IP_CONST_SAVEVS_ACID;
         break;
      case 1: nBonusType = IP_CONST_SAVEVS_COLD;
         break;
      case 2: nBonusType = IP_CONST_SAVEVS_DEATH;
         break;
      case 3: nBonusType = IP_CONST_SAVEVS_DISEASE;
         break;
      case 4: nBonusType = IP_CONST_SAVEVS_DIVINE;
         break;
      case 5: nBonusType = IP_CONST_SAVEVS_ELECTRICAL;
         break;
      case 6: nBonusType = IP_CONST_SAVEVS_FEAR;
         break;
      case 7: nBonusType = IP_CONST_SAVEVS_FIRE;
         break;
      case 8: nBonusType = IP_CONST_SAVEVS_MINDAFFECTING;
         break;
      case 9: nBonusType = IP_CONST_SAVEVS_NEGATIVE;
         break;
      case 10: nBonusType = IP_CONST_SAVEVS_POISON;
         break;
      case 11: nBonusType = IP_CONST_SAVEVS_POSITIVE;
         break;
      case 12: nBonusType = IP_CONST_SAVEVS_SONIC;
         break;
      case 13: nBonusType = IP_CONST_SAVEVS_UNIVERSAL;
         break;
      default: break;
   } // end of switch
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   if (nBonusType == IP_CONST_SAVEVS_UNIVERSAL && nBonus > FW_MAX_BONUS_SAVING_THROW_VS_UNIVERSAL) {
      nBonus = FW_MAX_BONUS_SAVING_THROW_VS_UNIVERSAL;
   }
   ipAdd = ItemPropertyBonusSavingThrowVsX(nBonusType, nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a bonus spell resistance to add to an item.
// * Values for min and max should be an integer between 10 and 32 in even
// * increments of 2. I.E. 10,12,14,16,18,20,22,24,26,28,30,32
//
itemproperty FW_Choose_IP_Bonus_Spell_Resistance (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_BONUS_SPELL_RESISTANCE == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
   		// Note: Different formula than normal.
		max = FloatToInt(nCR * FW_MAX_BONUS_SPELL_RESISTANCE_MODIFIER) ;
		min = FloatToInt(nCR * FW_MIN_BONUS_SPELL_RESISTANCE_MODIFIER) ;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_0 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_0 ;    break;
		
		case 1: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_1 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_1 ;    break;
		case 2: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_2 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_2 ;    break;
		case 3: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_3 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_3 ;    break;
   		case 4: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_4 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_4 ;    break;
		case 5: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_5 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_5 ;    break;
		case 6: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_6 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_6 ;    break;
   		case 7: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_7 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_7 ;    break;
		case 8: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_8 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_8 ;    break;
		case 9: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_9 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_9 ;    break;
   		case 10: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_10 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_10 ; break;
		
		case 11: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_11 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_11 ;  break;
		case 12: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_12 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_12 ;  break;
		case 13: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_13 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_13 ;  break;
   		case 14: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_14 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_14 ;  break;
		case 15: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_15 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_15 ;  break;
		case 16: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_16 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_16 ;  break;
   		case 17: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_17 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_17 ;  break;
		case 18: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_18 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_18 ;  break;
		case 19: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_19 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_19 ;  break;
   		case 20: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_20 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_20 ;  break;
   
   		case 21: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_21 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_21 ;  break;
		case 22: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_22 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_22 ;  break;
		case 23: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_23 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_23 ;  break;
   		case 24: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_24 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_24 ;  break;
		case 25: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_25 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_25 ;  break;
		case 26: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_26 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_26 ;  break;
   		case 27: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_27 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_27 ;  break;
		case 28: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_28 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_28 ;  break;
		case 29: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_29 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_29 ;  break;
   		case 30: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_30 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_30 ;  break;		
		
		case 31: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_31 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_31 ;  break;
		case 32: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_32 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_32 ;  break;
		case 33: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_33 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_33 ;  break;
   		case 34: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_34 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_34 ;  break;
		case 35: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_35 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_35 ;  break;
		case 36: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_36 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_36 ;  break;
   		case 37: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_37 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_37 ;  break;
		case 38: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_38 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_38 ;  break;
		case 39: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_39 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_39 ;  break;
   		case 40: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_40 ; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_40 ;  break;
		
		case 41: min = FW_MIN_BONUS_SPELL_RESISTANCE_CR_41_OR_HIGHER; max = FW_MAX_BONUS_SPELL_RESISTANCE_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of switch
   int nBonus;

   // This is to stop people placing values outside the limits of 10 and 32.
   if (min < 10)
      min = 10;
   if (min > 32)
      min = 32;
   if (max < 10)
      max = 10;
   if (max > 32)
      max = 32;

   int nValue1 = (min - 10) / 2;
   int nValue2 = (max - 10) / 2;
   int nMappedValue = nValue2 - nValue1 + 1;
   int nRoll = Random(nMappedValue)+ nValue1;
   switch (nRoll)
   {
      case 0: nBonus = IP_CONST_SPELLRESISTANCEBONUS_10;
         break;
      case 1: nBonus = IP_CONST_SPELLRESISTANCEBONUS_12;
         break;
      case 2: nBonus = IP_CONST_SPELLRESISTANCEBONUS_14;
         break;
      case 3: nBonus = IP_CONST_SPELLRESISTANCEBONUS_16;
         break;
      case 4: nBonus = IP_CONST_SPELLRESISTANCEBONUS_18;
         break;
      case 5: nBonus = IP_CONST_SPELLRESISTANCEBONUS_20;
         break;
      case 6: nBonus = IP_CONST_SPELLRESISTANCEBONUS_22;
         break;
      case 7: nBonus = IP_CONST_SPELLRESISTANCEBONUS_24;
         break;
      case 8: nBonus = IP_CONST_SPELLRESISTANCEBONUS_26;
         break;
      case 9: nBonus = IP_CONST_SPELLRESISTANCEBONUS_28;
         break;
      case 10: nBonus = IP_CONST_SPELLRESISTANCEBONUS_30;
         break;
      case 11: nBonus = IP_CONST_SPELLRESISTANCEBONUS_32;
         break;
      default: break;
   } // end of switch
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = IP_CONST_SPELLRESISTANCEBONUS_10;  }
   ipAdd = ItemPropertyBonusSpellResistance(nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a spell to be added to an item as a cast
// * spell item property.
//
itemproperty FW_Choose_IP_Cast_Spell ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_CAST_SPELL == FALSE)
      return ipAdd;
   int nSpell;
   int nNumUses;
   int nReRoll = TRUE;

   while (nReRoll)
   {
      // As of 12 May 2008 there are 708 spells in NWN 2. See "iprp_spells.2da"
      nSpell = Random (708);
      switch (nSpell)
      {
	  		// Excluding spells here that were deleted, but still have entries
			// in iprp_spells.2da and they didn't set Label to "****". 
			// LEAVE THESE ALONE.  YOU EXCLUDE SPELLS IN THE SECTION BELOW THIS ONE
			case 200: case 314: case 315: case 316: case 317: case 318: case 319:
			case 320: case 329: case 335: case 344: case 351: case 353: case 359: 
			case 370: case 372: case 452: case 453: case 454: case 459: case 460:
			case 462: case 463: case 465: case 468: case 469: case 470: case 471: 
			case 478: case 496: case 497: case 498: case 499: case 500: case 513:
			case 536: case 537: case 540: case 553: case 607: case 608: case 609: 
			nReRoll = TRUE;
			break; 
        //**************************************
        //
        //  EXCLUDE SPELLS IN THIS SECTION
        //
        // I gave 3 examples below of how to exclude a bonus spell from being
        // added to an item.  In the examples, if Aid(3), Awaken(9), or Bane(5)
        // is rolled as a random cast spell, then the generator re-rolls until a
        // spell that isn't disallowed below is found.  If you uncomment
        // this section of code, ALWAYS leave the default alone.  The default
        // guarantees that this function doesn't get stuck in a loop forever
        // by setting nReRoll to FALSE.  Don't change it.  Substitute the
        // IP_CONST_CASTSPELL_* that you do not want to appear in for one of my
        // examples. If you desire to disallow more than 3, then you'll need
        // to make additional case statements like in the examples shown.
        //
        //
        // WARNING: There is a possibility of creating significant lag if you
        //    have a whole lot of disallowed spells with only a couple of
        //    acceptable ones. The reason is the while statement keeps
        //    re-rolling a number between 0 and 646.  It might take it a LONG
        //    time to pick an acceptable spell if you disallow almost everything.
        //    It would be better to rewrite this function a different way if you
        //    are going to disallow more than half of the spells.
        // VITALLY IMPORTANT NOTE: Don't disallow everything or else this will
        //    crash the game because it will get stuck in a loop forever. If you
        //    want to disallow ALL spells from appearing on an item, do so
        //    by setting FW_ALLOW_CAST_SPELL = FALSE;
        /*
        case IP_CONST_CASTSPELL_AID_3: nReRoll = TRUE;
           break;
        case IP_CONST_CASTSPELL_AWAKEN_9: nReRoll = TRUE;
           break;
        case IP_CONST_CASTSPELL_BANE_5: nReRoll = TRUE;
           break;
        */
        //**************************************
        // We found an acceptable spell!! NEVER CHANGE THE DEFAULT FROM FALSE.
        default: nReRoll = FALSE;
           break;
      } // end of switch

      // Here I am going to see if the random generator rolled a spell that was
      // removed.  In the .2da file iprp_spells if a spell has been removed its
      // label value is equal to "****"  The Get2DAString function Returns ""
      // (empty string) for "****".  If we rolled a spell that was removed, then
      // we need to reroll, so I set nReRoll = TRUE to force a reroll.
      string sCheck = "";
      string sLabel;
      sLabel = Get2DAString ("iprp_spells", "Label", nSpell);
      if (sLabel == sCheck)
         nReRoll = TRUE;
   } // end of while

   // Now we have to choose a random number of uses.
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
   // Now that we have a spell chosen and the number of uses we can finally
   // make the itemproperty work.
   ipAdd = ItemPropertyCastSpell (nSpell, nNumUses);
   return ipAdd;
} // end of function

////////////////////////////////////////////
// * Function that randomly chooses a damage type and damage bonus to be added
// * to an item.
//
itemproperty FW_Choose_IP_Damage_Bonus (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_DAMAGE_BONUS == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
   		// NOTE: DIFFERENT FORMULA
		max = FloatToInt(nCR * FW_MAX_DAMAGE_BONUS_MODIFIER) - 1;
		min = FloatToInt(nCR * FW_MIN_DAMAGE_BONUS_MODIFIER) - 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_DAMAGE_BONUS_CR_0 ; max = FW_MAX_DAMAGE_BONUS_CR_0 ;    break;
		
		case 1: min = FW_MIN_DAMAGE_BONUS_CR_1 ; max = FW_MAX_DAMAGE_BONUS_CR_1 ;    break;
		case 2: min = FW_MIN_DAMAGE_BONUS_CR_2 ; max = FW_MAX_DAMAGE_BONUS_CR_2 ;    break;
		case 3: min = FW_MIN_DAMAGE_BONUS_CR_3 ; max = FW_MAX_DAMAGE_BONUS_CR_3 ;    break;
   		case 4: min = FW_MIN_DAMAGE_BONUS_CR_4 ; max = FW_MAX_DAMAGE_BONUS_CR_4 ;    break;
		case 5: min = FW_MIN_DAMAGE_BONUS_CR_5 ; max = FW_MAX_DAMAGE_BONUS_CR_5 ;    break;
		case 6: min = FW_MIN_DAMAGE_BONUS_CR_6 ; max = FW_MAX_DAMAGE_BONUS_CR_6 ;    break;
   		case 7: min = FW_MIN_DAMAGE_BONUS_CR_7 ; max = FW_MAX_DAMAGE_BONUS_CR_7 ;    break;
		case 8: min = FW_MIN_DAMAGE_BONUS_CR_8 ; max = FW_MAX_DAMAGE_BONUS_CR_8 ;    break;
		case 9: min = FW_MIN_DAMAGE_BONUS_CR_9 ; max = FW_MAX_DAMAGE_BONUS_CR_9 ;    break;
   		case 10: min = FW_MIN_DAMAGE_BONUS_CR_10 ; max = FW_MAX_DAMAGE_BONUS_CR_10 ; break;
		
		case 11: min = FW_MIN_DAMAGE_BONUS_CR_11 ; max = FW_MAX_DAMAGE_BONUS_CR_11 ;  break;
		case 12: min = FW_MIN_DAMAGE_BONUS_CR_12 ; max = FW_MAX_DAMAGE_BONUS_CR_12 ;  break;
		case 13: min = FW_MIN_DAMAGE_BONUS_CR_13 ; max = FW_MAX_DAMAGE_BONUS_CR_13 ;  break;
   		case 14: min = FW_MIN_DAMAGE_BONUS_CR_14 ; max = FW_MAX_DAMAGE_BONUS_CR_14 ;  break;
		case 15: min = FW_MIN_DAMAGE_BONUS_CR_15 ; max = FW_MAX_DAMAGE_BONUS_CR_15 ;  break;
		case 16: min = FW_MIN_DAMAGE_BONUS_CR_16 ; max = FW_MAX_DAMAGE_BONUS_CR_16 ;  break;
   		case 17: min = FW_MIN_DAMAGE_BONUS_CR_17 ; max = FW_MAX_DAMAGE_BONUS_CR_17 ;  break;
		case 18: min = FW_MIN_DAMAGE_BONUS_CR_18 ; max = FW_MAX_DAMAGE_BONUS_CR_18 ;  break;
		case 19: min = FW_MIN_DAMAGE_BONUS_CR_19 ; max = FW_MAX_DAMAGE_BONUS_CR_19 ;  break;
   		case 20: min = FW_MIN_DAMAGE_BONUS_CR_20 ; max = FW_MAX_DAMAGE_BONUS_CR_20 ;  break;
   
   		case 21: min = FW_MIN_DAMAGE_BONUS_CR_21 ; max = FW_MAX_DAMAGE_BONUS_CR_21 ;  break;
		case 22: min = FW_MIN_DAMAGE_BONUS_CR_22 ; max = FW_MAX_DAMAGE_BONUS_CR_22 ;  break;
		case 23: min = FW_MIN_DAMAGE_BONUS_CR_23 ; max = FW_MAX_DAMAGE_BONUS_CR_23 ;  break;
   		case 24: min = FW_MIN_DAMAGE_BONUS_CR_24 ; max = FW_MAX_DAMAGE_BONUS_CR_24 ;  break;
		case 25: min = FW_MIN_DAMAGE_BONUS_CR_25 ; max = FW_MAX_DAMAGE_BONUS_CR_25 ;  break;
		case 26: min = FW_MIN_DAMAGE_BONUS_CR_26 ; max = FW_MAX_DAMAGE_BONUS_CR_26 ;  break;
   		case 27: min = FW_MIN_DAMAGE_BONUS_CR_27 ; max = FW_MAX_DAMAGE_BONUS_CR_27 ;  break;
		case 28: min = FW_MIN_DAMAGE_BONUS_CR_28 ; max = FW_MAX_DAMAGE_BONUS_CR_28 ;  break;
		case 29: min = FW_MIN_DAMAGE_BONUS_CR_29 ; max = FW_MAX_DAMAGE_BONUS_CR_29 ;  break;
   		case 30: min = FW_MIN_DAMAGE_BONUS_CR_30 ; max = FW_MAX_DAMAGE_BONUS_CR_30 ;  break;		
		
		case 31: min = FW_MIN_DAMAGE_BONUS_CR_31 ; max = FW_MAX_DAMAGE_BONUS_CR_31 ;  break;
		case 32: min = FW_MIN_DAMAGE_BONUS_CR_32 ; max = FW_MAX_DAMAGE_BONUS_CR_32 ;  break;
		case 33: min = FW_MIN_DAMAGE_BONUS_CR_33 ; max = FW_MAX_DAMAGE_BONUS_CR_33 ;  break;
   		case 34: min = FW_MIN_DAMAGE_BONUS_CR_34 ; max = FW_MAX_DAMAGE_BONUS_CR_34 ;  break;
		case 35: min = FW_MIN_DAMAGE_BONUS_CR_35 ; max = FW_MAX_DAMAGE_BONUS_CR_35 ;  break;
		case 36: min = FW_MIN_DAMAGE_BONUS_CR_36 ; max = FW_MAX_DAMAGE_BONUS_CR_36 ;  break;
   		case 37: min = FW_MIN_DAMAGE_BONUS_CR_37 ; max = FW_MAX_DAMAGE_BONUS_CR_37 ;  break;
		case 38: min = FW_MIN_DAMAGE_BONUS_CR_38 ; max = FW_MAX_DAMAGE_BONUS_CR_38 ;  break;
		case 39: min = FW_MIN_DAMAGE_BONUS_CR_39 ; max = FW_MAX_DAMAGE_BONUS_CR_39 ;  break;
   		case 40: min = FW_MIN_DAMAGE_BONUS_CR_40 ; max = FW_MAX_DAMAGE_BONUS_CR_40 ;  break;
		
		case 41: min = FW_MIN_DAMAGE_BONUS_CR_41_OR_HIGHER; max = FW_MAX_DAMAGE_BONUS_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else	  
   int nDamageType = FW_Choose_IP_CONST_DAMAGETYPE ();
   int nDamage = FW_Choose_IP_CONST_DAMAGEBONUS (min, max);
   ipAdd = ItemPropertyDamageBonus(nDamageType, nDamage);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an alignment group, damage type, and damage
// * bonus to be added to an item.
//
itemproperty FW_Choose_IP_Damage_Bonus_Vs_Align (int nCR = 0)
{
   itemproperty ipAdd;
   if ( FW_ALLOW_DAMAGE_BONUS_VS_ALIGNMENT == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
   		// NOTE DIFFERENT FORMULA
		max = FloatToInt(nCR * FW_MAX_DAMAGE_BONUS_VS_ALIGN_MODIFIER) - 1;
		min = FloatToInt(nCR * FW_MIN_DAMAGE_BONUS_VS_ALIGN_MODIFIER) - 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_0 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_0 ;    break;
		
		case 1: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_1 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_1 ;    break;
		case 2: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_2 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_2 ;    break;
		case 3: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_3 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_3 ;    break;
   		case 4: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_4 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_4 ;    break;
		case 5: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_5 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_5 ;    break;
		case 6: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_6 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_6 ;    break;
   		case 7: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_7 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_7 ;    break;
		case 8: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_8 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_8 ;    break;
		case 9: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_9 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_9 ;    break;
   		case 10: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_10 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_10 ; break;
		
		case 11: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_11 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_11 ;  break;
		case 12: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_12 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_12 ;  break;
		case 13: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_13 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_13 ;  break;
   		case 14: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_14 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_14 ;  break;
		case 15: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_15 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_15 ;  break;
		case 16: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_16 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_16 ;  break;
   		case 17: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_17 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_17 ;  break;
		case 18: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_18 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_18 ;  break;
		case 19: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_19 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_19 ;  break;
   		case 20: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_20 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_20 ;  break;
   
   		case 21: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_21 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_21 ;  break;
		case 22: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_22 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_22 ;  break;
		case 23: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_23 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_23 ;  break;
   		case 24: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_24 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_24 ;  break;
		case 25: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_25 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_25 ;  break;
		case 26: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_26 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_26 ;  break;
   		case 27: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_27 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_27 ;  break;
		case 28: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_28 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_28 ;  break;
		case 29: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_29 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_29 ;  break;
   		case 30: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_30 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_30 ;  break;		
		
		case 31: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_31 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_31 ;  break;
		case 32: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_32 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_32 ;  break;
		case 33: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_33 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_33 ;  break;
   		case 34: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_34 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_34 ;  break;
		case 35: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_35 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_35 ;  break;
		case 36: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_36 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_36 ;  break;
   		case 37: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_37 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_37 ;  break;
		case 38: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_38 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_38 ;  break;
		case 39: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_39 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_39 ;  break;
   		case 40: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_40 ; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_40 ;  break;
		
		case 41: min = FW_MIN_DAMAGE_BONUS_VS_ALIGNMENT_CR_41_OR_HIGHER; max = FW_MAX_DAMAGE_BONUS_VS_ALIGNMENT_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nAlignGroup = FW_Choose_IP_CONST_ALIGNMENTGROUP ();
   int nDamageType = FW_Choose_IP_CONST_DAMAGETYPE ();
   int nDamage = FW_Choose_IP_CONST_DAMAGEBONUS (min, max);
   ipAdd = ItemPropertyDamageBonusVsAlign(nAlignGroup, nDamageType, nDamage);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a race, damage type, and damage
// * bonus to be added to an item.
//
itemproperty FW_Choose_IP_Damage_Bonus_Vs_Race (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_DAMAGE_BONUS_VS_RACE == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
   		// 	NOTE DIFFERENT FORMULA
		max = FloatToInt(nCR * FW_MAX_DAMAGE_BONUS_VS_RACE_MODIFIER) - 1;
		min = FloatToInt(nCR * FW_MIN_DAMAGE_BONUS_VS_RACE_MODIFIER) - 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_0 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_0 ;    break;
		
		case 1: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_1 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_1 ;    break;
		case 2: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_2 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_2 ;    break;
		case 3: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_3 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_3 ;    break;
   		case 4: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_4 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_4 ;    break;
		case 5: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_5 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_5 ;    break;
		case 6: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_6 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_6 ;    break;
   		case 7: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_7 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_7 ;    break;
		case 8: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_8 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_8 ;    break;
		case 9: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_9 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_9 ;    break;
   		case 10: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_10 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_10 ; break;
		
		case 11: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_11 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_11 ;  break;
		case 12: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_12 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_12 ;  break;
		case 13: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_13 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_13 ;  break;
   		case 14: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_14 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_14 ;  break;
		case 15: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_15 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_15 ;  break;
		case 16: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_16 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_16 ;  break;
   		case 17: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_17 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_17 ;  break;
		case 18: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_18 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_18 ;  break;
		case 19: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_19 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_19 ;  break;
   		case 20: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_20 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_20 ;  break;
   
   		case 21: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_21 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_21 ;  break;
		case 22: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_22 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_22 ;  break;
		case 23: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_23 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_23 ;  break;
   		case 24: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_24 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_24 ;  break;
		case 25: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_25 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_25 ;  break;
		case 26: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_26 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_26 ;  break;
   		case 27: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_27 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_27 ;  break;
		case 28: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_28 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_28 ;  break;
		case 29: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_29 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_29 ;  break;
   		case 30: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_30 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_30 ;  break;		
		
		case 31: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_31 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_31 ;  break;
		case 32: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_32 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_32 ;  break;
		case 33: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_33 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_33 ;  break;
   		case 34: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_34 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_34 ;  break;
		case 35: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_35 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_35 ;  break;
		case 36: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_36 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_36 ;  break;
   		case 37: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_37 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_37 ;  break;
		case 38: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_38 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_38 ;  break;
		case 39: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_39 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_39 ;  break;
   		case 40: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_40 ; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_40 ;  break;
		
		case 41: min = FW_MIN_DAMAGE_BONUS_VS_RACE_CR_41_OR_HIGHER; max = FW_MAX_DAMAGE_BONUS_VS_RACE_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else  
   int nRace = FW_Choose_IP_CONST_RACIALTYPE ();
   int nDamageType = FW_Choose_IP_CONST_DAMAGETYPE ();
   int nDamage = FW_Choose_IP_CONST_DAMAGEBONUS (min, max);
   ipAdd = ItemPropertyDamageBonusVsRace(nRace, nDamageType, nDamage);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a specific alignment, damage type, and damage
// * bonus to be added to an item.
//
itemproperty FW_Choose_IP_Damage_Bonus_Vs_SAlign (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_DAMAGE_BONUS_VS_SALIGNMENT == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
   		// NOTE DIFFERENT FORMULA
		max = FloatToInt(nCR * FW_MAX_DAMAGE_BONUS_VS_SALIGN_MODIFIER) - 1;
		min = FloatToInt(nCR * FW_MIN_DAMAGE_BONUS_VS_SALIGN_MODIFIER) - 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_0 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_0 ;    break;
		
		case 1: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_1 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_1 ;    break;
		case 2: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_2 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_2 ;    break;
		case 3: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_3 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_3 ;    break;
   		case 4: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_4 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_4 ;    break;
		case 5: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_5 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_5 ;    break;
		case 6: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_6 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_6 ;    break;
   		case 7: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_7 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_7 ;    break;
		case 8: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_8 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_8 ;    break;
		case 9: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_9 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_9 ;    break;
   		case 10: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_10 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_10 ; break;
		
		case 11: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_11 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_11 ;  break;
		case 12: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_12 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_12 ;  break;
		case 13: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_13 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_13 ;  break;
   		case 14: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_14 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_14 ;  break;
		case 15: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_15 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_15 ;  break;
		case 16: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_16 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_16 ;  break;
   		case 17: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_17 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_17 ;  break;
		case 18: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_18 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_18 ;  break;
		case 19: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_19 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_19 ;  break;
   		case 20: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_20 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_20 ;  break;
   
   		case 21: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_21 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_21 ;  break;
		case 22: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_22 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_22 ;  break;
		case 23: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_23 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_23 ;  break;
   		case 24: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_24 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_24 ;  break;
		case 25: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_25 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_25 ;  break;
		case 26: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_26 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_26 ;  break;
   		case 27: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_27 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_27 ;  break;
		case 28: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_28 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_28 ;  break;
		case 29: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_29 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_29 ;  break;
   		case 30: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_30 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_30 ;  break;		
		
		case 31: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_31 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_31 ;  break;
		case 32: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_32 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_32 ;  break;
		case 33: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_33 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_33 ;  break;
   		case 34: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_34 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_34 ;  break;
		case 35: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_35 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_35 ;  break;
		case 36: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_36 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_36 ;  break;
   		case 37: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_37 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_37 ;  break;
		case 38: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_38 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_38 ;  break;
		case 39: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_39 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_39 ;  break;
   		case 40: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_40 ; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_40 ;  break;
		
		case 41: min = FW_MIN_DAMAGE_BONUS_VS_SALIGNMENT_CR_41_OR_HIGHER; max = FW_MAX_DAMAGE_BONUS_VS_SALIGNMENT_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else	  
   int nSAlign = FW_Choose_IP_CONST_SALIGN ();
   int nDamageType = FW_Choose_IP_CONST_DAMAGETYPE ();
   int nDamage = FW_Choose_IP_CONST_DAMAGEBONUS (min, max);
   ipAdd = ItemPropertyDamageBonusVsSAlign(nSAlign, nDamageType, nDamage);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a damage type and damage immunity amount to
// * be added to an item.
//
itemproperty FW_Choose_IP_Damage_Immunity ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_DAMAGE_IMMUNITY == FALSE)
      return ipAdd;
   int nDamageType = FW_Choose_IP_CONST_DAMAGETYPE ();
   int nBonus;
   int nRoll = Random (7);
   switch (nRoll)
   {
      case 0: nBonus = IP_CONST_DAMAGEIMMUNITY_5_PERCENT;
         break;
      case 1: nBonus = IP_CONST_DAMAGEIMMUNITY_10_PERCENT;
         break;
      case 2: nBonus = IP_CONST_DAMAGEIMMUNITY_25_PERCENT;
         break;
      case 3: nBonus = IP_CONST_DAMAGEIMMUNITY_50_PERCENT;
         break;
      case 4: nBonus = IP_CONST_DAMAGEIMMUNITY_75_PERCENT;
         break;
      case 5: nBonus = IP_CONST_DAMAGEIMMUNITY_90_PERCENT;
         break;
      case 6: nBonus = IP_CONST_DAMAGEIMMUNITY_100_PERCENT;
         break;
   }
   ipAdd = ItemPropertyDamageImmunity(nDamageType, nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a damage penalty.  Values for min and
// * max should be an integer between 1 and 5. Yes that is right. 5 is the max.
//
itemproperty FW_Choose_IP_Damage_Penalty (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_DAMAGE_PENALTY == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_DAMAGE_PENALTY_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_DAMAGE_PENALTY_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_DAMAGE_PENALTY_CR_0 ; max = FW_MAX_DAMAGE_PENALTY_CR_0 ;    break;
		
		case 1: min = FW_MIN_DAMAGE_PENALTY_CR_1 ; max = FW_MAX_DAMAGE_PENALTY_CR_1 ;    break;
		case 2: min = FW_MIN_DAMAGE_PENALTY_CR_2 ; max = FW_MAX_DAMAGE_PENALTY_CR_2 ;    break;
		case 3: min = FW_MIN_DAMAGE_PENALTY_CR_3 ; max = FW_MAX_DAMAGE_PENALTY_CR_3 ;    break;
   		case 4: min = FW_MIN_DAMAGE_PENALTY_CR_4 ; max = FW_MAX_DAMAGE_PENALTY_CR_4 ;    break;
		case 5: min = FW_MIN_DAMAGE_PENALTY_CR_5 ; max = FW_MAX_DAMAGE_PENALTY_CR_5 ;    break;
		case 6: min = FW_MIN_DAMAGE_PENALTY_CR_6 ; max = FW_MAX_DAMAGE_PENALTY_CR_6 ;    break;
   		case 7: min = FW_MIN_DAMAGE_PENALTY_CR_7 ; max = FW_MAX_DAMAGE_PENALTY_CR_7 ;    break;
		case 8: min = FW_MIN_DAMAGE_PENALTY_CR_8 ; max = FW_MAX_DAMAGE_PENALTY_CR_8 ;    break;
		case 9: min = FW_MIN_DAMAGE_PENALTY_CR_9 ; max = FW_MAX_DAMAGE_PENALTY_CR_9 ;    break;
   		case 10: min = FW_MIN_DAMAGE_PENALTY_CR_10 ; max = FW_MAX_DAMAGE_PENALTY_CR_10 ; break;
		
		case 11: min = FW_MIN_DAMAGE_PENALTY_CR_11 ; max = FW_MAX_DAMAGE_PENALTY_CR_11 ;  break;
		case 12: min = FW_MIN_DAMAGE_PENALTY_CR_12 ; max = FW_MAX_DAMAGE_PENALTY_CR_12 ;  break;
		case 13: min = FW_MIN_DAMAGE_PENALTY_CR_13 ; max = FW_MAX_DAMAGE_PENALTY_CR_13 ;  break;
   		case 14: min = FW_MIN_DAMAGE_PENALTY_CR_14 ; max = FW_MAX_DAMAGE_PENALTY_CR_14 ;  break;
		case 15: min = FW_MIN_DAMAGE_PENALTY_CR_15 ; max = FW_MAX_DAMAGE_PENALTY_CR_15 ;  break;
		case 16: min = FW_MIN_DAMAGE_PENALTY_CR_16 ; max = FW_MAX_DAMAGE_PENALTY_CR_16 ;  break;
   		case 17: min = FW_MIN_DAMAGE_PENALTY_CR_17 ; max = FW_MAX_DAMAGE_PENALTY_CR_17 ;  break;
		case 18: min = FW_MIN_DAMAGE_PENALTY_CR_18 ; max = FW_MAX_DAMAGE_PENALTY_CR_18 ;  break;
		case 19: min = FW_MIN_DAMAGE_PENALTY_CR_19 ; max = FW_MAX_DAMAGE_PENALTY_CR_19 ;  break;
   		case 20: min = FW_MIN_DAMAGE_PENALTY_CR_20 ; max = FW_MAX_DAMAGE_PENALTY_CR_20 ;  break;
   
   		case 21: min = FW_MIN_DAMAGE_PENALTY_CR_21 ; max = FW_MAX_DAMAGE_PENALTY_CR_21 ;  break;
		case 22: min = FW_MIN_DAMAGE_PENALTY_CR_22 ; max = FW_MAX_DAMAGE_PENALTY_CR_22 ;  break;
		case 23: min = FW_MIN_DAMAGE_PENALTY_CR_23 ; max = FW_MAX_DAMAGE_PENALTY_CR_23 ;  break;
   		case 24: min = FW_MIN_DAMAGE_PENALTY_CR_24 ; max = FW_MAX_DAMAGE_PENALTY_CR_24 ;  break;
		case 25: min = FW_MIN_DAMAGE_PENALTY_CR_25 ; max = FW_MAX_DAMAGE_PENALTY_CR_25 ;  break;
		case 26: min = FW_MIN_DAMAGE_PENALTY_CR_26 ; max = FW_MAX_DAMAGE_PENALTY_CR_26 ;  break;
   		case 27: min = FW_MIN_DAMAGE_PENALTY_CR_27 ; max = FW_MAX_DAMAGE_PENALTY_CR_27 ;  break;
		case 28: min = FW_MIN_DAMAGE_PENALTY_CR_28 ; max = FW_MAX_DAMAGE_PENALTY_CR_28 ;  break;
		case 29: min = FW_MIN_DAMAGE_PENALTY_CR_29 ; max = FW_MAX_DAMAGE_PENALTY_CR_29 ;  break;
   		case 30: min = FW_MIN_DAMAGE_PENALTY_CR_30 ; max = FW_MAX_DAMAGE_PENALTY_CR_30 ;  break;		
		
		case 31: min = FW_MIN_DAMAGE_PENALTY_CR_31 ; max = FW_MAX_DAMAGE_PENALTY_CR_31 ;  break;
		case 32: min = FW_MIN_DAMAGE_PENALTY_CR_32 ; max = FW_MAX_DAMAGE_PENALTY_CR_32 ;  break;
		case 33: min = FW_MIN_DAMAGE_PENALTY_CR_33 ; max = FW_MAX_DAMAGE_PENALTY_CR_33 ;  break;
   		case 34: min = FW_MIN_DAMAGE_PENALTY_CR_34 ; max = FW_MAX_DAMAGE_PENALTY_CR_34 ;  break;
		case 35: min = FW_MIN_DAMAGE_PENALTY_CR_35 ; max = FW_MAX_DAMAGE_PENALTY_CR_35 ;  break;
		case 36: min = FW_MIN_DAMAGE_PENALTY_CR_36 ; max = FW_MAX_DAMAGE_PENALTY_CR_36 ;  break;
   		case 37: min = FW_MIN_DAMAGE_PENALTY_CR_37 ; max = FW_MAX_DAMAGE_PENALTY_CR_37 ;  break;
		case 38: min = FW_MIN_DAMAGE_PENALTY_CR_38 ; max = FW_MAX_DAMAGE_PENALTY_CR_38 ;  break;
		case 39: min = FW_MIN_DAMAGE_PENALTY_CR_39 ; max = FW_MAX_DAMAGE_PENALTY_CR_39 ;  break;
   		case 40: min = FW_MIN_DAMAGE_PENALTY_CR_40 ; max = FW_MAX_DAMAGE_PENALTY_CR_40 ;  break;
		
		case 41: min = FW_MIN_DAMAGE_PENALTY_CR_41_OR_HIGHER; max = FW_MAX_DAMAGE_PENALTY_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else	  
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 5)
      min = 5;
   if (max < 1)
      max = 1;
   if (max > 5)
      max = 5;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyDamagePenalty(nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an enhancement level that is required to get
// * past the damage reduction as well as choosing the amount of hit points that
// * will be absorbed if the weapon is not of high enough enhancement.
//
itemproperty FW_Choose_IP_Damage_Reduction (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_DAMAGE_REDUCTION == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_DAMAGE_REDUCTION_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_DAMAGE_REDUCTION_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_DAMAGE_REDUCTION_CR_0 ; max = FW_MAX_DAMAGE_REDUCTION_CR_0 ;    break;
		
		case 1: min = FW_MIN_DAMAGE_REDUCTION_CR_1 ; max = FW_MAX_DAMAGE_REDUCTION_CR_1 ;    break;
		case 2: min = FW_MIN_DAMAGE_REDUCTION_CR_2 ; max = FW_MAX_DAMAGE_REDUCTION_CR_2 ;    break;
		case 3: min = FW_MIN_DAMAGE_REDUCTION_CR_3 ; max = FW_MAX_DAMAGE_REDUCTION_CR_3 ;    break;
   		case 4: min = FW_MIN_DAMAGE_REDUCTION_CR_4 ; max = FW_MAX_DAMAGE_REDUCTION_CR_4 ;    break;
		case 5: min = FW_MIN_DAMAGE_REDUCTION_CR_5 ; max = FW_MAX_DAMAGE_REDUCTION_CR_5 ;    break;
		case 6: min = FW_MIN_DAMAGE_REDUCTION_CR_6 ; max = FW_MAX_DAMAGE_REDUCTION_CR_6 ;    break;
   		case 7: min = FW_MIN_DAMAGE_REDUCTION_CR_7 ; max = FW_MAX_DAMAGE_REDUCTION_CR_7 ;    break;
		case 8: min = FW_MIN_DAMAGE_REDUCTION_CR_8 ; max = FW_MAX_DAMAGE_REDUCTION_CR_8 ;    break;
		case 9: min = FW_MIN_DAMAGE_REDUCTION_CR_9 ; max = FW_MAX_DAMAGE_REDUCTION_CR_9 ;    break;
   		case 10: min = FW_MIN_DAMAGE_REDUCTION_CR_10 ; max = FW_MAX_DAMAGE_REDUCTION_CR_10 ; break;
		
		case 11: min = FW_MIN_DAMAGE_REDUCTION_CR_11 ; max = FW_MAX_DAMAGE_REDUCTION_CR_11 ;  break;
		case 12: min = FW_MIN_DAMAGE_REDUCTION_CR_12 ; max = FW_MAX_DAMAGE_REDUCTION_CR_12 ;  break;
		case 13: min = FW_MIN_DAMAGE_REDUCTION_CR_13 ; max = FW_MAX_DAMAGE_REDUCTION_CR_13 ;  break;
   		case 14: min = FW_MIN_DAMAGE_REDUCTION_CR_14 ; max = FW_MAX_DAMAGE_REDUCTION_CR_14 ;  break;
		case 15: min = FW_MIN_DAMAGE_REDUCTION_CR_15 ; max = FW_MAX_DAMAGE_REDUCTION_CR_15 ;  break;
		case 16: min = FW_MIN_DAMAGE_REDUCTION_CR_16 ; max = FW_MAX_DAMAGE_REDUCTION_CR_16 ;  break;
   		case 17: min = FW_MIN_DAMAGE_REDUCTION_CR_17 ; max = FW_MAX_DAMAGE_REDUCTION_CR_17 ;  break;
		case 18: min = FW_MIN_DAMAGE_REDUCTION_CR_18 ; max = FW_MAX_DAMAGE_REDUCTION_CR_18 ;  break;
		case 19: min = FW_MIN_DAMAGE_REDUCTION_CR_19 ; max = FW_MAX_DAMAGE_REDUCTION_CR_19 ;  break;
   		case 20: min = FW_MIN_DAMAGE_REDUCTION_CR_20 ; max = FW_MAX_DAMAGE_REDUCTION_CR_20 ;  break;
   
   		case 21: min = FW_MIN_DAMAGE_REDUCTION_CR_21 ; max = FW_MAX_DAMAGE_REDUCTION_CR_21 ;  break;
		case 22: min = FW_MIN_DAMAGE_REDUCTION_CR_22 ; max = FW_MAX_DAMAGE_REDUCTION_CR_22 ;  break;
		case 23: min = FW_MIN_DAMAGE_REDUCTION_CR_23 ; max = FW_MAX_DAMAGE_REDUCTION_CR_23 ;  break;
   		case 24: min = FW_MIN_DAMAGE_REDUCTION_CR_24 ; max = FW_MAX_DAMAGE_REDUCTION_CR_24 ;  break;
		case 25: min = FW_MIN_DAMAGE_REDUCTION_CR_25 ; max = FW_MAX_DAMAGE_REDUCTION_CR_25 ;  break;
		case 26: min = FW_MIN_DAMAGE_REDUCTION_CR_26 ; max = FW_MAX_DAMAGE_REDUCTION_CR_26 ;  break;
   		case 27: min = FW_MIN_DAMAGE_REDUCTION_CR_27 ; max = FW_MAX_DAMAGE_REDUCTION_CR_27 ;  break;
		case 28: min = FW_MIN_DAMAGE_REDUCTION_CR_28 ; max = FW_MAX_DAMAGE_REDUCTION_CR_28 ;  break;
		case 29: min = FW_MIN_DAMAGE_REDUCTION_CR_29 ; max = FW_MAX_DAMAGE_REDUCTION_CR_29 ;  break;
   		case 30: min = FW_MIN_DAMAGE_REDUCTION_CR_30 ; max = FW_MAX_DAMAGE_REDUCTION_CR_30 ;  break;		
		
		case 31: min = FW_MIN_DAMAGE_REDUCTION_CR_31 ; max = FW_MAX_DAMAGE_REDUCTION_CR_31 ;  break;
		case 32: min = FW_MIN_DAMAGE_REDUCTION_CR_32 ; max = FW_MAX_DAMAGE_REDUCTION_CR_32 ;  break;
		case 33: min = FW_MIN_DAMAGE_REDUCTION_CR_33 ; max = FW_MAX_DAMAGE_REDUCTION_CR_33 ;  break;
   		case 34: min = FW_MIN_DAMAGE_REDUCTION_CR_34 ; max = FW_MAX_DAMAGE_REDUCTION_CR_34 ;  break;
		case 35: min = FW_MIN_DAMAGE_REDUCTION_CR_35 ; max = FW_MAX_DAMAGE_REDUCTION_CR_35 ;  break;
		case 36: min = FW_MIN_DAMAGE_REDUCTION_CR_36 ; max = FW_MAX_DAMAGE_REDUCTION_CR_36 ;  break;
   		case 37: min = FW_MIN_DAMAGE_REDUCTION_CR_37 ; max = FW_MAX_DAMAGE_REDUCTION_CR_37 ;  break;
		case 38: min = FW_MIN_DAMAGE_REDUCTION_CR_38 ; max = FW_MAX_DAMAGE_REDUCTION_CR_38 ;  break;
		case 39: min = FW_MIN_DAMAGE_REDUCTION_CR_39 ; max = FW_MAX_DAMAGE_REDUCTION_CR_39 ;  break;
   		case 40: min = FW_MIN_DAMAGE_REDUCTION_CR_40 ; max = FW_MAX_DAMAGE_REDUCTION_CR_40 ;  break;
		
		case 41: min = FW_MIN_DAMAGE_REDUCTION_CR_41_OR_HIGHER; max = FW_MAX_DAMAGE_REDUCTION_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else	  
   int nEnhancement = FW_Choose_IP_CONST_DAMAGEREDUCTION (min, max);

   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
   		// NOTE DIFFERENT FORMULA
		max = FloatToInt(nCR * FW_MAX_DAMAGESOAK_HP_MODIFIER) * 5;
		min = FloatToInt(nCR * FW_MIN_DAMAGESOAK_HP_MODIFIER) * 5;
   }
   else
   { 
   // NOW DETERMINE THE AMOUNT OF HP TO SOAK   
   switch (nCR)
   {
		case 0: min = FW_MIN_DAMAGESOAK_HP_CR_0 ; max = FW_MAX_DAMAGESOAK_HP_CR_0 ;    break;
		
		case 1: min = FW_MIN_DAMAGESOAK_HP_CR_1 ; max = FW_MAX_DAMAGESOAK_HP_CR_1 ;    break;
		case 2: min = FW_MIN_DAMAGESOAK_HP_CR_2 ; max = FW_MAX_DAMAGESOAK_HP_CR_2 ;    break;
		case 3: min = FW_MIN_DAMAGESOAK_HP_CR_3 ; max = FW_MAX_DAMAGESOAK_HP_CR_3 ;    break;
   		case 4: min = FW_MIN_DAMAGESOAK_HP_CR_4 ; max = FW_MAX_DAMAGESOAK_HP_CR_4 ;    break;
		case 5: min = FW_MIN_DAMAGESOAK_HP_CR_5 ; max = FW_MAX_DAMAGESOAK_HP_CR_5 ;    break;
		case 6: min = FW_MIN_DAMAGESOAK_HP_CR_6 ; max = FW_MAX_DAMAGESOAK_HP_CR_6 ;    break;
   		case 7: min = FW_MIN_DAMAGESOAK_HP_CR_7 ; max = FW_MAX_DAMAGESOAK_HP_CR_7 ;    break;
		case 8: min = FW_MIN_DAMAGESOAK_HP_CR_8 ; max = FW_MAX_DAMAGESOAK_HP_CR_8 ;    break;
		case 9: min = FW_MIN_DAMAGESOAK_HP_CR_9 ; max = FW_MAX_DAMAGESOAK_HP_CR_9 ;    break;
   		case 10: min = FW_MIN_DAMAGESOAK_HP_CR_10 ; max = FW_MAX_DAMAGESOAK_HP_CR_10 ; break;
		
		case 11: min = FW_MIN_DAMAGESOAK_HP_CR_11 ; max = FW_MAX_DAMAGESOAK_HP_CR_11 ;  break;
		case 12: min = FW_MIN_DAMAGESOAK_HP_CR_12 ; max = FW_MAX_DAMAGESOAK_HP_CR_12 ;  break;
		case 13: min = FW_MIN_DAMAGESOAK_HP_CR_13 ; max = FW_MAX_DAMAGESOAK_HP_CR_13 ;  break;
   		case 14: min = FW_MIN_DAMAGESOAK_HP_CR_14 ; max = FW_MAX_DAMAGESOAK_HP_CR_14 ;  break;
		case 15: min = FW_MIN_DAMAGESOAK_HP_CR_15 ; max = FW_MAX_DAMAGESOAK_HP_CR_15 ;  break;
		case 16: min = FW_MIN_DAMAGESOAK_HP_CR_16 ; max = FW_MAX_DAMAGESOAK_HP_CR_16 ;  break;
   		case 17: min = FW_MIN_DAMAGESOAK_HP_CR_17 ; max = FW_MAX_DAMAGESOAK_HP_CR_17 ;  break;
		case 18: min = FW_MIN_DAMAGESOAK_HP_CR_18 ; max = FW_MAX_DAMAGESOAK_HP_CR_18 ;  break;
		case 19: min = FW_MIN_DAMAGESOAK_HP_CR_19 ; max = FW_MAX_DAMAGESOAK_HP_CR_19 ;  break;
   		case 20: min = FW_MIN_DAMAGESOAK_HP_CR_20 ; max = FW_MAX_DAMAGESOAK_HP_CR_20 ;  break;
   
   		case 21: min = FW_MIN_DAMAGESOAK_HP_CR_21 ; max = FW_MAX_DAMAGESOAK_HP_CR_21 ;  break;
		case 22: min = FW_MIN_DAMAGESOAK_HP_CR_22 ; max = FW_MAX_DAMAGESOAK_HP_CR_22 ;  break;
		case 23: min = FW_MIN_DAMAGESOAK_HP_CR_23 ; max = FW_MAX_DAMAGESOAK_HP_CR_23 ;  break;
   		case 24: min = FW_MIN_DAMAGESOAK_HP_CR_24 ; max = FW_MAX_DAMAGESOAK_HP_CR_24 ;  break;
		case 25: min = FW_MIN_DAMAGESOAK_HP_CR_25 ; max = FW_MAX_DAMAGESOAK_HP_CR_25 ;  break;
		case 26: min = FW_MIN_DAMAGESOAK_HP_CR_26 ; max = FW_MAX_DAMAGESOAK_HP_CR_26 ;  break;
   		case 27: min = FW_MIN_DAMAGESOAK_HP_CR_27 ; max = FW_MAX_DAMAGESOAK_HP_CR_27 ;  break;
		case 28: min = FW_MIN_DAMAGESOAK_HP_CR_28 ; max = FW_MAX_DAMAGESOAK_HP_CR_28 ;  break;
		case 29: min = FW_MIN_DAMAGESOAK_HP_CR_29 ; max = FW_MAX_DAMAGESOAK_HP_CR_29 ;  break;
   		case 30: min = FW_MIN_DAMAGESOAK_HP_CR_30 ; max = FW_MAX_DAMAGESOAK_HP_CR_30 ;  break;		
		
		case 31: min = FW_MIN_DAMAGESOAK_HP_CR_31 ; max = FW_MAX_DAMAGESOAK_HP_CR_31 ;  break;
		case 32: min = FW_MIN_DAMAGESOAK_HP_CR_32 ; max = FW_MAX_DAMAGESOAK_HP_CR_32 ;  break;
		case 33: min = FW_MIN_DAMAGESOAK_HP_CR_33 ; max = FW_MAX_DAMAGESOAK_HP_CR_33 ;  break;
   		case 34: min = FW_MIN_DAMAGESOAK_HP_CR_34 ; max = FW_MAX_DAMAGESOAK_HP_CR_34 ;  break;
		case 35: min = FW_MIN_DAMAGESOAK_HP_CR_35 ; max = FW_MAX_DAMAGESOAK_HP_CR_35 ;  break;
		case 36: min = FW_MIN_DAMAGESOAK_HP_CR_36 ; max = FW_MAX_DAMAGESOAK_HP_CR_36 ;  break;
   		case 37: min = FW_MIN_DAMAGESOAK_HP_CR_37 ; max = FW_MAX_DAMAGESOAK_HP_CR_37 ;  break;
		case 38: min = FW_MIN_DAMAGESOAK_HP_CR_38 ; max = FW_MAX_DAMAGESOAK_HP_CR_38 ;  break;
		case 39: min = FW_MIN_DAMAGESOAK_HP_CR_39 ; max = FW_MAX_DAMAGESOAK_HP_CR_39 ;  break;
   		case 40: min = FW_MIN_DAMAGESOAK_HP_CR_40 ; max = FW_MAX_DAMAGESOAK_HP_CR_40 ;  break;
		
		case 41: min = FW_MIN_DAMAGESOAK_HP_CR_41_OR_HIGHER; max = FW_MAX_DAMAGESOAK_HP_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else
   int nHPSoak = FW_Choose_IP_CONST_DAMAGESOAK (min, max);
   ipAdd = ItemPropertyDamageReduction (nEnhancement, nHPSoak);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an amount of hit points that will be
// * resisted each round, subject to min and max values. Acceptable values for
// * min and max are: 5,10,15,...,50
//
itemproperty FW_Choose_IP_Damage_Resistance (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_DAMAGE_RESISTANCE == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
   		// NOTE DIFFERENT FORMULA
		max = FloatToInt(nCR * FW_MAX_DAMAGE_RESISTANCE_MODIFIER) * 5;
		min = FloatToInt(nCR * FW_MIN_DAMAGE_RESISTANCE_MODIFIER) * 5;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_DAMAGERESIST_HP_CR_0 ; max = FW_MAX_DAMAGERESIST_HP_CR_0 ;    break;
		
		case 1: min = FW_MIN_DAMAGERESIST_HP_CR_1 ; max = FW_MAX_DAMAGERESIST_HP_CR_1 ;    break;
		case 2: min = FW_MIN_DAMAGERESIST_HP_CR_2 ; max = FW_MAX_DAMAGERESIST_HP_CR_2 ;    break;
		case 3: min = FW_MIN_DAMAGERESIST_HP_CR_3 ; max = FW_MAX_DAMAGERESIST_HP_CR_3 ;    break;
   		case 4: min = FW_MIN_DAMAGERESIST_HP_CR_4 ; max = FW_MAX_DAMAGERESIST_HP_CR_4 ;    break;
		case 5: min = FW_MIN_DAMAGERESIST_HP_CR_5 ; max = FW_MAX_DAMAGERESIST_HP_CR_5 ;    break;
		case 6: min = FW_MIN_DAMAGERESIST_HP_CR_6 ; max = FW_MAX_DAMAGERESIST_HP_CR_6 ;    break;
   		case 7: min = FW_MIN_DAMAGERESIST_HP_CR_7 ; max = FW_MAX_DAMAGERESIST_HP_CR_7 ;    break;
		case 8: min = FW_MIN_DAMAGERESIST_HP_CR_8 ; max = FW_MAX_DAMAGERESIST_HP_CR_8 ;    break;
		case 9: min = FW_MIN_DAMAGERESIST_HP_CR_9 ; max = FW_MAX_DAMAGERESIST_HP_CR_9 ;    break;
   		case 10: min = FW_MIN_DAMAGERESIST_HP_CR_10 ; max = FW_MAX_DAMAGERESIST_HP_CR_10 ; break;
		
		case 11: min = FW_MIN_DAMAGERESIST_HP_CR_11 ; max = FW_MAX_DAMAGERESIST_HP_CR_11 ;  break;
		case 12: min = FW_MIN_DAMAGERESIST_HP_CR_12 ; max = FW_MAX_DAMAGERESIST_HP_CR_12 ;  break;
		case 13: min = FW_MIN_DAMAGERESIST_HP_CR_13 ; max = FW_MAX_DAMAGERESIST_HP_CR_13 ;  break;
   		case 14: min = FW_MIN_DAMAGERESIST_HP_CR_14 ; max = FW_MAX_DAMAGERESIST_HP_CR_14 ;  break;
		case 15: min = FW_MIN_DAMAGERESIST_HP_CR_15 ; max = FW_MAX_DAMAGERESIST_HP_CR_15 ;  break;
		case 16: min = FW_MIN_DAMAGERESIST_HP_CR_16 ; max = FW_MAX_DAMAGERESIST_HP_CR_16 ;  break;
   		case 17: min = FW_MIN_DAMAGERESIST_HP_CR_17 ; max = FW_MAX_DAMAGERESIST_HP_CR_17 ;  break;
		case 18: min = FW_MIN_DAMAGERESIST_HP_CR_18 ; max = FW_MAX_DAMAGERESIST_HP_CR_18 ;  break;
		case 19: min = FW_MIN_DAMAGERESIST_HP_CR_19 ; max = FW_MAX_DAMAGERESIST_HP_CR_19 ;  break;
   		case 20: min = FW_MIN_DAMAGERESIST_HP_CR_20 ; max = FW_MAX_DAMAGERESIST_HP_CR_20 ;  break;
   
   		case 21: min = FW_MIN_DAMAGERESIST_HP_CR_21 ; max = FW_MAX_DAMAGERESIST_HP_CR_21 ;  break;
		case 22: min = FW_MIN_DAMAGERESIST_HP_CR_22 ; max = FW_MAX_DAMAGERESIST_HP_CR_22 ;  break;
		case 23: min = FW_MIN_DAMAGERESIST_HP_CR_23 ; max = FW_MAX_DAMAGERESIST_HP_CR_23 ;  break;
   		case 24: min = FW_MIN_DAMAGERESIST_HP_CR_24 ; max = FW_MAX_DAMAGERESIST_HP_CR_24 ;  break;
		case 25: min = FW_MIN_DAMAGERESIST_HP_CR_25 ; max = FW_MAX_DAMAGERESIST_HP_CR_25 ;  break;
		case 26: min = FW_MIN_DAMAGERESIST_HP_CR_26 ; max = FW_MAX_DAMAGERESIST_HP_CR_26 ;  break;
   		case 27: min = FW_MIN_DAMAGERESIST_HP_CR_27 ; max = FW_MAX_DAMAGERESIST_HP_CR_27 ;  break;
		case 28: min = FW_MIN_DAMAGERESIST_HP_CR_28 ; max = FW_MAX_DAMAGERESIST_HP_CR_28 ;  break;
		case 29: min = FW_MIN_DAMAGERESIST_HP_CR_29 ; max = FW_MAX_DAMAGERESIST_HP_CR_29 ;  break;
   		case 30: min = FW_MIN_DAMAGERESIST_HP_CR_30 ; max = FW_MAX_DAMAGERESIST_HP_CR_30 ;  break;		
		
		case 31: min = FW_MIN_DAMAGERESIST_HP_CR_31 ; max = FW_MAX_DAMAGERESIST_HP_CR_31 ;  break;
		case 32: min = FW_MIN_DAMAGERESIST_HP_CR_32 ; max = FW_MAX_DAMAGERESIST_HP_CR_32 ;  break;
		case 33: min = FW_MIN_DAMAGERESIST_HP_CR_33 ; max = FW_MAX_DAMAGERESIST_HP_CR_33 ;  break;
   		case 34: min = FW_MIN_DAMAGERESIST_HP_CR_34 ; max = FW_MAX_DAMAGERESIST_HP_CR_34 ;  break;
		case 35: min = FW_MIN_DAMAGERESIST_HP_CR_35 ; max = FW_MAX_DAMAGERESIST_HP_CR_35 ;  break;
		case 36: min = FW_MIN_DAMAGERESIST_HP_CR_36 ; max = FW_MAX_DAMAGERESIST_HP_CR_36 ;  break;
   		case 37: min = FW_MIN_DAMAGERESIST_HP_CR_37 ; max = FW_MAX_DAMAGERESIST_HP_CR_37 ;  break;
		case 38: min = FW_MIN_DAMAGERESIST_HP_CR_38 ; max = FW_MAX_DAMAGERESIST_HP_CR_38 ;  break;
		case 39: min = FW_MIN_DAMAGERESIST_HP_CR_39 ; max = FW_MAX_DAMAGERESIST_HP_CR_39 ;  break;
   		case 40: min = FW_MIN_DAMAGERESIST_HP_CR_40 ; max = FW_MAX_DAMAGERESIST_HP_CR_40 ;  break;
		
		case 41: min = FW_MIN_DAMAGERESIST_HP_CR_41_OR_HIGHER; max = FW_MAX_DAMAGERESIST_HP_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else	  
   int nDamageType = FW_Choose_IP_CONST_DAMAGETYPE ();
   int nRoll;
   int nHPResist;
   if (min < 5)
      min = 5;
   if (min > 50)
      min = 50;
   if (max < 5)
      max = 5;
   if (max > 50)
      max = 50;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nHPResist = IP_CONST_DAMAGERESIST_5;  }
   else
   {
      int nValue = (max/5) - (min/5) + 1;
      nRoll = Random(nValue) + (min/5) - 1;
   }
   switch (nRoll)
   {
      case 0: nHPResist = IP_CONST_DAMAGERESIST_5;
         break;
      case 1: nHPResist = IP_CONST_DAMAGERESIST_10;
         break;
      case 2: nHPResist = IP_CONST_DAMAGERESIST_15;
         break;
      case 3: nHPResist = IP_CONST_DAMAGERESIST_20;
         break;
      case 4: nHPResist = IP_CONST_DAMAGERESIST_25;
         break;
      case 5: nHPResist = IP_CONST_DAMAGERESIST_30;
         break;
      case 6: nHPResist = IP_CONST_DAMAGERESIST_35;
         break;
      case 7: nHPResist = IP_CONST_DAMAGERESIST_40;
         break;
      case 8: nHPResist = IP_CONST_DAMAGERESIST_45;
         break;
      case 9: nHPResist = IP_CONST_DAMAGERESIST_50;
         break;
      default: nHPResist = IP_CONST_DAMAGERESIST_5;
         break;
   }
   ipAdd = ItemPropertyDamageResistance (nDamageType, nHPResist);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a damage type and damage vulnerability
// * amount to be added to an item.
//
itemproperty FW_Choose_IP_Damage_Vulnerability ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_DAMAGE_VULNERABILITY == FALSE)
      return ipAdd;
   int nDamageType = FW_Choose_IP_CONST_DAMAGETYPE ();
   int nBonus;
   int nRoll = Random (7);
   switch (nRoll)
   {
      case 0: nBonus = IP_CONST_DAMAGEVULNERABILITY_5_PERCENT;
         break;
      case 1: nBonus = IP_CONST_DAMAGEVULNERABILITY_10_PERCENT;
         break;
      case 2: nBonus = IP_CONST_DAMAGEVULNERABILITY_25_PERCENT;
         break;
      case 3: nBonus = IP_CONST_DAMAGEVULNERABILITY_50_PERCENT;
         break;
      case 4: nBonus = IP_CONST_DAMAGEVULNERABILITY_75_PERCENT;
         break;
      case 5: nBonus = IP_CONST_DAMAGEVULNERABILITY_90_PERCENT;
         break;
      case 6: nBonus = IP_CONST_DAMAGEVULNERABILITY_100_PERCENT;
         break;
   }
   ipAdd = ItemPropertyDamageVulnerability(nDamageType, nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that returns the item property darvision (to be added to an item)
// * if darkvision is an allowed property.
//
itemproperty FW_Choose_IP_Darkvision ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_DARKVISION == FALSE)
      return ipAdd;
   
   ipAdd = ItemPropertyDarkvision();
   return ipAdd; 
}

////////////////////////////////////////////
// * Function that randomly chooses an ability penalty type and amount.  You can
// * specify the min or max if you want, but any value less than 1 is changed to
// * 1 and any value greater than 10 is changed to 10.  Use ONLY positive
// * integers.  I.E. 1 = -1 penalty, 2 = -2 penalty, etc.
//
itemproperty FW_Choose_IP_Decrease_Ability (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_ABILITY_PENALTY == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_ABILITY_PENALTY_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_ABILITY_PENALTY_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_ABILITY_PENALTY_CR_0 ; max = FW_MAX_ABILITY_PENALTY_CR_0 ;    break;
		
		case 1: min = FW_MIN_ABILITY_PENALTY_CR_1 ; max = FW_MAX_ABILITY_PENALTY_CR_1 ;    break;
		case 2: min = FW_MIN_ABILITY_PENALTY_CR_2 ; max = FW_MAX_ABILITY_PENALTY_CR_2 ;    break;
		case 3: min = FW_MIN_ABILITY_PENALTY_CR_3 ; max = FW_MAX_ABILITY_PENALTY_CR_3 ;    break;
   		case 4: min = FW_MIN_ABILITY_PENALTY_CR_4 ; max = FW_MAX_ABILITY_PENALTY_CR_4 ;    break;
		case 5: min = FW_MIN_ABILITY_PENALTY_CR_5 ; max = FW_MAX_ABILITY_PENALTY_CR_5 ;    break;
		case 6: min = FW_MIN_ABILITY_PENALTY_CR_6 ; max = FW_MAX_ABILITY_PENALTY_CR_6 ;    break;
   		case 7: min = FW_MIN_ABILITY_PENALTY_CR_7 ; max = FW_MAX_ABILITY_PENALTY_CR_7 ;    break;
		case 8: min = FW_MIN_ABILITY_PENALTY_CR_8 ; max = FW_MAX_ABILITY_PENALTY_CR_8 ;    break;
		case 9: min = FW_MIN_ABILITY_PENALTY_CR_9 ; max = FW_MAX_ABILITY_PENALTY_CR_9 ;    break;
   		case 10: min = FW_MIN_ABILITY_PENALTY_CR_10 ; max = FW_MAX_ABILITY_PENALTY_CR_10 ; break;
		
		case 11: min = FW_MIN_ABILITY_PENALTY_CR_11 ; max = FW_MAX_ABILITY_PENALTY_CR_11 ;  break;
		case 12: min = FW_MIN_ABILITY_PENALTY_CR_12 ; max = FW_MAX_ABILITY_PENALTY_CR_12 ;  break;
		case 13: min = FW_MIN_ABILITY_PENALTY_CR_13 ; max = FW_MAX_ABILITY_PENALTY_CR_13 ;  break;
   		case 14: min = FW_MIN_ABILITY_PENALTY_CR_14 ; max = FW_MAX_ABILITY_PENALTY_CR_14 ;  break;
		case 15: min = FW_MIN_ABILITY_PENALTY_CR_15 ; max = FW_MAX_ABILITY_PENALTY_CR_15 ;  break;
		case 16: min = FW_MIN_ABILITY_PENALTY_CR_16 ; max = FW_MAX_ABILITY_PENALTY_CR_16 ;  break;
   		case 17: min = FW_MIN_ABILITY_PENALTY_CR_17 ; max = FW_MAX_ABILITY_PENALTY_CR_17 ;  break;
		case 18: min = FW_MIN_ABILITY_PENALTY_CR_18 ; max = FW_MAX_ABILITY_PENALTY_CR_18 ;  break;
		case 19: min = FW_MIN_ABILITY_PENALTY_CR_19 ; max = FW_MAX_ABILITY_PENALTY_CR_19 ;  break;
   		case 20: min = FW_MIN_ABILITY_PENALTY_CR_20 ; max = FW_MAX_ABILITY_PENALTY_CR_20 ;  break;
   
   		case 21: min = FW_MIN_ABILITY_PENALTY_CR_21 ; max = FW_MAX_ABILITY_PENALTY_CR_21 ;  break;
		case 22: min = FW_MIN_ABILITY_PENALTY_CR_22 ; max = FW_MAX_ABILITY_PENALTY_CR_22 ;  break;
		case 23: min = FW_MIN_ABILITY_PENALTY_CR_23 ; max = FW_MAX_ABILITY_PENALTY_CR_23 ;  break;
   		case 24: min = FW_MIN_ABILITY_PENALTY_CR_24 ; max = FW_MAX_ABILITY_PENALTY_CR_24 ;  break;
		case 25: min = FW_MIN_ABILITY_PENALTY_CR_25 ; max = FW_MAX_ABILITY_PENALTY_CR_25 ;  break;
		case 26: min = FW_MIN_ABILITY_PENALTY_CR_26 ; max = FW_MAX_ABILITY_PENALTY_CR_26 ;  break;
   		case 27: min = FW_MIN_ABILITY_PENALTY_CR_27 ; max = FW_MAX_ABILITY_PENALTY_CR_27 ;  break;
		case 28: min = FW_MIN_ABILITY_PENALTY_CR_28 ; max = FW_MAX_ABILITY_PENALTY_CR_28 ;  break;
		case 29: min = FW_MIN_ABILITY_PENALTY_CR_29 ; max = FW_MAX_ABILITY_PENALTY_CR_29 ;  break;
   		case 30: min = FW_MIN_ABILITY_PENALTY_CR_30 ; max = FW_MAX_ABILITY_PENALTY_CR_30 ;  break;		
		
		case 31: min = FW_MIN_ABILITY_PENALTY_CR_31 ; max = FW_MAX_ABILITY_PENALTY_CR_31 ;  break;
		case 32: min = FW_MIN_ABILITY_PENALTY_CR_32 ; max = FW_MAX_ABILITY_PENALTY_CR_32 ;  break;
		case 33: min = FW_MIN_ABILITY_PENALTY_CR_33 ; max = FW_MAX_ABILITY_PENALTY_CR_33 ;  break;
   		case 34: min = FW_MIN_ABILITY_PENALTY_CR_34 ; max = FW_MAX_ABILITY_PENALTY_CR_34 ;  break;
		case 35: min = FW_MIN_ABILITY_PENALTY_CR_35 ; max = FW_MAX_ABILITY_PENALTY_CR_35 ;  break;
		case 36: min = FW_MIN_ABILITY_PENALTY_CR_36 ; max = FW_MAX_ABILITY_PENALTY_CR_36 ;  break;
   		case 37: min = FW_MIN_ABILITY_PENALTY_CR_37 ; max = FW_MAX_ABILITY_PENALTY_CR_37 ;  break;
		case 38: min = FW_MIN_ABILITY_PENALTY_CR_38 ; max = FW_MAX_ABILITY_PENALTY_CR_38 ;  break;
		case 39: min = FW_MIN_ABILITY_PENALTY_CR_39 ; max = FW_MAX_ABILITY_PENALTY_CR_39 ;  break;
   		case 40: min = FW_MIN_ABILITY_PENALTY_CR_40 ; max = FW_MAX_ABILITY_PENALTY_CR_40 ;  break;
		
		case 41: min = FW_MIN_ABILITY_PENALTY_CR_41_OR_HIGHER; max = FW_MAX_ABILITY_PENALTY_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else
   int nAbility;
   int nBonus;

   if (min < 1)
      min = 1;
   if (min > 10)
      min = 10;
   if (max < 1)
      max = 1;
   if (max > 10)
      max = 10;
   int nRoll = Random (6);
   switch (nRoll)
   {
      case 0: nAbility = IP_CONST_ABILITY_CHA;
         break;
      case 1: nAbility = IP_CONST_ABILITY_CON;
         break;
      case 2: nAbility = IP_CONST_ABILITY_DEX;
         break;
      case 3: nAbility = IP_CONST_ABILITY_INT;
         break;
      case 4: nAbility = IP_CONST_ABILITY_STR;
         break;
      case 5: nAbility = IP_CONST_ABILITY_WIS;
         break;
      default: break;
   } // end of switch
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyDecreaseAbility(nAbility, nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an Armor Class type and penalty (subject to
// * min and max values.  Use only POSITIVE integers for min and max. 1...5
//
itemproperty FW_Choose_IP_Decrease_AC (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_AC_PENALTY == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_AC_PENALTY_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_AC_PENALTY_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_AC_PENALTY_CR_0 ; max = FW_MAX_AC_PENALTY_CR_0 ;    break;
		
		case 1: min = FW_MIN_AC_PENALTY_CR_1 ; max = FW_MAX_AC_PENALTY_CR_1 ;    break;
		case 2: min = FW_MIN_AC_PENALTY_CR_2 ; max = FW_MAX_AC_PENALTY_CR_2 ;    break;
		case 3: min = FW_MIN_AC_PENALTY_CR_3 ; max = FW_MAX_AC_PENALTY_CR_3 ;    break;
   		case 4: min = FW_MIN_AC_PENALTY_CR_4 ; max = FW_MAX_AC_PENALTY_CR_4 ;    break;
		case 5: min = FW_MIN_AC_PENALTY_CR_5 ; max = FW_MAX_AC_PENALTY_CR_5 ;    break;
		case 6: min = FW_MIN_AC_PENALTY_CR_6 ; max = FW_MAX_AC_PENALTY_CR_6 ;    break;
   		case 7: min = FW_MIN_AC_PENALTY_CR_7 ; max = FW_MAX_AC_PENALTY_CR_7 ;    break;
		case 8: min = FW_MIN_AC_PENALTY_CR_8 ; max = FW_MAX_AC_PENALTY_CR_8 ;    break;
		case 9: min = FW_MIN_AC_PENALTY_CR_9 ; max = FW_MAX_AC_PENALTY_CR_9 ;    break;
   		case 10: min = FW_MIN_AC_PENALTY_CR_10 ; max = FW_MAX_AC_PENALTY_CR_10 ; break;
		
		case 11: min = FW_MIN_AC_PENALTY_CR_11 ; max = FW_MAX_AC_PENALTY_CR_11 ;  break;
		case 12: min = FW_MIN_AC_PENALTY_CR_12 ; max = FW_MAX_AC_PENALTY_CR_12 ;  break;
		case 13: min = FW_MIN_AC_PENALTY_CR_13 ; max = FW_MAX_AC_PENALTY_CR_13 ;  break;
   		case 14: min = FW_MIN_AC_PENALTY_CR_14 ; max = FW_MAX_AC_PENALTY_CR_14 ;  break;
		case 15: min = FW_MIN_AC_PENALTY_CR_15 ; max = FW_MAX_AC_PENALTY_CR_15 ;  break;
		case 16: min = FW_MIN_AC_PENALTY_CR_16 ; max = FW_MAX_AC_PENALTY_CR_16 ;  break;
   		case 17: min = FW_MIN_AC_PENALTY_CR_17 ; max = FW_MAX_AC_PENALTY_CR_17 ;  break;
		case 18: min = FW_MIN_AC_PENALTY_CR_18 ; max = FW_MAX_AC_PENALTY_CR_18 ;  break;
		case 19: min = FW_MIN_AC_PENALTY_CR_19 ; max = FW_MAX_AC_PENALTY_CR_19 ;  break;
   		case 20: min = FW_MIN_AC_PENALTY_CR_20 ; max = FW_MAX_AC_PENALTY_CR_20 ;  break;
   
   		case 21: min = FW_MIN_AC_PENALTY_CR_21 ; max = FW_MAX_AC_PENALTY_CR_21 ;  break;
		case 22: min = FW_MIN_AC_PENALTY_CR_22 ; max = FW_MAX_AC_PENALTY_CR_22 ;  break;
		case 23: min = FW_MIN_AC_PENALTY_CR_23 ; max = FW_MAX_AC_PENALTY_CR_23 ;  break;
   		case 24: min = FW_MIN_AC_PENALTY_CR_24 ; max = FW_MAX_AC_PENALTY_CR_24 ;  break;
		case 25: min = FW_MIN_AC_PENALTY_CR_25 ; max = FW_MAX_AC_PENALTY_CR_25 ;  break;
		case 26: min = FW_MIN_AC_PENALTY_CR_26 ; max = FW_MAX_AC_PENALTY_CR_26 ;  break;
   		case 27: min = FW_MIN_AC_PENALTY_CR_27 ; max = FW_MAX_AC_PENALTY_CR_27 ;  break;
		case 28: min = FW_MIN_AC_PENALTY_CR_28 ; max = FW_MAX_AC_PENALTY_CR_28 ;  break;
		case 29: min = FW_MIN_AC_PENALTY_CR_29 ; max = FW_MAX_AC_PENALTY_CR_29 ;  break;
   		case 30: min = FW_MIN_AC_PENALTY_CR_30 ; max = FW_MAX_AC_PENALTY_CR_30 ;  break;		
		
		case 31: min = FW_MIN_AC_PENALTY_CR_31 ; max = FW_MAX_AC_PENALTY_CR_31 ;  break;
		case 32: min = FW_MIN_AC_PENALTY_CR_32 ; max = FW_MAX_AC_PENALTY_CR_32 ;  break;
		case 33: min = FW_MIN_AC_PENALTY_CR_33 ; max = FW_MAX_AC_PENALTY_CR_33 ;  break;
   		case 34: min = FW_MIN_AC_PENALTY_CR_34 ; max = FW_MAX_AC_PENALTY_CR_34 ;  break;
		case 35: min = FW_MIN_AC_PENALTY_CR_35 ; max = FW_MAX_AC_PENALTY_CR_35 ;  break;
		case 36: min = FW_MIN_AC_PENALTY_CR_36 ; max = FW_MAX_AC_PENALTY_CR_36 ;  break;
   		case 37: min = FW_MIN_AC_PENALTY_CR_37 ; max = FW_MAX_AC_PENALTY_CR_37 ;  break;
		case 38: min = FW_MIN_AC_PENALTY_CR_38 ; max = FW_MAX_AC_PENALTY_CR_38 ;  break;
		case 39: min = FW_MIN_AC_PENALTY_CR_39 ; max = FW_MAX_AC_PENALTY_CR_39 ;  break;
   		case 40: min = FW_MIN_AC_PENALTY_CR_40 ; max = FW_MAX_AC_PENALTY_CR_40 ;  break;
		
		case 41: min = FW_MIN_AC_PENALTY_CR_41_OR_HIGHER; max = FW_MAX_AC_PENALTY_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else	  
   int nACType;
   int nPenalty;
   if (min < 1)
      min = 1;
   if (min > 5)
      min = 5;
   if (max < 1)
      max = 1;
   if (max > 5)
      max = 5;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nPenalty = 1;  }
   else if (min == max)
      {  nPenalty = min;  }
   else
   {
      int nValue = max - min + 1;
      nPenalty = Random(nValue)+ min;
   }
   int nRoll = Random (5);
   switch (nRoll)
   {
      case 0: nACType = IP_CONST_ACMODIFIERTYPE_ARMOR;
         break;
      case 1: nACType = IP_CONST_ACMODIFIERTYPE_DEFLECTION;
         break;
      case 2: nACType = IP_CONST_ACMODIFIERTYPE_DODGE;
         break;
      case 3: nACType = IP_CONST_ACMODIFIERTYPE_NATURAL;
         break;
      case 4: nACType = IP_CONST_ACMODIFIERTYPE_SHIELD;
         break;
   }
   ipAdd = ItemPropertyDecreaseAC (nACType, nPenalty);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly decreases a skill between 1 and 10 points.
// * Acceptable values for min and max must be POSITIVE integers: 1,2,3,...,10
//
itemproperty FW_Choose_IP_Decrease_Skill (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_SKILL_DECREASE == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_SKILL_DECREASE_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_SKILL_DECREASE_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_SKILL_DECREASE_CR_0 ; max = FW_MAX_SKILL_DECREASE_CR_0 ;    break;
		
		case 1: min = FW_MIN_SKILL_DECREASE_CR_1 ; max = FW_MAX_SKILL_DECREASE_CR_1 ;    break;
		case 2: min = FW_MIN_SKILL_DECREASE_CR_2 ; max = FW_MAX_SKILL_DECREASE_CR_2 ;    break;
		case 3: min = FW_MIN_SKILL_DECREASE_CR_3 ; max = FW_MAX_SKILL_DECREASE_CR_3 ;    break;
   		case 4: min = FW_MIN_SKILL_DECREASE_CR_4 ; max = FW_MAX_SKILL_DECREASE_CR_4 ;    break;
		case 5: min = FW_MIN_SKILL_DECREASE_CR_5 ; max = FW_MAX_SKILL_DECREASE_CR_5 ;    break;
		case 6: min = FW_MIN_SKILL_DECREASE_CR_6 ; max = FW_MAX_SKILL_DECREASE_CR_6 ;    break;
   		case 7: min = FW_MIN_SKILL_DECREASE_CR_7 ; max = FW_MAX_SKILL_DECREASE_CR_7 ;    break;
		case 8: min = FW_MIN_SKILL_DECREASE_CR_8 ; max = FW_MAX_SKILL_DECREASE_CR_8 ;    break;
		case 9: min = FW_MIN_SKILL_DECREASE_CR_9 ; max = FW_MAX_SKILL_DECREASE_CR_9 ;    break;
   		case 10: min = FW_MIN_SKILL_DECREASE_CR_10 ; max = FW_MAX_SKILL_DECREASE_CR_10 ; break;
		
		case 11: min = FW_MIN_SKILL_DECREASE_CR_11 ; max = FW_MAX_SKILL_DECREASE_CR_11 ;  break;
		case 12: min = FW_MIN_SKILL_DECREASE_CR_12 ; max = FW_MAX_SKILL_DECREASE_CR_12 ;  break;
		case 13: min = FW_MIN_SKILL_DECREASE_CR_13 ; max = FW_MAX_SKILL_DECREASE_CR_13 ;  break;
   		case 14: min = FW_MIN_SKILL_DECREASE_CR_14 ; max = FW_MAX_SKILL_DECREASE_CR_14 ;  break;
		case 15: min = FW_MIN_SKILL_DECREASE_CR_15 ; max = FW_MAX_SKILL_DECREASE_CR_15 ;  break;
		case 16: min = FW_MIN_SKILL_DECREASE_CR_16 ; max = FW_MAX_SKILL_DECREASE_CR_16 ;  break;
   		case 17: min = FW_MIN_SKILL_DECREASE_CR_17 ; max = FW_MAX_SKILL_DECREASE_CR_17 ;  break;
		case 18: min = FW_MIN_SKILL_DECREASE_CR_18 ; max = FW_MAX_SKILL_DECREASE_CR_18 ;  break;
		case 19: min = FW_MIN_SKILL_DECREASE_CR_19 ; max = FW_MAX_SKILL_DECREASE_CR_19 ;  break;
   		case 20: min = FW_MIN_SKILL_DECREASE_CR_20 ; max = FW_MAX_SKILL_DECREASE_CR_20 ;  break;
   
   		case 21: min = FW_MIN_SKILL_DECREASE_CR_21 ; max = FW_MAX_SKILL_DECREASE_CR_21 ;  break;
		case 22: min = FW_MIN_SKILL_DECREASE_CR_22 ; max = FW_MAX_SKILL_DECREASE_CR_22 ;  break;
		case 23: min = FW_MIN_SKILL_DECREASE_CR_23 ; max = FW_MAX_SKILL_DECREASE_CR_23 ;  break;
   		case 24: min = FW_MIN_SKILL_DECREASE_CR_24 ; max = FW_MAX_SKILL_DECREASE_CR_24 ;  break;
		case 25: min = FW_MIN_SKILL_DECREASE_CR_25 ; max = FW_MAX_SKILL_DECREASE_CR_25 ;  break;
		case 26: min = FW_MIN_SKILL_DECREASE_CR_26 ; max = FW_MAX_SKILL_DECREASE_CR_26 ;  break;
   		case 27: min = FW_MIN_SKILL_DECREASE_CR_27 ; max = FW_MAX_SKILL_DECREASE_CR_27 ;  break;
		case 28: min = FW_MIN_SKILL_DECREASE_CR_28 ; max = FW_MAX_SKILL_DECREASE_CR_28 ;  break;
		case 29: min = FW_MIN_SKILL_DECREASE_CR_29 ; max = FW_MAX_SKILL_DECREASE_CR_29 ;  break;
   		case 30: min = FW_MIN_SKILL_DECREASE_CR_30 ; max = FW_MAX_SKILL_DECREASE_CR_30 ;  break;		
		
		case 31: min = FW_MIN_SKILL_DECREASE_CR_31 ; max = FW_MAX_SKILL_DECREASE_CR_31 ;  break;
		case 32: min = FW_MIN_SKILL_DECREASE_CR_32 ; max = FW_MAX_SKILL_DECREASE_CR_32 ;  break;
		case 33: min = FW_MIN_SKILL_DECREASE_CR_33 ; max = FW_MAX_SKILL_DECREASE_CR_33 ;  break;
   		case 34: min = FW_MIN_SKILL_DECREASE_CR_34 ; max = FW_MAX_SKILL_DECREASE_CR_34 ;  break;
		case 35: min = FW_MIN_SKILL_DECREASE_CR_35 ; max = FW_MAX_SKILL_DECREASE_CR_35 ;  break;
		case 36: min = FW_MIN_SKILL_DECREASE_CR_36 ; max = FW_MAX_SKILL_DECREASE_CR_36 ;  break;
   		case 37: min = FW_MIN_SKILL_DECREASE_CR_37 ; max = FW_MAX_SKILL_DECREASE_CR_37 ;  break;
		case 38: min = FW_MIN_SKILL_DECREASE_CR_38 ; max = FW_MAX_SKILL_DECREASE_CR_38 ;  break;
		case 39: min = FW_MIN_SKILL_DECREASE_CR_39 ; max = FW_MAX_SKILL_DECREASE_CR_39 ;  break;
   		case 40: min = FW_MIN_SKILL_DECREASE_CR_40 ; max = FW_MAX_SKILL_DECREASE_CR_40 ;  break;
		
		case 41: min = FW_MIN_SKILL_DECREASE_CR_41_OR_HIGHER; max = FW_MAX_SKILL_DECREASE_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else 
   int nPenalty;
   int nSkill;
   if (min < 1)
      min = 1;
   if (min > 10)
      min = 10;
   if (max < 1)
      max = 1;
   if (max > 10)
      max = 10;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nPenalty = 1;  }
   else if (min == max)
      {  nPenalty = min;  }
   else
   {
      int nValue = max - min + 1;
      nPenalty = Random(nValue)+ min;
   }

   int nReRoll = TRUE;
   while (nReRoll)
   {
      // As of 10 July 2007 there are 30 skills in NWN 2. See "skills.2da"
      nSkill = Random (30);
      switch (nSkill)
      {
         // NWN 2 removed the skills: Animal Empathy and Ride. That's what
         // these two checks are for.  Don't change these values.
         // 0 = animal empathy.
         case 0: nReRoll = TRUE;
            break;
         // 28 = ride.
         case 28: nReRoll = TRUE;
            break;

         // If you want to disallow skills, do it here.  I've shown 3 examples
         // of how this is done. change what I've chosen for what you want
         // disallowed.
         /*
         case SKILL_APPRAISE: nReRoll = TRUE;
            break;
         case SKILL_USE_MAGIC_DEVICE: nReRoll = TRUE;
            break;
         case SKILL_TUMBLE: nReRoll = TRUE;
            break;
         */
         //**************************************
         // We found an acceptable spell!!
         // NEVER CHANGE THIS.
         default: nReRoll = FALSE;
            break;
      } // end of switch
   } // end of while
   ipAdd = ItemPropertyDecreaseSkill (nSkill, nPenalty);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an Enhancement bonus.  Values for min and
// * max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Enhancement_Bonus (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_ENHANCEMENT_BONUS == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_ENHANCEMENT_BONUS_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_ENHANCEMENT_BONUS_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_ENHANCEMENT_BONUS_CR_0 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_0 ;    break;
		
		case 1: min = FW_MIN_ENHANCEMENT_BONUS_CR_1 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_1 ;    break;
		case 2: min = FW_MIN_ENHANCEMENT_BONUS_CR_2 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_2 ;    break;
		case 3: min = FW_MIN_ENHANCEMENT_BONUS_CR_3 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_3 ;    break;
   		case 4: min = FW_MIN_ENHANCEMENT_BONUS_CR_4 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_4 ;    break;
		case 5: min = FW_MIN_ENHANCEMENT_BONUS_CR_5 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_5 ;    break;
		case 6: min = FW_MIN_ENHANCEMENT_BONUS_CR_6 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_6 ;    break;
   		case 7: min = FW_MIN_ENHANCEMENT_BONUS_CR_7 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_7 ;    break;
		case 8: min = FW_MIN_ENHANCEMENT_BONUS_CR_8 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_8 ;    break;
		case 9: min = FW_MIN_ENHANCEMENT_BONUS_CR_9 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_9 ;    break;
   		case 10: min = FW_MIN_ENHANCEMENT_BONUS_CR_10 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_10 ; break;
		
		case 11: min = FW_MIN_ENHANCEMENT_BONUS_CR_11 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_11 ;  break;
		case 12: min = FW_MIN_ENHANCEMENT_BONUS_CR_12 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_12 ;  break;
		case 13: min = FW_MIN_ENHANCEMENT_BONUS_CR_13 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_13 ;  break;
   		case 14: min = FW_MIN_ENHANCEMENT_BONUS_CR_14 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_14 ;  break;
		case 15: min = FW_MIN_ENHANCEMENT_BONUS_CR_15 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_15 ;  break;
		case 16: min = FW_MIN_ENHANCEMENT_BONUS_CR_16 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_16 ;  break;
   		case 17: min = FW_MIN_ENHANCEMENT_BONUS_CR_17 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_17 ;  break;
		case 18: min = FW_MIN_ENHANCEMENT_BONUS_CR_18 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_18 ;  break;
		case 19: min = FW_MIN_ENHANCEMENT_BONUS_CR_19 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_19 ;  break;
   		case 20: min = FW_MIN_ENHANCEMENT_BONUS_CR_20 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_20 ;  break;
   
   		case 21: min = FW_MIN_ENHANCEMENT_BONUS_CR_21 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_21 ;  break;
		case 22: min = FW_MIN_ENHANCEMENT_BONUS_CR_22 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_22 ;  break;
		case 23: min = FW_MIN_ENHANCEMENT_BONUS_CR_23 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_23 ;  break;
   		case 24: min = FW_MIN_ENHANCEMENT_BONUS_CR_24 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_24 ;  break;
		case 25: min = FW_MIN_ENHANCEMENT_BONUS_CR_25 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_25 ;  break;
		case 26: min = FW_MIN_ENHANCEMENT_BONUS_CR_26 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_26 ;  break;
   		case 27: min = FW_MIN_ENHANCEMENT_BONUS_CR_27 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_27 ;  break;
		case 28: min = FW_MIN_ENHANCEMENT_BONUS_CR_28 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_28 ;  break;
		case 29: min = FW_MIN_ENHANCEMENT_BONUS_CR_29 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_29 ;  break;
   		case 30: min = FW_MIN_ENHANCEMENT_BONUS_CR_30 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_30 ;  break;		
		
		case 31: min = FW_MIN_ENHANCEMENT_BONUS_CR_31 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_31 ;  break;
		case 32: min = FW_MIN_ENHANCEMENT_BONUS_CR_32 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_32 ;  break;
		case 33: min = FW_MIN_ENHANCEMENT_BONUS_CR_33 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_33 ;  break;
   		case 34: min = FW_MIN_ENHANCEMENT_BONUS_CR_34 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_34 ;  break;
		case 35: min = FW_MIN_ENHANCEMENT_BONUS_CR_35 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_35 ;  break;
		case 36: min = FW_MIN_ENHANCEMENT_BONUS_CR_36 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_36 ;  break;
   		case 37: min = FW_MIN_ENHANCEMENT_BONUS_CR_37 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_37 ;  break;
		case 38: min = FW_MIN_ENHANCEMENT_BONUS_CR_38 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_38 ;  break;
		case 39: min = FW_MIN_ENHANCEMENT_BONUS_CR_39 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_39 ;  break;
   		case 40: min = FW_MIN_ENHANCEMENT_BONUS_CR_40 ; max = FW_MAX_ENHANCEMENT_BONUS_CR_40 ;  break;
		
		case 41: min = FW_MIN_ENHANCEMENT_BONUS_CR_41_OR_HIGHER; max = FW_MAX_ENHANCEMENT_BONUS_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch
   } // end of else	  
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyEnhancementBonus(nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an Enhancement bonus vs. an alignment group.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Enhancement_Bonus_Vs_Align (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_ENHANCEMENT_BONUS_VS_ALIGN == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_0 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_0 ;    break;
		
		case 1: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_1 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_1 ;    break;
		case 2: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_2 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_2 ;    break;
		case 3: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_3 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_3 ;    break;
   		case 4: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_4 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_4 ;    break;
		case 5: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_5 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_5 ;    break;
		case 6: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_6 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_6 ;    break;
   		case 7: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_7 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_7 ;    break;
		case 8: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_8 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_8 ;    break;
		case 9: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_9 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_9 ;    break;
   		case 10: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_10 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_10 ; break;
		
		case 11: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_11 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_11 ;  break;
		case 12: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_12 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_12 ;  break;
		case 13: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_13 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_13 ;  break;
   		case 14: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_14 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_14 ;  break;
		case 15: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_15 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_15 ;  break;
		case 16: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_16 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_16 ;  break;
   		case 17: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_17 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_17 ;  break;
		case 18: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_18 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_18 ;  break;
		case 19: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_19 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_19 ;  break;
   		case 20: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_20 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_20 ;  break;
   
   		case 21: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_21 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_21 ;  break;
		case 22: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_22 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_22 ;  break;
		case 23: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_23 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_23 ;  break;
   		case 24: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_24 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_24 ;  break;
		case 25: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_25 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_25 ;  break;
		case 26: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_26 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_26 ;  break;
   		case 27: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_27 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_27 ;  break;
		case 28: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_28 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_28 ;  break;
		case 29: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_29 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_29 ;  break;
   		case 30: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_30 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_30 ;  break;		
		
		case 31: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_31 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_31 ;  break;
		case 32: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_32 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_32 ;  break;
		case 33: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_33 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_33 ;  break;
   		case 34: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_34 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_34 ;  break;
		case 35: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_35 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_35 ;  break;
		case 36: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_36 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_36 ;  break;
   		case 37: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_37 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_37 ;  break;
		case 38: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_38 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_38 ;  break;
		case 39: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_39 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_39 ;  break;
   		case 40: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_40 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_40 ;  break;
		
		case 41: min = FW_MIN_ENHANCEMENT_BONUS_VS_ALIGN_CR_41_OR_HIGHER; max = FW_MAX_ENHANCEMENT_BONUS_VS_ALIGN_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else
   int nAlignGroup = FW_Choose_IP_CONST_ALIGNMENTGROUP ();
   int nBonus;

   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyEnhancementBonusVsAlign(nAlignGroup, nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an attack bonus vs. race.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Enhancement_Bonus_Vs_Race (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_ENHANCEMENT_BONUS_VS_RACE == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_ENHANCEMENT_BONUS_VS_RACE_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_ENHANCEMENT_BONUS_VS_RACE_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_0 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_0 ;    break;
		
		case 1: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_1 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_1 ;    break;
		case 2: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_2 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_2 ;    break;
		case 3: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_3 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_3 ;    break;
   		case 4: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_4 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_4 ;    break;
		case 5: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_5 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_5 ;    break;
		case 6: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_6 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_6 ;    break;
   		case 7: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_7 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_7 ;    break;
		case 8: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_8 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_8 ;    break;
		case 9: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_9 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_9 ;    break;
   		case 10: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_10 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_10 ; break;
		
		case 11: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_11 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_11 ;  break;
		case 12: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_12 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_12 ;  break;
		case 13: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_13 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_13 ;  break;
   		case 14: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_14 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_14 ;  break;
		case 15: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_15 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_15 ;  break;
		case 16: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_16 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_16 ;  break;
   		case 17: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_17 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_17 ;  break;
		case 18: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_18 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_18 ;  break;
		case 19: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_19 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_19 ;  break;
   		case 20: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_20 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_20 ;  break;
   
   		case 21: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_21 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_21 ;  break;
		case 22: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_22 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_22 ;  break;
		case 23: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_23 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_23 ;  break;
   		case 24: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_24 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_24 ;  break;
		case 25: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_25 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_25 ;  break;
		case 26: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_26 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_26 ;  break;
   		case 27: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_27 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_27 ;  break;
		case 28: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_28 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_28 ;  break;
		case 29: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_29 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_29 ;  break;
   		case 30: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_30 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_30 ;  break;		
		
		case 31: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_31 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_31 ;  break;
		case 32: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_32 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_32 ;  break;
		case 33: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_33 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_33 ;  break;
   		case 34: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_34 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_34 ;  break;
		case 35: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_35 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_35 ;  break;
		case 36: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_36 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_36 ;  break;
   		case 37: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_37 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_37 ;  break;
		case 38: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_38 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_38 ;  break;
		case 39: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_39 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_39 ;  break;
   		case 40: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_40 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_40 ;  break;
		
		case 41: min = FW_MIN_ENHANCEMENT_BONUS_VS_RACE_CR_41_OR_HIGHER; max = FW_MAX_ENHANCEMENT_BONUS_VS_RACE_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else	  
   int nRace = FW_Choose_IP_CONST_RACIALTYPE ();
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyEnhancementBonusVsRace(nRace, nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an Enhancement bonus vs. SPECIFIC alignment.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Enhancement_Bonus_Vs_SAlign (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_ENHANCEMENT_BONUS_VS_SALIGN == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_0 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_0 ;    break;
		
		case 1: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_1 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_1 ;    break;
		case 2: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_2 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_2 ;    break;
		case 3: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_3 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_3 ;    break;
   		case 4: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_4 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_4 ;    break;
		case 5: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_5 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_5 ;    break;
		case 6: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_6 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_6 ;    break;
   		case 7: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_7 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_7 ;    break;
		case 8: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_8 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_8 ;    break;
		case 9: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_9 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_9 ;    break;
   		case 10: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_10 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_10 ; break;
		
		case 11: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_11 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_11 ;  break;
		case 12: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_12 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_12 ;  break;
		case 13: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_13 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_13 ;  break;
   		case 14: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_14 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_14 ;  break;
		case 15: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_15 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_15 ;  break;
		case 16: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_16 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_16 ;  break;
   		case 17: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_17 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_17 ;  break;
		case 18: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_18 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_18 ;  break;
		case 19: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_19 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_19 ;  break;
   		case 20: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_20 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_20 ;  break;
   
   		case 21: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_21 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_21 ;  break;
		case 22: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_22 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_22 ;  break;
		case 23: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_23 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_23 ;  break;
   		case 24: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_24 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_24 ;  break;
		case 25: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_25 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_25 ;  break;
		case 26: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_26 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_26 ;  break;
   		case 27: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_27 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_27 ;  break;
		case 28: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_28 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_28 ;  break;
		case 29: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_29 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_29 ;  break;
   		case 30: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_30 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_30 ;  break;		
		
		case 31: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_31 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_31 ;  break;
		case 32: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_32 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_32 ;  break;
		case 33: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_33 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_33 ;  break;
   		case 34: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_34 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_34 ;  break;
		case 35: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_35 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_35 ;  break;
		case 36: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_36 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_36 ;  break;
   		case 37: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_37 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_37 ;  break;
		case 38: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_38 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_38 ;  break;
		case 39: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_39 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_39 ;  break;
   		case 40: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_40 ; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_40 ;  break;
		
		case 41: min = FW_MIN_ENHANCEMENT_BONUS_VS_SALIGN_CR_41_OR_HIGHER; max = FW_MAX_ENHANCEMENT_BONUS_VS_SALIGN_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else 
   int nAlign = FW_Choose_IP_CONST_SALIGN ();
   int nBonus;

   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyEnhancementBonusVsSAlign(nAlign, nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses an Enhancement penalty.  Values for min and
// * max should be an integer between 1 and 5. Yes that is right. 5 is the max.
//
itemproperty FW_Choose_IP_Enhancement_Penalty (int nCR = 0)
{
   itemproperty ipAdd;
   if ( FW_ALLOW_ENHANCEMENT_PENALTY == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_ENHANCEMENT_PENALTY_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_ENHANCEMENT_PENALTY_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_ENHANCEMENT_PENALTY_CR_0 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_0 ;    break;
		
		case 1: min = FW_MIN_ENHANCEMENT_PENALTY_CR_1 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_1 ;    break;
		case 2: min = FW_MIN_ENHANCEMENT_PENALTY_CR_2 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_2 ;    break;
		case 3: min = FW_MIN_ENHANCEMENT_PENALTY_CR_3 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_3 ;    break;
   		case 4: min = FW_MIN_ENHANCEMENT_PENALTY_CR_4 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_4 ;    break;
		case 5: min = FW_MIN_ENHANCEMENT_PENALTY_CR_5 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_5 ;    break;
		case 6: min = FW_MIN_ENHANCEMENT_PENALTY_CR_6 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_6 ;    break;
   		case 7: min = FW_MIN_ENHANCEMENT_PENALTY_CR_7 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_7 ;    break;
		case 8: min = FW_MIN_ENHANCEMENT_PENALTY_CR_8 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_8 ;    break;
		case 9: min = FW_MIN_ENHANCEMENT_PENALTY_CR_9 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_9 ;    break;
   		case 10: min = FW_MIN_ENHANCEMENT_PENALTY_CR_10 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_10 ; break;
		
		case 11: min = FW_MIN_ENHANCEMENT_PENALTY_CR_11 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_11 ;  break;
		case 12: min = FW_MIN_ENHANCEMENT_PENALTY_CR_12 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_12 ;  break;
		case 13: min = FW_MIN_ENHANCEMENT_PENALTY_CR_13 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_13 ;  break;
   		case 14: min = FW_MIN_ENHANCEMENT_PENALTY_CR_14 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_14 ;  break;
		case 15: min = FW_MIN_ENHANCEMENT_PENALTY_CR_15 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_15 ;  break;
		case 16: min = FW_MIN_ENHANCEMENT_PENALTY_CR_16 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_16 ;  break;
   		case 17: min = FW_MIN_ENHANCEMENT_PENALTY_CR_17 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_17 ;  break;
		case 18: min = FW_MIN_ENHANCEMENT_PENALTY_CR_18 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_18 ;  break;
		case 19: min = FW_MIN_ENHANCEMENT_PENALTY_CR_19 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_19 ;  break;
   		case 20: min = FW_MIN_ENHANCEMENT_PENALTY_CR_20 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_20 ;  break;
   
   		case 21: min = FW_MIN_ENHANCEMENT_PENALTY_CR_21 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_21 ;  break;
		case 22: min = FW_MIN_ENHANCEMENT_PENALTY_CR_22 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_22 ;  break;
		case 23: min = FW_MIN_ENHANCEMENT_PENALTY_CR_23 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_23 ;  break;
   		case 24: min = FW_MIN_ENHANCEMENT_PENALTY_CR_24 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_24 ;  break;
		case 25: min = FW_MIN_ENHANCEMENT_PENALTY_CR_25 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_25 ;  break;
		case 26: min = FW_MIN_ENHANCEMENT_PENALTY_CR_26 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_26 ;  break;
   		case 27: min = FW_MIN_ENHANCEMENT_PENALTY_CR_27 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_27 ;  break;
		case 28: min = FW_MIN_ENHANCEMENT_PENALTY_CR_28 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_28 ;  break;
		case 29: min = FW_MIN_ENHANCEMENT_PENALTY_CR_29 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_29 ;  break;
   		case 30: min = FW_MIN_ENHANCEMENT_PENALTY_CR_30 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_30 ;  break;		
		
		case 31: min = FW_MIN_ENHANCEMENT_PENALTY_CR_31 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_31 ;  break;
		case 32: min = FW_MIN_ENHANCEMENT_PENALTY_CR_32 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_32 ;  break;
		case 33: min = FW_MIN_ENHANCEMENT_PENALTY_CR_33 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_33 ;  break;
   		case 34: min = FW_MIN_ENHANCEMENT_PENALTY_CR_34 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_34 ;  break;
		case 35: min = FW_MIN_ENHANCEMENT_PENALTY_CR_35 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_35 ;  break;
		case 36: min = FW_MIN_ENHANCEMENT_PENALTY_CR_36 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_36 ;  break;
   		case 37: min = FW_MIN_ENHANCEMENT_PENALTY_CR_37 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_37 ;  break;
		case 38: min = FW_MIN_ENHANCEMENT_PENALTY_CR_38 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_38 ;  break;
		case 39: min = FW_MIN_ENHANCEMENT_PENALTY_CR_39 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_39 ;  break;
   		case 40: min = FW_MIN_ENHANCEMENT_PENALTY_CR_40 ; max = FW_MAX_ENHANCEMENT_PENALTY_CR_40 ;  break;
		
		case 41: min = FW_MIN_ENHANCEMENT_PENALTY_CR_41_OR_HIGHER; max = FW_MAX_ENHANCEMENT_PENALTY_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else  
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 5)
      min = 5;
   if (max < 1)
      max = 1;
   if (max > 5)
      max = 5;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyEnhancementPenalty(nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses a base damage type to be added to a melee weapon.
// * Only adds Bludgeoning, Slashing, or Piercing damage to a weapon.
//
itemproperty FW_Choose_IP_Extra_Melee_Damage_Type ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_EXTRA_MELEE_DAMAGE_TYPE == FALSE)
      return ipAdd;
   int nDamageType;
   int nRoll = Random(3);
   switch(nRoll)
   {
      case 0: nDamageType = IP_CONST_DAMAGETYPE_BLUDGEONING;
         break;
      case 1: nDamageType = IP_CONST_DAMAGETYPE_PIERCING;
         break;
      case 2: nDamageType = IP_CONST_DAMAGETYPE_SLASHING;
         break;
      default: break;
   }
   ipAdd = ItemPropertyExtraMeleeDamageType(nDamageType);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses a base damage type to be added to a ranged weapon.
// * Only adds Bludgeoning, Slashing, or Piercing damage to a weapon.
//
itemproperty FW_Choose_IP_Extra_Range_Damage_Type ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_EXTRA_RANGE_DAMAGE_TYPE == FALSE)
      return ipAdd;
   int nDamageType;
   int nRoll = Random(3);
   switch(nRoll)
   {
      case 0: nDamageType = IP_CONST_DAMAGETYPE_BLUDGEONING;
         break;
      case 1: nDamageType = IP_CONST_DAMAGETYPE_PIERCING;
         break;
      case 2: nDamageType = IP_CONST_DAMAGETYPE_SLASHING;
         break;
      default: break;
   }
   ipAdd = ItemPropertyExtraRangeDamageType(nDamageType);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that returns the item property freedom of movement only
// * if freedom of movement is an allowed property.
//
itemproperty FW_Choose_IP_Freedom_Of_Movement ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_FREEDOM_OF_MOVEMENT == FALSE)
      return ipAdd;
   
   ipAdd = ItemPropertyFreeAction();
   return ipAdd;
}

////////////////////////////////////////////
// * Function that returns the item property haste only
// * if haste is an allowed property.
//
itemproperty FW_Choose_IP_Haste ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_HASTE == FALSE)
      return ipAdd;
   
   ipAdd = ItemPropertyHaste();
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses the level of a healer's kit subject to min and max.
// * Min and Max must be positive integers between 1 and 12:  1,2,3,...,12
//
itemproperty FW_Choose_IP_Healer_Kit (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_HEALER_KIT == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_HEALER_KIT_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_HEALER_KIT_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_HEALER_KIT_CR_0 ; max = FW_MAX_HEALER_KIT_CR_0 ;    break;
		
		case 1: min = FW_MIN_HEALER_KIT_CR_1 ; max = FW_MAX_HEALER_KIT_CR_1 ;    break;
		case 2: min = FW_MIN_HEALER_KIT_CR_2 ; max = FW_MAX_HEALER_KIT_CR_2 ;    break;
		case 3: min = FW_MIN_HEALER_KIT_CR_3 ; max = FW_MAX_HEALER_KIT_CR_3 ;    break;
   		case 4: min = FW_MIN_HEALER_KIT_CR_4 ; max = FW_MAX_HEALER_KIT_CR_4 ;    break;
		case 5: min = FW_MIN_HEALER_KIT_CR_5 ; max = FW_MAX_HEALER_KIT_CR_5 ;    break;
		case 6: min = FW_MIN_HEALER_KIT_CR_6 ; max = FW_MAX_HEALER_KIT_CR_6 ;    break;
   		case 7: min = FW_MIN_HEALER_KIT_CR_7 ; max = FW_MAX_HEALER_KIT_CR_7 ;    break;
		case 8: min = FW_MIN_HEALER_KIT_CR_8 ; max = FW_MAX_HEALER_KIT_CR_8 ;    break;
		case 9: min = FW_MIN_HEALER_KIT_CR_9 ; max = FW_MAX_HEALER_KIT_CR_9 ;    break;
   		case 10: min = FW_MIN_HEALER_KIT_CR_10 ; max = FW_MAX_HEALER_KIT_CR_10 ; break;
		
		case 11: min = FW_MIN_HEALER_KIT_CR_11 ; max = FW_MAX_HEALER_KIT_CR_11 ;  break;
		case 12: min = FW_MIN_HEALER_KIT_CR_12 ; max = FW_MAX_HEALER_KIT_CR_12 ;  break;
		case 13: min = FW_MIN_HEALER_KIT_CR_13 ; max = FW_MAX_HEALER_KIT_CR_13 ;  break;
   		case 14: min = FW_MIN_HEALER_KIT_CR_14 ; max = FW_MAX_HEALER_KIT_CR_14 ;  break;
		case 15: min = FW_MIN_HEALER_KIT_CR_15 ; max = FW_MAX_HEALER_KIT_CR_15 ;  break;
		case 16: min = FW_MIN_HEALER_KIT_CR_16 ; max = FW_MAX_HEALER_KIT_CR_16 ;  break;
   		case 17: min = FW_MIN_HEALER_KIT_CR_17 ; max = FW_MAX_HEALER_KIT_CR_17 ;  break;
		case 18: min = FW_MIN_HEALER_KIT_CR_18 ; max = FW_MAX_HEALER_KIT_CR_18 ;  break;
		case 19: min = FW_MIN_HEALER_KIT_CR_19 ; max = FW_MAX_HEALER_KIT_CR_19 ;  break;
   		case 20: min = FW_MIN_HEALER_KIT_CR_20 ; max = FW_MAX_HEALER_KIT_CR_20 ;  break;
   
   		case 21: min = FW_MIN_HEALER_KIT_CR_21 ; max = FW_MAX_HEALER_KIT_CR_21 ;  break;
		case 22: min = FW_MIN_HEALER_KIT_CR_22 ; max = FW_MAX_HEALER_KIT_CR_22 ;  break;
		case 23: min = FW_MIN_HEALER_KIT_CR_23 ; max = FW_MAX_HEALER_KIT_CR_23 ;  break;
   		case 24: min = FW_MIN_HEALER_KIT_CR_24 ; max = FW_MAX_HEALER_KIT_CR_24 ;  break;
		case 25: min = FW_MIN_HEALER_KIT_CR_25 ; max = FW_MAX_HEALER_KIT_CR_25 ;  break;
		case 26: min = FW_MIN_HEALER_KIT_CR_26 ; max = FW_MAX_HEALER_KIT_CR_26 ;  break;
   		case 27: min = FW_MIN_HEALER_KIT_CR_27 ; max = FW_MAX_HEALER_KIT_CR_27 ;  break;
		case 28: min = FW_MIN_HEALER_KIT_CR_28 ; max = FW_MAX_HEALER_KIT_CR_28 ;  break;
		case 29: min = FW_MIN_HEALER_KIT_CR_29 ; max = FW_MAX_HEALER_KIT_CR_29 ;  break;
   		case 30: min = FW_MIN_HEALER_KIT_CR_30 ; max = FW_MAX_HEALER_KIT_CR_30 ;  break;		
		
		case 31: min = FW_MIN_HEALER_KIT_CR_31 ; max = FW_MAX_HEALER_KIT_CR_31 ;  break;
		case 32: min = FW_MIN_HEALER_KIT_CR_32 ; max = FW_MAX_HEALER_KIT_CR_32 ;  break;
		case 33: min = FW_MIN_HEALER_KIT_CR_33 ; max = FW_MAX_HEALER_KIT_CR_33 ;  break;
   		case 34: min = FW_MIN_HEALER_KIT_CR_34 ; max = FW_MAX_HEALER_KIT_CR_34 ;  break;
		case 35: min = FW_MIN_HEALER_KIT_CR_35 ; max = FW_MAX_HEALER_KIT_CR_35 ;  break;
		case 36: min = FW_MIN_HEALER_KIT_CR_36 ; max = FW_MAX_HEALER_KIT_CR_36 ;  break;
   		case 37: min = FW_MIN_HEALER_KIT_CR_37 ; max = FW_MAX_HEALER_KIT_CR_37 ;  break;
		case 38: min = FW_MIN_HEALER_KIT_CR_38 ; max = FW_MAX_HEALER_KIT_CR_38 ;  break;
		case 39: min = FW_MIN_HEALER_KIT_CR_39 ; max = FW_MAX_HEALER_KIT_CR_39 ;  break;
   		case 40: min = FW_MIN_HEALER_KIT_CR_40 ; max = FW_MAX_HEALER_KIT_CR_40 ;  break;
		
		case 41: min = FW_MIN_HEALER_KIT_CR_41_OR_HIGHER; max = FW_MAX_HEALER_KIT_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else	  
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 12)
      min = 12;
   if (max < 1)
      max = 1;
   if (max > 12)
      max = 12;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyHealersKit (nBonus);
   return ipAdd;
}


////////////////////////////////////////////
// * Function that returns the item property holy avenger only
// * if holy avenger is an allowed property.
//
itemproperty FW_Choose_IP_Holy_Avenger ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_HOLY_AVENGER == FALSE)
      return ipAdd;
   
   ipAdd = ItemPropertyHolyAvenger();
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses a miscellaneous immunity property for an item.
//
itemproperty FW_Choose_IP_Immunity_Misc ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_IMMUNITY_MISC == FALSE)
      return ipAdd;
   int nImmunityType;
   int nRoll = Random (10);
   switch (nRoll)
   {
      case 0: nImmunityType = IP_CONST_IMMUNITYMISC_BACKSTAB;
         break;
      case 1: nImmunityType = IP_CONST_IMMUNITYMISC_CRITICAL_HITS;
         break;
      case 2: nImmunityType = IP_CONST_IMMUNITYMISC_DEATH_MAGIC;
         break;
      case 3: nImmunityType = IP_CONST_IMMUNITYMISC_DISEASE;
         break;
      case 4: nImmunityType = IP_CONST_IMMUNITYMISC_FEAR;
         break;
      case 5: nImmunityType = IP_CONST_IMMUNITYMISC_KNOCKDOWN;
         break;
      case 6: nImmunityType = IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN;
         break;
      case 7: nImmunityType = IP_CONST_IMMUNITYMISC_MINDSPELLS;
         break;
      case 8: nImmunityType = IP_CONST_IMMUNITYMISC_PARALYSIS;
         break;
      case 9: nImmunityType = IP_CONST_IMMUNITYMISC_POISON;
         break;
      default: break;
   }
   ipAdd = ItemPropertyImmunityMisc (nImmunityType);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses an immunity to spell level for an item.  The user
// * becomes immune to all spells of the number chosen and below. Acceptable
// * values for min and max are integers from 1 to 9.  0 is NOT acceptable.
//
itemproperty FW_Choose_IP_Immunity_To_Spell_Level (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_IMMUNITY_TO_SPELL_LEVEL == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_IMMUNITY_TO_SPELL_LEVEL_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_IMMUNITY_TO_SPELL_LEVEL_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_0 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_0 ;    break;
		
		case 1: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_1 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_1 ;    break;
		case 2: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_2 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_2 ;    break;
		case 3: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_3 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_3 ;    break;
   		case 4: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_4 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_4 ;    break;
		case 5: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_5 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_5 ;    break;
		case 6: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_6 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_6 ;    break;
   		case 7: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_7 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_7 ;    break;
		case 8: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_8 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_8 ;    break;
		case 9: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_9 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_9 ;    break;
   		case 10: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_10 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_10 ; break;
		
		case 11: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_11 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_11 ;  break;
		case 12: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_12 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_12 ;  break;
		case 13: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_13 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_13 ;  break;
   		case 14: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_14 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_14 ;  break;
		case 15: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_15 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_15 ;  break;
		case 16: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_16 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_16 ;  break;
   		case 17: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_17 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_17 ;  break;
		case 18: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_18 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_18 ;  break;
		case 19: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_19 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_19 ;  break;
   		case 20: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_20 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_20 ;  break;
   
   		case 21: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_21 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_21 ;  break;
		case 22: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_22 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_22 ;  break;
		case 23: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_23 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_23 ;  break;
   		case 24: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_24 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_24 ;  break;
		case 25: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_25 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_25 ;  break;
		case 26: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_26 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_26 ;  break;
   		case 27: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_27 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_27 ;  break;
		case 28: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_28 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_28 ;  break;
		case 29: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_29 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_29 ;  break;
   		case 30: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_30 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_30 ;  break;		
		
		case 31: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_31 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_31 ;  break;
		case 32: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_32 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_32 ;  break;
		case 33: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_33 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_33 ;  break;
   		case 34: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_34 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_34 ;  break;
		case 35: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_35 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_35 ;  break;
		case 36: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_36 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_36 ;  break;
   		case 37: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_37 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_37 ;  break;
		case 38: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_38 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_38 ;  break;
		case 39: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_39 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_39 ;  break;
   		case 40: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_40 ; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_40 ;  break;
		
		case 41: min = FW_MIN_IMMUNITY_TO_SPELL_LEVEL_CR_41_OR_HIGHER; max = FW_MAX_IMMUNITY_TO_SPELL_LEVEL_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else	  
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 9)
      min = 9;
   if (max < 1)
      max = 1;
   if (max > 9)
      max = 9;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyImmunityToSpellLevel(nBonus);
   return ipAdd;
}


////////////////////////////////////////////
// * Function that returns the item property improved evasion only
// * if improved evasion is an allowed property.
//
itemproperty FW_Choose_IP_Improved_Evasion ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_IMPROVED_EVASION == FALSE)
      return ipAdd;
   
   ipAdd = ItemPropertyImprovedEvasion();
   return ipAdd;
}


////////////////////////////////////////////
// * Function that returns the item property keen only
// * if keen is an allowed property.
//
itemproperty FW_Choose_IP_Keen ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_KEEN == FALSE)
      return ipAdd;
   
   ipAdd = ItemPropertyKeen();
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses a color and brightness of light to be added to an
// * item.
//
itemproperty FW_Choose_IP_Light()
{
   itemproperty ipAdd;
   if (FW_ALLOW_LIGHT == FALSE)
      return ipAdd;
   int nBrightness;
   int nColor;

   int nRoll = Random (4);
   switch (nRoll)
   {
      case 0: nBrightness = IP_CONST_LIGHTBRIGHTNESS_DIM;
         break;
      case 1: nBrightness = IP_CONST_LIGHTBRIGHTNESS_LOW;
         break;
      case 2: nBrightness = IP_CONST_LIGHTBRIGHTNESS_NORMAL;
         break;
      case 3: nBrightness = IP_CONST_LIGHTBRIGHTNESS_BRIGHT;
         break;
      default: break;
   }
   nRoll = Random (7);
   switch (nRoll)
   {
      case 0: nColor = IP_CONST_LIGHTCOLOR_BLUE;
         break;
      case 1: nColor = IP_CONST_LIGHTCOLOR_GREEN;
         break;
      case 2: nColor = IP_CONST_LIGHTCOLOR_ORANGE;
         break;
      case 3: nColor = IP_CONST_LIGHTCOLOR_PURPLE;
         break;
      case 4: nColor = IP_CONST_LIGHTCOLOR_RED;
         break;
      case 5: nColor = IP_CONST_LIGHTCOLOR_WHITE;
         break;
      case 6: nColor = IP_CONST_LIGHTCOLOR_YELLOW;
         break;
      default: break;
   }
   ipAdd = ItemPropertyLight (nBrightness, nColor);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that limits an item's use to a certain Alignment GROUP.
//
itemproperty FW_Choose_IP_Limit_Use_By_Align ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_LIMIT_USE_BY_ALIGN == FALSE)
      return ipAdd;
   int nAlignGroup = FW_Choose_IP_CONST_ALIGNMENTGROUP ();
   ipAdd = ItemPropertyLimitUseByAlign (nAlignGroup);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that limits an item's use to a certain Class.
//
itemproperty FW_Choose_IP_Limit_Use_By_Class ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_LIMIT_USE_BY_CLASS == FALSE)
      return ipAdd;
   int nClass = FW_Choose_IP_CONST_CLASS ();
   ipAdd = ItemPropertyLimitUseByClass (nClass);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that limits an item's use to a certain Race.
//
itemproperty FW_Choose_IP_Limit_Use_By_Race ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_LIMIT_USE_BY_RACE == FALSE)
      return ipAdd;
   int nRace;

   // Since these are items that PC's will be using, it makes no sense to limit
   // something to a race that a PC cannot play, such as vermin or dragon.
   // As new expansions are released this function will need to be updated with
   // any new racial types that a PC can play. For example, Mask of the Betrayer
   // will add Genasi, which are elementals.  That's why I have elemental here.
   int nRoll = Random (9);
   switch (nRoll)
   {
      case 0: nRace = IP_CONST_RACIALTYPE_DWARF;
         break;
      case 1: nRace = IP_CONST_RACIALTYPE_ELEMENTAL;
         break;
      case 2: nRace = IP_CONST_RACIALTYPE_ELF;
         break;
      case 3: nRace = IP_CONST_RACIALTYPE_GNOME;
         break;
      case 4: nRace = IP_CONST_RACIALTYPE_HALFELF;
         break;
      case 5: nRace = IP_CONST_RACIALTYPE_HALFLING;
         break;
      case 6: nRace = IP_CONST_RACIALTYPE_HALFORC;
         break;
      case 7: nRace = IP_CONST_RACIALTYPE_HUMAN;
         break;
      case 8: nRace = IP_CONST_RACIALTYPE_OUTSIDER;
         break;
      default: break;
   } // end of switch
   ipAdd = ItemPropertyLimitUseByRace (nRace);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that limits an item's use to a certain SPECIFIC alignment.
//
itemproperty FW_Choose_IP_Limit_Use_By_SAlign ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_LIMIT_USE_BY_SALIGN == FALSE)
      return ipAdd;
   int nAlignment = FW_Choose_IP_CONST_SALIGN  ();
   ipAdd = ItemPropertyLimitUseBySAlign (nAlignment);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses an amount of massive critical dmg. bonus to be added
// * to an item.  Min and Max must be POSITIVE integers between 0 and 19. See
// * the table: DAMAGE_BONUS for how to set these values to something different
// * than the default.
//
itemproperty FW_Choose_IP_Massive_Critical (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_MASSIVE_CRITICAL_DAMAGE_BONUS == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
   		// note different formula
		max = FloatToInt(nCR * FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_MODIFIER) - 1;
		min = FloatToInt(nCR * FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_MODIFIER) - 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_0 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_0 ;    break;
		
		case 1: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_1 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_1 ;    break;
		case 2: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_2 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_2 ;    break;
		case 3: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_3 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_3 ;    break;
   		case 4: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_4 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_4 ;    break;
		case 5: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_5 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_5 ;    break;
		case 6: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_6 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_6 ;    break;
   		case 7: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_7 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_7 ;    break;
		case 8: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_8 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_8 ;    break;
		case 9: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_9 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_9 ;    break;
   		case 10: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_10 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_10 ; break;
		
		case 11: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_11 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_11 ;  break;
		case 12: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_12 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_12 ;  break;
		case 13: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_13 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_13 ;  break;
   		case 14: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_14 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_14 ;  break;
		case 15: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_15 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_15 ;  break;
		case 16: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_16 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_16 ;  break;
   		case 17: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_17 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_17 ;  break;
		case 18: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_18 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_18 ;  break;
		case 19: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_19 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_19 ;  break;
   		case 20: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_20 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_20 ;  break;
   
   		case 21: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_21 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_21 ;  break;
		case 22: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_22 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_22 ;  break;
		case 23: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_23 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_23 ;  break;
   		case 24: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_24 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_24 ;  break;
		case 25: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_25 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_25 ;  break;
		case 26: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_26 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_26 ;  break;
   		case 27: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_27 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_27 ;  break;
		case 28: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_28 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_28 ;  break;
		case 29: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_29 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_29 ;  break;
   		case 30: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_30 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_30 ;  break;		
		
		case 31: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_31 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_31 ;  break;
		case 32: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_32 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_32 ;  break;
		case 33: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_33 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_33 ;  break;
   		case 34: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_34 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_34 ;  break;
		case 35: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_35 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_35 ;  break;
		case 36: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_36 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_36 ;  break;
   		case 37: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_37 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_37 ;  break;
		case 38: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_38 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_38 ;  break;
		case 39: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_39 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_39 ;  break;
   		case 40: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_40 ; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_40 ;  break;
		
		case 41: min = FW_MIN_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_41_OR_HIGHER; max = FW_MAX_MASSIVE_CRITICAL_DAMAGE_BONUS_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else	  
   int nBonus = FW_Choose_IP_CONST_DAMAGEBONUS (min, max);
   ipAdd = ItemPropertyMassiveCritical(nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses the Mighty Bonus on a ranged weapon (the maximum
// * strength bonus allowed.  min and max must be positive integers. 1...20
//
itemproperty FW_Choose_IP_Mighty (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_MIGHTY_BONUS == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_MIGHTY_BONUS_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_MIGHTY_BONUS_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_MIGHTY_BONUS_CR_0 ; max = FW_MAX_MIGHTY_BONUS_CR_0 ;    break;
		
		case 1: min = FW_MIN_MIGHTY_BONUS_CR_1 ; max = FW_MAX_MIGHTY_BONUS_CR_1 ;    break;
		case 2: min = FW_MIN_MIGHTY_BONUS_CR_2 ; max = FW_MAX_MIGHTY_BONUS_CR_2 ;    break;
		case 3: min = FW_MIN_MIGHTY_BONUS_CR_3 ; max = FW_MAX_MIGHTY_BONUS_CR_3 ;    break;
   		case 4: min = FW_MIN_MIGHTY_BONUS_CR_4 ; max = FW_MAX_MIGHTY_BONUS_CR_4 ;    break;
		case 5: min = FW_MIN_MIGHTY_BONUS_CR_5 ; max = FW_MAX_MIGHTY_BONUS_CR_5 ;    break;
		case 6: min = FW_MIN_MIGHTY_BONUS_CR_6 ; max = FW_MAX_MIGHTY_BONUS_CR_6 ;    break;
   		case 7: min = FW_MIN_MIGHTY_BONUS_CR_7 ; max = FW_MAX_MIGHTY_BONUS_CR_7 ;    break;
		case 8: min = FW_MIN_MIGHTY_BONUS_CR_8 ; max = FW_MAX_MIGHTY_BONUS_CR_8 ;    break;
		case 9: min = FW_MIN_MIGHTY_BONUS_CR_9 ; max = FW_MAX_MIGHTY_BONUS_CR_9 ;    break;
   		case 10: min = FW_MIN_MIGHTY_BONUS_CR_10 ; max = FW_MAX_MIGHTY_BONUS_CR_10 ; break;
		
		case 11: min = FW_MIN_MIGHTY_BONUS_CR_11 ; max = FW_MAX_MIGHTY_BONUS_CR_11 ;  break;
		case 12: min = FW_MIN_MIGHTY_BONUS_CR_12 ; max = FW_MAX_MIGHTY_BONUS_CR_12 ;  break;
		case 13: min = FW_MIN_MIGHTY_BONUS_CR_13 ; max = FW_MAX_MIGHTY_BONUS_CR_13 ;  break;
   		case 14: min = FW_MIN_MIGHTY_BONUS_CR_14 ; max = FW_MAX_MIGHTY_BONUS_CR_14 ;  break;
		case 15: min = FW_MIN_MIGHTY_BONUS_CR_15 ; max = FW_MAX_MIGHTY_BONUS_CR_15 ;  break;
		case 16: min = FW_MIN_MIGHTY_BONUS_CR_16 ; max = FW_MAX_MIGHTY_BONUS_CR_16 ;  break;
   		case 17: min = FW_MIN_MIGHTY_BONUS_CR_17 ; max = FW_MAX_MIGHTY_BONUS_CR_17 ;  break;
		case 18: min = FW_MIN_MIGHTY_BONUS_CR_18 ; max = FW_MAX_MIGHTY_BONUS_CR_18 ;  break;
		case 19: min = FW_MIN_MIGHTY_BONUS_CR_19 ; max = FW_MAX_MIGHTY_BONUS_CR_19 ;  break;
   		case 20: min = FW_MIN_MIGHTY_BONUS_CR_20 ; max = FW_MAX_MIGHTY_BONUS_CR_20 ;  break;
   
   		case 21: min = FW_MIN_MIGHTY_BONUS_CR_21 ; max = FW_MAX_MIGHTY_BONUS_CR_21 ;  break;
		case 22: min = FW_MIN_MIGHTY_BONUS_CR_22 ; max = FW_MAX_MIGHTY_BONUS_CR_22 ;  break;
		case 23: min = FW_MIN_MIGHTY_BONUS_CR_23 ; max = FW_MAX_MIGHTY_BONUS_CR_23 ;  break;
   		case 24: min = FW_MIN_MIGHTY_BONUS_CR_24 ; max = FW_MAX_MIGHTY_BONUS_CR_24 ;  break;
		case 25: min = FW_MIN_MIGHTY_BONUS_CR_25 ; max = FW_MAX_MIGHTY_BONUS_CR_25 ;  break;
		case 26: min = FW_MIN_MIGHTY_BONUS_CR_26 ; max = FW_MAX_MIGHTY_BONUS_CR_26 ;  break;
   		case 27: min = FW_MIN_MIGHTY_BONUS_CR_27 ; max = FW_MAX_MIGHTY_BONUS_CR_27 ;  break;
		case 28: min = FW_MIN_MIGHTY_BONUS_CR_28 ; max = FW_MAX_MIGHTY_BONUS_CR_28 ;  break;
		case 29: min = FW_MIN_MIGHTY_BONUS_CR_29 ; max = FW_MAX_MIGHTY_BONUS_CR_29 ;  break;
   		case 30: min = FW_MIN_MIGHTY_BONUS_CR_30 ; max = FW_MAX_MIGHTY_BONUS_CR_30 ;  break;		
		
		case 31: min = FW_MIN_MIGHTY_BONUS_CR_31 ; max = FW_MAX_MIGHTY_BONUS_CR_31 ;  break;
		case 32: min = FW_MIN_MIGHTY_BONUS_CR_32 ; max = FW_MAX_MIGHTY_BONUS_CR_32 ;  break;
		case 33: min = FW_MIN_MIGHTY_BONUS_CR_33 ; max = FW_MAX_MIGHTY_BONUS_CR_33 ;  break;
   		case 34: min = FW_MIN_MIGHTY_BONUS_CR_34 ; max = FW_MAX_MIGHTY_BONUS_CR_34 ;  break;
		case 35: min = FW_MIN_MIGHTY_BONUS_CR_35 ; max = FW_MAX_MIGHTY_BONUS_CR_35 ;  break;
		case 36: min = FW_MIN_MIGHTY_BONUS_CR_36 ; max = FW_MAX_MIGHTY_BONUS_CR_36 ;  break;
   		case 37: min = FW_MIN_MIGHTY_BONUS_CR_37 ; max = FW_MAX_MIGHTY_BONUS_CR_37 ;  break;
		case 38: min = FW_MIN_MIGHTY_BONUS_CR_38 ; max = FW_MAX_MIGHTY_BONUS_CR_38 ;  break;
		case 39: min = FW_MIN_MIGHTY_BONUS_CR_39 ; max = FW_MAX_MIGHTY_BONUS_CR_39 ;  break;
   		case 40: min = FW_MIN_MIGHTY_BONUS_CR_40 ; max = FW_MAX_MIGHTY_BONUS_CR_40 ;  break;
		
		case 41: min = FW_MIN_MIGHTY_BONUS_CR_41_OR_HIGHER; max = FW_MAX_MIGHTY_BONUS_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else	  
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   // Mighty
   ipAdd = ItemPropertyMaxRangeStrengthMod (nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses an OnHitCastSpell to be added to an item. Obviously
// * this only works on weapons.
//
itemproperty FW_Choose_IP_On_Hit_Cast_Spell (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_ON_HIT_CAST_SPELL == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_ON_HIT_SPELL_LEVEL_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_ON_HIT_SPELL_LEVEL_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_0 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_0 ;    break;
		
		case 1: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_1 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_1 ;    break;
		case 2: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_2 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_2 ;    break;
		case 3: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_3 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_3 ;    break;
   		case 4: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_4 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_4 ;    break;
		case 5: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_5 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_5 ;    break;
		case 6: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_6 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_6 ;    break;
   		case 7: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_7 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_7 ;    break;
		case 8: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_8 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_8 ;    break;
		case 9: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_9 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_9 ;    break;
   		case 10: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_10 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_10 ; break;
		
		case 11: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_11 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_11 ;  break;
		case 12: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_12 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_12 ;  break;
		case 13: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_13 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_13 ;  break;
   		case 14: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_14 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_14 ;  break;
		case 15: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_15 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_15 ;  break;
		case 16: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_16 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_16 ;  break;
   		case 17: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_17 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_17 ;  break;
		case 18: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_18 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_18 ;  break;
		case 19: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_19 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_19 ;  break;
   		case 20: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_20 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_20 ;  break;
   
   		case 21: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_21 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_21 ;  break;
		case 22: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_22 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_22 ;  break;
		case 23: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_23 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_23 ;  break;
   		case 24: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_24 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_24 ;  break;
		case 25: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_25 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_25 ;  break;
		case 26: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_26 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_26 ;  break;
   		case 27: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_27 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_27 ;  break;
		case 28: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_28 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_28 ;  break;
		case 29: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_29 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_29 ;  break;
   		case 30: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_30 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_30 ;  break;		
		
		case 31: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_31 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_31 ;  break;
		case 32: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_32 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_32 ;  break;
		case 33: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_33 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_33 ;  break;
   		case 34: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_34 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_34 ;  break;
		case 35: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_35 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_35 ;  break;
		case 36: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_36 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_36 ;  break;
   		case 37: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_37 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_37 ;  break;
		case 38: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_38 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_38 ;  break;
		case 39: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_39 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_39 ;  break;
   		case 40: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_40 ; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_40 ;  break;
		
		case 41: min = FW_MIN_ON_HIT_SPELL_LEVEL_CR_41_OR_HIGHER; max = FW_MAX_ON_HIT_SPELL_LEVEL_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else	  
   int nSpell;
   int nLevel;
   int nReRoll = TRUE;

   while (nReRoll)
   {
      // As of 12 May 2008 there are 143 OnHit spells in NWN 2.
      // See "iprp_onhitspell.2da"
      nSpell = Random (143);
      switch (nSpell)
      {
        //**************************************
        //
        //  EXCLUDE SPELLS IN THIS SECTION
        //
        // I gave 3 examples below of how to exclude an onhit spell from being
        // added to an item.  In the examples, if Acid Fog, Bane, or Daze is
        // rolled as a random OnHitCastSpell then the generator re-rolls until a
        // spell that isn't disallowed below is found.  If you uncomment
        // this section of code, ALWAYS leave the default alone.  The default
        // guarantees that this function doesn't get stuck in a loop forever
        // by setting nReRoll to FALSE.  Don't change it.  Substitute the
        // IP_CONST_ONHIT_CASTSPELL_* that you do not want to appear in for one
        // of my examples. If you desire to disallow more than 3, then you'll
        // need to make additional case statements like in the examples shown.
        //
        //
        // WARNING: There is a possibility of creating significant lag if you
        //    have a whole lot of disallowed spells with only a couple of
        //    acceptable ones. The reason is the while statement keeps
        //    re-rolling a number between 0 and 142.  It might take it a LONG
        //    time to pick an acceptable spell if you disallow almost everything.
        //    It would be better to rewrite this function a different way if you
        //    are going to disallow more than half of the spells.
        // VITALLY IMPORTANT NOTE: Don't disallow everything or else this will
        //    crash the game because it will get stuck in a loop forever. If you
        //    want to disallow ALL OnHitspells from appearing on an item, do so
        //    by changing the constant FW_ALLOW_ON_HIT_CAST_SPELL = FALSE;
        /*
        case IP_CONST_ONHIT_CASTSPELL_ACID_FOG: nReRoll = TRUE;
           break;
        case IP_CONST_ONHIT_CASTSPELL_BANE: nReRoll = TRUE;
           break;
        case IP_CONST_ONHIT_CASTSPELL_DAZE: nReRoll = TRUE;
           break;
        */
        //**************************************
        // We found an acceptable spell!!
        default: nReRoll = FALSE;
           break;
      } // end of switch

      // Here I am going to see if the random generator rolled a spell that was
      // removed.  In the .2da file iprp_onhitspell if a spell has been removed
      // its label value is equal to "****"  The Get2DAString function Returns
      // "" (empty string) for "****".  If we rolled a spell that was removed,
      // then we need to reroll, so I set nReRoll = TRUE to force a reroll.
      string sCheck = "";
      string sLabel;
      sLabel = Get2DAString ("iprp_onhitspell", "Label", nSpell);
      if (sLabel == sCheck)
         nReRoll = TRUE;
   } // end of while

   if (min < 1)
      min = 1;
   if (min > 9)
      min = 9;
   if (max < 1)
      max = 1;
   if (max > 9)
      max = 9;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nLevel = 1;  }
   else if (min == max)
      {  nLevel = min;  }
   else
   {
      int nValue = max - min + 1;
      nLevel = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyOnHitCastSpell (nSpell, nLevel);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses an OnHitProps to be added to an item. Obviously
// * this only works on weapons and armors.
//
itemproperty FW_Choose_IP_On_Hit_Props (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_ON_HIT_PROPS == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
   		// note different formula
		max = FloatToInt(nCR * FW_MAX_ON_HIT_SAVE_DC_MODIFIER) ;
		min = FloatToInt(nCR * FW_MIN_ON_HIT_SAVE_DC_MODIFIER) ;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_ON_HIT_SAVE_DC_CR_0 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_0 ;    break;
		
		case 1: min = FW_MIN_ON_HIT_SAVE_DC_CR_1 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_1 ;    break;
		case 2: min = FW_MIN_ON_HIT_SAVE_DC_CR_2 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_2 ;    break;
		case 3: min = FW_MIN_ON_HIT_SAVE_DC_CR_3 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_3 ;    break;
   		case 4: min = FW_MIN_ON_HIT_SAVE_DC_CR_4 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_4 ;    break;
		case 5: min = FW_MIN_ON_HIT_SAVE_DC_CR_5 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_5 ;    break;
		case 6: min = FW_MIN_ON_HIT_SAVE_DC_CR_6 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_6 ;    break;
   		case 7: min = FW_MIN_ON_HIT_SAVE_DC_CR_7 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_7 ;    break;
		case 8: min = FW_MIN_ON_HIT_SAVE_DC_CR_8 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_8 ;    break;
		case 9: min = FW_MIN_ON_HIT_SAVE_DC_CR_9 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_9 ;    break;
   		case 10: min = FW_MIN_ON_HIT_SAVE_DC_CR_10 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_10 ; break;
		
		case 11: min = FW_MIN_ON_HIT_SAVE_DC_CR_11 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_11 ;  break;
		case 12: min = FW_MIN_ON_HIT_SAVE_DC_CR_12 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_12 ;  break;
		case 13: min = FW_MIN_ON_HIT_SAVE_DC_CR_13 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_13 ;  break;
   		case 14: min = FW_MIN_ON_HIT_SAVE_DC_CR_14 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_14 ;  break;
		case 15: min = FW_MIN_ON_HIT_SAVE_DC_CR_15 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_15 ;  break;
		case 16: min = FW_MIN_ON_HIT_SAVE_DC_CR_16 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_16 ;  break;
   		case 17: min = FW_MIN_ON_HIT_SAVE_DC_CR_17 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_17 ;  break;
		case 18: min = FW_MIN_ON_HIT_SAVE_DC_CR_18 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_18 ;  break;
		case 19: min = FW_MIN_ON_HIT_SAVE_DC_CR_19 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_19 ;  break;
   		case 20: min = FW_MIN_ON_HIT_SAVE_DC_CR_20 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_20 ;  break;
   
   		case 21: min = FW_MIN_ON_HIT_SAVE_DC_CR_21 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_21 ;  break;
		case 22: min = FW_MIN_ON_HIT_SAVE_DC_CR_22 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_22 ;  break;
		case 23: min = FW_MIN_ON_HIT_SAVE_DC_CR_23 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_23 ;  break;
   		case 24: min = FW_MIN_ON_HIT_SAVE_DC_CR_24 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_24 ;  break;
		case 25: min = FW_MIN_ON_HIT_SAVE_DC_CR_25 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_25 ;  break;
		case 26: min = FW_MIN_ON_HIT_SAVE_DC_CR_26 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_26 ;  break;
   		case 27: min = FW_MIN_ON_HIT_SAVE_DC_CR_27 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_27 ;  break;
		case 28: min = FW_MIN_ON_HIT_SAVE_DC_CR_28 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_28 ;  break;
		case 29: min = FW_MIN_ON_HIT_SAVE_DC_CR_29 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_29 ;  break;
   		case 30: min = FW_MIN_ON_HIT_SAVE_DC_CR_30 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_30 ;  break;		
		
		case 31: min = FW_MIN_ON_HIT_SAVE_DC_CR_31 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_31 ;  break;
		case 32: min = FW_MIN_ON_HIT_SAVE_DC_CR_32 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_32 ;  break;
		case 33: min = FW_MIN_ON_HIT_SAVE_DC_CR_33 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_33 ;  break;
   		case 34: min = FW_MIN_ON_HIT_SAVE_DC_CR_34 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_34 ;  break;
		case 35: min = FW_MIN_ON_HIT_SAVE_DC_CR_35 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_35 ;  break;
		case 36: min = FW_MIN_ON_HIT_SAVE_DC_CR_36 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_36 ;  break;
   		case 37: min = FW_MIN_ON_HIT_SAVE_DC_CR_37 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_37 ;  break;
		case 38: min = FW_MIN_ON_HIT_SAVE_DC_CR_38 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_38 ;  break;
		case 39: min = FW_MIN_ON_HIT_SAVE_DC_CR_39 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_39 ;  break;
   		case 40: min = FW_MIN_ON_HIT_SAVE_DC_CR_40 ; max = FW_MAX_ON_HIT_SAVE_DC_CR_40 ;  break;
		
		case 41: min = FW_MIN_ON_HIT_SAVE_DC_CR_41_OR_HIGHER; max = FW_MAX_ON_HIT_SAVE_DC_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else	  
   int nSaveDC;
   int nSpecial;
   int nRoll;
   // There are 26 on hit props in "iprp_onhit.2da" As of 12 May 2008.
   int nProperty = Random (26);
   // #4 in the .2da was removed. So if we rolled #4, reroll a new one.
   while (nProperty == 4)
   {
      nProperty = Random (26);
   }
   // Keep min and max inside bounds.
   if (min < 14)
      min = 14;
   if (max < 14)
      max = 14;
   if (min > 26)
      min = 26;
   if (max > 26)
      max = 26;
   // In case someone accidentally swapped min and max.	
   if (min > max)
      min = max;
   // Map user inputs to .2da values.	  
   int nValue1 = (min - 14) / 2;
   int nValue2 = (max - 14) / 2;
   int nMappedValue = nValue2 - nValue1 + 1;
   nSaveDC = Random(nMappedValue)+ nValue1;
   switch (nSaveDC)
   {
      case 0: nSaveDC = IP_CONST_ONHIT_SAVEDC_14;
         break;
      case 1: nSaveDC = IP_CONST_ONHIT_SAVEDC_16;
         break;
      case 2: nSaveDC = IP_CONST_ONHIT_SAVEDC_18;
         break;
      case 3: nSaveDC = IP_CONST_ONHIT_SAVEDC_20;
         break;
      case 4: nSaveDC = IP_CONST_ONHIT_SAVEDC_22;
         break;
      case 5: nSaveDC = IP_CONST_ONHIT_SAVEDC_24;
         break;
      case 6: nSaveDC = IP_CONST_ONHIT_SAVEDC_26;
         break;      
      default: break;
   } // end of switch
   
   switch (nProperty)
   {
      case IP_CONST_ONHIT_ABILITYDRAIN:	nSpecial = Random (6);         	
	        break;
	  // All of these look for a duration constant. 
	  case IP_CONST_ONHIT_BLINDNESS: case IP_CONST_ONHIT_CONFUSION:
	  case IP_CONST_ONHIT_DAZE:      case IP_CONST_ONHIT_DEAFNESS:
	  case IP_CONST_ONHIT_DOOM:      case IP_CONST_ONHIT_FEAR:
	  case IP_CONST_ONHIT_HOLD:      case IP_CONST_ONHIT_SILENCE:
	  case IP_CONST_ONHIT_SLEEP:     case IP_CONST_ONHIT_SLOW:
	  case IP_CONST_ONHIT_STUN: 
	  	    // There are 40 in iprp_onhitdur.2da		
	 	    nSpecial = Random (40);	  
	     break;
	  // There are 17 diseases in disease.2da
      case IP_CONST_ONHIT_DISEASE: nSpecial = Random (17); 
	     break;
      // There are 6 types of poisons in iprp_poison.2da
	  case IP_CONST_ONHIT_ITEMPOISON: nSpecial = Random (6);
	     break;
	  // Make use of previous work. 
	  case IP_CONST_ONHIT_SLAYALIGNMENT: nSpecial = FW_Choose_IP_CONST_SALIGN ();
	     break;
	  // Make use of previous work.
	  case IP_CONST_ONHIT_SLAYALIGNMENTGROUP: nSpecial = FW_Choose_IP_CONST_ALIGNMENTGROUP();
	     break;
	  // Make use of previous work.
	  case IP_CONST_ONHIT_SLAYRACE: nSpecial = FW_Choose_IP_CONST_RACIALTYPE();
	     break;
	  // According to the Lexicon, I have to pick a number between 1 to 5
	  case IP_CONST_ONHIT_WOUNDING: nSpecial = Random (5) + 1;
	     break;
	  // According to the Lexicon, I have to pick a number between 1 to 5
      case IP_CONST_ONHIT_LEVELDRAIN: nSpecial = Random (5) + 1;
	     break;	 
		 
	  default: nSpecial = 0;
	     break;   
   }// end of switch.	  
   ipAdd = ItemPropertyOnHitProps(nProperty, nSaveDC, nSpecial);   
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a saving throw penalty to add to an item.
// * Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Reduced_Saving_Throw (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_SAVING_THROW_PENALTY == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_SAVING_THROW_PENALTY_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_SAVING_THROW_PENALTY_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_SAVING_THROW_PENALTY_CR_0 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_0 ;    break;
		
		case 1: min = FW_MIN_SAVING_THROW_PENALTY_CR_1 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_1 ;    break;
		case 2: min = FW_MIN_SAVING_THROW_PENALTY_CR_2 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_2 ;    break;
		case 3: min = FW_MIN_SAVING_THROW_PENALTY_CR_3 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_3 ;    break;
   		case 4: min = FW_MIN_SAVING_THROW_PENALTY_CR_4 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_4 ;    break;
		case 5: min = FW_MIN_SAVING_THROW_PENALTY_CR_5 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_5 ;    break;
		case 6: min = FW_MIN_SAVING_THROW_PENALTY_CR_6 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_6 ;    break;
   		case 7: min = FW_MIN_SAVING_THROW_PENALTY_CR_7 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_7 ;    break;
		case 8: min = FW_MIN_SAVING_THROW_PENALTY_CR_8 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_8 ;    break;
		case 9: min = FW_MIN_SAVING_THROW_PENALTY_CR_9 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_9 ;    break;
   		case 10: min = FW_MIN_SAVING_THROW_PENALTY_CR_10 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_10 ; break;
		
		case 11: min = FW_MIN_SAVING_THROW_PENALTY_CR_11 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_11 ;  break;
		case 12: min = FW_MIN_SAVING_THROW_PENALTY_CR_12 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_12 ;  break;
		case 13: min = FW_MIN_SAVING_THROW_PENALTY_CR_13 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_13 ;  break;
   		case 14: min = FW_MIN_SAVING_THROW_PENALTY_CR_14 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_14 ;  break;
		case 15: min = FW_MIN_SAVING_THROW_PENALTY_CR_15 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_15 ;  break;
		case 16: min = FW_MIN_SAVING_THROW_PENALTY_CR_16 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_16 ;  break;
   		case 17: min = FW_MIN_SAVING_THROW_PENALTY_CR_17 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_17 ;  break;
		case 18: min = FW_MIN_SAVING_THROW_PENALTY_CR_18 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_18 ;  break;
		case 19: min = FW_MIN_SAVING_THROW_PENALTY_CR_19 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_19 ;  break;
   		case 20: min = FW_MIN_SAVING_THROW_PENALTY_CR_20 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_20 ;  break;
   
   		case 21: min = FW_MIN_SAVING_THROW_PENALTY_CR_21 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_21 ;  break;
		case 22: min = FW_MIN_SAVING_THROW_PENALTY_CR_22 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_22 ;  break;
		case 23: min = FW_MIN_SAVING_THROW_PENALTY_CR_23 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_23 ;  break;
   		case 24: min = FW_MIN_SAVING_THROW_PENALTY_CR_24 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_24 ;  break;
		case 25: min = FW_MIN_SAVING_THROW_PENALTY_CR_25 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_25 ;  break;
		case 26: min = FW_MIN_SAVING_THROW_PENALTY_CR_26 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_26 ;  break;
   		case 27: min = FW_MIN_SAVING_THROW_PENALTY_CR_27 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_27 ;  break;
		case 28: min = FW_MIN_SAVING_THROW_PENALTY_CR_28 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_28 ;  break;
		case 29: min = FW_MIN_SAVING_THROW_PENALTY_CR_29 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_29 ;  break;
   		case 30: min = FW_MIN_SAVING_THROW_PENALTY_CR_30 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_30 ;  break;		
		
		case 31: min = FW_MIN_SAVING_THROW_PENALTY_CR_31 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_31 ;  break;
		case 32: min = FW_MIN_SAVING_THROW_PENALTY_CR_32 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_32 ;  break;
		case 33: min = FW_MIN_SAVING_THROW_PENALTY_CR_33 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_33 ;  break;
   		case 34: min = FW_MIN_SAVING_THROW_PENALTY_CR_34 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_34 ;  break;
		case 35: min = FW_MIN_SAVING_THROW_PENALTY_CR_35 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_35 ;  break;
		case 36: min = FW_MIN_SAVING_THROW_PENALTY_CR_36 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_36 ;  break;
   		case 37: min = FW_MIN_SAVING_THROW_PENALTY_CR_37 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_37 ;  break;
		case 38: min = FW_MIN_SAVING_THROW_PENALTY_CR_38 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_38 ;  break;
		case 39: min = FW_MIN_SAVING_THROW_PENALTY_CR_39 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_39 ;  break;
   		case 40: min = FW_MIN_SAVING_THROW_PENALTY_CR_40 ; max = FW_MAX_SAVING_THROW_PENALTY_CR_40 ;  break;
		
		case 41: min = FW_MIN_SAVING_THROW_PENALTY_CR_41_OR_HIGHER; max = FW_MAX_SAVING_THROW_PENALTY_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else	  
   int nBaseSaveType;
   int nBonus;

   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   int nRoll = Random (3);
   switch (nRoll)
   {
      case 0: nBaseSaveType = IP_CONST_SAVEBASETYPE_FORTITUDE;
         break;
      case 1: nBaseSaveType = IP_CONST_SAVEBASETYPE_REFLEX;
         break;
      case 2: nBaseSaveType = IP_CONST_SAVEBASETYPE_WILL;
         break;
      default: break;
   } // end of switch
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyReducedSavingThrow(nBaseSaveType, nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a bonus saving throw VS 'XYZ' to add to an
// * Item. Values for min and max should be an integer between 1 and 20.
//
itemproperty FW_Choose_IP_Reduced_Saving_Throw_VsX (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_SAVING_THROW_PENALTY_VSX == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_SAVING_THROW_PENALTY_VSX_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_SAVING_THROW_PENALTY_VSX_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_0 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_0 ;    break;
		
		case 1: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_1 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_1 ;    break;
		case 2: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_2 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_2 ;    break;
		case 3: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_3 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_3 ;    break;
   		case 4: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_4 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_4 ;    break;
		case 5: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_5 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_5 ;    break;
		case 6: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_6 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_6 ;    break;
   		case 7: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_7 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_7 ;    break;
		case 8: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_8 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_8 ;    break;
		case 9: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_9 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_9 ;    break;
   		case 10: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_10 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_10 ; break;
		
		case 11: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_11 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_11 ;  break;
		case 12: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_12 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_12 ;  break;
		case 13: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_13 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_13 ;  break;
   		case 14: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_14 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_14 ;  break;
		case 15: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_15 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_15 ;  break;
		case 16: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_16 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_16 ;  break;
   		case 17: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_17 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_17 ;  break;
		case 18: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_18 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_18 ;  break;
		case 19: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_19 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_19 ;  break;
   		case 20: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_20 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_20 ;  break;
   
   		case 21: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_21 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_21 ;  break;
		case 22: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_22 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_22 ;  break;
		case 23: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_23 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_23 ;  break;
   		case 24: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_24 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_24 ;  break;
		case 25: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_25 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_25 ;  break;
		case 26: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_26 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_26 ;  break;
   		case 27: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_27 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_27 ;  break;
		case 28: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_28 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_28 ;  break;
		case 29: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_29 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_29 ;  break;
   		case 30: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_30 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_30 ;  break;		
		
		case 31: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_31 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_31 ;  break;
		case 32: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_32 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_32 ;  break;
		case 33: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_33 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_33 ;  break;
   		case 34: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_34 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_34 ;  break;
		case 35: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_35 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_35 ;  break;
		case 36: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_36 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_36 ;  break;
   		case 37: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_37 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_37 ;  break;
		case 38: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_38 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_38 ;  break;
		case 39: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_39 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_39 ;  break;
   		case 40: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_40 ; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_40 ;  break;
		
		case 41: min = FW_MIN_SAVING_THROW_PENALTY_VSX_CR_41_OR_HIGHER; max = FW_MAX_SAVING_THROW_PENALTY_VSX_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else	  
   int nBonusType;
   int nBonus;

   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   int nRoll = Random (14);
   switch (nRoll)
   {
      case 0: nBonusType = IP_CONST_SAVEVS_ACID;
         break;
      case 1: nBonusType = IP_CONST_SAVEVS_COLD;
         break;
      case 2: nBonusType = IP_CONST_SAVEVS_DEATH;
         break;
      case 3: nBonusType = IP_CONST_SAVEVS_DISEASE;
         break;
      case 4: nBonusType = IP_CONST_SAVEVS_DIVINE;
         break;
      case 5: nBonusType = IP_CONST_SAVEVS_ELECTRICAL;
         break;
      case 6: nBonusType = IP_CONST_SAVEVS_FEAR;
         break;
      case 7: nBonusType = IP_CONST_SAVEVS_FIRE;
         break;
      case 8: nBonusType = IP_CONST_SAVEVS_MINDAFFECTING;
         break;
      case 9: nBonusType = IP_CONST_SAVEVS_NEGATIVE;
         break;
      case 10: nBonusType = IP_CONST_SAVEVS_POISON;
         break;
      case 11: nBonusType = IP_CONST_SAVEVS_POSITIVE;
         break;
      case 12: nBonusType = IP_CONST_SAVEVS_SONIC;
         break;
      case 13: nBonusType = IP_CONST_SAVEVS_UNIVERSAL;
         break;
      default: break;
   } // end of switch
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyReducedSavingThrowVsX(nBonusType, nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses a regeneration bonus that an item can have.  Subject
// * to min and max values as defined.  Limits for min and max are positive
// * integers between 1 and 20:  1,2,3,...,20
//
itemproperty FW_Choose_IP_Regeneration (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_REGENERATION == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_REGENERATION_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_REGENERATION_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_REGENERATION_CR_0 ; max = FW_MAX_REGENERATION_CR_0 ;    break;
		
		case 1: min = FW_MIN_REGENERATION_CR_1 ; max = FW_MAX_REGENERATION_CR_1 ;    break;
		case 2: min = FW_MIN_REGENERATION_CR_2 ; max = FW_MAX_REGENERATION_CR_2 ;    break;
		case 3: min = FW_MIN_REGENERATION_CR_3 ; max = FW_MAX_REGENERATION_CR_3 ;    break;
   		case 4: min = FW_MIN_REGENERATION_CR_4 ; max = FW_MAX_REGENERATION_CR_4 ;    break;
		case 5: min = FW_MIN_REGENERATION_CR_5 ; max = FW_MAX_REGENERATION_CR_5 ;    break;
		case 6: min = FW_MIN_REGENERATION_CR_6 ; max = FW_MAX_REGENERATION_CR_6 ;    break;
   		case 7: min = FW_MIN_REGENERATION_CR_7 ; max = FW_MAX_REGENERATION_CR_7 ;    break;
		case 8: min = FW_MIN_REGENERATION_CR_8 ; max = FW_MAX_REGENERATION_CR_8 ;    break;
		case 9: min = FW_MIN_REGENERATION_CR_9 ; max = FW_MAX_REGENERATION_CR_9 ;    break;
   		case 10: min = FW_MIN_REGENERATION_CR_10 ; max = FW_MAX_REGENERATION_CR_10 ; break;
		
		case 11: min = FW_MIN_REGENERATION_CR_11 ; max = FW_MAX_REGENERATION_CR_11 ;  break;
		case 12: min = FW_MIN_REGENERATION_CR_12 ; max = FW_MAX_REGENERATION_CR_12 ;  break;
		case 13: min = FW_MIN_REGENERATION_CR_13 ; max = FW_MAX_REGENERATION_CR_13 ;  break;
   		case 14: min = FW_MIN_REGENERATION_CR_14 ; max = FW_MAX_REGENERATION_CR_14 ;  break;
		case 15: min = FW_MIN_REGENERATION_CR_15 ; max = FW_MAX_REGENERATION_CR_15 ;  break;
		case 16: min = FW_MIN_REGENERATION_CR_16 ; max = FW_MAX_REGENERATION_CR_16 ;  break;
   		case 17: min = FW_MIN_REGENERATION_CR_17 ; max = FW_MAX_REGENERATION_CR_17 ;  break;
		case 18: min = FW_MIN_REGENERATION_CR_18 ; max = FW_MAX_REGENERATION_CR_18 ;  break;
		case 19: min = FW_MIN_REGENERATION_CR_19 ; max = FW_MAX_REGENERATION_CR_19 ;  break;
   		case 20: min = FW_MIN_REGENERATION_CR_20 ; max = FW_MAX_REGENERATION_CR_20 ;  break;
   
   		case 21: min = FW_MIN_REGENERATION_CR_21 ; max = FW_MAX_REGENERATION_CR_21 ;  break;
		case 22: min = FW_MIN_REGENERATION_CR_22 ; max = FW_MAX_REGENERATION_CR_22 ;  break;
		case 23: min = FW_MIN_REGENERATION_CR_23 ; max = FW_MAX_REGENERATION_CR_23 ;  break;
   		case 24: min = FW_MIN_REGENERATION_CR_24 ; max = FW_MAX_REGENERATION_CR_24 ;  break;
		case 25: min = FW_MIN_REGENERATION_CR_25 ; max = FW_MAX_REGENERATION_CR_25 ;  break;
		case 26: min = FW_MIN_REGENERATION_CR_26 ; max = FW_MAX_REGENERATION_CR_26 ;  break;
   		case 27: min = FW_MIN_REGENERATION_CR_27 ; max = FW_MAX_REGENERATION_CR_27 ;  break;
		case 28: min = FW_MIN_REGENERATION_CR_28 ; max = FW_MAX_REGENERATION_CR_28 ;  break;
		case 29: min = FW_MIN_REGENERATION_CR_29 ; max = FW_MAX_REGENERATION_CR_29 ;  break;
   		case 30: min = FW_MIN_REGENERATION_CR_30 ; max = FW_MAX_REGENERATION_CR_30 ;  break;		
		
		case 31: min = FW_MIN_REGENERATION_CR_31 ; max = FW_MAX_REGENERATION_CR_31 ;  break;
		case 32: min = FW_MIN_REGENERATION_CR_32 ; max = FW_MAX_REGENERATION_CR_32 ;  break;
		case 33: min = FW_MIN_REGENERATION_CR_33 ; max = FW_MAX_REGENERATION_CR_33 ;  break;
   		case 34: min = FW_MIN_REGENERATION_CR_34 ; max = FW_MAX_REGENERATION_CR_34 ;  break;
		case 35: min = FW_MIN_REGENERATION_CR_35 ; max = FW_MAX_REGENERATION_CR_35 ;  break;
		case 36: min = FW_MIN_REGENERATION_CR_36 ; max = FW_MAX_REGENERATION_CR_36 ;  break;
   		case 37: min = FW_MIN_REGENERATION_CR_37 ; max = FW_MAX_REGENERATION_CR_37 ;  break;
		case 38: min = FW_MIN_REGENERATION_CR_38 ; max = FW_MAX_REGENERATION_CR_38 ;  break;
		case 39: min = FW_MIN_REGENERATION_CR_39 ; max = FW_MAX_REGENERATION_CR_39 ;  break;
   		case 40: min = FW_MIN_REGENERATION_CR_40 ; max = FW_MAX_REGENERATION_CR_40 ;  break;
		
		case 41: min = FW_MIN_REGENERATION_CR_41_OR_HIGHER; max = FW_MAX_REGENERATION_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else	  
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyRegeneration (nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses a skill bonus type and amount to be added to an item.
// * Limits for min and max are 1 and 50:  1,2,3,...,50
//
itemproperty FW_Choose_IP_Skill_Bonus (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_SKILL_BONUS == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_SKILL_BONUS_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_SKILL_BONUS_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_SKILL_BONUS_CR_0 ; max = FW_MAX_SKILL_BONUS_CR_0 ;    break;
		
		case 1: min = FW_MIN_SKILL_BONUS_CR_1 ; max = FW_MAX_SKILL_BONUS_CR_1 ;    break;
		case 2: min = FW_MIN_SKILL_BONUS_CR_2 ; max = FW_MAX_SKILL_BONUS_CR_2 ;    break;
		case 3: min = FW_MIN_SKILL_BONUS_CR_3 ; max = FW_MAX_SKILL_BONUS_CR_3 ;    break;
   		case 4: min = FW_MIN_SKILL_BONUS_CR_4 ; max = FW_MAX_SKILL_BONUS_CR_4 ;    break;
		case 5: min = FW_MIN_SKILL_BONUS_CR_5 ; max = FW_MAX_SKILL_BONUS_CR_5 ;    break;
		case 6: min = FW_MIN_SKILL_BONUS_CR_6 ; max = FW_MAX_SKILL_BONUS_CR_6 ;    break;
   		case 7: min = FW_MIN_SKILL_BONUS_CR_7 ; max = FW_MAX_SKILL_BONUS_CR_7 ;    break;
		case 8: min = FW_MIN_SKILL_BONUS_CR_8 ; max = FW_MAX_SKILL_BONUS_CR_8 ;    break;
		case 9: min = FW_MIN_SKILL_BONUS_CR_9 ; max = FW_MAX_SKILL_BONUS_CR_9 ;    break;
   		case 10: min = FW_MIN_SKILL_BONUS_CR_10 ; max = FW_MAX_SKILL_BONUS_CR_10 ; break;
		
		case 11: min = FW_MIN_SKILL_BONUS_CR_11 ; max = FW_MAX_SKILL_BONUS_CR_11 ;  break;
		case 12: min = FW_MIN_SKILL_BONUS_CR_12 ; max = FW_MAX_SKILL_BONUS_CR_12 ;  break;
		case 13: min = FW_MIN_SKILL_BONUS_CR_13 ; max = FW_MAX_SKILL_BONUS_CR_13 ;  break;
   		case 14: min = FW_MIN_SKILL_BONUS_CR_14 ; max = FW_MAX_SKILL_BONUS_CR_14 ;  break;
		case 15: min = FW_MIN_SKILL_BONUS_CR_15 ; max = FW_MAX_SKILL_BONUS_CR_15 ;  break;
		case 16: min = FW_MIN_SKILL_BONUS_CR_16 ; max = FW_MAX_SKILL_BONUS_CR_16 ;  break;
   		case 17: min = FW_MIN_SKILL_BONUS_CR_17 ; max = FW_MAX_SKILL_BONUS_CR_17 ;  break;
		case 18: min = FW_MIN_SKILL_BONUS_CR_18 ; max = FW_MAX_SKILL_BONUS_CR_18 ;  break;
		case 19: min = FW_MIN_SKILL_BONUS_CR_19 ; max = FW_MAX_SKILL_BONUS_CR_19 ;  break;
   		case 20: min = FW_MIN_SKILL_BONUS_CR_20 ; max = FW_MAX_SKILL_BONUS_CR_20 ;  break;
   
   		case 21: min = FW_MIN_SKILL_BONUS_CR_21 ; max = FW_MAX_SKILL_BONUS_CR_21 ;  break;
		case 22: min = FW_MIN_SKILL_BONUS_CR_22 ; max = FW_MAX_SKILL_BONUS_CR_22 ;  break;
		case 23: min = FW_MIN_SKILL_BONUS_CR_23 ; max = FW_MAX_SKILL_BONUS_CR_23 ;  break;
   		case 24: min = FW_MIN_SKILL_BONUS_CR_24 ; max = FW_MAX_SKILL_BONUS_CR_24 ;  break;
		case 25: min = FW_MIN_SKILL_BONUS_CR_25 ; max = FW_MAX_SKILL_BONUS_CR_25 ;  break;
		case 26: min = FW_MIN_SKILL_BONUS_CR_26 ; max = FW_MAX_SKILL_BONUS_CR_26 ;  break;
   		case 27: min = FW_MIN_SKILL_BONUS_CR_27 ; max = FW_MAX_SKILL_BONUS_CR_27 ;  break;
		case 28: min = FW_MIN_SKILL_BONUS_CR_28 ; max = FW_MAX_SKILL_BONUS_CR_28 ;  break;
		case 29: min = FW_MIN_SKILL_BONUS_CR_29 ; max = FW_MAX_SKILL_BONUS_CR_29 ;  break;
   		case 30: min = FW_MIN_SKILL_BONUS_CR_30 ; max = FW_MAX_SKILL_BONUS_CR_30 ;  break;		
		
		case 31: min = FW_MIN_SKILL_BONUS_CR_31 ; max = FW_MAX_SKILL_BONUS_CR_31 ;  break;
		case 32: min = FW_MIN_SKILL_BONUS_CR_32 ; max = FW_MAX_SKILL_BONUS_CR_32 ;  break;
		case 33: min = FW_MIN_SKILL_BONUS_CR_33 ; max = FW_MAX_SKILL_BONUS_CR_33 ;  break;
   		case 34: min = FW_MIN_SKILL_BONUS_CR_34 ; max = FW_MAX_SKILL_BONUS_CR_34 ;  break;
		case 35: min = FW_MIN_SKILL_BONUS_CR_35 ; max = FW_MAX_SKILL_BONUS_CR_35 ;  break;
		case 36: min = FW_MIN_SKILL_BONUS_CR_36 ; max = FW_MAX_SKILL_BONUS_CR_36 ;  break;
   		case 37: min = FW_MIN_SKILL_BONUS_CR_37 ; max = FW_MAX_SKILL_BONUS_CR_37 ;  break;
		case 38: min = FW_MIN_SKILL_BONUS_CR_38 ; max = FW_MAX_SKILL_BONUS_CR_38 ;  break;
		case 39: min = FW_MIN_SKILL_BONUS_CR_39 ; max = FW_MAX_SKILL_BONUS_CR_39 ;  break;
   		case 40: min = FW_MIN_SKILL_BONUS_CR_40 ; max = FW_MAX_SKILL_BONUS_CR_40 ;  break;
		
		case 41: min = FW_MIN_SKILL_BONUS_CR_41_OR_HIGHER; max = FW_MAX_SKILL_BONUS_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else	  
   int nBonus;
   int nSkill;
   if (min < 1)
      min = 1;
   if (min > 50)
      min = 50;
   if (max < 1)
      max = 1;
   if (max > 50)
      max = 50;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }

   int nReRoll = TRUE;
   while (nReRoll)
   {
      // As of 12 May 2008 there are 30 skills in NWN 2. See "skills.2da"
      nSkill = Random (30);
      switch (nSkill)
      {
         // NWN 2 removed the skills: Animal Empathy and Ride. That's what
         // these two checks are for.  Don't change these values.
         // 0 = animal empathy.
         case 0: nReRoll = TRUE;
            break;
         // 28 = ride.
         case 28: nReRoll = TRUE;
            break;

         // If you want to disallow skills, do it here.  I've shown 3 examples
         // of how this is done. change what I've chosen for what you want
         // disallowed.
         /*
         case SKILL_APPRAISE: nReRoll = TRUE;
            break;
         case SKILL_USE_MAGIC_DEVICE: nReRoll = TRUE;
            break;
         case SKILL_TUMBLE: nReRoll = TRUE;
            break;
         */
         //**************************************
         // We found an acceptable spell!!
         // NEVER CHANGE THIS.
         default: nReRoll = FALSE;
            break;
      } // end of switch
   } // end of while
   ipAdd = ItemPropertySkillBonus (nSkill, nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses a random spell school immunity to give to an item.
//
itemproperty FW_Choose_IP_Spell_Immunity_School ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_SPELL_IMMUNITY_SCHOOL == FALSE)
      return ipAdd;
   int nRoll;
   int nSpellSchool;

   nRoll = Random (10);
   switch (nRoll)
   {
      case 0: nSpellSchool = IP_CONST_SPELLSCHOOL_ABJURATION;
         break;
      case 1: nSpellSchool = IP_CONST_SPELLSCHOOL_CONJURATION;
         break;
      case 2: nSpellSchool = IP_CONST_SPELLSCHOOL_DIVINATION;
         break;
      case 3: nSpellSchool = IP_CONST_SPELLSCHOOL_ENCHANTMENT;
         break;
      case 4: nSpellSchool = IP_CONST_SPELLSCHOOL_EVOCATION;
         break;
      case 5: nSpellSchool = IP_CONST_SPELLSCHOOL_ILLUSION;
         break;
      case 6: nSpellSchool = IP_CONST_SPELLSCHOOL_NECROMANCY;
         break;
      case 7: nSpellSchool = IP_CONST_SPELLSCHOOL_TRANSMUTATION;
         break;
      default: break;
   }
   ipAdd = ItemPropertySpellImmunitySchool (nSpellSchool);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses a random specific spell immunity to give to an item.
//
itemproperty FW_Choose_IP_Spell_Immunity_Specific ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_SPELL_IMMUNITY_SPECIFIC == FALSE)
      return ipAdd;
   int nReRoll = TRUE;
   int nSpell;
   while (nReRoll)
   {
      // As of May 12 2008 there are 187 IP_CONST_IMMUNITYSPELL_* to choose.
      nSpell = Random (188);
      switch (nSpell)
      {
        //**************************************
        //
        //  EXCLUDE SPELL IMMUNITY SPECIFIC IN THIS SECTION
        //
        // I gave 3 examples below of how to exclude a spell immunity from being
        // added to an item.  In the examples, if Chain Lightning, Darkness, or
        // dispel magic is rolled as a random specific spell immunity, then the
        // generator re-rolls until a spell that isn't disallowed is found.  If
        // you uncomment this section of code, ALWAYS leave the default alone.
        // The default guarantees that this function doesn't get stuck in a loop
        // forever by setting nReRoll to FALSE.  Don't change it.  Substitute
        // the IP_CONST_IMMUNITYSPELL_* that you do not want to appear in for
        // one of my examples. If you desire to disallow more than 3, then
        // you'll need to make additional case statements like in the examples
        // shown.
        //
        //
        // WARNING: There is a possibility of creating significant lag if you
        //    have a whole lot of disallowed spells with only a couple of
        //    acceptable ones. The reason is the while statement keeps
        //    re-rolling a number between 0 and 187.  It might take it a LONG
        //    time to pick an acceptable spell if you disallow almost everything.
        //    It would be better to rewrite this function a different way if you
        //    are going to disallow more than half of the spells.
        // VITALLY IMPORTANT NOTE: Don't disallow everything or else this will
        //    crash the game because it will get stuck in a loop forever. If you
        //    want to disallow ALL spells from appearing on an item, do so
        //    by setting FW_ALLOW_SPELL_IMMUNITY_SPECIFIC = FALSE;
        /*
        case IP_CONST_IMMUNITYSPELL_CHAIN_LIGHTNING: nReRoll = TRUE;
           break;
        case IP_CONST_IMMUNITYSPELL_DARKNESS: nReRoll = TRUE;
           break;
        case IP_CONST_IMMUNITYSPELL_DISPEL_MAGIC: nReRoll = TRUE;
           break;
        */
        //**************************************
        // We found an acceptable spell!!
        // NEVER TAKE THIS OUT OR YOU'LL CRASH THE GAME
        default: nReRoll = FALSE;
           break;
      } // end of switch
   } // end of while
   ipAdd = ItemPropertySpellImmunitySpecific (nSpell);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses the thieves tools modifier to be added to an item.
// * You can specify the min or max if you want, but any value less than 1 is
// * changed to 1 and any value greater than 12 is changed to 12.
//
itemproperty FW_Choose_IP_Thieves_Tools (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_THIEVES_TOOLS == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_THIEVES_TOOLS_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_THIEVES_TOOLS_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_THIEVES_TOOLS_CR_0 ; max = FW_MAX_THIEVES_TOOLS_CR_0 ;    break;
		
		case 1: min = FW_MIN_THIEVES_TOOLS_CR_1 ; max = FW_MAX_THIEVES_TOOLS_CR_1 ;    break;
		case 2: min = FW_MIN_THIEVES_TOOLS_CR_2 ; max = FW_MAX_THIEVES_TOOLS_CR_2 ;    break;
		case 3: min = FW_MIN_THIEVES_TOOLS_CR_3 ; max = FW_MAX_THIEVES_TOOLS_CR_3 ;    break;
   		case 4: min = FW_MIN_THIEVES_TOOLS_CR_4 ; max = FW_MAX_THIEVES_TOOLS_CR_4 ;    break;
		case 5: min = FW_MIN_THIEVES_TOOLS_CR_5 ; max = FW_MAX_THIEVES_TOOLS_CR_5 ;    break;
		case 6: min = FW_MIN_THIEVES_TOOLS_CR_6 ; max = FW_MAX_THIEVES_TOOLS_CR_6 ;    break;
   		case 7: min = FW_MIN_THIEVES_TOOLS_CR_7 ; max = FW_MAX_THIEVES_TOOLS_CR_7 ;    break;
		case 8: min = FW_MIN_THIEVES_TOOLS_CR_8 ; max = FW_MAX_THIEVES_TOOLS_CR_8 ;    break;
		case 9: min = FW_MIN_THIEVES_TOOLS_CR_9 ; max = FW_MAX_THIEVES_TOOLS_CR_9 ;    break;
   		case 10: min = FW_MIN_THIEVES_TOOLS_CR_10 ; max = FW_MAX_THIEVES_TOOLS_CR_10 ; break;
		
		case 11: min = FW_MIN_THIEVES_TOOLS_CR_11 ; max = FW_MAX_THIEVES_TOOLS_CR_11 ;  break;
		case 12: min = FW_MIN_THIEVES_TOOLS_CR_12 ; max = FW_MAX_THIEVES_TOOLS_CR_12 ;  break;
		case 13: min = FW_MIN_THIEVES_TOOLS_CR_13 ; max = FW_MAX_THIEVES_TOOLS_CR_13 ;  break;
   		case 14: min = FW_MIN_THIEVES_TOOLS_CR_14 ; max = FW_MAX_THIEVES_TOOLS_CR_14 ;  break;
		case 15: min = FW_MIN_THIEVES_TOOLS_CR_15 ; max = FW_MAX_THIEVES_TOOLS_CR_15 ;  break;
		case 16: min = FW_MIN_THIEVES_TOOLS_CR_16 ; max = FW_MAX_THIEVES_TOOLS_CR_16 ;  break;
   		case 17: min = FW_MIN_THIEVES_TOOLS_CR_17 ; max = FW_MAX_THIEVES_TOOLS_CR_17 ;  break;
		case 18: min = FW_MIN_THIEVES_TOOLS_CR_18 ; max = FW_MAX_THIEVES_TOOLS_CR_18 ;  break;
		case 19: min = FW_MIN_THIEVES_TOOLS_CR_19 ; max = FW_MAX_THIEVES_TOOLS_CR_19 ;  break;
   		case 20: min = FW_MIN_THIEVES_TOOLS_CR_20 ; max = FW_MAX_THIEVES_TOOLS_CR_20 ;  break;
   
   		case 21: min = FW_MIN_THIEVES_TOOLS_CR_21 ; max = FW_MAX_THIEVES_TOOLS_CR_21 ;  break;
		case 22: min = FW_MIN_THIEVES_TOOLS_CR_22 ; max = FW_MAX_THIEVES_TOOLS_CR_22 ;  break;
		case 23: min = FW_MIN_THIEVES_TOOLS_CR_23 ; max = FW_MAX_THIEVES_TOOLS_CR_23 ;  break;
   		case 24: min = FW_MIN_THIEVES_TOOLS_CR_24 ; max = FW_MAX_THIEVES_TOOLS_CR_24 ;  break;
		case 25: min = FW_MIN_THIEVES_TOOLS_CR_25 ; max = FW_MAX_THIEVES_TOOLS_CR_25 ;  break;
		case 26: min = FW_MIN_THIEVES_TOOLS_CR_26 ; max = FW_MAX_THIEVES_TOOLS_CR_26 ;  break;
   		case 27: min = FW_MIN_THIEVES_TOOLS_CR_27 ; max = FW_MAX_THIEVES_TOOLS_CR_27 ;  break;
		case 28: min = FW_MIN_THIEVES_TOOLS_CR_28 ; max = FW_MAX_THIEVES_TOOLS_CR_28 ;  break;
		case 29: min = FW_MIN_THIEVES_TOOLS_CR_29 ; max = FW_MAX_THIEVES_TOOLS_CR_29 ;  break;
   		case 30: min = FW_MIN_THIEVES_TOOLS_CR_30 ; max = FW_MAX_THIEVES_TOOLS_CR_30 ;  break;		
		
		case 31: min = FW_MIN_THIEVES_TOOLS_CR_31 ; max = FW_MAX_THIEVES_TOOLS_CR_31 ;  break;
		case 32: min = FW_MIN_THIEVES_TOOLS_CR_32 ; max = FW_MAX_THIEVES_TOOLS_CR_32 ;  break;
		case 33: min = FW_MIN_THIEVES_TOOLS_CR_33 ; max = FW_MAX_THIEVES_TOOLS_CR_33 ;  break;
   		case 34: min = FW_MIN_THIEVES_TOOLS_CR_34 ; max = FW_MAX_THIEVES_TOOLS_CR_34 ;  break;
		case 35: min = FW_MIN_THIEVES_TOOLS_CR_35 ; max = FW_MAX_THIEVES_TOOLS_CR_35 ;  break;
		case 36: min = FW_MIN_THIEVES_TOOLS_CR_36 ; max = FW_MAX_THIEVES_TOOLS_CR_36 ;  break;
   		case 37: min = FW_MIN_THIEVES_TOOLS_CR_37 ; max = FW_MAX_THIEVES_TOOLS_CR_37 ;  break;
		case 38: min = FW_MIN_THIEVES_TOOLS_CR_38 ; max = FW_MAX_THIEVES_TOOLS_CR_38 ;  break;
		case 39: min = FW_MIN_THIEVES_TOOLS_CR_39 ; max = FW_MAX_THIEVES_TOOLS_CR_39 ;  break;
   		case 40: min = FW_MIN_THIEVES_TOOLS_CR_40 ; max = FW_MAX_THIEVES_TOOLS_CR_40 ;  break;
		
		case 41: min = FW_MIN_THIEVES_TOOLS_CR_41_OR_HIGHER; max = FW_MAX_THIEVES_TOOLS_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch 	  
   } // end of else	  
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 12)
      min = 12;
   if (max < 1)
      max = 1;
   if (max > 12)
      max = 12;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyThievesTools(nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that returns the item property true seeing only
// * if true seeing is an allowed property.
//
itemproperty FW_Choose_IP_True_Seeing ()
{

   itemproperty ipAdd;
   if (FW_ALLOW_TRUE_SEEING == FALSE)
      return ipAdd;
   
   ipAdd = ItemPropertyTrueSeeing();
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses a random amount of turn resistance to be added to an
// * item. Limits for min and max are 1 and 50:  1,2,3,...,50
//
itemproperty FW_Choose_IP_Turn_Resistance (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_TURN_RESISTANCE == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_TURN_RESISTANCE_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_TURN_RESISTANCE_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_TURN_RESISTANCE_CR_0 ; max = FW_MAX_TURN_RESISTANCE_CR_0 ;    break;
		
		case 1: min = FW_MIN_TURN_RESISTANCE_CR_1 ; max = FW_MAX_TURN_RESISTANCE_CR_1 ;    break;
		case 2: min = FW_MIN_TURN_RESISTANCE_CR_2 ; max = FW_MAX_TURN_RESISTANCE_CR_2 ;    break;
		case 3: min = FW_MIN_TURN_RESISTANCE_CR_3 ; max = FW_MAX_TURN_RESISTANCE_CR_3 ;    break;
   		case 4: min = FW_MIN_TURN_RESISTANCE_CR_4 ; max = FW_MAX_TURN_RESISTANCE_CR_4 ;    break;
		case 5: min = FW_MIN_TURN_RESISTANCE_CR_5 ; max = FW_MAX_TURN_RESISTANCE_CR_5 ;    break;
		case 6: min = FW_MIN_TURN_RESISTANCE_CR_6 ; max = FW_MAX_TURN_RESISTANCE_CR_6 ;    break;
   		case 7: min = FW_MIN_TURN_RESISTANCE_CR_7 ; max = FW_MAX_TURN_RESISTANCE_CR_7 ;    break;
		case 8: min = FW_MIN_TURN_RESISTANCE_CR_8 ; max = FW_MAX_TURN_RESISTANCE_CR_8 ;    break;
		case 9: min = FW_MIN_TURN_RESISTANCE_CR_9 ; max = FW_MAX_TURN_RESISTANCE_CR_9 ;    break;
   		case 10: min = FW_MIN_TURN_RESISTANCE_CR_10 ; max = FW_MAX_TURN_RESISTANCE_CR_10 ; break;
		
		case 11: min = FW_MIN_TURN_RESISTANCE_CR_11 ; max = FW_MAX_TURN_RESISTANCE_CR_11 ;  break;
		case 12: min = FW_MIN_TURN_RESISTANCE_CR_12 ; max = FW_MAX_TURN_RESISTANCE_CR_12 ;  break;
		case 13: min = FW_MIN_TURN_RESISTANCE_CR_13 ; max = FW_MAX_TURN_RESISTANCE_CR_13 ;  break;
   		case 14: min = FW_MIN_TURN_RESISTANCE_CR_14 ; max = FW_MAX_TURN_RESISTANCE_CR_14 ;  break;
		case 15: min = FW_MIN_TURN_RESISTANCE_CR_15 ; max = FW_MAX_TURN_RESISTANCE_CR_15 ;  break;
		case 16: min = FW_MIN_TURN_RESISTANCE_CR_16 ; max = FW_MAX_TURN_RESISTANCE_CR_16 ;  break;
   		case 17: min = FW_MIN_TURN_RESISTANCE_CR_17 ; max = FW_MAX_TURN_RESISTANCE_CR_17 ;  break;
		case 18: min = FW_MIN_TURN_RESISTANCE_CR_18 ; max = FW_MAX_TURN_RESISTANCE_CR_18 ;  break;
		case 19: min = FW_MIN_TURN_RESISTANCE_CR_19 ; max = FW_MAX_TURN_RESISTANCE_CR_19 ;  break;
   		case 20: min = FW_MIN_TURN_RESISTANCE_CR_20 ; max = FW_MAX_TURN_RESISTANCE_CR_20 ;  break;
   
   		case 21: min = FW_MIN_TURN_RESISTANCE_CR_21 ; max = FW_MAX_TURN_RESISTANCE_CR_21 ;  break;
		case 22: min = FW_MIN_TURN_RESISTANCE_CR_22 ; max = FW_MAX_TURN_RESISTANCE_CR_22 ;  break;
		case 23: min = FW_MIN_TURN_RESISTANCE_CR_23 ; max = FW_MAX_TURN_RESISTANCE_CR_23 ;  break;
   		case 24: min = FW_MIN_TURN_RESISTANCE_CR_24 ; max = FW_MAX_TURN_RESISTANCE_CR_24 ;  break;
		case 25: min = FW_MIN_TURN_RESISTANCE_CR_25 ; max = FW_MAX_TURN_RESISTANCE_CR_25 ;  break;
		case 26: min = FW_MIN_TURN_RESISTANCE_CR_26 ; max = FW_MAX_TURN_RESISTANCE_CR_26 ;  break;
   		case 27: min = FW_MIN_TURN_RESISTANCE_CR_27 ; max = FW_MAX_TURN_RESISTANCE_CR_27 ;  break;
		case 28: min = FW_MIN_TURN_RESISTANCE_CR_28 ; max = FW_MAX_TURN_RESISTANCE_CR_28 ;  break;
		case 29: min = FW_MIN_TURN_RESISTANCE_CR_29 ; max = FW_MAX_TURN_RESISTANCE_CR_29 ;  break;
   		case 30: min = FW_MIN_TURN_RESISTANCE_CR_30 ; max = FW_MAX_TURN_RESISTANCE_CR_30 ;  break;		
		
		case 31: min = FW_MIN_TURN_RESISTANCE_CR_31 ; max = FW_MAX_TURN_RESISTANCE_CR_31 ;  break;
		case 32: min = FW_MIN_TURN_RESISTANCE_CR_32 ; max = FW_MAX_TURN_RESISTANCE_CR_32 ;  break;
		case 33: min = FW_MIN_TURN_RESISTANCE_CR_33 ; max = FW_MAX_TURN_RESISTANCE_CR_33 ;  break;
   		case 34: min = FW_MIN_TURN_RESISTANCE_CR_34 ; max = FW_MAX_TURN_RESISTANCE_CR_34 ;  break;
		case 35: min = FW_MIN_TURN_RESISTANCE_CR_35 ; max = FW_MAX_TURN_RESISTANCE_CR_35 ;  break;
		case 36: min = FW_MIN_TURN_RESISTANCE_CR_36 ; max = FW_MAX_TURN_RESISTANCE_CR_36 ;  break;
   		case 37: min = FW_MIN_TURN_RESISTANCE_CR_37 ; max = FW_MAX_TURN_RESISTANCE_CR_37 ;  break;
		case 38: min = FW_MIN_TURN_RESISTANCE_CR_38 ; max = FW_MAX_TURN_RESISTANCE_CR_38 ;  break;
		case 39: min = FW_MIN_TURN_RESISTANCE_CR_39 ; max = FW_MAX_TURN_RESISTANCE_CR_39 ;  break;
   		case 40: min = FW_MIN_TURN_RESISTANCE_CR_40 ; max = FW_MAX_TURN_RESISTANCE_CR_40 ;  break;
		
		case 41: min = FW_MIN_TURN_RESISTANCE_CR_41_OR_HIGHER; max = FW_MAX_TURN_RESISTANCE_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else	  
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 50)
      min = 50;
   if (max < 1)
      max = 1;
   if (max > 50)
      max = 50;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyTurnResistance (nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses the unlimited ammo item property and also the amount
// * (if any) of extra damage that will be done.
//
itemproperty FW_Choose_IP_Unlimited_Ammo ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_UNLIMITED_AMMO == FALSE)
      return ipAdd;
   int nAmmoDamage;
   int nRoll = Random (9);
   switch (nRoll)
   {
      case 0: nAmmoDamage = IP_CONST_UNLIMITEDAMMO_BASIC;
         break;
      case 1: nAmmoDamage = IP_CONST_UNLIMITEDAMMO_PLUS1;
         break;
      case 2: nAmmoDamage = IP_CONST_UNLIMITEDAMMO_PLUS2;
         break;
      case 3: nAmmoDamage = IP_CONST_UNLIMITEDAMMO_PLUS3;
         break;
      case 4: nAmmoDamage = IP_CONST_UNLIMITEDAMMO_1D6COLD;
         break;
      case 5: nAmmoDamage = IP_CONST_UNLIMITEDAMMO_1D6FIRE;
         break;
      case 6: nAmmoDamage = IP_CONST_UNLIMITEDAMMO_1D6LIGHT;
         break;
      case 7: nAmmoDamage = IP_CONST_UNLIMITEDAMMO_PLUS4;
         break;
      case 8: nAmmoDamage = IP_CONST_UNLIMITEDAMMO_PLUS5;
         break;
   }
   ipAdd = ItemPropertyUnlimitedAmmo (nAmmoDamage);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that chooses a vampiric regeneration bonus that an item can have.
// * Limits for min and max are positive integers: 1,2,3,...,20
//
itemproperty FW_Choose_IP_Vampiric_Regeneration (int nCR = 0)
{
   itemproperty ipAdd;
   if (FW_ALLOW_VAMPIRIC_REGENERATION == FALSE)
      return ipAdd;
	  
   int min;
   int max;
   if (FW_ALLOW_FORMULA_BASED_CR_SCALING == TRUE)
   {   		
		max = FloatToInt(nCR * FW_MAX_VAMPIRIC_REGENERATION_MODIFIER) + 1;
		min = FloatToInt(nCR * FW_MIN_VAMPIRIC_REGENERATION_MODIFIER) + 1;
   }
   else
   { 
   switch (nCR)
   {
		case 0: min = FW_MIN_VAMPIRIC_REGENERATION_CR_0 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_0 ;    break;
		
		case 1: min = FW_MIN_VAMPIRIC_REGENERATION_CR_1 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_1 ;    break;
		case 2: min = FW_MIN_VAMPIRIC_REGENERATION_CR_2 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_2 ;    break;
		case 3: min = FW_MIN_VAMPIRIC_REGENERATION_CR_3 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_3 ;    break;
   		case 4: min = FW_MIN_VAMPIRIC_REGENERATION_CR_4 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_4 ;    break;
		case 5: min = FW_MIN_VAMPIRIC_REGENERATION_CR_5 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_5 ;    break;
		case 6: min = FW_MIN_VAMPIRIC_REGENERATION_CR_6 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_6 ;    break;
   		case 7: min = FW_MIN_VAMPIRIC_REGENERATION_CR_7 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_7 ;    break;
		case 8: min = FW_MIN_VAMPIRIC_REGENERATION_CR_8 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_8 ;    break;
		case 9: min = FW_MIN_VAMPIRIC_REGENERATION_CR_9 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_9 ;    break;
   		case 10: min = FW_MIN_VAMPIRIC_REGENERATION_CR_10 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_10 ; break;
		
		case 11: min = FW_MIN_VAMPIRIC_REGENERATION_CR_11 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_11 ;  break;
		case 12: min = FW_MIN_VAMPIRIC_REGENERATION_CR_12 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_12 ;  break;
		case 13: min = FW_MIN_VAMPIRIC_REGENERATION_CR_13 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_13 ;  break;
   		case 14: min = FW_MIN_VAMPIRIC_REGENERATION_CR_14 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_14 ;  break;
		case 15: min = FW_MIN_VAMPIRIC_REGENERATION_CR_15 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_15 ;  break;
		case 16: min = FW_MIN_VAMPIRIC_REGENERATION_CR_16 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_16 ;  break;
   		case 17: min = FW_MIN_VAMPIRIC_REGENERATION_CR_17 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_17 ;  break;
		case 18: min = FW_MIN_VAMPIRIC_REGENERATION_CR_18 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_18 ;  break;
		case 19: min = FW_MIN_VAMPIRIC_REGENERATION_CR_19 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_19 ;  break;
   		case 20: min = FW_MIN_VAMPIRIC_REGENERATION_CR_20 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_20 ;  break;
   
   		case 21: min = FW_MIN_VAMPIRIC_REGENERATION_CR_21 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_21 ;  break;
		case 22: min = FW_MIN_VAMPIRIC_REGENERATION_CR_22 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_22 ;  break;
		case 23: min = FW_MIN_VAMPIRIC_REGENERATION_CR_23 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_23 ;  break;
   		case 24: min = FW_MIN_VAMPIRIC_REGENERATION_CR_24 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_24 ;  break;
		case 25: min = FW_MIN_VAMPIRIC_REGENERATION_CR_25 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_25 ;  break;
		case 26: min = FW_MIN_VAMPIRIC_REGENERATION_CR_26 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_26 ;  break;
   		case 27: min = FW_MIN_VAMPIRIC_REGENERATION_CR_27 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_27 ;  break;
		case 28: min = FW_MIN_VAMPIRIC_REGENERATION_CR_28 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_28 ;  break;
		case 29: min = FW_MIN_VAMPIRIC_REGENERATION_CR_29 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_29 ;  break;
   		case 30: min = FW_MIN_VAMPIRIC_REGENERATION_CR_30 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_30 ;  break;		
		
		case 31: min = FW_MIN_VAMPIRIC_REGENERATION_CR_31 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_31 ;  break;
		case 32: min = FW_MIN_VAMPIRIC_REGENERATION_CR_32 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_32 ;  break;
		case 33: min = FW_MIN_VAMPIRIC_REGENERATION_CR_33 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_33 ;  break;
   		case 34: min = FW_MIN_VAMPIRIC_REGENERATION_CR_34 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_34 ;  break;
		case 35: min = FW_MIN_VAMPIRIC_REGENERATION_CR_35 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_35 ;  break;
		case 36: min = FW_MIN_VAMPIRIC_REGENERATION_CR_36 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_36 ;  break;
   		case 37: min = FW_MIN_VAMPIRIC_REGENERATION_CR_37 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_37 ;  break;
		case 38: min = FW_MIN_VAMPIRIC_REGENERATION_CR_38 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_38 ;  break;
		case 39: min = FW_MIN_VAMPIRIC_REGENERATION_CR_39 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_39 ;  break;
   		case 40: min = FW_MIN_VAMPIRIC_REGENERATION_CR_40 ; max = FW_MAX_VAMPIRIC_REGENERATION_CR_40 ;  break;
		
		case 41: min = FW_MIN_VAMPIRIC_REGENERATION_CR_41_OR_HIGHER; max = FW_MAX_VAMPIRIC_REGENERATION_CR_41_OR_HIGHER;  break;
		
		default: break; 
   } // end of switch	  
   } // end of else	  
   int nBonus;
   if (min < 1)
      min = 1;
   if (min > 20)
      min = 20;
   if (max < 1)
      max = 1;
   if (max > 20)
      max = 20;
   // This check is to stop people who inadvertently place a larger value on
   // the max than they have on the min.
   if (min > max)
      {  nBonus = 1;  }
   else if (min == max)
      {  nBonus = min;  }
   else
   {
      int nValue = max - min + 1;
      nBonus = Random(nValue)+ min;
   }
   ipAdd = ItemPropertyVampiricRegeneration (nBonus);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a weight increase to be added to an item
// * from the IP_CONST_WEIGHTINCREASE_* values.  Possible return values are: 5,
// * 10, 15, 30, 50, and 100 pounds.
//
itemproperty FW_Choose_IP_Weight_Increase ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_WEIGHT_INCREASE == FALSE)
      return ipAdd;
   int nWeight;
   int nRoll = Random (6);
   switch (nRoll)
   {
      case 0: nWeight = IP_CONST_WEIGHTINCREASE_5_LBS;
         break;
      case 1: nWeight = IP_CONST_WEIGHTINCREASE_10_LBS;
         break;
      case 2: nWeight = IP_CONST_WEIGHTINCREASE_15_LBS;
         break;
      case 3: nWeight = IP_CONST_WEIGHTINCREASE_30_LBS;
         break;
      case 4: nWeight = IP_CONST_WEIGHTINCREASE_50_LBS;
         break;
      case 5: nWeight = IP_CONST_WEIGHTINCREASE_100_LBS;
         break;
      default: break;
   }
   ipAdd = ItemPropertyWeightIncrease (nWeight);
   return ipAdd;
}

////////////////////////////////////////////
// * Function that randomly chooses a weight reduction % to be added to an item.
// * Possible return values are: 10%, 20%, 40%, 60%, and 80%.
//
// Mustang modification to limit to 60%.
itemproperty FW_Choose_IP_Weight_Reduction ()
{
   itemproperty ipAdd;
   if (FW_ALLOW_WEIGHT_REDUCTION == FALSE)
      return ipAdd;
   int nWeight;
   int nRoll = Random (2);//(5);
   switch (nRoll)
   {
      //case 0: nWeight = IP_CONST_REDUCEDWEIGHT_10_PERCENT;
      //   break;
      //case 1: nWeight = IP_CONST_REDUCEDWEIGHT_20_PERCENT;
      //   break;
      //case 2: nWeight = IP_CONST_REDUCEDWEIGHT_40_PERCENT;
      //   break;
      case 0: nWeight = IP_CONST_REDUCEDWEIGHT_60_PERCENT;
         break;
      case 1: nWeight = IP_CONST_REDUCEDWEIGHT_80_PERCENT;
         break;
      default: break;
   }
   ipAdd = ItemPropertyWeightReduction (nWeight);
   return ipAdd;
}
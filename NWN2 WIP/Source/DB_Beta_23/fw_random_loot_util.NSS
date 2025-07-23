/////////////////////////////////////////////
// *
// * Created by Chris Whitaker
// * Date: 20 Feb 2011
// *
// * This file is a simple utility interface for
// * testing the random loot system output.
//////////////////////////////////////////////

// *****************************************
//
//              INCLUDED FILES
//
// *****************************************
#include "fw_random_loot_core"
#include "fw_inc_misc"
#include "nw_i0_plot"

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
// * This function will create an item on oTarget, log it to oTarget and then destoy it
// * its just for testing
void FW_FakeGenerateLogAndDestroy(object oTarget, int nCR = 0);

void FW_FakeGenerateLogAndDestroy(object oTarget, int nCR = 0)
{
   int nStartGold = GetGold(oTarget);
   struct MyStruct strStruct = FW_CompleteRandomLootGeneration(oTarget, strStruct, nCR);
   string msg = "Random Loot: CR=" + IntToString(nCR) + " value=";
   if (strStruct.nLootType == FW_MISC_GOLD) {
     int nGoldGiven = GetGold(oTarget) - nStartGold;
     msg += IntToString(nGoldGiven) + " Name: Gold ";
	 // how retarded.... this function fails unless on a trigger event.
	 // oh well it is only a test util and only bound in by devs testing the system
	 TakeGold(nGoldGiven, oTarget);
   }
   else {
     msg += IntToString(GetGoldPieceValue(strStruct.oItem)) +" Name: " + GetName(strStruct.oItem) + " ";
     
   }
   itemproperty ipLoop=GetFirstItemProperty(strStruct.oItem);
   //Loop for as long as the ipLoop variable is valid
   while (GetIsItemPropertyValid(ipLoop))
   {
      switch(GetItemPropertyType(ipLoop))
	  {
         case ITEM_PROPERTY_ABILITY_BONUS : msg += "ITEM_PROPERTY_ABILITY_BONUS"; break;
         case ITEM_PROPERTY_AC_BONUS : msg += "ITEM_PROPERTY_AC_BONUS"; break;
         case ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP : msg += "ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP"; break;
         case ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE : msg += "ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE"; break;
         case ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP : msg += "ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP"; break;
         case ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT : msg += "ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT"; break;
         case ITEM_PROPERTY_ARCANE_SPELL_FAILURE : msg += "ITEM_PROPERTY_ARCANE_SPELL_FAILURE"; break;
         case ITEM_PROPERTY_ATTACK_BONUS : msg += "ITEM_PROPERTY_ATTACK_BONUS"; break;
         case ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP : msg += "ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP"; break;
         case ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP : msg += "ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP"; break;
         case ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT : msg += "ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT"; break;
         case ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION : msg += "ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION"; break;
         case ITEM_PROPERTY_BONUS_FEAT : msg += "ITEM_PROPERTY_BONUS_FEAT"; break;
         case ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N : msg += "ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N"; break;
         case ITEM_PROPERTY_CAST_SPELL : msg += "ITEM_PROPERTY_CAST_SPELL"; break;
         case ITEM_PROPERTY_DAMAGE_BONUS : msg += "ITEM_PROPERTY_DAMAGE_BONUS"; break;
         case ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP : msg += "ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP"; break;
         case ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP : msg += "ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP"; break;
         case ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT : msg += "ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT"; break;
         case ITEM_PROPERTY_DAMAGE_REDUCTION : msg += "ITEM_PROPERTY_DAMAGE_REDUCTION"; break; 
         case ITEM_PROPERTY_DAMAGE_RESISTANCE : msg += "ITEM_PROPERTY_DAMAGE_RESISTANCE"; break; 
         case ITEM_PROPERTY_DAMAGE_VULNERABILITY : msg += "ITEM_PROPERTY_DAMAGE_VULNERABILITY"; break; 
         case ITEM_PROPERTY_DARKVISION : msg += "ITEM_PROPERTY_DARKVISION"; break; 
         case ITEM_PROPERTY_DECREASED_ABILITY_SCORE : msg += "ITEM_PROPERTY_DECREASED_ABILITY_SCORE"; break; 
         case ITEM_PROPERTY_DECREASED_AC : msg += "ITEM_PROPERTY_DECREASED_AC"; break; 
         case ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER : msg += "ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER"; break; 
         case ITEM_PROPERTY_DECREASED_DAMAGE : msg += "ITEM_PROPERTY_DECREASED_DAMAGE"; break; 
         case ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER : msg += "ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER"; break; 
         case ITEM_PROPERTY_DECREASED_SAVING_THROWS : msg += "ITEM_PROPERTY_DECREASED_SAVING_THROWS"; break; 
         case ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC : msg += "ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC"; break; 
         case ITEM_PROPERTY_DECREASED_SKILL_MODIFIER : msg += "ITEM_PROPERTY_DECREASED_SKILL_MODIFIER"; break; 
         case ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT : msg += "ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT"; break; 
         case ITEM_PROPERTY_ENHANCEMENT_BONUS : msg += "ITEM_PROPERTY_ENHANCEMENT_BONUS"; break; 
         case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP : msg += "ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP"; break; 
         case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP : msg += "ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP"; break; 
         case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT : msg += "ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT"; break; 
         case ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE : msg += "ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE"; break; 
         case ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE : msg += "ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE"; break; 
         case ITEM_PROPERTY_FREEDOM_OF_MOVEMENT : msg += "ITEM_PROPERTY_FREEDOM_OF_MOVEMENT"; break; 
         case ITEM_PROPERTY_HASTE : msg += "ITEM_PROPERTY_HASTE"; break; 
         case ITEM_PROPERTY_HEALERS_KIT : msg += "ITEM_PROPERTY_HEALERS_KIT"; break; 
         case ITEM_PROPERTY_HOLY_AVENGER : msg += "ITEM_PROPERTY_HOLY_AVENGER"; break; 
         case ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE : msg += "ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE"; break; 
         case ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS : msg += "ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS"; break; 
         case ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL : msg += "ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL"; break; 
         case ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL : msg += "ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL"; break; 
         case ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL : msg += "ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL"; break; 
         case ITEM_PROPERTY_IMPROVED_EVASION : msg += "ITEM_PROPERTY_IMPROVED_EVASION"; break; 
         case ITEM_PROPERTY_KEEN : msg += "ITEM_PROPERTY_KEEN"; break; 
         case ITEM_PROPERTY_LIGHT : msg += "ITEM_PROPERTY_LIGHT"; break; 
         case ITEM_PROPERTY_MASSIVE_CRITICALS : msg += "ITEM_PROPERTY_MASSIVE_CRITICALS"; break; 
         case ITEM_PROPERTY_MIGHTY : msg += "ITEM_PROPERTY_MIGHTY"; break; 
         case ITEM_PROPERTY_MIND_BLANK : msg += "ITEM_PROPERTY_MIND_BLANK"; break; 
         case ITEM_PROPERTY_MONSTER_DAMAGE : msg += "ITEM_PROPERTY_MONSTER_DAMAGE"; break; 
         case ITEM_PROPERTY_NO_DAMAGE : msg += "ITEM_PROPERTY_NO_DAMAGE"; break; 
         case ITEM_PROPERTY_ON_HIT_PROPERTIES : msg += "ITEM_PROPERTY_ON_HIT_PROPERTIES"; break; 
         case ITEM_PROPERTY_ON_MONSTER_HIT : msg += "ITEM_PROPERTY_ON_MONSTER_HIT"; break; 
         case ITEM_PROPERTY_ONHITCASTSPELL : msg += "ITEM_PROPERTY_ONHITCASTSPELL"; break; 
         case ITEM_PROPERTY_POISON : msg += "ITEM_PROPERTY_POISON"; break; 
         case ITEM_PROPERTY_REGENERATION : msg += "ITEM_PROPERTY_REGENERATION"; break; 
         case ITEM_PROPERTY_REGENERATION_VAMPIRIC : msg += "ITEM_PROPERTY_REGENERATION_VAMPIRIC"; break; 
         case ITEM_PROPERTY_SAVING_THROW_BONUS : msg += "ITEM_PROPERTY_SAVING_THROW_BONUS"; break; 
         case ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC : msg += "ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC"; break;  
         case ITEM_PROPERTY_SKILL_BONUS : msg += "ITEM_PROPERTY_SKILL_BONUS"; break;  
         case ITEM_PROPERTY_SPECIAL_WALK : msg += "ITEM_PROPERTY_SPECIAL_WALK"; break;  
         case ITEM_PROPERTY_SPELL_RESISTANCE : msg += "ITEM_PROPERTY_SPELL_RESISTANCE"; break;  
         case ITEM_PROPERTY_THIEVES_TOOLS : msg += "ITEM_PROPERTY_THIEVES_TOOLS"; break;  
         case ITEM_PROPERTY_TRAP : msg += "ITEM_PROPERTY_TRAP"; break;  
         case ITEM_PROPERTY_TRUE_SEEING : msg += "ITEM_PROPERTY_TRUE_SEEING"; break;  
         case ITEM_PROPERTY_TURN_RESISTANCE : msg += "ITEM_PROPERTY_TURN_RESISTANCE"; break;  
         case ITEM_PROPERTY_UNLIMITED_AMMUNITION : msg += "ITEM_PROPERTY_UNLIMITED_AMMUNITION"; break; 
         case ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP : msg += "ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP"; break; 
         case ITEM_PROPERTY_USE_LIMITATION_CLASS : msg += "ITEM_PROPERTY_USE_LIMITATION_CLASS"; break; 
         case ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE : msg += "ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE"; break; 
         case ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT : msg += "ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT"; break; 
        //  case ITEM_PROPERTY_USE_LIMITATION_TILESET : msg += "ITEM_PROPERTY_USE_LIMITATION_TILESET"; break; 
         case ITEM_PROPERTY_VISUALEFFECT : msg += "ITEM_PROPERTY_VISUALEFFECT"; break; 
         case ITEM_PROPERTY_WEIGHT_INCREASE : msg += "ITEM_PROPERTY_WEIGHT_INCREASE"; break; 
         default : msg += "Item Property unknown";
      }

      //Next itemproperty on the list...
      ipLoop=GetNextItemProperty(strStruct.oItem);
   }

   SendMessageToPC(oTarget, msg);
   DestroyObject(strStruct.oItem);
}
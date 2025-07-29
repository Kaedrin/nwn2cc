//-----------------------------------------------------------------------------
//  C Daniel Vale 2007
//  djvale@gmail.com
//
//  C Laurie Vale 2007
//  charlievale@gmail.com
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
//------------------------------------------------------------------------------
//  Script Name: vn_inc_main
//  Description: Generic Functions, useful to anyone.
//------------------------------------------------------------------------------

#include "vn_inc_constants"
#include "vn_pc__inc"

//------------------------------------------------------------------------------
//                     Interface
//------------------------------------------------------------------------------

//------------------- General Calculations -------------------------------------

// Randomise a float!!!!
/* use ginc_math
float RandomFloat(float fNum);
*/

// Level
int GetLevelFromXP(int nXP);
int GetXPFromLevel(int nLevel);

// GetILRByValue: Retern the level required to use an item of value iNewValue.
int GetILRByValue(int iNewValue);

// Min / max 
int GetMin(int a, int b);
int GetMax(int a, int b);

// Generate a random number from nMin to nMax, inclusive
int RandomRange(int nMin, int nMax);


// GetRequiredLoreSkill: Retern the level required to id an item.
int GetRequiredLoreSkill(int nItemValue);

// Produce quotes in strings
// NOTE: For this to work you must set two local variables on the module:
// LeftQuote = ' "'
// RightQuote = '" '
string LQ() { return GetLocalString(GetModule(), "LeftQuote"); }
string RQ() { return GetLocalString(GetModule(), "RightQuote"); }

string BoolToString(int bBool);
//string LocationToString(location lLoc); // already in X0_I0_POSITION

//-----------------------  Items  ----------------------------------------------

// If the item is stackable, returns the max stack size
// if the item is not stackable returns 0 (FALSE)
// Uses CHECK_CHEST to test if an item is stackable
int GetIsStackableItem(object oItem);

// Take nStackSize of sTag from oPC
// if bDestroy the items are destroyed, otherwise they are given to OBJECT_SELF
// on success return TRUE, on error (not enough) return FALSE
int SurrenderItem(object oPC, string sTag, int nStackSize = 1, int bDestroy = TRUE);

// take nGold from oTarget.
// return TRUE on success or FALSE on error (doesn't have enough gold)
int SurrenderGold(object oTarget, int nGold);

// Get the total number of items (including stacked items)
// matching sItemTag, possessed by oPC
int GetNumHeldItems(object oPC, string sItemTag);

// give to oPartyMember nManaEach of sResRef
// (works fine with any item)
void GiveStackable(string sResRef, object oPartyMember, int nManaEach);

// void wrapper for CreateObject
void CreateObjectVoid(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation=FALSE, string sNewTag="");

// CreateItemOnObjectVoid: Void wrapper for CreateItemOnObject so it can be used
// with DelayCommand()
void CreateItemOnObjectVoid(string sItemTemplate, object oTarget=OBJECT_SELF, int nStackSize=1);

// find the gold piece value of nCopies of the item specified by sItemResRef
int GetGoldPieceValueFromResRef(string sItemResRef, int nCopies);


//------------------- Objects --------------------------------------------------

// Destroy a container, and it's inventory 
// Use where destroy object leaves loot you don't want.
void DestroyObjectAndInventory(object oObject);

// Destroy an object, 
// even if set to undestroyable, 
// including its inventory,
// including its whole stack
void ForceDestroyObject(object oObject);

// Find and return an object from oPC's inventory
// returns OBJECT_INVALID if no object has sTag
object GetItemInInventory(object oPC, string sTag);

//--------------------------  Characters  --------------------------------------


// convert a three letter mnemonic into an ability constant
int GetAttribute(string sAttribute);

// Get the characters level from their xp total, rather than thier current HitDice
int GetTrueLevel(object oPC);

// jump the character to a new location, applying a visual effect at both ends
void Teleport(object oPC, location lDestination);

//-----------------------  Associates  -----------------------------------------

// return the first associate of oPC
object GetFirstAssociate(object oPC);

// return the next associate of oPC
object GetNextAssociate(object oPC);

// Jump all of oPC's associates to lDest
void JumpAssociates(object oPC, location lDest);

// Jump the associates of type nAssociateType of oPC to lDest
void JumpAssociateType(int nAssociateType, object oPC, location lDest);



//------------------- Parties --------------------------------------------------

struct party_data
{
	object oLeader;
	int nMaxLevel;
	int nMinLevel;
	int nAverageLevel;
	float fWeightedAverageLevel;
	int nTotalLevel;
	int nPartySize;
};

// Get the partie's leader, highest level, lowest level, average level, 
// weighted average level, total levels and number of PCs, in one go.
// (It is usually more efficient to get everthing at once, to save looping
// through the party several times.)
// TODO add the bInArea parameter
// oPC - a member of the party
struct party_data GetPartyData(object oPC);

int GetPartySize(object oPC, int bInArea = TRUE);
// Get the total number of party members
// oPC - a member of the party
// bInArea - if TRUE, then restrict the test to party members in the same
//           area as oPC. Ignored if FALSE.

int GetPartyAverageLevel(object oPC, int bInArea = TRUE);
// uses get true level to determine party average level based on xp,
// (not current HitDice)
// oPC - a member of the party
// bInArea - if TRUE, then restrict the test to party members in the same
//           area as oPC. Ignored if FALSE.

int GetPartyTotalLevels(object oPC, int bInArea = TRUE);
// uses get true level to determine party average level based on xp
// (not current HitDice)
// oPC - a member of the party
// bInArea - if TRUE, then restrict the test to party members in the same
//           area as oPC. Ignored if FALSE.

int GetPartyHighestLevel(object oPC, int bInArea = TRUE);
// Uses GetTrueLevel to determine the level of the highest level character
// in a party. Minimum return is 1, even if oPC is OBJECT_INVALID
// oPC - a member of the party
// bInArea - if TRUE, then restrict the test to party members in the same
//           area as oPC. Ignored if FALSE.


//------------------------------------------------------------------------------
//                     Implementation
//------------------------------------------------------------------------------

// Generate a random number between 0 and fNum.
// 0 < result <= fNum
/* use ginc_math
float RandomFloat(float fNum)
{
    int nRandom = Random(99999) + 1;
    return IntToFloat(nRandom) * fNum / 99999.0;
}
*/

object GetGlobalObject(string sName)
{
	return GetLocalObject(GetModule(), sName);
}

int GetMin(int a, int b)
{
	if (a > b)
		return b;
		
    return a;
}

int GetMax(int a, int b)
{
	if (a > b)
		return a;
		
	return b;
}

// Generate a random number from nMin to nMax, inclusive
// Precondition nMin <= nMax
int RandomRange(int nMin, int nMax)
{
	return nMin + Random(nMax - nMin + 1);
}

// A bool is just an int, but this makes it prettier.
string BoolToString(int bBool)
{
	if (bBool) 
		return "TRUE";
	else
		return "FALSE";	
}

// Make a printable string from a location
/* already exists in X0_I0_POSITION
string LocationToString(location lLoc)
{
	vector vLoc = GetPositionFromLocation(lLoc);

	string sMsg = 
		LQ() + GetName(GetAreaFromLocation(lLoc)) + RQ() +
		"(" + FloatToString(vLoc.x) + ", " + FloatToString(vLoc.y) + ", " + FloatToString(vLoc.z) + ") : " + 
		FloatToString(GetFacingFromLocation(lLoc));
		
	return sMsg;		
}
*/

int GetLevelFromXP(int nXP)
// return the level that coincides with an experience total of nXP
{

    return FloatToInt((500.0 + sqrt(250000.0 + 2000.0 * IntToFloat(nXP)) ) / 1000.0);

} // get level from xp


int GetXPFromLevel(int nLevel)
{

    // based on sum of series formulae n/2(f+l)
    return (nLevel * (nLevel-1) * 500);

} // get xp from level


int GetAttribute(string sAttribute)
// convert a three letter mnemonic into an ability constant
{

    if (sAttribute == "str") return ABILITY_STRENGTH;
    if (sAttribute == "dex") return ABILITY_DEXTERITY;
    if (sAttribute == "int") return ABILITY_INTELLIGENCE;
    if (sAttribute == "con") return ABILITY_CONSTITUTION;
    if (sAttribute == "wis") return ABILITY_WISDOM;
    if (sAttribute == "cha") return ABILITY_CHARISMA;

    return 0;
} // get attribute


// GetILRByValue: Retern the level required to use an item of value iNewValue.
int GetILRByValue(int iNewValue)
{
    if (iNewValue > 4000000) return 40;
    else if (iNewValue > 3800000) return 39;
    else if (iNewValue > 3600000) return 38;
    else if (iNewValue > 3400000) return 37;
    else if (iNewValue > 3200000) return 36;
    else if (iNewValue > 3000000) return 35;
    else if (iNewValue > 2800000) return 34;
    else if (iNewValue > 2600000) return 33;
    else if (iNewValue > 2400000) return 32;
    else if (iNewValue > 2200000) return 31;
    else if (iNewValue > 2000000) return 30;
    else if (iNewValue > 1800000) return 29;
    else if (iNewValue > 1600000) return 28;
    else if (iNewValue > 1400000) return 27;
    else if (iNewValue > 1200000) return 26;
    else if (iNewValue > 1000000) return 25;
    else if (iNewValue > 750000)  return 24;
    else if (iNewValue > 500000)  return 23;
    else if (iNewValue > 250000)  return 22;
    else if (iNewValue > 130000)  return 21;
    else if (iNewValue > 110000)  return 20;
    else if (iNewValue > 90000)   return 19;
    else if (iNewValue > 75000)   return 18;
    else if (iNewValue > 65000)   return 17;
    else if (iNewValue > 50000)   return 16;
    else if (iNewValue > 40000)   return 15;
    else if (iNewValue > 35000)   return 14;
    else if (iNewValue > 30000)   return 13;
    else if (iNewValue > 25000)   return 12;
    else if (iNewValue > 19500)   return 11;
    else if (iNewValue > 15000)   return 10;
    else if (iNewValue > 12000)   return 9;
    else if (iNewValue > 9000)    return 8;
    else if (iNewValue > 6500)    return 7;
    else if (iNewValue > 5000)    return 6;
    else if (iNewValue > 3500)    return 5;
    else if (iNewValue > 2500)    return 4;
    else if (iNewValue > 1500)    return 3;
    else if (iNewValue > 1000)     return 2;
    else return 1;

} // GetILRByValue


// GetRequiredLoreSkill: Retern the level required to id an item.
int GetRequiredLoreSkill(int nItemValue)
{
    if (nItemValue<=  5 )return 0 ;
    else if (nItemValue<=  10 )return 1 ;
    else if (nItemValue<=  50 )return 2 ;
    else if (nItemValue<=  100 )return 3 ;
    else if (nItemValue<=  150 )return 4 ;
    else if (nItemValue<=  200 )return 5 ;
    else if (nItemValue<=  300 )return 6 ;
    else if (nItemValue<=  400 )return 7 ;
    else if (nItemValue<=  500 )return 8 ;
    else if (nItemValue<=  1000 )return 9 ;
    else if (nItemValue<=  2500 )return 10 ;
    else if (nItemValue<=  3750 )return 11 ;
    else if (nItemValue<=  4800 )return 12 ;
    else if (nItemValue<=  6500 )return 13 ;
    else if (nItemValue<=  9500 )return 14 ;
    else if (nItemValue<=  13000 )return 15 ;
    else if (nItemValue<=  17000 )return 16 ;
    else if (nItemValue<=  20000 )return 17 ;
    else if (nItemValue<=  30000 )return 18 ;
    else if (nItemValue<=  40000 )return 19 ;
    else if (nItemValue<=  50000 )return 20 ;
    else if (nItemValue<=  60000 )return 21 ;
    else if (nItemValue<=  80000 )return 22 ;
    else if (nItemValue<=  100000 )return 23 ;
    else if (nItemValue<=  150000 )return 24 ;
    else if (nItemValue<=  200000 )return 25 ;
    else if (nItemValue<=  250000 )return 26 ;
    else if (nItemValue<=  300000 )return 27 ;
    else if (nItemValue<=  350000 )return 28 ;
    else if (nItemValue<=  400000 )return 29 ;
    else if (nItemValue<=  500000 )return 30 ;
    else if (nItemValue<=  600000 )return 31 ;
    else if (nItemValue<=  700000 )return 32 ;
    else if (nItemValue<=  800000 )return 33 ;
    else if (nItemValue<=  900000 )return 34 ;
    else if (nItemValue<=  1000000 )return 35 ;
    else if (nItemValue<=  1100000 )return 36 ;
    else if (nItemValue<=  1200000 )return 37 ;
    else if (nItemValue<=  1300000 )return 38 ;
    else if (nItemValue<=  1400000 )return 39 ;
    else if (nItemValue<=  1500000 )return 40 ;
    else if (nItemValue<=  1600000 )return 41 ;
    else if (nItemValue<=  1700000 )return 42 ;
    else if (nItemValue<=  1800000 )return 43 ;
    else if (nItemValue<=  1900000 )return 44 ;
    else if (nItemValue<=  2000000 )return 45 ;
    else if (nItemValue<=  2100000 )return 46 ;
    else if (nItemValue<=  2200000 )return 47 ;
    else if (nItemValue<=  2300000 )return 48 ;
    else if (nItemValue<=  2400000 )return 49 ;
    else if (nItemValue<=  2500000 )return 50 ;
    else if (nItemValue<=  2600000 )return 51 ;
    else if (nItemValue<=  3000000 )return 52 ;
    else if (nItemValue<=  5000000 )return 53 ;
    else if (nItemValue<=  6000000 )return 54 ;
    else if (nItemValue<=  9000000 )return 55 ;
    else if (nItemValue<=  12000000 )return 56 ;
    else return 57;

} // GetRequiredLoreSkill

//------------------- Items   --------------------------------------------------

// give to oTarget nToGive of sResRef
void GiveStackable(string sResRef, object oTarget, int nToGive)
{

    int nGiven = 0;
    object oStack;
    for (nGiven = 0; nGiven < nToGive; nGiven++)
    {
        CreateItemOnObject(sResRef, oTarget, 1);
    }


}// give stackable


void CreateObjectVoid(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation=FALSE, string sNewTag="")
// void wrapper for CreateObject
{
    CreateObject(nObjectType, sTemplate, lLocation, bUseAppearAnimation, sNewTag);
}

// CreateItemOnObjectVoid: Void wrapper for CreateItemOnObject so it can be used
// with DelayCommand()
void CreateItemOnObjectVoid(string sItemTemplate, object oTarget=OBJECT_SELF, int nStackSize=1)
{
    CreateItemOnObject(sItemTemplate, oTarget, nStackSize);
}

// Get the total number of items (including stacked items)
// possessed by oPC, matching sItemTag.
int GetNumHeldItems(object oPC, string sItemTag)
{
    int nCopies = 0; // count of copies held
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == sItemTag)
        {
            nCopies += GetNumStackedItems(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
    }
    return nCopies;
}


int SurrenderGold(object oTarget, int nGold)
// take nGold from oTarget.
// return TRUE on success or FALSE on error (doesn't have enough gold)
{
    int nPCGold = GetGold(oTarget);
    if (nGold <= nPCGold)
    {
        TakeGoldFromCreature(nGold, oTarget, TRUE);
        return TRUE;
    }
    return FALSE;
}



int SurrenderItem(object oPC, string sTag, int nStackSize = 1, int bDestroy = TRUE)
// Take nStackSize of sTag from oPC
// if bDestroy the items are destroyed, otherwise they are given to OBJECT_SELF
// on success return TRUE, on error (not enough) return FALSE
{

    if (sTag == "") return TRUE; // surrender nothing
    if (nStackSize < 1) return TRUE; // surrender nothing

    // see how many of sTag oPC has
    int nItemsOnHand = 0;
    object oItem = GetFirstItemInInventory(oPC);
    while (oItem != OBJECT_INVALID)
    {
        if (GetTag(oItem) == sTag)
        {
            nItemsOnHand += GetNumStackedItems(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
    }//while: items

    // is it enough?
    if (nItemsOnHand < nStackSize) return FALSE;

    // take the items
    int nItemsInThisStack;
    int nToTake = nStackSize;
    object oCopy;
    oItem = GetFirstItemInInventory(oPC);
    while (oItem != OBJECT_INVALID && nToTake > 0)
    {
        if (sTag == GetTag(oItem))
        {
            nItemsInThisStack = GetNumStackedItems(oItem);
            if (nItemsInThisStack > nToTake)
            {
                SetItemStackSize(oItem, nItemsInThisStack - nToTake);
                if ( ! bDestroy)
                {
                    oCopy = CopyItem(oItem, OBJECT_SELF, TRUE);
                    SetItemStackSize(oCopy, nToTake);
                }
                nToTake = 0;
            } else {
                nToTake -= nItemsInThisStack;
                if (bDestroy)
                    DestroyObject(oItem);
                else
                    ActionTakeItem(oItem, oPC);
            }
        }
        oItem = GetNextItemInInventory(oPC);
    }

    return TRUE;
}// surredner item




int GetIsStackableItem(object oItem)
// Uses CHECK_CHEST to test if an item is stackable
// If the item is stackable, returns the max stack size
// if the item is not stackable returns 0 (FALSE)
{
    //Must have a chest tagged checkchest
    object oCopy=CopyItem(oItem, GetObjectByTag(CHECK_CHEST));

    //Set the stacksize to maximum
    SetItemStackSize(oCopy, MAX_STACKABLE);

    // Find the number stacked now
    int bStack = GetItemStackSize(oCopy);

    // If the stack size is 1, set it to 0 (FALSE)
    if (bStack == 1) bStack = 0;

    //Destroy the test copy
    DestroyObject(oCopy);

    // Return bStack which is TRUE if item is stackable
    return bStack;
}

// find the gold piece value of nCopies of the item specified by sItemResRef
int GetGoldPieceValueFromResRef(string sItemResRef, int nCopies)
{
    // get the check chest
    object oCheckChest = GetObjectByTag(CHECK_CHEST);

    // make a copy of the item
    object oItem = CreateItemOnObject(sItemResRef, oCheckChest);

    // Get the value of one of the item
    int nGoldPieceValue = GetGoldPieceValue(oItem);

    // Multiply by nCopies
    nGoldPieceValue *= nCopies;

    return nGoldPieceValue;
}


// Find and return an object from oPC's inventory
// returns OBJECT_INVALID if no object has sTag
object GetItemInInventory(object oPC, string sTag)
{
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == sTag) return oItem;
        oItem = GetNextItemInInventory(oPC);
    }
    return OBJECT_INVALID;
}



//------------------- Objects --------------------------------------------------


// Destroy a container, and it's inventory 
// Use where destroy object leaves loot you don't want.
void DestroyObjectAndInventory(object oObject)
{
	if (GetHasInventory(oObject))
	{
		object oItem = GetFirstItemInInventory(oObject);
		while (GetIsObjectValid(oItem))
		{
			// SendMessageToPC(GetFirstPC(), "destroyed " + GetName(oItem));
			ForceDestroyObject(oItem);
			oItem = GetNextItemInInventory(oObject);
		}
	}
	
	// don't use ForceDestroyObject here, or you will create an infinite loop
	DestroyObject (oObject);
}


// Destroy an object, 
// even if set to undestroyable, 
// including its inventory,
// including its whole stack
void ForceDestroyObject(object oObject)
{
	AssignCommand(oObject, SetIsDestroyable(TRUE));
	SetItemStackSize(oObject, 1);
	DestroyObjectAndInventory (oObject);
}


//----------------------- PCs --------------------------------------------------

int GetTrueLevel(object oPC)
// Get the characters level from their xp total, rather than thier current HitDice
{
    int xp = GetXP(oPC);
    return GetLevelFromXP(xp);

}// get true level



// jump the character to a new location, applying a visual effect at both ends
void Teleport(object oPC, location lDestination)
{
	effect eJumpVisual= EffectVisualEffect(VFX_DUR_SOOTHING_LIGHT);
	
	// save the PC's location for a Recall Potion
	if ( ! GetIsObjectValid(GetItemPossessedBy(oPC, DEATH_MARK)))
		SetTokenLocation(oPC, MEMORY_RECALL, GetLocation(oPC));
	
	if (GetAreaFromLocation(lDestination) != GetArea(oPC))
	{
		SetLocalInt(oPC,"Jumping",1);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eJumpVisual,oPC,2.0);
		DelayCommand(2.0,AssignCommand(oPC,JumpToLocation(lDestination)));	
	}
	else
	{
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eJumpVisual,oPC,2.0);
		DelayCommand(2.0,AssignCommand(oPC,JumpToLocation(lDestination)));
		DelayCommand(2.1,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eJumpVisual,oPC,2.0));

	}
	DelayCommand(2.1, JumpAssociates(oPC, lDestination));
}// teleport

//-------------------------  Associates  ---------------------------------------

void JumpAssociateType(int nAssociateType, object oPC, location lDest)
// Jump the associates of type nAssociateType of oPC to lDest

{

    // Ensure the associates go too.
    int nNth = 1;
    object oAssociate = GetAssociate(nAssociateType, oPC, nNth);
    int nMaxAssociate = GetMaxHenchmen();
	// SendMessageToPC(oPC, "Max Henchmen = " + IntToString(nMaxAssociate));
    while (oAssociate != OBJECT_INVALID && nNth <= nMaxAssociate)
    {
        AssignCommand(oAssociate, JumpToLocation(lDest));
		// Teleport(oAssociate);
        nNth++;
        oAssociate = GetAssociate(nAssociateType, oPC, nNth);
    }//while


}// jump associate type

void JumpAssociates(object oPC, location lDest)
// Jump all of oPC's associates to lDest
{
    JumpAssociateType(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC, lDest);
    JumpAssociateType(ASSOCIATE_TYPE_DOMINATED, oPC, lDest);
    JumpAssociateType(ASSOCIATE_TYPE_FAMILIAR, oPC, lDest);
    JumpAssociateType(ASSOCIATE_TYPE_HENCHMAN, oPC, lDest);
    JumpAssociateType(ASSOCIATE_TYPE_SUMMONED, oPC, lDest);
}// jump associates


object GetFirstAssociate(object oPC)
// return the first associate of oPC
{
    object oAssociate;

    oAssociate = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    if ( ! GetIsObjectValid(oAssociate)) oAssociate = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    if ( ! GetIsObjectValid(oAssociate)) oAssociate = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    if ( ! GetIsObjectValid(oAssociate)) oAssociate = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);
    if ( ! GetIsObjectValid(oAssociate)) oAssociate = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);

    if ( ! GetIsObjectValid(oAssociate)) oAssociate = OBJECT_INVALID;

    if (GetIsObjectValid(oAssociate))
    {
        SetLocalInt(oPC, "GetNextAssociate_Type", GetAssociateType(oAssociate));
        SetLocalInt(oPC, "GetNextAssociate_nNth", 1);
    } else {
        DeleteLocalInt(oPC, "GetNextAssociate_Type");
        DeleteLocalInt(oPC, "GetNextAssociate_nNth");
    }

    return oAssociate;
} // get first associate


int GetNextAssociateType(int nType)
{
    if (nType == ASSOCIATE_TYPE_FAMILIAR) return ASSOCIATE_TYPE_ANIMALCOMPANION;
    if (nType == ASSOCIATE_TYPE_ANIMALCOMPANION) return ASSOCIATE_TYPE_DOMINATED;
    if (nType == ASSOCIATE_TYPE_DOMINATED) return ASSOCIATE_TYPE_HENCHMAN;
    if (nType == ASSOCIATE_TYPE_HENCHMAN) return ASSOCIATE_TYPE_SUMMONED;
    return -1;
}

object GetNextAssociate(object oPC)
// return the next associate of oPC
{
    int nType = GetLocalInt(oPC, "GetNextAssociate_Type");
    int nNth = GetLocalInt(oPC, "GetNextAssociate_nNth");

    if (nType == 0 || nNth == 0) return OBJECT_INVALID;

    nNth++;
//    SendMessageToPC(oPC, "nNth = " + IntToString(nNth));

    int nMaxAssociate = GetMaxHenchmen();

    object oAssociate;
    if ((nNth > 1) && (nType != ASSOCIATE_TYPE_HENCHMAN))
        oAssociate = OBJECT_INVALID;
    else
        oAssociate = GetAssociate(nType, oPC, nNth);

    if (nNth > nMaxAssociate) oAssociate = OBJECT_INVALID;

    // if there are no more associates of nType, try the other types
    while ( ( ! GetIsObjectValid(oAssociate)) && (nType != -1) )
    {
        nNth = 1;
        nType = GetNextAssociateType(nType);
//        SendMessageToPC(oPC, "Try Associate type: " + IntToString(nType));
        if (nType != -1)
            oAssociate = GetAssociate(nType, oPC, nNth);
        else
            oAssociate = OBJECT_INVALID;
    }

//    SendMessageToPC(oPC, "Associate type: " + IntToString(nType));

    if (GetIsObjectValid(oAssociate))
    {
        SetLocalInt(oPC, "GetNextAssociate_Type", GetAssociateType(oAssociate));
        SetLocalInt(oPC, "GetNextAssociate_nNth", nNth);
    } else {
        DeleteLocalInt(oPC, "GetNextAssociate_Type");
        DeleteLocalInt(oPC, "GetNextAssociate_nNth");
    }

    return oAssociate;
} // get next associate

//------------------- Parties --------------------------------------------------

/*
struct party_data
{
	object oLeader;
	int nMaxLevel;
	int nMinLevel;
	int nAverageLevel;
	int fWeightedAverageLevel;
	int nTotalLevel;
	int nPartySize;
}
*/

// Rather than doing the party loop to get each peice of information,
// get it all in one go!
struct party_data GetPartyData(object oPC)
{
	struct party_data pdParty;
	int nHitDice;
	int nSumSquares = 0;
	
	pdParty.oLeader = GetFactionLeader(oPC);
	
	pdParty.nTotalLevel = 0;
	pdParty.nPartySize = 0;

	object oParty = GetFirstFactionMember(oPC);
	while (GetIsObjectValid(oParty))
	{
		nHitDice = GetHitDice(oParty);
		pdParty.nMaxLevel = GetMax( pdParty.nMaxLevel, nHitDice );
		pdParty.nMinLevel = GetMin( pdParty.nMinLevel, nHitDice );
		pdParty.nTotalLevel += nHitDice;
		pdParty.nPartySize++;
		
		nSumSquares += nHitDice * nHitDice;
		
		oParty = GetNextFactionMember(oPC);
	}
	
	if (pdParty.nPartySize > 0)
	{
		pdParty.nAverageLevel = pdParty.nTotalLevel / pdParty.nPartySize;
		pdParty.fWeightedAverageLevel = IntToFloat(nSumSquares) / IntToFloat(pdParty.nTotalLevel);
	}
	else	
	{
		pdParty.nAverageLevel = 0;
		pdParty.fWeightedAverageLevel = 0.0;
	}
		
			
	
	return pdParty;
}

int GetPartySize(object oPC, int bInArea = TRUE)
// Get the party total number of party members in the area
{
    int nPartySize = 0;
    object oArea = GetArea(oPC);
    object oParty = GetFirstFactionMember(oPC);
    while (oParty != OBJECT_INVALID)
    {
        if (oArea == GetArea(oParty) || ( ! bInArea) )
        {
            nPartySize++;
        }
        oParty = GetNextFactionMember(oPC);

    } // while
    return nPartySize;
}


int GetPartyTotalLevels(object oPC, int bInArea = TRUE)
// uses get true level to determine party total levels based on xp (not current HitDice)
// bInArea by default discards party members not in same area (map) as oPC
{
    int nTotalLevels = 0;

    object oParty = GetFirstFactionMember(oPC);
    object oArea = GetArea(oPC);
    while (oParty != OBJECT_INVALID)
    {
        if (oArea == GetArea(oParty) || ( ! bInArea))
        {
            nTotalLevels += GetTrueLevel(oParty);
        }

        oParty = GetNextFactionMember(oPC);
    }

    return nTotalLevels;

}// get party total levels

int GetPartyAverageLevel(object oPC, int bInArea = TRUE)
// uses get true level to determine party average level based on xp (not current HitDice)
{
    int nTotalLevels = 0;
    int nPartySize = 0;

    object oArea = GetArea(oPC);
    object oParty = GetFirstFactionMember(oPC);
    while (oParty != OBJECT_INVALID)
    {
        if (oArea == GetArea(oParty) || ( ! bInArea))
        {
            nPartySize++;
            nTotalLevels += GetTrueLevel(oParty);
        }
        oParty = GetNextFactionMember(oPC);
    }

    if (nPartySize == 0) nPartySize = 1;
    return nTotalLevels / nPartySize;
} // get party average level

int GetPartyHighestLevel(object oPC, int bInArea = TRUE)
// Uses GetTrueLevel to determine the level of the highest level character
// in a party. Minimum return is 1, even if oPC is OBJECT_INVALID
// oPC - a member of the party
// bInArea - if TRUE, then restrict the test to party members in the same
//           area as oPC. Ignored if FALSE.
{
    int nHighestLevel = 1;
    int nLevel = 1;

    object oParty = GetFirstFactionMember(oPC);
    object oArea = GetArea(oPC);
    while (oParty != OBJECT_INVALID)
    {
        if (oArea == GetArea(oParty) || ( ! bInArea))
        {
            nLevel = GetTrueLevel(oParty);
            if (nLevel > nHighestLevel)
              nHighestLevel = nLevel;
        }

        oParty = GetNextFactionMember(oPC);
    }

    return nHighestLevel;

}

//void main(){}
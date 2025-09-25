//kinc_trade_crafting
//Trade System - Crafting sub-include
//NLC 7/21/08
#include "ginc_debug"
#include "ginc_param_const"
#include "ginc_2da"
#include "kinc_trade_system"
#include "ginc_crafting"

//Utility Functions
void DestroyItems(object oTarget,string sItem,int nNumItems, int bFeedback = TRUE);

//Crafting Function Prototypes
int CheckCanCraft(int nIndex, object oPC, string sTable);
int CheckCanEnchant(int nIndex, object oItem, object oPC, string sTable);
int CheckLocalInts(int nIndex, object oPC, string sTable);
int CheckGoldCost(int nIndex, object oPC, string sTable);
int CheckTradeBars(int nIndex, object oPC, string sTable);
int CheckItemReagents(int nIndex, object oPC, string sTable);
int CheckGoodReagents(int nIndex, object oPC, string sTable);
int CheckRareResReagents(int nIndex, object oPC, string sTable);
int CheckCraftingSpellUses(int nIndex, object oPC, string sTable);
int CheckItemPrereqs(int nIndex, object oPC, string sTable);
int CheckSkillPrereqs(int nIndex, object oPC, string sTable);
int CheckPlaceablePrereq(int nIndex, object oPC, string sTable);
int CheckFeatPrereqs(int nIndex, object oPC, string sTable);
int CheckEnchantingTargetValid(int nIndex, object oItem, object oPC, string sTable);
int CheckEnchantmentNumber(int nIndex, object oItem, object oPC, string sTable);
int CheckHasEnoughCasterLevels(int nIndex, object oPC, string sTable);

void CraftItem(int nIndex, object oPC, string sTable);
void EnchantItem(int nIndex, object oItem, object oPC, string sTable);
void DeductGoldCost(int nIndex, object oPC, string sTable);
void DeductTradeBarCost(int nIndex, object oPC, string sTable);
void ConsumeItemReagents(int nIndex, object oPC, string sTable);
void ConsumeGoodReagents(int nIndex, object oPC, string sTable);
void ConsumeRareResReagents(int nIndex, object oPC, string sTable);
void ConsumeCraftingSpellUse(int nIndex, object oPC, string sTable);
void CreateCraftedItem(int nIndex, object oPC, string sTable);
void EnchantTargetItem(int nIndex, object oItem, string sTable);


void DoCraftingFailureFeedback(int nCraftingFailure, object oPC, string sExtraFeedback = "");
/*----------------------------------\
|	Crafting Function Definitions	|
\----------------------------------*/
int CheckCanCraft(int nIndex, object oPC, string sTable)
{
	if (nIndex < 1)
	{
		PrettyDebug("Invalid Recipe Index!");
		return FALSE;
	}
	
	if( CheckLocalInts(nIndex, oPC, sTable)			&&
		CheckGoldCost(nIndex, oPC, sTable)			&&
		CheckTradeBars(nIndex, oPC, sTable)			&&
		CheckItemReagents(nIndex, oPC, sTable)		&&
		CheckGoodReagents(nIndex, oPC, sTable)		&&
		CheckRareResReagents(nIndex, oPC, sTable)	&&
		CheckCraftingSpellUses(nIndex, oPC, sTable)	&&
		CheckFeatPrereqs(nIndex, oPC, sTable)		&&
		CheckItemPrereqs(nIndex, oPC, sTable)		&&
		CheckSkillPrereqs(nIndex, oPC, sTable)		&&
		CheckPlaceablePrereq(nIndex, oPC, sTable)		)
	{
		return TRUE;
	}
	
	else
		return FALSE;
}

int CheckCanEnchant(int nIndex, object oItem, object oPC, string sTable)
{
	if (nIndex < 1)
	{
		PrettyDebug("Invalid Recipe Index!");
		return FALSE;
	}
	
	if( CheckLocalInts(nIndex, oPC, sTable)						&&
		CheckGoldCost(nIndex, oPC, sTable)						&&
		CheckTradeBars(nIndex, oPC, sTable)						&&
		CheckItemReagents(nIndex, oPC, sTable)					&&
		CheckGoodReagents(nIndex, oPC, sTable)					&&
		CheckRareResReagents(nIndex, oPC, sTable)				&&
		CheckCraftingSpellUses(nIndex, oPC, sTable)				&&
		CheckFeatPrereqs(nIndex, oPC, sTable)					&&
		CheckItemPrereqs(nIndex, oPC, sTable)					&&
		CheckSkillPrereqs(nIndex, oPC, sTable)					&&
		CheckEnchantingTargetValid(nIndex, oItem, oPC, sTable)	&&
		CheckEnchantmentNumber(nIndex, oItem, oPC, sTable)		&&
		CheckHasEnoughCasterLevels(nIndex, oPC, sTable)			&&
		CheckPlaceablePrereq(nIndex, oPC, sTable)	)
	{
		return TRUE;
	}
	
	else
		return FALSE;
}

int CheckLocalInts(int nIndex, object oPC, string sTable)
{
	string sInts = Get2DAString(sTable, "RECIPE_TAG", nIndex);
	string sParam = GetStringParam(sInts, 0);
	int i=0;
	
	while(sParam != "")
	{
		if( GetLocalInt(oPC, sParam) != TRUE )		//We want to iterate through the list of local ints and verify that they are all
		{
			DoCraftingFailureFeedback(CRAFTING_FAILURE_RECIPE, oPC);
			return FALSE;							//TRUE on the PC who is attempting to craft the item.
		}
		i++;
		sParam = GetStringParam(sInts, i);
	}
	
	PrettyDebug("CheckLocalInts returning TRUE");
	return TRUE;									//If we've made it through the loop without returning FALSE, return TRUE.
}

int CheckGoldCost(int nIndex, object oPC, string sTable)
{
	int nGoldCost = Get2DAInt(sTable, "COST_GOLD", nIndex);
	if ( GetGold(oPC) >= nGoldCost )
	{
	
		return TRUE;
	}	
	else
	{
		string sGoldCost = IntToString(nGoldCost);
		DoCraftingFailureFeedback(CRAFTING_FAILURE_GOLD, oPC, sGoldCost);
		return FALSE;
	}
}

int CheckTradeBars(int nIndex, object oPC, string sTable)
{
	int nTradeBarCost = Get2DAInt(sTable, "COST_BARS", nIndex);
	if ( GetPartyBars() >= nTradeBarCost )
	{
		PrettyDebug("CheckTradeBars returning TRUE");
		return TRUE;
	}	
	else
	{
		string sBarsCost = IntToString(nTradeBarCost);
		DoCraftingFailureFeedback(CRAFTING_FAILURE_BARS, oPC, sBarsCost);
		return FALSE;
	}
}

int CheckItemReagents(int nIndex, object oPC, string sTable)
{
	string sItems = Get2DAString(sTable, "COST_ITEMS", nIndex);
	string sParam = GetStringParam(sItems, 0);
	int i=0;
	
	while(sParam != "")
	{
		int nNum = StringToInt( GetStringParam(sItems, i+1) );			//The NEXT parameter we are setting equal to the number to create - if it's a valid int.
		
		if ( nNum != 0 )												//if nNum is a valid int, we are going to use it as an iterator.
		{
			if(GetNumItems(oPC, sParam) < nNum)							//If the player has fewer than nNum of the required item,
			{
				object oTempItem = CreateItemOnObject(sParam, oPC, 1, "", FALSE);
				string sItemName = GetName(oTempItem);
				DoCraftingFailureFeedback(CRAFTING_FAILURE_ITEM, oPC, sItemName);
				DestroyItems(oPC, sParam, 1, FALSE);
				return FALSE;											//return FALSE.
			}
				
			i += 2;														//We want to increment i by 2 in this case to skip nNum on the next iteration.
		}
		
		else
		{
			if(GetNumItems(oPC, sParam) < 1)							//If the player has fewer than 1 of the required item,
			{
				object oTempItem = CreateItemOnObject(sParam, oPC, 1, "", FALSE);
				string sItemName = GetName(oTempItem);
				DoCraftingFailureFeedback(CRAFTING_FAILURE_ITEM, oPC, sItemName);
				DestroyItems(oPC, sParam, 1, FALSE);
				return FALSE;											//return FALSE.
			}
			
			i++;
		}
		sParam = GetStringParam(sItems, i);
	}
	
	PrettyDebug("CheckItemReagents returning TRUE");
	return TRUE;									//If we've made it through the loop without returning FALSE, return TRUE.
}

int CheckGoodReagents(int nIndex, object oPC, string sTable)
{
	string sGoods = Get2DAString(sTable, "COST_GOODS", nIndex);
	string sParam = GetStringParam(sGoods, 0);
	int i=0;
	
	while(sParam != "")
	{
		int nNum = StringToInt( GetStringParam(sGoods, i+1) );			//The NEXT parameter we are setting equal to the number to create - if it's a valid int.
		
		if ( nNum != 0 )												//if nNum is a valid int, we are going to use it as an iterator.
		{
			int nGoodIndex = Search2DA(GOODS_2DA, "LABEL", sParam);
			PrettyDebug("GoodIndex:" + IntToString(nGoodIndex) + " nNum:" + IntToString(nNum));
			if( TakeCargo(nGoodIndex, nNum, TRUE, TRUE) == FALSE && TakeCargo(nGoodIndex + 12, nNum, FALSE, TRUE) == FALSE)		
			{	//This rather lovely if statement basically works around the existance of Trade Good AND Rare Resource versions of the goods...
				//You only get a failure message if you don't have enough of EITHER.
				DoCraftingFailureFeedback(CRAFTING_FAILURE_GOOD, oPC, GetTradeGoodName(nGoodIndex));
				return FALSE;											//break the loop and return false.
			}	
			i += 2;														//We want to increment i by 2 in this case to skip nNum on the next iteration.
		}
		
		else
		{
			int nGoodIndex = Search2DA(GOODS_2DA, "LABEL", sParam);
			PrettyDebug("GoodIndex:" + IntToString(nGoodIndex) + " no nNum");
			if( TakeCargo(nGoodIndex, 1, TRUE, TRUE) == FALSE && TakeCargo(nGoodIndex + 12, 1, FALSE, TRUE) == FALSE)			//Check if we can take that amount... if we can't,
			{
				DoCraftingFailureFeedback(CRAFTING_FAILURE_GOOD, oPC, GetTradeGoodName(nGoodIndex));
				return FALSE;											//break the loop and return false.
			}
			i++;
		}
		
		sParam = GetStringParam(sGoods, i);
	}
	
	PrettyDebug("CheckGoodReagents returning TRUE");
	return TRUE;									//If we've made it through the loop without returning FALSE, return TRUE.
	
}

int CheckRareResReagents(int nIndex, object oPC, string sTable)
{
	string sRareRes = Get2DAString(sTable, "COST_RARERES", nIndex);
	string sParam = GetStringParam(sRareRes, 0);
	int i=0;
	
	while(sParam != "")
	{
		int nNum = StringToInt( GetStringParam(sRareRes, i+1) );			//The NEXT parameter we are setting equal to the number to create - if it's a valid int.
		
		if ( nNum != 0 )												//if nNum is a valid int, we are going to use it as an iterator.
		{
			int nResIndex = Search2DA(RES_2DA, "LABEL", sParam);
			if( TakeCargo(nResIndex, nNum, FALSE, TRUE) == FALSE )		//Check if we can take that amount... if we can't,
			{
				DoCraftingFailureFeedback(CRAFTING_FAILURE_RES, oPC, GetRareResourceName(nResIndex));
				return FALSE;											//break the loop and return false.
			}	
			i += 2;														//We want to increment i by 2 in this case to skip nNum on the next iteration.
		}
		
		else
		{
			int nResIndex = Search2DA(RES_2DA, "LABEL", sParam);
			if( TakeCargo(nResIndex, 1, FALSE, TRUE) == FALSE )			//Check if we can take that amount... if we can't,
			{
				DoCraftingFailureFeedback(CRAFTING_FAILURE_RES, oPC, GetRareResourceName(nResIndex));
				return FALSE;											//break the loop and return false.
			}
			i++;
		}
		
		sParam = GetStringParam(sRareRes, i);
	}
	
	PrettyDebug("CheckRareResReagents returning TRUE");
	return TRUE;									//If we've made it through the loop without returning FALSE, return TRUE.
}

int CheckCraftingSpellUses(int nIndex, object oPC, string sTable)
{
	string sSpellIDs = Get2DAString(sTable, "COST_SPELLS", nIndex);
	string sParam = GetStringParam(sSpellIDs, 0);
	int i=0;

	while(sParam != "")
	{
		int nSpellID = StringToInt(sParam);
		int bSpellValid = FALSE;							//Initialise the spell test to FALSE
		if(GetHasSpell(nSpellID, oPC))
			bSpellValid = TRUE;								//If I've got the spell, then we're golden.
		
		object oFM = GetFirstFactionMember(oPC, FALSE);
		while(GetIsObjectValid(oFM) && bSpellValid != TRUE)	//Otherwise, we iterate through the party until we find someone who has it (or have
		{													//iterated through the entire party).
			if(GetHasSpell(nSpellID, oFM) || GetHasFeat(FEAT_IMBUE_ITEM, oFM)) //FIX: Added support for Imbue Item
				bSpellValid = TRUE;
				
			oFM = GetNextFactionMember(oPC, FALSE);
		}
		
		if (bSpellValid != TRUE)							//If we still haven't found someone who has this spell, we need to fail out at this point.
		{
			string sSpellName = GetStringByStrRef(Get2DAInt("spells", "Name", nSpellID));
			DoCraftingFailureFeedback(CRAFTING_FAILURE_SPELL, oPC, sSpellName);
			return FALSE;
		}
		++i;
		
		sParam = GetStringParam(sSpellIDs, i);
	}
	PrettyDebug("CheckCraftingSpellUses returning TRUE");
	return TRUE;
}

int CheckItemPrereqs(int nIndex, object oPC, string sTable)
{
	string sItemTags = Get2DAString(sTable, "PREREQ_ITEMS", nIndex);
	string sParam = GetStringParam(sItemTags, 0);
	int i=0;
	
	while(sParam != "")
	{
		
		int bItemFound = FALSE;									//Initialise the spell test to FALSE
		if(GetIsObjectValid(GetItemPossessedBy(oPC, sParam)))
			bItemFound = TRUE;									//If I've got the item, then we're golden.
		
		object oFM = GetFirstFactionMember(oPC, FALSE);
		while(GetIsObjectValid(oFM) && bItemFound != TRUE)		//Otherwise, we iterate through the party until we find someone who has it (or have
		{														//iterated through the entire party).
			if(GetIsObjectValid(GetItemPossessedBy(oFM, sParam)))
				bItemFound = TRUE;
				
			oFM = GetNextFactionMember(oPC, FALSE);
		}

		if (bItemFound != TRUE)							//If we still haven't found someone who has this item, we need to fail out at this point.
		{
			DoCraftingFailureFeedback(CRAFTING_FAILURE_PREREQ_ITEM, oPC);
			return FALSE;
		}
				
		++i;

		sParam = GetStringParam(sItemTags, i);
	}
	PrettyDebug("CheckItemPrereqs returning TRUE");
	return TRUE;
}

int CheckFeatPrereqs(int nIndex, object oPC, string sTable)
{
	string sFeatPrereqs = Get2DAString(sTable, "PREREQ_FEATS", nIndex);
	string sParam = GetStringParam(sFeatPrereqs, 0);
	
	int i=0;
	while(sParam != "")
	{
		int bFeatFound = FALSE;
		int nFeatID = StringToInt(sParam);

		if(GetHasFeat(nFeatID, oPC, TRUE))
			bFeatFound = TRUE;
		
		object oFM = GetFirstFactionMember(oPC, FALSE);
		while(GetIsObjectValid(oFM) && bFeatFound != TRUE)
		{
			if(GetHasFeat(nFeatID, oFM, TRUE))
				bFeatFound = TRUE;
				
			oFM = GetNextFactionMember(oPC, FALSE);
		}

		if (bFeatFound != TRUE)							
		{
			string sFeatName = GetStringByStrRef(Get2DAInt("feat", "FEAT", nFeatID));
			DoCraftingFailureFeedback(CRAFTING_FAILURE_FEAT, oPC, sFeatName);
			return FALSE;
		}
				
		++i;

		sParam = GetStringParam(sFeatPrereqs, i);
	}
	PrettyDebug("CheckFeatPrereqs returning TRUE");	
	return TRUE;
}

int CheckSkillPrereqs(int nIndex, object oPC, string sTable)
{
	string sSkillPrereqs = Get2DAString(sTable, "PREREQ_SKILLRANKS", nIndex);
	string sParam = GetStringParam(sSkillPrereqs, 0);
	
	if(sParam == "")
		return TRUE;
	
	int i=0;
	while(sParam != "")
	{
		string sRank = GetStringParam(sSkillPrereqs, i + 1);	//Because the skills and ranks are stored in the format of SKILLID,RANK we need to get
																//the list element AFTER the skill to determine the rank.
																
		int bHasSkill = FALSE;
		int nSkill = StringToInt(sParam);
		int nRanks = StringToInt(sRank);
		
		if(GetSkillRank(nSkill, oPC) >= nRanks )
		{
			bHasSkill = TRUE;
		}
		
		object oFM = GetFirstFactionMember(oPC, FALSE);
		while(GetIsObjectValid(oFM) && bHasSkill != TRUE)
		{
			if(GetSkillRank(nSkill, oFM) >= nRanks )
				bHasSkill = TRUE;
				
			oFM = GetNextFactionMember(oPC, FALSE);
		}
		if(bHasSkill != TRUE)
		{
			string sSkillName = GetStringByStrRef(Get2DAInt("skills", "Name", nSkill));
			DoCraftingFailureFeedback(CRAFTING_FAILURE_SKILL, oPC, sSkillName);
			return FALSE;
		}
		i+=2;													//We iterate by 2 here, so that next time through the loop sParam is a skill ID, not a rank.									
		
		sParam = GetStringParam(sSkillPrereqs, i);
	}
	PrettyDebug("CheckSkillPrereqs returning TRUE");		
	return TRUE;
}

int CheckPlaceablePrereq(int nIndex, object oPC, string sTable)
{
	string sPlaceableToFind = Get2DAString(sTable, "PREREQ_PLACEABLE", nIndex);
	
	if(sPlaceableToFind == "")
		return TRUE;
	
	object oBench = GetNearestObjectByTag(sPlaceableToFind, oPC);
	if(GetIsObjectValid(oBench))
	{
		if(LineOfSightObject(oPC, oBench))
		{
			if(GetDistanceBetween(oPC, oBench) <= CRAFTING_PLC_SEARCH_DIST)
			{
				PrettyDebug("CheckPlaceablePrereq returning TRUE");
				return TRUE;
			}
		}
	}
	DoCraftingFailureFeedback(CRAFTING_FAILURE_PLC, oPC);
	return FALSE;
}

int CheckEnchantingTargetValid(int nIndex, object oItem, object oPC, string sTable)
{
	string sEnchantmentEffect = Get2DAString(sTable, "EFFECT_STRING", nIndex);
	int nPropID = GetIntParam(sEnchantmentEffect, 0);
	int nBaseItemType = GetBaseItemType(oItem);
	
	if (!GetIsLegalItemProp(nBaseItemType, nPropID))
	{
		DoCraftingFailureFeedback(CRAFTING_FAILURE_INV_IPRP, oPC);
		return FALSE;
	}
	else return TRUE;
}

int CheckEnchantmentNumber(int nIndex, object oItem, object oPC, string sTable)
{
	string sEnchantmentEffect = Get2DAString(sTable, "EFFECT_STRING", nIndex);
	// examine target - can more item props be placed?
	int nMaxPropCount = 3;
	if (GetHitDice(oPC) > 20)
		nMaxPropCount = 4;
		
	int nMaxEnchantError = ERROR_TARGET_HAS_MAX_ENCHANTMENTS_NON_EPIC;
	int nItemPropCount = GetPropSlotsUsed(oItem); //GetNumberItemProperties(oItem);
	if (nItemPropCount >= nMaxPropCount)
	{
		// can't add stuff, but can still replace an old effect.
		if (!GetAreAllEncodedEffectsAnUpgrade(oItem, sEnchantmentEffect))
		{
			//output("FAILURE");
/*			if (iMaxPropCount == 4)
				nMaxEnchantError = ERROR_TARGET_HAS_MAX_ENCHANTMENTS;
				
			ErrorNotify(oPC, nMaxEnchantError); */
			DoCraftingFailureFeedback(CRAFTING_FAILURE_MAX_IPRP, oPC);
      		return FALSE;
		}
		
	}
	
	return TRUE;
}

int CheckHasEnoughCasterLevels(int nIndex, object oPC, string sTable)
{
	int nRequiredCasterLevel = Get2DAInt(sTable, "PREREQ_CASTER_LEVEL", nIndex);
	int bHasLevels;
	
	int nCasterLevel = GetCasterLevel(oPC);
	if(nCasterLevel >= nRequiredCasterLevel)
	{
		bHasLevels = TRUE;
	}
	
	object oFM = GetFirstFactionMember(oPC, FALSE);
	while(bHasLevels != TRUE && GetIsObjectValid(oFM))
	{
		if(GetCasterLevel(oFM) >= nRequiredCasterLevel )
			bHasLevels = TRUE;
			
		oFM = GetNextFactionMember(oPC, FALSE);
	}
	
	if(bHasLevels != TRUE)
	{
		DoCraftingFailureFeedback(CRAFTING_FAILURE_CLVL, oPC);
		return FALSE;
	}	
	
	else return TRUE;
}

void CraftItem(int nIndex, object oPC, string sTable)
{
	DeductGoldCost(nIndex, oPC, sTable);
	DeductTradeBarCost(nIndex, oPC, sTable);
	ConsumeItemReagents(nIndex, oPC, sTable);
	ConsumeGoodReagents(nIndex, oPC, sTable);
	ConsumeRareResReagents(nIndex, oPC, sTable);
	ConsumeCraftingSpellUse(nIndex, oPC, sTable);
	
	CreateCraftedItem(nIndex, oPC, sTable);
}

void EnchantItem(int nIndex, object oItem, object oPC, string sTable)
{
	DeductGoldCost(nIndex, oPC, sTable);
	DeductTradeBarCost(nIndex, oPC, sTable);
	ConsumeItemReagents(nIndex, oPC, sTable);
	ConsumeGoodReagents(nIndex, oPC, sTable);
	ConsumeRareResReagents(nIndex, oPC, sTable);
	ConsumeCraftingSpellUse(nIndex, oPC, sTable);
	
	EnchantTargetItem(nIndex, oItem, sTable);
	SetEnchantedItemName(oPC, oItem);
}
void DeductGoldCost(int nIndex, object oPC, string sTable)
{
	int nGoldCost = Get2DAInt(sTable, "COST_GOLD", nIndex);
	PrettyDebug("Gold Cost=" + IntToString(nGoldCost));
	PrettyDebug(GetName(oPC));
	AssignCommand(oPC, TakeGoldFromCreature(nGoldCost, oPC, TRUE));
}

void DeductTradeBarCost(int nIndex, object oPC, string sTable)
{
	int nTradeBarCost = Get2DAInt(sTable, "COST_BARS", nIndex);
	TakeBars(nTradeBarCost);
}

void DestroyItems(object oTarget,string sItem,int nNumItems, int bFeedback = TRUE)
{
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oTarget);

    while (GetIsObjectValid(oItem) == TRUE && nCount < nNumItems)
    {
        if (GetTag(oItem) == sItem)
        {
            int nRemainingToDestroy = nNumItems - nCount;
			int nStackSize = GetItemStackSize(oItem);
			
			if(nStackSize <= nRemainingToDestroy)
			{
				DestroyObject(oItem,0.1f, bFeedback);
				nCount += nStackSize;
			}
            else
			{
				int nNewStackSize = nStackSize - nRemainingToDestroy;
				SetItemStackSize(oItem, nNewStackSize, bFeedback);
				break;
			}
        }
        oItem = GetNextItemInInventory(oTarget);
    }
   return;
}

void ConsumeItemReagents(int nIndex, object oPC, string sTable)
{
	string sItems = Get2DAString(sTable, "COST_ITEMS", nIndex);
	string sParam = GetStringParam(sItems, 0);
	int i=0;
	
	while(sParam != "")
	{
		int nNum = StringToInt( GetStringParam(sItems, i+1) );			//The NEXT parameter we are setting equal to the number to create - if it's a valid int.
		
		if ( nNum != 0 )												//if nNum is a valid int, we are going to use it as an iterator.
		{
			DestroyItems(oPC, sParam, nNum);		
			i += 2;														//We want to increment i by 2 in this case to skip nNum on the next iteration.
		}
		
		else															//If nNum is not a valid integer, we proceed to the next parameter directly and 
		{																//Only kill 1 item.
			DestroyItems(oPC, sParam, 1);
			i++;
		}
		sParam = GetStringParam(sItems, i);
	}
}

void ConsumeGoodReagents(int nIndex, object oPC, string sTable)
{
	string sGoods = Get2DAString(sTable, "COST_GOODS", nIndex);
	string sParam = GetStringParam(sGoods, 0);
	int i=0;
	
	while(sParam != "")
	{
		int nNum = StringToInt( GetStringParam(sGoods, i+1) );			//The NEXT parameter we are setting equal to the number to create - if it's a valid int.
		
		if ( nNum != 0 )												//if nNum is a valid int, we are going to use it as an amount.
		{
			int nGoodIndex = Search2DA(GOODS_2DA, "LABEL", sParam);
			int bGoodSuccess = TakeCargo(nGoodIndex, nNum, TRUE);
			if (bGoodSuccess != TRUE)		//This little semi-hacky thing handles rare-resource versions of the trade goods.
			{
				TakeCargo(nGoodIndex + 12, nNum, FALSE);
			}
			i += 2;														//We want to increment i by 2 in this case to skip nNum on the next iteration.
		}
		
		else
		{
			int nGoodIndex = Search2DA(GOODS_2DA, "LABEL", sParam);
			int bGoodSuccess = TakeCargo(nGoodIndex, 1, TRUE);
			if (bGoodSuccess != TRUE)		//This little semi-hacky thing handles rare-resource versions of the trade goods.
			{
				TakeCargo(nGoodIndex + 12, 1, FALSE);
			}
			i++;
		}
		
		sParam = GetStringParam(sGoods, i);
	}
	
}

void ConsumeRareResReagents(int nIndex, object oPC, string sTable)
{
	string sRareRes = Get2DAString(sTable, "COST_RARERES", nIndex);
	string sParam = GetStringParam(sRareRes, 0);
	int i=0;
	
	while(sParam != "")
	{
		int nNum = StringToInt( GetStringParam(sRareRes, i+1) );			//The NEXT parameter we are setting equal to the number to create - if it's a valid int.
		
		if ( nNum != 0 )												//if nNum is a valid int, we are going to use it as an iterator.
		{
			int nResIndex = Search2DA(RES_2DA, "LABEL", sParam);
			TakeCargo(nResIndex, nNum, FALSE);
				
			i += 2;														//We want to increment i by 2 in this case to skip nNum on the next iteration.
		}
		
		else
		{
			int nResIndex = Search2DA(RES_2DA, "LABEL", sParam);
			TakeCargo(nResIndex, 1, FALSE);
			
			i++;
		}
		
		sParam = GetStringParam(sRareRes, i);
	}
}

void ConsumeCraftingSpellUse(int nIndex, object oPC, string sTable)
{
	string sSpellIDs = Get2DAString(sTable, "COST_SPELLS", nIndex);
	string sParam = GetStringParam(sSpellIDs, 0);
	int i=0;
	
	while(sParam != "")
	{
		int nSpellDeducted = FALSE;
		int nSpellID = StringToInt(sParam);
				
		if(GetHasSpell(nSpellID, oPC))
		{
			DecrementRemainingSpellUses(oPC, nSpellID);
			nSpellDeducted = TRUE;
		}
		
		object oFM = GetFirstFactionMember(oPC, FALSE);
		while(GetIsObjectValid(oFM) && nSpellDeducted != TRUE)
		{
			if(GetHasSpell(nSpellID, oFM) && !GetIsOwnedByPlayer(oFM))		//Don't use another player's spells in a MP game.
			{
				DecrementRemainingSpellUses(oPC, nSpellID);
				nSpellDeducted = TRUE;
			}	
			oFM = GetNextFactionMember(oPC, FALSE);
		}
		
		++i;
		
		sParam = GetStringParam(sSpellIDs, i);
	}
}

void CreateCraftedItem(int nIndex, object oPC, string sTable)
{
	string sItems = Get2DAString(sTable, "RESULT_RESREFS", nIndex);
	string sParam = GetStringParam(sItems, 0);
	int i=0;
	
	while(sParam != "")
	{
		int nNum = StringToInt( GetStringParam(sItems, i+1) );	//The NEXT parameter we are setting equal to the number to create.
		
		if ( nNum != 0 )										//if nNum is a valid int, we are going to use it as an iterator.
		{
			object oItem = CreateItemOnObject(sParam, oPC, nNum);
			SetIdentified(oItem, TRUE);
		
			i += 2;												//We want to increment i by 2 in this case to skip the iterator.
		}
		
		else
		{
			object oItem = CreateItemOnObject(sParam, oPC);
			SetIdentified(oItem, TRUE);
			++i;
		}
		
		sParam = GetStringParam(sItems, i);
	}
	
	string sSound = Get2DAString(sTable, "SOUND", nIndex);
	AssignCommand(oPC, ClearAllActions());
	AssignCommand(oPC, PlaySound(sSound, TRUE));
}

void EnchantTargetItem(int nIndex, object oItem, string sTable)
{
	string sEffects = Get2DAString(sTable, "EFFECT_STRING", nIndex);
	ApplyEncodedEffectsToItem(oItem, sEffects);
}

void DoCraftingFailureFeedback(int nCraftingFailure, object oPC, string sExtraFeedback = "")
{
	string sFeedbackMessage = GetStringByStrRef(nCraftingFailure);
	if(sExtraFeedback != "")
	{
		sFeedbackMessage += " ";
		sFeedbackMessage += sExtraFeedback;
	}	
	SendMessageToPC(oPC, sFeedbackMessage);
}
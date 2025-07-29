#include "kemo_auction_includes"

void main (string sItemNumber, string sPrice)
{
	object oPC = OBJECT_SELF;

	//if the user has not set a price, warn and do not continue
	if (sPrice == "" || StringToInt(sPrice) < 1)
	{
		SetGUIObjectHidden(oPC,"KEMO_AUCTION","SellPriceWarning",FALSE);
		DelayCommand(5.0f,SetGUIObjectHidden(oPC,"KEMO_AUCTION","SellPriceWarning",TRUE));
		return;
	}

	object oItem = GetItemFromList(oPC, sItemNumber); //find the sale item from the list
	if (!GetIsObjectValid(oItem)) return;
	string sDB = SetCorrectAuctioneer(oItem) + "_db";
	string sKey = "SaleParameters1";
	string sItem = GetCampaignString(sDB,sKey);
	
	//find the first available sales slot
	int iCounter = 1;
	while (sItem != "")
	{
		iCounter++;
		sKey = "SaleParameters" + IntToString(iCounter);
		sItem = GetCampaignString(sDB,sKey);
	}

	//force the price to be an integer, keep it within limits
	int iPrice = StringToInt(sPrice);
	int iMinValue = FloatToInt(GetGoldPieceValue(oItem) * MIN_PRICE_MULTIPLIER);
	int iMaxValue = FloatToInt(GetGoldPieceValue(oItem) * MAX_PRICE_MULTIPLIER);
	if (iPrice < iMinValue) iPrice = iMinValue;
	if (iPrice > iMaxValue) iPrice = iMaxValue;
	sPrice = IntToString(iPrice);

	//set key names based on slot number
	string sKeyObject = "SaleObject" + IntToString(iCounter);
	
	//set up the parameters for the sale item
	string sItemName = GetName(oItem);
	string sSellerID = GetSellerID(oPC);
	string sSellerName = GetName(oPC);
	string sMaxSales = IntToString(MAX_SALES_PER_CHAR);

	int iCommission;
	switch (COMMISSION_USE_VALUE)
	{
		case 0: iCommission = iPrice; break;
		case 1: iCommission = GetGoldPieceValue(oItem); break;
		case 2:
			{
				if (iPrice > GetGoldPieceValue(oItem)) iCommission = iPrice;
				else iCommission = GetGoldPieceValue(oItem);
			} break;
		case 3: iCommission = COMMISSION_SET_VALUE; break;
	}
	if (COMMISSION_USE_VALUE != 3) iCommission = FloatToInt(iCommission * COMMISSION_PERCENTAGE);
	if (iCommission < COMMISSION_MINIMUM) iCommission = COMMISSION_MINIMUM;
	if (iCommission > COMMISSION_MAXIMUM) iCommission = COMMISSION_MAXIMUM;
	
	if (sDB == "_db")
	{
		DeleteLocalObject(oPC,"SaleItem");
		DeleteLocalInt(oPC,"SaleItemNumber");
		SendMessageToPC(oPC,MAY_NOT_SELL);
		return;
	}
	else if (GetCampaignInt(sDB,"ListTotal"+sSellerID) == MAX_SALES_PER_CHAR)
	{
		SendMessageToPC(oPC, MAY_LIST_MAXIMUM + sMaxSales + ITEMS_AT_ONE_TIME);
		return;
	}
	else if (GetCampaignInt(sDB,"SaleListTotalActive") >= MAX_SALES_TOTAL)
	{
		string n = IntToString(MAX_SALES_TOTAL);
		SendMessageToPC(oPC, MAX_ITEMS_REACHED + n);
		return;
	}
	else if (GetGold(oPC) < iCommission && COMMISSION_EXTRACT_POINT == 0)
	{
		DeleteLocalObject(oPC,"SaleItem");
		DeleteLocalInt(oPC,"SaleItemNumber");
		SendMessageToPC(oPC,NOT_ENOUGH_GOLD_COMM);
		return;
	}
	else if (FindSubString(sItemName,";") > -1)
	{
		DeleteLocalObject(oPC,"SaleItem");
		DeleteLocalInt(oPC,"SaleItemNumber");
		SendMessageToPC(oPC,NO_SEMICOLONS);
		return;		
	}
	else
	{
		
		string sStackSize = IntToString(GetNumStackedItems(oItem));
		string sPostSeconds = IntToString(GetUNIXTime());
		string sIcon = GetSaleItemIcon(oItem);
		string sCDKey = GetPCPublicCDKey(oPC);
		string sPlayername = GetPCPlayerName(oPC);
		string sIP = GetPCIPAddress(oPC);
		// for GetStringParam:
		// 0 = item name
		// 1 = price
		// 2 = seller ID
		// 3 = seller name
		// 4 = post seconds
		// 5 = stack size
		// 6 = icon ID
		// 7 = seller cd key
		// 8 = seller playername
		// 9 = seller IP
		SetCampaignString(sDB,sKey,sItemName + ";" + sPrice + ";" + sSellerID
			+ ";" + sSellerName + ";" + sPostSeconds + ";" + sStackSize + ";" + sIcon
			+ ";" + sCDKey + ";" + sPlayername + ";" + sIP);

		StoreCampaignObject(sDB,sKeyObject,oItem);

		if (COMMISSION_EXTRACT_POINT == 0) TakeGoldFromCreature(iCommission,oPC,TRUE);
		DestroyObject(oItem);
		DeleteLocalObject(oPC,"SaleItem");
		DeleteLocalInt(oPC,"SaleItemNumber");
		// PC can only have MAX_SALES_PER_CHAR items listed at once
		string sListTotal = "ListTotal"+sSellerID;
		int iListNumber = GetCampaignInt(sDB,sListTotal);
		iListNumber++;
		SetCampaignInt(sDB,sListTotal,iListNumber);
		// if a new last sales slot, add to the total number of sales slots
		if (GetCampaignInt(sDB,"SaleListTotal") < iCounter) SetCampaignInt(sDB,"SaleListTotal",iCounter);
		DelayCommand(1.0f,ExecuteScript("gui_kemo_auction_sell",oPC));
		
		SetCampaignInt(sDB,"SaleListTotalActive",GetCampaignInt(sDB,"SaleListTotalActive")+1);
	}
}
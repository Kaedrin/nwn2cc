// called from the kemo_auction GUI

#include "kemo_auction_includes"

void main(string sItemNumber)
{
	object oPC = OBJECT_SELF;
	string sTag = GetLocalString(oPC,"Auctioneer");
	string sDB = sTag + "_db";
	location lPC = GetLocation(oPC);
	//Get the sale item slot
	string sKey = "SaleParameters" + sItemNumber;
	string sKeyObject = "SaleObject" + sItemNumber;
	string sSaleItem = GetCampaignString(sDB,sKey);
	string sPrice;
	
	sPrice = GetStringParam(sSaleItem,1,";");
	int iPrice = StringToInt(sPrice);
	
	if (GetGold(oPC) < iPrice)
	{
		SendMessageToPC(oPC, NOT_ENOUGH_GOLD);
		return;
	}
	if (CheckExploit(oPC,sSaleItem))
	{
		SendMessageToPC(oPC, TO_PREVENT_EXPLOITS);
		return;
	}
	else
	{
		TakeGoldFromCreature(iPrice,oPC,TRUE);
		object oSaleItem = RetrieveCampaignObject(sDB,sKeyObject,lPC);
		//ActionPickUpItem(oSaleItem);
		object oSaleCopy = CopyItem(oSaleItem,oPC,1);
		DestroyObject(oSaleItem);
		
		string sSellerID;
		//Get the seller ID, reserve gold for the seller, decrement seller's list total
		sSellerID = GetStringParam(sSaleItem,2,";");
		string sListTotal = "ListTotal"+sSellerID;
		int iSellerGold = GetCampaignInt(sDB,sSellerID);
		iSellerGold = iSellerGold + iPrice;
		SetCampaignInt(sDB,sSellerID,iSellerGold);
		int iListTotal = GetCampaignInt(sDB,sListTotal);
//		SendMessageToPC(oPC,sDB + " " + sListTotal + "    " + IntToString(iListTotal));//DEBUG
		iListTotal--;
//		SendMessageToPC(oPC,sDB + " " + sListTotal + "    " + IntToString(iListTotal));//DEBUG
		SetCampaignInt(sDB,sListTotal,iListTotal);
		
		//Remove the sale item from the slot
		DeleteCampaignVariable(sDB,sKey);
		DeleteCampaignVariable(sDB,sKeyObject);
	}
	ExecuteScript("gui_kemo_auction_list",oPC);
}
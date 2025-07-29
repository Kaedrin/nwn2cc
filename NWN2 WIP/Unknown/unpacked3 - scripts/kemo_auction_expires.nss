#include "ginc_param_const"
#include "kemo_auction_includes"

int CheckDate(string sPostSeconds)
{
	int iExpireSeconds = 86400 * EXPIRATION_IN_DAYS;
	int iPostSeconds = StringToInt(sPostSeconds) + iExpireSeconds; // length of post time in seconds
	int iCurrentSeconds = GetUNIXTime();
	if (iCurrentSeconds > iPostSeconds) return TRUE;
	else return FALSE;
}

void SetExpiredItemSeller(string sDB, object oItem, string sSellerID)
{
	int iExpireCounter = 1; string sExpireCounter;
	int iListTotal;
	string sListTotal = "ListTotal"+sSellerID;
	string sExpireVar = "Exp" + sSellerID + "_1";
	object oListItem;
	location lLoc = GetLocation(OBJECT_SELF);

	while (iExpireCounter <= MAX_SALES_PER_CHAR)
	{
		// Take an item out of the PC's expired list
		oListItem = RetrieveCampaignObject(sDB,sExpireVar,lLoc,OBJECT_SELF);
		// Test the item: if it exists, destroy and move on.
		// If it doesn't exist, slot the new expired item in
		if (!GetIsObjectValid(oListItem))
		{
			StoreCampaignObject(sDB,sExpireVar,oItem);
			DestroyObject(oItem);
			iExpireCounter = MAX_SALES_PER_CHAR;
		}
		else DestroyObject(oListItem);
		// increment the counter
		iExpireCounter++; sExpireVar = "Exp" + sSellerID + "_" + IntToString(iExpireCounter);
	}
	iListTotal = GetCampaignInt(sDB,sListTotal);
	iListTotal--;
	SetCampaignInt(sDB,sListTotal,iListTotal);
}

void main()
{
	object oExpired; object oPC = OBJECT_SELF;
	object oAuctioneer = GetNearestObjectByTag("kemo_auctioneer");
	location lLoc = GetLocation(oAuctioneer);
	string sTag = GetLocalString(oPC,"Auctioneer");
	string sDB = sTag + "_db";
	
	int iCounter = 1;
	string sCounter;

	string sKey = "SaleParameters1";

	int iSaleListTotal = GetCampaignInt(sDB,"SaleListTotal"); // size of sale item list
	string sItem; string sPostSeconds;
	
	sItem = GetCampaignString(sDB,sKey); // first slot
	
	// run through the item list checking for expired sales
	while (iCounter <= iSaleListTotal)
	{
		if (sItem != "")
		{
			sPostSeconds = GetStringParam(sItem,4,";");
			// 7 day expiration
			if (CheckDate(sPostSeconds))
			{
				//take item out of sale list, put into PC's expired list
				oExpired = RetrieveCampaignObject(sDB,"SaleObject" + IntToString(iCounter),lLoc,oAuctioneer);
				SetExpiredItemSeller(sDB,oExpired,GetStringParam(sItem,2,";"));
				// Remove the item from the sale list
				DeleteCampaignVariable(sDB,sKey);
				DeleteCampaignVariable(sDB,"SaleObject" + IntToString(iCounter));
			}
		}
		//increment the slot
		iCounter++;
		sKey = "SaleParameters" + IntToString(iCounter); 
		sItem = GetCampaignString(sDB,sKey);
	}
}
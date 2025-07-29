#include "kemo_auction_includes"

void main(string sItemNumber)
{
	object oPC = OBJECT_SELF;
	object oAuctionTable = GetNearestObjectByTag("kemo_auction_viewpoint");
	object oItem; object oCopy;
	
	string sTag = GetLocalString(oPC,"Auctioneer");
	string sDB = sTag + "_db";
	//Get the sale item slot
	string sKey = "SaleObject" + sItemNumber;
	oItem = RetrieveCampaignObject(sDB,sKey,GetLocation(oAuctionTable));
	DelayCommand(1.0f,ActionExamine(oItem));
	DelayCommand(3.0f,DestroyObject(oItem));
}
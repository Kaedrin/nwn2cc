#include "kemo_auction_includes"

void main()
{
	ExecuteScript("kemo_auction_expires",OBJECT_SELF);

	object oPC = OBJECT_SELF;
	string sTag = GetLocalString(oPC,"Auctioneer");

	int iCounter = 1;
	string sCounter;

	string sDB = sTag + "_db";
	string sKey = "SaleParameters1";

	int iListTotal = GetCampaignInt(sDB,"SaleListTotal"); // length of sale item list
	string sItem; string sName; string sPrice; string sStackSize;
	string sSellerName; string sPostSeconds; string sPostTime;
	string sIcon;
	
	sItem = GetCampaignString(sDB,sKey); // first item in list
	
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","KEMO_AUCTION_BUY",FALSE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","BuyLabelPane",FALSE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","AuctionCount",FALSE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","SellLabelPane",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","SellPricePane",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","KEMO_AUCTION_SELL",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","ViewButton",FALSE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","BuyButton",FALSE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","SellButtonB",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","FilterPane",FALSE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","PagePane",FALSE);

	ClearListBox(oPC,"KEMO_AUCTION","KEMO_AUCTION_BUY");
	AuctionSaleNumber(oPC);
	string sRow; string sTextFields; string sTextures; string sVariables;
	string sNameFilter;
	string sFilter = GetStringUpperCase(GetLocalString(oPC,"AuctionFilter"));
	
	int page = GetLocalInt(oPC, "kemo_auction_page");
	
	int pageCount = 0;
	int resultCount = 0;
	int activeItemsCount = 0;

	int lastItem = page * AUCTION_PAGE_SIZE;
	int firstItem = lastItem - AUCTION_PAGE_SIZE;
	
	while (iCounter <= iListTotal)
	{
		// if there is an item here, display; if not, just increment the counter
		if (sItem != "")
		{
			sName = GetStringParam(sItem,0,";");
			sNameFilter = GetStringUpperCase(sName);
			if (sFilter == "" || FindSubString(sNameFilter,sFilter) > -1)
			{
				// Search over all pages and filter the results into pages.
				if (resultCount >= firstItem && resultCount < lastItem)
				{
					sCounter = IntToString(iCounter);
					sPrice = GetStringParam(sItem,1,";");
					sSellerName = GetStringParam(sItem,3,";");
					sPostSeconds = GetStringParam(sItem,4,";");
					sPostTime = GetPostLength(sPostSeconds);
					sStackSize = GetStringParam(sItem,5,";");
					sIcon = GetStringParam(sItem,6,";");
		
					sRow = "BuyRow"+sCounter;
					sTextFields = "BuyPaneName=     "+sName+" ("+sStackSize+");" +
							"BuyPanePrice="+sPrice+";" +
							"BuyPaneSeller=   "+sSellerName+";" +
							"BuyPaneTime="+sPostTime;
					sTextures = "BuyPaneIcon=" + sIcon;
					sVariables = "5="+sCounter;

					pageCount++;
					AddListBoxRow(oPC,"KEMO_AUCTION","KEMO_AUCTION_BUY",sRow,sTextFields,sTextures,sVariables,"");
				}
				resultCount++;
			}
			activeItemsCount++;
		}
		iCounter++;
		sKey = "SaleParameters" + IntToString(iCounter);
		sItem = GetCampaignString(sDB,sKey);
	}
	
	string sItemOfTotal = "Showing item " + IntToString(firstItem + 1) + " to " + IntToString(firstItem + pageCount) + " of " + IntToString(resultCount) + " items";
	
	if (pageCount == 0 && page == 1) SetGUIObjectHidden(oPC,"KEMO_AUCTION","PagePane",TRUE);
	else SetGUIObjectText(oPC,"KEMO_AUCTION","ItemsOfTotal",-1,sItemOfTotal);
	
	SetLocalInt(oPC, "kemo_auction_list_size", resultCount);
	SetCampaignInt(sDB,"SaleListTotalActive", activeItemsCount);
}
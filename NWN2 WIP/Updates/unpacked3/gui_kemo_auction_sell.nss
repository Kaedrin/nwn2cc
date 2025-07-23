#include "kemo_auction_includes"

void main()
{
	object oPC = OBJECT_SELF;
	
	if ( GetLocalString(oPC, "kemo_auction_mode") != "sell" )
	{
		SetLocalInt(oPC, "kemo_auction_page", 1);
		SetLocalString(oPC, "kemo_auction_mode", "sell");
	}

	ExecuteScript("gui_kemo_auction_retrieve",oPC);

	SetGUIObjectHidden(oPC,"KEMO_AUCTION","KEMO_AUCTION_BUY",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","SellLabelPane",FALSE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","SellPricePane",FALSE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","AuctionCount",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","BuyLabelPane",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","KEMO_AUCTION_SELL",FALSE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","ViewButton",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","BuyButton",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","SellButtonB",FALSE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","FilterPane",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_AUCTION","PagePane",FALSE);

	SetGUIObjectText(oPC,"KEMO_AUCTION","AuctionTitle",-1,AUCTION_SELL_TEXT);
	
	ClearListBox(oPC,"KEMO_AUCTION","KEMO_AUCTION_SELL");
	

	object oItem = GetFirstItemInInventory(oPC);
	string sIcon; string sName;
	string sVariables;
	string sStorageVar;
	int iCounter = 0; string sCounter;

	if (GetDistanceToObject(GetNearestObjectByTag("kemo_auctioneer")) > 3.0f)
	{	SendMessageToPC(oPC,TOO_FAR_AWAY);
		return;
	}

	int page = GetLocalInt(oPC, "kemo_auction_page");
	
	int pageCount = 0;
	int resultCount = 0;

	int lastItem = page * AUCTION_PAGE_SIZE;
	int firstItem = lastItem - AUCTION_PAGE_SIZE;
	
	while (oItem != OBJECT_INVALID)
	{
		iCounter++; sCounter = IntToString(iCounter);
		if (CheckTag(oItem)) //checks for forbidden items, prevents listing
		{
				// Search over all pages and filter the results into pages.
				if (resultCount >= firstItem && resultCount < lastItem)
				{
					sStorageVar = "TempAuctionObject" + sCounter;
					sIcon = "SellPaneIcon=" + GetSaleItemIcon(oItem);
					sName = "SellPaneName=" + GetName(oItem) + " (" + IntToString(GetNumStackedItems(oItem)) + ")";
					sVariables = "7="+sCounter;

					pageCount++;
					AddListBoxRow(oPC,"KEMO_AUCTION","KEMO_AUCTION_SELL","Row"+sCounter,sName,sIcon,sVariables,"");
					SetLocalObject(oPC,sStorageVar,oItem);
				}
				resultCount++;
		}
		oItem = GetNextItemInInventory(oPC);
	}
	
	string sItemOfTotal = "Showing item " + IntToString(firstItem + 1) + " to " + IntToString(firstItem + pageCount) + " of " + IntToString(resultCount) + " items";
	
	if (pageCount == 0 && page == 1) SetGUIObjectHidden(oPC,"KEMO_AUCTION","PagePane",TRUE);
	else SetGUIObjectText(oPC,"KEMO_AUCTION","ItemsOfTotal",-1,sItemOfTotal);
	
	SetLocalInt(oPC, "kemo_auction_list_size", resultCount);
}
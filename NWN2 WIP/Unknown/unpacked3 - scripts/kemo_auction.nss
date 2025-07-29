// called from kemo_auction_conv

void main()
{
	object oPC = GetPCSpeaker();
	object oAuctioneer = OBJECT_SELF;
	
	
	switch (d4())
	{
		case 1: PackCampaignDatabase("kemo_arms_auction_db"); break;
		case 2: PackCampaignDatabase("kemo_armor_auction_db"); break;
		case 3: PackCampaignDatabase("kemo_misc_auction_db"); break;
		case 4: PackCampaignDatabase("kemo_craft_auction_db"); break;
	}

	DisplayGuiScreen(oPC,"KEMO_AUCTION",FALSE,"kemo_auction.xml");
	ClearListBox(oPC,"KEMO_AUCTION","KEMO_AUCTION_BUY");
	SetLocalString(oAuctioneer,"CurrentUser",GetTag(oPC));
	//ExecuteScript("gui_kemo_auction_list",oPC);
}
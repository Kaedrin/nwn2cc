#include "kemo_auction_includes"

void main(string sAuction)
{
	object oPC = OBJECT_SELF;

	SetLocalString(oPC, "kemo_auction_mode", "buy");

	SetLocalInt(oPC, "kemo_auction_page", 1);
	
	if (sAuction == "Arms") SetLocalString(oPC,"Auctioneer","kemo_arms_auction");
	if (sAuction == "Armor") SetLocalString(oPC,"Auctioneer","kemo_armor_auction");
	if (sAuction == "Misc") SetLocalString(oPC,"Auctioneer","kemo_misc_auction");
	if (sAuction == "Craft") SetLocalString(oPC,"Auctioneer","kemo_craft_auction");

	//this section needed mainly for localization purposes
	if (sAuction == "Arms") sAuction = AUCTION_ARMS_TEXT;
	if (sAuction == "Armor") sAuction = AUCTION_ARMOR_TEXT;
	if (sAuction == "Misc") sAuction = AUCTION_MISC_TEXT;
	if (sAuction == "Craft") sAuction = AUCTION_CRAFT_TEXT;
	
	SetGUIObjectText(oPC,"KEMO_AUCTION","AuctionTitle",-1, sAuction);
	ExecuteScript("gui_kemo_auction_list",oPC);
}
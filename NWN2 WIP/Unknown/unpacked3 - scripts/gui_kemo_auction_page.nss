#include "kemo_auction_includes"

void main(int increase)
{
	// Keeps the hacks away.
	if (increase != 1 && increase != -1)
		return;

   	object oPC = OBJECT_SELF;
	int page = GetLocalInt(oPC, "kemo_auction_page") + increase;
	
	// No negative pages.
	if (page < 1)
		page = 1;

	// No infinite pages.
	int iListTotal = GetLocalInt(oPC, "kemo_auction_list_size");
	if ((page - 1) * AUCTION_PAGE_SIZE >= iListTotal)
		page = ((iListTotal - 1) / AUCTION_PAGE_SIZE) + 1;

	// Prevents unneeded reloads
	if (page == GetLocalInt(oPC, "kemo_auction_page"))
		return;
	
	SetLocalInt(oPC, "kemo_auction_page", page);
	
	if ( GetLocalString(oPC, "kemo_auction_mode") == "buy" )
		ExecuteScript("gui_kemo_auction_list",OBJECT_SELF);
	else
		ExecuteScript("gui_kemo_auction_sell",OBJECT_SELF);
}
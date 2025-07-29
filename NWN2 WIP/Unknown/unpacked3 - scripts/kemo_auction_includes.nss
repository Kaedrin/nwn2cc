#include "ginc_param_const"
#include "nwnx_clock" 

// percentage that the auctioneer charges to post a sale (or takes from sale price if COMMISSION_EXTRACT_POINT = 1)
const float COMMISSION_PERCENTAGE = 0.15f;

// the divisor in the auctioneers variable commission scheme (see COMMISSION_USE_VALUE below)
const int VARIABLE_COMMISSION_DIVISOR = 5;

// minimum and maximum commission
const int COMMISSION_MINIMUM = 100;
const int COMMISSION_MAXIMUM = 1000000;

// how the commission is calculated: 
// 0 = sale price selected by player * COMMISSION_PERCENTAGE
// 1 = value of the item * COMMISSION_PERCENTAGE
// 2 = (greater of sale price and item value) * COMMISSION_PERCENTAGE
// 3 = COMMISSION_SET_VALUE
// 4 = variable commission: salePrice * (salePrice/(VARIABLE_COMMISSION_DIVISOR * itemValue)) 
const int COMMISSION_USE_VALUE = 0;

// use only if COMMISSION_USE_VALUE = 3
const int COMMISSION_SET_VALUE = 0;

// switch for when the commission is taken: 0 for when the item is posted, 1 for when it's sold
// if set to 1, the commission will be calculated using COMMISSION_USE_VALUE = 0
const int COMMISSION_EXTRACT_POINT = 0;

// minimum and maximum sale price relative to item value
const float MIN_PRICE_MULTIPLIER = 0.0f;
const float MAX_PRICE_MULTIPLIER = 100.0f;

// number of days until a sale item expires
const int EXPIRATION_IN_DAYS = 7;

// number of sales a PC may have in each of the 4 categories
const int MAX_SALES_PER_CHAR = 10;

// total number of sales allowed in each of the 4 categories
const int MAX_SALES_TOTAL = 125;

// cannot post a non-specific material weapon below this value
const int MIN_NONSPECIFIC_WEAPON_VALUE = 1800;

// cannot post a non-specific material armor below this value
const int MIN_NONSPECIFIC_ARMOR_VALUE = 2500;

// cannot post an iron armor below this value
const int MIN_IRON_ARMOR_VALUE = 2500;

// prevent players from selling to themselves, by various methods:
// A = prevent by CD Key
// B = prevent by Player name
// C = prevent by IP
// set to 1 to use the method
const int EXPLOIT_PREVENTION_SWITCH_A = 0;
const int EXPLOIT_PREVENTION_SWITCH_B = 0;
const int EXPLOIT_PREVENTION_SWITCH_C = 0;

// number of items on one page
const int AUCTION_PAGE_SIZE = 6;

// string constants for easier localization

const string YOU_CURRENTLY_HAVE = "You currently have ";
const string ACTIVE_AUCTIONS = " active auctions";
const string WITHIN_5_MINUTES = "within 5 minutes";
const string WITHIN_10_MINUTES = "within 10 minutes";
const string WITHIN_HALF_HOUR = "within 1/2 hour";
const string WITHIN_ONE_HOUR = "within 1 hour";
const string WITHIN_ONE_DAY = "within 1 day";
const string ONE_DAY_AGO = "1 day ago";
const string TWO_DAYS_AGO = "2 days ago";
const string THREE_DAYS_AGO = "3 days ago";
const string FOUR_DAYS_AGO = "4 days ago";
const string FIVE_DAYS_AGO = "5 days ago";
const string SIX_DAYS_AGO = "6 days ago";
const string NOT_ENOUGH_GOLD = "You do not have enough gold on hand to buy this item.";
const string NOT_ENOUGH_GOLD_COMM = "You do not have enough gold to pay for the commission.";
const string NO_SEMICOLONS = "You may not sell items with semicolons in their names.";
const string TO_PREVENT_EXPLOITS = "((To prevent exploits, you are not permitted to buy items from this seller.))";
const string ITEM_HAS_SOLD = "One or more of your items has sold!";
const string ITEM_HAS_EXPIRED = "One of your sales has expired.";
const string AUCTION_ARMS_TEXT = "KEMO Auction: Arms";
const string AUCTION_ARMOR_TEXT = "KEMO Auction: Armor";
const string AUCTION_MISC_TEXT = "KEMO Auction: Misc";
const string AUCTION_CRAFT_TEXT = "KEMO Auction: Craft";
const string AUCTION_SELL_TEXT = "KEMO Auction: Sell";
const string MAY_LIST_MAXIMUM = "You may only list a maximum of ";
const string ITEMS_AT_ONE_TIME = " items at one time.";
const string MAX_ITEMS_REACHED = "The maximum amount of items has been reached: ";
const string MAY_NOT_SELL = "You may not sell this item.";
const string THIS_ITEM_VALUED = "This item is valued at ";
const string GOLD_ABBREVIATION = "g.";
const string POSTING_COMMISSION_WOULD_BE = "The posting commission would be ";
const string POSTING_COMMISSION_AT_LEAST = "The posting commission would be at least ";
const string PERCENT_OF_SALE_PRICE = "% of the sale price, minimum ";
const string LESS_THAN_ONE_PERCENT = "The posting commission would be less than 1% of the sale price, minimum ";
const string TOO_FAR_AWAY = "You are too far away from the auction book.";

// Checks the tag of the item being sold for forbidden tags
int CheckTag(object oItem)
{

	//If you want to prevent players from selling certain items (such as keys), add their tags here:
	string sItemTag = GetTag(oItem);
	if (FindSubString(sItemTag,"key") > -1 || GetItemCursedFlag(oItem)) return FALSE;
	if(GetIsObjectValid(oItem))
	{
	        if (GetWeaponType(oItem) != WEAPON_TYPE_NONE) {
	            if ((GetItemBaseMaterialType(oItem) == GMATERIAL_NONSPECIFIC) &&
	                (GetGoldPieceValue(oItem) < MIN_NONSPECIFIC_WEAPON_VALUE)) 
	                return FALSE;
	        }
	        if (GetArmorRank(oItem) != ARMOR_RANK_NONE) {
	            if ((GetItemBaseMaterialType(oItem) == GMATERIAL_NONSPECIFIC) &&
	                (GetGoldPieceValue(oItem) < MIN_NONSPECIFIC_ARMOR_VALUE)) 
	                return FALSE;
	            if ((GetItemBaseMaterialType(oItem) == GMATERIAL_METAL_IRON) &&
	                (GetGoldPieceValue(oItem) < MIN_IRON_ARMOR_VALUE)) 
	                return FALSE;
	        }
		itemproperty iProp = GetFirstItemProperty(oItem);
		while (GetIsItemPropertyValid(iProp))
		{
			if (GetItemPropertyDurationType(iProp) == DURATION_TYPE_TEMPORARY)
			return FALSE;
			iProp = GetNextItemProperty(oItem);	
		}
		return TRUE;
	}
	else return FALSE;
}

string GetSellerID(object oPC)
{
	return GetSubString(GetPCPlayerName(oPC), 0, 12)
				+ "_" + GetSubString(GetFirstName(oPC), 0, 6)
				+ "_" + GetSubString(GetLastName(oPC), 0, 9);
}

// Retrieves the icon of an item
string GetSaleItemIcon(object oItem)
{
	string sIcon = Get2DAString("nwn2_icons","ICON",GetItemIcon(oItem));
	return sIcon == "" ? "temp0.tga" : sIcon + ".tga";
}

//identify the type of item being sold, make sure it's going to the correct auction panel
string SetCorrectAuctioneer(object oItem)
{
	string sType;
	switch (GetBaseItemType(oItem))
	{
		case 0: case 1: case 2: case 3: case 4: case 5: case 6:
		case 7: case 8: case 9: case 10: case 11: case 12: case 13: sType = "kemo_arms_auction"; break;
		case 14: sType = "kemo_armor_auction"; break;
		case 15: sType = "kemo_misc_auction"; break;
		case 16: case 17: sType = "kemo_armor_auction"; break;
		case 18: sType = "kemo_arms_auction"; break;
		case 19: sType = "kemo_misc_auction"; break;
		case 20: sType = "kemo_arms_auction"; break;
		case 21: sType = "kemo_misc_auction"; break;
		case 22: sType = "kemo_arms_auction"; break;
		case 24: sType = "kemo_misc_auction"; break;
		case 25: sType = "kemo_arms_auction"; break;
		case 26: sType = "kemo_armor_auction"; break;
		case 27: case 28: sType = "kemo_arms_auction"; break;
		case 29:  sType = "kemo_misc_auction"; break;
		case 31: case 32: case 33: sType = "kemo_arms_auction"; break;
		case 34: sType = "kemo_misc_auction"; break;
		case 35: sType = "kemo_arms_auction"; break;
		case 36: sType = "kemo_armor_auction"; break;
		case 37: case 38: case 40: case 41: case 42: sType = "kemo_arms_auction"; break;
		case 43: sType = "kemo_misc_auction"; break;
		case 44: case 45: case 46: case 47: sType = "kemo_arms_auction"; break;
		case 49: sType = "kemo_misc_auction"; break;
		case 50: case 51: sType = "kemo_arms_auction"; break;
		case 52: sType = "kemo_misc_auction"; break;
		case 53: sType = "kemo_arms_auction"; break;
		case 54: sType = "kemo_misc_auction"; break;
		case 55: sType = "kemo_arms_auction"; break;
		case 56: case 57: sType = "kemo_armor_auction"; break;
		case 58: case 59: case 60: case 61: sType = "kemo_arms_auction"; break;
		case 62: sType = "kemo_misc_auction"; break;
		case 63: sType = "kemo_arms_auction"; break;
		case 64: case 66: case 68: sType = "kemo_misc_auction"; break;
		case 69: case 70: case 71: case 72: sType = "kemo_arms_auction"; break;
		case 74: case 75: sType = "kemo_misc_auction"; break;
		case 77: sType = "kemo_craft_auction"; break;
		case 78: sType = "kemo_armor_auction"; break;
		case 79: case 80: sType = "kemo_misc_auction"; break;
		case 81: sType = "kemo_arms_auction"; break;
		case 101: case 102: case 103: sType = "kemo_craft_auction"; break;
		case 104: case 105: case 106: sType = "kemo_misc_auction"; break;
		case 108: sType = "kemo_arms_auction"; break;
		case 109: case 110: sType = "kemo_craft_auction"; break;
		case 111: case 113: case 114: case 116:
		case 119: case 120: case 124: case 126: sType = "kemo_arms_auction"; break;
		case 128: case 129: case 132: sType = "kemo_misc_auction"; break;
		case 140: case 141: case 142: sType = "kemo_arms_auction"; break;
		default: sType = "kemo_misc_auction"; break;
	}
	return sType;
}

object GetItemFromList(object oPC, string sItemNumber)
{
	string sStorageVar = "TempAuctionObject" + sItemNumber;
	return GetLocalObject(oPC,sStorageVar);
}

string GetPostLength(string sPostSeconds)
{
	int iNow = GetUNIXTime();
	int iThen = StringToInt(sPostSeconds);
	int iPeriod = iNow - iThen;
	
	if (iPeriod <= 60) return "1 minute ago";
	else if (iPeriod <= 300) return WITHIN_5_MINUTES;
	else if (iPeriod <= 600) return WITHIN_10_MINUTES;
	else if (iPeriod <= 1800) return WITHIN_HALF_HOUR;
	else if (iPeriod <= 3600) return WITHIN_ONE_HOUR;
	else if (iPeriod <= 86400) return WITHIN_ONE_DAY;
	else if (iPeriod < 172800) return ONE_DAY_AGO;
	else if (iPeriod < 259200) return TWO_DAYS_AGO;
	else if (iPeriod < 345600) return THREE_DAYS_AGO;
	else if (iPeriod < 432000) return FOUR_DAYS_AGO;
	else if (iPeriod < 518400) return FIVE_DAYS_AGO;
	else if (iPeriod < 604800) return SIX_DAYS_AGO;
	else return "Expired";
}

// Returns the sale item's properties
string GetSaleProperties(object oItem)
{
	string sProperties = "";
	
	itemproperty ipProperty = GetFirstItemProperty(oItem);
	int iPropType; int iLength;

	while (GetIsItemPropertyValid(ipProperty))
	{
		iPropType = GetItemPropertyType(ipProperty);
		sProperties = sProperties + IntToString(iPropType) + ",";
		ipProperty = GetNextItemProperty(oItem);
	}
	iLength = GetStringLength(sProperties);
	sProperties = GetStringLeft(sProperties,iLength-1);
	return sProperties;
}

void AuctionSaleNumber(object oPC)
{
	string sSellerID = GetSellerID(oPC);
	string sTag = GetLocalString(oPC,"Auctioneer"); string sDB = sTag + "_db";
	string sListTotal = "ListTotal"+sSellerID;
	int iListTotal = GetCampaignInt(sDB,sListTotal);
	string sAuctionCount = IntToString(iListTotal);
	
	SetGUIObjectText(oPC,"KEMO_AUCTION","AuctionCount",-1,YOU_CURRENTLY_HAVE + sAuctionCount + ACTIVE_AUCTIONS);
}

int CheckExploit(object oPC, string sItem)
{
	string sCD = GetStringParam(sItem,7,";");
	string sPlayer = GetStringParam(sItem,8,";");
	string sIP = GetStringParam(sItem,9,";");
	
	if (EXPLOIT_PREVENTION_SWITCH_A && sCD == GetPCPublicCDKey(oPC)) return TRUE;
	if (EXPLOIT_PREVENTION_SWITCH_B && sPlayer == GetPCPlayerName(oPC)) return TRUE;
	if (EXPLOIT_PREVENTION_SWITCH_C && sIP == GetPCIPAddress(oPC)) return TRUE;
	return FALSE;
}
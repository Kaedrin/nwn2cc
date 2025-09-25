//kinc_trade_constants 
//trading system constants
//nchapman 1/21/08

// -------------------------------------------------------
// Constants
// -------------------------------------------------------
//STRREF Constants
const int STRREF_GAINED_CARGO_FEEDBACK = 226895;
const int STRREF_LOST_CARGO_FEEDBACK = 226896;
const int STRREF_TRADE_BARS = 217008;

//2DA Filename Constants
const string GOODS_2DA = "nx2_gooddef";
const string RES_2DA = "nx2_rresdef";
const string ECON_2DA = "nx2_economy";
const string WAGON_2DA = "nx2_wagons";
const string RES_NODE_2DA = "nx2_resnodes";
const string COMPANY_LEVEL_2DA = "nx2_company_levels";
const string NX2_CRAFTING_2DA = "nx2_crafting";
const string NX2_ENCHANTING_2DA = "nx2_enchanting";
const string CARAVAN_DESC_2DA = "nx2_caravan_descriptions";
const string CARAVAN_PRICE_2DA = "nx2_caravan_price";
const string CARAVAN_INCOME_2DA = "nx2_caravan_income";

//Variable Names
const string VAR_COMPANY_LEVEL = "00_nCompanyLevel";
const string VAR_COMPANY_RESERVE = "00_nCompanyReserve";
const string VAR_CARAVAN_SPAWN_STRING = "sCaravanSpawn";
const string VAR_CARAVAN_PREFIX = "CARAVAN_STATE_";

//Caravan Constants
const int CARAVAN_STATE_NONE				= 0;
const int CARAVAN_STATE_CONSTRUCTING		= 1000;
const int CARAVAN_STATE_UPGRADING_2			= 2000;
const int CARAVAN_STATE_UPGRADING_3			= 3000;
const int CARAVAN_STATE_IN_TRANSIT_LOWER	= 5000;
const int CARAVAN_STATE_IN_TRANSIT_HIGHER	= 6000;
const int CARAVAN_STATE_REFILL				= 8000;
const int CARAVAN_STATE_WAYLAID				= 9000;

//Crafting Constants
const float CRAFTING_PLC_SEARCH_DIST = 10.0f;		//The distance, in meters, that the player must be from prereq placeables to craft.
const int CRAFTING_FAILURE_RECIPE 		= 225392;
const int CRAFTING_FAILURE_GOLD 		= 225393;
const int CRAFTING_FAILURE_BARS			= 225394;
const int CRAFTING_FAILURE_ITEM			= 225395;
const int CRAFTING_FAILURE_GOOD			= 225396;
const int CRAFTING_FAILURE_RES			= 225397;
const int CRAFTING_FAILURE_SPELL		= 225398;
const int CRAFTING_FAILURE_PREREQ_ITEM	= 225399;
const int CRAFTING_FAILURE_FEAT			= 225400;
const int CRAFTING_FAILURE_PLC			= 225401;
const int CRAFTING_FAILURE_SKILL		= 225402;
const int CRAFTING_FAILURE_INV_IPRP		= 234315;
const int CRAFTING_FAILURE_MAX_IPRP		= 234316;
const int CRAFTING_FAILURE_CLVL			= 234317;

//Shortage/Surplus Constants
const string SHORTAGE_SUFFIX = "_SHORTAGE";
const string SURPLUS_SUFFIX = "_SURPLUS";
const int PANIC_CHANCE = 5;
const int BASE_PANIC_LOSS = 20;
const int OVERAGE_CHANCE = 5;
const int BASE_OVERAGE_GAIN = 10;
const int BASE_SHORTAGE_AMT = 10;
const int BASE_SURPLUS_AMT = 50;
const int BASE_REGEN_LOW = 2;
const int BASE_REGEN_MED = 5;
const int BASE_REGEN_HIGH = 10;
const int BASE_EQ_LOW = 20;
const int BASE_EQ_MED = 30;
const int BASE_EQ_HIGH = 40;

//Equilibrium And Stock Formula Constants
const int TOWN_STOCK_MULT = 5;
const int CITY_STOCK_MULT = 10;

//Company Levels
const int COMPANY_LEVEL_1 = 1;
const int COMPANY_LEVEL_2 = 2;
const int COMPANY_LEVEL_3 = 3;
const int COMPANY_LEVEL_4 = 4;
const int COMPANY_LEVEL_5 = 5;
const int COMPANY_LEVEL_6 = 6;
const int COMPANY_LEVEL_7 = 7;

//Income Constants
const int BASE_INCOME = 20;

//Commodity Constants
const int NUM_TRADE_GOODS = 3;
const string PARTY_PREFIX = "PARTY_";
const string TEMP_SUFFIX = "_TEMP";
const string STORAGE_PREFIX = "STORAGE_";
const string SHIPPING_PREFIX = "SHIPPING_";

//Trade Good Index Constants - These correspond to rows in nx2_goodref.2da
const int GOOD_ORE = 1;
const int GOOD_TIMBER = 2;
const int GOOD_SKINS = 3;
//const int GOOD_INGOTS = 4;
//const int GOOD_LUMBER = 5;
//const int GOOD_LEATHER = 6;

//Rare Resource Constants - These correspond to rows in nx2_rresdef.2da
const int RES_C_IRON = 1;
const int RES_ADMN = 2;
const int RES_DSTEEL = 3;
const int RES_MITHRAL = 4;
const int RES_SALT = 5;
const int RES_HERBS = 6;
const int RES_IVORY = 7;
const int RES_A_SILVER = 8;
const int RES_H_MEAD = 9;
const int RES_D_MEAD = 10;
const int RES_ZAL = 11;
const int RES_SILK = 12;
const int RES_ORE = 13;
const int RES_LUMBER = 14;
const int RES_SKINS = 15;

//Price Constants
const int PRICE_LOW = 1;
const int PRICE_MED = 2;
const int PRICE_HIGH = 3;
const int TRADE_BAR_EXCHANGE_RATE = 15;

//Location Constants - These correspond to rows in nx2_economy.2da
const int LOC_DEBUG			= 0;
const int LOC_NEVERWINTER	= 1;
const int LOC_LEILON		= 2;
const int LOC_CONYBERRY		= 3;
const int LOC_NEWLEAF		= 4;
const int LOC_HIGHCLIFF		= 5;
const int LOC_PHANDALIN		= 6;
const int LOC_THUNDERTREE	= 7;
const int LOC_PORTLLAST		= 8;
const int LOC_WESTHARBOR	= 9;
const int LOC_SAMARGOL		= 10;
const int LOC_TARUIN		= 11;
const int LOC_TORICH		= 12;
const int LOC_RASSATAN		= 13;

//Location Size Constants
const int SIZE_VILLAGE = 1;
const int SIZE_TOWN = 2;
const int SIZE_CITY = 3;

//Wagon Constants - These correspond to rows in nx2_wagons.2da
const int WAGON_1 = 1;
const int WAGON_2 = 2;
const int WAGON_3 = 3;

// UI Constants
const string GUI_MARKET_SCREEN = "MARKET_SCREEN";
const string GUI_MARKET_XML = "nx2_market.xml";
const string GUI_MINIMARKET_XML = "nx2_minimarket.xml";
const string GUI_TURNIN_SCREEN = "TURNIN_SCREEN";
const string GUI_TURNIN_XML = "nx2_turnin.xml";
const string GUI_STORAGE_SCREEN = "SCREEN_STORAGE";
const string GUI_STORAGE_XML = "nx2_storage.xml";
const string GUI_CARAVAN_SCREEN = "SCREEN_CARAVAN";
const string GUI_CARAVAN_XML = "nx2_caravan.xml";
const string GUI_TRADE_INV_SCREEN = "SCREEN_TRADE_INVENTORY";
const string GUI_TRADE_INV_XML = "nx2_trade_inv.xml";
const string GUI_SHIPPING_SCREEN = "SCREEN_SHIPPING";
const string GUI_SHIPPING_XML = "nx2_shipping.xml";

//Caravan UI Strings
const string GUI_CARAVAN_SOURCE_LB = "CARAVAN_SOURCE_LB";
const string GUI_CARAVAN_DEST_LB = "CARAVAN_DEST_LB";
const string GUI_CARAVAN_TEXT_LB = "CARAVAN_TEXT_LB";

//Market UI Strings
const string GUI_MARKET_TITLE = "SCENE_TITLE";
const string GUI_MARKET_TRADE_GOOD_LB = "TRADE_GOOD_LB";
const string GUI_MARKET_RARE_RES_LB = "RARE_RES_LB";
const string GUI_MARKET_PARTY_BARS_TEXT = "PARTY_BARS_TEXT";
const string GUI_MARKET_PARTY_CARGO_TEXT = "PARTY_CARGO_TEXT";
const string GUI_MARKET_PRICE_ORE = "ORE_PRICE_TEXT";
const string GUI_MARKET_PRICE_TIMBER = "TIMBER_PRICE_TEXT";
const string GUI_MARKET_PRICE_SKINS = "SKINS_PRICE_TEXT";
const string GUI_MARKET_PRICE_INGOTS = "INGOTS_PRICE_TEXT";
const string GUI_MARKET_PRICE_LUMBER = "LUMBER_PRICE_TEXT";
const string GUI_MARKET_PRICE_LEATHER = "LEATHER_PRICE_TEXT";
const string GUI_MARKET_PARTY_ORE = "ORE_PARTY_TEXT";
const string GUI_MARKET_PARTY_TIMBER = "TIMBER_PARTY_TEXT";
const string GUI_MARKET_PARTY_SKINS = "SKINS_PARTY_TEXT";
const string GUI_MARKET_PARTY_INGOTS = "INGOTS_PARTY_TEXT";
const string GUI_MARKET_PARTY_LUMBER = "LUMBER_PARTY_TEXT";
const string GUI_MARKET_PARTY_LEATHER = "LEATHER_PARTY_TEXT";
const string GUI_MARKET_RARE_BUTTON = "SHOW_RARE";
const string GUI_MARKET_GOODS_BUTTON = "SHOW_GOODS";

//Trade Inventory UI Strings
const string GUI_TRADE_INV_GOOD_LB = "TRADE_GOOD_INV_LB";
const string GUI_TRADE_INV_RARE_LB = "RARE_RES_INV_LB";

//Turn IN UI Strings
const string GUI_TURNIN_PARTY_BARS_TEXT = "PARTY_BARS_TEXT";
const string GUI_TURNIN_SCROLLBAR = "TURN_IN_BAR_SLIDER";
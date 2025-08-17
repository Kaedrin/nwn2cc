//	m01_a_teleport_sc
/*
	Applies the teleport effect to the party and jumps them outside one of the towns in 
	the Sword Coast map.
*/
//	JSH-OEI 03/06/08

#include "ginc_companion"
#include "kinc_trade_constants"
#include "ginc_overland"
void main(int nDestination)
{
	object oPC			= GetFirstPC();	
	string sDestWP		= "f20_wp_from_m01";
	string sMap;
	string sOrigin;
	string sModuleName	= "F_X2";
		
	switch(nDestination)
	{
		case 100:	//	Neverwinter
			SetGlobalInt("TradingPostIndex", LOC_NEVERWINTER);
			SetGlobalInt("00_nLocationIndex", 1);
			sModuleName	= "N_X2";
			break;
		case 200:	//	Leilon
			SetGlobalInt("TradingPostIndex", LOC_LEILON);
			SetGlobalString(sMap, "f_leilon");
			SetGlobalString(sOrigin, "LeilonTradingPost");
			SetGlobalInt("00_nLocationIndex", 2);
			break;
		case 300:	//	Conyberry
			SetGlobalInt("TradingPostIndex", LOC_CONYBERRY);
			SetGlobalString(sMap, "f_conyberry");
			SetGlobalString(sOrigin, "ConyberryTradingPost");
			SetGlobalInt("00_nLocationIndex", 3);
			break;
		case 400:	//	New Leaf
			SetGlobalInt("TradingPostIndex", LOC_NEWLEAF);
			SetGlobalString(sMap, "f_newleaf");
			SetGlobalString(sOrigin, "NewLeafTradingPost");
			SetGlobalInt("00_nLocationIndex", 4);
			break;
		case 500:	//	Highcliff
			SetGlobalInt("TradingPostIndex", LOC_HIGHCLIFF);
			SetGlobalString(sMap, "f_highcliff");
			SetGlobalString(sOrigin, "HighcliffTradingPost");
			SetGlobalInt("00_nLocationIndex", 5);
			break;
		case 600:	//	Phandalin
			SetGlobalInt("TradingPostIndex", LOC_PHANDALIN);
			SetGlobalString(sMap, "f_phandalin");
			SetGlobalString(sOrigin, "PhandalinTradingPost");
			SetGlobalInt("00_nLocationIndex", 6);
			break;
		case 700:	//	Thundertree
			SetGlobalInt("TradingPostIndex", LOC_THUNDERTREE);
			SetGlobalString(sMap, "f_thundertree");
			SetGlobalString(sOrigin, "ThundertreeTradingPost");
			SetGlobalInt("00_nLocationIndex", 7);
			break;
		case 800:	//	Port Llast
			SetGlobalInt("TradingPostIndex", LOC_PORTLLAST);
			SetGlobalString(sMap, "f_portllast");
			SetGlobalString(sOrigin, "PortLlastTradingPost");
			SetGlobalInt("00_nLocationIndex", 8);
			sModuleName = "S_X2";
			break;
		case 900:	//	West Harbor
			SetGlobalInt("TradingPostIndex", LOC_WESTHARBOR);
			SetGlobalString(sMap, "f_westharbor");
			SetGlobalString(sOrigin, "WestHarborTradingPost");
			SetGlobalInt("00_nLocationIndex", 9);
			sModuleName = "T_X2";
			break;
		default:
			break;
	}
	ExitOverlandMap(oPC);		
	SaveRosterLoadModule(sModuleName, sDestWP);		
}
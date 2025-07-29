#include "kemo_auction_includes"

void AuctionRetrieve(string sTag, string sSellerID)
{
	object oPC = OBJECT_SELF;
	object oExpired;

	
	string sDB = sTag + "_db";

	//gets gold from the auctioneer, gives to PC
	int iGold = GetCampaignInt(sDB,sSellerID);

	int iAnnounce = 0; int iCommission = 0;
	
	if (iGold != 0)
	{
		iAnnounce++;
		if (!iAnnounce) SendMessageToPC(oPC, ITEM_HAS_SOLD);

		if (COMMISSION_EXTRACT_POINT == 1)
		{	iCommission = FloatToInt(iGold * COMMISSION_PERCENTAGE);
			if (iCommission < COMMISSION_MINIMUM) iCommission = COMMISSION_MINIMUM;
			if (iCommission > COMMISSION_MAXIMUM) iCommission = COMMISSION_MAXIMUM;

			iGold = iGold - iCommission;
		}

		GiveGoldToCreature(oPC,iGold);
		SetCampaignInt(sDB,sSellerID,0);
	}
	
	//retrieves expired sale items
	int iExpireCheck = 1; string sExpireVar;
	while (iExpireCheck <= MAX_SALES_PER_CHAR)
	{
		sExpireVar = "Exp" + sSellerID + "_" + IntToString(iExpireCheck);
//		SendMessageToPC(oPC,"Expiration Slot: " + sExpireVar); //DEBUG
		oExpired = RetrieveCampaignObject(sDB,sExpireVar,GetLocation(oPC),oPC);
		object oExpiredCopy = CopyItem(oExpired,oPC,1);
		DestroyObject(oExpired);
		if (GetIsObjectValid(oExpired))
		{
			SendMessageToPC(oPC, ITEM_HAS_EXPIRED);
			DeleteCampaignVariable(sDB,sExpireVar);
		}
		iExpireCheck++;
	}
}

void main()
{
	object oPC = OBJECT_SELF;
	string sSellerID = GetSellerID(oPC);
	AuctionRetrieve("kemo_arms_auction",sSellerID);
	AuctionRetrieve("kemo_armor_auction",sSellerID);
	AuctionRetrieve("kemo_misc_auction",sSellerID);
	AuctionRetrieve("kemo_craft_auction",sSellerID);
}
void main (string sFilter)
{
	object oPC = OBJECT_SELF;
	
	if (sFilter != GetLocalString(oPC,"AuctionFilter"))
		SetLocalString(oPC,"AuctionFilter",sFilter);
}
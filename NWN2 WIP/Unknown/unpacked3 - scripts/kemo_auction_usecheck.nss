int StartingConditional()
{
	object oAuctioneer = OBJECT_SELF;
	object oPC = GetPCSpeaker();
	string sUser = GetLocalString(oAuctioneer,"CurrentUser");
	object oUser = GetNearestObjectByTag(sUser);
	
	if (sUser == "") return TRUE; // if no one has used the auctioneer yet, allow
	if (GetTag(oPC) == sUser) return TRUE; // if the last user is using again, allow
	
	// if the user is not logged in or is too far away, allow
	if (!GetIsObjectValid(oUser) || GetDistanceToObject(oUser) > 3.0f)
	{
		DeleteLocalString(oAuctioneer,"CurrentUser");
		return TRUE;
	}
	
	// otherwise, refuse
	return FALSE;
}
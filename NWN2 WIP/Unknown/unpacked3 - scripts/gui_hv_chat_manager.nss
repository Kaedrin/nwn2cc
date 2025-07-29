void UpdatePlayerList(object oPC, string sSearchString = "")
{
	string sPlayerName = "";

	// Clear list box
	ClearListBox(oPC, "hv_chat_manager", "playerslist");	

	// Go over all players
	object oPlayer = GetFirstPC();
	
	while (GetIsPC(oPlayer)) {
	
		// Get player name in lower case
		sPlayerName = GetStringLowerCase(GetName(oPlayer));
		
		// If it contains our search string, add it
		if ((sSearchString == "") || (FindSubString(sPlayerName, GetStringLowerCase(sSearchString)) != -1))
			AddListBoxRow(oPC, "hv_chat_manager", "playerslist", GetName(oPlayer), "playername= /t " + GetName(oPlayer), "", "", "");
		
		oPlayer = GetNextPC();
	}
}

void main(string sSearchString)
{
	if (!GetIsDM(OBJECT_SELF))
		return;
		
	object oPC = OBJECT_SELF;
	UpdatePlayerList(oPC, sSearchString);
}
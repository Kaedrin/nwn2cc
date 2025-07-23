// called from kemo_storage_conv

string GetPCID(object oPC)
{
	return GetSubString(GetPCPlayerName(oPC), 0, 12)
				+ "_" + GetSubString(GetFirstName(oPC), 0, 6)
				+ "_" + GetSubString(GetLastName(oPC), 0, 9);
}

void main()
{
	object oPC = GetPCSpeaker();
	string sDB = GetPCID(oPC) + "_storage";
	
	if (d20() == 1) PackCampaignDatabase(sDB); // packs database 5% of the time

	DisplayGuiScreen(oPC,"KEMO_STORAGE",FALSE,"kemo_storage.xml");
	ClearListBox(oPC,"KEMO_STORAGE","KEMO_STORAGE_RETRIEVE");
	ExecuteScript("gui_kemo_storage_list",oPC);
}
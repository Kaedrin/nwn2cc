void main(string sAction, string sEntry)
{
	object oPC = OBJECT_SELF;
	string sDB; string sBio;
	
	if (sAction == "save")
	{
		sDB = GetSubString(GetPCPlayerName(oPC), 0, 12) +
			"_" + GetSubString(GetFirstName(oPC), 0, 6) +
			"_" + GetSubString(GetLastName(oPC), 0, 9);
		SetCampaignString(sDB,"Bio",sEntry);
		SetDescription(oPC, sEntry);
		CloseGUIScreen(oPC,"KEMO_BIO_EDIT");
		return;
	}
	
	else if (sAction == "load")
	{
		sDB = GetSubString(GetPCPlayerName(oPC), 0, 12) +
			"_" + GetSubString(GetFirstName(oPC), 0, 6) +
			"_" + GetSubString(GetLastName(oPC), 0, 9);
		sBio = GetCampaignString(sDB,"Bio");
		SetGUIObjectText(oPC,"KEMO_BIO_EDIT","INPUT_BIOTEXT",-1,sBio);
	}
	
	else if (sAction == "display")
	{
		DisplayGuiScreen(oPC,"KEMO_BIO_EDIT",FALSE,"kemo_bio_edit.xml");
	}
}
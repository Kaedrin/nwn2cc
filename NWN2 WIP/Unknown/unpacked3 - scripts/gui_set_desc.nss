void main(string sEvent, string sDesc)
{
	object oPC = OBJECT_SELF;
	
	// Set player name
	if (sEvent == "2") {
		string sFirstName = GetFirstName(oPC);
		string sLastName = GetLastName(oPC);
		string sFullName = sFirstName + " " + sLastName;
		SetGUIObjectText(oPC, "hvchangedesc", "DESC_EDIT_ITEM_NAME_TEXT", -1, sFullName);
		return;
	}
	
	// Clear text
	if (sEvent == "1") {
		SetGUIObjectText(oPC, "hvchangedesc", "descbox", -1, "");
		return;
	}
	
	// Set new description
	SetDescription(oPC, sDesc);
	SendMessageToPC(oPC, "Description changed.");
}
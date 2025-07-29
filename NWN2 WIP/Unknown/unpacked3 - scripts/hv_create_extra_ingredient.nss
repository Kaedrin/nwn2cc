void main()
{
	object oPC = GetLastUsedBy();
	if ((GetLocalInt(oPC, "hv_herb") == 0) && (GetJournalEntry("hv_beastmen", oPC) > 399) && (GetJournalEntry("hv_beastmen", oPC) < 420)) {
		SendMessageToPC(oPC, "Found another rare ingredient.");
		CreateItemOnObject("hv_extra_ingredient", oPC);
		SetLocalInt(oPC, "hv_herb", 1);
	}
	
}
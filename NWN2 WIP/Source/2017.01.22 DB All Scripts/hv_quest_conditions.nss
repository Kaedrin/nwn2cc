int StartingConditional(string sBookTag)
{
	// Make sure PC doesn't have the book
	object oPC = GetPCSpeaker();
	if (GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),sBookTag)) == 0) {
		// Check if PC has the quest
		int nEntry = GetJournalEntry("hv_historian", oPC);
		if ((nEntry > 300) && (nEntry < 304)) {
			return TRUE;
		}
	}
	
	return FALSE;
}
void main()
{
	//object oItem = GetObjectByTag("hv_ella_gem",0);
	//object oPC = GetItemPossessor(oItem);
	object oPC = GetLastKiller();
	if ((GetJournalEntry("ellas_uber_chicken",oPC) > 0) && (GetJournalEntry("ellas_uber_chicken",oPC) < 4))
	{
		AddJournalQuestEntry("ellas_uber_chicken", 4, oPC, FALSE, FALSE, FALSE);
	}
}
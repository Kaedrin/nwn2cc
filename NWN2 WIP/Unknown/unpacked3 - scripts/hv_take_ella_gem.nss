void main()
{
	// give ella_gem back to Ella
	object oItem = GetItemPossessedBy(GetPCSpeaker(),"hv_ella_gem");
	ActionTakeItem(oItem, GetPCSpeaker(), TRUE);
}
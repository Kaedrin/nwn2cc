void main()
{
	// give to the pc  the ella_gem
	object oItem = GetItemPossessedBy(OBJECT_SELF,"hv_ella_gem");
	ActionGiveItem(oItem, GetPCSpeaker(), TRUE);
}
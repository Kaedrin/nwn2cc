int StartingConditional()
{
	object oPC = GetPCSpeaker();
	return (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC)));
}
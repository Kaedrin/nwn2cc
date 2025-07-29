int StartingConditional()
{
	object oPC = GetPCSpeaker();
	object oNPC = OBJECT_SELF;
	return (GetObjectSeen(oPC, oNPC));
}
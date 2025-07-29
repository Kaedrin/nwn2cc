void main()
{
	if (!GetIsDM(OBJECT_SELF))
		return;
		
	object oTarget = GetPlayerCurrentTarget(OBJECT_SELF);

	if (GetIsPC(oTarget))
		return;

	object oNeutralNPC = GetObjectByTag("kemo_auctioneer");
	AssignCommand(oTarget, ClearAllActions(TRUE));
	ChangeFaction(oTarget, oNeutralNPC);
	SendMessageToPC(OBJECT_SELF, "Set faction to True Neutral.");
}
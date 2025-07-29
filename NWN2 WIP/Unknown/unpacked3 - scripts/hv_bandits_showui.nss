// Fire up password GUI for player (from conversation)
void main()
{
	object oPC = GetPCSpeaker();
	
	if (GetIsObjectValid(oPC))
		DisplayGuiScreen(oPC, "hv_bandits_password", FALSE, "hv_bandits_password.xml");
	else
		ActionStartConversation(GetLastUsedBy());
}
void main()
{
    object oPC = GetFirstPC();
    object oNPC = GetObjectByTag("algjoe");
    object oNPC2 = GetObjectByTag("algjoe2");
	object oNPC3 = GetObjectByTag("algjoe3");
	object oNPC4 = GetObjectByTag("algjoe4");
    AssignCommand(oNPC2, ActionStartConversation(oNPC, "pokertalk"));
}
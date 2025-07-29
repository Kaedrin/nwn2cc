void main() {
	object oPC = GetItemActivator();
	if (GetIsPC(oPC)) {
		AssignCommand(oPC,ActionStartConversation(oPC,"npc_chronos_device",TRUE,FALSE,TRUE,FALSE));
	}
}
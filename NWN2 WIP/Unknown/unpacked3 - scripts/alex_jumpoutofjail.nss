location lTarget;
object oTarget;

void main()
{

	object oPC = GetPCSpeaker();

   	oTarget = GetWaypointByTag("WP_ZB_out_2_SD");

   	lTarget = GetLocation(oTarget);

   	if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   	AssignCommand(oPC, ClearAllActions());

   	DelayCommand(10.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
	DelayCommand(45.0, SendMessageToPC(oPC, "You have been released from jail after paying a fine."));
	
	object oJailer = GetNearestObjectByTag("sd_jailor", oPC);
	DelayCommand(120.0, DestroyObject(oJailer));
}
void main()
{
 	object oPC = GetLastUsedBy();
	if (!GetIsPC(oPC)) return;
	object oTarget;
	location lTarget;
	string sTag = GetTag(OBJECT_SELF);
	oTarget=GetWaypointByTag("WP_"+sTag);
	lTarget = GetLocation(oTarget);

	//only do the jump if the location is valid.
	//though not flawless, we just check if it is in a valid area.
	//the script will stop if the location isn't valid - meaning that
	//nothing put after the teleport will fire either.
	//the current location won't be stored, either

	if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

	DelayCommand(1.0f, AssignCommand(oPC, ClearAllActions()));
	DelayCommand(2.0f, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
}
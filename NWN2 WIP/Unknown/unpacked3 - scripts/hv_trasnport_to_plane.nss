void main()
{	
	object oPC = GetLastUsedBy();
	AssignCommand(oPC, JumpToObject(GetWaypointByTag("hv_demiplane_wp")));
}
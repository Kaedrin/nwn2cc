void main()
{	
	object oPC = GetLastUsedBy();
	object oRandomWaypoint = GetLocalObject(OBJECT_SELF, "hv_avault_r_wp");
	AssignCommand(oPC, JumpToObject(oRandomWaypoint));
}
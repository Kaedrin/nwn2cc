void main()
{
	object oTarget = GetObjectByTag(GetLocalString(OBJECT_SELF, "Click_Target"));
	object oPlayer = GetLastUsedBy();
	AssignCommand(oPlayer, JumpToObject(oTarget));
}
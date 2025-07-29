void main()
{
	// add NPC to PC's party
	object oPC = GetLastSpeaker();
	AddHenchman(oPC);
	ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_DEFENDER);
	
	// create some bad guys!
	object oWP = GetObjectByTag("hv_badguys_spawn");
	location lLocation = GetLocation(oWP);
	CreateObject(OBJECT_TYPE_CREATURE, "hv_follower", lLocation, TRUE);
	CreateObject(OBJECT_TYPE_CREATURE, "hv_follower", lLocation, TRUE);
	CreateObject(OBJECT_TYPE_CREATURE, "hv_follower", lLocation, TRUE);
}
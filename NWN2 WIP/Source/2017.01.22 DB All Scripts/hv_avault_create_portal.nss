// On Open of the arcane vault doors
void main()
{	
	// Portal placeable tag
	string sPortal = "hv_avault_portal";
	
	// Effects to portal
	effect ePortal1 = EffectNWN2SpecialEffectFile("fx_portal_gen_small");
    effect ePortal2 = EffectNWN2SpecialEffectFile("sp_magic_circle");

	// Get location for portal
	object oWaypoint = GetNearestObjectByTag("avault_door_wp_");
	location lLocation = GetLocation(oWaypoint);
	
	// Create portal (variable used to track if we destroyed
	// it yet
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, sPortal, lLocation,FALSE);
	

	// Apply effects to portal
	ApplyEffectToObject(2,ePortal2,oPortal);
	ApplyEffectToObject(2,ePortal1,oPortal);
	
	// Get random waypoint (0-95) and put it as
	// local object on the portal
	int nRand = Random(96);
	object oRandomWaypoint = GetObjectByTag("avault_door_wp_", nRand);
	SetLocalObject(oPortal, "hv_avault_r_wp", oRandomWaypoint);
	
	// Signal to self that portal needs to be destroyed
	SetLocalInt(OBJECT_SELF, "hv_avault_destroy_portal", 1);
	
	// Close door after 2 minutes
	DelayCommand(10.0f, ActionCloseDoor(OBJECT_SELF));
}
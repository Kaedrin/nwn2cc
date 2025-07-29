void main()
{
	// Check if player has the special key
	object oPC = GetEnteringObject();
	if (GetIsObjectValid(GetItemPossessedBy(oPC, "hv_portal_key"))) {
	
		// Portal placeable tag
		string sPortal = "hv_portal";
		
		// Make sure there is no portal already
		if (!GetIsObjectValid(GetObjectByTag("sPortal"))) {
			// Effects to portal
			effect ePortal1 = EffectNWN2SpecialEffectFile("fx_portal_gen_small");
    		effect ePortal2 = EffectNWN2SpecialEffectFile("sp_magic_circle");
 
			// Get location for portal
			object oWaypoint = GetWaypointByTag("hv_portal_wp");
			location lLocation = GetLocation(oWaypoint);
	
			// Create portal
    		object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, sPortal, lLocation,FALSE);

			// Apply effects to portal
			ApplyEffectToObject(2,ePortal2,oPortal);
			ApplyEffectToObject(2,ePortal1,oPortal);
		}
	}
}
// Wrap the CreateObject function to return "void",
// so it can be used with "DelayCommand".
void CreateObjectVoid(int nObjectType, string sTemplate, location lLoc, int bUseAppearAnimation = FALSE)
{
    CreateObject(nObjectType, sTemplate, lLoc, bUseAppearAnimation);
}

void main()
{
	// Get nearest waypoint.
	object oWP = GetNearestObjectByTag("hv_barricade_wp");
	
	// Get its location.
	location lWP = GetLocation(oWP);
	
	// Order the Area to create a new one after 90 seconds.
	AssignCommand(GetArea(OBJECT_SELF), DelayCommand(90.0f, CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "hv_barricade", lWP)));
}
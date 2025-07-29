void main()
{
	// First thing I need to know how many pillars
	// are left, so update a variable.
	object oArea = GetArea(OBJECT_SELF);
	int nPillarsLeft = GetLocalInt(oArea, "hv_pillars_count");
	SetLocalInt(oArea, "hv_pillars_count", nPillarsLeft - 1);
	
	// if there are no more pillars, make sure no
	// more orbs will be created. in addition, 
	// make boss mortal
	if (nPillarsLeft == 1) {
		SetLocalInt(oArea, "hv_create_orbs", 0);
		object oBoss = GetObjectByTag("hv_temple_boss");
		if (GetIsObjectValid(oBoss))
			SetPlotFlag(oBoss, FALSE);
	}
}
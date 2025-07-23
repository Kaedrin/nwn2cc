/*
	nar_sdc_lever
	
	Controls the lever and secret door in nar_sdc_shadowdalecrypt.
	
	Narks - 18/01/2011
*/

void main()
{
	// Play animation for lever.
	int nActive = GetLocalInt(OBJECT_SELF, "X2_L_PLC_ACTIVATED_STATE");
	if (!nActive)
	{
		ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
	}
	else
	{
		ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
	}
	SetLocalInt(OBJECT_SELF,"X2_L_PLC_ACTIVATED_STATE",!nActive);

	// Unlock and open the secret door.
	object oDoor = GetObjectByTag("nar_sdc_secretdoor");
	SetLocked(oDoor, FALSE);
	AssignCommand(oDoor, ActionOpenDoor(oDoor));
}
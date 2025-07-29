//waypoint jump requires a waypoint tagged WP_(door tag)

void main()
{
 object oDoor1 = OBJECT_SELF;
 object	oDoor2 = GetTransitionTarget(oDoor1);	
 object oPC=GetLastOpenedBy();
 string sTag=GetTag(OBJECT_SELF);
 object oDest=GetObjectByTag("WP_"+sTag);
 location lDest=GetLocation(oDest);
 AssignCommand(oDoor1,DelayCommand(15.0,ActionCloseDoor(oDoor1)));
 AssignCommand(oDoor2,DelayCommand(15.0,ActionCloseDoor(oDoor2)));
 if(GetIsLocationValid(lDest)==TRUE)
 {
 	DelayCommand(3.0, AssignCommand(oPC,JumpToLocation(lDest)));
 }
 
 	float  	fShutDelay = 20.0;//GetLocalFloat(oDoor1, "AUTO_SHUT_DELAY");
	int	fLockDoor = GetLocalInt(oDoor1, "AUTO_LOCK");
	if(fLockDoor==0)
		return;
	else if(fLockDoor==1)
	{
		SetLockLockable(oDoor1, TRUE);
		SetLockLockable(oDoor2, TRUE);
		AssignCommand(oDoor1, DelayCommand(fShutDelay, ActionLockObject(oDoor1)));
		AssignCommand(oDoor2, DelayCommand(fShutDelay, ActionLockObject(oDoor2)));
	}
}
 
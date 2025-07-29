void main()
{
	object oDoor = GetBlockingDoor();
    if (oDoor != OBJECT_INVALID)
    {if (GetIsDoorActionPossible(oDoor, DOOR_ACTION_OPEN)) 
        {DoDoorAction(oDoor, DOOR_ACTION_OPEN);}}
}
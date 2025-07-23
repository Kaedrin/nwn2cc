void main()
{
	// TODO - change back to 1.5f
	DelayCommand(1.5f, ActionCloseDoor(OBJECT_SELF));
	DelayCommand(1.5f, ActionLockObject(OBJECT_SELF));
}
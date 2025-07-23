// On Open of doors - lock doors to rooms with restricted access.
// For Rachelle's inn.
void main()
{
	DelayCommand(5.0, ActionCloseDoor(OBJECT_SELF));
	DelayCommand(6.0, SetLocked(OBJECT_SELF, TRUE));
}
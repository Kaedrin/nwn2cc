// -----------------------------------------------
// closes open door after set time
// and locks door.
// -----------------------------------------------
void main()
{
  DelayCommand(5.0, ActionCloseDoor(OBJECT_SELF));
  SetLocked(OBJECT_SELF, 1);
}
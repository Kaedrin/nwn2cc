/* Closes and locks doors.

Script by Arcylisia 2011 */ 

void main() {
  DelayCommand(5.0, ActionCloseDoor(OBJECT_SELF));
  DelayCommand(5.5, SetLocked(OBJECT_SELF, TRUE));
}
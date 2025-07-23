/* Closes and locks doors.

Script by Arcylisia 2011 */ 

void main() {
  DelayCommand(4.5, ActionCloseDoor(OBJECT_SELF));
  DelayCommand(5.0, SetLocked(OBJECT_SELF, TRUE));
}
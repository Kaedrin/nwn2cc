void main()
{
AssignCommand(OBJECT_SELF,DelayCommand(5.0,ActionCloseDoor(OBJECT_SELF)));
AssignCommand(OBJECT_SELF,DelayCommand(6.0,SetLocked(OBJECT_SELF, TRUE)));
}
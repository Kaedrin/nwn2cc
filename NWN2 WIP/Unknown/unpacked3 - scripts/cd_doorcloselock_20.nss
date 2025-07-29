void main()
{
	AssignCommand(OBJECT_SELF,DelayCommand(20.0,ActionCloseDoor(OBJECT_SELF)));
	AssignCommand(OBJECT_SELF,DelayCommand(21.0,SetLocked(OBJECT_SELF, TRUE)));
}
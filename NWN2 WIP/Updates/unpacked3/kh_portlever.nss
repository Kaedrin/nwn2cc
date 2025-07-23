void  main ()
{
object oDoor = GetNearestObjectByTag("kh_doorlever", OBJECT_SELF, 1);
object oDoor2 = GetNearestObjectByTag("kh_doorlever2", OBJECT_SELF, 1);
SetLocked(oDoor,FALSE);
SetLocked(oDoor2,FALSE);
DelayCommand(2.0,AssignCommand(oDoor,ActionOpenDoor(oDoor)));
DelayCommand(2.0,AssignCommand(oDoor2,ActionOpenDoor(oDoor2)));}
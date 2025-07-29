void  main ()
{
object oDoor = GetNearestObjectByTag("alg_gem_door", OBJECT_SELF, 1);
SetLocked(oDoor,FALSE);
DelayCommand(2.0,AssignCommand(oDoor,ActionOpenDoor(oDoor)));

}
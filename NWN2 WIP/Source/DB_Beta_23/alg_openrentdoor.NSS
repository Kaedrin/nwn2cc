
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;
object oDoor = GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF,1);
ActionOpenDoor(oDoor);
DelayCommand(5.0, ActionCloseDoor(oDoor));
DelayCommand(5.0, SetLocked(oDoor, TRUE));

} 
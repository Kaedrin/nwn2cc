void main()
{
//object oPC = GetClickingObject();
object GemDoor = (OBJECT_SELF);
object oTarget;
object oSpawn;
location lTarget;
//if (!GetIsPC(oPC)) return;

if (GetLocalInt(GemDoor, "gemchest")== 3)
   {
   ActionOpenDoor(OBJECT_SELF);
   AssignCommand(OBJECT_SELF,DelayCommand(200.0,ActionCloseDoor(OBJECT_SELF)));
   AssignCommand(OBJECT_SELF,DelayCommand(210.0,ActionLockObject(OBJECT_SELF)));
   
   }
else if(GetNearestObjectByTag("dh_hintghost")==OBJECT_INVALID)
{
oTarget = GetWaypointByTag("hintghost");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "dh_hintghost", lTarget);
oTarget = oSpawn;
}
object oGhost = GetNearestObjectByTag("dh_hintghost");
if(oGhost != OBJECT_INVALID)
{
DestroyObject(oGhost, 300.0f);
} 
} 
#include "nw_i0_generic"
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("PLC_MR_SlumbHag02");

DestroyObject(oTarget, 0.0);

object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("plc_mr_slumbhag02");
object originalTarget = oTarget;

object oArea = GetArea(oTarget);
if(GetLocalInt(oArea, "HagSpawn") == 0)
{
 SetLocalInt(oArea, "HagSpawn", 1);
 AssignCommand(oArea, DelayCommand(600.0f, SetLocalInt(oArea, "HagSpawn", 0)));
 int i = 1;
 while(oTarget != OBJECT_INVALID)
 {

  lTarget = GetLocation(oTarget);
  oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "dh_nighthag", lTarget);
  oTarget = oSpawn;
  if(GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
  {
  	DestroyObject(oTarget, 0.1);
  }
  SetIsTemporaryEnemy(oPC, oTarget);
  AssignCommand(oTarget, ActionAttack(oPC));
  AssignCommand(oTarget, DetermineCombatRound(oPC));
  oTarget = GetNearestObjectByTag("plc_mr_slumbhag02", originalTarget, i);
  i = i + 1;
 }
 int j = 1;
 object oPlaceable = GetObjectByTagAndType("PLC_MR_SlumbHag02", OBJECT_TYPE_PLACEABLE, j);
 while(oPlaceable != OBJECT_INVALID)
 {
 	if(GetArea(oPlaceable) == oArea)
	{
		DestroyObject(oPlaceable, 0.1f);
	}
	j = j + 1;
 }
}
else
{
return;
}
}
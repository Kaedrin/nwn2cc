void main()
{
object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;


if ((GetItemPossessedBy(oPC, "Key of Darkness")== OBJECT_INVALID) || (!GetIsSkillSuccessful(oPC, SKILL_SEARCH, 35)))
{
   return;
}


object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("Shartemp");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shar_in_ob", lTarget);
}
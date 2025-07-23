void main()
{

object oPC = GetClickingObject();

if (!GetIsPC(oPC)) return;

if (GetTag(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC)) != "waterbreath")
   return;

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("wp_deepwaterin");

lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, ActionJumpToLocation(lTarget));

}

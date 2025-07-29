location lTarget;
object oTarget;

//Put this script OnUsed
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

if ((GetItemPossessedBy(oPC, "Key of Darkness")!=OBJECT_INVALID))
   {
   oTarget = GetWaypointByTag("wp_sharran_temple_interior");

   lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   AssignCommand(oPC, ClearAllActions());
   SendMessageToPC(oPC, "As you open the door, your skin tingles as swirling darkness envelopes you.");


   AssignCommand(oPC, ActionJumpToLocation(lTarget));

   }
else
   {
   SendMessageToPC(oPC, "A door.");

   }
 
}
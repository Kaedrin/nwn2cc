location lTarget;
object oTarget;


//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

if ((GetRacialType(oPC)==RACIAL_TYPE_HALFORC))
   {
   oTarget = GetWaypointByTag("WP_Start");

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
}
 
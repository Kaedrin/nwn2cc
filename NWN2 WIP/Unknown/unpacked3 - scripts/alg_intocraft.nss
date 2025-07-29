location lTarget;
object oTarget;

void main()
{

object oPC = GetPCSpeaker();
//check for gold..take gold..teleport
if (GetGold(oPC) >= 100)
   {
   AssignCommand(oPC, TakeGoldFromCreature(100, oPC, TRUE));

   oTarget = GetWaypointByTag("WP_into_sdcraft");

   lTarget = GetLocation(oTarget);

   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   AssignCommand(oPC, ClearAllActions());

   AssignCommand(oPC, ActionJumpToLocation(lTarget));

   }
else
   {
   //not enough refuse to do
   AssignCommand(GetObjectByTag("rlg_mstore_merchant"), ActionSpeakString("I am sorry you do not have enough gold to enter."));

   }

}

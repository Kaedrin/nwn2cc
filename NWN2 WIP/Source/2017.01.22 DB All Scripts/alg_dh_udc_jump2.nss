location lTarget;
object oTarget;

void main()
{
object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;


 if (GetAbilityScore(oPC, ABILITY_DEXTERITY)>= 14)
   {
   oTarget = GetWaypointByTag("dh_ud_otherside2");

   lTarget = GetLocation(oTarget);



   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   AssignCommand(oPC, ClearAllActions());

   AssignCommand(oPC, ActionJumpToLocation(lTarget));

   }
else
   {
   ActionSpeakString("Your going to need to do better then that!");

   }

}
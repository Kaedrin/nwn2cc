void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (ReflexSave(oPC, 18))
   {
   }
   else
   {
   object oTarget = GetWaypointByTag ("PRIMEAPE_DROPDOWN");

   location lTarget = GetLocation (oTarget);

   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   AssignCommand(oPC, ClearAllActions());

   AssignCommand(oPC, ActionJumpToLocation(lTarget));
   
   FloatingTextStringOnCreature("* You misstep and fall down to the darkness .. *", oPC);
   }
}
effect eEffect;
location lTarget;
object oTarget;


//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

if (GetIsSkillSuccessful(oPC, SKILL_TUMBLE, 32))
   {
   SendMessageToPC(oPC, "You manage to climb up");

   oTarget = GetWaypointByTag("WP_cotdmound");

   lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.


   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   AssignCommand(oPC, ClearAllActions());

   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));

   }
else
   {
   SendMessageToPC(oPC, "You slip and fall down to where you started.");

   eEffect = EffectDamage(15, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);

   ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);

   oTarget = GetWaypointByTag("WP_cotdcave");

   lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.

   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   AssignCommand(oPC, ClearAllActions());

  DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));

   }

}
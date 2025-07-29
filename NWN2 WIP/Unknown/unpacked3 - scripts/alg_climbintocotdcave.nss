effect eEffect;
location lTarget;
object oTarget;


//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

if (GetIsSkillSuccessful(oPC, SKILL_TUMBLE, 30))
   {
   SendMessageToPC(oPC, "You elegantly slide down uninjured.");

   oTarget = GetWaypointByTag("WP_cotdcave");

   lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.


   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   AssignCommand(oPC, ClearAllActions());

   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));

   }
else
   {
   SendMessageToPC(oPC, "You loose control and fall down the hole.");

   eEffect = EffectDamage(5, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);

   ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);

   oTarget = GetWaypointByTag("WP_cotdcave");

   lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.

   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   AssignCommand(oPC, ClearAllActions());

  DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));

   }

}
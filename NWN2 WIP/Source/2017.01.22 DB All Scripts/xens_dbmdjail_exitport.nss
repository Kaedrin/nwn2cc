//Script for Dalelands Beyond.
//Copyrights Xeneize @2014 | Gold Check for Jailor NPC.
//Takes desired ammount of gold away from PC/Ports PC out.
//Put this on action taken in the conversation editor.

void main()
{

object oPC = GetPCSpeaker();

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("spawn_mdjailexit");

lTarget = GetLocation(oTarget);

//Only works if location is valid

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, ActionJumpToLocation(lTarget));

effect eEffect;
eEffect = EffectDamage(500, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, OBJECT_SELF);

}
//Script for Dalelands Beyond.
//Copyrights Xeneize @2014 | Arrests and Teleports invisible player to Zhentarim Jail in Castle Krag.
//Script is attached to convo_ckjailor
//Put this on action taken in the conversation editor

void main()
{

object oPC = GetPCSpeaker();

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("spawn_kragjail");

lTarget = GetLocation(oTarget);

//Will only jump to location if it's valid, otherwise it will do nothing.


if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

DelayCommand(3.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));

oTarget = oPC;

//Visual effect for teleporting the target away.
int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));

object oSpawn;
oTarget = GetWaypointByTag("spawn_zhentjailor");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "gac_zhent_carlos", lTarget);

}
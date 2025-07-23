//
// Spawn Banner
// Activate Spawn
//

#include "spawn_functions"

void main()
{
    object oPC = GetPCSpeaker();
    object oSpawn = GetLocalObject(OBJECT_SELF, "ParentSpawn");
    NESS_ActivateSpawn(oSpawn);
    DestroyObject(OBJECT_SELF);
    object oBanner = CreateObject(OBJECT_TYPE_PLACEABLE, "spawn_ban_a", GetLocation(oSpawn));
    SetLocalObject(oBanner, "ParentSpawn", oSpawn);
    FloatingTextStringOnCreature("Spawn Activated", oPC);
}
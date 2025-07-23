//
// Deactivation Scripts
//
#include "spawn_functions"
//
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
//
//
void main()
{
    // Retrieve Script
    int nDeactivateScript = GetLocalInt(OBJECT_SELF, "DeactivateScript");

    // Invalid Script
    if (nDeactivateScript == -1)
    {
        return;
    }

//
// Only Make Modifications Between These Lines
// -------------------------------------------


    // Script 00
    if (nDeactivateScript == 0)
    {
        // Explode with Gore when Deactivated
        effect eVisual = EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVisual, GetLocation(OBJECT_SELF), 0.0);
    }
    //


// -------------------------------------------
// Only Make Modifications Between These Lines
//

}
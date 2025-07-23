//
// Spawn Banner
// Conversation Check
//

#include "spawn_functions"

int StartingConditional()
{
    if (NESS_IsModuleSpawnTracking())
    {
        return FALSE;
    }
    return TRUE;
}

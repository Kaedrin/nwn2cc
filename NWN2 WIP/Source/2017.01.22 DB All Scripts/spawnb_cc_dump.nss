//
// Spawn Banner
// Conversation Check
//

#include "spawn_functions"

int StartingConditional()
{
    if (NESS_IsModuleSpawnDumping())
    {
        return FALSE;
    }
    return TRUE;
}

//
// Spawn Banner
// Conversation Check
//

#include "spawn_functions"

int StartingConditional()
{
    if (NESS_IsModuleSpawnDumping())
    {
        return TRUE;
    }
    return FALSE;
}

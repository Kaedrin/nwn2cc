//
// Spawn Banner
// Turn Spawn Tracking ON
//

#include "spawn_functions"

void main()
{
    NESS_DumpModuleSpawns();
    SendMessageToAllDMs("Spawn dumping enabled");
}

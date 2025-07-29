//
// Spawn Banner
// Turn Spawn Tracking OFF
//

#include "spawn_functions"

void main()
{
    NESS_DumpModuleSpawns(FALSE);
    SendMessageToAllDMs("Spawn dumping disabled");
}

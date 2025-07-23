//
// Spawn Banner
// Turn Spawn Tracking ON
//

#include "spawn_functions"

void main()
{
    NESS_TrackModuleSpawns();
    SendMessageToAllDMs("Spawn tracking enabled");
}

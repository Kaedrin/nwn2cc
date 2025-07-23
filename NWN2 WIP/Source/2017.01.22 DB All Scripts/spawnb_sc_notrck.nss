//
// Spawn Banner
// Turn Spawn Tracking OFF
//

#include "spawn_functions"

void main()
{
    NESS_TrackModuleSpawns(FALSE);
    SendMessageToAllDMs("Spawn tracking disabled");
}

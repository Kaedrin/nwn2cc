/*
Filename:           hcr2_crea_spawn_e
System:             core (Creature OnSpawn event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 4th, 2009.
Summary:
HCR2 hcr2_crea_spawn_e Event.
This script should be attachted to an Creature OnSpawn event under
the scripts section of Creature properties.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
    h2_RunObjectEventScripts(H2_CREATUREEVENT_ON_SPAWN, OBJECT_SELF);
}
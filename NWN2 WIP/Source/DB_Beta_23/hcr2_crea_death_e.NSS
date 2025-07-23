/*
Filename:           hcr2_crea_death_e
System:             core (Creature OnDeath event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 4th, 2009.
Summary:
HCR2 hcr2_crea_death_e Event.
This script should be attachted to an Creature OnDeath event under
the scripts section of Creature properties.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
    h2_RunObjectEventScripts(H2_CREATUREEVENT_ON_DEATH, OBJECT_SELF);
}
/*
Filename:           hcr2_crea_perception_e
System:             core (Creature OnPerception event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 4th, 2009.
Summary:
HCR2 hcr2_crea_perception_e Event.
This script should be attachted to an Creature OnPerception event under
the scripts section of Creature properties.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
    h2_RunObjectEventScripts(H2_CREATUREEVENT_ON_PERCEPTION, OBJECT_SELF);
}
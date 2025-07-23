/*
Filename:           hcr2_crea_rested_e
System:             core (Creature OnRested event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 4th, 2009.
Summary:
HCR2 hcr2_crea_rested_e Event.
This script should be attachted to an Creature OnRested event under
the scripts section of Creature properties.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
    h2_RunObjectEventScripts(H2_CREATUREEVENT_ON_RESTED, OBJECT_SELF);
}
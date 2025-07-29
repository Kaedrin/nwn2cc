/*
Filename:           hcr2_door_damaged_e
System:             core (Door OnDamaged event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 4th, 2009.
Summary:
HCR2 hcr2_door_damaged_e Event.
This script should be attachted to an Door OnDamaged event under
the scripts section of Door properties.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
    h2_RunObjectEventScripts(H2_DOOREVENT_ON_DAMAGED, OBJECT_SELF);
}
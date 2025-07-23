/*
Filename:           hcr2_door_disarm_e
System:             core (Door OnDisarm event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 4th, 2009.
Summary:
HCR2 hcr2_door_disarm_e Event.
This script should be attachted to an Door OnDisarm event under
the scripts section of Door properties.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
    h2_RunObjectEventScripts(H2_DOOREVENT_ON_DISARM, OBJECT_SELF);
}
/*
Filename:           hcr2_door_failtoopen_e
System:             core (Door OnFailToOpen event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 4th, 2009.
Summary:
HCR2 hcr2_door_failtoopen_e Event.
This script should be attachted to an Door OnFailToOpen event under
the scripts section of Door properties.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
    h2_RunObjectEventScripts(H2_DOOREVENT_ON_FAILTOOPEN, OBJECT_SELF);
}
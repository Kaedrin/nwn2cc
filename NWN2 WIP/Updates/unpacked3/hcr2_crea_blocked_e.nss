/*
Filename:           hcr2_crea_blocked_e
System:             core (Creature OnBlocked event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 4th, 2009.
Summary:
HCR2 hcr2_crea_blocked_e Event.
This script should be attachted to an Creature OnBlocked event under
the scripts section of Creature properties.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
    h2_RunObjectEventScripts(H2_CREATUREEVENT_ON_BLOCKED, OBJECT_SELF);
}
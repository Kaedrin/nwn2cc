/*
Filename:           hcr2_door_spellcastat_e
System:             core (Door OnSpellCastAt event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 4th, 2009.
Summary:
HCR2 hcr2_door_spellcastat_e Event.
This script should be attachted to an Door OnSpellCastAt event under
the scripts section of Door properties.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
    h2_RunObjectEventScripts(H2_DOOREVENT_ON_SPELLCASTAT, OBJECT_SELF);
}
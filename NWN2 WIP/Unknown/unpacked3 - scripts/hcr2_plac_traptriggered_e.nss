/*
Filename:           hcr2_plac_traptriggered_e
System:             core (Placeable OnTrapTriggered event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 4th, 2009.
Summary:
HCR2 hcr2_plac_traptriggered_e Event.
This script should be attachted to an Placeable OnTrapTriggered event under
the scripts section of Placeable properties.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
    h2_RunObjectEventScripts(H2_PLACEABLEEVENT_ON_TRAPTRIGGERED, OBJECT_SELF);
}
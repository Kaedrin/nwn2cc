/*
Filename:           hcr2_plac_disarm_e
System:             core (Placeable OnDisarm event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 4th, 2009.
Summary:
HCR2 hcr2_plac_disarm_e Event.
This script should be attachted to an Placeable OnDisarm event under
the scripts section of Placeable properties.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
    h2_RunObjectEventScripts(H2_PLACEABLEEVENT_ON_DISARM, OBJECT_SELF);
}
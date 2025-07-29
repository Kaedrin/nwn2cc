/*
Filename:           hcr2_areaheartbeat_e
System:             core (Area OnHeartbeat event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 Area OnHeartbeat Event.
This script should be attachted to an Area's OnHeartbeat event under
the scripts section of Area properties.

Variables available to all area event scripts:
GetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA) returns the number of players in the area.

-----------------
Revision: v1.05
Adjusted event call function

*/

#include "hcr2_core_i"

void main() 
{



    h2_RunObjectEventScripts(H2_AREAEVENT_ON_HEARTBEAT, OBJECT_SELF);
}
/*
Filename:           hcr2_areaoncliententer_e
System:             core (Area OnEnter event script)
Author:             Edward Beck (0100010)
Date Created:       Nov 11th, 2006.
Summary:
HCR2 Area OnClientEnter Event.
This script should be attachted to an Area's OnEnter event under
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
    int playercount = GetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA);
    SetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA, playercount + 1);    
    h2_RunObjectEventScripts(H2_AREAEVENT_ON_CLIENT_ENTER, OBJECT_SELF);
}
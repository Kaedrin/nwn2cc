/*
Filename:           hcr2_onplayerstruck_e
System:             core (player on hit event scriptt)
Author:             Edward Beck (0100010)
Date Created:       Sept 12th, 2009.
Summary:
HCR2 OnPlayerHit Event.
This script is executed from x2_s3_onhitcast, whenever
a player is struck by another creature (melee or ranged).

-----------------
Revision:

*/

#include "hcr2_core_i"
 
void main()
{
	h2_RunModuleEventScripts(H2_EVENT_ON_PLAYER_STRUCK);	 
}
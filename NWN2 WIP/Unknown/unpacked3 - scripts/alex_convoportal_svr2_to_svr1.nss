// In the OnUsed of a statue
// Sends the using PC to another (fictional) server
// with player password "mumb0Jumb0", and has
// the PC appear at waypoint "ISK_WP_PORTAL". The
// player will not be notified that they've moved server.
#include "nw_i0_generic"
void main() 
{
     object oPC = GetPCSpeaker();
     //if (!GetIsPC( oPC )) return;
     ActivatePortal(oPC, "68.169.154.157:5121", "", "WP_START");
}
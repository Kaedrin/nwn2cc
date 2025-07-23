/*
Filename:           hcr2_clientleave_e
System:             core (client leave event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnClientLeave Event.
This script should be attachted to the OnClientLeave event under
the scripts section of Module properties.

-----------------
Revision: v1.02
Added call to h2_LogOutPC.

Revision: v1.05
Removed Spell and health saving on logout as 
its not neded anymore with the new 'Disable log in heal'
server option
*/
#include "hcr2_core_i"
//#include "mvd_02_init"

void main()
{
    object oPC = GetExitingObject();
    if (GetLocalInt(oPC, H2_LOGIN_BOOT))
        return;
	h2_LogOutPC(oPC);		
    if (!GetIsDM(oPC))
    {
        int iPlayerCount = h2_GetModLocalInt(H2_PLAYER_COUNT);
        h2_SetModLocalInt(H2_PLAYER_COUNT, iPlayerCount - 1); 
		h2_RemoveEffects(oPC);       
    }
    h2_RunModuleEventScripts(H2_EVENT_ON_CLIENT_LEAVE);

}
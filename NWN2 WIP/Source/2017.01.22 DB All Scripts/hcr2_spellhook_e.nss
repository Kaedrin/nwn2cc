
/*
Filename:           hcr2_spellhook_e
System:             core (spellhook event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnSpellhook Event.
This script should be set as the spellhook script in the
OnModuleLoad event script for the module.

-----------------
Revision v1.03
Added spell-tracking call.

v1.05
Added call to check for OnHitCast event (PlayerStruck and Unique Power property)
*/

#include "hcr2_core_i"

void main()
{	
	h2_AddTrackedSpell();
	h2_CheckOnHitCast();
    h2_RunModuleEventScripts(H2_EVENT_ON_SPELLHOOK);
//	SendMessageToPC(OBJECT_SELF, "I am running!");
   
}
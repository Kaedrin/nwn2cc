// gui_death_respawn_self.nss
/*
	NWN2 Default Death Screen 'Respawn' callback
*/
// BMA-OEI 7/20/06

//Modified by 0100010 to execute the module OnRespawn Event
//HCR2 v1.01, added H2_DISABLE_RESPAWN_GUI check.

#include "ginc_death"
#include "hcr2_constants_i"

void main()
{
	if (H2_DISABLE_RESPAWN_GUI)
		return;
	ResurrectCreature( OBJECT_SELF );
	SetLocalObject(GetModule(), H2_LAST_RESPAWN_BUTTON_PRESSER, OBJECT_SELF);
	//TODO: drop H2_RESPAWN_EVENT_SCRIPT constant when 
	//GetEventHandler works for module objects.
	ExecuteScript(H2_RESPAWN_EVENT_SCRIPT, GetModule());	
}
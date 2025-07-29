#include "alex_constants"

// Boot player if she fails this check
void main()
{
	object oPC = OBJECT_SELF;
	
	// If current location is same as stored one, and 
	// chat wasn't used in the last X (AFK_CHECK) minutes,
	// initiate boot sequence
	if ((GetLocation(oPC) == GetLocalLocation(oPC, AFK_LOCATION))
		&&
		(GetLocalInt(oPC, AFK_CHAT) == 0)) {
			
			// Boot player
			BootPC(oPC);
			return;
	}
		
	// Store current location
	SetLocalLocation(oPC, AFK_LOCATION, GetLocation(oPC));
		
	// Reset Chat variable
	SetLocalInt(oPC, AFK_CHAT, 0);
	
	// Debug
	//SendMessageToPC(oPC, "<C=lightgreen>Passed second AFK Check");									
}
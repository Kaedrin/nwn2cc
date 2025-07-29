#include "hv_bandits_inc"

// Handle password GUI
void main(string sPass = "")
{
	// Check if password is correct
	if (CheckPassword(sPass, OBJECT_SELF) == TRUE) {
	
		// Open door
		object oDoor = GetNearestObjectByTag(S_DOOR);
		AssignCommand(oDoor, ActionOpenDoor(oDoor));
		AssignCommand(oDoor, SpeakString("The door opens."));
		
		// Close door after 20 seconds
		AssignCommand(oDoor, DelayCommand(20.0, ActionCloseDoor(oDoor)));
	}
	// Wrong pass
	else {
		
		SpeakString("<C=red>*Wrong security code!*");
		DoRandomTrapEffect(OBJECT_SELF);
	}
}
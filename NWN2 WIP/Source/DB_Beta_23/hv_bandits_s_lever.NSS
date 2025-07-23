#include "hv_bandits_inc"

// Open security doors
void main()
{
	// Lever Animation
	ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
	ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
	
	// Open door
	//object oDoor = GetNearestObjectByTag(S_DOOR);
	object oDoor = GetNearestObject(OBJECT_TYPE_DOOR);
	ActionOpenDoor(oDoor);
	
	// Close door after 10 seconds
	DelayCommand(10.0, ActionCloseDoor(oDoor));
	DelayCommand(11.0, SetLocked(oDoor, TRUE));
}
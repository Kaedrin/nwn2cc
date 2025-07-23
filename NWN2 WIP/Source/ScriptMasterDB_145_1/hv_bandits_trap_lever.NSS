#include "hv_bandits_inc"

// Move traps from pair of statues to the other
void main()
{
	// Lever Animation
	ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
	ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
	
	// Move traps to other statues
	MoveTraps(OBJECT_SELF);
}
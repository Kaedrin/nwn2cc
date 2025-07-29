#include "hv_arena_inc"

// Stop challenge - remove all monsters and signal
// to area that no challenge is running.
void main()
{
	object oArea = GetArea(OBJECT_SELF);
	if (GetLocalInt(oArea, CHALLENGE_RUNNING)) {
		CleanArena();
		SetLocalInt(oArea, CHALLENGE_RUNNING, FALSE);
		Announce("<C=teal>The challenge was stopped!");
	}
	else
		SendMessageToPC(GetLastUsedBy(), "No challenge is running.");
}
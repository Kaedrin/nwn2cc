/*
	In NPC's conversation; check if active quest was completed.
*/

#include "ev_mq_inc"

int StartingConditional()
{
	SetLocalString(GetPCSpeaker(), "ev_mq_domain", GetLocalString(OBJECT_SELF, "ev_mq_domain"));
	completed_current_quest(GetPCSpeaker());
	return TRUE;
}
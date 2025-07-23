// Say something when seeing a PC

#include "hv_cq_inc"

void main()
{
	object oPC = GetLastPerceived();
	if (!GetIsPC(oPC)) return;
	
	// 5% to speak
	if (Random(20) == 13) {
		SpeakString("<C=yellow><i>Your time in this realm is over!");
		SoundObjectPlay(GetObjectByTag(PRISONER_SPEAK));
	}
}
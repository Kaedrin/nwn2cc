string sTarget=GetLocalString(OBJECT_SELF, "SoundObjectName");

#include "ginc_param_const"

void main(float fDelay)
{
	object oTarget = GetNearestObjectByTag(sTarget); //GetSoundObjectByTag
	if (GetIsObjectValid(oTarget)) 
		DelayCommand(fDelay,SoundObjectPlay(oTarget));
}
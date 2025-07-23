#include "ginc_param_const"
//Jumps the PC Speaker to the Destination ...	
// orignal author unknown
void main(string sDestination, float fDelay)
{
	object oDestination = GetTarget(sDestination);
	object oTarget = GetPCSpeaker();

	AssignCommand(oTarget, DelayCommand(fDelay, JumpToObject(oDestination)));
	return;
	
}
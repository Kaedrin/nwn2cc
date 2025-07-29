#include "cmi_includes"

int StartingConditional()
{
	object oPC = GetPCSpeaker();
	
	if(GetLevelByClass(39, oPC) > 0 && GetHasFeat(2276, oPC) == FALSE)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}
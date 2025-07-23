#include "cmi_includes"

int StartingConditional()
{
	object oPC = GetPCSpeaker();
	
	if(GetLevelByClass(185, oPC) > 0 && GetHasFeat(2275, oPC) == FALSE)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}
	
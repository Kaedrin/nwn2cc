#include "ginc_param_const"


void main()
{
	// Use OBJECT_SELF for current character.
    object oPC = OBJECT_SELF;
	object oArea = GetArea(oPC);
	
	if(!GetIsDM(oPC))
		return;
	
	if(GetLocalInt(oArea, "NO_SPAWN")==0)
	{
		SetLocalInt(oArea, "NO_SPAWN", 1);
		AssignCommand(GetModule(), DelayCommand(3600.0f, DeleteLocalInt(oArea, "NO_SPAWN")));
		SendMessageToPC(oPC, "Spawn in area : '" + GetName(oArea) + "' disabled for one hour.");
	}
	else
	{
		DeleteLocalInt(oArea, "NO_SPAWN");
		SendMessageToPC(oPC, "Spawn in area : '" + GetName(oArea) + "' are enabled.");
	}
}
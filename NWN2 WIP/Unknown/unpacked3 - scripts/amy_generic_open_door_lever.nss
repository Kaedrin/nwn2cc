//Use this script on used
//Use this script on a lever to open a door
//make sure the level and door have the EXACT
//same tag

#include "ginc_debug"

void main(string sDoorOpen)
{
object oPC = GetLastUsedBy();
int nActive = GetLocalInt (OBJECT_SELF,"X2_L_PLC_ACTIVATED_STATE");
//object oDoor = GetObjectByTag(GetTag(OBJECT_SELF));
object oDoor = GetNearestObjectByTag(GetTag(OBJECT_SELF));

if (!nActive)
	{
	ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
	AssignCommand(oDoor, ActionOpenDoor(oDoor));
	}
 else
   {
    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
   }
    // * Store New State
    SetLocalInt(OBJECT_SELF,"X2_L_PLC_ACTIVATED_STATE",!nActive);
}
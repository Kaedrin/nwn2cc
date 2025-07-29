/* 

gac_lock_door_lever

This script has been adjusted by gildren for the Dalelands Beyond server

It is being used in the sizth_morcane_interior area to lock jailcell doors

//::///////////////////////////////////////////////
//:: Name Door Locker for Private Rooms
//:: FileName plc_doorlvrlock.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/* Paint a placeable in the area and give it a unique
tag. Make it useable and plot and attach this script
to its on used event. Create an integer variable on
it called nDoorLock and set the variable to 0. Then
paint in the door that you want it to lock and unlock.
Set the door's tag to "placable tag"_door (replace
placeable tag with the actual tag of the placable that
locks and unlocks the door). Make sure that the door
is set to plot and that it is set to relockable with
a DC of 250.
*/
//:://////////////////////////////////////////////
//:: Created By: Himura
//:: Created On: 11/08/05
//:://////////////////////////////////////////////
void main()
{
string sDoorTag = GetTag(OBJECT_SELF) + "_door";
int nLockState = GetLocalInt(OBJECT_SELF, "nDoorLock");

if (nLockState==0)
{object oPC = GetLastUsedBy();
int nPCGP;
nPCGP = GetGold(oPC);
if (nPCGP>=0)
{string sDoorTag = GetTag(OBJECT_SELF) + "_door";
// AssignCommand(oPC, TakeGoldFromCreature(100, oPC, TRUE)); - removed by gildren 12-07-12
object oPayDoor = GetObjectByTag(sDoorTag, 0);
DelayCommand(1.0, ActionCloseDoor(oPayDoor));
DelayCommand(3.0, SetLocked(oPayDoor, TRUE));
DelayCommand(3.5, ActionSpeakString("The door has been locked"));
DelayCommand(5.0, SetLocalInt(OBJECT_SELF, "nDoorLock", 1));}
else
{ActionSpeakString("The door has not been locked"); }}

else
{string sDoorTag = GetTag(OBJECT_SELF) + "_door";
object oPC = GetLastUsedBy();
object oPayDoor = GetObjectByTag(sDoorTag, 0);
SetLocked(oPayDoor, FALSE);
// DelayCommand(0.5, GiveGoldToCreature(oPC, 50)); - removed by gildren 12-07-12
DelayCommand(1.0, ActionSpeakString("The door has been unlocked"));
DelayCommand(2.0, SetLocalInt(OBJECT_SELF, "nDoorLock", 0));}
}

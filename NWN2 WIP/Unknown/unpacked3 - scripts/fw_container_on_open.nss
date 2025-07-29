/////////////////////////////////////////////
// *
// * Created by Christopher Aulepp
// * Date: 12 May 2008
// * contact information: cdaulepp@juno.com
// * VERSION 2.0
// * copyright 2008 Christopher Aulepp.  All rights reserved.
// *
//////////////////////////////////////////////

/////////////////////////////////////////////
// *
// *  WARNING: ONLY AN EXPERIENCED SCRIPTER
// *  	       SHOULD CHANGE ANYTHING IN THIS 
// *		   FILE
// *
//////////////////////////////////////////////

// *****************************************
//
//              FILE DESCRIPTION
//
// *****************************************
/*


*/

// I need the timers from this file.
#include "fw_inc_misc"
#include "nw_i0_spells"


// *****************************************
//
//              UPDATES
//
// *****************************************



// *****************************************
//
//              FUNCTION DECLARATIONS
//				DON'T CHANGE
//
// *****************************************

//////////////////////////////////////////
// * Simple function that will close an open placeable.
//
void FW_Close_Placeable ();

//////////////////////////////////////////
// * Simple function that will mark a placeable as ready
// * to spawn treasure.  Simply puts a local int on a 
// * placeable object. 
//
void FW_Mark_Placeable_As_Ready_To_Spawn_Treasure ();

// *****************************************
//
//              IMPLEMENTATION
//				DON'T CHANGE
//
// *****************************************

//////////////////////////////////////////
// * Simple function that will close an open placeable.
//
void FW_Close_Placeable ()
{
    // Can't close ourselves twice
    if(GetIsOpen(OBJECT_SELF))
    {
        ActionCloseDoor(OBJECT_SELF);
    }
}

//////////////////////////////////////////
// * Simple function that will mark a placeable as ready
// * to spawn treasure.  Simply puts a local int on a 
// * placeable object. 
//
void FW_Mark_Placeable_As_Ready_To_Spawn_Treasure ()
{
	SetLocalInt (OBJECT_SELF, "FW_READY_TO_SPAWN_TREASURE", 1);	
}

//////////////////////////////////////////
// *
// *
// *		MAIN PROGRAM
// *
// *
//////////////////////////////////////////
void main()
{
    // break stealth and remove invis on the oPC.
    object oPC = GetLastOpenedBy();
    SetActionMode(oPC, ACTION_MODE_STEALTH, FALSE);
    RemoveSpecificEffect(EFFECT_TYPE_INVISIBILITY, oPC);
		
    // Check to see if the container is ready to possibly spawn new loot.
	int nLootCheck = GetLocalInt(OBJECT_SELF, "FW_READY_TO_SPAWN_TREASURE");	
	
	// When the placeable has never been opened, there will be no local
	// int on the placeable and the check above will return 0.  It
	// is okay to spawn loot on the placeable obviously, but we also need
	// to set up the local int for the next time it is opened.
	if (nLootCheck == 0)
	{
		// Set up the local variable on the object and set to 2, which
		// indicates not ready to spawn treasure.
		SetLocalInt (OBJECT_SELF, "FW_READY_TO_SPAWN_TREASURE", 2);
		// run the random loot generator (possibly spawning loot in the 
		// placeables inventory)
		ExecuteScript("fw_random_loot", OBJECT_SELF);
		// Run the countdown timer and then switch FW_READY_TO_SPAWN_TREASURE
		// to 1 after the countdown is done.
		DelayCommand (FW_TREASURE_CHEST_RESPAWN_TIMER, FW_Mark_Placeable_As_Ready_To_Spawn_Treasure()); 
	}
	else if (nLootCheck == 1)
	{
		// delete the existing local int.  We delete the existing int b/c
		// if we don't we would end up with a placeable object having many
		// copies of the same local variable.
		DeleteLocalInt (OBJECT_SELF, "FW_READY_TO_SPAWN_TREASURE");
		// Set up the local variable on the object and set to 2, which
		// indicates not ready to spawn treasure.
		SetLocalInt (OBJECT_SELF, "FW_READY_TO_SPAWN_TREASURE", 2);		
		// run the random loot generator (possibly spawning loot in the 
		// placeables inventory)
		ExecuteScript("fw_random_loot", OBJECT_SELF);
		// Run the countdown timer and then switch FW_READY_TO_SPAWN_TREASURE
		// to 1 after the countdown is done.
		DelayCommand (FW_TREASURE_CHEST_RESPAWN_TIMER, FW_Mark_Placeable_As_Ready_To_Spawn_Treasure()); 		
	}
	// otherwise this placeable is not ready to spawn loot b/c it was opened
	// in the last FW_TREASURE_CHEST_RESPAWN_TIMER seconds (default is 600).
	// In which case, don't do anything	
	else // (nLootCheck == 2)
	{		
		// Do nothing.
	}
	// Close the container after FW_CLOSE_DOOR_TIMER_DELAY seconds (default
	// is 15 seconds).
    DelayCommand(FW_CLOSE_DOOR_TIMER_DELAY, FW_Close_Placeable());
}
/*

    Script:			Main Death script for all spawn related objects.  This is called from the Master Death
	  				script which is placed on Mobs and placeable objects.  
	Version:		1.03
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		None

	Change Log:		11/24/2010 - 1.00 MV - Initial Release
					11/27/2010 - 1.01 MV - Change name and moved to Spawn System.
					12/14/2010 - 1.02 MV - Fixed effect bug.
					09/19/2011 - 1.03 MV - Updated to support spawning 1.42

*/

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_spawn_include"




// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// First lets get the parent.  Of course, if this object has no parent then it wasnt created using
	// the spawn plugin.  Possible if using say, the Quest Plugin and Loot Plugin for placeables but a
	// different system for spawning monsters.
	object oParent = GetLocalObject(OBJECT_SELF, "SPAWN_Parent");
	string sIndex = GetLocalString(OBJECT_SELF, "SPAWN_Index");
	SetLocalObject(oParent, "SPAWN_" + sIndex, OBJECT_INVALID);
	LEG_COMMON_TimeOfDeath(OBJECT_SELF, oParent);	

	// If we are a placeable object, let's put a destroy effect on here if we are asked to do so.
	if (GetLocalInt(oParent, "LEG_SPAWN_ObjectType") == 1)
	{
		// If we are not supposed to drop our loot as a placeable, then lets ensure we don't do that.
		if (GetLocalInt(oParent, "LEG_SPAWN_DoNotDropMyLoot"))
			LEG_COMMON_DestroyInventory(OBJECT_SELF);
		
		// Set up some defaults
		effect eExplode;
		int iEffect = GetLocalInt(oParent, "LEG_SPAWN_DestroyEffect");

		// If we have an effect, set it up, otherwise use the default one.
		if (iEffect)
			eExplode = EffectVisualEffect(iEffect);
		else
			eExplode = EffectNWN2SpecialEffectFile("fx_wooden_explosion_big");

		// Apply the effect.
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplode, OBJECT_SELF);
	}
	else
	{
		// We throw this in there in the event that we are not supposed to drop loot as a monster via the
		// SPAWN plugin.  NOTE that if monsters are configured to create loot on their person at time
		// of death, they simply do not create loot at all as handled by the leg_all_masterdeath script however
		// mobs MAY be told to create loot at spawn time in order for them to use it so we have to ensure
		// that in those cases, loot is destroyed before they drop it when they die.
		if (GetLocalInt(oParent, "LEG_SPAWN_DoNotDropMyLoot") && GetLocalInt(GetModule(), "LEG_LOOT_ONSPAWN"))
			LEG_COMMON_DestroyInventory(OBJECT_SELF);
	}
}
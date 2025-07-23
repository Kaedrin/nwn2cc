/*

    Script:			This script contains all the systems directly specific to the spawn system plugin.  Functions 
					here are NOT used by other plugins but only called by the spawn system itself.  Though this may
					be included with other plugins, it would only be done when the plugin requires facets of the
					spawn system.  Most functions used by other plugins for spawning related are in the Master
					Functions include.
	Version:		1.60
	Plugin Version: 1.7
	Author:			Marshall Vyper
	Parameters:		None

	Change Log:		11/26/2010 - MV - Initial Release
					12/14/2010 - MV - Fixed bug in 2DA spawning
					07/20/2011 - MV - Fixed bug, wrong variable for quest icon.
					09/19/2011 - MV - Changed system for Spawn 1.42
					09/27/2011 - MV - Support for Waypoint override local AI
					10/05/2011 - MV 1.51 - Fixed major bug with Banter plugin compatability.
					10/08/2011 - MV 1.52 - Added features for AI plugin.
					10/16/2011 - MV 1.60 - Fixed major bug in Area Despawn functions
*/

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// USER CONFIGURABLE CONSTANTS
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_spawn_constants"
const string DATABASETYPE = "nwnx";						// This is the database type.  Valid values: nwnx (Not Used Yet but must be set)



// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_all_masterinclude"
#include "leg_all_fixedgincwp"


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// FUNCTION DECLARATIONS
// /////////////////////////////////////////////////////////////////////////////////////////////////////


// ///////////////////////////////////////////////////////////////////////////
// Creating stuff.  Yeah pretty basic.  Call this with a waypoint, ResRef,
// location etc.  It performs the actual creation of a placeable or creatue
// and does not care to check for timing or anything.  Just makes it now at
// location passed.  This is for placeable object type spawns.
// object oSpawn_Point		- The object holding the variables, usually a WP.
// string sSpawnResRef		- The ResRef blueprint of what we need to spawn.
// location lSpawnSite		- The actual location where the object will appear.
// string sParentTag		- The TAG of the Spawn Point Object
//	Returns: N/A
void LEG_SPAWN_CreatePlaceableSpawn(object oSpawn_Point, string sSpawnResRef, location lSpawnSite, string sParentTag, string sIndex);

// ///////////////////////////////////////////////////////////////////////////
// Creating stuff.  Yeah pretty basic.  Call this with a waypoint, ResRef,
// location etc.  It performs the actual creation of a creatue
// and does not care to check for timing or anything.  Just makes it now at
// location passed.  This is for creature and NPC object type spawns.
// object oSpawn_Point		- The object holding the variables, usually a WP.
// string sSpawnResRef		- The ResRef blueprint of what we need to spawn.
// location lSpawnSite		- The actual location where the object will appear.
// string sParentTag		- The TAG of the Spawn Point Object
//	Returns: N/A
void LEG_SPAWN_CreateMobSpawn(object oSpawn_Point, string sSpawnResRef, location lSpawnSite, string sParentID, string sVarID);

// ///////////////////////////////////////////////////////////////////////////
// Function to identify a location for the spawn, the thing we're supposed to
// spawn based on Parent and once determined calls the create, function to 
// spawn now.
// object oSpawn_Point		- The object holding the variables, usually a WP.
// object oArea				- The area this placeable and spawn point is in
// string sParentTag		- The TAG of the Spawn Point Object
// float fSpawnDelay		- How much time should pass before spawning.
//	Returns: N/A
void LEG_SPAWN_ProcessSpawn(object oSpawn_Point, object oArea, string sParentTag, float fSpawnDelay, string sSpawnResRef, string sVarID);

// ///////////////////////////////////////////////////////////////////////////
// A Function to simply find the HBMan object in a given area and destroy it.
// object oArea				- The area we would like to destroy the HMAN in.
//	Returns: N/A
void LEG_SPAWN_DeSpawnHBMan(object oArea);

// ///////////////////////////////////////////////////////////////////////////
// A Function to simply create a HBMan object at its waypoint in the passed
// area.
// object oArea				- The area we would like to spawn the HMAN in.
//	Returns: N/A
void LEG_SPAWN_SpawnHBMan(object oArea);

// ///////////////////////////////////////////////////////////////////////////
// This function is usually fired by the HBMan's heartbeat or when a requested
// event occurs, like spawning a chest when a trigger is crossed or spawning
// a creature during a quest that is nearby rather than wait.
// It reviews all the spawn points for monsters and placeables in an area
// and checks to see if it is time to spawn the associated object.
// object oArea				- The area we would like to review Spawn Points
//	Returns: N/A
void LEG_SPAWN_CheckSpawns(object oArea);

// ///////////////////////////////////////////////////////////////////////////
// This function is fired when the last player exits the area.  It is called
// by the leg_spawn_onexit script.  It will clean up and creatures, placeables
// NPC's and quest Icons should that plugin be active.
// object oArea				- The area we would like to DeSpawn
//	Returns: N/A
void LEG_SPAWN_DeSpawnArea(object oArea);

// ///////////////////////////////////////////////////////////////////////////
// This function is called from the CheckSpawns function by our HB Man.  It
// will despawn any objects that are set to despawn because of a time of day
// setting.  (ie; Despawn the ghost when the daytime arrives)
// object oChild				- The actual thing to despawn.
// object oParent				- The parent WP with holding the configuration
//	Returns: TRUE if child was despawned.
int LEG_SPAWN_DeSpawnTOD(object oChild, object oParent);

// ///////////////////////////////////////////////////////////////////////////
// If there is a DeSpawnMins variable active on a placeable or monster, then
// this function is called during the CheckSpawns function to see if its
// time to despawn.  And if so, do it.
// object oChild				- The actual thing to despawn.
// object oParent				- The parent WP with holding the configuration
//	Returns: N/A
void LEG_SPAWN_DeSpawnByMins(object oChild, object oParent);

// ///////////////////////////////////////////////////////////////////////////
// Checks to see if the Quest Plugin is active during an area despawn.
// If the quest plugin is active there may be NPC's in the area with icons
// above their heads.  If this is the case, despawn the icon as well.
// object oChild				- The NPC that may have a quest icon.
//	Returns: N/A
void LEG_SPAWN_DeSpawnQuestIcon(object oChild);

// ///////////////////////////////////////////////////////////////////////////
// If there is more than one spawn site for a paticular spawn point setup
// then this function will randomly select one of the sites to use.  The
// other sites are simply waypoints with the Group Waypoint Tags setup.
// string sParentTag			- The Tag of the primary or #1 WP in the set
// int iSpawn_Points			- The total number of WP's in the group set.
// object oParent				- The parent waypoint that is configured.
//	Returns: Object of the WP that is selected.
object LEG_SPAWN_ChooseSite(string sParentTag, int iSpawn_Points, object oParent);

// ///////////////////////////////////////////////////////////////////////////
// If there is more than one spawn site for a paticular spawn point setup
// then this function will select each site starting with #1 and progressing
// until it reaches the total number in the group each time it is called.
// At that point, it will return the first one again.
// string sParentTag			- The Tag of the primary or #1 WP in the set
// int iSpawn_Points			- The total number of WP's in the group set.
// object oParent				- The parent waypoint that is configured.
//	Returns: Object of the WP that is selected.
object LEG_SPAWN_NextSite(string sParentTag, int iSpawn_Points, object oParent);

// ///////////////////////////////////////////////////////////////////////////
// This function accepts 2 time variables to Activate spawning and Deactivate
// spawning.  Any object that already exists during de-activate will
// despawn, unless it is in a fight or convo or opened and the FORCE option 
// is not set.  
// string sSpawnTOD				- Start time of 0-23, dawn, dusk, day, night
// string sDeSpawnTOD			- End time of 0-23, dawn, dusk, day, night
//	Returns: Object of the WP that is selected.
int LEG_SPAWN_CheckTOD(string sSpawnTOD, string sDeSpawnTOD);

string LEG_SPAWN_ChooseMobByFreq(object oSpawn_Point, string sParentID, int iArrayCount);


// /////////////////////////////////////////////////////////////////////////////////////////////////////
// FUNCTIONS
// /////////////////////////////////////////////////////////////////////////////////////////////////////





// //////////////////////////////////////////////////
// LEG_SPAWN_CreatePlaceableSpawn
// //////////////////////////////////////////////////
void LEG_SPAWN_CreatePlaceableSpawn(object oSpawn_Point, string sSpawnResRef, location lSpawnSite, string sParentID, string sIndex)
{
	// Make the thing go now...
	object oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, sSpawnResRef, lSpawnSite, TRUE);

	//SpeakString("Index: " + sIndex + ", Parent: " + sParentID);
	// Set the var on it.
	SetLocalString(oSpawn, "SPAWN_Index", sIndex);
	SetLocalString(oSpawn, "SPAWN_ParentID", sParentID);
	SetLocalObject(oSpawn_Point, "SPAWN_" + sIndex, oSpawn);
	
	// Set my Time of Birth.  This is used to despawn me when my DeSpawn mins are up.
	LEG_COMMON_TimeOfBirth(oSpawn, oSpawn_Point);
	
	// Do some error checking
	if (!GetIsObjectValid(oSpawn))
	{
		// Ruh-Roh.. we either spawned into a wall or the resref is invalid.. FAIL!
		SendMessageToAllDMs("Notice:  System attempted to spawn an object placeable but failed.  Possibly due to wall interference of incorrect ResRef");
	}
	else
	{
		// Store the parent on this puppy so that we can read the variables later from it.
		SetLocalObject(oSpawn, "SPAWN_Parent", oSpawn_Point);
		
		// Check and see if we need to make this thing Plot otherwise leave it at whatever it is set at in the blueprint.
		if (GetLocalInt(oSpawn_Point, "LEG_SPAWN_Plot"))
			SetPlotFlag(oSpawn, TRUE);
			
		// See if we need to put the visual effect on this placeable object.  Often used on
		// placeable objects in collection type quests.
		if (GetLocalInt(oSpawn_Point, "LEG_SPAWN_VisualEffect"))
		{
			effect eLootBag = EffectNWN2SpecialEffectFile("fx_lootbag.sef");
			DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLootBag, oSpawn));
		}
	}
}


// //////////////////////////////////////////////////
// LEG_SPAWN_CreateMobSpawn
// //////////////////////////////////////////////////
void LEG_SPAWN_CreateMobSpawn(object oSpawn_Point, string sSpawnResRef, location lSpawnSite, string sParentID, string sIndex)
{
	// Create our critter at the location site specified.
	object oSpawn = CreateObject(OBJECT_TYPE_CREATURE, sSpawnResRef, lSpawnSite, TRUE);	
	//SpeakString("Index: " + sIndex + ", Parent: " + sParentID);
	// Set the var on it.
	SetLocalString(oSpawn, "SPAWN_Index", sIndex);
	SetLocalString(oSpawn, "SPAWN_ParentID", sParentID);
	SetLocalObject(oSpawn_Point, "SPAWN_" + sIndex, oSpawn);
	
	// Set my Time of Birth.  This is used to despawn me when my DeSpawn mins are up.
	LEG_COMMON_TimeOfBirth(oSpawn, oSpawn_Point);
	
	// Save the parent WP onto this critter.
	SetLocalObject(oSpawn, "SPAWN_Parent", oSpawn_Point);

	// Check and see if we need to make this thing Plot otherwise leave it at whatever it is set at in the blueprint.
	if (GetLocalInt(oSpawn_Point, "LEG_SPAWN_Plot"))
		SetPlotFlag(oSpawn, TRUE);

	// If our WP tells us to Not Drop Loot when we die, it should override the local mob setting.  Yes this should
	// be a LOOT plugin check but ssshh.. its a secret, we don't need the Loot Plugin to destroy mobs inventory
	// before they die hehehe.
	int iLootDrop = GetLocalInt(oSpawn_Point, "LEG_LOOT_DoNotDropMyLoot");
	if (iLootDrop)
		SetLocalInt(oSpawn, "LEG_LOOT_DoNotDropMyLoot", iLootDrop);

	// If we're using the AI Plugin, then we want to set that up.  Otherwise, skip this section
	// and use whatever AI already exists.  
	if (GetLocalInt(GetModule(), "LEG_AI_ACTIVE"))
	{
		// Set up some AI type stuff for our critter here.
		SetLocalInt(oSpawn, "NW_ANIM_FLAG_CONSTANT", 1);
		SetLocalInt(oSpawn, "X2_USERDEFINED_ONSPAWN_EVENTS", 2);
		SetLocalInt(oSpawn, "NW_FLAG_HEARTBEAT_EVENT", 1);
		
		if (GetLocalInt(oSpawn_Point, "LEG_AI_SpawnCondition"))
			SetLocalInt(oSpawn, "LEG_AI_SpawnCondition", GetLocalInt(oSpawn_Point, "LEG_AI_SpawnCondition"));
		if (GetLocalInt(oSpawn_Point, "LEG_AI_CombatBehavior"))
			SetLocalInt(oSpawn, "LEG_AI_CombatBehavior", GetLocalInt(oSpawn_Point, "LEG_AI_CombatBehavior"));
		if (GetLocalFloat(oSpawn_Point, "LEG_AI_MillRange") > 0.0)
			SetLocalFloat(oSpawn, "LEG_AI_MillRange", GetLocalFloat(oSpawn_Point, "LEG_AI_MillRange"));
		if (GetLocalInt(oSpawn_Point, "LEG_AI_MobType"))
			SetLocalInt(oSpawn, "LEG_AI_MobType", GetLocalInt(oSpawn_Point, "LEG_AI_MobType"));
		if (GetLocalString(oSpawn_Point, "LEG_AI_WalkRoute") != "")
			SetLocalString(oSpawn, "LEG_AI_WalkRoute", GetLocalString(oSpawn_Point, "LEG_AI_WalkRoute"));
		if (GetLocalInt(oSpawn_Point, "LEG_AI_PatrolType") != 0)
			SetLocalInt(oSpawn, "LEG_AI_PatrolType", GetLocalInt(oSpawn_Point, "LEG_AI_PatrolType"));
		if (GetLocalInt(oSpawn_Point, "LEG_AI_SleepChance") != 0)
			SetLocalInt(oSpawn, "LEG_AI_SleepChance", GetLocalInt(oSpawn_Point, "LEG_AI_SleepChance"));
		if (GetLocalInt(oSpawn_Point, "LEG_AI_DayNight") != 0)
			SetLocalInt(oSpawn, "LEG_AI_DayNight", GetLocalInt(oSpawn_Point, "LEG_AI_DayNight"));
		
		// Check to see if there is a waypoint route and follow it, unless this is an NPC that is part of an 
		// escort quest.
		/*string sPatrolRoute = GetLocalString(oSpawn_Point, "LEG_AI_WalkRoute");
		if (sPatrolRoute != "" && GetLocalInt(oSpawn, "LEG_QUEST_Escort") == 0)
		{
			AssignCommand(oSpawn, SetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING));
			SetLocalString(oSpawn, "WP_TAG", sPatrolRoute);
		 	SetWWPController(sPatrolRoute);
		}
		*/
	}
}


// //////////////////////////////////////////////////
// LEG_SPAWN_SpawnHBMan
// //////////////////////////////////////////////////
void LEG_SPAWN_SpawnHBMan(object oArea)
{
	// If our heartbeat man doesn't exist, which can happen when the area is
	// despawned lets check for him and re-create him if needed.
	object oHBMan = GetObjectByTag(GetTag(oArea) + "_legspawnheartbeat");
	if (!GetIsObjectValid(oHBMan) || GetLocalInt(oHBMan, "STOP"))
	{
		oHBMan = CreateObject(OBJECT_TYPE_PLACEABLE, "legspawnheartbeat", GetLocation(GetWaypointByTag(GetTag(oArea) + "_HBMAN")), FALSE, GetTag(oArea) + "_legspawnheartbeat");
	}
	
	// Store all the area's waypoints on Mr. HBMan.
	int iIndex = 0;
	object oSpawn_Point = GetFirstObjectInArea();
	while (GetIsObjectValid(oSpawn_Point))
	{
			// Is this a spawn waypoint?
		if (GetLocalInt(oSpawn_Point, "LEG_SPAWN") && GetObjectType(oSpawn_Point) == OBJECT_TYPE_WAYPOINT)
		{
			iIndex++;
			SetLocalObject(oHBMan, "WP_" + IntToString(iIndex), oSpawn_Point);
		}
		
		oSpawn_Point = GetNextObjectInArea();
	}
	
	// Save how many Spawn WP's are in the area.
	SetLocalInt(oHBMan, "WP_Count", iIndex);
}


// //////////////////////////////////////////////////
// LEG_SPAWN_ChooseSite
// //////////////////////////////////////////////////
object LEG_SPAWN_ChooseSite(string sParentTag, int iSpawn_Points, object oParent)
{	
	// First we need to get the base tag from the parent.
	string sBaseParentTag = GetStringLeft(sParentTag, GetStringLength(sParentTag) - 3);
	
	// Choose one of the waypoints from the group at random.
	int iSpawnPoint = Random(iSpawn_Points) + 1;
	object oSpawnPoint;
	if (iSpawnPoint < 10)
		oSpawnPoint = GetObjectByTag(sBaseParentTag + "_0" + IntToString(iSpawnPoint));
	else
		oSpawnPoint = GetObjectByTag(sBaseParentTag + "_" + IntToString(iSpawnPoint));

	// Store the chosen WP site.
	SetLocalObject(oParent, "SPAWN_NextSpawnLocation", oSpawnPoint);		
	
	// Return with the chosen spawn point.
	return oSpawnPoint;
}


// //////////////////////////////////////////////////
// LEG_SPAWN_ChooseSite
// //////////////////////////////////////////////////
object LEG_SPAWN_NextSite(string sParentTag, int iSpawn_Points, object oParent)
{	
	// First we need to get the base tag from the parent.
	string sBaseParentTag = GetStringLeft(sParentTag, GetStringLength(sParentTag) - 3);
	
	// Choose one of the waypoints from the group at random.
	int iSpawnPoint = GetLocalInt(oParent, "SPAWN_NextWPLocation");
	if (iSpawnPoint > iSpawn_Points || iSpawnPoint == 0)
		iSpawnPoint = 1;
		
	object oSpawnPoint;
	if (iSpawnPoint < 10)
		oSpawnPoint = GetObjectByTag(sBaseParentTag + "_0" + IntToString(iSpawnPoint));
	else
		oSpawnPoint = GetObjectByTag(sBaseParentTag + "_" + IntToString(iSpawnPoint));

	// Store the chosen WP site.
	iSpawnPoint++;
	SetLocalInt(oParent, "SPAWN_NextWPLocation", iSpawnPoint);
	SetLocalObject(oParent, "SPAWN_NextSpawnLocation", oSpawnPoint);		
	
	// Return with the chosen spawn point.
	return oSpawnPoint;
}


// //////////////////////////////////////////////////
// LEG_SPAWN_ProcessSpawn
// //////////////////////////////////////////////////
void LEG_SPAWN_ProcessSpawn(object oSpawn_Point, object oArea, string sParentID, float fSpawnDelay, string sSpawnResRef, string sIndex)
{
	// Set up some variables for location and facing etc.
	int iCount, iAnimation;
	float fAngle, fRadiusX, fRadiusY, fRadius, fFacing;
	vector vRadius, vSpawnVector;
	location lSpawnSite;
	object oSpawn;	

	// We should first check and see if we're supposed to spawn anything at all due to time of day
	// settings on the WP
	string sSpawnTOD = GetLocalString(oSpawn_Point, "LEG_SPAWN_SpawnTOD");
	string sDeSpawnTOD = GetLocalString(oSpawn_Point, "LEG_SPAWN_DeSpawnTOD");
	int iSpawn = FALSE;
	
	// If we don't have a setting, we just assume Spawn is TRUE which mean go ahead and spawn for now.
	// Otherwise go based on the TOD.  If a Start Time is set, then an end time must be set too or
	// we will always spawn.
	if (sSpawnTOD == "" || sDeSpawnTOD == "")
		iSpawn = TRUE;
    else
		iSpawn = LEG_SPAWN_CheckTOD(sSpawnTOD, sDeSpawnTOD);
	
	// No point in going any further if we aren't supposed to spawn anything.
	if (!iSpawn)
		return;
		
	// Before we proceed to determining a spawn site for this object, we need to check and see
	// if this parent waypoint is a member of a group of waypoints used to select random
	// spawn locations (such as in collections from the quest plugin), or if we just want Joe Boss
	// to spawn in different places in the area each time.
	object oSpawn_Site;
	int iSpawnPoints = GetLocalInt(oSpawn_Point, "LEG_SPAWN_GroupCount");
	if (iSpawnPoints > 1)
	{
		// Looks like we are configured to have multiple spawn site locations.  Let's choose one.
		// Before we can choose a location we'll need to check on the spread.  If there is no spread selected
		// then go ahead and choose a random location for EACH mob.
		string sSpread = GetLocalString(oSpawn_Point, "LEG_SPAWN_Spread");
		int iNextWP = GetLocalInt(oSpawn_Point, "SPAWN_NextWPLocation");
		object oNextPoint = GetLocalObject(oSpawn_Point, "SPAWN_NextSpawnLocation");
		
		
		if (sSpread == "Random Spawn Points" || sSpread == "")
			oSpawn_Site = LEG_SPAWN_ChooseSite(GetTag(oSpawn_Point), iSpawnPoints, oSpawn_Point);
		else if (sSpread == "All at One Random Point")
		{
			if (!GetIsObjectValid(oNextPoint))
			{
				//SpeakString("Our Group Does Not have a valid point.  Choosing one.", TALKVOLUME_SHOUT);
				// This is the first mob so let's randomly choose a site and then record it.	
				oSpawn_Site = LEG_SPAWN_ChooseSite(GetTag(oSpawn_Point), iSpawnPoints, oSpawn_Point);
			}
			else
			{
				// We have the number for a site so let's continue to use that.
				//SpeakString("Choosing our standard point.", TALKVOLUME_SHOUT);
				oSpawn_Site = oNextPoint;	
			}
		}
		else if (sSpread == "In Order of Spawn Points")
		{
			oSpawn_Site = LEG_SPAWN_NextSite(GetTag(oSpawn_Point), iSpawnPoints, oSpawn_Point);
		}

		
	}
	else
	{
		// Otherwise our spawn site is the same location as the main parent spawn point;
		oSpawn_Site = oSpawn_Point;
	}
	
	// If we can randomly spawn several meters away from the waypoint, then lets choose a location for it
	fRadius = GetLocalFloat(oSpawn_Site, "LEG_SPAWN_RadiusRange");
	while (!GetIsLocationValid(lSpawnSite))
	{
		if (fRadius != 0.0)
		{
			vSpawnVector = GetPosition(oSpawn_Site);
			fAngle = IntToFloat(Random(361));
			fRadius = IntToFloat(Random(FloatToInt(fRadius)) + 1);
			fRadiusX = fRadius * cos(fAngle);
			fRadiusY = fRadius * sin(fAngle);
			vRadius = Vector(fRadiusX, fRadiusY);
			fFacing = GetFacing(oSpawn_Site);
			lSpawnSite = Location(oArea, vSpawnVector + vRadius, fFacing);
		}
		else
		{
			vSpawnVector = GetPosition(oSpawn_Site);
			fFacing = GetFacing(oSpawn_Site);
			lSpawnSite = Location(oArea, vSpawnVector, fFacing);
		}
	}
	// Lets make it appear!  Just like magic!  Of course based upoin Placeable or Creature
	if (GetLocalInt(oSpawn_Point, "LEG_SPAWN_ObjectType") == 1)
		DelayCommand(fSpawnDelay, LEG_SPAWN_CreatePlaceableSpawn(oSpawn_Point, sSpawnResRef, lSpawnSite, sParentID, sIndex));
	else
		DelayCommand(fSpawnDelay, LEG_SPAWN_CreateMobSpawn(oSpawn_Point, sSpawnResRef, lSpawnSite, sParentID, sIndex));
}


// //////////////////////////////////////////////////
// LEG_SPAWN_DeSpawnHBMan
// //////////////////////////////////////////////////
void LEG_SPAWN_DeSpawnHBMan(object oArea)
{
	// Lets get rid of Mr. Heartbeat man.
	object oHBMan = GetObjectByTag(GetTag(oArea) + "_legspawnheartbeat");
	SetPlotFlag(oHBMan,FALSE);
	AssignCommand(oHBMan, SetIsDestroyable(TRUE, FALSE, FALSE));	
	DestroyObject(oHBMan, 10.0);

}



// //////////////////////////////////////////////////
// LEG_SPAWN_DeSpawnArea
// //////////////////////////////////////////////////
void LEG_SPAWN_DeSpawnArea(object oArea)
{
	// Now we go through and destroy all the mobs.  We have to assign
	// a fresh respawn time to each waypoint spawner for mobs that
	// are still alive though.
	object oSpawn_Point;
	object oChild;
	
	// In the event the Quest Plugin is installed.
	object oQuestIcon;

	// We examine the area searching for Legends spawn points to process which are now all stored on Mr. HBMan
	int iRespawnMins, iCount = 0;
	
	// Find Mr. HBMan and get his WP's.
	object oHBMan = GetObjectByTag(GetTag(oArea) + "_legspawnheartbeat");
	int iTotalWPs = GetLocalInt(oHBMan, "WP_Count");
	string sParentID, sCountType, sMobResRef;
	int iDeSpawned, iObjectType, iCheckDespawn, iDelay, iCount2;

	// Set HBMan to stop spawning.
	SetLocalInt(oHBMan, "STOP", TRUE);
	
	// Don't do anything if the Spawn Plugin is not active.
	if (GetLocalInt(GetModule(), "LEG_SPAWN_ACTIVE"))
	{
		// Cycle through the waypoints stored on HBMan.
		for (iCount = 1; iCount <= iTotalWPs; iCount++)
		{
			// Get the WP.
			oSpawn_Point = GetLocalObject(oHBMan, "WP_" + IntToString(iCount));
			
			// Once we have a spawn point, we see if there are any children objects associated with it which
			// are stored on it.
			// All mobs are stored on the WP now.
			sCountType = GetLocalString(oSpawn_Point, "LEG_SPAWN_Count");
			int iTotalCount;
			if (sCountType == "Full")
			{
				string sParentID = GetLocalString(oSpawn_Point, "LEG_SPAWN_ParentID");
				iTotalCount = LEG_COMMON_GetArrayElementCount(oSpawn_Point, sParentID + "ResRef");
			}
			else
				iTotalCount = GetLocalInt(oSpawn_Point, "LEG_SPAWN_CountTotal");
			int iFriends = GetLocalInt(oSpawn_Point, "LEG_SPAWN_Friends");
			int iSpawnCount = 0;
			
			// See how many spawns are alive.
			int iIndex = 1;
			for (iIndex = 1; iIndex <= iTotalCount; iIndex++)
			{
				oChild = GetLocalObject(oSpawn_Point, "SPAWN_" + IntToString(iIndex));
				if (GetIsObjectValid(oChild))
				{
					// Get rid of any quest icons in the quest plugin if it is active.
					LEG_SPAWN_DeSpawnQuestIcon(oChild);
					
					// We should not allow any inventory items to be left laying around during a despawn.  Remember
					// DESPAWNS DO NOT DROP LOOT!  Only On-Death (or On Open if a placeable LOOT object).
					LEG_COMMON_DestroyInventory(oChild);
					
					// Now go ahead and destroy any dynamically placed objects such as NPCs, Monsters, Placeables & Inventory etc.
					SetPlotFlag(oChild,FALSE);				
					AssignCommand(oChild, SetIsDestroyable(TRUE, FALSE, FALSE));

					// Because this object wasn't destroyed or despawned by natural means, it was despawned due to
					// players leaving the area, we don't want returning players to have to wait the full respawn
					// cycle again so we set the TimeOfDeath variable back far enough to cause the CheckSpawn function
					// to re-spawn them when they come back.
					int iMinMins = GetLocalInt(oSpawn_Point, "LEG_SPAWN_MinRespawnMins");
					int iMaxMins = GetLocalInt(oSpawn_Point, "LEG_SPAWN_MaxRespawnMins");
					int iRespawnMins;
					if (iMinMins == -1)
						iRespawnMins = -1;
					else
						iRespawnMins = Random(iMaxMins - iMinMins + 1) + iMinMins;
					
					string sParentID = GetLocalString(oChild, "SPAWN_ParentID");
					string sIndex = GetLocalString(oChild, "SPAWN_Index");
					string sCountType = GetLocalString(oSpawn_Point, "LEG_SPAWN_Count");
					if (sCountType == "Full")
						LEG_COMMON_SetArrayElement(oSpawn_Point, sParentID + "TOD", StringToInt(sIndex), IntToString(LEG_COMMON_TimeStamp() - (iRespawnMins * REAL_MINUTES)));
					else
						SetLocalInt(oSpawn_Point, "SPAWN_TOD_" + sIndex, LEG_COMMON_TimeStamp() - (iRespawnMins * REAL_MINUTES));
			
					DestroyObject(oChild, IntToFloat(iCount) * 0.1);
				}
			}
		}			
	}
}



// //////////////////////////////////////////////////
// LEG_SPAWN_DeSpawnTOD
// //////////////////////////////////////////////////
int LEG_SPAWN_DeSpawnTOD(object oChild, object oParent)
{
	// First of all, we don't want our critters despawning in the middle of a fight or conversation
	// unless forced to.
	if ((GetIsInCombat(oChild) || IsInConversation(oChild) || GetIsOpen(oChild)) && !GetLocalInt(oParent, "LEG_SPAWN_ForceDespawn"))
	{
		return 0;
	}
	
	// We should first check and see if we're supposed to spawn anything at all due to time of day
	// settings on the WP
	string sSpawnTOD = GetLocalString(oParent, "LEG_SPAWN_SpawnTOD");
	string sDeSpawnTOD = GetLocalString(oParent, "LEG_SPAWN_DeSpawnTOD");
	int iSpawn = TRUE;
	
	// If we don't have a setting, we just assume Spawn is TRUE which mean go ahead and spawn for now.
	// Otherwise go based on the TOD.  If a Start Time is set, then an end time must be set too or
	// we will always spawn.
	if (sSpawnTOD == "" || sDeSpawnTOD == "")
		iSpawn = TRUE;
    else
		iSpawn = LEG_SPAWN_CheckTOD(sSpawnTOD, sDeSpawnTOD);
	
	// No point in going any further if we are TRUE for spawning right now.  Return that I did NOT despawn.
	if (iSpawn)
		return FALSE;
	
		
	// One more check for validity and Despawn confirmation.
	if(GetIsObjectValid(oChild) && iSpawn == FALSE)
	{
		// If I am despawning and the Banter plugin is active, check and see if I should say something.
		if (GetLocalInt(GetModule(), "LEG_BANTER_ACTIVE"))
		{
			// See if we have and Banter ID's
			string sBanterForcedID = GetLocalString(oChild, "LEG_BANTER_OnDeSpawnForced");
			string sBanterID = GetLocalString(oChild, "LEG_BANTER_OnDeSpawn");
			int iBanterChance = GetLocalInt(oChild, "LEG_BANTER_OnDeSpawnChance");
			
			// If we do, then lets see if we can speak.
			if (sBanterID != "" || sBanterForcedID != "")
			{
				// If this is a forced respawn
				if ((GetIsInCombat(oChild) || IsInConversation(oChild) || GetIsOpen(oChild)) && sBanterForcedID != "")
				{
					// We're in Combat or Convo so let's speak our forced.
					AddScriptParameterString(sBanterForcedID);
					AddScriptParameterInt(iBanterChance);
					AddScriptParameterString("Custom");
					ExecuteScriptEnhanced("leg_banter_speak", oChild);
				}
				else if ((!GetIsInCombat(oChild) && !IsInConversation(oChild) && !GetIsOpen(oChild)) && sBanterID != "")
				{
					// We're not in combat so lets speak our Regular one.
					AddScriptParameterString(sBanterID);
					AddScriptParameterInt(iBanterChance);
					AddScriptParameterString("Custom");
					ExecuteScriptEnhanced("leg_banter_speak", oChild);
				}
			}
		}

		// If the Quest Plugin is active we should destroy any quest icon for this NPC.
		LEG_SPAWN_DeSpawnQuestIcon(oChild);

		// We should not allow any inventory items to be left laying around during a despawn.  Remember
		// DESPAWNS DO NOT DROP LOOT!  Only On-Death (or On Open if a placeable LOOT object).
		LEG_COMMON_DestroyInventory(oChild);
				
		// Now get rid of the Child object set to despawn at this time.
		SetPlotFlag(oChild,FALSE);
		AssignCommand(oChild, SetIsDestroyable(TRUE, FALSE, FALSE));
		DestroyObject(oChild);
		
		// Because this object was despawned due to time of day, we need to ensure that it is
		// supposed to respawn in a timely fashion when players come back.
		int iRespawnMins = GetLocalInt(oParent, "LEG_SPAWN_RespawnMins");
		SetLocalInt(oParent, "SPAWN_TimeOfDeath", LEG_COMMON_TimeStamp() - (iRespawnMins * REAL_MINUTES));
	}			
	
	// Return that I Despawned or I don't exist.
	return TRUE;
}



// //////////////////////////////////////////////////
// LEG_SPAWN_DeSpawnByMins
// //////////////////////////////////////////////////
void LEG_SPAWN_DeSpawnByMins(object oChild, object oParent)
{
	// First of all, we don't want our critters despawning in the middle of a fight or conversation
	// unless forced to.
	if ((GetIsInCombat(oChild) || IsInConversation(oChild) || GetIsOpen(oChild)) && !GetLocalInt(oParent, "LEG_SPAWN_ForceDespawn"))
	{
		return;
	}
	
	// Despawn this critter or placeable, just cuz its time to.  Some objects have a LEG_SPAWN_DeSpawnMins
	// variable checked (which is reviewed during the "CheckSpawns" function).
	int iCurrentTime = LEG_COMMON_TimeStamp();
	int iDeSpawnMins = GetLocalInt(oParent, "LEG_SPAWN_DeSpawnMins");

	int iTimeOfBirthStamp;
	string sParentID = GetLocalString(oChild, "SPAWN_ParentID");
	string sIndex = GetLocalString(oChild, "SPAWN_Index");
	string sCountType = GetLocalString(oParent, "LEG_SPAWN_Count");
		
	//SpeakString("Index " + sIndex + " Mob is being checked for DESPAWN", TALKVOLUME_SHOUT);

	if (sCountType == "Full")
		iTimeOfBirthStamp = StringToInt(LEG_COMMON_GetArrayElement(oParent, sParentID + "TOB", StringToInt(sIndex)));
	else
		iTimeOfBirthStamp = GetLocalInt(oParent, "SPAWN_TOB_" + sIndex);
		
	//SpeakString("Index " + sIndex + " Mob time of birth: " + IntToString(iTimeOfBirthStamp), TALKVOLUME_SHOUT);
	
	// If the Despawn Mins + Current Time is greater than the Time of Birth, then time to despawn (no loot).
	if (iCurrentTime >= iTimeOfBirthStamp + (iDeSpawnMins * REAL_MINUTES))	
	{
		// If I am despawning and the Banter plugin is active, check and see if I should say something.
		if (GetLocalInt(GetModule(), "LEG_BANTER_ACTIVE"))
		{
			// See if we have and Banter ID's
			string sBanterForcedID = GetLocalString(oChild, "LEG_BANTER_OnDeSpawnForced");
			string sBanterID = GetLocalString(oChild, "LEG_BANTER_OnDeSpawn");
			int iBanterChance = GetLocalInt(oChild, "LEG_BANTER_OnDeSpawnChance");
			
			// If we do, then lets see if we can speak.
			if (sBanterID != "" || sBanterForcedID != "")
			{
				// If this is a forced respawn
				if ((GetIsInCombat(oChild) || IsInConversation(oChild) || GetIsOpen(oChild)) && sBanterForcedID != "")
				{
					// We're in Combat or Convo so let's speak our forced.
					AddScriptParameterString(sBanterForcedID);
					AddScriptParameterInt(iBanterChance);
					AddScriptParameterString("Custom");
					ExecuteScriptEnhanced("leg_banter_speak", oChild);
				}
				else if ((!GetIsInCombat(oChild) && !IsInConversation(oChild) && !GetIsOpen(oChild)) && sBanterID != "")
				{
					// We're not in combat so lets speak our Regular one.
					AddScriptParameterString(sBanterID);
					AddScriptParameterInt(iBanterChance);
					AddScriptParameterString("Custom");
					ExecuteScriptEnhanced("leg_banter_speak", oChild);
				}
			}
		}
		
		// Time to die.............
		// If the Quest Plugin is active we should destroy any quest icon for this NPC.
		LEG_SPAWN_DeSpawnQuestIcon(oChild);
		
		// No loot for you!
		LEG_COMMON_DestroyInventory(oChild);
		
		// Now get rid of the Child object set to despawn at this time.
		SetPlotFlag(oChild,FALSE);
		AssignCommand(oChild, SetIsDestroyable(TRUE, FALSE, FALSE));

		//SpeakString("Index " + sIndex + " Mob is being de-spawned.", TALKVOLUME_SHOUT);
		SetLocalObject(oParent, "SPAWN_" + sIndex, OBJECT_INVALID);
		
		// Now that we are dead due to a DeSpawn timer happening, let's re-start the Re-Spawn timer
		LEG_COMMON_TimeOfDeath(oChild, oParent);
		
		DestroyObject(oChild, 1.0);		
	}
}



// //////////////////////////////////////////////////
// LEG_SPAWN_DeSpawnQuestIcon
// //////////////////////////////////////////////////
void LEG_SPAWN_DeSpawnQuestIcon(object oChild)
{
	// Get rid of any quest icons in the quest plugin if it is active.
	if (GetLocalInt(GetModule(), "LEG_QUEST_ACTIVE"))
	{
		object oQuestIcon = GetLocalObject(oChild, "MyIcon");
		if(GetIsObjectValid(oQuestIcon))
		{
			SetPlotFlag(oQuestIcon,FALSE);
			AssignCommand(oQuestIcon, SetIsDestroyable(TRUE, FALSE, FALSE));
			DestroyObject(oQuestIcon);
		}
	}
}

// //////////////////////////////////////////////////
// LEG_SPAWN_CheckTOD
// //////////////////////////////////////////////////
int LEG_SPAWN_CheckTOD(string sSpawnTOD, string sDeSpawnTOD)
{
	// We need this function to determine Spawn and DeSpawn TOD's.  If we are supposed to Despawn during a particular
	// time of day, we certainly don't want a critter spawning etc.
	int iStartSpawn = LEG_COMMON_StringToHour(sSpawnTOD);
	int iEndSpawn = LEG_COMMON_StringToHour(sDeSpawnTOD);
	int iCurrentHour = GetTimeHour();
	
	// We want to return TRUE if its time to spawn, and FALSE if it's time to Despawn.  If the End Spawn is in the next
	// day, we need to be able to identify and deal with that.
	if (iEndSpawn < iStartSpawn)
	{
		// Looks like our end spawn is the next day so we'll throw a little check here for time due to that.
		if (iCurrentHour < iEndSpawn)
			return TRUE;
		else if (iCurrentHour >= iStartSpawn)
			return TRUE;
		else
			return FALSE;
	}
	else
	{
		// Here the Spawn time and Despawn time are in the same day so it's a little simpler.
		if (iCurrentHour >= iStartSpawn && iCurrentHour < iEndSpawn)
			return TRUE;
		else
			return FALSE;
	}
}



// //////////////////////////////////////////////////
// LEG_SPAWN_InitializeWPs
// //////////////////////////////////////////////////
void LEG_SPAWN_InitializeWPs(object oArea)
{
	// Initialize the waypoints as they haven't been initialized yet.
	object oSpawn_Point = GetFirstObjectInArea(oArea);
	while (GetIsObjectValid(oSpawn_Point))
	{
		// Is this a spawn waypoint?
		if (GetLocalInt(oSpawn_Point, "LEG_SPAWN") && GetObjectType(oSpawn_Point) == OBJECT_TYPE_WAYPOINT)
		{
			// Create a Unique ID for this waypoint and save it.
			location lLocation = GetLocation(oSpawn_Point);
	    	object oArea = GetAreaFromLocation(lLocation);
	    	vector vPosition = GetPositionFromLocation(lLocation);
	    	float fOrientation = GetFacingFromLocation(lLocation);
			string sID = GetStringLeft(GetTag(oArea) + "#" + FloatToString(vPosition.x) + "#" + FloatToString(vPosition.y) + "#" + FloatToString(vPosition.z) + "#" + FloatToString(fOrientation), 50);
			SetLocalString(oSpawn_Point, "LEG_SPAWN_ParentID", sID);
			
			// Now create the arrays for this waypoint.
			int iGridCount = GetLocalInt(oSpawn_Point, "LEG_SPAWN_GridCount");
			
			// Spawn Count Type
			string sSpawnCount = GetLocalString(oSpawn_Point, "LEG_SPAWN_Count");

		    if (sSpawnCount == "Full")
			{
				// Create array based on all objects
				int iIndex, iIndex2;
				for (iIndex = 1; iIndex <= iGridCount; iIndex++)
				{
					int iQuantity = GetLocalInt(oSpawn_Point, "LEG_SPAWN_Qty_" + IntToString(iIndex));
					string sResRef = GetLocalString(oSpawn_Point, "LEG_SPAWN_ResRef_" + IntToString(iIndex));
					string sFreq = GetLocalString(oSpawn_Point, "LEG_SPAWN_Freq_" + IntToString(iIndex));
					for (iIndex2 = 1; iIndex2 <= iQuantity; iIndex2++)
					{
						LEG_COMMON_AddArrayElement(oSpawn_Point, sID + "ResRef", sResRef);
						LEG_COMMON_AddArrayElement(oSpawn_Point, sID + "Freq", sFreq);
						LEG_COMMON_AddArrayElement(oSpawn_Point, sID + "TOD", "0");
						LEG_COMMON_AddArrayElement(oSpawn_Point, sID + "TOB", "0");
					}
				}
			}
			else
			{
				// Create array based on randomly chosen mobs.
				// Create array based on all objects
				// We set the TOTAL count of mobs at initialization
				int iMinCount = GetLocalInt(oSpawn_Point, "LEG_SPAWN_CountMin");
				int iMaxCount = GetLocalInt(oSpawn_Point, "LEG_SPAWN_CountMax");
				SetLocalInt(oSpawn_Point, "LEG_SPAWN_CountTotal", Random(iMaxCount - iMinCount + 1) + iMinCount);

				int iIndex, iIndex2;
				for (iIndex = 1; iIndex <= iGridCount; iIndex++)
				{
					int iQuantity = GetLocalInt(oSpawn_Point, "LEG_SPAWN_Qty_" + IntToString(iIndex));
					string sResRef = GetLocalString(oSpawn_Point, "LEG_SPAWN_ResRef_" + IntToString(iIndex));
					string sFreq = GetLocalString(oSpawn_Point, "LEG_SPAWN_Freq_" + IntToString(iIndex));
					LEG_COMMON_AddArrayElement(oSpawn_Point, sID + "ResRef", sResRef);
					LEG_COMMON_AddArrayElement(oSpawn_Point, sID + "Freq", sFreq);
					LEG_COMMON_AddArrayElement(oSpawn_Point, sID + "TOD", "0");
					LEG_COMMON_AddArrayElement(oSpawn_Point, sID + "TOB", "0");
				}
			}
		}
		
		// NEXT!
		oSpawn_Point = GetNextObjectInArea();	
	}
	
	// Set the area as initialized
	SetLocalInt(oArea, "SPAWN_AreaInit", TRUE);
}



// //////////////////////////////////////////////////
// LEG_SPAWN_ChooseMobByFreq
// //////////////////////////////////////////////////
string LEG_SPAWN_ChooseMobByFreq(object oSpawn_Point, string sParentID, int iArrayCount)
{
	// Randomly choose an element.
	string sMobResRef = "";
	int iRandom = Random(iArrayCount) + 1;
	//SpeakString("Choosing Array: " + IntToString(iRandom), TALKVOLUME_SHOUT);
	
	// Look up the Frequency for this element.
	string sFreq = LEG_COMMON_GetArrayElement(oSpawn_Point, sParentID + "Freq", iRandom);
	//SpeakString("Frequency: " + sFreq, TALKVOLUME_SHOUT);
	if (sFreq == "Common")
	{
		if (d100() <= COMMON)
		{
			sMobResRef = LEG_COMMON_GetArrayElement(oSpawn_Point, sParentID + "ResRef", iRandom);			
			//SpeakString("Mob ResRef: " + sMobResRef, TALKVOLUME_SHOUT);
		}
		else
		{
			sMobResRef = "";
			//SpeakString("Mob ResRef: " + sMobResRef, TALKVOLUME_SHOUT);
		}
	}
	else if (sFreq == "Uncommon")
	{
		if (d100() <= UNCOMMON)
			sMobResRef = LEG_COMMON_GetArrayElement(oSpawn_Point, sParentID + "ResRef", iRandom);			
		else
			sMobResRef = "";
	}
	else if (sFreq == "Rare")
	{
		if (d100() <= RARE)
		{
			sMobResRef = LEG_COMMON_GetArrayElement(oSpawn_Point, sParentID + "ResRef", iRandom);			
			//SpeakString("Mob ResRef: " + sMobResRef, TALKVOLUME_SHOUT);
		}
		else
		{
			sMobResRef = "";
			//SpeakString("Mob ResRef: " + sMobResRef, TALKVOLUME_SHOUT);
		}
		
	}
	else if (sFreq == "Very Rare")
	{
		if (d100() <= VERYRARE)
			sMobResRef = LEG_COMMON_GetArrayElement(oSpawn_Point, sParentID + "ResRef", iRandom);			
		else
			sMobResRef = "";
	}
	
	return sMobResRef;
}


// //////////////////////////////////////////////////
// LEG_SPAWN_CheckSpawns
// //////////////////////////////////////////////////
void LEG_SPAWN_CheckSpawns(object oArea)
{
	object oSpawn_Point;
	object oHBMan = GetObjectByTag(GetTag(oArea) + "_legspawnheartbeat");
	int iTotalWPs = GetLocalInt(oHBMan, "WP_Count");
	string sParentID, sCountType, sMobResRef;
	int iCount, iDeSpawned, iObjectType, iCheckDespawn, iDelay, iCount2;

	// Don't do anything if the Spawn Plugin is not active.
	if (GetLocalInt(GetModule(), "LEG_SPAWN_ACTIVE"))
	{
		for (iCount = 1; iCount <= iTotalWPs; iCount++)
		{
			oSpawn_Point = GetLocalObject(oHBMan, "WP_" + IntToString(iCount));
			sParentID = GetLocalString(oSpawn_Point, "LEG_SPAWN_ParentID");
			iObjectType = GetLocalInt(oSpawn_Point, "LEG_SPAWN_ObjectType");
			sCountType = GetLocalString(oSpawn_Point, "LEG_SPAWN_Count");
				
			
			if (sCountType == "Full")
			{
				
				// Cycle through the array and look for a spawner.  (Note we skip element 0)
				sMobResRef = LEG_COMMON_GetFirstArrayElement(oSpawn_Point, sParentID + "ResRef");
				int iIndex = 1;
				while (sMobResRef != "#OUTOFBOUNDS#" && sMobResRef != "#EOA#")
				{
					iCheckDespawn = FALSE;
					//SpeakString("Processing array element: " + IntToString(iIndex) + " Mob Resref: " + sMobResRef, TALKVOLUME_SHOUT);
					// Now look for a mob or placeable with this array index.
					object oMob = GetLocalObject(oSpawn_Point, "SPAWN_" + IntToString(iIndex));
					if (GetIsObjectValid(oMob))
					{
						// If the Count Type is FULL, then we simply look for this Mob of this Array Index
						// see if he exists, if so, we'll check a de-spawn.  If not, we check the respawn 
						// requirements and respawn him.  If Count Type is RANDOM, we simply look for the mob
						// if he exists we add 1 to a counter and move on to the next array index.  If the total
						// mobs is less than our MAX spawn count, then we randomlly choose a mob to spawn
						// provided all other respawn requirements are met (ie; Mins, TOD etc).
						iCheckDespawn = TRUE;
					}
					
					if (iCheckDespawn)
					{
						iDeSpawned = LEG_SPAWN_DeSpawnTOD(oMob, oSpawn_Point);
	
						// If we are not de-spawned as a result of a TOD, then we should check for a DeSpawnMins
						// variable.
						if (!iDeSpawned && GetLocalInt(oSpawn_Point, "LEG_SPAWN_DeSpawnMins"))
							LEG_SPAWN_DeSpawnByMins(oMob, oSpawn_Point);
					
					}					
					else if (sCountType == "Full")
					{
						// Check and see if we need to spawn this.
						// Nope, the Child does not exist.  Let's check and see if we have a respawn timer and if its passed.
						int iCurrentTime = LEG_COMMON_TimeStamp();
						int iMinMins = GetLocalInt(oSpawn_Point, "LEG_SPAWN_MinRespawnMins");
						int iMaxMins = GetLocalInt(oSpawn_Point, "LEG_SPAWN_MaxRespawnMins");
						int iRespawnMins;
						if (iMinMins == -1)
							iRespawnMins = -1;
						else
							iRespawnMins = Random(iMaxMins - iMinMins + 1) + iMinMins;
						int iTimeOfDeathStamp = StringToInt(LEG_COMMON_GetArrayElement(oSpawn_Point, sParentID + "TOD", iIndex));
						int iRespawnTime = (iRespawnMins * REAL_MINUTES) + iTimeOfDeathStamp;
	
						// We should also check and see if we have spawned since the last server reset and if we are only
						// supposed to spawn once per reset.
						int iSpawnOnce = GetLocalInt(oSpawn_Point, "LEG_SPAWN_SpawnOncePerReset");
						
						// We should also check and see if we only spawn from an external trigger such as a conversation,
						// mob death or whatever.
						int iSpawnTrigger = GetLocalInt(oSpawn_Point, "LEG_SPAWN_TriggerSpawn");
						if (!iSpawnTrigger)
						{
							// We like to set a slight delay of .1 seconds in between spawns just to keep things sane.
							iDelay++;
							// If we don't have a current time stamp, we have not spawned since the last server reset, so lets spawn.
							if (iTimeOfDeathStamp == 0)
							{
								LEG_SPAWN_ProcessSpawn(oSpawn_Point, oArea, sParentID, IntToFloat(iDelay) * 0.1, sMobResRef, IntToString(iIndex));
							}
							else if (iCurrentTime >= iRespawnTime)
							{
								// Looks like we did have a timestamp and its passed so lets spawn.  Note, if the LEG_SPAWN_RespawnMins
								// is set to -1, then this thing will only spawn once per server reset.
								if (iRespawnMins != -1 && iSpawnOnce == FALSE)
								{
									LEG_SPAWN_ProcessSpawn(oSpawn_Point, oArea, sParentID, IntToFloat(iDelay) * 0.1, sMobResRef, IntToString(iIndex));
								}
							}
						}						
					}
					
					// All done with this index totally now.  So let's move on to the next index.
					iIndex++;
					sMobResRef = LEG_COMMON_GetNextArrayElement(oSpawn_Point, sParentID + "ResRef");
				}			
			}
			else
			{
				// Randomly choose a mob from our array and see if we should spawn.  I got that backwards, check to 
				// see if we should add a spawn and then choose one.
				int iTotalCount = GetLocalInt(oSpawn_Point, "LEG_SPAWN_CountTotal");
				int iSpawnCount = 0;
				
				//SpeakString("Total Count = " + IntToString(iTotalCount), TALKVOLUME_SHOUT);
				// See how many spawns are alive.
				int iIndex = 1;
				object oMob;
				for (iIndex = 1; iIndex <= iTotalCount; iIndex++)
				{
					//SpeakString("Processing Index: " + IntToString(iIndex), TALKVOLUME_SHOUT);
					oMob = GetLocalObject(oSpawn_Point, "SPAWN_" + IntToString(iIndex));
					if (GetIsObjectValid(oMob))
					{
						// This mob is valid, check for de-spawn and increase valid count.  If not despawning
						// we increase the current count, otherwise, this guy doesn't count.
						iDeSpawned = LEG_SPAWN_DeSpawnTOD(oMob, oSpawn_Point);
	
						// If we are not de-spawned as a result of a TOD, then we should check for a DeSpawnMins
						// variable.
						if (!iDeSpawned && GetLocalInt(oSpawn_Point, "LEG_SPAWN_DeSpawnMins"))
							LEG_SPAWN_DeSpawnByMins(oMob, oSpawn_Point);
					}
					else
					{
						//SpeakString("Mob Index: " + IntToString(iIndex) + " is NOT valid.  Checking respawn", TALKVOLUME_SHOUT);
						// This slot is dead or hasn't spawned yet.  We will process it now and randomly choose
						// a RESREF to spawn
						// Check and see if we need to spawn this.
						// Nope, the Child does not exist.  Let's check and see if we have a respawn timer and if its passed.
						int iCurrentTime = LEG_COMMON_TimeStamp();
						int iMinMins = GetLocalInt(oSpawn_Point, "LEG_SPAWN_MinRespawnMins");
						int iMaxMins = GetLocalInt(oSpawn_Point, "LEG_SPAWN_MaxRespawnMins");
						int iRespawnMins;
						if (iMinMins == -1)
							iRespawnMins = -1;
						else
							iRespawnMins = Random(iMaxMins - iMinMins + 1) + iMinMins;
						int iTimeOfDeathStamp = GetLocalInt(oSpawn_Point, "SPAWN_TOD_" + IntToString(iIndex));
						int iRespawnTime = (iRespawnMins * REAL_MINUTES) + iTimeOfDeathStamp;
	
						//SpeakString("Mob Index: " + IntToString(iIndex) + " time of death: " + IntToString(iTimeOfDeathStamp), TALKVOLUME_SHOUT);
						// We should also check and see if we have spawned since the last server reset and if we are only
						// supposed to spawn once per reset.
						int iSpawnOnce = GetLocalInt(oSpawn_Point, "LEG_SPAWN_SpawnOncePerReset");
						
						// We should also check and see if we only spawn from an external trigger such as a conversation,
						// mob death or whatever.
						int iSpawnTrigger = GetLocalInt(oSpawn_Point, "LEG_SPAWN_TriggerSpawn");
						if (!iSpawnTrigger)
						{
							// We like to set a slight delay of .1 seconds in between spawns just to keep things sane.
							iDelay++;
							// If we don't have a current time stamp, we have not spawned since the last server reset, so lets spawn.
							if (iTimeOfDeathStamp == 0)
							{
								// We have to create a spawn.  We haven't chosen one yet so let's randomly choose one.
								// Randomly choose an index from the array.  How many elements are in the array?
								int iArrayCount = LEG_COMMON_GetArrayElementCount(oSpawn_Point, sParentID + "ResRef");
								sMobResRef = "";
								while (sMobResRef == "")
								{
									sMobResRef = LEG_SPAWN_ChooseMobByFreq(oSpawn_Point, sParentID, iArrayCount);
								}
								LEG_SPAWN_ProcessSpawn(oSpawn_Point, oArea, sParentID, IntToFloat(iDelay) * 0.1, sMobResRef, IntToString(iIndex));
							}
							else if (iCurrentTime >= iRespawnTime)
							{
								// Looks like we did have a timestamp and its passed so lets spawn.  Note, if the LEG_SPAWN_RespawnMins
								// is set to -1, then this thing will only spawn once per server reset.
								if (iRespawnMins != -1 && iSpawnOnce == FALSE)
								{
									// We have to create a spawn.  We haven't chosen one yet so let's randomly choose one.
									// We have to create a spawn.  We haven't chosen one yet so let's randomly choose one.
									// Randomly choose an index from the array.  How many elements are in the array?
									int iArrayCount = LEG_COMMON_GetArrayElementCount(oSpawn_Point, sParentID + "ResRef");
									int iRandom = 0;
									sMobResRef = "";
									while (sMobResRef == "")
									{
										sMobResRef = LEG_SPAWN_ChooseMobByFreq(oSpawn_Point, sParentID, iArrayCount);
									}										
									LEG_SPAWN_ProcessSpawn(oSpawn_Point, oArea, sParentID, IntToFloat(iDelay) * 0.1, sMobResRef, IntToString(iIndex));
								}
							}
						}						
					}
				}
			}
		}
	}
}
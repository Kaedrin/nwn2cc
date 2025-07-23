//
// Spawn Camp
//
//
// CampNumP
// CampNumC
// CampRadius
// CampTrigger
// CampTriggerScript
//
// RW       : Random Walk
// SF       : Spawn Facing Camp
// SG       : Spawn Group
// LT00     : Loot Table
// CD000|T0 : Corpse Decay
// PL0|T00  : Placeable Trap Disabled
// DT000    : Death Script
// RH000    : Return Home
//
//
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
//
//
void SetCampSpawn(object oCamp, string sCamp, location lCamp)
{

//
// Place Custom Camps Here
// -------------------------------------------


    // Example Camp
    // One Campfire and 4 Goblins
    if (sCamp == "goblincamp")
    {

        // Set Number of Placeables
        SetLocalInt(oCamp, "CampNumP", 2);
        // Set Number of Creatures
        SetLocalInt(oCamp, "CampNumC", 4);
        // Set Radius of Camp
        SetLocalFloat(oCamp, "CampRadius", 10.0);

        // Set Creature 0 to be Trigger
        // Script 00 : Kill him and the Camp Despawns
        SetLocalString(oCamp, "CampTrigger", "C0");
        SetLocalInt(oCamp, "CampTriggerScript", 0);

        // Set Placeable 0 to be Camp Center
        SetLocalString(oCamp, "CampCenter", "P0");

        // Set Placeable 0 and Spawn Flags
        // First Placeable always Spawns at Center of Camp
        // If CampCenter Is Not Set
        SetLocalString(oCamp, "CampP0", "plc_campfrwspit");
        SetLocalString(oCamp, "CampP0_Flags", "SP_SF");

        // Set Placeable 1 and Spawn Flags
        SetLocalString(oCamp, "CampP1", "plc_chest1");
        SetLocalString(oCamp, "CampP1_Flags", "SP_PL3T80P30");

        // Set Creature 0 and Spawn Flags
        SetLocalString(oCamp, "CampC0", "NW_GOBCHIEFB");
        SetLocalString(oCamp, "CampC0_Flags", "SP_RW_CD60_RH30");

        // Set Creature 1 and Spawn Flags
        SetLocalString(oCamp, "CampC1", "goblins_low");
        SetLocalString(oCamp, "CampC1_Flags", "SP_SF_SG_CD60_RH");

        // Set Creature 2 and Spawn Flags
        SetLocalString(oCamp, "CampC2", "goblins_low");
        SetLocalString(oCamp, "CampC2_Flags", "SP_SF_SG_CD60_RH");

        // Set Creature 3 and Spawn Flags
        SetLocalString(oCamp, "CampC3", "goblins_low");
        SetLocalString(oCamp, "CampC3_Flags", "SP_SF_SG_CD60_RH");
    }
    else if (sCamp == "demoncamp")
    {

        // Set Number of Placeables
        SetLocalInt(oCamp, "CampNumP", 2);
        // Set Number of Creatures
        SetLocalInt(oCamp, "CampNumC", 4);
        // Set Radius of Camp
        SetLocalFloat(oCamp, "CampRadius", 5.0);

        // Set Creature 0 to be Trigger
        // Script 00 : Kill him and the Camp Despawns
        SetLocalString(oCamp, "CampTrigger", "C0");
        SetLocalInt(oCamp, "CampTriggerScript", 0);

        // Set Placeable 0 to be Camp Center
        SetLocalString(oCamp, "CampCenter", "P0");

        // Set Placeable 0 and Spawn Flags
        // First Placeable always Spawns at Center of Camp
        // If CampCenter Is Not Set
        SetLocalString(oCamp, "CampP0", "plc_campfrwspit");
        SetLocalString(oCamp, "CampP0_Flags", "SP_SF");

        // Set Placeable 1 and Spawn Flags
        SetLocalString(oCamp, "CampP1", "plc_chest1");
        SetLocalString(oCamp, "CampP1_Flags", "SP_PL3T80P30");

        // Set Creature 0 and Spawn Flags
        SetLocalString(oCamp, "CampC0", "NW_DEMON");
        SetLocalString(oCamp, "CampC0_Flags", "SP_RW");

        // Set Creature 1 and Spawn Flags
        SetLocalString(oCamp, "CampC1", "NW_DEMON");
        SetLocalString(oCamp, "CampC1_Flags", "SP_SF");

        // Set Creature 2 and Spawn Flags
        SetLocalString(oCamp, "CampC2", "NW_DEMON");
        SetLocalString(oCamp, "CampC2_Flags", "SP_SF");

        // Set Creature 3 and Spawn Flags
        SetLocalString(oCamp, "CampC3", "NW_DEMON");
        SetLocalString(oCamp, "CampC3_Flags", "SP_SF");
    }
    //


// -------------------------------------------
//
}
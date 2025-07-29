//
// Spawn Flags
//
void SpawnFlags(object oSpawn, int nFlagTableNumber)
{
    // Initialize Values
    string sSpawnName = GetLocalString(oSpawn, "f_Flags");
    string sSpawnTag = GetLocalString(oSpawn, "f_Template");
    string sFlags, sTemplate;

//
// Only Make Modifications Between These Lines
// -------------------------------------------


    // Sample Complex Replacement
    // Using FT without FT00 will
    // Default to nFlagTableNumber 0
    if (nFlagTableNumber == 0)
    {
        // Old Method of using SpawnTag
        if (sSpawnTag == "myspawns")
        {
            sFlags = "SP_SN02_SA_RW";
            sTemplate = "NW_DOG";
        }

        if (sSpawnTag == "undead")
        {
            sFlags = "SP_SNO4";
            sTemplate = "NW_ZOMBIE01";
        }
    }
    //

    // Sample Simple Replacement Flag
    // Completely Replaces Flags
    // On Spawnpoints with FT01
    if (nFlagTableNumber == 1)
    {
        sFlags = "SP_SN04_RW_DOD";
        sTemplate = "NW_DOG";
    }
    //

    // Sample Template Flags
    // These Flags Get Added
    // To Spawnpoints with FT02
    if (nFlagTableNumber == 2)
    {
        sFlags = "_RW_PC05R";
    }
    //


// -------------------------------------------
// Only Make Modifications Between These Lines
//

    // Record Values
    if (sFlags != "")
    {
        SetLocalString(oSpawn, "f_Flags", sFlags);
    }
    else
    {
        SetLocalString(oSpawn, "f_Flags", sSpawnName);
    }
    if (sTemplate != "")
    {
        SetLocalString(oSpawn, "f_Template", sTemplate);
    }
    else
    {
        SetLocalString(oSpawn, "f_Template", sSpawnTag);
    }
}
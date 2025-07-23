//
// Spawn Check - PCs
//
int ParseFlagValue(string sName, string sFlag, int nDigits, int nDefault);
int ParseSubFlagValue(string sName, string sFlag, int nDigits, string sSubFlag, int nSubDigits, int nDefault);
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
int SpawnCheckPCs(object oSpawn)
{ 
    // Initialize Values
    object oPC;
    object oArea = GetArea(oSpawn);
    string sSpawnName = GetLocalString(oSpawn, "f_Flags");
    location lSpawn = GetLocation(oSpawn);
    int nCheckPCs = GetLocalInt(oSpawn, "f_SpawnCheckPCs");
    float fCheckPCsRadius = GetLocalFloat(oSpawn, "f_CheckPCsRadius");

    // Block Spawn by Default
    int nProcessSpawn = FALSE;

    // Cycle through PCs
    if (fCheckPCsRadius > -1.0)
    {
        oPC = GetFirstObjectInShape(SHAPE_SPHERE, fCheckPCsRadius, lSpawn, FALSE, OBJECT_TYPE_CREATURE);
    }
    else
    {
        oPC = GetFirstObjectInArea(oArea);
    }
    while (oPC != OBJECT_INVALID)
    {
        if (GetIsPC(oPC) == TRUE)
        {

//
// Only Make Modifications Between These Lines
// -------------------------------------------


            // Check 00
            if (nCheckPCs == 0)
            {
                // Example, Allow Spawn
                nProcessSpawn = TRUE;
            }
            //

            // Spawn with a Skill Check
            if (nCheckPCs == 1)
            {
                // Get Current Number of Children
                int nSpawnCount = GetLocalInt(oSpawn, "SpawnCount");

                if (nSpawnCount == 0)
                {
                    // DC of Hidden Placeable
                    int nItemDC = 20;

                    // Player's Skill
                    int nSkill = GetSkillRank(SKILL_SEARCH, oPC);

                    // Do Skill Check
                    int nDCCheck = d20() + nSkill;
                    if (nDCCheck >= nItemDC)
                    {
                        // Placeable Spotted!
                       // string sSpotted = "You notice a thingamathingy!";
                        //FloatingTextStringOnCreature(sSpotted, oPC, TRUE);
                        //Spawn it!
                        nProcessSpawn = TRUE;
                    }
                }
            }
            //

            // Spawn Based on Journal Quest Entry
            if (nCheckPCs == 1)
            {
                // Check Journal Quest Entry
                int nQuest = GetLocalInt(oPC, "NW_JOURNAL_ENTRYQuest1");
                if (nQuest == 1)
                {
                    // Quest Entry is 1, Spawn!
                    nProcessSpawn = TRUE;
                }
            }
            //

            // Spawn Based on Item in PC Inventory
            if (nCheckPCs == 2)
            {
                // Check Player for Item
                object oItem = GetFirstItemInInventory(oPC);
                while (oItem != OBJECT_INVALID)
                {
                    if (GetTag(oItem) == "MysticKey")
                    {
                        // Item Found, Spawn!
                        nProcessSpawn = TRUE;
                    }
                    oItem = GetNextItemInInventory(oPC);
                }
            }
            //


// -------------------------------------------
// Only Make Modifications Between These Lines
//
        }
        // Retreive Next PC
        if (fCheckPCsRadius > -1.0)
        {
            oPC = GetNextObjectInShape(SHAPE_SPHERE, fCheckPCsRadius, lSpawn, FALSE, OBJECT_TYPE_CREATURE);
        }
        else
        {
            oPC = GetNextObjectInArea(oArea);
        }
    }

    // Return whether Spawn can Proceed
    return nProcessSpawn;
}
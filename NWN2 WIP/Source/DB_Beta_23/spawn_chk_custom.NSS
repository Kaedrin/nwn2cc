//
// Spawn Check - Custom
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
int SpawnCheckCustom(object oSpawn)
{
    // Initialize Values
    int nSpawnCheckCustom = GetLocalInt(oSpawn, "f_SpawnCheckCustom");

    // Block Spawn by Default
    int nProcessSpawn = FALSE;

//
// Only Make Modifications Between These Lines
// -------------------------------------------

    // Check 00
    if (nSpawnCheckCustom == 0)
    {
        // Example, Allow Spawn
        nProcessSpawn = TRUE;
    }
    //

    //
    if (nSpawnCheckCustom == 1)
    {
        if (GetIsDawn() == TRUE || GetIsDay() == TRUE)
        {
            nProcessSpawn = TRUE;
            SetLocalInt(oSpawn, "SpawnProcessed", FALSE);
        }
        else
        {
            int nSpawnProcessed = GetLocalInt(oSpawn, "SpawnProcessed");
            if (nSpawnProcessed == FALSE)
            {
                nProcessSpawn = TRUE;
                SetLocalInt(oSpawn, "SpawnProcessed", TRUE);
            }
        }
    }
    //

	if (nSpawnCheckCustom == 2)
	
    // Reproducing Predators
    if (nSpawnCheckCustom == 10)
    {
        int nChildren = GetLocalInt(oSpawn, "ChildrenSpawned");
        if (nChildren >= 10)
        {
            int nHappy = 0;
            int nPredators;
            int nNth = 1;
            object oPredator = GetNearestObject(OBJECT_TYPE_CREATURE, oSpawn, nNth);
            while (oPredator != OBJECT_INVALID)
            {
                if (GetLocalInt(oPredator, "Predator") == TRUE)
                {
                    nPredators++;
                    if (GetLocalInt(oPredator, "CurrentHungerState") > 0)
                    {
                        nHappy++;
                    }
                }
                nNth++;
                oPredator = GetNearestObject(OBJECT_TYPE_CREATURE, oSpawn, nNth);
            }
            SendMessageToAllDMs("There are " + IntToString(nPredators) + " Predators Alive.");
            if (nHappy >= 2)
            {
                nProcessSpawn = TRUE;
            }
        }
        else
        {
            nProcessSpawn = TRUE;
        }
        if (nProcessSpawn == TRUE)
        {
            SendMessageToAllDMs("A Predator is Born!");
        }
    }
    //


// -------------------------------------------
// Only Make Modifications Between These Lines
//

    // Return whether Spawn can Proceed
    return nProcessSpawn;
}
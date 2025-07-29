//
// Spawn ObjectEffect
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
effect ObjectEffect(object oSpawn)
{
    // Initialize Variables
    effect eObjectEffect;

    // Initialize Values
    int nObjectEffect = GetLocalInt(oSpawn, "f_ObjectEffect");

//
// Only Make Modifications Between These Lines
// -------------------------------------------


    // ObjectEffect 00
    // Dummy ObjectEffect - Never Use
    if (nObjectEffect == 0)
    {
        return eObjectEffect;
    }
    //

    // Bard's Song
    if (nObjectEffect == 1)
    {
        eObjectEffect = EffectVisualEffect(VFX_DUR_BARD_SONG);
    }
    //


// -------------------------------------------
// Only Make Modifications Between These Lines
//

    // Return the ObjectEffect
    return eObjectEffect;
}

/*

*/
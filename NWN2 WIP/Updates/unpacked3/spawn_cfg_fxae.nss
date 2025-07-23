//
// Spawn AreaEffect
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
effect SpawnAreaEffect(object oSpawn)
{
    // Initialize Variables
    effect eAreaEffect;

    // Initialize Values
    int nSpawnAreaEffect = GetLocalInt(oSpawn, "f_SpawnAreaEffect");

//
// Only Make Modifications Between These Lines
// -------------------------------------------

    // AreaEffect 00
    // Dummy AreaEffect - Never Use
    if (nSpawnAreaEffect == 0)
    {
        return eAreaEffect;
    }
    //

    // Web, only Visual
    if (nSpawnAreaEffect == 1)
    {
        eAreaEffect = EffectAreaOfEffect(AOE_PER_WEB, "****", "****", "****");
    }
    //


// -------------------------------------------
// Only Make Modifications Between These Lines
//

    // Return the AreaEffect
    return eAreaEffect;
}

/*
0 - AOE_PER_FOGACID
1 - AOE_PER_FOGFIRE
2 - AOE_PER_FOGSTINK
3 - AOE_PER_FOGKILL
4 - AOE_PER_FOGMIND
18 - AOE_MOB_UNEARTHLY
19 - AOE_MOB_MENACE
20 - AOE_MOB_UNNATURAL
21 - AOE_MOB_STUN
22 - AOE_MOB_PROTECTION
23 - AOE_MOB_FIRE
24 - AOE_MOB_FROST
25 - AOE_MOB_ELECTRICAL
26 - AOE_PER_FOGGHOUL
27 - AOE_MOB_TYRANT_FOG
28 - AOE_PER_STORM
29 - AOE_PER_INVIS_SPHERE
30 - AOE_MOB_SILENCE
31 - AOE_PER_DELAY_BLAST_FIREBALL
32 - AOE_PER_GREASE
33 - AOE_PER_CREEPING_DOOM
35 - AOE_MOB_INVISIBILITY_PURGE
*/
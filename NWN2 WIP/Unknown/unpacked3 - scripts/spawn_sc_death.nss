//
// Death Scripts
//
#include "spawn_functions"
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
void main()
{
    // Initialize Variables

    // Retrieve Script Number
    int nDeathScript = GetLocalInt(OBJECT_SELF, "DeathScript");

    // Invalid Script
    if (nDeathScript == -1)
    {
        return;
    }

//
// Only Make Modifications Between These Lines
// -------------------------------------------


    // Script 00
    if (nDeathScript == 0)
    {
    }
    //

    // Scared Prey
    if (nDeathScript == 10)
    {
        object oKiller = GetLastKiller();
        if (GetLocalInt(oKiller, "Predator") == TRUE)
        {
            // Feed the Predator
            int nCurrentHungerState = GetLocalInt(oKiller, "CurrentHungerState");
            int nKills = GetLocalInt(oKiller, "Kills");
            nKills++;
            int nFed = 5 + (nKills / 25);
            nCurrentHungerState = nCurrentHungerState + 1 + nFed;
            SendMessageToAllDMs("Predator is Fed (" + IntToString(nFed) + ").");
            AssignCommand(oKiller, SpeakString("That's " + IntToString(nKills) + " prey I've killed!  I get " + IntToString(nFed) + " more food!"));
            SetLocalInt(oKiller, "Kills", nKills);
            SetLocalInt(oKiller, "CurrentHungerState", nCurrentHungerState);
        }
    }
    //


// -------------------------------------------
// Only Make Modifications Between These Lines
//

    // Record that we Ran Script
    SetLocalInt(OBJECT_SELF, "DeathScriptRan", TRUE);
}
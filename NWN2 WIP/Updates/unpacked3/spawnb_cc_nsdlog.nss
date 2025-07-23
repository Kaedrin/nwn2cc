//
// Spawn Banner
// Conversation Check
// Spawn Delay Debugging off
//
int StartingConditional()
{
    object oSpawn = GetLocalObject(OBJECT_SELF, "ParentSpawn");
    object oArea = GetArea(oSpawn);
    if (GetLocalInt(oArea, "SpawnDelayDebug") == TRUE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

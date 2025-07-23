//
// Spawn Banner
// Conversation Check
//
int StartingConditional()
{
    object oSpawn = GetLocalObject(OBJECT_SELF, "ParentSpawn");
    if (GetLocalInt(oSpawn, "SpawnDeactivated") == FALSE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

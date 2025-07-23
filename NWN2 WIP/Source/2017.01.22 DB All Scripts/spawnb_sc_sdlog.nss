//
// Spawn Banner
// Turn Spawn Delay logging ON
//

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    SetLocalInt(oArea, "SpawnDelayDebug", TRUE);
    SendMessageToAllDMs("Spawn delay logging enabled");
}

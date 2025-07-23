//
// Spawn Banner
// Turn Spawn Delay logging ON
//

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    SetLocalInt(oArea, "SpawnCountDebug", FALSE);
    SendMessageToAllDMs("Spawn count logging disable");
}

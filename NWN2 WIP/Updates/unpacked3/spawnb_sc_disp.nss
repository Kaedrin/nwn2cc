//
// Spawn Banner Display Text
//
void main()
{
    object oSpawn = GetLocalObject(OBJECT_SELF, "ParentSpawn");
    object oPC = GetLastUsedBy();

    string sSpawnName = GetLocalString(oSpawn, "f_Flags");
    string sSpawnTag =  GetLocalString(oSpawn, "f_Template");

    DelayCommand(0.0, FloatingTextStringOnCreature(sSpawnName, oPC));
    DelayCommand(1.0, FloatingTextStringOnCreature(sSpawnTag, oPC));
}

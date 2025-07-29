 /*
When an object is used look for a variable on the placeable and jump
the PC using the placeable to the destination named in the variable
*/


void main( )
{
    object oPlaceable = OBJECT_SELF;
    object oPC = GetLastUsedBy();
    string sTag = GetLocalString(oPlaceable,"Destination");
    object oDestination = GetObjectByTag(sTag);

        AssignCommand(oPC,ClearAllActions());
        DelayCommand(0.1,AssignCommand(oPC,ActionJumpToObject(oDestination)));
}
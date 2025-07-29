//::///////////////////////////////////////////////////
//:: X0_O2_ANYLOW.NSS
//:: OnOpened/OnDeath script for a treasure container.
//:: Treasure type: Any, random selection from whatever is in base container
//:: Treasure level: TREASURE_TYPE_LOW
//::
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/21/2002
//::///////////////////////////////////////////////////

#include "x0_i0_treasure"
#include "x2_inc_compon"
void main()
{
     craft_drop_placeable();

    if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
    {
       return;
    }
    if (GetLocalObject(OBJECT_SELF,"Player")== GetLastOpener())
    {
        return;
    }
    int iRespawn=Random(600);
    float fRespawn=IntToFloat(iRespawn);
    //object oOpener = GetLastOpener();
    //DTSGenerateTreasureOnContainer (OBJECT_SELF,oOpener,X2_DTS_CLASS_HIGH,X2_DTS_TYPE_DISP | X2_DTS_TYPE_GOLD);
    SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);
    DelayCommand(fRespawn,DeleteLocalInt(OBJECT_SELF,"NW_DO_ONCE"));
    ShoutDisturbed();
    SetLocalObject(OBJECT_SELF,"Player",GetLastOpener());
    CTG_CreateTreasure(TREASURE_TYPE_LOW, GetLastOpener(), OBJECT_SELF);

}
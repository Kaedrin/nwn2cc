/*******************************************************************************
* clean_area_exit
*
* Called by area's OnExit event. Clears area encounters, dropped items,
* stores & cleans placeable inventories if no PC is present for a length of time.
*
*******************************************************************************/

// Set this to FALSE if you do not want placeable inventories cleared
// does not affect spawn-per-person chests
#include "mai_inc_functions"

int nClearPlaceInv = FALSE;

void CleanArea(object oArea)
{
    object oTrash = GetFirstObjectInArea(oArea);
    object oInvItem;
    float fDelayTime = IntToFloat(GetLocalInt(oArea, "mai_clean_delay"));
    if (fDelayTime < 1.0)
    {
        float fDelayTime = 60.0;
    }

    //Check for PCs
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        if (GetLocalInt(oArea, "WorldWide") > 0)
        {
            DelayCommand(fDelayTime, CleanArea(oArea));
            return;
        }
        if (GetArea(oPC) == oArea)
        {
            DeleteLocalInt(oArea, "CleanArea");
            return;
        }
        oPC = GetNextPC();
    }

    while(GetIsObjectValid(oTrash))
    {
        string sTagPrefix = GetStringLeft(GetTag(oTrash), 15);
        // Clear remains, dropped items
        // Clear encounters
        if (GetIsEncounterCreature(oTrash) || sTagPrefix == "PWFSE_SPAWNERID")
        {
            AssignCommand(oTrash, SetIsDestroyable(TRUE));
            DestroyObject(oTrash, 0.0);
        }
		else if (GetObjectType(oTrash) == OBJECT_TYPE_ENCOUNTER)
		{
			if (GetLocalInt(oTrash, "NPCACT") == 1)
			{
				SetEncounterActive(TRUE, oTrash);	
				SetEncounterSpawnsCurrent(0, oTrash);
			}
		}
        oTrash = GetNextObjectInArea(oArea);
    }
    DeleteLocalInt(oArea, "CleanArea");
}

void main()
{
    object oArea = OBJECT_SELF;
    object oPC = GetExitingObject();
    float fDelayTime = IntToFloat(GetLocalInt(oArea, "mai_clean_delay"));
    if (fDelayTime < 1.0)
    {
        float fDelayTime = 600.0;
    }
    // Don't run if the exiting object is not a PC
    // We'll cover people logging from a battle zone later
    // If it's a cleanfast area, that means it needs to be newbie safe so don't take a chance
    // if (GetLocalInt( oArea, "CleanFast") == TRUE)
    // fDelayTime = 30.0f;
    // else
    // {
    // if (!GetIsPC(oPC))
    // return;
// }

    if (GetLocalInt(oArea, "CleanArea") != 1)
    {
        DelayCommand(fDelayTime, CleanArea(oArea));
        SetLocalInt(oArea, "CleanArea", 1);
    }
}
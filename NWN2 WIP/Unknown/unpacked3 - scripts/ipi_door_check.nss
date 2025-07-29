#include "ipi_constants"
#include "ipi_defaults"
#include "ipi_datemath_inc"
#include "pf_facade"

void ActionAutoCloseAndLock(object theObject)
{
    if (GetIsOpen(OBJECT_SELF))
        { ActionCloseDoor(OBJECT_SELF); }
    ActionDoCommand (SetLocked (OBJECT_SELF, TRUE));
}

void main()
{
    string sInnTag = GetStringLeft(GetTag(OBJECT_SELF),
        GetStringLength(sPREFIX) + 2);
    object myInn = GetObjectByTag(sInnTag);
    // Complain if we can't find our inn object
    if (myInn == OBJECT_INVALID)
    {
        string msg = "ERROR: Door with tag "+ GetTag(OBJECT_SELF) +
            " can't find inn placeable with tag "+ sInnTag;
        SpeakString(msg);
        WriteTimestampedLogEntry(msg);
        return;
    }
    object thisPC = GetClickingObject();
    string thisPCKey = GetName(thisPC) + GetPCPlayerName(thisPC);
    string sRoomNumber = GetStringRight(GetTag(OBJECT_SELF),3);
    string sTenantVar = "Rm" + sRoomNumber + "Tenant";
    string ownerKey = GetPFCampaignString(sCampaignName, sTenantVar, myInn);
    // DEBUG
    //SpeakString("Your Key = "+ thisPCKey +", OwnerKey = "+ownerKey);
    // Expire this agreement if necessary
    string sExpireVar = "Rm" + sRoomNumber + "Expire";
    string expireDateStr = GetPFCampaignString(sCampaignName, sExpireVar, myInn);
    int daysLeft = 0;
    if (expireDateStr != "")
        daysLeft = DateStrCmp(NewDateString(), expireDateStr);
    if (daysLeft < 0)
    {
        string msg = "Expiring contract for "+ GetName(thisPC) +
            " on room "+ sRoomNumber;
        WriteTimestampedLogEntry(msg);
        DeletePFCampaignVariable(sCampaignName, sTenantVar, myInn);
        DeletePFCampaignVariable(sCampaignName, sExpireVar, myInn);
    }
    else if (thisPCKey == ownerKey)
    {
        int roomNum = StringToInt(sRoomNumber);
        string myName =  "Room "+ IntToString(roomNum);
        if (GetWillSavingThrow(OBJECT_SELF) == USE_ROOM_NAME)
            myName = GetName(OBJECT_SELF);
        string msg = "*" + myName +" opens for "+ GetName(thisPC) +"*";
        ActionOpenDoor(OBJECT_SELF);
        FloatingTextStringOnCreature(msg, thisPC);
        DelayCommand(DOOR_DELAY, ActionAutoCloseAndLock(OBJECT_SELF));
    }
}
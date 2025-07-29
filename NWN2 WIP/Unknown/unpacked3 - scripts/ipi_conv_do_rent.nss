#include "ipi_constants"
#include "ipi_defaults"
#include "pf_facade"

void main()
{
    string sInnPrefix = GetStringRight(GetTag(OBJECT_SELF),2);
    object myInn = GetObjectByTag(sPREFIX + sInnPrefix);
    // Save the total rate for when the ipi_checkfunds script runs
    string chosenClass = IntToString(GetLocalInt(OBJECT_SELF, CHOSENCLASS_VAR));
    int roomNum = GetLocalInt(OBJECT_SELF, CURRENTROOM_VAR);
    if (! roomNum)
        roomNum = GetLocalInt(OBJECT_SELF, FIRSTROOMINCLASS_VAR + chosenClass);
    object door = GetDoor(sInnPrefix, roomNum);
    // Set this room's description
    SetCustomToken(171, "Room "+ IntToString(roomNum));
    if (GetWillSavingThrow(door) == USE_ROOM_NAME)
        SetCustomToken(171, GetName(door));
    int cost = GetLocalInt(OBJECT_SELF, TOTALCOST_VAR);
    // Store the player's key persistently
    object oPC = GetPCSpeaker();
    string sPKey = GetName(oPC) + GetPCPlayerName(oPC);
    string sTenantVar = "Rm" + IntToStringPad3(roomNum) + "Tenant";
    SetPFCampaignString(sCampaignName, sTenantVar, sPKey, myInn);
    // Set the expire date
    string sExpire = GetLocalString(OBJECT_SELF, EXPIREDATE_VAR);
    string sExpireVar = "Rm" + IntToStringPad3(roomNum) + "Expire";
    SetPFCampaignString(sCampaignName, sExpireVar, sExpire, myInn);

    // Take the money
    TakeGoldFromCreature(cost, oPC, TRUE);
    // Debug / logging
    string logMsg = "Renting room # "+ IntToString(roomNum) +" ("+
        GetName(door) +") to "+ GetName(GetPCSpeaker()) +" for "+
        IntToString(cost) +" gold until date "+ sExpire +".";
    WriteTimestampedLogEntry(logMsg);
}

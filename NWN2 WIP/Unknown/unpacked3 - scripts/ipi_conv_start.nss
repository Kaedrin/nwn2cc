// This is the innkeeper conversation initialization script
// In this file, OBJECT_SELF refers to the innkeeper NPC
#include "ipi_constants"
#include "ipi_defaults"
#include "ipi_datemath_inc"
#include "pf_facade"

int GetRentalCost(object oInn, int iBaseRate, int iNumDays)
{
    int rateFactor = 1;     // Assume rates are daily
    int ratePeriod = GetWillSavingThrow(oInn);
    if (ratePeriod == DAILY_RATE) rateFactor = 1;
    else if (ratePeriod == WEEKLY_RATE) rateFactor = DAYS_PER_WEEK;
    else if (ratePeriod == MONTHLY_RATE) rateFactor = DAYS_PER_MONTH;
    else if (ratePeriod == YEARLY_RATE)
        rateFactor = MONTHS_PER_YEAR * DAYS_PER_MONTH;
    int total =  (iBaseRate * iNumDays) / rateFactor;
    return total;
}

int StartingConditional()
{
    // Get my Inn object
    string sInnPrefix = GetStringRight(GetTag(OBJECT_SELF),2);
    object myInn = GetObjectByTag(sPREFIX + sInnPrefix);
    // Complain if we can't find our inn object
    if (myInn == OBJECT_INVALID)
    {
        string msg = "ERROR: Inkeeper "+ GetName(OBJECT_SELF) +
            " can't find inn placeable with tag "+ sPREFIX + sInnPrefix;
        SpeakString(msg);
        WriteTimestampedLogEntry(msg);
        return 0;
    }
    // Initialize my Inn if necessary
    if (! GetLocalInt(myInn, INITIALIZED_VAR))
        ExecuteScript("ipi_init_inn", myInn);

    //************* ITERATE THROUGH THE ROOM CLASSES *****************//
    // Setup custom conversation tokens
    // token <CUSTOM130> is set to the name of the Inn
    SetCustomToken(130, GetName(myInn));
    int numClasses = GetLocalInt(myInn, NUMCLASSES_VAR);
    int i;
    for (i=1; i<=numClasses; i++)
    {
        // tokens 131 throug 139 are set to the number of rooms
        // in classes 1 through 9, respectively
        string sVarName = ROOMSINCLASS_VAR + IntToString(i);
        string sNumRooms = IntToString(GetLocalInt(myInn,sVarName));
        SetCustomToken(130 + i, sNumRooms);
        // tokens 151 through 159 are set to the rental rate of rooms
        // in classes 1 through 9, respectively
        sVarName = CLASSRATE_VAR + IntToString(i);
        string sClassRate = IntToString(GetLocalInt(myInn, sVarName));
        SetCustomToken(150 + i, sClassRate);
        // Clear the "FirstRoomAvaliableInClass" variables
        SetLocalInt(OBJECT_SELF, FIRSTROOMINCLASS_VAR + IntToString(i), 0);
    }

    //************ ITERATE THROUGH THE ROOMS THEMSELVES ****************//
    // Calculate a TON of local state variables to use later in the conversation
    SetLocalInt(OBJECT_SELF, ISBOOKED_VAR, TRUE);
    SetLocalInt(OBJECT_SELF, HASROOM_VAR, FALSE);
    DeleteLocalInt(OBJECT_SELF, CURRENTROOM_VAR);
    DeleteLocalInt(OBJECT_SELF, CURRENTCLASS_VAR);
    DeleteLocalInt(OBJECT_SELF, REFUNDAMOUNT_VAR);
    DeleteLocalInt(OBJECT_SELF, DAYSLEFT_VAR);
    SetCustomToken(173, "");// " more" or "", depending on PCs rental status
    int totalRooms = GetLocalInt(myInn, TOTALROOMS_VAR);
    for (i=1; i<= totalRooms; i++)
    {
        string sTenantVar = "Rm" + IntToStringPad3(i) + "Tenant";
        string sTenantKey = GetPFCampaignString(sCampaignName, sTenantVar, myInn);
        object thisDoor = GetDoor(sInnPrefix,i);
        string classNameVar = CLASSFORRATE_VAR +
                IntToString(GetReflexSavingThrow(thisDoor));
        int thisClass = GetLocalInt(myInn, classNameVar);
        if (sTenantKey == "")
        {   // There's nobody in this room
            SetLocalInt(OBJECT_SELF, ISBOOKED_VAR, FALSE);
            int firstRoom = GetLocalInt(OBJECT_SELF,
                FIRSTROOMINCLASS_VAR + IntToString(thisClass));
            if (firstRoom < 1)
            {
                SetLocalInt(OBJECT_SELF,
                    FIRSTROOMINCLASS_VAR + IntToString(thisClass), i);
                SetCustomToken(160 + thisClass, IntToString(i));
                SetCustomToken(140 + thisClass, GetName(thisDoor));
            }
        }
        else
        {   // There's someone in this room
            // Expire this agreement if necessary
            string sExpireVar = "Rm" + IntToStringPad3(i) + "Expire";
            string expireDateStr = GetPFCampaignString(sCampaignName, sExpireVar, myInn);
            string todayDateStr = NewDateString();
            int daysLeft = DateStrCmp(todayDateStr, expireDateStr);
            if (daysLeft < 0)
            {
                string msg = "Expiring contract for "+ GetName(GetPCSpeaker()) +
                    " on room "+ IntToStringPad3(i);
                //SpeakString(msg);
                WriteTimestampedLogEntry(msg);
                DeletePFCampaignVariable(sCampaignName, sTenantVar, myInn);
                DeletePFCampaignVariable(sCampaignName, sExpireVar, myInn);
            }
            else
            {
                string pcKey = GetName(GetPCSpeaker()) + GetPCPlayerName(GetPCSpeaker());
                if (sTenantKey == pcKey)
                {   // The PC speaker has a room in this case
                    //SpeakString("Discovered Pre-existing agreement for room " + IntToString(i));
                    SetLocalInt(OBJECT_SELF, HASROOM_VAR, TRUE);
                    SetLocalInt(OBJECT_SELF, CURRENTROOM_VAR, i);
                    SetLocalInt(OBJECT_SELF, CURRENTCLASS_VAR, thisClass);
                    SetLocalInt(OBJECT_SELF, DAYSLEFT_VAR, daysLeft);
                    // Calculate a refund in case the PC decides to cancel
                    if (daysLeft > 1)
                    {
                        int baseRate = GetLocalInt(myInn, CLASSRATE_VAR + IntToString(thisClass));
                        int refund = GetRentalCost(myInn, baseRate, daysLeft);
                        SetLocalInt(OBJECT_SELF, REFUNDAMOUNT_VAR, refund);
                        SetCustomToken(174, IntToString(refund));
                    }
                    // Set this room's description
                    SetCustomToken(171, "Room "+ IntToString(i));
                    if (GetWillSavingThrow(thisDoor) == USE_ROOM_NAME)
                        SetCustomToken(171, GetName(thisDoor));
                    SetCustomToken(172, IntToString(daysLeft));
                    SetCustomToken(173, " more");
                }
            }
        }
    }

    string baseRentalTerm = "day";
    int ratePeriod = GetWillSavingThrow(myInn);
    if (ratePeriod == DAILY_RATE) baseRentalTerm = "day";
    else if (ratePeriod == WEEKLY_RATE) baseRentalTerm = "week";
    else if (ratePeriod == MONTHLY_RATE) baseRentalTerm = "month";
    else if (ratePeriod == YEARLY_RATE) baseRentalTerm = "year";
    SetCustomToken(190, baseRentalTerm);

    return 1;
}
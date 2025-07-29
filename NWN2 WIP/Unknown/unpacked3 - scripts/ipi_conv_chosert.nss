#include "ipi_constants"
#include "ipi_datemath_inc"

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

void ChooseTerm (int nDays)
{
    // Get my Inn object
    string sInnPrefix = GetStringRight(GetTag(OBJECT_SELF),2);
    object myInn = GetObjectByTag(sPREFIX + sInnPrefix);
    // Compute and save the total rate for when the ipi_checkfunds script runs
    string chosenClass = IntToString(GetLocalInt(OBJECT_SELF, CHOSENCLASS_VAR));
    int baseRate = GetLocalInt(myInn, CLASSRATE_VAR + chosenClass);
    SetLocalInt(OBJECT_SELF, TOTALCOST_VAR, GetRentalCost(myInn, baseRate, nDays));
    // Calculate and set the expiration date
    // If the PCSpeaker alrady has a contract, add in the remaining days
    int iTotalDays = nDays;
    if (GetLocalInt(OBJECT_SELF, DAYSLEFT_VAR))
        iTotalDays += GetLocalInt(OBJECT_SELF, DAYSLEFT_VAR);
    // Set this room's description
    int roomNum = GetLocalInt(OBJECT_SELF, CURRENTROOM_VAR);
    if (roomNum < 1)
        roomNum = GetLocalInt(OBJECT_SELF, FIRSTROOMINCLASS_VAR + chosenClass);
    object door = GetDoor(sInnPrefix, roomNum);
    SetCustomToken(171, "Room "+ IntToString(roomNum));
    if (GetWillSavingThrow(door) == USE_ROOM_NAME)
        SetCustomToken(171, GetName(door));
    SetCustomToken(172, IntToString(iTotalDays));
    string todayString = NewDateString();
    string expireDate = AddDays(todayString, iTotalDays);
    SetLocalString(OBJECT_SELF, EXPIREDATE_VAR, expireDate);
}


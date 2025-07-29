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
        rateFactor = DAYS_PER_MONTH * MONTHS_PER_YEAR;
    return (iBaseRate * iNumDays) / rateFactor;
}

// Rents the first available room in the class with number equal
// to OBJECT_SELF's LocalString CHOSENCLASS_VAR to the PCSpeaker()
// at cost determined by OBJECT_SELF's LocalString TOTALCOST_VAR
void RentChosenRoom(int nDays)
{
    // Get my Inn object
    string sInnPrefix = GetStringRight(GetTag(OBJECT_SELF),2);
    object myInn = GetObjectByTag(sPREFIX + sInnPrefix);
    object oPC = GetPCSpeaker();
    string sPCKey = GetName(oPC) + GetPCPlayerName(oPC);
    int iRoomNum = GetLocalInt(OBJECT_SELF, FIRSTROOMINCLASS_VAR +
        IntToString(iClassNum));
    string sTenantVar = "Rm" + IntToStringPad3(iRoomNum) + "Tenant";
    SetPFCampaignString(sCampaignName, sTenantVar, sPCKey, myInn);

    // Deduct the rent
    string doorTag = sPREFIX + sInnPrefix + "_RM" + IntToStringPad3(iRoomNum);
    object thisDoor = GetObjectByTag(doorTag);
    int totalCost = GetRentalCost(myInn, GetReflexSavingThrow(thisDoor), nDays);
    TakeGoldFromCreature(totalCost, oPC, TRUE);
    SetCustomToken(190, GetName(thisDoor));

    // Set the contract expiration
}


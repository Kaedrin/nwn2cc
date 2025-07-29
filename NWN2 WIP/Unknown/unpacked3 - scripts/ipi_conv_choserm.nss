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

void ChooseClass (int iClassNum)
{
    // Get my Inn object
    string sInnPrefix = GetStringRight(GetTag(OBJECT_SELF),2);
    object myInn = GetObjectByTag(sPREFIX + sInnPrefix);
    // Save the chosen class for when the ipi_conv_cosert script runs
    SetLocalInt(OBJECT_SELF, CHOSENCLASS_VAR, iClassNum);

    // Now set tokens for the daily, weekly, monthly, and yearly rates
    int baseCost = GetLocalInt(myInn, CLASSRATE_VAR + IntToString(iClassNum));
    SetCustomToken(181, IntToString(GetRentalCost(myInn, baseCost, 1)));
    SetCustomToken(182, IntToString(GetRentalCost(myInn, baseCost, DAYS_PER_WEEK)));
    SetCustomToken(183, IntToString(GetRentalCost(myInn, baseCost, DAYS_PER_MONTH)));
    SetCustomToken(184, IntToString(GetRentalCost(myInn, baseCost,
                                    MONTHS_PER_YEAR * DAYS_PER_MONTH)));
}


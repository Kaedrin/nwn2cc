#include "ipi_constants"

int StartingConditional()
{
    string sInnPrefix = GetStringRight(GetTag(OBJECT_SELF),2);
    object myInn = GetObjectByTag(sPREFIX + sInnPrefix);
    int ratePeriod = GetWillSavingThrow(myInn);
    return ratePeriod <= MONTHLY_RATE;
}

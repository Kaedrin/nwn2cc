//
//
//   ALFA NESS
//   Time functions v1.1
//
//   Do NOT Modify this File
//   See 'spawn__readme' for Instructions
//
//
//::///////////////////////////////////////////////
//:: Time Conversion Functions
//:: spawn_timefuncs
//:://////////////////////////////////////////////
/*
    These functions allow Calendar y/m/d/h/m/s to
    be converted to seconds of real time which can be used as
    a basis for time comparisons.  Time is reckoned
    in seconds from the NWN Epoch - 1340 DR.

    Note that HoursToRealSeconds() is equivalent to the Bioware function
    HoursToSeconds(); it is included for completeness.
*/
//:://////////////////////////////////////////////
//:: Created By: Cereborn
//:: Created On: November 22, 2002
//:://////////////////////////////////////////////

int CLOCK_DEBUG = FALSE;

int SPAWN_EPOCH = 1340;

void clockDebug(string str)
{
    if (CLOCK_DEBUG)
    {
        SendMessageToAllDMs(str);
        object oPC = GetFirstPC();
        if (! GetIsDM(oPC))
           SendMessageToPC(oPC, str);
        WriteTimestampedLogEntry(str);
    }
}

// Get the current time (elapsed since the Epoch) in real seconds
int GetCurrentRealSeconds();

// Convert a calendar (game) time to real seconds
int CalendarToRealSeconds(int year, int month, int day, int hour, int minute,
    int second);

// Returns number of real seconds in the # of specified (game) years
int YearsToRealSeconds(int years);

// Returns number of real seconds in the # of specified (game) months
int MonthsToRealSeconds(int months);

// Returns number of real seconds in the # of specified (game) days
int DaysToRealSeconds(int days);

// Returns number of real seconds in the # of specified (game) hours
int HoursToRealSeconds(int hours);

int YearsToRealSeconds(int years)
{
    return MonthsToRealSeconds(years*12);
}

int MonthsToRealSeconds(int months)
{
    return DaysToRealSeconds(months*28);
}

int DaysToRealSeconds(int days)
{
    return FloatToInt(HoursToSeconds(days*24));
}

int HoursToRealSeconds(int hours)
{
    return FloatToInt(HoursToSeconds(hours));
}

int CalendarToRealSeconds(int year, int month, int day, int hour, int minute,
   int second)
{
    if (year < SPAWN_EPOCH)
       year = SPAWN_EPOCH;
    if (month < 1)
       month = 1;
    if (day < 1)
       day = 1;

    return (YearsToRealSeconds(year-SPAWN_EPOCH) +
           MonthsToRealSeconds(month-1) +
           DaysToRealSeconds(day-1) +
           FloatToInt(HoursToSeconds(hour)) +
           (minute*60) +
           second);
}


int GetCurrentRealSeconds()
{
    //clockDebug("Converting " + IntToString(GetCalendarYear()) + " " +
    //    IntToString(GetCalendarMonth()) + " " +
    //    IntToString(GetCalendarDay()) + " " +
    //    IntToString(GetTimeHour()) + " " +
    //    IntToString(GetTimeMinute()) + " " +
    //    IntToString(GetTimeSecond()));

    return CalendarToRealSeconds(GetCalendarYear(), GetCalendarMonth(),
        GetCalendarDay(), GetTimeHour(), GetTimeMinute(), GetTimeSecond());
}

string RealSecondsToString(int nRealSeconds)
{
    int nMod;
    int nRem;
    string sDateTime = "";

    nMod = nRealSeconds / YearsToRealSeconds(1);
    nRem = nRealSeconds % YearsToRealSeconds(1);

    sDateTime = IntToString(nMod + SPAWN_EPOCH);

    nMod = nRem / MonthsToRealSeconds(1);
    nRem = nRem % MonthsToRealSeconds(1);

    sDateTime += " " + IntToString(nMod+1);

    nMod = nRem / DaysToRealSeconds(1);
    nRem = nRem % DaysToRealSeconds(1);

    sDateTime += " " + IntToString(nMod+1);

    nMod = nRem / FloatToInt(HoursToSeconds(1));
    nRem = nRem % FloatToInt(HoursToSeconds(1));

    sDateTime += " " + IntToString(nMod) + ":";

    nMod = nRem / 60;
    nRem = nRem % 60;

    if (nMod < 10)
        sDateTime += "0" + IntToString(nMod) + ":";
    else
        sDateTime += IntToString(nMod) + ":";

    if (nRem < 10)
        sDateTime += "0" + IntToString(nRem);
    else
        sDateTime += IntToString(nRem);

    return sDateTime;
}

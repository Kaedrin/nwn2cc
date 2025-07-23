// Functions to deal with DateStrings, which are 9-digit strings
// representing a particular calendar day, of the format
//      YYYYYMMDD       (all digits)
// This range covers from the first day of year zero to
// the last day of year 99999, so all functions herein are
// valid for datesin this range
int DAYS_PER_MONTH = 28;
int MONTHS_PER_YEAR = 12;
int DAYS_PER_WEEK = 7;

string IntToStringPad5(int iNum)
{
    if (iNum < 10) return "0000"+ IntToString(iNum);
    else if (iNum < 100) return "000"+ IntToString(iNum);
    else if (iNum < 1000) return "00"+ IntToString(iNum);
    else if (iNum < 10000) return "0"+ IntToString(iNum);
    else return IntToString(iNum);
}

string IntToStringPad2(int iNum)
{
    if (iNum < 10) return "0"+ IntToString(iNum);
    else return IntToString(iNum);
}

// This function can be used to generate a DateString for any
// given year/month/day combination.HOWEVER: any zero-value arguments
// are replaced with values from the current date, so this won't
// generate DateStrings for year zero, but you can leave off the
// arguments to get a current DateString
string NewDateString(int year = 0, int month = 0, int day = 0)
{
    if (year == 0) year = GetCalendarYear();
    if (month == 0) month = GetCalendarMonth();
    if (day == 0) day = GetCalendarDay();
    return IntToStringPad5(year) +
        IntToStringPad2(month) +
        IntToStringPad2(day);
}

string DateStringFromHours(int iNumDays)
{
    int iYear = iNumDays / (DAYS_PER_MONTH * MONTHS_PER_YEAR);
    iNumDays = iNumDays - (iYear * DAYS_PER_MONTH * MONTHS_PER_YEAR);
    int iMonth = iNumDays / DAYS_PER_MONTH;
    iNumDays = iNumDays - (iMonth *  DAYS_PER_MONTH);
    if (iNumDays == 0)
    {   // Days start counting with one, so correct this
        iNumDays = DAYS_PER_MONTH;
        iMonth--;
    }
    if (iMonth == 0)
    {   // Months start counting with one, so correct this
        iMonth = MONTHS_PER_YEAR;
        iYear--;    // Years start with zero, so no need to correct
    }
    return NewDateString(iYear, iMonth, iNumDays);
}

int GetDateStrYear(string sDateStr)
{
    return StringToInt(GetStringLeft(sDateStr, 5));
}

int GetDateStrMonth(string sDateStr)
{
    return StringToInt(GetStringLeft(GetStringRight(sDateStr, 4), 2));
}

int GetDateStrDay(string sDateStr)
{
    return StringToInt(GetStringRight(sDateStr, 2));
}

// returns the absolute number of days since day 1 of year zero
// Jan 1, 1300 = 436800
// March 2, 1300 = 436857
// Jun 1, 1372 = 436800
int GetDayCount (string sDateStr)
{
    int total = GetDateStrYear(sDateStr) * DAYS_PER_MONTH * MONTHS_PER_YEAR;
    total += GetDateStrMonth(sDateStr) * DAYS_PER_MONTH;
    total += GetDateStrDay(sDateStr);
    return total;
}

// Returns a new DateStr representing a dat iDays later than sDateStr,
// if iDays is positive, otherwise iDays earlier
string AddDays(string sDateStr, int iDays)
{
    int iStartDays = GetDayCount(sDateStr);
    return DateStringFromHours(iStartDays + iDays);
}

// Returns the number of days bewteen dateStr1 and dateStr2
// This is positive if dateStr1 is before dateStr2, negative if the reverse
int DateStrCmp(string dateStr1, string dateStr2)
{
    return GetDayCount(dateStr2) - GetDayCount(dateStr1);
}
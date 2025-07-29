//void main() {}
/*
Filename:           wtg_date_time_inc
Author:             WizardStorm Think Group (ThinkGroup@WizardStorm.com)
Date Created:       Oct 14th, 2006.
Summary:
Provides a full set of Date and Time functions.

Revision Info should only be included for post-release revisions.
-----------------
Revision Date:
Revision Author: 
Revision Summary:

*/

//generates YYYY-MM-DD string of current date
string GetCurrentDate();

//generates HH:MM:SS string of current time
string GetCurrentTime();

//generates YYYY-MM-DD HH:MM:SS string of current date and time
string GetCurrentDateTime();

//generates a string YYYY-MM-DD out of given dates
string GetDateString(int nYear, int nMonth, int nDay);

//generates a string HH:MM:SS out of given times
string GetTimeString(int nHour, int nMinute, int nSecond);

//generates a string YYYY-MM-DD HH:MM:SS out of given dates and times
string GetDateTimeString(int nYear, int nMonth, int nDay, int nHour, int nMinute, int nSecond);

//returns a year, month or day portion of a date as an integer
//usage: nDay = ParseDateString("1977-09-07", "day");
int ParseDateString(string sDateString, string sOption);

//returns a hour, minute or second portion of a time as an integer
//usage: nHour = ParseTimeString("17:03:21", "hour");
int ParseTimeString(string sTimeString, string sOption);

//returns a year, month, day, hour, minute or second portion of a DateTime as an integer
//usage: nHour = ParseDateTimeString("1977-09-07 17:03:21", "hour");
int ParseDateTimeString(string sDateTimeString, string sOption);

//usage: iNumOfDaysElapsed = GetDateDifference("1352-1-14", "1977-7-9", "days");
//uses NWN calendar settings for # of days in month (28)
//values for sOption are: years, months, days
//note: sDate1 MUST BE <= SDate2
//i.e. GetDateDifference("1356-01-14", "1355-01-14", "months") will return -1
int GetDateDifference(string sDate1, string sDate2, string sOption);

//usage: iNumOfMinutesElapsed = GetTimeDifference("06:14:22", "14:49:31", "minutes");
//uses NWN calendar settings for # of hours in day (0-23)
//values for sOption are: hours, minutes, seconds
//note: sTime1 MUST BE <= STime2
//i.e. GetTimeDifference("16:14:22", "14:49:31", "minutes") will return -1
int GetTimeDifference(string sTime1, string sTime2, string sOption);

//usage: sDueDate = GetFutureDate(GetCurrentDate(), 7, 1, 0);
//this will return a string 7 days and 1 month in the future
string GetFutureDate(string sStartDate, int nIncYear = 0, int nIncMonth = 0, int nIncDay = 0);

//usage: sBDay = GetPastDate(GetCurrentDate(), 0, 0, 50);
//this will return a string 50 years in the past
string GetPastDate(string sStartDate, int nIncYear = 0, int nIncMonth = 0, int nIncDay = 0);

//purpose: test if sDate1 == sDate2
int CompareDates(string sDate1, string sDate2);

//Converts sDateTime to Seconds
int DateTimeToSeconds(string sDateTime);


///////////////////////////////////////////////////////////////////////////////////////
//generates YYYY-MM-DD string of current date
///////////////////////////////////////////////////////////////////////////////////////
string GetCurrentDate()
{
    string sResult, sYear, sMonth, sDay;
    int nYear   = GetCalendarYear();
    int nMonth  = GetCalendarMonth();
    int nDay    = GetCalendarDay();

    if(GetStringLength(IntToString(nYear)) == 1)
        sYear = "000" + IntToString(nYear);
    else if(GetStringLength(IntToString(nYear)) == 2)
        sYear = "00" + IntToString(nYear);
    else if(GetStringLength(IntToString(nYear)) == 3)
        sYear = "0" + IntToString(nYear);
    else
        sYear = IntToString(nYear);

    if(GetStringLength(IntToString(nMonth)) == 1)
        sMonth = "0" + IntToString(nMonth);
    else
        sMonth = IntToString(nMonth);

    if(GetStringLength(IntToString(nDay)) == 1)
        sDay = "0" + IntToString(nDay);
    else
        sDay = IntToString(nDay);

    sResult = sYear + "-" + sMonth + "-" + sDay;
    return sResult;
}


///////////////////////////////////////////////////////////////////////////////////////
//generates HH:MM:SS string of current time
///////////////////////////////////////////////////////////////////////////////////////
string GetCurrentTime()
{

    string sResult, sHour, sMinute, sSecond;
    int nHour   = GetTimeHour();
    int nMinute = GetTimeMinute();
    int nSecond = GetTimeSecond();

    if(GetStringLength(IntToString(nHour)) == 1)
        sHour = "0" + IntToString(nHour);
    else
        sHour = IntToString(nHour);

    if(GetStringLength(IntToString(nMinute)) == 1)
        sMinute = "0" + IntToString(nMinute);
    else
        sMinute = IntToString(nMinute);

    if(GetStringLength(IntToString(nSecond)) == 1)
        sSecond = "0" + IntToString(nSecond);
    else
        sSecond = IntToString(nSecond);

    sResult = sHour + ":" + sMinute + ":" + sSecond;
    return sResult;
}


///////////////////////////////////////////////////////////////////////////////////////
//generates YYYY-MM-DD HH:MM:SS string of current date and time
///////////////////////////////////////////////////////////////////////////////////////
string GetCurrentDateTime()
{

    string sResult, sDate, sTime;

    sDate    = GetCurrentDate();
    sTime    = GetCurrentTime();

    sResult = sDate + " " + sTime;
    return sResult;
}

///////////////////////////////////////////////////////////////////////////////////////
//generates a string YYYY-MM-DD out of given dates
///////////////////////////////////////////////////////////////////////////////////////

string GetDateString(int nYear = 1, int nMonth = 1, int nDay = 1)
{
    string sResult;
	string sYear	= IntToString(nYear);
	string sMonth 	= IntToString(nMonth);
	string sDay		= IntToString(nDay);
	
    if (nMonth < 10)
        sMonth = "0" + IntToString(nMonth);
	
    if (nDay < 10)
        sDay = "0" + IntToString(nDay);

    sResult = sYear + "-" + sMonth + "-" + sDay;
    return sResult;
}

///////////////////////////////////////////////////////////////////////////////////////
//generates a string HH:MM:SS out of given times
///////////////////////////////////////////////////////////////////////////////////////

string GetTimeString(int nHour = 0, int nMinute = 0, int nSecond = 0)
{
    string sResult;
	string sHour	= IntToString(nHour);
	string sMinute	= IntToString(nMinute);
	string sSecond	= IntToString(nSecond);
	
    if (nHour < 10)
        sHour = "0" + IntToString(nHour);
	
    if (nMinute < 10)
        sMinute = "0" + IntToString(nMinute);
	
    if (nSecond < 10)
        sSecond = "0" + IntToString(nSecond);

    sResult = sHour + ":" + sMinute + ":" + sSecond;
    return sResult;
}

///////////////////////////////////////////////////////////////////////////////////////
//generates a string YYYY-MM-DD HH:MM:SS out of given dates and times
///////////////////////////////////////////////////////////////////////////////////////

string GetDateTimeString(int nYear = 1, int nMonth = 1, int nDay = 1, int nHour = 0, int nMinute = 0, int nSecond = 0)
{
    string sResult;
	string sDate	= GetDateString(nYear, nMonth, nDay);
	string sTime	= GetTimeString(nHour, nMinute, nSecond);

    sResult = sDate + " " + sTime;
    return sResult;
}


///////////////////////////////////////////////////////////////////////////////////////
//returns a hour, minute or second portion of a time as an integer
//usage: nHour = ParseTimeString("17:03:21", "hour");
///////////////////////////////////////////////////////////////////////////////////////

int ParseDateString(string sDateString, string sOption) //option = day || month || year
{
    string sTemp1;
    int nResult, nSlash1, nSlash2, nIndex, nStrLength;

    nSlash1 = 0;
    nSlash2 = 0;
    nStrLength = GetStringLength(sDateString);
    for(nIndex = 0; nIndex <= (nStrLength - 1); nIndex++)//get position of slashes
    {
        sTemp1 = GetSubString(sDateString, nIndex, 1);
        if(sTemp1 == "-")
        {
            if(nSlash1 == 0)
            {
                nSlash1 = nIndex;
            }
            else if (nSlash2 == 0)
            {
                nSlash2 = nIndex;
            }
        }
    }
    if(sOption == "year")
    {
        sTemp1 = GetStringLeft(sDateString, nSlash1);
        nResult = StringToInt(sTemp1);
    }
    else if(sOption == "month")
    {
        sTemp1 = GetSubString(sDateString, nSlash1 + 1, (nSlash2 - nSlash1) -1);
        nResult = StringToInt(sTemp1);
    }
    else if(sOption == "day")
    {
        sTemp1 = GetSubString(sDateString, nSlash2 + 1, (nStrLength - 1) - nSlash2);
        nResult = StringToInt(sTemp1);
    }
    else
        return -1;//invalid option

    return nResult;
}


///////////////////////////////////////////////////////////////////////////////////////
//returns a hour, minute or second portion of a time as an integer
//usage: nHour = ParseTimeString("17:03:21", "hour");
///////////////////////////////////////////////////////////////////////////////////////

int ParseTimeString(string sTimeString, string sOption) //option = hour || minute || second
{
    string sTemp1;
    int nResult, nColon1, nColon2, nIndex, nStrLength;

    nColon1 = 0;
    nColon2 = 0;
    nStrLength = GetStringLength(sTimeString);
    for(nIndex = 0; nIndex <= (nStrLength - 1); nIndex++)//get position of colons
    {
        sTemp1 = GetSubString(sTimeString, nIndex, 1);
        if(sTemp1 == ":")
        {
            if(nColon1 == 0)
            {
                nColon1 = nIndex;
            }
            else if (nColon2 == 0)
            {
                nColon2 = nIndex;
            }
        }
    }
    if(sOption == "hour")
    {
        sTemp1 = GetStringLeft(sTimeString, nColon1);
        nResult = StringToInt(sTemp1);
    }
    else if(sOption == "minute")
    {
        sTemp1 = GetSubString(sTimeString, nColon1 + 1, (nColon2 - nColon1) -1);
        nResult = StringToInt(sTemp1);
    }
    else if(sOption == "second")
    {
        sTemp1 = GetSubString(sTimeString, nColon2 + 1, (nStrLength - 1) - nColon2);
        nResult = StringToInt(sTemp1);
    }
    else
        nResult -1;//invalid option

    return nResult;
}

///////////////////////////////////////////////////////////////////////////////////////
//generates a string YYYY-MM-DD HH:MM:SS out of given dates and times
///////////////////////////////////////////////////////////////////////////////////////

int ParseDateTimeString(string sDateTimeString, string sOption) //option = year || month || day || hour || minute || second
{
    int nResult;
    string sDateTimePart;

    if(sOption == "year" ||  sOption == "month" || sOption == "day") {
        sDateTimePart = GetStringLeft(sDateTimeString, 10);
        nResult = ParseDateString(sDateTimePart, sOption);
    }
    else if(sOption == "hour" ||  sOption == "minute" || sOption == "second") {
        sDateTimePart = GetStringRight(sDateTimeString, 8);
        nResult = ParseTimeString(sDateTimePart, sOption);
    }
    else
        nResult = -1; // invalid option

    return nResult;
}


///////////////////////////////////////////////////////////////////////////////////////
//usage: iNumOfDaysElapsed = GetDateDifference("1352-1-14", "1977-7-9", "days");
//uses NWN calendar settings for # of days in month (28)
//values for sOption are: years, months, days
//note: sDate1 MUST BE <= SDate2
//i.e. GetDateDifference("1356-01-14", "1355-01-14", "months") will return -1
///////////////////////////////////////////////////////////////////////////////////////

int GetDateDifference(string sDate1, string sDate2, string sOption)//option = "years", "months", "days"
{
    int nTempDay1, nTempMonth1, nTempYear1;
    int nTempDay2, nTempMonth2, nTempYear2;
    int nResult;
    int nYears, nDays, nMonths;

    nTempDay1   = ParseDateString(sDate1, "day");
    nTempMonth1 = ParseDateString(sDate1, "month");
    nTempYear1  = ParseDateString(sDate1, "year");
    nTempDay2   = ParseDateString(sDate2, "day");
    nTempMonth2 = ParseDateString(sDate2, "month");
    nTempYear2  = ParseDateString(sDate2, "year");

    if(nTempYear2 == nTempYear1)//same year
    {
        nYears = 0;
        if(nTempMonth2 == nTempMonth1)//same year and same month
        {
            nMonths = 0;
            nDays = nTempDay2 - nTempDay1;
        }
        else //same year and different month
        {
            if(nTempDay2 == nTempDay1)//same year, different month, same day
            {
                nMonths = nTempMonth2 - nTempMonth1;
                nDays = nMonths * 28;
            }
            else //same year, diff month, diff day
            {
                if(nTempDay2 >= nTempDay1)//different month at least one month
                {
                    nMonths = nTempMonth2 - nTempMonth1;
                    nDays = (nTempDay2 - nTempDay1) + (nMonths * 28);
                }
                else //different month, at least one month, ending in incomplete month
                {
                    nMonths = (nTempMonth2 - nTempMonth1) - 1;
                    nDays = (28 * nMonths) + (28 - (nTempDay1 - 1)) + (28 - ((28 - nTempDay2) + 1));
                }
            }
        }
    }

    if(nTempYear2 > nTempYear1)//not same year
    {
        if(nTempMonth2 == nTempMonth1)//diff year, same month
        {
            if(nTempDay2 == nTempDay1)//diff year, same month, same day
            {
                nYears = nTempYear2 - nTempYear1;
                nMonths = 12 * nYears;
                nDays = 28 * nMonths;
            }
            else //diff year, same month, diff day
            {
                if(nTempDay2 > nTempDay1)//diff year, same month, at least one year
                {
                    nYears = nTempYear2 - nTempYear1;
                    nMonths = 12 * nYears;
                    nDays = (28 * nMonths) + (nTempDay2 - nTempDay1);
                }
                else //diff year, same month, one less year
                {
                    nYears = (nTempYear2 - nTempYear1) -1;
                    nMonths = (12 * nYears) + 11;
                    nDays = (28 * nMonths) + (28 + (nTempDay2 - nTempDay1));
                }
            }
        }
        else //diff year, diff month
        {
            if(nTempMonth2 > nTempMonth1)//diff year, diff month, at least one year, extra months
            {
                if(nTempDay2 == nTempDay1)//diff year, diff month, same day
                {
                    nYears = nTempYear2 - nTempYear1;
                    nMonths = (12 * nYears) + (nTempMonth2 - nTempMonth1);
                    nDays = 28 * nMonths;
                }
                else //diff year, diff month, diff day
                {
                    if(nTempDay2 > nTempDay1)//diff year, diff month, extra days
                    {
                        nYears = nTempYear2 - nTempYear1;
                        nMonths = (12 * nYears) + (nTempMonth2 - nTempMonth1);
                        nDays = (28 * nMonths) + (nTempDay2 - nTempDay1);
                    }
                    else //diff year, diff month, fewer days
                    {
                        nYears = nTempYear2 - nTempYear1;
                        nMonths = (12 * nYears) + (nTempMonth2 - nTempMonth1);
                        nDays =(28 * nMonths) + (28 + (nTempDay2 - nTempDay1));
                    }
                }
            }
            else //diff year, diff month, one year less (fewer months)
            {
                if(nTempDay2 == nTempDay1)//diff year, less months, same day
                {
                    nYears = (nTempYear2 - nTempYear1) -1;
                    nMonths = (12 * nYears) - (nTempMonth2 - nTempMonth1);
                    nDays = 28 * nMonths;
                }
                else //diff year, fewer months, diff day
                {
                    if(nTempDay2 > nTempDay1)//diff year, fewer months, extra days
                    {
                        nYears = (nTempYear2 - nTempYear1) -1;
                        nMonths = (12 * nYears) - (nTempMonth2 - nTempMonth1);
                        nDays = (28 * nMonths) + (nTempDay2 - nTempDay1);
                    }
                    else //diff year, fewer months, less days
                    {
                        nYears = (nTempYear2 - nTempYear1) -1;
                        nMonths = (12 * nYears) - (nTempMonth2 - nTempMonth1);
                        nDays =(28 * nMonths) + (28 + (nTempDay2 - nTempDay1));
                    }
                }
            }
        }
    }

    // does not handle negetive differences, switch the dates around.
    if(nTempYear2 < nTempYear1)
        return -1;

    if(sOption == "days")
    {
        return nDays;
    }
    else if(sOption == "months")
    {
        return nMonths;
    }
    else if(sOption == "years")
    {
        return nYears;
    }
    else
        return -1; //invalid option
}


///////////////////////////////////////////////////////////////////////////////////////
//usage: iNumOfMinutesElapsed = GetTimeDifference("06:14:22", "14:49:31", "minutes");
//uses NWN calendar settings for # of hours in day (0-23)
//values for sOption are: hours, minutes, seconds
//note: sTime1 MUST BE <= STime2
//i.e. GetTimeDifference("16:14:22", "14:49:31", "minutes") will return -1
///////////////////////////////////////////////////////////////////////////////////////

int GetTimeDifference(string sTime1, string sTime2, string sOption) //option = "hours", "minutes", "seconds"
{
    int nTempHour1, nTempMinute1, nTempSecond1;
    int nTempHour2, nTempMinute2, nTempSecond2;
    int nResult;
    int nHours, nMinutes, nSeconds;

    nTempHour1      = ParseDateString(sTime1, "hour");
    nTempMinute1    = ParseDateString(sTime1, "minute");
    nTempSecond1    = ParseDateString(sTime1, "second");
    nTempHour2      = ParseDateString(sTime2, "hour");
    nTempMinute2    = ParseDateString(sTime2, "minute");
    nTempSecond2    = ParseDateString(sTime2, "second");

    if(nTempHour2 == nTempHour1)//same hour
    {
        nHours = 0;
        if(nTempMinute2 == nTempMinute1)//same hour and same minute
        {
            nMinutes = 0;
            nSeconds = nTempSecond2 - nTempSecond1;
        }
        else //same hour and different minute
        {
            if(nTempSecond2 == nTempSecond1)//same hour, different minute, same second
            {
                nMinutes = nTempMinute2 - nTempMinute1;
                nSeconds = nMinutes * 60;
            }
            else //same hour, diff minute, diff second
            {
                if(nTempSecond2 >= nTempSecond1)//different minute at least one minute
                {
                    nMinutes = nTempMinute2 - nTempMinute1;
                    nSeconds = (nTempSecond2 - nTempSecond1) + (nMinutes * 60);
                }
                else //different minute, at least one minute, ending in incomplete minute
                {
                    nMinutes = (nTempMinute2 - nTempMinute1) - 1;
                    nSeconds = (60 * nMinutes-1) + (60 - nTempSecond1) + (60 - (60 - nTempSecond2));
                }
            }
        }
    }

    if(nTempHour2 > nTempHour1)//not same hour
    {
        if(nTempMinute2 == nTempMinute1)//diff hour, same minute
        {
            if(nTempSecond2 == nTempSecond1)//diff hour, same minute, same second
            {
                nHours      = nTempHour2 - nTempHour1;
                nMinutes    = 60 * nHours;
                nSeconds    = 60 * nMinutes;
            }
            else //diff hour, same minute, diff second
            {
                if(nTempSecond2 > nTempSecond1)//diff hour, same minute, at least one hour
                {
                    nHours      = nTempHour2 - nTempHour1;
                    nMinutes    = 60 * nHours;
                    nSeconds    = (60 * nMinutes) + (nTempSecond2 - nTempSecond1);
                }
                else //diff hour, same minute, one less hour
                {
                    nHours      = (nTempHour2 - nTempHour1) -1;
                    nMinutes    = (60 * nHours) + 59;
                    nSeconds    = (60 * nMinutes) + (60 + (nTempSecond2 - nTempSecond1));
                }
            }
        }
        else //diff hour, diff minute
        {
            if(nTempMinute2 > nTempMinute1)//diff hour, diff minute, at least one hour, extra minutes
            {
                if(nTempSecond2 == nTempSecond1)//diff hour, diff minute, same second
                {
                    nHours      = nTempHour2 - nTempHour1;
                    nMinutes    = (60 * nHours) + (nTempMinute2 - nTempMinute1);
                    nSeconds    = 60 * nMinutes;
                }
                else //diff hour, diff minute, diff seconds
                {
                    if(nTempSecond2 > nTempSecond1)//diff year, diff month, extra days
                    {
                        nHours      = nTempHour2 - nTempHour1;
                        nMinutes    = (60 * nHours) + (nTempMinute2 - nTempMinute1);
                        nSeconds    = (60 * nMinutes) + (nTempSecond2 - nTempSecond1);
                    }
                    else //diff hour, diff minute, fewer seconds
                    {
                        nHours      = nTempHour2 - nTempHour1;
                        nMinutes    = (60 * nHours) + (nTempMinute2 - nTempMinute1);
                        nSeconds    = (60 * nMinutes) + (60 + (nTempSecond2 - nTempSecond1));
                    }
                }
            }
            else //diff hour, diff minute, one hour less (fewer minutes)
            {
                if(nTempSecond2 == nTempSecond1)//diff hour, less minute, same seconds
                {
                    nHours      = (nTempHour2 - nTempHour1) -1;
                    nMinutes    = (60 * nHours) - (nTempMinute2 - nTempMinute1);
                    nSeconds    = 60 * nMinutes;
                }
                else //diff hour, fewer minute, diff second
                {
                    if(nTempSecond2 > nTempSecond1)//diff hour, fewer minute, extra second
                    {
                        nHours      = (nTempHour2 - nTempHour1) -1;
                        nMinutes    = (60 * nHours) - (nTempMinute2 - nTempMinute1);
                        nSeconds    = (60 * nMinutes) + (nTempSecond2 - nTempSecond1);
                    }
                    else //diff hour, fewer minutes, less seconds
                    {
                        nHours      = (nTempHour2 - nTempHour1) -1;
                        nMinutes    = (60 * nHours) - (nTempMinute2 - nTempMinute1);
                        nSeconds    = (60 * nMinutes) + (60 + (nTempSecond2 - nTempSecond1));
                    }
                }
            }
        }
    }

    // does not handle negetive differences, switch the dates around.
    if(nTempHour2 < nTempHour1)
        return -1;

    if(sOption == "hours")
    {
        return nHours;
    }
    else if(sOption == "minutes")
    {
        return nMinutes;
    }
    else if(sOption == "seconds")
    {
        return  nSeconds;
    }
    else
        return -1; //invalid option
}


///////////////////////////////////////////////////////////////////////////////////////
//usage: sDueDate = GetFutureDate(GetCurrentDate(), 7, 1, 0);
//this will return a string 7 years and 1 month in the future
///////////////////////////////////////////////////////////////////////////////////////

string GetFutureDate(string sStartDate, int nIncYear = 0, int nIncMonth = 0, int nIncDay = 0)
{
    string sResult;
    int nIndex, nRolloverBuffer;
    int nStartDay, nStartMonth, nStartYear;
    int nEndDay, nEndMonth, nEndYear;

    nStartDay = ParseDateString(sStartDate, "day");
    nStartMonth = ParseDateString(sStartDate, "month");
    nStartYear = ParseDateString(sStartDate, "year");

    nEndYear = nStartYear + nIncYear;
    nEndMonth = nStartMonth + nIncMonth;
    nEndDay = nStartDay + nIncDay;
    if((nStartDay + nIncDay) > 28) //rollover days and months
    {
        nRolloverBuffer = nEndDay - 28;
        nIndex = 1;
        while (nRolloverBuffer >= 28)
        {
            nRolloverBuffer = nRolloverBuffer - 28;
            nIndex++;
        }
        nEndDay = nRolloverBuffer;
        nEndMonth = nEndMonth + nIndex;
    }
    if(nEndMonth > 12) //rollover months and years
    {
        nRolloverBuffer = nEndMonth - 12;
        nIndex = 1;
        while (nRolloverBuffer >= 12)
        {
            nRolloverBuffer = nRolloverBuffer - 12;
            nIndex++;
        }
        nEndMonth = nRolloverBuffer;
        nEndYear = nEndYear + nIndex;
    }

    //sResult = IntToString(nEndYear) + "-" + IntToString(nEndMonth) + "-" + IntToString(nEndDay);
    sResult = GetDateString(nEndYear, nEndMonth, nEndDay);

    return sResult;
}


///////////////////////////////////////////////////////////////////////////////////////
//usage: sBDay = GetPastDate(GetCurrentDate(), 0, 0, 50);
//this will return a string 50 days in the past
///////////////////////////////////////////////////////////////////////////////////////

string GetPastDate(string sStartDate, int nIncYear = 0, int nIncMonth = 0, int nIncDay = 0)
{
    string sResult;
    int nIndex, nRolloverBuffer;
    int nStartDay, nStartMonth, nStartYear;
    int nEndDay, nEndMonth, nEndYear;

    nStartDay = ParseDateString(sStartDate, "day");
    nStartMonth = ParseDateString(sStartDate, "month");
    nStartYear = ParseDateString(sStartDate, "year");

    nEndYear = nStartYear - nIncYear;
    nEndMonth = nStartMonth - nIncMonth;
    nEndDay = nStartDay - nIncDay;
    if(nEndDay < 1) //rollover days and months
    {
        nRolloverBuffer = nEndDay + 28;
        nIndex = 1;
        while (nRolloverBuffer <= 1)
        {
            nRolloverBuffer = nRolloverBuffer + 28;
            nIndex++;
        }
        nEndDay = nRolloverBuffer;
        nEndMonth = nEndMonth - nIndex;
    }
    if(nEndMonth < 1) //rollover months and years
    {
        nRolloverBuffer = nEndMonth + 12;
        nIndex = 1;
        while (nRolloverBuffer <= 1)
        {
            nRolloverBuffer = nRolloverBuffer + 12;
            nIndex++;
        }
        nEndMonth = nRolloverBuffer;
        nEndYear = nEndYear - nIndex;
    }

    //sResult = IntToString(nEndYear) + "-" + IntToString(nEndMonth) + "-" + IntToString(nEndDay);
    sResult = GetDateString(nEndYear, nEndMonth, nEndDay);

    return sResult;
}


///////////////////////////////////////////////////////////////////////////////////////
//purpose: test if sDate1 == sDate2
///////////////////////////////////////////////////////////////////////////////////////

int CompareDates(string sDate1, string sDate2)
{
    int nResult;
    int nTempDay1, nTempMonth1, nTempYear1;
    int nTempDay2, nTempMonth2, nTempYear2;

    nTempDay1   = ParseDateString(sDate1, "day");
    nTempMonth1 = ParseDateString(sDate1, "month");
    nTempYear1  = ParseDateString(sDate1, "year");
    nTempDay2   = ParseDateString(sDate2, "day");
    nTempMonth2 = ParseDateString(sDate2, "month");
    nTempYear2  = ParseDateString(sDate2, "year");

    if(nTempYear1 == nTempYear2) //same year
    {
        if(nTempMonth1 == nTempMonth2) //same month
        {
            if(nTempDay1 > nTempDay2) //same year and month, just check day
                nResult = TRUE;
            else
                nResult = FALSE;
        }
        else
        {
            if(nTempMonth1 > nTempMonth2)//same year, if month is bigger date is >
                nResult = TRUE;
            else
                nResult = FALSE;
        }
    }
    else
    {
        if(nTempYear1 > nTempYear2)//if the year is bigger, day and month don't matter
            nResult = TRUE;
        else
            nResult = FALSE;
    }

    return nResult;
}
///////////////////////////////////////////////////////////////////////////////////////
//Converts sDateTime to Seconds
///////////////////////////////////////////////////////////////////////////////////////
int DateTimeToSeconds(string sDateTime)
{
    int nResults = 0;

    nResults  +=  ParseDateTimeString(sDateTime, "second");
    nResults  += (ParseDateTimeString(sDateTime, "minute")  * 60);
    nResults  += (ParseDateTimeString(sDateTime, "hour")    * 3600);
    nResults  += (ParseDateTimeString(sDateTime, "day")     * 86400);
    nResults  += (ParseDateTimeString(sDateTime, "month")   * 2419200);
    nResults  += (ParseDateTimeString(sDateTime, "year")    * 29090400);

    return nResults;
}
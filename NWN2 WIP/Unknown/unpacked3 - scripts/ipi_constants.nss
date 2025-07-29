// Some constants
string sPREFIX = "IPI_Inn_";
int MAX_CLASSES = 9;
int MAX_ROOMS = 999;

//This number controls how room rate numbers, takes from the
// Reflex Save of door objects, will be interpreted.
// Set the Will Save of the Inn placeable to one of these
int DAILY_RATE = 0;
int WEEKLY_RATE = 1;
int MONTHLY_RATE = 2;
int YEARLY_RATE = 3;

//This number controls how a room's name will be reported
// when the individual room, not it's class, is referenced
// Set the Will Save of door objects to this number.
int USE_ROOM_NUMBER = 0;
int USE_ROOM_NAME = 1;

// Names of variables stored on the Inn object
string INITIALIZED_VAR = "bInitialized";
string ROOMSINCLASS_VAR = "RoomsInClass";
string CLASSFORRATE_VAR = "ClassForRate";
string NUMCLASSES_VAR = "NumClasses";
string CLASSRATE_VAR = "RateForClass";
string TOTALROOMS_VAR = "TotalRooms";

// Names of variables stored on the Innkeeper object
string ISBOOKED_VAR = "IsBooked";
string HASROOMS_VAR = "HasRoomsInClass";
string FIRSTROOMINCLASS_VAR = "FirstAvailInClass";
string CHOSENCLASS_VAR = "ChosenClass";
string TOTALCOST_VAR = "TotalRentalCost";
string EXPIREDATE_VAR = "ContractExpireDate";
string HASROOM_VAR = "HasRoom";
string CURRENTROOM_VAR = "CurrentRoomNumber";
string CURRENTCLASS_VAR = "CurrentRoomClass";
string DAYSLEFT_VAR = "RemainingDays";
string REFUNDAMOUNT_VAR = "RefundAmount";

// A couple of heler functions used everywhere
string IntToStringPad3(int iNum)
{
    if (iNum < 10) return "00"+ IntToString(iNum);
    else if (iNum < 100) return "0"+ IntToString(iNum);
    else return IntToString(iNum);
}

object GetDoor(string sInnPrefix, int iRoomNum)
{
    string sDoorTag = sPREFIX + sInnPrefix +
        "_RM"+ IntToStringPad3(iRoomNum);
    return GetObjectByTag(sDoorTag);
}
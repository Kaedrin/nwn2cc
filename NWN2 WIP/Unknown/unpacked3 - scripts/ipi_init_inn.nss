// This script is used to initialize an Inn object,
// so OBJECT_SELF always refers to an Inn here
#include "ipi_constants"


// Strips the right-most token off roomName and returns the rest
string getClassName(string roomName)
{
    // Find the index of the last space character
    string className = roomName;
    int spaceIndex = -1;
    int i;
    for (i=0; i<GetStringLength(roomName); i++)
    {
        string thisChar = GetSubString(roomName, i, 1);
        if (thisChar == " ") spaceIndex = i;
    }
    if (spaceIndex > 0) className = GetSubString(roomName, 0, spaceIndex);
    return className;
}

void main()
{
    // Determine the number of classes and rooms, and store
    // this info as local variables on this inn object
    string sInnPrefix = GetStringRight(GetTag(OBJECT_SELF),2);
    int iNumClasses = 0;
    int iRoomNum = 1;
    object thisDoor = GetDoor(sInnPrefix, iRoomNum);
    while (thisDoor != OBJECT_INVALID)
    {
        //SpeakString("Checking door " + GetTag(thisDoor) + "...");
        int rate = GetReflexSavingThrow(thisDoor);
        string classKey = CLASSFORRATE_VAR + IntToString(rate);
        int thisClass = GetLocalInt(OBJECT_SELF, classKey);
        if (thisClass)
        {
            //SpeakString("Seen class " + IntToString(thisClass) + " before ...");
            int numRooms = GetLocalInt(OBJECT_SELF, ROOMSINCLASS_VAR + IntToString(thisClass));
            SetLocalInt(OBJECT_SELF, ROOMSINCLASS_VAR + IntToString(thisClass), numRooms + 1);
            string className = getClassName(GetName(thisDoor));
            //SetLocalString(OBJECT_SELF, CLASSNAME_VAR +IntToString(iNumClasses), className);
        }
        else
        {   // This is the first room with this rate
            iNumClasses++;
            thisClass = iNumClasses;
            //SpeakString("This is the first room in class " + IntToString(thisClass) + " ...");
            SetLocalInt(OBJECT_SELF, ROOMSINCLASS_VAR + IntToString(iNumClasses), 1);
            SetLocalInt(OBJECT_SELF, CLASSRATE_VAR +IntToString(iNumClasses), rate);
            string className = GetName(thisDoor);
            //SetLocalString(OBJECT_SELF, CLASSNAME_VAR +IntToString(iNumClasses), className);
            SetLocalInt(OBJECT_SELF, classKey, iNumClasses);
        }
        // Look for the next door
        iRoomNum++;
        thisDoor = GetDoor(sInnPrefix, iRoomNum);
    }
    SetLocalInt(OBJECT_SELF, TOTALROOMS_VAR, iRoomNum - 1);
    SetLocalInt(OBJECT_SELF, NUMCLASSES_VAR, iNumClasses);
    SetLocalInt(OBJECT_SELF, INITIALIZED_VAR, 1);

    /*
    // FOR DEBUGGING...
    // Report of the number of rooms and classes
    int nClasses = GetLocalInt(OBJECT_SELF, NUMCLASSES_VAR);
    WriteTimestampedLogEntry("Number of classes = "+ IntToString(nClasses));
    int i;
    for (i=1; i <= nClasses ; i++)
    {
        string sKey = ROOMSINCLASS_VAR + IntToString(i);
        int iRate = GetLocalInt(OBJECT_SELF, CLASSRATE_VAR + IntToString(i));
        string sName = GetLocalString(OBJECT_SELF, CLASSNAME_VAR + IntToString(i));
        string msg = "Class "+ IntToString(i) +" : there are "+
            IntToString(GetLocalInt(OBJECT_SELF,sKey)) + "  " +
            sName + "(s), each of which costs " +
            IntToString(iRate) +" gold per day.  ";
        WriteTimestampedLogEntry(msg);
        SpeakString(msg);
    }
    //*/
}

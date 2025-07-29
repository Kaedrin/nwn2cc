/*
Filename:           hcr2_locals_i
System:             core (special get/set locals include script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 core function definitions for special types of variable setting and getting.
This file holds the commonly used  special variable set, get and delete functions,
used throughout the core HCR2 system.

this script is accesible from hcr2_debug_i, hcr2_timers_i, hcr2_core_i.

-----------------
Revision: v1.05 adjusted include orders

*/

#include "hcr2_constants_i"

//Gets a local variable of the given type named sVarName onto to a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
int h2_GetModLocalInt(string sVarName);

//Sets a local variable of the given type named sVarName with the given value onto to a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
void h2_SetModLocalInt(string sVarName, int value);

//Deletes a local variable of the given type named sVarName from a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
void h2_DeleteModLocalInt(string sVarName);

//Gets a local variable of the given type named sVarName onto to a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
string h2_GetModLocalString(string sVarName);

//Sets a local variable of the given type named sVarName with the given value onto to a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
void h2_SetModLocalString(string sVarName, string value);

//Deletes a local variable of the given type named sVarName from a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
void h2_DeleteModLocalString(string sVarName);

//Gets a local variable of the given type named sVarName onto to a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
float h2_GetModLocalFloat(string sVarName);

//Sets a local variable of the given type named sVarName with the given value onto to a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
void h2_SetModLocalFloat(string sVarName, float value);

//Deletes a local variable of the given type named sVarName from a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
void h2_DeleteModLocalFloat(string sVarName);

//Gets a local variable of the given type named sVarName onto to a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
object h2_GetModLocalObject(string sVarName);

//Sets a local variable of the given type named sVarName with the given value onto to a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
void h2_SetModLocalObject(string sVarName, object value);

//Deletes a local variable of the given type named sVarName from a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
void h2_DeleteModLocalObject(string sVarName);

//Gets a local variable of the given type named sVarName onto to a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
location h2_GetModLocalLocation(string sVarName);

//Sets a local variable of the given type named sVarName with the given value onto to a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
void h2_SetModLocalLocation(string sVarName, location value);

//Deletes a local variable of the given type named sVarName from a
//specific placeable object with the tag H2_CORE_DATA_POINT.
//The reason for this is to avoid the performance issue that can occur
//when setting and getting locals on the extrememly overused GetModule() object.
//This function is primarily for internal h2_core use.
void h2_DeleteModLocalLocation(string sVarName);

int h2_GetModLocalInt(string sVarName)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    return GetLocalInt(oModuleLocalStorage, sVarName);
}

void h2_SetModLocalInt(string sVarName, int value)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    SetLocalInt(oModuleLocalStorage, sVarName, value);
}

void h2_DeleteModLocalInt(string sVarName)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    DeleteLocalInt(oModuleLocalStorage, sVarName);
}

string h2_GetModLocalString(string sVarName)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    return GetLocalString(oModuleLocalStorage, sVarName);
}

void h2_SetModLocalString(string sVarName, string value)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    SetLocalString(oModuleLocalStorage, sVarName, value);
}

void h2_DeleteModLocalString(string sVarName)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    DeleteLocalString(oModuleLocalStorage, sVarName);
}

float h2_GetModLocalFloat(string sVarName)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    return GetLocalFloat(oModuleLocalStorage, sVarName);
}

void h2_SetModLocalFloat(string sVarName, float value)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    SetLocalFloat(oModuleLocalStorage, sVarName, value);
}

void h2_DeleteModLocalFloat(string sVarName)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    DeleteLocalFloat(oModuleLocalStorage, sVarName);
}

object h2_GetModLocalObject(string sVarName)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    return GetLocalObject(oModuleLocalStorage, sVarName);
}

void h2_SetModLocalObject(string sVarName, object value)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    SetLocalObject(oModuleLocalStorage, sVarName, value);
}

void h2_DeleteModLocalObject(string sVarName)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    DeleteLocalObject(oModuleLocalStorage, sVarName);
}

location h2_GetModLocalLocation(string sVarName)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    return GetLocalLocation(oModuleLocalStorage, sVarName);
}

void h2_SetModLocalLocation(string sVarName, location value)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    SetLocalLocation(oModuleLocalStorage, sVarName, value);
}

void h2_DeleteModLocalLocation(string sVarName)
{
    object oModuleLocalStorage = GetWaypointByTag(H2_CORE_DATA_POINT);
    DeleteLocalLocation(oModuleLocalStorage, sVarName);
}
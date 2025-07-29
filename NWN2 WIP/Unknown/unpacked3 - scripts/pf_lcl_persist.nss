/*  Persistence Facade v1.1, by benton
    This is the implementation for local "persistence".
    It just stores all the data in memory
*/
int GetPFCampaignInt(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { return GetLocalInt(oPlayer, sVarName); }

float GetPFCampaignFloat(string sCampaignName, string sVarName,object oPlayer=OBJECT_INVALID)
    { return GetLocalFloat(oPlayer, sVarName); }

location GetPFCampaignLocation(string sCampaignName, string sVarName,object oPlayer=OBJECT_INVALID)
    { return GetLocalLocation(oPlayer, sVarName); }

string GetPFCampaignString(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { return GetLocalString(oPlayer, sVarName); }

// For some reason, Vectors can't be stored locally
vector GetPFCampaignVector(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { return Vector(0.0, 0.0, 0.0); }

void SetPFCampaignInt(string sCampaignName, string sVarName, int nInt,
    object oPlayer=OBJECT_INVALID, int expire = 0)
    { SetLocalInt(oPlayer, sVarName, nInt);}

void SetPFCampaignFloat(string sCampaignName, string sVarName, float flFloat,
    object oPlayer=OBJECT_INVALID, int expire = 0)
    { SetLocalFloat(oPlayer, sVarName, flFloat);}

void SetPFCampaignLocation(string sCampaignName, string sVarName, location locLocation,
    object oPlayer=OBJECT_INVALID, int expire = 0)
    { SetLocalLocation(oPlayer, sVarName, locLocation);}

void SetPFCampaignString(string sCampaignName, string sVarName, string sString,
    object oPlayer=OBJECT_INVALID, int expire = 0)
    { SetLocalString(oPlayer, sVarName, sString);}

// For some reason, Vectors can't be stored locally
void SetPFCampaignVector(string sCampaignName, string sVarName, vector vVector,
    object oPlayer=OBJECT_INVALID, int expire = 0) { }

void DeletePFCampaignVariable(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
{
        DeleteLocalInt(oPlayer, sVarName);
        DeleteLocalFloat(oPlayer, sVarName);
        DeleteLocalLocation(oPlayer, sVarName);
        DeleteLocalObject(oPlayer, sVarName);
        DeleteLocalString(oPlayer, sVarName);
}

void DestroyPFCampaignDatabase(string sCampaignName) {}

int StorePFCampaignObject(string sCampaignName, string sVarName, object oObject, object oPlayer=OBJECT_INVALID)
    { SetLocalObject(GetModule(), sVarName, oObject); return 1; }

object RetrievePFCampaignObject(string sCampaignName, string sVarName, location locLocation,
    object oOwner = OBJECT_INVALID, object oPlayer=OBJECT_INVALID)
    { return GetLocalObject(GetModule(), sVarName); }

//==================   HCR compatibilty functions ===================//
// These functions are put in so HCR will compile and use in-memory "persistence"
void DeletePersistentString(object oTarget, string sName)
    { DeleteLocalString(oTarget, sName);}
void DeletePersistentInt(object oTarget, string sName)
    { DeleteLocalInt(oTarget, sName);}
void DeletePersistentFloat(object oTarget, string sName)
    { DeleteLocalFloat(oTarget, sName);}
void DeletePersistentLocation(object oTarget, string sName)
    { DeleteLocalLocation(oTarget, sName);}
void DeletePersistentObject(object oTarget, string sName)
    { DeleteLocalObject(oTarget, sName);}

void SetPersistentString(object oTarget, string sName, string sValue)
    { SetLocalString(oTarget, sName, sValue);}
void SetPersistentInt(object oTarget, string sName, int iValue)
    { SetLocalInt(oTarget, sName, iValue);}
void SetPersistentFloat(object oTarget, string sName, float fValue)
    { SetLocalFloat(oTarget, sName, fValue);}
void SetPersistentLocation(object oTarget, string sName, location lValue)
    { SetLocalLocation(oTarget, sName, lValue);}
void SetPersistentObject(object oTarget, string sName, object oValue)
    { SetLocalObject(oTarget, sName, oValue);}

string GetPersistentString(object oTarget, string sName)
    { return GetLocalString(oTarget, sName); }
int GetPersistentInt(object oTarget, string sName)
    { return GetLocalInt(oTarget, sName); }
float GetPersistentFloat(object oTarget, string sName)
    { return GetLocalFloat(oTarget, sName); }
location GetPersistentLocation(object oTarget, string sName)
    { return GetLocalLocation(oTarget, sName); }
object GetPersistentObject(object oTarget, string sName)
    { return GetLocalObject(oTarget, sName); }

// These do nothing in local storage
// They are put in so HCR will compile if without using HCR persistence
void PWDBSaveAll() {}
void PWDBSaveChanged() {}


//==================   APS compatibilty functions ===================//
#include "pf_aps_sql_inc"

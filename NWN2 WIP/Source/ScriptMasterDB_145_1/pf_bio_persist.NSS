/*  Persistence Facade v1.1, by benton
    This is the front-end for the built-in Bioware persistence
    It just adds a few functions for HCR and APS compatibility
*/
// This is the campaign name that all HCR data for this module
// will be associated with. If you're not using HCR, it's not used.
string sHCRCampaignName = "pwdata";

/*  The Bioware Persistence system will not store object-specific variables unless
    the object is a PC. To get around this, the object tag is appended to the variable
    name if the object is valid and not a PC
*/
string ObjectVarName(string sVarName, object oObject)
{
    if ((oObject == OBJECT_INVALID) | GetIsPC(oObject))
        return sVarName;
    else return sVarName + GetTag(oObject);
}

int GetPFCampaignInt(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { return GetCampaignInt(sCampaignName, ObjectVarName(sVarName, oPlayer), oPlayer); }

float GetPFCampaignFloat(string sCampaignName, string sVarName,object oPlayer=OBJECT_INVALID)
    { return GetCampaignFloat(sCampaignName, ObjectVarName(sVarName, oPlayer), oPlayer); }

location GetPFCampaignLocation(string sCampaignName, string sVarName,object oPlayer=OBJECT_INVALID)
    { return GetCampaignLocation(sCampaignName, ObjectVarName(sVarName, oPlayer), oPlayer); }

string GetPFCampaignString(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { return GetCampaignString(sCampaignName, ObjectVarName(sVarName, oPlayer), oPlayer); }

vector GetPFCampaignVector(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { return GetCampaignVector(sCampaignName, ObjectVarName(sVarName, oPlayer), oPlayer); }

void SetPFCampaignInt(string sCampaignName, string sVarName, int nInt,
    object oPlayer=OBJECT_INVALID, int expire = 0)
    { SetCampaignInt(sCampaignName, ObjectVarName(sVarName, oPlayer), nInt, oPlayer);}

void SetPFCampaignFloat(string sCampaignName, string sVarName, float flFloat,
    object oPlayer=OBJECT_INVALID, int expire = 0)
    { SetCampaignFloat(sCampaignName, ObjectVarName(sVarName, oPlayer), flFloat, oPlayer);}

void SetPFCampaignLocation(string sCampaignName, string sVarName, location locLocation,
    object oPlayer=OBJECT_INVALID, int expire = 0)
    { SetCampaignLocation(sCampaignName, ObjectVarName(sVarName, oPlayer), locLocation, oPlayer);}

void SetPFCampaignString(string sCampaignName, string sVarName, string sString,
    object oPlayer=OBJECT_INVALID, int expire = 0)
    { SetCampaignString(sCampaignName, ObjectVarName(sVarName, oPlayer), sString, oPlayer);}

void SetPFCampaignVector(string sCampaignName, string sVarName, vector vVector,
    object oPlayer=OBJECT_INVALID, int expire = 0)
    { SetCampaignVector(sCampaignName, ObjectVarName(sVarName, oPlayer), vVector, oPlayer);}

void DeletePFCampaignVariable(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { DeleteCampaignVariable(sCampaignName, ObjectVarName(sVarName, oPlayer), oPlayer); }

void DestroyPFCampaignDatabase(string sCampaignName)
    { DestroyCampaignDatabase(sCampaignName); }

int StorePFCampaignObject(string sCampaignName, string sVarName, object oObject, object oPlayer=OBJECT_INVALID)
    { return StoreCampaignObject(sCampaignName, ObjectVarName(sVarName, oPlayer), oObject, oPlayer);}

object RetrievePFCampaignObject(string sCampaignName, string sVarName, location locLocation,
    object oOwner = OBJECT_INVALID, object oPlayer=OBJECT_INVALID)
    { return RetrieveCampaignObject(sCampaignName, ObjectVarName(sVarName, oPlayer), locLocation, oOwner, oPlayer); }


//==================   HCR compatibilty functions ===================//
// These functions are put in so HCR will compile and use Bioware persistence

string GetPersistentString(object oTarget, string sName)
    { return GetCampaignString(sHCRCampaignName, ObjectVarName(sName, oTarget), oTarget); }
int GetPersistentInt(object oTarget, string sName)
    { return GetCampaignInt(sHCRCampaignName, ObjectVarName(sName, oTarget), oTarget); }
float GetPersistentFloat(object oTarget, string sName)
    { return GetCampaignFloat(sHCRCampaignName, ObjectVarName(sName, oTarget), oTarget); }
location GetPersistentLocation(object oTarget, string sName)
    { return GetCampaignLocation(sHCRCampaignName, ObjectVarName(sName, oTarget), oTarget); }
object GetPersistentObject(object oTarget, string sName)
    { return RetrieveCampaignObject(sHCRCampaignName, ObjectVarName(sName, oTarget), GetLocation(oTarget), oTarget, oTarget); }

void SetPersistentString(object oTarget, string sName, string sValue)
    { SetCampaignString(sHCRCampaignName, ObjectVarName(sName, oTarget), sValue, oTarget);}
void SetPersistentInt(object oTarget, string sName, int iValue)
    { SetCampaignInt(sHCRCampaignName, ObjectVarName(sName, oTarget), iValue, oTarget);}
void SetPersistentFloat(object oTarget, string sName, float fValue)
    { SetCampaignFloat(sHCRCampaignName, ObjectVarName(sName, oTarget), fValue, oTarget);}
void SetPersistentLocation(object oTarget, string sName, location lValue)
    { SetCampaignLocation(sHCRCampaignName, ObjectVarName(sName, oTarget), lValue, oTarget);}
void SetPersistentObject(object oTarget, string sName, object oValue)
    { StoreCampaignObject(sHCRCampaignName, ObjectVarName(sName, oTarget), oValue, oTarget);}

void DeletePersistentString(object oTarget, string sName)
    { DeleteCampaignVariable(sHCRCampaignName, ObjectVarName(sName, oTarget), oTarget);}
void DeletePersistentInt(object oTarget, string sName)
    { DeleteCampaignVariable(sHCRCampaignName, ObjectVarName(sName, oTarget), oTarget);}
void DeletePersistentFloat(object oTarget, string sName)
    { DeleteCampaignVariable(sHCRCampaignName, ObjectVarName(sName, oTarget), oTarget);}
void DeletePersistentLocation(object oTarget, string sName)
    { DeleteCampaignVariable(sHCRCampaignName, ObjectVarName(sName, oTarget), oTarget);}
void DeletePersistentObject(object oTarget, string sName)
    { DeleteCampaignVariable(sHCRCampaignName, ObjectVarName(sName, oTarget), oTarget);}


// These do nothing in APS since all saving is done on-the-fly to DB
// They are put in so HCR will compile if without using HCR persistence
void PWDBSaveAll() {}
void PWDBSaveChanged() {}


//==================   APS compatibilty functions ===================//
#include "pf_aps_sql_inc"
/*  Persistence Facade v1.1, by benton
    Persistence facade file
    This file is used to define the persistence functions, and
    to include the desired presistence implementation.
    Include this file wherever you want to use these
        GetPFCampaign<VarType> functions.

    Below the function definitions, you must uncomment exactly
    one #include line. Each of the possible include files
    implements the following functions differently.

    ******** IMPORTANT NOTE FOR HCR USERS ********************
    When HCR is imported, and you want it to use APS persistence,
    you must change line 5 of the HCR script hc_inc_timecheck from
        void GetPersistentInt(object oMod, string sType);
    to
        int GetPersistentInt(object oObject, string sVarName, string sTable="pwdata");
    See the README for details on getting HCR to work with other
    persistence systems.
    **********************************************************
*/
// INTERFACE:

// Here are the functions you should use to store data
void SetPFCampaignInt(string sCampaignName, string sVarName, int nInt,
    object oPlayer=OBJECT_INVALID, int iExpire = 0);
void SetPFCampaignFloat(string sCampaignName, string sVarName, float flFloat,
    object oPlayer=OBJECT_INVALID, int iExpire = 0);
void SetPFCampaignLocation(string sCampaignName, string sVarName, location locLocation,
    object oPlayer=OBJECT_INVALID, int iExpire = 0);
void SetPFCampaignString(string sCampaignName, string sVarName, string sString,
    object oPlayer=OBJECT_INVALID, int iExpire = 0);
void SetPFCampaignVector(string sCampaignName, string sVarName, vector vVector,
    object oPlayer=OBJECT_INVALID, int iExpire = 0);
int StorePFCampaignObject(string sCampaignName, string sVarName, object oObject,
    object oPlayer=OBJECT_INVALID);

// Here are the functions you should use to retrieve data
int GetPFCampaignInt(string sCampaignName, string sVarName,
    object oPlayer=OBJECT_INVALID);
float GetPFCampaignFloat(string sCampaignName, string sVarName,
    object oPlayer=OBJECT_INVALID);
location GetPFCampaignLocation(string sCampaignName, string sVarName,
    object oPlayer=OBJECT_INVALID);
string GetPFCampaignString(string sCampaignName, string sVarName,
    object oPlayer=OBJECT_INVALID);
vector GetPFCampaignVector(string sCampaignName, string sVarName,
    object oPlayer=OBJECT_INVALID);
object RetrievePFCampaignObject(string sCampaignName, string sVarName, location locLocation,
    object oOwner = OBJECT_INVALID, object oPlayer=OBJECT_INVALID);

// Use this function to delete data
void DeletePFCampaignVariable(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID);

// IMPLEMENTATION:

/*  Uncomment the following line to use the built-in Bioware
    persistence
*/
#include "pf_bio_persist"

/*  Import HCR and pf_hcr_persist, then uncomment the following line to use HCR
    persistence, which dumps nwscript to the server log file.
*/
//#include "pf_hcr_persist"

/*  Import pf_aps_persist and uncomment the following line to use APS/NWNX
    database persistence. You must also add the command
        ExecuteScript("aps_onload", GetModule());
    somewhere in your module's OnModuleLoad script
    (or use aps_onload as your module's OnModuleLoad script).
*/
//#include "pf_aps_persist"

/*  Local "Persistence" emulation
    (for testing without writing any permanent data)
    This persistence system simply calls the equivalent
    SetLocal<VarType> function
*/
//#include "pf_lcl_persist"


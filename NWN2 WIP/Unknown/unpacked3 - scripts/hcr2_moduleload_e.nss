/*
Filename:           hcr2_moduleload_e
System:             core (module load event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnModuleLoad Event.
This script should be attachted to the OnModuleLoad event under
the scripts section of Module properties.

-----------------
Revision: v1.02
Added log to indicate what persistence system is being used.

Revision: v1.05
Added various debugging code for testing  purposes if the module name is HCR2_TEST.
Altered logging code

*/

#include "hcr2_core_i"
#include "x2_inc_switches"
#include "elu_functions_i"
#include "alex_constants"
#include "cwhit_tracking_core"
#include "nwnx_sql"
#include "ev_mq_inc"

void main()
{
	object oMod = GetModule();	//Turn on Debug and 
	h2_CreateDataPoint(H2_CORE_DATA_POINT);	
	if (GetName(oMod) == "HCR2_TEST")
		h2_SetModLocalInt(H2_LOGLEVEL, H2_LOG_DEBUG); 
	else
		h2_SetModLocalInt(H2_LOGLEVEL, H2_DEFAULT_LOGLEVEL);
		
	h2_LogMessage(H2_LOG_INFO, H2_TEXT_USING_PERSISTENCE + H2_PERSISTENCE_SYSTEM_NAME);    	
	h2_InitializeDatabase();
	
	// Write mini-quests to database
	add_all_mini_quests();
	
	// Reset Online column in characters database
	// (to handle server crashes)
	string sSQL = "UPDATE characters SET Online=0";
	SQLExecDirect(sSQL);
	
    h2_CopyEventVariablesToCoreDataPoint();    
	h2_CreateDataPoint(H2_FEATUSES_DATA_POINT);
	//h2_SetUpFeatUsesData may cause a TMI timeout 
	//if not used w/ DelayCommand
	DelayCommand(0.0, h2_SetUpFeatUsesData());
	
	if (GetName(oMod) == "HCR2_TEST")
	{	//Set up some testing data and events.		
		int index = 1;
	    string scriptname = h2_GetModLocalString(H2_EVENT_ON_MODULE_LOAD + IntToString(index));
	    while (scriptname != "")
	    {        
	        index++;
	        scriptname = h2_GetModLocalString(H2_EVENT_ON_MODULE_LOAD + IntToString(index));
	    }
		h2_SetModLocalString(H2_EVENT_ON_MODULE_LOAD + IntToString(index), "test_moduleload");
		h2_LogMessage(H2_LOG_DEBUG,"Added test_moduleload");
	}
	
    h2_RestoreSavedCalendar();
    h2_SaveServerStartTime();
    h2_StartCharExportTimer();
	
	//Adding custom reset script (by Alex)
	if(RESET_ENABLED)
	{
		int ServerResetTimer = h2_CreateTimer(GetModule(), "alex_serverreset", RESET_TIMER_UPDATE);
		h2_StartTimer(ServerResetTimer);
	}	
	
	//Adding MotB sundial (by Alex)
	int ClockUpdateTimer = h2_CreateTimer(GetModule(), "alex_updateclock", CLOCK_TIMER_UPDATE);
	h2_StartTimer(ClockUpdateTimer);
	
	//Adding PC tracking (by Chris)
	int TrackingUpdateTimer = h2_CreateTimer(GetModule(), "cwhit_tracking", TRACKING_UPDATE_TIME);
	h2_StartTimer(TrackingUpdateTimer);
	
	// Adding AFK Prevention System (By Ella)
	int AFKCheckTimer = h2_CreateTimer(GetModule(), AFK_SCRIPT1, AFK_CHECK);
	h2_StartTimer(AFKCheckTimer);
	SetLocalFloat(GetModule(), AFK_CHECK_TIME, AFK_CHECK);
	SetLocalInt(GetModule(), AFK_TIMER_INT, AFKCheckTimer);
	
	SetModuleSwitch (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS, TRUE);
	SetModuleSwitch (MODULE_SWITCH_ENABLE_SEPERATE_ITEM_SCRIPTS, TRUE);
	SetUserDefinedItemEventPrefix("t_");
	LoadClass2DAData();
	LoadSkill2DAData();	
	
    h2_RunModuleEventScripts(H2_EVENT_ON_MODULE_LOAD);
	
	SetGlobalInt("bNX2_TRANSITIONS", TRUE);
	string sOverrideSpellScript = GetLocalString(oMod, MODULE_VAR_OVERRIDE_SPELLSCRIPT);
	//This is placed AFTER the RunModuleEventScripts in case some moduleload event script tried to re-assigned this value.	
	//SetLocalString(oMod, MODULE_VAR_OVERRIDE_SPELLSCRIPT, H2_SPELLHOOK_EVENT_SCRIPT);		
      
	if (sOverrideSpellScript !=  "" && sOverrideSpellScript != H2_SPELLHOOK_EVENT_SCRIPT)
	{	//log a warning that some system tried to reset the value.
		h2_LogMessage(H2_LOG_WARN, "Some subsystem attempted to reset the MODULE_VAR_OVERRIDE_SPELLSCRIPT to: " + sOverrideSpellScript +
			". This has been reset to the proper value needed by HCR2, but you should look over your OnModuleLoadX scripts and determine if " + 
			sOverrideSpellScript + " needs to be added as an OnSpellHookX module variable.");
	}
	
	ExecuteScript("cmi_pw_mod_start", GetModule());
}
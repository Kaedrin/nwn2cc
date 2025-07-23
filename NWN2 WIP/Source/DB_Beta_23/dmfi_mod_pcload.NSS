////////////////////////////////////////////////////////////////////////////////
// dmfi_mod_pcload - DM Friendly Initiative - On PC Loaded Script : Module Event
// Original Scripter:  Demetrious      Design: DMFI Design Team
//------------------------------------------------------------------------------
// Last Modified By:   Demetrious           12/6/6
//------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////

// This script is only included so that I can create an up to date erf for the 
// Listener package - it is purposefully excluded from the dmfi.erf

#include "dmfi_inc_initial"
#include "ev_warlock_pact_inc"

void main()
{
	object oPC = GetEnteringObject();

	//SetLocalInt(GetEnteringObject(), DMFI_DM_STATE,1);  //QA Testing purposes only.
	DMFI_ClientEnter(GetEnteringObject());
	
	// Message of the day
	string sMotd = GetLocalString(GetModule(), "hv_motd");
	if (sMotd != "") {
		DelayCommand(5.0, SendMessageToPC(GetEnteringObject(), "<C=pink>Message of the day:\n" + sMotd));
		DelayCommand(5.2, SendChatMessage(OBJECT_INVALID, GetEnteringObject(), CHAT_MODE_SERVER, "<C=pink>Message of the day:\n" + sMotd));
	}
	
	// Show rules
	if (GetLocalInt(GetEnteringObject(), "ev_rules") == 0) {
		if (GetTotalLevels(GetEnteringObject(), FALSE) < 6) {
			ExecuteScript("ev_show_server_rules", GetEnteringObject());
		}
		SetLocalInt(GetEnteringObject(), "ev_rules", 1);
	}
	
	// Warlock pact feats
	// If has warlock levels and no pact feat, prompt for one
	if (GetLevelByClass(CLASS_TYPE_WARLOCK, oPC) > 0) {
		if (!GetHasFeat(PACT_DARK, oPC, TRUE)
			&& 
			!GetHasFeat(PACT_INFERNAL, oPC, TRUE)
			&& 
			!GetHasFeat(PACT_SEELIE, oPC, TRUE)
			&& 
			!GetHasFeat(PACT_STAR, oPC, TRUE)
			&& 
			!GetHasFeat(PACT_UNSEELIE, oPC, TRUE))
		{
			DisplayGuiScreen(oPC, "ev_warlock_pact", TRUE, "ev_warlock_pact.xml");
		}
	
	}	
}
// k_mod_hb
/*
	module heartbeat
	
*/
// ChazM 11/17/06
// ChazM 5/30/07 - added SpiritEaterConversationPauseCheck
// ChazM 6/7/07 - moved convo pause funcs to kinc_spirit_eater
// ChazM 7/2/07 - fix: Spirit Eater points update for campaign hours passed
// ChazM 7/25/07 - fix for time updates on module first entry

#include "ginc_time"
#include "ginc_debug"
#include "kinc_spirit_eater"



// Post message with drop-shadow and print to log
void StillMessage(object oTarget, string sMessage, int nX, int nY, float fDuration, int nColor=POST_COLOR_WHITE)
{
	Backdrop(oTarget, sMessage, nX, nY, fDuration, POST_COLOR_BLACK);
	DebugPostString(oTarget, sMessage, nX, nY, fDuration, nColor);
	PrintString(sMessage);
}

void PostTime(string sDate, string sTime)
{
	object oPC = GetFirstPC(FALSE);
	StillMessage(oPC, sDate, 300, 30, 5.9f);
	StillMessage(oPC, sTime, 300, 50, 5.9f);

}

void PostSpiritEnergy()
{
	object oPC = GetFirstPC(FALSE);
	string sSE = "--Spirit Energy: " + FloatToString(GetSpiritEaterPoints());
	StillMessage(oPC, sSE, 300, 70, 5.9f);
	string sCorruption = "--Corruption: " + FloatToString(GetSpiritEaterCorruption());
	StillMessage(oPC, sCorruption, 300, 90, 5.9f);
}

void main()
{

	ExecuteScript("cmi_mod_hb", OBJECT_SELF);
	int _isSoZ;
	string sTag = GetTag(GetModule());
	
	if ( sTag == "F_X2"
	||	sTag == "G_X2"
	||	sTag == "M_X2"
	||	sTag == "N_X2"
	||	sTag == "O_X2"
	||	sTag == "S_X2"
	||	sTag == "T_X2"
	||	sTag == "X_X2"
	)
	{
		_isSoZ = TRUE;
	}
	else
		_isSoZ = FALSE;


	//SpawnScriptDebugger();
	struct CTimeDate rTimeDate = GetCurrentCTimeDate();
	string sOut1 = "--Date: " + GetFRDisplayDate(rTimeDate);
	string sOut2 = "--Time: " + GetFRDisplayTime(rTimeDate);

	if (!_isSoZ)
	{
		PostTime(sOut1, sOut2);
		PostSpiritEnergy();
	}
	
	struct CHoursPassed rHP = CheckTime();
	int nNumModuleHoursPassed =	rHP.nNumModuleHoursPassed;
	int nNumCampaignHoursPassed = rHP.nNumCampaignHoursPassed;
	
	//int nNumModuleHoursPassed = CheckTime();
	//int nNumCampaignHoursPassed = GetGlobalInt(VAR_HOURS_PASSED);
	
	if (!_isSoZ)
	{	
		PrettyDebug("nNumModuleHoursPassed = " + IntToString(nNumModuleHoursPassed));
		PrettyDebug("nNumCampaignHoursPassed = " + IntToString(nNumCampaignHoursPassed));
	}
	
	if ((nNumModuleHoursPassed > 0) ||
		(nNumCampaignHoursPassed > 0))
	{
		UpdateClockForAllPlayers();

		if (!_isSoZ)
		{			
			UpdateSEPointsForTimePassed(nNumCampaignHoursPassed);
			PrettyDebug("SpiritEaterStage = " + IntToString(GetSpiritEaterStage()) + "SpiritEaterPoints = " + FloatToString(GetSpiritEaterPoints()));
		}
	}
	
	if (!_isSoZ)
	{	
		CheckAllForSEConvoPause();
	}
}
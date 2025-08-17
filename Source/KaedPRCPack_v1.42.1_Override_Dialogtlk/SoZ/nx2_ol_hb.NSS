//nx2_ol_hb
//Default OL Map heartbeat script.
//If the map has a local string named "sHeartbeatScript" it will run that script as well.
//NLC 8/20/08

#include "ginc_overland"
#include "kinc_trade"
#include "ginc_vars"

const int NEUTRAL_ENC_SPAWN_TIME = 1;

void RunCalendarEvents()
{
	int nDay = GetCalendarDay();
	int nMonth = GetCalendarMonth();
	int nYear = GetCalendarYear();

	if(nDay != GetGlobalInt(VAR_CURRENT_DAY))
	{
		SetGlobalInt(VAR_CURRENT_DAY, nDay);
		PrettyDebug("Running ProcessTimeUnit()");
		
		if(GetGlobalInt("00_nStoryStep") >= 2)
			ProcessTimeUnit();
		
		if(nMonth != GetGlobalInt(VAR_CURRENT_MONTH))
		{
			SetGlobalInt(VAR_CURRENT_MONTH, nMonth);
			
			if(nYear != GetGlobalInt(VAR_CURRENT_YEAR))
				SetGlobalInt(VAR_CURRENT_YEAR, nYear);
		}
	}
}

void main()
{
	object oPC = GetFactionLeader(GetFirstPC(FALSE));
	int nSpecialEncounterCooldown = GetLocalInt(OBJECT_SELF, VAR_ENC_SPECIAL_COOLDOWN);
	int nTimer = GetLocalInt(OBJECT_SELF, VAR_ENC_TIMER);

	RunCalendarEvents();
	
	if(GetArea(oPC) != OBJECT_SELF)
		return;
	
	ModifyLocalInt(OBJECT_SELF, VAR_ENC_SPECIAL_COOLDOWN, -1);	
	ModifyLocalInt(OBJECT_SELF, VAR_ENC_TIMER, 1);

	if((nTimer % NEUTRAL_ENC_SPAWN_TIME) == 0)
	{
		InitializeNeutralEncounter(oPC);
	}
	
	if(nSpecialEncounterCooldown <= 0)
	{
		InitializeSpecialEncounter(oPC);
		ResetSpecialEncounterTimer();
	}
	
	object oFM = GetFirstFactionMember(oPC, FALSE);
	while(GetIsObjectValid(oFM))
	{
		if(GetScriptHidden(oFM))
		{
			AssignCommand(oFM, JumpToObject(GetFactionLeader(oFM)));
		}
		oFM = GetNextFactionMember(oPC, FALSE);
	}
	
	/* Failsafe - if the PC hasn't been shrunk yet, and you hit a heartbeat, shrink him. */
	while(GetIsPC(oPC) && GetIsObjectValid(oPC) && GetLocalInt(oPC, "pcshrunk") == FALSE)
	{
		SetLocalInt(oPC, "pcshrunk", TRUE);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSetScale(0.5, 0.5, 0.5),oPC);
		oPC = GetNextPC(FALSE);
	}
	
	string sHeartbeatScript = GetLocalString(OBJECT_SELF, "sHeartbeatScript");
	if(sHeartbeatScript != "")
	{
		ExecuteScript(sHeartbeatScript, OBJECT_SELF);
	}
}
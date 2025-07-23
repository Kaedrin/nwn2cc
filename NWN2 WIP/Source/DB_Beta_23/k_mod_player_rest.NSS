// k_mod_player_rest
/*
    Module rest
*/
// ChazM 3/2/06
// ChazM 11/29/06
// ChazM 4/10/07 - added GUI functions (disabled for the time being until fully working)
// ChazM 4/11/07 - Finished and enabled Rest GUI changes. Moved parts to gui_rest
// ChazM 4/13/07 - Added support for rest strings output through script
// ChazM 7/18/07 - Added delay before popping up GUI to prevent multiple rest clicks while paused.

#include "ginc_restsys"
#include "x2_inc_switches"
#include "ginc_time"
#include "ginc_transition"

#include "cmi_includes"


// prototypes
void DoSinglePartyRest(object oPC);

// funcitons
void DoSinglePartyRest(object oPC)
{
	//WMRestEncounterInit(oPC);
	PrettyDebug("Using Single Party Rest System (switch set)!");	
	// if you press the rest button, an interface pops up alerting you to the danger level,
	// and asking how long you want to rest.
	if (GetLocalInt(oPC, VAR_REST_NOW) == FALSE)
	{
		AssignCommand(oPC, ClearAllActions());
		if (!IsPartyGathered(oPC, 20.0f))
		{
			//AssignCommand(oPC, ActionSpeakString("Hey, Let's all gather together so we can rest!"));
			FloatingTextStrRefOnCreature(STR_REF_MUST_GATHER_FOR_REST, oPC);
		}			
		else
		{
			//AssignCommand(oPC, ActionStartConversation(oPC, "gr_rest_convo", TRUE, FALSE));
			// conversation must set DoRestingNow to TRUE and make player rest
			DelayCommand(0.01f, DisplayRestGUI(oPC));
		}
	}
	else
	{
		// Rest away!
	}			
}

void main()
{
	object oPC = GetLastPCRested();
	
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
		
		//This code is for SoZ and is meant ONLY to fix Septimund's spellcasting and 
		//resting on the overland map.	
		object oPartyMember = GetFirstFactionMember(oPC, FALSE);
		while(GetIsObjectValid(oPartyMember) == TRUE)
		{
			if (GetTag(oPartyMember) == "co_septimund")
			{
				if (!GetHasFeat(2249, oPartyMember))
					FeatAdd(oPartyMember, 2249, FALSE, TRUE);
			}
			ExecuteScript("ccs_player_rest",oPC);
			oPartyMember = GetNextFactionMember(oPC, FALSE);
		}		
	}
	else
		_isSoZ = FALSE;
		
	if (_isSoZ)	
		AssignCommand(oPC, ClearAllActions());
	
	PrettyDebug(GetName(oPC) + " is Resting!");
	int iRestEventType = GetLastRestEventType();
	int bSinglePartyRestSystem = GetModuleSwitchValue(MODULE_SWITCH_USE_NX1_SINGLE_PARTY_RESTSYSTEM);
	
	switch (iRestEventType)
	{
		case REST_EVENTTYPE_REST_STARTED:
		{
		
			int nCurrentCon = GetAbilityScore(oPC, ABILITY_CONSTITUTION);
			int nBaseCon = GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE);
			int nHD = GetHitDice(oPC);
			int nHeal = nHD * ((nCurrentCon - nBaseCon) / 2);
			if (nHeal > 0)
			{
				int nCurrentHP = GetCurrentHitPoints(oPC);
				if (nCurrentHP < (nHeal + 1) )
				{
					int nHealVal = nHeal - nCurrentHP + 1;
					effect eHeal = EffectHeal(nHealVal);
					ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
					SetLocalInt(oPC, "HealFixValue", nHealVal);			
				}
			}
					
			//RestSendMessage(oPC, STR_REF_REST_STARTED);
			PrettyDebug("this is REST_EVENTTYPE_REST_STARTED - so checking for wandering monsters...");
		    if (bSinglePartyRestSystem == TRUE)
			{
				DoSinglePartyRest(oPC);
			}				
		    else if (GetModuleSwitchValue(MODULE_SWITCH_USE_XP2_RESTSYSTEM) == TRUE)
			{
				RestSendMessage(oPC, STR_REF_REST_STARTED);
				WMRestEncounterInit(oPC);
				WMRestEncounterCheck(oPC);
			}
			else
			{
				RestSendMessage(oPC, STR_REF_REST_STARTED);
			}
		}
		break;

		case REST_EVENTTYPE_REST_CANCELLED:
		{
			int nHealFixValue = GetLocalInt(oPC, "HealFixValue");
			if (nHealFixValue > 0)
			{
				effect eBadPlayerSlap = EffectDamage(nHealFixValue, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL, TRUE);
    			ApplyEffectToObject(DURATION_TYPE_INSTANT, eBadPlayerSlap, oPC);
				SetLocalInt(oPC, "HealFixValue", 0);	
			}
			
			int bReportCancel = GetLocalInt(oPC, VAR_REST_REPORT_CANCEL);
			if ((!bSinglePartyRestSystem) || bReportCancel)
				RestSendMessage(oPC, STR_REF_REST_CANCELLED);
		 // No longer used but left in for the community
		 // WMFinishPlayerRest(oPC,TRUE); // removes sleep effect, etc
		}
		break;
		
		case REST_EVENTTYPE_REST_FINISHED:
		{
			SetLocalInt(oPC, "HealFixValue", 0);	
			ExecuteScript("ccs_player_rest",oPC);
				
			// always indicate rest finished
			RestSendMessage(oPC, STR_REF_REST_FINISHED);
		 // No longer used but left in for the community
		 //   WMFinishPlayerRest(oPC); // removes sleep effect, etc
		}
	}	

}
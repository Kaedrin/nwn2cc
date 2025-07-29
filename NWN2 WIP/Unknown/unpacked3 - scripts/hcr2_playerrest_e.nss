/*
Filename:           hcr2_playerrest_e
System:             core (player rest event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnPlayerRest Event.
This script should be attachted to the OnPlayerRest event under
the scripts section of Module properties.

-----------------
Revision: v1.03
Added call to h2_SavePCSpellsAvailable if spell recovery was allowed 
on rest finished.

v1.05
Fix for tracking rest time, spells, feats, and health 
for companions on rest

*/
#include "hcr2_core_i"

void main()
{
    object oPC = GetLastPCRested();
	if (H2_EXPORT_CHARACTERS_INTERVAL > 0.0)
		ExportSingleCharacter(oPC);
		
    int nRestEventType = GetLastRestEventType();    
    object oPM;
	switch (nRestEventType)
    {
        case REST_EVENTTYPE_REST_STARTED:
			oPM = GetFirstFactionMember(oPC, FALSE);
			while (GetIsObjectValid(oPM))
			{
				if (!GetIsPC(oPM) || oPM == oPC)
				{
					h2_SetAllowRest(oPM, TRUE);
		            h2_SetAllowSpellRecovery(oPM, TRUE);
					h2_SetAllowFeatRecovery(oPM, TRUE);
		            h2_SetPostRestHealAmount(oPM, GetMaxHitPoints(oPM));            
		        }
				oPM = GetNextFactionMember(oPM, FALSE);
			}                
            h2_RunModuleEventScripts(H2_EVENT_ON_PLAYER_REST_STARTED);
            if (h2_GetAllowRest(oPC) && !GetLocalInt(oPC, H2_SKIP_REST_MESSAGEBOX))			              
				h2_DisplayRestMessageBox(oPC);			
            else if (!h2_GetAllowRest(oPC))
            {
                SetLocalInt(oPC, H2_SKIP_CANCEL_REST, TRUE);
                AssignCommand(oPC, ClearAllActions());
                SendMessageToPC(oPC, H2_TEXT_REST_NOT_ALLOWED_HERE);
            }
            DeleteLocalInt(oPC, H2_SKIP_REST_MESSAGEBOX);
            break;
        case REST_EVENTTYPE_REST_CANCELLED:
			if (!GetLocalInt(oPC, H2_SKIP_CANCEL_REST))
                h2_RunModuleEventScripts(H2_EVENT_ON_PLAYER_REST_CANCELLED);
            DeleteLocalInt(oPC, H2_SKIP_CANCEL_REST);
            break;
        case REST_EVENTTYPE_REST_FINISHED:
			if (h2_GetAllowSpellRecovery(oPC))
			{
				h2_SavePCSpellsAvailable(oPC);
				DeleteLocalString(oPC, H2_SPELL_TRACK);
				DeleteLocalString(oPC, H2_SPELL_TRACK_SP);
			}
            h2_RunModuleEventScripts(H2_EVENT_ON_PLAYER_REST_FINISHED);
            break;
    }
	//object oPC = GetLastPCRested();
	ExecuteScript("cmi_player_rest",oPC);
}
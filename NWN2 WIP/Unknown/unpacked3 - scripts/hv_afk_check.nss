#include "alex_constants"
#include "hv_chat_commands"

// Check if player should be booted or warned from getting booted
void main()
{
	// Count how many PCs there are
	int nPCCount = 0;	

	// Go over all PCs in module
	object oPC = GetFirstPC();
	
	while (GetIsPC(oPC)) {
	
		// Skip DMs?
		if ((GetIsDM(oPC)) && (BOOT_AFK_DM == FALSE)) {
		
			oPC = GetNextPC();
			nPCCount++;
			continue;
		}	
		
		// If current location is same as stored one, and 
		// chat wasn't used in the last X (AFK_CHECK) minutes,
		// initiate boot sequence
		if ((GetLocation(oPC) == GetLocalLocation(oPC, AFK_LOCATION))
			&&
			(GetLocalInt(oPC, AFK_CHAT) == 0)) {
			
				// Inform player she's in booting danger
				SendMessageToPC(oPC, "<C=red>This auto-script has noticed that your char has neither moved nor spoken for "
									+ FloatToString(GetLocalFloat(GetModule(), AFK_CHECK_TIME) / 60, 18, 1) + " minutes. This auto-script will boot you from the server in "
									+ FloatToString(SECOND_AFK_CHECK / 60, 18, 1) + " minute unless you move, speak or hit OK on the messagebox.");
				
			   	// Initiate Booting Sequence
				DisplayMessageBox(oPC, 0, "Press OK to confirm you are not AFK", "gui_hv_afk_confirmation");
				DelayCommand(SECOND_AFK_CHECK, ExecuteScript("hv_afk_check2", oPC));
		}
		else {
		
			// Store current location
			SetLocalLocation(oPC, AFK_LOCATION, GetLocation(oPC));
		
			// Reset Chat variable
			SetLocalInt(oPC, AFK_CHAT, 0);
		
			// Debug
			//SendMessageToPC(oPC, "<C=cyan>Passed AFK Check");
		}
		
		nPCCount++;
		
		// Next please!
		oPC = GetNextPC();		
	}
	
	/*// If there are more than 65 players, set
	// shorter afk timer if it isn't laready set
	if (nPCCount >= 65) {
		if (GetLocalFloat(GetModule(), AFK_CHECK_TIME) > 240.0) {
			DelayCommand(SECOND_AFK_CHECK + 10.0, SetNewAFKTimer(240.0));
			DelayCommand(SECOND_AFK_CHECK + 10.5,SendMessageToAllDMs("<C=cyan>High player count (" + IntToString(nPCCount) + ") - AFK timer will be set to 4.0 minutes automatically."));
		}
	}
	else {
		if (GetLocalFloat(GetModule(), AFK_CHECK_TIME) < AFK_CHECK) {
			DelayCommand(SECOND_AFK_CHECK + 10.0, SetNewAFKTimer(AFK_CHECK));
			DelayCommand(SECOND_AFK_CHECK + 10.5,SendMessageToAllDMs("<C=cyan>Low player count (" + IntToString(nPCCount) + ") - AFK timer will be set to " + FloatToString(AFK_CHECK / 60, 18, 1) + " minutes automatically."));
		}
	}*/
}
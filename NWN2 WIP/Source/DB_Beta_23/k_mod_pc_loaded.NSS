// k_mod_pc_loaded
/*
	Description:
	NX1 - module PC loaded
	
	This fires shortle after client enter, when the PC is fully in the game.
	Note that this does not fire between module transtions.
	
*/
// ChazM 11/21/06
// ChazM 5/17/07 - added RemovePurificationPowers()
// ChazM 6/1/07 - added SetClockOnForPlayer()
// ChazM 6/4/07 added UpdateWhoIsSpiritEater() 
// ChazM 6/5/07 - PC's no longer registered for time events
// ChazM 7/5/07 - added jump to party leader, one party mode warning, and pc spawn script (like in the OC)
// ChazM 7/19/07 - remove SE from enterer if not supposed to be the spirit eater.

#include "ginc_time"

#include "kinc_spirit_eater"
#include "x0_inc_henai"
#include "ginc_math"

const int STR_REF_ONE_PARTY_MODE_ONLY	= 183964;

void NotOnePartyModeWarning(object oPC)
{
	string sMsg = GetStringByStrRef(STR_REF_ONE_PARTY_MODE_ONLY);

	DisplayMessageBox(
		oPC, // Display a message box for this PC
		-1, // string ref to display
		sMsg, // Message to display
		"", // Callback for clicking the OK button
		"", // Callback for clicking the Cancel button
		FALSE, // Do not display the Cancel button
		"SCREEN_MESSAGEBOX_INFORMATION", // Display the tutorial message box   
		-1, // OK string ref
		"", // OK string
		-1, // Cancel string ref
		""  // Cancel string
		);
}

// these were to be removed at then end of NWN2 OC
void RemovePurificationPowers(object oPC)
{
	FeatRemove(oPC, FEAT_CLEANSING_NOVA);
	FeatRemove(oPC, FEAT_SHINING_SHIELD);
	FeatRemove(oPC, FEAT_SOOTHING_LIGHT);
	FeatRemove(oPC, FEAT_AURORA_CHAIN);
	FeatRemove(oPC, FEAT_WEB_OF_PURITY);
}


void main()
{
	// auto register all entering PC's
	// PC's don't have a tag, so they will all run scrip "t_"
	// it's up to that script to further determine what should be done based on the particular PC.
    object oPC = GetEnteringObject();
	//RegisterForTimeEvent(oPC);
 	PrettyDebug("k_mod_pc_loaded fired for " + GetName(oPC));
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
	
	string sAreaTag = GetTag(GetArea(oPC));		
	if (sAreaTag == "a00_lobby" || sAreaTag == "a01_lower_barrow")
	{
   		RemovePurificationPowers(oPC);	
		//Your OC feats have been removed for Mask of the Betrayer.
	}
	
	// clock is off by defualt and must be turned on initially.
	SetClockOnForPlayer(oPC, TRUE);
	
	if (_isSoZ)
	{
		int nTWFeatsAllowed = GetGlobalInt("00_nTWFeatsAllowed");

		if(nTWFeatsAllowed == 0)
		{	
			int nMaxLevel;
			object oFM = GetFirstFactionMember(oPC);
			
			while(GetIsObjectValid(oFM))
			{
				int nLevel = GetTotalLevels(oFM, FALSE);
				if(nLevel > nMaxLevel)
					nMaxLevel = nLevel;
				
				oFM = GetNextFactionMember(oPC);
			}
			
			nTWFeatsAllowed = 1 + ((nMaxLevel - 1) / 3);		//You get one feat at first level, plus one feat every 3 levels thereafter.
			SetGlobalInt("00_nTWFeatsAllowed", nTWFeatsAllowed);
		}	
	}
	
	if (!_isSoZ)
	{	
		// someone joined so update who spirit eater is.
		object oInitializedSpiritEater = UpdateWhoIsSpiritEater();
		if (oInitializedSpiritEater != oPC)
		{
			// we may still have this left over from leaving a previous game.
			RemoveSpiritEaterStatus(oPC);
		}
	}
	
		// move player to the party leader.
	object oLeader = GetFactionLeader(oPC);
	if (oLeader != oPC)
		AssignCommand(oPC, ActionJumpToObject(oLeader));


	ExecuteScript("gr_pc_spawn", oPC);
	ExecuteScript("ffmmr", oPC);  // Blessed of Waukeen
	ExecuteScript("bbcde", oPC);
	
		
//	SendMessageToPC(oPC,"cmi_pc_loaded script being called.");
	//ExecuteScript("cmi_pc_loaded",oPC);
	ExecuteScript("ccs_pc_loaded",oPC);
	//SpeakString("k_mod_pc_loaded:" ,TALKVOLUME_SHOUT);

	if (!GetOnePartyMode() && !GetIsSinglePlayer())
	{
		NotOnePartyModeWarning(oPC);
	}
}
//::///////////////////////////////////////////////
//:: General Include for SoZ
//:: cmi_ginc_SoZ
//:: Utility script for SoZ
//:: Created By: Kaedrin (Matt)
//:: Created On: Dec 1, 2008
//:://////////////////////////////////////////////


void RestoreClassEffects(object oPC)
{

	//This code is for SoZ and is meant ONLY to fix Septimund's spellcasting.
    object oPartyMember = GetFirstFactionMember(oPC, FALSE);
    while(GetIsObjectValid(oPartyMember) == TRUE)
    {
		ExecuteScript("cmi_pc_loaded", oPartyMember);
		ExecuteScript("cmi_player_equip", oPartyMember);	
        oPartyMember = GetNextFactionMember(oPC, TRUE);	
	}

}

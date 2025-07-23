// k_mod_player_unequip
/*
    Module unequip item script
    gets the tag of the item and calls:
    "i_<tag>_ue"
*/
// ChazM 3/1/05
// BMA-OEI 9/26/05 moved concat below string trim
// ChazM 10/20/05 - hook back in to the x2_mod_def* script

	
void main()
{
	ExecuteScript("x2_mod_def_unequ", OBJECT_SELF);

	object oPC = GetPCItemLastUnequippedBy();
	
	//SendMessageToPC(oPC,"cmi_player_unequip firing.");			
	ExecuteScript("ccs_player_unequip", oPC);
	//ExecuteScript("cmi_player_unequip", oPC);
/*
    object oItem = GetPCItemLastUnequipped();
    string sTag = GetTag(oItem);

    if (GetStringLength(sTag) > 11)
	{
        sTag = GetStringLeft(sTag, 11);
	}

    sTag = "i_" + sTag + "_ue";
    ExecuteScript(sTag, OBJECT_SELF);
*/
}
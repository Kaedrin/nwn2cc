#include "nwnx_character"

// return TRUE if input is valid
int IsHairInputValid(object pc, string id)
{
	int pc_race = GetRacialType(pc);
	int pc_subrace = GetSubRace(pc);
	string category = "ev_hair_";
	if (GetGender(pc) == GENDER_FEMALE) category += "f";
	else category += "m";
		
	if		(pc_race == RACIAL_TYPE_HUMAN) category += "human";
	else if (pc_race == RACIAL_TYPE_HALFORC) category += "halforc";
	else if (pc_race == RACIAL_TYPE_DWARF) category += "dwarf";
	else if (pc_race == RACIAL_TYPE_GNOME) category += "gnome";
	else if (pc_race == RACIAL_TYPE_HALFLING) category += "halfling";
	else if (pc_race == RACIAL_TYPE_HALFELF) category += "halfelf";
	else if (pc_race == RACIAL_TYPE_ELF) category += "elf";
	else if (pc_race == RACIAL_TYPE_GRAYORC) category += "grayorc";
	
	else if (pc_subrace == RACIAL_SUBTYPE_AASIMAR) category += "aasimar";
	else if (pc_subrace == RACIAL_SUBTYPE_AIR_GENASI) category += "airgenasi";
	else if (pc_subrace == RACIAL_SUBTYPE_EARTH_GENASI) category += "earthgenasi";
	else if (pc_subrace == RACIAL_SUBTYPE_FIRE_GENASI) category += "firegenasi";
	else if (pc_subrace == RACIAL_SUBTYPE_TIEFLING) category += "tiefling";
	else if (pc_subrace == RACIAL_SUBTYPE_WATER_GENASI) category += "watergenasi";
	else if (pc_subrace == RACIAL_SUBTYPE_YUANTI) category += "yuanti";
	
	else { return FALSE; }
	
	int i = 0;
	int total_options = GetNum2DARows(category);
	for (i = 0; i < total_options; i++) {
		if (Get2DAString(category,"HEAD_ID", i) == id) {
			return TRUE;
		}
	}
	return FALSE;
}

void main(string sCommand, string sArg1)
{	
	object oPC;
	if (sCommand == "sethair") {
		oPC = OBJECT_SELF;
		
		if (IsHairInputValid(oPC, sArg1) == FALSE) {
			SendMessageToPC(oPC, "Entered invalid hair ID.");
			return;
		}
		
		AssignCommand(GetModule(), SetHair(oPC, StringToInt(sArg1)));
		AssignCommand(GetModule(), DelayCommand( 1.0f, BootAndUpdateCharacter( oPC ) ));
	}
	
	else if (sCommand == "sethead") {
		oPC = OBJECT_SELF;
		AssignCommand(GetModule(), SetHead(oPC, StringToInt(sArg1)));
		AssignCommand(GetModule(), DelayCommand( 1.0f, BootAndUpdateCharacter( oPC ) ));
	}
	
	else if (sCommand == "show_hair_ui") {
		oPC = GetPCSpeaker();
		DisplayGuiScreen(oPC, "ev_change_hair", FALSE, "ev_change_hair.xml");
	}
	
	else if (sCommand == "show_head_ui") {
		oPC = GetPCSpeaker();
		DisplayGuiScreen(oPC, "ev_change_head", FALSE, "ev_change_head.xml");
	}
}
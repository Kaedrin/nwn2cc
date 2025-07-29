#include "x0_i0_position"
#include "ginc_param_const"

location GetLocationInFormation(int n, int nTotal, location lStartingLocation, string sRadiusSpacing = "")
{
	
	float fR = 15.0;
	if (sRadiusSpacing != "") fR = StringToFloat(sRadiusSpacing);
	
	float fAngle = (360.0 / nTotal) * n;
	return GenerateNewLocationFromLocation(lStartingLocation, fR, fAngle, fAngle - 180.0);
}


void main()
{
	object pc = GetLastUsedBy();
	location loc = GetLocation(OBJECT_SELF);
	
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
	
	else { SendMessageToPC(pc, "Race not supported."); return; }
	
	// if the category is already displaying, then there's nothing to do!
	if (GetLocalString(OBJECT_SELF, "ev_hair_category") == category) {
		SendMessageToPC(pc, "Already displaying available options.");
		return;	
	}
	
	SetLocalString(OBJECT_SELF, "ev_hair_category", category);
	
	// destroy previously created npcs by this lever
	object area = GetArea(OBJECT_SELF);
	object npc = GetFirstObjectInArea(area);
	while (npc != OBJECT_INVALID) {
		if (GetTag(npc) == "ev_hair_npc" + ObjectToString(OBJECT_SELF)) {
			DestroyObject(npc);
		}
		npc = GetNextObjectInArea(area);
	}
	
	int i = 0;
	int total_options = GetNum2DARows(category);
	SendMessageToPC(pc, "total options: " + IntToString(total_options));
	location next_loc;
	string head_id;
	for (i = 0; i < total_options; i++) {
		next_loc = GetLocationInFormation(i+1, total_options, loc);
		head_id = Get2DAString(category,"HEAD_ID", i);
		CreateObject(OBJECT_TYPE_CREATURE, category + head_id, next_loc, FALSE, "ev_hair_npc" + ObjectToString(OBJECT_SELF));
	}
}
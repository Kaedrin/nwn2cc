//::///////////////////////////////////////////////
//:: Chair Sitting Script v1.1
//:: Author: Razare
//:: NWN2:MotB Version 1.0.1153.0
//:://////////////////////////////////////////////
/*
	Script must be put on the OnUsed event of
	a chair. The chair must be set as follows:

	Static = False
	Usable? = True
	Default Action Preference = Use

	Stand some distance from the chair when
	you click on it, it tends to function
	better that way.  Sometimes you will sit
	crooked because the script doesn't finish
	turning you in the right direction, just
	try again if it looks silly.
	
	IMPORTANT:  Click on the chair ONCE and wait.
	
	Small Chair - Gnomes and Halflings
	Medium Chair - Dwarves
	Large Chair - Humans, Elves, Half-Elves, Half-Orcs, Aasimar, Tiefling, Half-Drow, and Genasi
*/
//:://////////////////////////////////////////////
//:: January 18, 2008
//:://////////////////////////////////////////////

#include "x0_i0_position"


int GetSize(int nRacialType, int nRacialSubType)
{
	int nSize = 3;

	if(nRacialType == RACIAL_TYPE_HUMAN)
	{ nSize = 3; }
	if(nRacialType == RACIAL_TYPE_ELF)
	{ nSize = 3; }
	if(nRacialType == RACIAL_TYPE_HALFELF)
	{ nSize = 3; }
	if(nRacialType == RACIAL_TYPE_HALFORC)
	{ nSize = 3; }
	if(nRacialSubType == RACIAL_SUBTYPE_TIEFLING)
	{ nSize = 3; }
	if(nRacialSubType == RACIAL_SUBTYPE_AASIMAR)
	{ nSize = 3; }
	if(nRacialSubType == RACIAL_SUBTYPE_AIR_GENASI)
	{ nSize = 3; }
	if(nRacialSubType == RACIAL_SUBTYPE_EARTH_GENASI)
	{ nSize = 3; }
	if(nRacialSubType == RACIAL_SUBTYPE_FIRE_GENASI)
	{ nSize = 3; }
	if(nRacialSubType == RACIAL_SUBTYPE_WATER_GENASI)
	{ nSize = 3; }
	if(nRacialSubType == RACIAL_SUBTYPE_EARTH_GENASI)
	{ nSize = 3; }
	if(nRacialType == RACIAL_TYPE_DWARF)
	{ nSize = 2; }
	if(nRacialType == RACIAL_TYPE_HALFLING)
	{ nSize = 1; }
	if(nRacialType == RACIAL_TYPE_GNOME)
	{ nSize = 1; }
		
	return nSize;	
}


void main()
{

	object oChair = OBJECT_SELF;
	object oUser = GetLastUsedBy();
	object oLastUser = GetLocalObject(oChair, "pl_lastuser");

	float fOtherDis = 0.0;
	float fOtherAgl = 0.0;	
	
	if( ((GetRacialType(oUser) == RACIAL_TYPE_HALFORC) && (GetGender(oUser) == GENDER_MALE)) || (GetRacialType(oUser) == RACIAL_TYPE_DWARF) || (GetSize(GetRacialType(oUser), GetSubRace(oUser)) == 1) )
	{
		fOtherDis = GetLocalFloat(oChair, "pl_hodisadj");
		fOtherAgl = GetLocalFloat(oChair, "pl_hoagladj");
	}

	if( GetSize(GetRacialType(oUser), GetSubRace(oUser)) == GetLocalInt(oChair, "pl_size") )	
	{
		if( ( GetArea(oLastUser) != GetArea(oChair) ) ||
		(GetDistanceBetween(oLastUser, oChair) >= 0.25) ||
		(oLastUser == oUser) )
		{
			AssignCommand(oUser, ActionMoveToLocation(Location(GetArea(oChair),GetChangedPosition(GetChangedPosition(GetPosition(oChair),GetLocalFloat(oChair, "pl_adjdis"),GetNormalizedDirection(GetFacing(oChair)+GetLocalFloat(oChair, "pl_adjagl")+GetLocalFloat(oChair,"pl_rotate"))),fOtherDis,GetNormalizedDirection(fOtherAgl+GetLocalFloat(oChair,"pl_rotate"))),0.0)));
			DelayCommand(1.5, AssignCommand(oUser, SetFacing( GetNormalizedDirection(GetFacing(oChair)+180.0+GetLocalFloat(oChair,"pl_rotate")) )));
			DelayCommand(2.5, ExecuteScript("pl_sitanimation", oUser));
			SetLocalObject(oChair, "pl_lastuser", oUser);
		}
	}
}
//:: OnUse: Sit
//:: pat_sitted_medium
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

    Simple script to make the creature using a
    placeable sit on it

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-18
//:: Modified By: Patcha
//:: Modified On: 2006-12-08
//:: v1.50 By: Patcha
//:: v1.50 On: 2006-12-15
//:://////////////////////////////////////////////

void main()
{
	object oChair = OBJECT_SELF;
	object oSitter = GetLastUsedBy();
	location lChair = GetLocation(oChair);
	float fFacing = GetFacingFromLocation(lChair);
	string sTag = GetTag(oChair);
	AssignCommand(oSitter,ClearAllActions());	
	lChair = Location(GetArea(oChair), GetPositionFromLocation(lChair), fFacing + 180.0);
	//float fBase = 1.0;
	float fSize = GetLocalFloat(oChair,"SCALE");
	//if(fSize == 0.0)
	//fSize = 1.0;
	//float fScale = fBase - fSize;
	
		
		
	
	if(	(((GetRacialType(oSitter) == RACIAL_TYPE_ELF) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM)) ||
		((GetRacialType(oSitter) == RACIAL_TYPE_HALFELF) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM)) ||
		((GetRacialType(oSitter) == RACIAL_TYPE_HALFORC) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM)) ||
		((GetRacialType(oSitter) == RACIAL_TYPE_HUMAN) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM)) ||
		((GetSubRace(oSitter) == RACIAL_SUBTYPE_AASIMAR) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM)) ||
		((GetSubRace(oSitter) == RACIAL_SUBTYPE_TIEFLING) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM))))
		{
		//DestroyObject(OBJECT_SELF);
	    //oChair = CreateObject(OBJECT_TYPE_PLACEABLE,"chairbig",lChair);
		//ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSetScale(1.0),oChair);
		if(fSize != 1.0)
		SetScale(oChair,1.0,1.0,1.0);
		SetLocalFloat(oChair,"SCALE",1.0);
		AssignCommand(oChair,SetFacing(fFacing));
		}

	    //Check for Character Race with original Creature Size
	if(	(((GetRacialType(oSitter) == RACIAL_TYPE_DWARF) && (GetCreatureSize(oSitter) == CREATURE_SIZE_MEDIUM)) ||
		((GetRacialType(oSitter) == RACIAL_TYPE_GNOME) && (GetCreatureSize(oSitter) == CREATURE_SIZE_SMALL)) ||
		((GetRacialType(oSitter) == RACIAL_TYPE_HALFLING) && (GetCreatureSize(oSitter) == CREATURE_SIZE_SMALL))))
	{
		//DestroyObject(OBJECT_SELF);
	   //oChair = CreateObject(OBJECT_TYPE_PLACEABLE,"chairsmall",lChair);
	   //ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSetScale(0.7),oChair);
	   if(fSize != 0.7)
	   SetScale(oChair,0.7,0.7,0.7);
	   SetLocalFloat(oChair,"SCALE",0.7);
		AssignCommand(oChair,SetFacing(fFacing));
	}	
		
			if(GetIsObjectValid(oChair) && GetIsObjectValid(oSitter))
		{
			AssignCommand(oSitter, ActionJumpToLocation(lChair));
			//AssignCommand(oSitter,PlayAnimation(ANIMATION_LOOPING_SIT_CHAIR));
			PlayCustomAnimation(oSitter, "sitidle", 1);

		}

}
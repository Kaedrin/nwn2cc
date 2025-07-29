
//RANDOM_GROUND_TRAP_LOCATION
//CreateTrapAtLocation
//GetIsTrapped
//GetNearestTrapToObject
//SetTrapDetectDC
//SetTrapOneShot


int GetRandomTrapType(int nTrap, object oSelf);

//This is to maintain compatibilty with Sir Elric's we where using -driller
int GetRandomTrapType(int nTrap, object oSelf)
{
   switch(nTrap)
   {
      case 1: nTrap = GetLocalInt(oSelf, "PRESET_TYPE");
              if(nTrap == 0 || nTrap > 11 )
                 nTrap = Random(11) + 1;
              switch(nTrap)// Minor
              {
                 case 1:  nTrap = TRAP_BASE_TYPE_MINOR_ACID;       return nTrap;
                 case 2:  nTrap = TRAP_BASE_TYPE_MINOR_ACID_SPLASH;return nTrap;
				 case 3:  nTrap = TRAP_BASE_TYPE_MINOR_TANGLE;     return nTrap;
                 case 4:  nTrap = TRAP_BASE_TYPE_MINOR_FIRE;       return nTrap;
                 case 5:  nTrap = TRAP_BASE_TYPE_MINOR_FROST;      return nTrap;
                 case 6:  nTrap = TRAP_BASE_TYPE_MINOR_GAS;        return nTrap;
                 case 7:  nTrap = TRAP_BASE_TYPE_MINOR_HOLY;       return nTrap;
                 case 8:  nTrap = TRAP_BASE_TYPE_MINOR_NEGATIVE;   return nTrap;
                 case 9:  nTrap = TRAP_BASE_TYPE_MINOR_SONIC;      return nTrap;
                 case 10: nTrap = TRAP_BASE_TYPE_MINOR_SPIKE;      return nTrap;
				 // Trap is to hard on noobs.. don't use it 
				 //case 11:  nTrap = TRAP_BASE_TYPE_MINOR_ELECTRICAL; return nTrap;
				 case 11:  nTrap = TRAP_BASE_TYPE_MINOR_TANGLE;     return nTrap;
			  }
			  
      case 2: nTrap = GetLocalInt(oSelf, "PRESET_TYPE");
              if(nTrap == 0 || nTrap > 11 )
                 nTrap = Random(11) + 1;
              switch(nTrap)// Average
              {
                 case 1: nTrap  = TRAP_BASE_TYPE_AVERAGE_ACID;       return nTrap;
                 case 2: nTrap  = TRAP_BASE_TYPE_AVERAGE_ACID_SPLASH;return nTrap;
				 /* Switch to minor version */
                 //case 3: nTrap  = TRAP_BASE_TYPE_AVERAGE_ELECTRICAL; return nTrap;
				 case 3: nTrap  = TRAP_BASE_TYPE_MINOR_ELECTRICAL;   return nTrap;
                 case 4: nTrap  = TRAP_BASE_TYPE_AVERAGE_FIRE;       return nTrap;
                 case 5: nTrap  = TRAP_BASE_TYPE_AVERAGE_FROST;      return nTrap;
                 case 6: nTrap  = TRAP_BASE_TYPE_AVERAGE_GAS;        return nTrap;
                 case 7: nTrap  = TRAP_BASE_TYPE_AVERAGE_HOLY;       return nTrap;
                 case 8: nTrap  = TRAP_BASE_TYPE_AVERAGE_NEGATIVE;   return nTrap;
                 case 9: nTrap  = TRAP_BASE_TYPE_AVERAGE_SONIC;      return nTrap;
                 case 10: nTrap = TRAP_BASE_TYPE_AVERAGE_SPIKE;      return nTrap;
                 case 11: nTrap = TRAP_BASE_TYPE_AVERAGE_TANGLE;     return nTrap;
              }
      case 3 : nTrap = GetLocalInt(oSelf, "PRESET_TYPE");
              if(nTrap == 0 || nTrap > 11 )
                 nTrap = Random(11) + 1;
              switch(nTrap)// Strong
              {
                 case 1: nTrap  = TRAP_BASE_TYPE_STRONG_ACID;       return nTrap;
                 case 2: nTrap  = TRAP_BASE_TYPE_STRONG_ACID_SPLASH;return nTrap;
                 case 3: nTrap  = TRAP_BASE_TYPE_STRONG_ELECTRICAL; return nTrap;
                 case 4: nTrap  = TRAP_BASE_TYPE_STRONG_FIRE;       return nTrap;
                 case 5: nTrap  = TRAP_BASE_TYPE_STRONG_FROST;      return nTrap;
                 case 6: nTrap  = TRAP_BASE_TYPE_STRONG_GAS;        return nTrap;
                 case 7: nTrap  = TRAP_BASE_TYPE_STRONG_HOLY;       return nTrap;
                 case 8: nTrap  = TRAP_BASE_TYPE_STRONG_NEGATIVE;   return nTrap;
                 case 9: nTrap  = TRAP_BASE_TYPE_STRONG_SONIC;      return nTrap;
                 case 10: nTrap = TRAP_BASE_TYPE_STRONG_SPIKE;      return nTrap;
                 case 11: nTrap = TRAP_BASE_TYPE_STRONG_TANGLE;     return nTrap;
              }
      case 4: nTrap = GetLocalInt(oSelf, "PRESET_TYPE");
              if(nTrap == 0 || nTrap > 11 )
                 nTrap = Random(11) + 1;
              switch(nTrap)// Deadly
              {
                 case 1: nTrap  = TRAP_BASE_TYPE_DEADLY_ACID;       return nTrap;
                 case 2: nTrap  = TRAP_BASE_TYPE_DEADLY_ACID_SPLASH;return nTrap;
                 case 3: nTrap  = TRAP_BASE_TYPE_DEADLY_ELECTRICAL; return nTrap;
                 case 4: nTrap  = TRAP_BASE_TYPE_DEADLY_FIRE;       return nTrap;
                 case 5: nTrap  = TRAP_BASE_TYPE_DEADLY_FROST;      return nTrap;
                 case 6: nTrap  = TRAP_BASE_TYPE_DEADLY_GAS;        return nTrap;
                 case 7: nTrap  = TRAP_BASE_TYPE_DEADLY_HOLY;       return nTrap;
                 case 8: nTrap  = TRAP_BASE_TYPE_DEADLY_NEGATIVE;   return nTrap;
                 case 9: nTrap  = TRAP_BASE_TYPE_DEADLY_SONIC;      return nTrap;
                 case 10: nTrap = TRAP_BASE_TYPE_DEADLY_SPIKE;      return nTrap;
                 case 11: nTrap = TRAP_BASE_TYPE_DEADLY_TANGLE;     return nTrap;
              }
      case 5: nTrap = GetLocalInt(oSelf, "PRESET_TYPE");
              if(nTrap == 0 || nTrap > 4 )
                 nTrap = Random(6) + 1;
              switch(nTrap)// Epic
              {
                 case 1: nTrap = TRAP_BASE_TYPE_EPIC_ELECTRICAL;return nTrap;
                 case 2: nTrap = TRAP_BASE_TYPE_EPIC_FIRE;      return nTrap;
                 case 3: nTrap = TRAP_BASE_TYPE_EPIC_FROST;     return nTrap;
                 case 4: nTrap = TRAP_BASE_TYPE_EPIC_SONIC;     return nTrap;
				 case 5: nTrap = TRAP_BASE_TYPE_DEADLY_HOLY;    return nTrap;
				 case 6: nTrap = TRAP_BASE_TYPE_DEADLY_NEGATIVE;return nTrap;
              }
    }
     return TRAP_BASE_TYPE_MINOR_SPIKE; // Fail safe


}

void TrapObject(object oObject, int i, int iGroundTrap)
{
	object oArea = GetArea(oObject);
	object oNearest = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oObject);
	object oTrap;
	
	int nDiff = GetLocalInt(oArea,"TRAP_DIFF");
	if(nDiff == 0)	nDiff = 1;
	if(nDiff > 5)	nDiff = 5;
	
	/* Check if a PC is nearby.. don't set it if there is */
	if(GetIsPC(oNearest))
	{
		int distance = FloatToInt(GetDistanceBetween(oNearest, oObject));
		if(distance<15){
			//SendMessageToPC(GetFirstPC(),"Player to Close ");
			return;
		}
	}



	if(iGroundTrap>0){
		oTrap = CreateTrapAtLocation(GetRandomTrapType(nDiff,oObject),GetLocation(oObject));
		SetLocalObject(oArea,"TRAP_"+IntToString(i),oTrap);
		//SendMessageToPC(GetFirstPC(),"Create Ground Trap ");
	}
	else
	{
		CreateTrapOnObject(GetRandomTrapType(nDiff,oObject),oObject);	
		oTrap = oObject;
		//SendMessageToPC(GetFirstPC(),"Create Door Trap ");
	}
	SetLocalInt(oTrap,"dr_trap_area",1);
	
	/* For noob level 1 traps, set the DC's */
	if(nDiff==1)
	{
		SetTrapDisarmDC(oTrap, 10 + Random(10)); // 10 - 19
	    SetTrapDetectDC(oTrap, 10 + Random(10)); // 10 - 19
	}
	
	if(d10()<6)
		SetTrapRecoverable(oTrap, FALSE);
	else
		SetTrapRecoverable(oTrap, TRUE);
}

void SetTraps(object oArea)
{
	object oObject = GetFirstObjectInArea(oArea);
	int i;

	while(GetIsObjectValid(oObject))
	{
		//SendMessageToPC(GetFirstPC(),"Object name "+GetName(oObject));
		//SendMessageToPC(GetFirstPC(),"Object type: "+IntToString(GetObjectType(oObject)));
		
		//Clean out the old traps, if any.
		//Only clean out tagged traps...otherwise it clears out chest traps
		//which run on a different system.
		if(GetLocalInt(oObject,"dr_trap_area")>0)
		{
			SetTrapDisabled(oObject);
			SetLocalInt(oObject,"dr_trap_area",0);
			//SendMessageToPC(GetFirstPC(),"Disable Trap ");
		}

	
		/* Only trap doors.. do not trap chests or other objects */
		//if(GetObjectType(oObject) == OBJECT_TYPE_DOOR )
		//{
			//SendMessageToPC(GetFirstPC(),"Useable object found");
		//	if(d8() == 1)//1 in 8 chance of being trapped
		//	{
		//		TrapObject(oObject,0, 0);
				/* Shut the door if it's being placed on a door */
		//		if(GetObjectType(oObject) == OBJECT_TYPE_DOOR)
		//			ActionCloseDoor(oObject);
		//	}
		//}
		/* Trap the waypoint used for traps */
		if( (GetTag(oObject) == "RANDOM_GROUND_TRAP_LOCATION")
		 && (d8() == 1))//1 in 8 chance of being trapped)
		{
			i += 1;
			SetLocalObject(oArea,"TRAP_WP_"+IntToString(i),oObject);
		}
		oObject = GetNextObjectInArea(oArea);
	}
	
	//SetLocalInt(oArea,"TRAP_COUNT",i);
	int j;
	object oTrap;
	for(j=1;j<=i;j++)
	{
		oTrap = GetLocalObject(oArea,"TRAP_WP_"+IntToString(j));
		TrapObject(oTrap,j, 1);
	}
}

void main()
{
	object oArea = GetArea(OBJECT_SELF);
	int i = GetLocalInt(oArea,"TRAPPED");
	
	if(i == 0){
		SetTraps(oArea);
		/* Set some initial random start value so all widgets don't re-spawn at the same time */
		SetLocalInt(oArea,"TRAPPED",Random(10));
	}
	
	//50 is 5 minutes
	if(i < 160)			//16 minutes - random time taken off above which can be 6-60 seconds.
	{
		i += 1;
		SetLocalInt(oArea,"TRAPPED",i);
		return;
	}
	else
		SetLocalInt(oArea,"TRAPPED",0);
	
	//SendMessageToPC(GetFirstPC(),"Setting up traps");

}
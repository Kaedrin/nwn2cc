int StartingConditional()
{
	object oPC = GetPCSpeaker();
		
	//grab sub race
	int iSubRace = GetSubRace(oPC);
  
    // see whether they should be sent to location or not
    switch (iSubRace)
    {
	   case RACIAL_SUBTYPE_HUMAN: return TRUE;
       case RACIAL_SUBTYPE_HALFELF: return TRUE;
	   
	   case RACIAL_SUBTYPE_MOON_ELF: return TRUE;
	   case RACIAL_SUBTYPE_SUN_ELF: return TRUE;
	   case RACIAL_SUBTYPE_WOOD_ELF: return TRUE;   
	   case RACIAL_SUBTYPE_WILD_ELF: return TRUE;
	   
	   case 67: return TRUE;	//Star Elf
	   case 68: return TRUE;	//Painted Elf
	   
	   case RACIAL_SUBTYPE_STRONGHEART_HALF: return TRUE;   
	   case RACIAL_SUBTYPE_LIGHTFOOT_HALF: return TRUE;
	   
	   case RACIAL_SUBTYPE_ROCK_GNOME: return TRUE;
	   
	   case RACIAL_SUBTYPE_HALFORC: return TRUE;
	   
	   case RACIAL_SUBTYPE_SHIELD_DWARF: return TRUE;
	   case RACIAL_SUBTYPE_GOLD_DWARF: return TRUE;
	
       case RACIAL_SUBTYPE_AASIMAR: return TRUE;
       case RACIAL_SUBTYPE_TIEFLING: return TRUE;
	   
	   case RACIAL_SUBTYPE_AIR_GENASI: return TRUE;
	   case RACIAL_SUBTYPE_EARTH_GENASI: return TRUE;
	   case RACIAL_SUBTYPE_FIRE_GENASI: return TRUE;
	   case RACIAL_SUBTYPE_WATER_GENASI: return TRUE;
	   
       case RACIAL_SUBTYPE_GRAY_DWARF: return FALSE;
	   
       case RACIAL_SUBTYPE_DROW: return FALSE;
	   case RACIAL_SUBTYPE_HALFDROW: return FALSE;
	   
       case RACIAL_SUBTYPE_SVIRFNEBLIN: return TRUE;
	   
	   case RACIAL_SUBTYPE_YUANTI: return TRUE;
	   case RACIAL_SUBTYPE_GRAYORC: return TRUE;
       default:  return FALSE;
    }
	return FALSE;
}
	
#include "cmi_includes"	

int UsePaladinFullCaster()
{

	int nPaladinFullCaster = GetLocalInt(GetModule(), "PaladinFullCaster");
	return nPaladinFullCaster;
}

int UseRangerFullCaster()
{

	int nRangerFullCaster = GetLocalInt(GetModule(), "RangerFullCaster");
	return nRangerFullCaster;
}

int GetCasterLevelForRangers(object oCaster = OBJECT_SELF)
{

	int nRangerCaster = 	GetLastSpellCastClass();
	int nCasterLevel = 0;
	nCasterLevel = GetCasterLevel(oCaster);	
	//SendMessageToPC(GetFirstPC(),IntToString(nCasterLevel));
	if (nRangerCaster != CLASS_TYPE_RANGER) // Not a Ranger
	{
		return nCasterLevel;		
	}
	else // Use full caster level for Rangers
	{
	
		int nFullCaster = UseRangerFullCaster();
		if (nFullCaster)
		{
			int nRanger = GetLevelByClass(CLASS_TYPE_RANGER, oCaster);
			
			//Begin Ugly Fix till the new caster level function is done
			if (GetHasFeat(FEAT_NATWAR_SPELLCASTING_RANGER, oCaster))
			{
				nRanger += GetLevelByClass(CLASS_NATURES_WARRIOR, oCaster)/2;
			}
			if (GetHasFeat(FEAT_DSHAPE_SPELLCASTING_RANGER, oCaster))
			{
				nRanger += GetLevelByClass(CLASS_DAGGERSPELL_SHAPER, oCaster) - 1;
			}
		    if (GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_CHILD_NIGHT, oCaster) - 1;
		    }	
		    if (GetHasFeat(FEAT_SWRDNCR_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_SWORD_DANCER, oCaster);
		    }						
		    if (GetHasFeat(FEAT_DRSLR_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += (GetLevelByClass(CLASS_DRAGONSLAYER, oCaster) + 1 ) / 2;
		    }	
		    if (GetHasFeat(FEAT_ELDDISC_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_ELDRITCH_DISCIPLE, oCaster);
		    }
		    if (GetHasFeat(FEAT_KOT_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_KNIGHT_TIERDRIAL, oCaster);
		    }	
		    if (GetHasFeat(FEAT_SHDWSTLKR_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += (GetLevelByClass(CLASS_SHADOWBANE_STALKER, oCaster) + 1) * 3/4;
		    }			
		    if (GetHasFeat(FEAT_FROSTMAGE_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_FROST_MAGE, oCaster);
		    }	
		    if (GetHasFeat(FEAT_CANAITH_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_CANAITH_LYRIST, oCaster);
		    }							
		    if (GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_HEARTWARDER, oCaster);
		    }			
		    if (GetHasFeat(FEAT_FOREST_MASTER_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += (GetLevelByClass(CLASS_FOREST_MASTER, oCaster) + 1) * 3/4;
		    }				
		    if (GetHasFeat(FEAT_MASTER_RADIANCE_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_MASTER_RADIANCE, oCaster) - 1;
		    }				
		    if (GetHasFeat(FEAT_LION_TALISID_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_LION_TALISID, oCaster);
		    }				
		    if (GetHasFeat(FEAT_STORMSINGER_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_STORMSINGER, oCaster);
		    }			
		    if (GetHasFeat(FEAT_BFZ_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_BLACK_FLAME_ZEALOT, oCaster) / 2;
		    }				
			if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_RANGER, oCaster))
		    {
				int nLevel = GetLevelByClass(CLASS_HOSPITALER, oCaster);
		        nRanger += GetPrestigeCasterLevelByClassLevel(CLASS_HOSPITALER, nLevel, oCaster);
		    }		
		    if (GetHasFeat(FEAT_SHINING_BLADE_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_SHINING_BLADE, oCaster) / 2;
		    }			
		    if (GetHasFeat(1552, oCaster)) //sacred fist
		    {
		        nRanger += (GetLevelByClass(CLASS_TYPE_SACREDFIST, oCaster) + 1) * 3/4;
		    }
		    if (GetHasFeat(1583, oCaster)) //harper
		    {
		        nRanger += GetLevelByClass(CLASS_TYPE_HARPER, oCaster) - 1;
		    }
		    if (GetHasFeat(1811, oCaster)) //warpriest
		    {
		        nRanger += GetLevelByClass(CLASS_TYPE_WARPRIEST, oCaster) / 2;
		    }
		    if (GetHasFeat(2036, oCaster)) //stormlord
		    {
		        nRanger += GetLevelByClass(CLASS_TYPE_STORMLORD, oCaster);
		    }
		    if (GetHasFeat(2254, oCaster)) //doomguide
		    {
		        nRanger += GetLevelByClass(60, oCaster);
		    }			
			//FEAT_KNIWILD_SPELLCASTING_RANGER
		    if (GetHasFeat(FEAT_KNIWILD_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_KNIGHT_WILD, oCaster);
		    }				
			//FEAT_MYSTRESV_SPELLCASTING_RANGER	
		    if (GetHasFeat(FEAT_MYSTRESV_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_MYSTIC_RESV, oCaster);
		    }			
			//CLASS_MARKSMAN	
		    if (GetHasFeat(FEAT_MARKSMAN_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_MARKSMAN, oCaster);
		    }		
			//FEAT_BEASTHA_SPELLCASTING_RANGER				
		    if (GetHasFeat(FEAT_BEASTHA_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_BEASTHEARTADEPT, oCaster);
		    }
			//FEAT_ARBALEST_SPELLCASTING_RANGER				
		    if (GetHasFeat(FEAT_ARBALEST_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_ARBALEST, oCaster);
		    }					
					
			//End Ugly Fix
			
			if (nFullCaster == 2)
				nRanger = nRanger - 3;
			
			int nHD = GetHitDice(oCaster);	
			if (nHD > nRanger)
			{
				if (GetHasFeat(FEAT_PRACTICED_SPELLCASTER_RANGER, oCaster))
					nRanger = nRanger + 4;
				if (nRanger > nHD)
					nRanger = nHD;
					
				return nRanger;
				
			}
			else
				return nHD; // Full Paladin	
		}
		else return nCasterLevel;
		
	}

}

int GetRawRangerCasterLevel(object oCaster = OBJECT_SELF)
{
		int nFullCaster = UseRangerFullCaster();
			int nRanger = GetLevelByClass(CLASS_TYPE_RANGER, oCaster);
			if (nRanger == 0)
				return 0;
			
			//Begin Ugly Fix till the new caster level function is done
			if (GetHasFeat(FEAT_NATWAR_SPELLCASTING_RANGER, oCaster))
			{
				nRanger += GetLevelByClass(CLASS_NATURES_WARRIOR, oCaster)/2;
			}
			if (GetHasFeat(FEAT_DSHAPE_SPELLCASTING_RANGER, oCaster))
			{
				nRanger += GetLevelByClass(CLASS_DAGGERSPELL_SHAPER, oCaster) - 1;
			}
		    if (GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_CHILD_NIGHT, oCaster) - 1;
		    }	
		    if (GetHasFeat(FEAT_SWRDNCR_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_SWORD_DANCER, oCaster);
		    }						
		    if (GetHasFeat(FEAT_DRSLR_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += (GetLevelByClass(CLASS_DRAGONSLAYER, oCaster) + 1 ) / 2;
		    }	
		    if (GetHasFeat(FEAT_ELDDISC_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_ELDRITCH_DISCIPLE, oCaster);
		    }
		    if (GetHasFeat(FEAT_KOT_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_KNIGHT_TIERDRIAL, oCaster);
		    }	
		    if (GetHasFeat(FEAT_SHDWSTLKR_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += (GetLevelByClass(CLASS_SHADOWBANE_STALKER, oCaster) + 1) * 3/4;
		    }			
		    if (GetHasFeat(FEAT_FROSTMAGE_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_FROST_MAGE, oCaster);
		    }	
		    if (GetHasFeat(FEAT_CANAITH_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_CANAITH_LYRIST, oCaster);
		    }							
		    if (GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_HEARTWARDER, oCaster);
		    }			
		    if (GetHasFeat(FEAT_FOREST_MASTER_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += (GetLevelByClass(CLASS_FOREST_MASTER, oCaster) + 1) * 3/4;
		    }				
		    if (GetHasFeat(FEAT_MASTER_RADIANCE_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_MASTER_RADIANCE, oCaster) - 1;
		    }				
		    if (GetHasFeat(FEAT_LION_TALISID_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_LION_TALISID, oCaster);
		    }				
		    if (GetHasFeat(FEAT_STORMSINGER_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_STORMSINGER, oCaster);
		    }			
		    if (GetHasFeat(FEAT_BFZ_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_BLACK_FLAME_ZEALOT, oCaster) / 2;
		    }				
			if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_RANGER, oCaster))
		    {
				int nLevel = GetLevelByClass(CLASS_HOSPITALER, oCaster);
		        nRanger += GetPrestigeCasterLevelByClassLevel(CLASS_HOSPITALER, nLevel, oCaster);
		    }		
		    if (GetHasFeat(FEAT_SHINING_BLADE_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_SHINING_BLADE, oCaster) / 2;
		    }			
		    if (GetHasFeat(1552, oCaster)) //sacred fist
		    {
		        nRanger += (GetLevelByClass(CLASS_TYPE_SACREDFIST, oCaster) + 1) * 3/4;
		    }
		    if (GetHasFeat(1583, oCaster)) //harper
		    {
		        nRanger += GetLevelByClass(CLASS_TYPE_HARPER, oCaster) - 1;
		    }
		    if (GetHasFeat(1811, oCaster)) //warpriest
		    {
		        nRanger += GetLevelByClass(CLASS_TYPE_WARPRIEST, oCaster) / 2;
		    }
		    if (GetHasFeat(2036, oCaster)) //stormlord
		    {
		        nRanger += GetLevelByClass(CLASS_TYPE_STORMLORD, oCaster);
		    }
		    if (GetHasFeat(2254, oCaster)) //doomguide
		    {
		        nRanger += GetLevelByClass(60, oCaster);
		    }			
			//FEAT_KNIWILD_SPELLCASTING_RANGER
		    if (GetHasFeat(FEAT_KNIWILD_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_KNIGHT_WILD, oCaster);
		    }				
			//FEAT_MYSTRESV_SPELLCASTING_RANGER	
		    if (GetHasFeat(FEAT_MYSTRESV_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_MYSTIC_RESV, oCaster);
		    }			
			//CLASS_MARKSMAN	
		    if (GetHasFeat(FEAT_MARKSMAN_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_MARKSMAN, oCaster);
		    }				
			//FEAT_BEASTHA_SPELLCASTING_RANGER				
		    if (GetHasFeat(FEAT_BEASTHA_SPELLCASTING_RANGER, oCaster))
		    {
		        nRanger += GetLevelByClass(CLASS_BEASTHEARTADEPT, oCaster);
		    }		
								
			//End Ugly Fix
			
			if (!nFullCaster)
				nRanger = (nRanger - (GetLevelByClass(CLASS_TYPE_RANGER, oCaster) / 2));
			
			if (nFullCaster == 2)
				nRanger = nRanger - 3;	
				
			int nHD = GetHitDice(oCaster);	
			if (nHD > nRanger)
			{
				if (GetHasFeat(FEAT_PRACTICED_SPELLCASTER_RANGER, oCaster))
					nRanger = nRanger + 4;
				if (nRanger > nHD)
					nRanger = nHD;
					
				return nRanger;
				
			}
			else
				return nHD; // Full Paladin	
}

int GetRawPaladinCasterLevel(object oCaster = OBJECT_SELF)
{
		int nFullCaster = UsePaladinFullCaster();
			int nPaladin = GetLevelByClass(CLASS_TYPE_PALADIN, oCaster);
			if (nPaladin == 0)
				return 0;
			
			//Begin Ugly Fix till the new caster level function is done
			if (GetHasFeat(FEAT_DSHAPE_SPELLCASTING_PALADIN, oCaster))
			{
				nPaladin += GetLevelByClass(CLASS_DAGGERSPELL_SHAPER, oCaster) - 1;
			}
		    if (GetHasFeat(FEAT_COTSF_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_CHAMP_SILVER_FLAME, oCaster);
		    }	
		    if (GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_CHILD_NIGHT, oCaster) - 1;
		    }	
		    if (GetHasFeat(FEAT_SWRDNCR_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_SWORD_DANCER, oCaster);
		    }						
		    if (GetHasFeat(FEAT_DRSLR_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += (GetLevelByClass(CLASS_DRAGONSLAYER, oCaster) + 1 ) / 2;
		    }	
		    if (GetHasFeat(FEAT_ELDDISC_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_ELDRITCH_DISCIPLE, oCaster);
		    }
		    if (GetHasFeat(FEAT_KOT_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_KNIGHT_TIERDRIAL, oCaster);
		    }	
		    if (GetHasFeat(FEAT_SHDWSTLKR_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += (GetLevelByClass(CLASS_SHADOWBANE_STALKER, oCaster) + 1) * 3/4;
		    }			
		    if (GetHasFeat(FEAT_FROSTMAGE_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_FROST_MAGE, oCaster);
		    }	
		    if (GetHasFeat(FEAT_CANAITH_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_CANAITH_LYRIST, oCaster);
		    }							
		    if (GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_HEARTWARDER, oCaster);
		    }			
		    if (GetHasFeat(FEAT_FOREST_MASTER_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += (GetLevelByClass(CLASS_FOREST_MASTER, oCaster) + 1) * 3/4;
		    }				
		    if (GetHasFeat(FEAT_MASTER_RADIANCE_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_MASTER_RADIANCE, oCaster) - 1;
		    }				
		    if (GetHasFeat(FEAT_LION_TALISID_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_LION_TALISID, oCaster);
		    }				
		    if (GetHasFeat(FEAT_STORMSINGER_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_STORMSINGER, oCaster);
		    }			
		    if (GetHasFeat(FEAT_BFZ_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_BLACK_FLAME_ZEALOT, oCaster) / 2;
		    }				
			if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_PALADIN, oCaster))
		    {
				int nLevel = GetLevelByClass(CLASS_HOSPITALER, oCaster);
		        nPaladin += GetPrestigeCasterLevelByClassLevel(CLASS_HOSPITALER, nLevel, oCaster);
		    }		
		    if (GetHasFeat(FEAT_SHINING_BLADE_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_SHINING_BLADE, oCaster) / 2;
		    }			
		    if (GetHasFeat(1551, oCaster)) //sacred fist
		    {
		        nPaladin += (GetLevelByClass(CLASS_TYPE_SACREDFIST, oCaster) + 1) * 3/4;
		    }
		    if (GetHasFeat(1582, oCaster)) //harper
		    {
		        nPaladin += GetLevelByClass(CLASS_TYPE_HARPER, oCaster) - 1;
		    }
		    if (GetHasFeat(1810, oCaster)) //warpriest
		    {
		        nPaladin += GetLevelByClass(CLASS_TYPE_WARPRIEST, oCaster) / 2;
		    }
		    if (GetHasFeat(2035, oCaster)) //stormlord
		    {
		        nPaladin += GetLevelByClass(CLASS_TYPE_STORMLORD, oCaster);
		    }
		    if (GetHasFeat(2250, oCaster)) //doomguide
		    {
		        nPaladin += GetLevelByClass(60, oCaster);
		    }		
			//FEAT_KNIWILD_SPELLCASTING_PALADIN
		    if (GetHasFeat(FEAT_KNIWILD_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_KNIGHT_WILD, oCaster);
		    }				
			//FEAT_MYSTRESV_SPELLCASTING_PALADIN	
		    if (GetHasFeat(FEAT_MYSTRESV_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_MYSTIC_RESV, oCaster);
		    }			
			//CLASS_TEMPLAR	
		    if (GetHasFeat(FEAT_TEMPLAR_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_TEMPLAR, oCaster);
		    }								
					
			//End Ugly Fix
			
			if (nFullCaster == 2)
				nPaladin = nPaladin - 3;
			
			if (!nFullCaster)
			nPaladin = (nPaladin - (GetLevelByClass(CLASS_TYPE_PALADIN, oCaster) / 2));
			
			int nHD = GetHitDice(oCaster);	
			if (nHD > nPaladin)
			{
				if (GetHasFeat(FEAT_PRACTICED_SPELLCASTER_PALADIN, oCaster))
					nPaladin = nPaladin + 4;
				if (nPaladin > nHD)
					nPaladin = nHD;
			}				
			
			return nPaladin;
}

int GetCasterLevelForPaladins(object oCaster = OBJECT_SELF)
{

	int nPaladinCaster = 	GetLastSpellCastClass();
	int nCasterLevel = 0;
	nCasterLevel = GetCasterLevel(oCaster);	
	//SendMessageToPC(GetFirstPC(),IntToString(nCasterLevel));
	if (nPaladinCaster != CLASS_TYPE_PALADIN) // Not a Paladin
	{
		return nCasterLevel;		
	}
	else // Use full caster level for Paladins
	{
	
		int nFullCaster = UsePaladinFullCaster();
		if (nFullCaster)
		{
			int nPaladin = GetLevelByClass(CLASS_TYPE_PALADIN, oCaster);
			
			//Begin Ugly Fix till the new caster level function is done
			if (GetHasFeat(FEAT_DSHAPE_SPELLCASTING_PALADIN, oCaster))
			{
				nPaladin += GetLevelByClass(CLASS_DAGGERSPELL_SHAPER, oCaster) - 1;
			}
		    if (GetHasFeat(FEAT_COTSF_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_CHAMP_SILVER_FLAME, oCaster);
		    }	
		    if (GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_CHILD_NIGHT, oCaster) - 1;
		    }	
		    if (GetHasFeat(FEAT_SWRDNCR_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_SWORD_DANCER, oCaster);
		    }						
		    if (GetHasFeat(FEAT_DRSLR_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += (GetLevelByClass(CLASS_DRAGONSLAYER, oCaster) + 1 ) / 2;
		    }	
		    if (GetHasFeat(FEAT_ELDDISC_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_ELDRITCH_DISCIPLE, oCaster);
		    }
		    if (GetHasFeat(FEAT_KOT_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_KNIGHT_TIERDRIAL, oCaster);
		    }	
		    if (GetHasFeat(FEAT_SHDWSTLKR_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += (GetLevelByClass(CLASS_SHADOWBANE_STALKER, oCaster) + 1) * 3/4;
		    }			
		    if (GetHasFeat(FEAT_FROSTMAGE_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_FROST_MAGE, oCaster);
		    }	
		    if (GetHasFeat(FEAT_CANAITH_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_CANAITH_LYRIST, oCaster);
		    }							
		    if (GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_HEARTWARDER, oCaster);
		    }			
		    if (GetHasFeat(FEAT_FOREST_MASTER_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += (GetLevelByClass(CLASS_FOREST_MASTER, oCaster) + 1) * 3/4;
		    }				
		    if (GetHasFeat(FEAT_MASTER_RADIANCE_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_MASTER_RADIANCE, oCaster) - 1;
		    }				
		    if (GetHasFeat(FEAT_LION_TALISID_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_LION_TALISID, oCaster);
		    }				
		    if (GetHasFeat(FEAT_STORMSINGER_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_STORMSINGER, oCaster);
		    }			
		    if (GetHasFeat(FEAT_BFZ_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_BLACK_FLAME_ZEALOT, oCaster) / 2;
		    }				
			if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_PALADIN, oCaster))
		    {
				int nLevel = GetLevelByClass(CLASS_HOSPITALER, oCaster);
		        nPaladin += GetPrestigeCasterLevelByClassLevel(CLASS_HOSPITALER, nLevel, oCaster);
		    }		
		    if (GetHasFeat(FEAT_SHINING_BLADE_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_SHINING_BLADE, oCaster) / 2;
		    }			
		    if (GetHasFeat(1551, oCaster)) //sacred fist
		    {
		        nPaladin += (GetLevelByClass(CLASS_TYPE_SACREDFIST, oCaster) + 1) * 3/4;
		    }
		    if (GetHasFeat(1582, oCaster)) //harper
		    {
		        nPaladin += GetLevelByClass(CLASS_TYPE_HARPER, oCaster) - 1;
		    }
		    if (GetHasFeat(1810, oCaster)) //warpriest
		    {
		        nPaladin += GetLevelByClass(CLASS_TYPE_WARPRIEST, oCaster) / 2;
		    }
		    if (GetHasFeat(2035, oCaster)) //stormlord
		    {
		        nPaladin += GetLevelByClass(CLASS_TYPE_STORMLORD, oCaster);
		    }
		    if (GetHasFeat(2250, oCaster)) //doomguide
		    {
		        nPaladin += GetLevelByClass(60, oCaster);
		    }			
			//FEAT_KNIWILD_SPELLCASTING_PALADIN
		    if (GetHasFeat(FEAT_KNIWILD_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_KNIGHT_WILD, oCaster);
		    }				
			//FEAT_MYSTRESV_SPELLCASTING_PALADIN	
		    if (GetHasFeat(FEAT_MYSTRESV_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_MYSTIC_RESV, oCaster);
		    }			
			//CLASS_TEMPLAR	
		    if (GetHasFeat(FEAT_TEMPLAR_SPELLCASTING_PALADIN, oCaster))
		    {
		        nPaladin += GetLevelByClass(CLASS_TEMPLAR, oCaster);
		    }						
			//End Ugly Fix
					
			if (nFullCaster == 2)
				nPaladin = nPaladin - 3;			
			
			int nHD = GetHitDice(oCaster);	
			if (nHD > nPaladin)
			{
				if (GetHasFeat(FEAT_PRACTICED_SPELLCASTER_PALADIN, oCaster))
					nPaladin = nPaladin + 4;
				if (nPaladin > nHD)
					nPaladin = nHD;
					
				return nPaladin;
				
			}
			else
				return nHD; // Full Paladin	
		}
		else return nCasterLevel;
		
	}

}

int GetPalRngCasterLevel(object oCaster = OBJECT_SELF)
{
	int nLastCastingClass = GetLastSpellCastClass();
	int nCasterLevel = GetHitDice(oCaster);
	if (nLastCastingClass == CLASS_TYPE_PALADIN)
	{
		nCasterLevel = GetCasterLevelForPaladins(oCaster);
	}
	else	
	if (nLastCastingClass == CLASS_TYPE_RANGER)
	{
		nCasterLevel = GetCasterLevelForRangers(oCaster);
	}
	else
		nCasterLevel = GetCasterLevel(oCaster);
	return nCasterLevel;
	
}

int IsTgtPalRngFullCaster(object oTarget)
{
	//For speed, only assess players
	if (!GetIsPC(oTarget))
		return FALSE;
		
	int nPal = GetRawPaladinCasterLevel(oTarget);
	int nRng = GetRawRangerCasterLevel(oTarget);
	int nCL = 0;
	if (nPal > 0 || nRng > 0)
	{
		if (nPal > nRng)
			nCL = nPal;
		else
			nCL = nRng;
	}	
	else
		return FALSE;
	int nHD = GetHitDice(oTarget);						
	float fRatio = IntToFloat(nHD)/IntToFloat(nCL);			
	if (fRatio >= 0.75f)
		return TRUE;
	else
		return FALSE;
}
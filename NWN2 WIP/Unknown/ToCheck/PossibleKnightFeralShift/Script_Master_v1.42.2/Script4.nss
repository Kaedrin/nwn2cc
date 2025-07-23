
/*

Sacred Fist/Forest Master
//1, 2, 3, 5, 6, 7, 9, and 10

if x < 4
 return x;
else
if x < 8
 return x - 1;
else
 return x - 2;

***

Swift
//2, 3, 5, 6, 8, and 9

if x < 4
 return x - 1;
else
if x < 7
 return x - 2;
else
if x < 10
 return x - 3;
else 
 return x - 4;

***

Hosp
//2, 3, 4, 6, 7, 8, and 10

if x < 5
 return x - 1;
else
if x < 9
 return x - 2;
else
 return x - 3;

***

Skip First
// 2..10

return x - 1;

***

Odd
//1, 3, 5, 7, 9

return (x + 1) / 2;

***

Even
//2, 4, 6, 8, 10

return x/2;

***

Full
//1..10

return x;

***

None
//N/A

return 0;

*/

#include "cmi_includes"

int GetPrestigeAdvancementClass(int iClass, object oTarget)
{
	int nAdvancedClass;
	if (iClass == CLASS_BLACK_FLAME_ZEALOT)
	{
		if (GetHasFeat(FEAT_BFZ_SPELLCASTING_CLERIC, oTarget))
			return CLASS_TYPE_CLERIC;
		if (GetHasFeat(FEAT_BFZ_SPELLCASTING_DRUID, oTarget))
			return CLASS_TYPE_DRUID;
		if (GetHasFeat(FEAT_BFZ_SPELLCASTING_FAVORED_SOUL, oTarget))
			return CLASS_TYPE_FAVORED_SOUL;
		if (GetHasFeat(FEAT_BFZ_SPELLCASTING_SPIRIT_SHAMAN, oTarget))
			return CLASS_TYPE_SPIRIT_SHAMAN;
		if (GetHasFeat(FEAT_BFZ_SPELLCASTING_PALADIN, oTarget))
			return CLASS_TYPE_PALADIN;
		if (GetHasFeat(FEAT_BFZ_SPELLCASTING_RANGER, oTarget))
			return CLASS_TYPE_RANGER;															
	}
	if (iClass == CLASS_BLADESINGER)
	{
		if (GetHasFeat(FEAT_BLADESINGER_SPELLCASTING_BARD, oTarget))
			return CLASS_TYPE_BARD;
		if (GetHasFeat(FEAT_BLADESINGER_SPELLCASTING_SORCERER, oTarget))
			return CLASS_TYPE_SORCERER;
		if (GetHasFeat(FEAT_BLADESINGER_SPELLCASTING_WIZARD, oTarget))
			return CLASS_TYPE_WIZARD;														
	}
	
	return -1;
}

int GetPrestigeCasterLevelByClassLevel2(int nClass, int nClassLevel, object oTarget)
{
	
	if (nClass == CLASS_BLACK_FLAME_ZEALOT)
		return nClassLevel / 2;
		
	if (nClass == CLASS_FOREST_MASTER || nClass == CLASS_TYPE_SACREDFIST )
	{
		//1, 2, 3, 5, 6, 7, 9, and 10
		if (nClassLevel < 4)
			return nClassLevel;
		else
		if (nClassLevel < 8)
			return nClassLevel - 1;
		else
			return nClassLevel - 2;	
	}
	
	if (nClass == CLASS_SWIFTBLADE)
	{
		//2, 3, 5, 6, 8, and 9
		if (nClassLevel < 4)
			return nClassLevel - 1;
		else
		if (nClassLevel < 7)
			return nClassLevel - 2;
		else
		if (nClassLevel < 10)
			return nClassLevel - 3;
		else 
			return nClassLevel - 4;	
	}
	
	if (nClass == CLASS_HOSPITALER)
	{
		//2, 3, 4, 6, 7, 8, and 10	
		if (nClassLevel < 5)
			return nClassLevel - 1;
		else
		if (nClassLevel < 9)
			return nClassLevel - 2;
		else
			return nClassLevel - 3;	
	}
	
	
	return 0;
}

void main()	
{
	int iPosition;
	int iPosition2;
	
	object oTarget = OBJECT_SELF;
	int iClassLevel;
	int iClass;

	int iWizard; //Int		
	int iSorcerer; //Cha
	int iFavoredSoul; //Cha
	int iCleric; //Wis	
	int iSpiritShaman; //Wis
	int iDruid; //Wis
	int iBard; //Cha
	int iPaladin; //Wis
	int iRanger; //Wis
	int iWarlock; //Cha
	int iAssassin; //Int
	int iBlackguard; //Wis
	
	int iTempClass;
	
	for(iPosition = 0; iPosition < 4; iPosition++)
	{
		iClassLevel = GetLevelByPosition(iPosition, oTarget);
		if (iClassLevel > 0)
		{
			iClass = GetClassByPosition(iPosition, oTarget);		

			if (iClass == CLASS_TYPE_WIZARD)
			{
				iWizard += iClassLevel;
			}
			else
			if (iClass == CLASS_TYPE_SORCERER)
			{
				iSorcerer += iClassLevel;
			}
			else
			if (iClass == CLASS_TYPE_FAVORED_SOUL)
			{
				iFavoredSoul += iClassLevel;
			}
			else
			if (iClass == CLASS_TYPE_CLERIC)
			{
				iCleric += iClassLevel;
			}
			else
			if (iClass == CLASS_TYPE_SPIRIT_SHAMAN)
			{
				iSpiritShaman += iClassLevel;
			}
			else
			if (iClass == CLASS_TYPE_DRUID)
			{
				iDruid += iClassLevel;
			}
			else
			if (iClass == CLASS_TYPE_BARD)
			{
				iBard += iClassLevel;
			}	
			else
			if (iClass == CLASS_TYPE_PALADIN)
			{
				iPaladin += iClassLevel;
			}	
			else
			if (iClass == CLASS_TYPE_RANGER)
			{
				iRanger += iClassLevel;
			}	
			else
			if (iClass == CLASS_TYPE_WARLOCK)
			{
				iWarlock += iClassLevel;
			}			
			else
			if (iClass == CLASS_TYPE_ASSASSIN)
			{
				iAssassin += iClassLevel;
			}	
			else
			if (iClass == CLASS_TYPE_BLACKGUARD)
			{
				iBlackguard += iClassLevel;
			}	
			
			
			// Intermission															
					
			if (iClass == CLASS_AVENGER)
			{
				iAssassin += iClassLevel;	
			}
			else
			if (iClass == CLASS_BLACK_FLAME_ZEALOT)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else							
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else							
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}								
			}
			else
			if (iClass == CLASS_BLADESINGER)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_WIZARD)
				{
					iWizard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SORCERER)
				{
					iSorcerer += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}			
				else
				if (iTempClass == CLASS_TYPE_BARD)
				{
					iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}													
			}	
			else
			if (iClass == CLASS_CANAITH_LYRIST)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_WIZARD)
				{
					iWizard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SORCERER)
				{
					iSorcerer += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_BARD)
				{
					iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}												
			}							
			else			
			if (iClass == CLASS_CHAMP_SILVER_FLAME)
			{
				iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
			}							
			else
			if (iClass == CLASS_DRAGONSLAYER)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_WIZARD)
				{
					iWizard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SORCERER)
				{
					iSorcerer += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_BARD)
				{
					iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_WARLOCK)
				{
					iWarlock += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_ASSASSIN)
				{
					iAssassin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_BLACKGUARD)
				{
					iBlackguard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}																				
			}							
			else
			if (iClass == CLASS_FOREST_MASTER)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}													
			}							
			else		
			if (iClass == CLASS_FROST_MAGE)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_WIZARD)
				{
					iWizard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SORCERER)
				{
					iSorcerer += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_BARD)
				{
					iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}													
			}							
			else
			if (iClass == CLASS_HEARTWARDER)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_WIZARD)
				{
					iWizard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SORCERER)
				{
					iSorcerer += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_BARD)
				{
					iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_WARLOCK)
				{
					iWarlock += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}												
			}							
			else			
			if (iClass == CLASS_HOSPITALER)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}													
			}							
			else			
			if (iClass == CLASS_KNIGHT_TIERDRIAL)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_WIZARD)
				{
					iWizard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SORCERER)
				{
					iSorcerer += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_BARD)
				{
					iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_WARLOCK)
				{
					iWarlock += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_ASSASSIN)
				{
					iAssassin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_BLACKGUARD)
				{
					iBlackguard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}															
			}							
			else
			if (iClass == CLASS_LION_TALISID)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}													
			}							
			else			
			if (iClass == CLASS_LYRIC_THAUMATURGE)
			{
				iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);										
			}							
			else			
			if (iClass == CLASS_MASTER_RADIANCE)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}											
			}							
			else
			if (iClass == CLASS_NATURES_WARRIOR)
			{
				iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);																	
			}							
			else
			if (iClass == CLASS_SHADOWBANE_STALKER)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}												
			}							
			else
			if (iClass == CLASS_SHINING_BLADE)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}										
			}							
			else
			if (iClass == CLASS_STORMSINGER)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_WIZARD)
				{
					iWizard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SORCERER)
				{
					iSorcerer += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_BARD)
				{
					iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_WARLOCK)
				{
					iWarlock += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}												
			}							
			else
			if (iClass == CLASS_SWIFTBLADE)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_WIZARD)
				{
					iWizard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SORCERER)
				{
					iSorcerer += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_BARD)
				{
					iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}												
			}	
			
			
			
			// Intermission
			
			
									
			else									
			if (iClass == CLASS_TYPE_ARCANE_SCHOLAR)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_WIZARD)
				{
					iWizard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SORCERER)
				{
					iSorcerer += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_BARD)
				{
					iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
			}							
			else
			if (iClass == CLASS_TYPE_ARCANETRICKSTER)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_WIZARD)
				{
					iWizard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SORCERER)
				{
					iSorcerer += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_BARD)
				{
					iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
			}							
			else			
			if (iClass == CLASS_TYPE_DOOMGUIDE)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
			}							
			else
			if (iClass == CLASS_TYPE_ELDRITCH_KNIGHT)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_WIZARD)
				{
					iWizard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SORCERER)
				{
					iSorcerer += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_BARD)
				{
					iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}								
			}							
			else			
			if (iClass == CLASS_TYPE_HARPER)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_WIZARD)
				{
					iWizard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SORCERER)
				{
					iSorcerer += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_BARD)
				{
					iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_WARLOCK)
				{
					iWarlock += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}												
			}							
			else
			if (iClass == CLASS_TYPE_HELLFIRE_WARLOCK)
			{
				iWarlock += iClassLevel;
			}
			else
			if (iClass == CLASS_TYPE_PALEMASTER)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_WIZARD)
				{
					iWizard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SORCERER)
				{
					iSorcerer += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_BARD)
				{
					iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}												
			}	
			else
			if (iClass == CLASS_TYPE_RED_WIZARD)
			{
				iWizard += iClass;
			}			
			if (iClass == CLASS_TYPE_SACREDFIST)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
			}
			else				
			if (iClass == CLASS_TYPE_STORMLORD)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
			}
			else			
			if (iClass == CLASS_TYPE_WARPRIEST)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
			}
			
			
			
			/*
			else																										
			if (iClass == 00000)
			{
				iTempClass = GetPrestigeAdvancementClass(iClass, oTarget);
				if (iTempClass == CLASS_TYPE_WIZARD)
				{
					iWizard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SORCERER)
				{
					iSorcerer += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_CLERIC)
				{
					iCleric += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_DRUID)
				{
					iDruid += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}				
				else
				if (iTempClass == CLASS_TYPE_BARD)
				{
					iBard += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_PALADIN)
				{
					iPaladin += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_RANGER)
				{
					iRanger += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}						
				else											
				if (iTempClass == CLASS_TYPE_FAVORED_SOUL)
				{
					iFavoredSoul += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}
				else
				if (iTempClass == CLASS_TYPE_SPIRIT_SHAMAN)
				{
					iSpiritShaman += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}	
				else
				if (iTempClass == CLASS_TYPE_WARLOCK)
				{
					iWarlock += GetPrestigeCasterLevelByClassLevel(iClass, iClassLevel, oTarget);
				}												
			}							
			*/
			

		}
	}
}
//::///////////////////////////////////////////////
//:: cmi_player_levelup
//:: Purpose: To Fix characters as they are loaded by a module
//:: Created By: Kaedrin (Matt)
//:: Created On: October 18, 2007
//:://////////////////////////////////////////////

#include "cmi_ginc_chars"

#include "nwn2_inc_spells"
#include "ginc_2da"

void main()	
{
	object oPC = OBJECT_SELF;
	
	int nHexblade = GetLevelByClass(CLASS_HEXBLADE, oPC) ;
	if (nHexblade > 0)
	{
		int nHexbladeSpells = nHexblade;
		
		int nVengTaker = GetLevelByClass(CLASS_VENGTAKE, oPC);
		nHexblade += nVengTaker;
		nHexbladeSpells += nVengTaker;
				
		int nBlackGuard = GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC);	
		if (GetHasFeat(FEAT_BG_ARCANE_SERVANT_DARKNESS,oPC))
		{
			nHexblade += nBlackGuard;
			if (GetHasFeat(FEAT_HEXBLADE_PRACTICED_CASTER,oPC))
				nHexbladeSpells += nBlackGuard;
		}
		else
			nBlackGuard = 0;

		if ( (nBlackGuard > 0) || (nVengTaker > 0) )
		{
			StackHexbladeCurse();
		}
		else
		{
			if (GetHasFeat(FEAT_HEXBLADE_EXTRA_CURSE_I, oPC))
				StackHexbladeCurse();			
		}
				
		if (nHexblade > 11)
		{
			if (GetHasFeat(FEAT_HEXBLADE_EXTRA_AURA, oPC))
				StackHexbladeAura();
		}
		
		if (nHexbladeSpells > 3)
			StackHexbladeSpells(nHexbladeSpells);
					
	}
	
	/*
	int nTemplar = GetLevelByClass(CLASS_TEMPLAR, oPC) ;
	if (nTemplar > 0)
	{
		string sDeity = GetDeity(OBJECT_SELF);
		int nIndex = FindSubString(sDeity, " ");
		string sDeity2;
		if (nIndex != -1)
		{
			sDeity2 = GetSubString(sDeity, 0, nIndex);
		}
		else
			sDeity2 = sDeity;
		int nDeity = Search2DA("nwn2_deities", "FirstName", sDeity2);
		
		int nWpnProf = StringToInt(Get2DAString("nwn2_deities", "FavoredWeaponProficiency", nDeity));
		if (!GetHasFeat(nWpnProf))
		{
			FeatAdd(OBJECT_SELF, nWpnProf, FALSE, TRUE, TRUE);
		}	
	
	
	}
	*/
	
	if (GetLevelByClass(CLASS_TYPE_FAVORED_SOUL) > 0)
	{
		string sDeity = GetDeity(OBJECT_SELF);
		//SendMessageToPC(oPC, "sDeity: " + sDeity);
		int nIndex = FindSubString(sDeity, " ");
		//SendMessageToPC(oPC, "nIndex: " + IntToString(nIndex));		
		string sDeity2;
		if (nIndex != -1)
		{
			sDeity2 = GetSubString(sDeity, 0, nIndex);
			//SendMessageToPC(oPC, "sDeity2: " + sDeity2);		
		}
		else
			sDeity2 = sDeity;
		int nDeity = Search2DA("nwn2_deities", "FirstName", sDeity2);
		//SendMessageToPC(oPC, "nDeity: " + IntToString(nDeity));
		int nWpnProf = StringToInt(Get2DAString("nwn2_deities", "FavoredWeaponProficiency", nDeity));
		//SendMessageToPC(oPC, "nWpnProf: " + IntToString(nWpnProf));
		if (!GetHasFeat(nWpnProf))
		{
			FeatAdd(OBJECT_SELF, nWpnProf, FALSE, TRUE, TRUE);
		}
	}

	int nNinja = GetLevelByClass(CLASS_NINJA, oPC);
	if (nNinja > 0) //Stack Ki Power Uses
	{
		int nBonus;
		if (GetHasFeat(FEAT_ASCETIC_STALKER, oPC))
			nBonus += GetLevelByClass(CLASS_TYPE_MONK, oPC);
		if (GetHasFeat(FEAT_MARTIAL_STALKER, oPC))
		{
			nBonus += GetLevelByClass(CLASS_TYPE_FIGHTER, oPC);
			nBonus += GetLevelByClass(CLASS_THUG, oPC);
		}
		if (GetHasFeat(FEAT_EXPANDED_KI_POOL, oPC))
			nBonus += 3;		
		
		if (nBonus > 0)
		{
			int nCount = 0;
			int nStart = 3616 + nNinja + 1;
			for (nCount = nStart; nCount < (nStart + nBonus); nCount++)
			{
				if (nCount <= 3646)
				{
					FeatAdd(oPC, nCount, FALSE, FALSE, FALSE);
				}
				else
				{
					FeatAdd(oPC, nCount + 42, FALSE, FALSE, FALSE);
					//3647
					//3689-91
				}
			}
		}	
	}
	
	/*
	if (GetLocalInt(GetModule(), "FreeEmberGuard") == 1)	
	{
		if (GetHasFeat(FEAT_ELEMENTAL_SHAPE, oPC) && !GetHasFeat(FEAT_ELEMSHAPE_EMBERGUARD))
		{
			if (GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 24)
				FeatAdd(oPC, FEAT_ELEMSHAPE_EMBERGUARD, FALSE, TRUE, TRUE);
		}
	}
	*/

	//SetLocalString(oPC, "cmi_animcomp", "");
	DeleteLocalString(oPC, "cmi_animcomp");
	
	if (GetLocalInt(GetModule(), "TempestStackWithRanger") == 1)
	{
		int nRanger = GetLevelByClass(CLASS_TYPE_RANGER, OBJECT_SELF);
		int nTempest = GetLevelByClass(CLASS_TEMPEST, OBJECT_SELF);
		
		if (nTempest > 0 && nRanger < 21)
		{
			int nTotal = nRanger + nTempest;
			if (nTotal > 20)
			{
				if (!GetHasFeat(1972))
					FeatAdd(OBJECT_SELF, 1972, FALSE, TRUE, TRUE);
			}
			else
			if (nTotal > 10)
			{
				if (!GetHasFeat(20))
					FeatAdd(OBJECT_SELF, 20, FALSE, TRUE, TRUE);			
			}
			else
			if (nTotal > 5)
			{
				if (!GetHasFeat(41))
					FeatAdd(OBJECT_SELF, 41, FALSE, TRUE, TRUE);			
			}
		}
	}		

	if (GetLocalInt(GetModule(), "UseSacredFistFix") == 1)
	{
		if (GetHasFeat(2103, oPC))
		{
			FeatRemove(oPC, 2103);
			FeatAdd(oPC, FEAT_SACREDFIST_CODE_OF_CONDUCT, FALSE);	
		}
	}
	
	if (GetHasFeat(FEAT_FOREST_MASTER_FOREST_HAMMER, oPC, TRUE))
	{
		SendMessageToPC(oPC, "Forest Hammer disabled, recast to gain the benefits of your new level.");
		RemoveEffectsFromSpell(oPC, FOREST_MASTER_FOREST_HAMMER);	
	}
	
	//Barbarian
	if (GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC) > 13)
	{	
		if (!GetHasFeat(FEAT_INDOMITABLE_WILL, oPC))
			FeatAdd(oPC, FEAT_INDOMITABLE_WILL, FALSE, TRUE, TRUE);
	}				
	
	//Duelist
	if (GetLevelByClass(CLASS_TYPE_DUELIST,oPC) > 6)
	{	
		//Remove Elaborate Parry so it can be reapplied
		if (GetHasSpellEffect(-1742,oPC))
		{
			RemoveSpellEffects(-1742, oPC, oPC);					
		}
	}	
	
	if (GetHitDice(oPC) == 2)
	{
		//Character may have been reset, need to clear out any feats granted by this script
		int iFeat;
		for (iFeat = 2993; iFeat< 3052; iFeat++)
		{
			if (GetHasFeat(iFeat,oPC,TRUE))
				FeatRemove(oPC, iFeat);
		}
		DeleteLocalInt(oPC,"Bladesong");
		DeleteLocalInt(oPC,"XbowSniper");
		DeleteLocalInt(oPC,"cmi_HOSP_Spellcaster");
	}
	
	if (GetHasFeat(FEAT_DAYLIGHT_ENDURANCE, oPC))
	{
		if (!GetHasFeat(2207)) 
			FeatAdd(oPC, 2207, FALSE, FALSE, FALSE);
	}
	
	int nStackSneakNeeded=0;
	int nStackDeathNeeded=0;
	int nStackWildshapeNeeded=0;
	int nStackBardsongUsesNeeded=0;
	int nStackEldBlastNeeded=0;
	int nStackBardMusicNeeded=0;
	int nStackSwashbucklerGrace=0;
	int nStackSwashbucklerDodge=0;	
	
	// Bard
	if ((GetLevelByClass(CLASS_TYPE_BARD,oPC) > 0) && GetHasFeat(FEAT_ARTIST,oPC))
	{
		nStackBardsongUsesNeeded=1;		
	}		
	
	if (GetLevelByClass(CLASS_TYPE_PALADIN, oPC) > 0)
	{
		InfuseDivineSpirit(oPC);
	}
	
	if (GetLevelByClass(CLASS_TYPE_SPIRIT_SHAMAN, oPC) > 0)
	{
		StackSpiritShaman(oPC);
	}	
	
	if (GetLevelByClass(CLASS_TYPE_SWASHBUCKLER, oPC) > 0)
	{
		nStackSneakNeeded=1;
		nStackSwashbucklerGrace=1;
		nStackSwashbucklerDodge=1;				
	}	
	
	if (GetLevelByClass(CLASS_TYPE_WARLOCK, oPC) > 0)
	{
		//Child of Night
		if (GetLevelByClass(CLASS_CHILD_NIGHT,oPC) > 0)
		{
			if (GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_WARLOCK, oPC))
				nStackEldBlastNeeded=1;		
		}	
		
		// Hellfire Warlock
		if (GetLevelByClass(CLASS_TYPE_HELLFIRE_WARLOCK,oPC) > 0)
		{
			nStackEldBlastNeeded=1;
		}	
		
		if (GetHasFeat(FEAT_FEY_POWER, oPC) || GetHasFeat(FEAT_FIENDISH_POWER, oPC) ||  GetHasFeat(FEAT_PRACTICED_INVOKER, oPC))
			nStackEldBlastNeeded=1;
		
		// Eldritch Disciple
		if (GetLevelByClass(CLASS_ELDRITCH_DISCIPLE,oPC) > 0)
		{
			nStackEldBlastNeeded=1;
		}		
		
		// Stormsinger
		if (GetLevelByClass(CLASS_STORMSINGER,oPC) > 0)
		{
			nStackEldBlastNeeded=1;
		}				
		
		//Knight of Tierdrial
		if (GetLevelByClass(CLASS_KNIGHT_TIERDRIAL, oPC) > 0)
		{
			if (GetHasFeat(FEAT_KOT_SPELLCASTING_WARLOCK, oPC))
				nStackEldBlastNeeded=1;		
		}
		
		// Heartwarder
		if (GetLevelByClass(CLASS_HEARTWARDER,oPC) > 0)
		{
			if (GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_WARLOCK, oPC))
				nStackEldBlastNeeded=1;
		}
		
		// Dragon Slayer
		if (GetLevelByClass(CLASS_DRAGONSLAYER,oPC) > 0)
		{
			if (GetHasFeat(FEAT_DRSLR_SPELLCASTING_WARLOCK, oPC))
				nStackEldBlastNeeded=1;
		}
		
		// Daggerspell Mage
		if (GetLevelByClass(CLASS_DAGGERSPELL_MAGE,oPC) > 0)
		{
			if (GetHasFeat(FEAT_DMAGE_SPELLCASTING_WARLOCK, oPC))
				nStackEldBlastNeeded=1;
		}		
		
		if (!GetHasFeat(FEAT_IMPROVED_UNARMED_STRIKE, oPC))
			FeatAdd(oPC, FEAT_IMPROVED_UNARMED_STRIKE, TRUE, TRUE);
	}
		
	// Dark Lantern
	if (GetLevelByClass(CLASS_DARK_LANTERN,oPC) > 1)
	{
		nStackSneakNeeded=1;
	}
	
	//CLASS_STALKER_DEPTHS
	if (GetLevelByClass(CLASS_STALKER_DEPTHS,oPC) > 1)
	{
		nStackSneakNeeded=1;
	}	
	
	//CLASS_WHIRLING_DERVISH
	if (GetLevelByClass(CLASS_WHIRLING_DERVISH,oPC) >2)
	{
		nStackSneakNeeded=1;
	}		
	
	// Charnag Maelthra
	if (GetLevelByClass(CLASS_UNDERDARK_MARAUDER,oPC) > 0)
	{
		if (GetHasFeat(FEAT_CHARNAG_WAY_SHADOW, oPC))
			nStackSneakNeeded=1;
	}	
	
	// Skullclan Hunter
	if (GetLevelByClass(CLASS_SKULLCLAN_HUNTER,oPC) > 2)
	{
		nStackSneakNeeded=1;
	}
			
	//Stormsinger	
	if (GetLevelByClass(CLASS_STORMSINGER,oPC) > 0)
	{
		nStackBardsongUsesNeeded = 1;		
	}	
	
	//Canaith Lyrist	
	if (GetLevelByClass(CLASS_CANAITH_LYRIST,oPC) > 0)
	{
		nStackBardsongUsesNeeded = 1;
		nStackBardMusicNeeded = 1;		
	}	
	
	if (GetLevelByClass(CLASS_DISSONANT_CHORD,oPC) > 0)
	{
		nStackBardsongUsesNeeded = 1;	
	}
	if (GetLevelByClass(CLASS_LYRIC_THAUMATURGE,oPC) > 0)
	{
		nStackBardsongUsesNeeded = 1;	
	}			
	
	//Lion of Talisid	
	if (GetLevelByClass(CLASS_LION_TALISID,oPC) > 2)
	{
		nStackWildshapeNeeded = 1;		
	}
	
	// Nature's Warrior	
	if (GetLevelByClass(CLASS_NATURES_WARRIOR,oPC) > 0)
	{
		nStackWildshapeNeeded = 1;		
	}	
	// CLASS_DAGGERSPELL_SHAPER
	if (GetLevelByClass(CLASS_DAGGERSPELL_SHAPER,oPC) > 0)
	{
		nStackWildshapeNeeded=1;
	}	
	
	if (GetHasFeat(FEAT_REAL_EXTRA_WILD_SHAPE, oPC, TRUE))
	{
		nStackWildshapeNeeded=1;	
	}
	if (GetHasFeat(FEAT_EXTRA_WILD_SHAPE, oPC, TRUE))
	{
		nStackWildshapeNeeded=1;	
	}	
			
	// Stack Wildshape if needed
	if (nStackWildshapeNeeded == 1)
		StackWildshapeUses(oPC);
		
	if (nStackEldBlastNeeded == 1)
		StackEldBlast(oPC);
				
	
	// Dread Commando
	if (GetLevelByClass(CLASS_DREAD_COMMANDO,oPC) > 0)
	{
		nStackSneakNeeded=1;
	}
		
	// Nightsong Enforcer
	if (GetLevelByClass(CLASS_NIGHTSONG_ENFORCER,oPC) > 0)
	{
		nStackSneakNeeded=1;
	}
	
	// Nightsong Infiltrator
	if (GetLevelByClass(CLASS_NIGHTSONG_INFILTRATOR,oPC) > 3)
	{
		nStackSneakNeeded=1;
	}
	
	// Rogue
	if (GetLevelByClass(CLASS_TYPE_ROGUE,oPC) > 0)
	{
		nStackSneakNeeded=1;
		nStackSwashbucklerDodge = 1;
		
		if (GetLevelByClass(CLASS_TYPE_ROGUE,oPC) > 12)
		{
			if (GetHasFeat(FEAT_EPITHET_HIPS_DONTLIE, oPC))
				FeatAdd(oPC, 433, FALSE, TRUE, TRUE);
		}
	}
	
	// CLASS_NINJA
	if (GetLevelByClass(CLASS_NINJA,oPC) > 0)
	{
		nStackSneakNeeded=1;
		nStackSwashbucklerDodge = 1;	
	}
	// CLASS_GHOST_FACED_KILLER
	if (GetLevelByClass(CLASS_GHOST_FACED_KILLER,oPC) > 1)
	{
		nStackSneakNeeded=1;
	}
	// CLASS_DAGGERSPELL_MAGE
	if (GetLevelByClass(CLASS_DAGGERSPELL_MAGE,oPC) > 2)
	{
		nStackSneakNeeded=1;
	}
	// CLASS_DAGGERSPELL_SHAPER
	if (GetLevelByClass(CLASS_DAGGERSPELL_SHAPER,oPC) > 2)
	{
		nStackSneakNeeded=1;
	}
	// CLASS_SCOUT
	if (GetLevelByClass(CLASS_SCOUT,oPC) > 0)
	{
		nStackSneakNeeded=1;
		nStackSwashbucklerDodge=1;
	}
	// CLASS_WILD_STALKER
	if (GetLevelByClass(CLASS_WILD_STALKER,oPC) > 1)
	{
		nStackSneakNeeded=1;
		nStackSwashbucklerDodge = 1;		
	}						
	
	// CLASS_SHADOWDANCER
	if (GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC) > 3)
	{
		if (GetHasFeat(FEAT_BLADE_OF_SHADOW, oPC))
			nStackSneakNeeded=1;
	}		

	// Stack Sneak Attack Dice if needed
	if (nStackSneakNeeded == 1)
		StackSneakAttack(oPC);					
		
	// Blackguard
	if (GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) > 0)
	{
		AddBGFeats(oPC);
		if (!(GetLocalInt(oPC, "BlackGuardCleaned") == 1))
			CleanBlackGuard(oPC);		
		
	}		
	
	// Assassin
	if (GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC) > 0)
	{
		AddASNFeats(oPC);
		nStackDeathNeeded=1;
		if (!(GetLocalInt(oPC, "AssassinCleaned") == 1))
			CleanAssassin(oPC);			
	}
	
	// Avenger
	if (GetLevelByClass(CLASS_AVENGER,oPC) > 0)
	{
		AddASNFeats(oPC);
		nStackDeathNeeded=1;		
	}	
	
	// Black Flame Zealot
	if (GetLevelByClass(CLASS_BLACK_FLAME_ZEALOT,oPC) > 2)
	{
		nStackDeathNeeded=1;		
	}
	
	// Stack Death Attack Dice if needed
	if (nStackDeathNeeded == 1)
		StackDeathAttack(oPC);	
		
	if (nStackBardsongUsesNeeded)	
		StackBardicUses(oPC);
		
	if (nStackBardMusicNeeded)	
		StackBardMusicUses(oPC);
		
	//if (nStackSwashbucklerGrace)
	//	StackSwashbucklerGrace(oPC);
		
	//if (nStackSwashbucklerDodge)		
	//	StackSwashbucklerDodge(oPC);				
	
		/*
	// Hospitaler
	//SendMessageToPC(GetFirstPC(),"Outside Loop");
	if (GetLevelByClass(CLASS_HOSPITALER,oPC)== 1)
	{
		//SendMessageToPC(GetFirstPC(),"Inside Loop");
		if (!GetLocalInt(oPC,"cmi_HOSP_Spellcaster"))
		{	
			//SendMessageToPC(GetFirstPC(),"No localvar yet");
			int iHasCasterFeat = 0;
			if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_SPIRIT_SHAMAN,oPC))
				iHasCasterFeat = 1;
			else
			if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_CLERIC,oPC))
				iHasCasterFeat = 1;
			else				
			if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_DRUID,oPC))
				iHasCasterFeat = 1;
			else
			if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_PALADIN,oPC))
				iHasCasterFeat = 1;
			else
			if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_RANGER,oPC))
				iHasCasterFeat = 1;
			else
			if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_FAVORED_SOUL,oPC))
				iHasCasterFeat = 1;
																							
			if (iHasCasterFeat == 0)
			{
				//SendMessageToPC(GetFirstPC(),"No caster feat");
				BeginConversation("c_Hosp_Levelup",OBJECT_SELF);
				SetLocalInt(oPC,"cmi_HOSP_Spellcaster",1);																			
			}		
		}
	} // End Hospitaler	
	*/
	
	// Hospitaler
	//SendMessageToPC(oPC, "Test");
	if (GetLevelByClass(CLASS_HOSPITALER,oPC) > 0)
	{
		//SendMessageToPC(GetFirstPC(TRUE), GetName(oPC) + " :x: " + GetName(GetFirstPC(TRUE)));	
		if (GetLocalInt(oPC,"cmi_HOSP_Spellcaster") != 2)
		{			
			int iHasCasterFeat = 0;
			if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_SPIRIT_SHAMAN,oPC))
			{
				iHasCasterFeat = 1;
			}
			else if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_CLERIC,oPC))
			{
				iHasCasterFeat = 1;
			}
			else if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_DRUID,oPC))
			{
				iHasCasterFeat = 1;
			}
			else if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_PALADIN,oPC))
			{
				iHasCasterFeat = 1;
			}
			else if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_RANGER,oPC))
			{
				iHasCasterFeat = 1;
			}
			else if (GetHasFeat(FEAT_HOSPITALER_SPELLCASTING_FAVORED_SOUL,oPC))
			{
				iHasCasterFeat = 1;
			}
							
			int nValidClasses = 0;																			
			if (iHasCasterFeat == 0)
			{
				int nFeatToAdd;
				string sClassText;
				if ( GetLevelByClass( CLASS_TYPE_CLERIC, oPC ) > 0 )
				{
					nValidClasses++;
					nFeatToAdd = FEAT_HOSPITALER_SPELLCASTING_CLERIC;
					sClassText = "Cleric spellcasting progression granted.";
				}
				
				if ( GetLevelByClass( CLASS_TYPE_DRUID, oPC ) > 0 )
				{
					nValidClasses++;
					nFeatToAdd = FEAT_HOSPITALER_SPELLCASTING_DRUID;
					sClassText = "Druid spellcasting progression granted.";					
				}
				
				if ( GetLevelByClass( CLASS_TYPE_FAVORED_SOUL, oPC ) > 0 )
				{
					nValidClasses++;
					nFeatToAdd = FEAT_HOSPITALER_SPELLCASTING_FAVORED_SOUL;
					sClassText = "Favored Soul spellcasting progression granted.";					
				}
				
				if ( GetLevelByClass( CLASS_TYPE_PALADIN, oPC ) > 0 )
				{
					SendMessageToPC(oPC, "Paladin");				
					nValidClasses++;
					nFeatToAdd = FEAT_HOSPITALER_SPELLCASTING_PALADIN;
					sClassText = "Paladin spellcasting progression granted.";					
					//SendMessageToPC(oPC, "nValidClasses: " + IntToString(nValidClasses));					
				}
				
				if ( GetLevelByClass( CLASS_TYPE_RANGER, oPC ) > 0 )
				{
					nValidClasses++;
					nFeatToAdd = FEAT_HOSPITALER_SPELLCASTING_RANGER;
					sClassText = "Ranger spellcasting progression granted.";					
				}
				
				if ( GetLevelByClass( CLASS_TYPE_SPIRIT_SHAMAN, oPC ) > 0 )
				{
					nValidClasses++;
					nFeatToAdd = FEAT_HOSPITALER_SPELLCASTING_SPIRIT_SHAMAN;
					sClassText = "Spirit Shaman spellcasting progression granted.";					
				}
				//SendMessageToPC(oPC, "nValidClasses: " + IntToString(nValidClasses));
				if ( nValidClasses == 1 )
				{
					// just add it
					FeatAdd(oPC,nFeatToAdd,FALSE);
					SendMessageToPC(oPC, sClassText);
					SetLocalInt(oPC,"cmi_HOSP_Spellcaster",2);
				}
				else if ( nValidClasses > 1 )
				{
					// dialog to pick it now...
					//SendMessageToPC(oPC, "num: " + IntToString(nValidClasses));
					SendMessageToPC(oPC, "No caster feat, launching a dialog for you to choose.");
					BeginConversation("c_hosp_levelup", oPC );
					SetLocalInt(oPC,"cmi_HOSP_Spellcaster",2);
				}																		
			}		
		}
	} // End Hospitaler		

}
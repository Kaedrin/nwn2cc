//::///////////////////////////////////////////////
//:: Sneak Attack Include Script
//:: cmi_inc_sneakattack
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 1, 2008
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"
#include "cmi_ginc_chars"

int GetSneakLevels (object oTarget)
{
	int nClassLevel = 0;
	int nSneakLevels = 0;
	
	// Stock classes
		
	nClassLevel = GetLevelByClass(CLASS_TYPE_INVISIBLE_BLADE, oTarget);	
	if (nClassLevel > 1)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}
		
	nClassLevel = GetLevelByClass(CLASS_TYPE_ARCANETRICKSTER, oTarget);	
	if (nClassLevel > 1)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}
		
	nClassLevel = GetLevelByClass(CLASS_TYPE_ASSASSIN, oTarget);
	if (nClassLevel > 0)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}

	nClassLevel = GetLevelByClass(CLASS_TYPE_BLACKGUARD, oTarget);	
	if (nClassLevel > 3)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}

	if (GetLevelByClass(CLASS_NWNINE_WARDER, oTarget) > 2)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}		
			
	nClassLevel = GetLevelByClass(CLASS_TYPE_ROGUE, oTarget);
	if (nClassLevel > 0)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	
	nClassLevel = GetLevelByClass(CLASS_TYPE_SHADOWTHIEFOFAMN, oTarget);
	if (nClassLevel > 0)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	
	// Begin my classes
	
	nClassLevel = GetLevelByClass(CLASS_SHADOWBANE_STALKER, oTarget);
	if (nClassLevel > 2)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}		
	
	nClassLevel = GetLevelByClass(CLASS_SKULLCLAN_HUNTER, oTarget);
	if (nClassLevel > 2)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}		
	
	nClassLevel = GetLevelByClass(CLASS_WHIRLING_DERVISH, oTarget);
	if (nClassLevel > 2)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}	
		
	nClassLevel = GetLevelByClass(CLASS_DARK_LANTERN, oTarget);
	if (nClassLevel > 0)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}		
	
	nClassLevel = GetLevelByClass(CLASS_DREAD_COMMANDO, oTarget);
	if (nClassLevel > 0)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}
		
	nClassLevel = GetLevelByClass(CLASS_THUG, oTarget);
	if (nClassLevel > 0)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	
	nClassLevel = GetLevelByClass(CLASS_AVENGER, oTarget);
	if (nClassLevel > 0)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}
		
	nClassLevel = GetLevelByClass(CLASS_BLACK_FLAME_ZEALOT, oTarget);
	if (nClassLevel > 2)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}	
	
	nClassLevel = GetLevelByClass(CLASS_DIVINE_SEEKER, oTarget);
	if (nClassLevel > 1)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}	
	
	nClassLevel = GetLevelByClass(CLASS_NIGHTSONG_INFILTRATOR, oTarget);
	if (nClassLevel > 3)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	
	nClassLevel = GetLevelByClass(CLASS_NIGHTSONG_ENFORCER, oTarget);
	if (nClassLevel > 0)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	
	nClassLevel = GetLevelByClass(CLASS_UNDERDARK_MARAUDER, oTarget);
	if (nClassLevel > 0)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}	
	
	//1.38
	nClassLevel = GetLevelByClass(CLASS_DAGGERSPELL_MAGE, oTarget);
	if (nClassLevel > 2)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	
	nClassLevel = GetLevelByClass(CLASS_DAGGERSPELL_SHAPER, oTarget);
	if (nClassLevel > 2)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}
		
	nClassLevel = GetLevelByClass(CLASS_NINJA, oTarget);
	if (nClassLevel > 0)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}	
	
	nClassLevel = GetLevelByClass(CLASS_SCOUT, oTarget);
	if (nClassLevel > 0)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}	
	
	nClassLevel = GetLevelByClass(CLASS_WILD_STALKER, oTarget);
	if (nClassLevel > 1)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	
	nClassLevel = GetLevelByClass(CLASS_GHOST_FACED_KILLER, oTarget);
	if (nClassLevel > 1)
	{
		nSneakLevels = nSneakLevels + nClassLevel;
	}
		
	return nSneakLevels;
	
}

int GetTotalSneakDice(object oTarget, object oSneakAttacker)
{
	int nDice = 0;
	int nClassLevel = 0;
	int nSneakLevels = 0;
	
	// Stock classes
	
	nClassLevel = GetLevelByClass(CLASS_TYPE_INVISIBLE_BLADE, oSneakAttacker);	
	if (nClassLevel > 0)
	{
		nDice = nDice + (nClassLevel + 1) / 2;
		nSneakLevels = nSneakLevels + nClassLevel;
	}	
		
	nClassLevel = GetLevelByClass(CLASS_TYPE_ARCANETRICKSTER, oSneakAttacker);	
	if (nClassLevel > 1)
	{
		nDice = nDice + nClassLevel / 2;
		nSneakLevels = nSneakLevels + nClassLevel;
	}
		
	nClassLevel = GetLevelByClass(CLASS_TYPE_ASSASSIN, oSneakAttacker);
	if (nClassLevel > 0)
	{
		nDice = nDice + (nClassLevel + 1) / 2;
		nSneakLevels = nSneakLevels + nClassLevel;
	}

	nClassLevel = GetLevelByClass(CLASS_TYPE_BLACKGUARD, oSneakAttacker);	
	if (nClassLevel > 3)
	{
		nDice = nDice + (nClassLevel - 1) / 3;
		nSneakLevels = nSneakLevels + nClassLevel;
	}

	if (GetLevelByClass(CLASS_NWNINE_WARDER, oSneakAttacker) > 2)
	{
		nDice = nDice + 2;
		nSneakLevels = nSneakLevels + nClassLevel;
	}		
			
	nClassLevel = GetLevelByClass(CLASS_TYPE_ROGUE, oSneakAttacker);
	if (nClassLevel > 0)
	{
		if (GetHasFeat(FEAT_DARING_OUTLAW , oSneakAttacker))
		{
			nClassLevel += GetLevelByClass(CLASS_TYPE_SWASHBUCKLER,oSneakAttacker);
		}		
		nDice = nDice + (nClassLevel + 1) / 2;
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	
	nClassLevel = GetLevelByClass(CLASS_TYPE_SHADOWTHIEFOFAMN, oSneakAttacker);
	if (nClassLevel > 0)
	{
		nDice = nDice + (nClassLevel + 1) / 2;
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	
	// Begin my classes	
	
	nClassLevel = GetLevelByClass(CLASS_UNDERDARK_MARAUDER, oSneakAttacker);
	if (nClassLevel > 0)
	{
		nDice = nDice + ((nClassLevel + 1)/2);
		nSneakLevels = nSneakLevels + nClassLevel;
	}	
		
	nClassLevel = GetLevelByClass(CLASS_SHADOWBANE_STALKER, oSneakAttacker);
	if (nClassLevel > 2)
	{
		nDice = nDice + nClassLevel / 3;
		nSneakLevels = nSneakLevels + nClassLevel;
	}			
	
	nClassLevel = GetLevelByClass(CLASS_SKULLCLAN_HUNTER, oSneakAttacker);
	if (nClassLevel > 2)
	{
		nDice = nDice + nClassLevel / 3;
		nSneakLevels = nSneakLevels + nClassLevel;
	}		
	
	nClassLevel = GetLevelByClass(CLASS_WHIRLING_DERVISH, oSneakAttacker);
	if (nClassLevel > 2)
	{
		nDice = nDice + nClassLevel / 3;
		nSneakLevels = nSneakLevels + nClassLevel;
	}	
		
	nClassLevel = GetLevelByClass(CLASS_DARK_LANTERN, oSneakAttacker);
	if (nClassLevel > 0)
	{
		nDice = nDice + (nClassLevel / 2 );
		nSneakLevels = nSneakLevels + nClassLevel;
	}		
	
	nClassLevel = GetLevelByClass(CLASS_DREAD_COMMANDO, oSneakAttacker);
	if (nClassLevel > 0)
	{
		nDice = nDice + (nClassLevel + 1) / 2;
		nSneakLevels = nSneakLevels + nClassLevel;
	}
		
	nClassLevel = GetLevelByClass(CLASS_THUG, oSneakAttacker);
	if (nClassLevel > 0)
	{
		nDice = nDice + (nClassLevel / 2 );
		nSneakLevels = nSneakLevels + nClassLevel;
	}	
	
	nClassLevel = GetLevelByClass(CLASS_AVENGER, oSneakAttacker);
	if (nClassLevel > 0)
	{
		nDice = nDice + (nClassLevel + 1) / 2;
		nSneakLevels = nSneakLevels + nClassLevel;
	}
		
	nClassLevel = GetLevelByClass(CLASS_BLACK_FLAME_ZEALOT, oSneakAttacker);
	if (nClassLevel > 2)
	{
		nDice = nDice + nClassLevel / 3;
		nSneakLevels = nSneakLevels + nClassLevel;
	}	
	
	nClassLevel = GetLevelByClass(CLASS_DIVINE_SEEKER, oSneakAttacker);
	if (nClassLevel > 1)
	{
		nDice = nDice + (nClassLevel + 1) / 3;
		nSneakLevels = nSneakLevels + nClassLevel;
	}	
	
	nClassLevel = GetLevelByClass(CLASS_NIGHTSONG_INFILTRATOR, oSneakAttacker);
	if (nClassLevel > 3)
	{
		nDice = nDice + nClassLevel / 4;
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	
	nClassLevel = GetLevelByClass(CLASS_NIGHTSONG_ENFORCER, oSneakAttacker);
	if (nClassLevel > 0)
	{
		nDice = nDice + (nClassLevel + 2) / 3;
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	
	//1.38
	nClassLevel = GetLevelByClass(CLASS_NINJA, oSneakAttacker);
	if (nClassLevel > 0)
	{
		nDice = nDice + (nClassLevel + 1) / 2;
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	nClassLevel = GetLevelByClass(CLASS_SCOUT, oSneakAttacker);
	if (nClassLevel > 0)
	{
		nDice = nDice + (nClassLevel + 3) / 4;
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	nClassLevel = GetLevelByClass(CLASS_DAGGERSPELL_MAGE, oSneakAttacker);
	if (nClassLevel > 0)
	{
		nDice = nDice + (nClassLevel / 3);
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	nClassLevel = GetLevelByClass(CLASS_DAGGERSPELL_SHAPER, oSneakAttacker);
	if (nClassLevel > 0)
	{
		nDice = nDice + (nClassLevel / 3);
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	nClassLevel = GetLevelByClass(CLASS_GHOST_FACED_KILLER, oSneakAttacker);
	if (nClassLevel > 0)
	{
		nDice = nDice + (nClassLevel + 1) / 3;
		nSneakLevels = nSneakLevels + nClassLevel;
	}
	nClassLevel = GetLevelByClass(CLASS_WILD_STALKER, oSneakAttacker);
	if (nClassLevel > 0)
	{
		nDice = nDice + (nClassLevel + 2) / 4;
		nSneakLevels = nSneakLevels + nClassLevel;
	}							
	
	if (GetHasFeat(FEAT_IMPROVED_UNCANNY_DODGE, oTarget, TRUE))
	{
		if ( nSneakLevels > (GetSneakLevels(oTarget) + 3) ) // Need to be >= Target Dice + 4
		{
			return nDice;
		}
		else
			return 0;
	}		

	
	return nDice;
}



int IsTargetConcealed(object oTarget, object oSneakAttacker)
{
     int bIsConcealed = FALSE;

     int bAttackerHasTrueSight = GetHasEffect(EFFECT_TYPE_TRUESEEING, oSneakAttacker);
     int bAttackerCanSeeInvisble = GetHasEffect(EFFECT_TYPE_SEEINVISIBLE, oSneakAttacker);
     int bAttackerUltraVision = GetHasEffect(EFFECT_TYPE_ULTRAVISION, oSneakAttacker);

     if(GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_50, oTarget) )
	 	bIsConcealed = TRUE;
     else if(GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_40, oTarget) )     
	 	bIsConcealed = TRUE;
     else if(GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_30, oTarget) )     
	 	bIsConcealed = TRUE;
     else if(GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_20, oTarget) )     
	 	bIsConcealed = TRUE;
     else if(GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_10, oTarget) )     
	 	bIsConcealed = TRUE;
     else if(GetStealthMode(oTarget) == STEALTH_MODE_ACTIVATED && !GetObjectSeen(oTarget, oSneakAttacker) )  
	 	bIsConcealed = TRUE;
     else if(GetHasEffect(EFFECT_TYPE_SANCTUARY, oTarget) && !bAttackerHasTrueSight )
          bIsConcealed = TRUE;
     else if(GetHasEffect(EFFECT_TYPE_INVISIBILITY, oTarget) && !bAttackerHasTrueSight && !bAttackerCanSeeInvisble )
          bIsConcealed = TRUE;
     else if(GetHasEffect(EFFECT_TYPE_DARKNESS, oTarget) && !bAttackerHasTrueSight && !bAttackerUltraVision)
          bIsConcealed = TRUE;
     else if(GetHasFeatEffect(FEAT_EMPTY_BODY, oTarget) )
          bIsConcealed = TRUE;
     else if(GetHasEffect(EFFECT_TYPE_ETHEREAL, oTarget) && !bAttackerHasTrueSight && !bAttackerCanSeeInvisble  )
          bIsConcealed = TRUE;
     else if(GetHasEffect(EFFECT_TYPE_CONCEALMENT, oTarget) && !bAttackerHasTrueSight)
          bIsConcealed = TRUE;

     return bIsConcealed;
}

// Sneak Attack can't be used against targets with concealment
int IsTargetValidForSneakAttack(object oTarget, object oSneakAttacker)
{
	int nEpicPrecision = FALSE;
	object oAttackedByTarget = GetAttackTarget(oTarget);

	//Don't bother if the target is out of range
	if (GetDistanceBetween(oSneakAttacker, oTarget) < FeetToMeters(30.0f))
	{
		//Don't bother if the target is immune
		if (GetIsImmune(oTarget, IMMUNITY_TYPE_SNEAK_ATTACK, oSneakAttacker) || GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT, oSneakAttacker))
		{ 
			if (GetHasFeat(2128, oSneakAttacker))
				nEpicPrecision = TRUE;
			else
				return FALSE;
		}
		//Don't bother if the target is concealed
		if (IsTargetConcealed(oTarget, oSneakAttacker))
		{
			return FALSE;
		}

		if (oAttackedByTarget == oSneakAttacker) //Head to Head requires the target be unable to defend themself
		{
			//Should I add Daze?  Need to test being dazed near a creature with sneak 
			//to see how the official sneak attack is handled.
			//Need to add any future spells that knockdown here
    		if (
			GetHasEffect( EFFECT_TYPE_STUNNED, oTarget)
   		 	|| GetHasEffect( EFFECT_TYPE_BLINDNESS, oTarget)
   		 	|| GetHasEffect( EFFECT_TYPE_PARALYZE, oTarget)
   		 	|| GetHasEffect( EFFECT_TYPE_SLEEP, oTarget)
   		 	|| GetHasEffect( EFFECT_TYPE_PETRIFY, oTarget)
   		 	|| GetHasEffect( EFFECT_TYPE_CUTSCENE_PARALYZE, oTarget)
   		// 	|| GetHasFeatEffect( FEAT_IMPROVED_KNOCKDOWN, oTarget)			
   		// 	|| GetHasFeatEffect( FEAT_KNOCKDOWN, oTarget)
		//	|| GetHasSpellEffect( SPELL_SPELLABILITY_Clap_Thunder, oTarget) // Clap of Thunder does a knockdown
			)
			{
				if (nEpicPrecision)
					return 2;
				else
					return TRUE;
  		  	}
			else
			{	
				// Need code here for invisible caster and target seeing invisble
				return FALSE;
			}
		}
		else
		{
			if (nEpicPrecision)
				return 2;
			else
				return TRUE;  // Should check if flanking but this is good for now.
		}
			
	} // end distance check
	return FALSE;
} 

int EvaluateSneakAttack(object oTarget, object oSneakAttacker)
{
	
	int nSneakAttackSpells = GetLocalInt(GetModule(), "SneakAttackSpells");
	
	if (!nSneakAttackSpells)
		return 0;
		
	int nIsTargetValidForSneakAttack = IsTargetValidForSneakAttack(oTarget, oSneakAttacker);
	if (nIsTargetValidForSneakAttack)
	{
		int nDice = GetTotalSneakDice(oTarget, oSneakAttacker);
		
		if (nDice > 0)
		{
			if (nIsTargetValidForSneakAttack == 2)
				nDice = nDice / 2;
			FloatingTextStringOnCreature("Sneak Attack!", oSneakAttacker);
			SendMessageToPC(oSneakAttacker, "Sneak Attack!");
			return d6(nDice);	
		}
		else
			return 0;
	}		
	return 0;

}